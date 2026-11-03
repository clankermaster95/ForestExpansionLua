"""Stateful native double for differential scenarios; never a Warcraft emulator."""
from collections import Counter
from jass_model import VM,Handle,Code,f32,default

class EventVM(VM):
    def __init__(self,*args):
        super().__init__(*args)
        self.context={};self.units={};self.unit_order=[];self.timers=[];self.registered=[]
        self.current_timer=None;self.filter_unit=None;self.calls=Counter();self.active=False
        self.fallbacks=Counter();self.observations=[]
    def call(self,name,args):
        if name in self.functions:self.calls[name]+=1
        return super().call(name,args)
    def resolve(self,v):
        if isinstance(v,dict):
            if 'global' in v:return self.g[v['global']]
            if 'unit' in v:return self.units[v['unit']]
            if 'player' in v:return self.players[v['player']]
            if 'rawcode' in v:return int.from_bytes(v['rawcode'].encode(),'big')
            if 'array' in v:return self.g[v['array']][self.resolve(v['index'])]
            if 'field' in v:return self.resolve(v['of']).data[v['field']]
        return v
    def native(self,n,a,ret):
        if n in self.context:return self.context[n]
        if n=='TimerStart':
            a[0].data.update(timeout=a[1],periodic=a[2],callback=a[3],active=True)
            if a[0] not in self.timers:self.timers.append(a[0])
            return None
        if n in ['PauseTimer','DestroyTimer']:a[0].data['active']=False;return None
        if n=='GetExpiredTimer':return self.current_timer
        if n=='TimerGetElapsed':return a[0].data.get('elapsed',0.0)
        if n.startswith(('Save','Load','HaveSaved','RemoveSaved')) and 'Hashtable' not in n:
            if a and isinstance(a[0],Handle) and a[0].kind=='hashtable':
                table=a[0].data.setdefault('entries',{});key=(a[1],a[2])
                if n.startswith('Save'):table[key]=a[3];return True if ret=='boolean' else None
                if n.startswith('Load'):return table.get(key,default(ret))
                if n.startswith('HaveSaved'):return key in table
                table.pop(key,None);return None
        if n=='FlushChildHashtable':
            a[0].data['entries']={k:v for k,v in a[0].data.get('entries',{}).items() if k[0]!=a[1]};return None
        if n=='FlushParentHashtable':a[0].data['entries']={};return None
        if n in ['TriggerRegisterAnyUnitEventBJ','TriggerRegisterPlayerUnitEvent']:
            event=a[1] if n.endswith('BJ') else a[2]
            a[0].data.setdefault('events',[]).append((event,None if n.endswith('BJ') else a[1]))
            if a[0] not in self.registered:self.registered.append(a[0])
            return self.handle(ret) if ret!='nothing' else None
        if n=='GetFilterUnit':return self.filter_unit
        if n=='GroupEnumUnitsInRange':
            members=[]
            for u in self.unit_order:
                if (u.data['x']-a[1])**2+(u.data['y']-a[2])**2<=a[3]**2:
                    self.filter_unit=u
                    if a[4] is None or self.call(a[4].data['code'],[]):members.append(u)
            self.filter_unit=None;a[0].data['members']=members;return None
        if n in ['FirstOfGroup','BlzGroupGetSize','IsUnitInGroup','GroupRemoveUnit','GroupClear']:
            group=a[1] if n=='IsUnitInGroup' else a[0];members=group.data.setdefault('members',[])
            if n=='FirstOfGroup':return next(iter(members),None)
            if n=='BlzGroupGetSize':return len(members)
            if n=='IsUnitInGroup':return a[0] in members
            if n=='GroupClear':members.clear();return None
            if a[1] in members:members.remove(a[1])
            return True if ret=='boolean' else None
        if n=='GetOwningPlayer':return a[0].data.get('owner',self.players[0]) if a[0] else self.players[0]
        if n=='GetConvertedPlayerId':return (a[0].id-100+1) if a[0] else 1
        if n=='GetUnitAbilityLevel':return a[0].data.get('abilities',{}).get(a[1],0) if a[0] else 0
        if n=='UnitHasBuffBJ':return a[0].data.get('abilities',{}).get(a[1],0)>0 if a[0] else False
        if n=='UnitHasItemOfTypeBJ':return any(item.data.get('typeid')==a[1] for item in a[0].data.get('items',[])) if a[0] else False
        if n=='GetPlayerTechCountSimple':return a[1].data.get('tech',{}).get(a[0],0)
        if n=='GetBooleanOr':return a[0] or a[1]
        if n=='IsUnitType':
            if not a[0]:return False
            if a[1]==self.g['UNIT_TYPE_DEAD']:return a[0].data.get('life',100.0)<=0 or a[0].data.get('removed',False)
            return a[1].id in a[0].data.get('types',[])
        if n=='UnitAlive':return a[0] is not None and a[0].data.get('life',100.0)>0 and not a[0].data.get('removed',False)
        if n in ['IsUnitEnemy','IsUnitAlly']:
            enemy=a[0] is not None and a[0].data.get('owner')!=a[1]
            return enemy if n=='IsUnitEnemy' else not enemy
        if n=='IsUnitVisible':return a[0] is not None and a[0].data.get('visible',True)
        if n=='BlzIsUnitInvulnerable':return a[0].data.get('invulnerable',False) if a[0] else False
        if n=='GetWidgetLife':return a[0].data.get('life',100.0) if a[0] else 0.0
        if n=='SetWidgetLife':a[0].data['life']=a[1];return None
        if n=='GetUnitState':return a[0].data.get('maxLife' if a[1]==self.g['UNIT_STATE_MAX_LIFE'] else 'mana',100.0)
        if n=='BlzGetUnitZ':return a[0].data.get('z',0.0) if a[0] else 0.0
        if n in ['BlzGetUnitIntegerField','BlzGetUnitRealField']:
            return a[0].data.get('fields',{}).get(a[1].id,default(ret)) if a[0] else default(ret)
        if n in ['BlzSetUnitIntegerField','BlzSetUnitRealField']:
            a[0].data.setdefault('fields',{})[a[1].id]=a[2];return True
        if n=='BlzGetUnitArmor':return a[0].data.get('armor',0.0)
        if n=='BlzSetUnitArmor':a[0].data['armor']=a[1];return None
        if n=='UnitInventorySize':return len(a[0].data.get('items',[])) if a[0] else 0
        if n=='UnitItemInSlot':return next(iter(a[0].data.get('items',[])[a[1]:a[1]+1]),None)
        if n=='GetItemTypeId':return a[0].data.get('typeid',0) if a[0] else 0
        if n=='BlzSetEventDamage':self.context['GetEventDamage']=a[0];return None
        if n in ['BlzSetEventAttackType','BlzSetEventDamageType','BlzSetEventWeaponType']:
            self.context[n.replace('Set','Get')]=a[0];return True
        if n=='UnitDamageTarget':
            if a[1]:a[1].data['life']=f32(a[1].data.get('life',100.0)-a[2])
            return True
        if n in ['AddSpecialEffect','AddSpecialEffectTarget']:return self.handle('effect')
        if n=='GetTriggerUnit' and self.active:return None
        if self.active and ret!='nothing' and not n.startswith(('Convert','Create','TriggerRegister')):
            base={'Player','GetPlayerId','GetHandleId','GetUnitTypeId','GetUnitX','GetUnitY','GetRandomInt','GetRandomReal',
                'I2R','R2I','I2S','R2S','S2I','StringLength','StringCase','SubString','Sin','Cos','SquareRoot','Atan2','Pow',
                'GetTriggeringTrigger','GetEnumPlayer','GetEnumUnit','Condition','Filter','IsTriggerEnabled','TriggerEvaluate',
                'GetLocalPlayer','GroupAddUnit','ForceAddPlayer'}
            if n not in base:self.fallbacks[n]+=1
        return super().native(n,a,ret)
    def run(self,steps):
        self.active=True
        for step in steps:
            if 'unit' in step:
                attrs=step.get('data',{});data={'typeid':int.from_bytes(b'hfoo','big'),'x':0.0,'y':0.0,'z':0.0,
                    'life':100.0,'maxLife':100.0,'owner':self.players[0],'abilities':{},'types':[]}
                data.update({k:self.resolve(v) for k,v in attrs.items()})
                u=self.handle('unit',**data);self.units[step['unit']]=u;self.unit_order.append(u)
            if 'mutate' in step:
                u=self.resolve(step['mutate']);u.data.update({k:self.resolve(v) for k,v in step['data'].items()})
            if 'ability' in step:
                u=self.resolve(step['of']);u.data.setdefault('abilities',{})[self.resolve(step['ability'])]=step['level']
            if 'types' in step:self.resolve(step['of']).data['types']=[self.resolve(v).id for v in step['types']]
            if 'context' in step:self.context={k:self.resolve(v) for k,v in step['context'].items()}
            if 'set' in step:
                value=self.resolve(step['value'])
                if 'index' in step:self.g[step['set']][self.resolve(step['index'])]=value
                else:self.g[step['set']]=value
            if 'call' in step:
                value=self.call(step['call'],[self.resolve(a) for a in step.get('args',[])])
                self.observations.append(step['call']+'='+self.encode(value))
            if 'tick' in step:
                for _ in range(step.get('count',1)):
                    for timer in list(self.timers):
                        if timer.data.get('active') and timer.data['callback']==step['tick']:
                            self.current_timer=timer
                            if not timer.data['periodic']:timer.data['active']=False
                            self.call(timer.data['callback'],[])
                    self.current_timer=None
            if 'observe' in step:
                value=self.resolve(step['observe']);self.observations.append(step['label']+'='+self.encode(value))
                if 'expect' in step:assert value==self.resolve(step['expect']),(step,value)
        assert not self.fallbacks,'Unmodelled event return values: '+str(self.fallbacks)
