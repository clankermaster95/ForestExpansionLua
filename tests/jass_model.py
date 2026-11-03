"""Independent evaluator for the JASS AST. Engine calls use a deterministic test double."""
import json,math,struct,re
from dataclasses import dataclass,field
def f32(v):
    try:return struct.unpack('<f',struct.pack('<f',v))[0]
    except OverflowError:return math.copysign(math.inf,v)
def i32(v):return (int(v)+2**31)%2**32-2**31
def default(t):return {'integer':0,'real':0.0,'boolean':False}.get(t)
class Code(str):pass
@dataclass(eq=False)
class Handle:
    kind:str; id:int; data:dict=field(default_factory=dict)
class Array(dict):
    def __init__(self,t):super().__init__();self.t=t
    def __missing__(self,k):return default(self.t)
class Returned(Exception):
    def __init__(self,value):self.value=value
class Exited(Exception):pass
class Suspended(Exception):pass

class VM:
    def __init__(self,model,api):
        self.model=model;self.api=api;self.g={};self.types={};self.trace=[];self.tracking=False
        self.next_id=1048576;self.players={};self.enums={};self.trigger=None;self.enum=None;self.frames=[]
        self.signatures=api['functions'];self.functions=model['functions']
    def handle(self,kind,**data):
        self.next_id+=1;return Handle(kind,self.next_id,data)
    def encode(self,v):
        if v is None:return 'nil'
        if isinstance(v,bool):return 'true' if v else 'false'
        if isinstance(v,Code):return 'c:'+v
        if isinstance(v,Handle):return f'h:{v.kind}:{v.id}'
        if isinstance(v,int):return str(v)
        if isinstance(v,float):return 'f:'+struct.pack('>f',f32(v)).hex()
        if isinstance(v,str):return 's:'+v.encode().hex()
        raise TypeError(type(v))
    def var(self,name,loc):return (loc[name] if name in loc else self.g.get(name),self.frames[-1].get(name,self.types.get(name)) if self.frames else self.types.get(name))
    def expr(self,n,loc):
        k=n[0]
        if k=='var':return self.var(n[1],loc)
        if k=='code':return Code(n[1]),'code'
        if k=='array':
            a,t=self.var(n[1],loc);return a[self.expr(n[2],loc)[0]],t
        if k=='call':return self.call(n[1],[self.expr(a,loc)[0] for a in n[2]]),self.signatures[n[1]]['Returns']
        if k=='literal':
            typ,s=n[1:]
            if typ=='NullLiteralExpression':return None,'null'
            if typ=='TrueLiteralExpression':return True,'boolean'
            if typ=='FalseLiteralExpression':return False,'boolean'
            if typ=='StringLiteralExpression':
                value=re.sub(r'\\(.)',lambda m:{'n':'\n','r':'\r','t':'\t','b':'\b','f':'\f'}.get(m[1],m[1]),s[1:-1]);return value,'string'
            if typ=='FourCCLiteralExpression':return i32(int.from_bytes(s[1:-1].encode('latin1'),'big')),'integer'
            if typ=='CharacterLiteralExpression':return ord(s[1]),'integer'
            if typ=='RealLiteralExpression':return f32(float(s)),'real'
            radix=16 if typ=='HexadecimalLiteralExpression' else 8 if typ=='OctalLiteralExpression' else 10
            return i32(int(s.replace('$','0x'),radix)),'integer'
        if k=='unary':
            v,t=self.expr(n[2],loc)
            if n[1]=='LogicalNotExpression':return not v,'boolean'
            if n[1]=='UnaryMinusExpression':return (i32(-v) if t=='integer' else -v),t
            return v,t
        if k=='binary':
            op=n[1];a,ta=self.expr(n[2],loc)
            if op=='LogicalAndExpression' and not a:return False,'boolean'
            if op=='LogicalOrExpression' and a:return True,'boolean'
            b,tb=self.expr(n[3],loc)
            if op in ['LogicalAndExpression','LogicalOrExpression']:return bool(b),'boolean'
            if op=='AddExpression' and 'string' in [ta,tb]:return (a or '')+(b or ''),'string'
            real='real' in [ta,tb]
            if real:a,b=f32(a),f32(b)
            comparisons={'EqualsExpression':lambda:a==b,'NotEqualsExpression':lambda:a!=b,'LessThanExpression':lambda:a<b,'GreaterThanExpression':lambda:a>b,'LessThanOrEqualExpression':lambda:a<=b,'GreaterThanOrEqualExpression':lambda:a>=b}
            if op in comparisons:return comparisons[op](),'boolean'
            if op=='AddExpression':v=a+b
            elif op=='SubtractExpression':v=a-b
            elif op=='MultiplyExpression':v=a*b
            elif op=='DivideExpression':
                v=a/b if real else (abs(a)//abs(b))*(-1 if (a<0)!=(b<0) else 1)
            else:raise ValueError(op)
            return (f32(v) if real else i32(v)),('real' if real else 'integer')
        raise ValueError(n)
    def declare(self,n,loc,types):
        _,name,typ,array,value=n;types[name]=typ
        loc[name]=Array(typ) if array else default(typ) if value is None else self.expr(value,loc)[0]
        if typ=='real' and not array:loc[name]=f32(loc[name])
    def statements(self,body,loc):
        for n in body:
            k=n[0]
            if k=='decl':self.declare(n,loc,self.frames[-1])
            elif k=='set':
                _,name,index,value=n;v=self.expr(value,loc)[0];target=loc if name in loc else self.g
                typ=self.var(name,loc)[1]
                if typ=='real':v=f32(v)
                if index is None:target[name]=v
                else:target[name][self.expr(index,loc)[0]]=v
            elif k=='call':self.call(n[1],[self.expr(a,loc)[0] for a in n[2]])
            elif k=='return':raise Returned(None if n[1] is None else self.expr(n[1],loc)[0])
            elif k=='exit':
                if self.expr(n[1],loc)[0]:raise Exited()
            elif k=='loop':
                for iteration in range(100000):
                    try:self.statements(n[1],loc)
                    except Exited:break
                else:raise RuntimeError('Nonterminating JASS loop')
            elif k=='if':
                for condition,branch in n[1]:
                    if self.expr(condition,loc)[0]:self.statements(branch,loc);break
                else:self.statements(n[2],loc)
            else:raise ValueError(n)
    def call(self,name,args):
        sig=self.signatures[name]
        args=[f32(v) if t=='real' else v for v,t in zip(args,sig['Types'])]
        if name in self.functions:
            f=self.functions[name];loc={p[0]:v for p,v in zip(f['parameters'],args)}
            self.frames.append(dict(f['parameters']))
            try:self.statements(f['body'],loc)
            except Returned as e:return f32(e.value) if f['returns']=='real' else e.value
            finally:self.frames.pop()
            return None
        if self.tracking:self.trace.append(name+'|'+ '|'.join(self.encode(v) for v in args))
        return self.native(name,args,sig['Returns'])
    def actions(self,t):
        previous=self.trigger;self.trigger=t
        try:
            for code in t.data.get('actions',[]):
                try:self.call(code,[])
                except Suspended:break
        finally:self.trigger=previous
    def native(self,n,a,ret):
        if n.startswith('Convert'):
            key=(ret,a[0]);self.enums.setdefault(key,Handle(ret,a[0]));return self.enums[key]
        if n=='Player':
            self.players.setdefault(a[0],Handle('player',100+a[0]));return self.players[a[0]]
        if n=='GetPlayerId':return a[0].id-100 if a[0] else 0
        if n=='GetHandleId':return a[0].id if a[0] else 0
        if n=='GetPlayerNeutralAggressive':return 24
        if n=='GetPlayerNeutralPassive':return 27
        if n=='GetBJMaxPlayers':return 24
        if n=='GetBJMaxPlayerSlots':return 28
        if n=='GetLocalPlayer':return self.native('Player',[0],'player')
        if n=='GetTriggeringTrigger':return self.trigger
        if n in ['GetEnumPlayer','GetEnumUnit']:return self.enum
        if n in ['Condition','Filter']:return self.handle(ret,code=a[0])
        if n=='TriggerAddAction':a[0].data.setdefault('actions',[]).append(a[1]);return self.handle(ret)
        if n=='TriggerAddCondition':a[0].data.setdefault('conditions',[]).append(a[1]);return self.handle(ret)
        if n=='DisableTrigger':a[0].data['disabled']=True;return None
        if n=='EnableTrigger':a[0].data['disabled']=False;return None
        if n=='IsTriggerEnabled':return bool(a[0]) and not a[0].data.get('disabled',False)
        if n=='TriggerEvaluate':return all(self.call(h.data['code'],[]) for h in a[0].data.get('conditions',[]))
        if n in ['TriggerExecute','ConditionalTriggerExecute','TriggerExecuteBJ']:
            if a[0] is None:return None
            if n=='TriggerExecute' or (not a[0].data.get('disabled',False) and all(self.call(h.data['code'],[]) for h in a[0].data.get('conditions',[]))):self.actions(a[0])
            return None
        if n=='ExecuteFunc':self.call(a[0],[]);return None
        if n in ['TriggerSleepAction','PolledWait']:raise Suspended()
        if n in ['GroupAddUnit','ForceAddPlayer']:a[0].data.setdefault('members',[]).append(a[1]);return True if ret=='boolean' else None
        if n in ['ForForce','ForGroup','ForGroupBJ']:
            previous=self.enum
            for member in (a[0].data.get('members',[]) if a[0] else []):self.enum=member;self.call(a[1],[])
            self.enum=previous;return None
        if n in ['CreateUnit','BlzCreateUnitWithSkin','CreateUnitByName']:return self.handle('unit',typeid=a[1],x=a[2],y=a[3])
        if n=='GetUnitTypeId':return a[0].data.get('typeid',0) if a[0] else 0
        if n in ['GetUnitX','GetUnitY']:return f32(a[0].data.get('x' if n.endswith('X') else 'y',0)) if a[0] else 0.0
        if n in ['GetWidgetLife','GetUnitLifePercent']:return 100.0 if a[0] else 0.0
        if n=='UnitAlive':return a[0] is not None
        if n in ['GetRandomInt','GetRandomReal']:return a[0]
        if n=='I2R':return f32(a[0])
        if n=='R2I':return i32(math.trunc(a[0]))
        if n=='I2S':return str(a[0])
        if n=='R2S':return f'{a[0]:.3f}'
        if n=='StringLength':return len((a[0] or '').encode())
        if n=='StringCase':return (a[0] or '').upper() if a[1] else (a[0] or '').lower()
        if n=='S2I':
            match=re.match(r'\s*([+-]?\d+)',a[0] or '');return i32(int(match[1])) if match else 0
        if n=='SubString':return (a[0] or '').encode()[a[1]:a[2]].decode()
        if n in ['Sin','Cos','SquareRoot','Atan2','Pow']:
            return f32({'Sin':math.sin,'Cos':math.cos,'SquareRoot':math.sqrt,'Atan2':math.atan2,'Pow':pow}[n](*a))
        if n.startswith(('Create','InitHashtable','TriggerRegister')) or n in ['GetWorldBounds','GetPlayableMapRect']:
            if ret not in ['nothing','integer','real','boolean','string']:return self.handle(ret)
        return default(ret)
    def startup(self):
        for d in self.model['apiGlobals']:self.declare(d,self.g,self.types)
        self.tracking=True
        for d in self.model['globals']:self.declare(d,self.g,self.types)
        self.call('config',[]);self.call('main',[])
        return self.trace
