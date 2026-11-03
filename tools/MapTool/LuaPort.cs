using System.Globalization;
using System.Text;
using System.Text.Json;
using War3Net.CodeAnalysis.Jass;
using War3Net.CodeAnalysis.Jass.Syntax;

// A typed, fail-closed Lua emitter over War3Net's JASS AST. No regex rewriting of code.
// JASS numeric operations are explicitly represented so Lua's 64-bit arithmetic and
// floor division cannot silently change the original map's calculations.
sealed class LuaPort
{
    record Signature(string Returns, string[] Types, string[] Names);
    record Expr(string Code,string Type);
    readonly Dictionary<string,Signature> functions=new();
    readonly Dictionary<string,string> globals=new(),locals=new();
    readonly HashSet<string> usedFunctions=new(),usedGlobals=new();
    readonly Dictionary<string,string> unresolved=new();
    bool allowMissing;
    string returnType="nothing";
    static readonly HashSet<string> Keywords=["and","break","do","else","elseif","end","false","for","function","goto","if","in","local","nil","not","or","repeat","return","then","true","until","while"];
    static string Id(string s)=>Keywords.Contains(s)?"__j_"+s:s;
    static string Name(JassIdentifierNameSyntax n)=>n.Token.Text;
    static string Type(JassTypeSyntax t)=>t.ToString()!;
    static string Default(string t)=>t switch {"integer"=>"0","real"=>"0.0","boolean"=>"false",_=>"nil"};
    // In small Lua the decimal token 2147483648 is a float, even after unary
    // minus. Spell INT_MIN using representable integer tokens instead.
    static string IntLiteral(int value)=>value==int.MinValue?"(-2147483647 - 1)":value.ToString(CultureInfo.InvariantCulture);
    public static string Quote(string s) {
        var b=new StringBuilder("\"");
        foreach(char c in s) b.Append(c switch {'"'=>"\\\"",'\\'=>"\\\\",'\n'=>"\\n",'\r'=>"\\r",'\t'=>"\\t",_=>c<32?"\\"+((int)c).ToString("D3"):c.ToString()});
        return b.Append('"').ToString();
    }
    static string DecodeJassString(string token) {
        var b=new StringBuilder();
        for(int i=1;i<token.Length-1;i++) {
            char c=token[i];
            if(c=='\\') c=token[++i] switch {'n'=>'\n','r'=>'\r','t'=>'\t','b'=>'\b','f'=>'\f',var other=>other};
            b.Append(c);
        }
        return b.ToString();
    }
    static string StripBlockComments(string source) {
        // Preserve strings and line numbers while accepting vJASS's block comments.
        return System.Text.RegularExpressions.Regex.Replace(source,
            "\"(?:[^\"\\\\]|\\\\.)*\"|//[^\\r\\n]*|/\\*[\\s\\S]*?\\*/",
            m=>m.Value.StartsWith("/*")?new string(m.Value.Select(c=>c=='\n'||c=='\r'?c:' ').ToArray()):m.Value);
    }
    static JassParameterSyntax[] Parameters(JassParameterListOrEmptyParameterListSyntax p)=>p is JassParameterListSyntax list?list.ParameterList.Items.ToArray():[];
    static Signature Sig(JassParameterListOrEmptyParameterListSyntax p,JassTypeSyntax ret) {
        var ps=Parameters(p); return new(Type(ret),ps.Select(x=>Type(x.Type)).ToArray(),ps.Select(x=>Name(x.IdentifierName)).ToArray());
    }
    void Register(JassCompilationUnitSyntax unit) {
        foreach(var d in unit.Declarations) switch(d) {
            case JassGlobalsDeclarationSyntax g:
                foreach(var v in g.GlobalDeclarations) switch(v) {
                    case JassGlobalConstantDeclarationSyntax c: globals[Name(c.IdentifierName)]=Type(c.Type); break;
                    case JassGlobalVariableDeclarationSyntax x:
                        if(x.Declarator is JassArrayDeclaratorSyntax a) globals[Name(a.IdentifierName)]=Type(a.Type);
                        else if(x.Declarator is JassVariableDeclaratorSyntax b) globals[Name(b.IdentifierName)]=Type(b.Type);
                        else throw new NotSupportedException(v.ToString());
                        break;
                    default: throw new NotSupportedException(v.ToString());
                } break;
            case JassFunctionDeclarationSyntax f:
                var decl=f.FunctionDeclarator;
                functions[Name(decl.IdentifierName)]=Sig(decl.ParameterList,decl.ReturnClause.ReturnType); break;
            case JassNativeFunctionDeclarationSyntax n:
                functions[Name(n.IdentifierName)]=Sig(n.ParameterList,n.ReturnClause.ReturnType); break;
        }
    }
    string Variable(string name) {
        if(locals.TryGetValue(name,out var type)) return type;
        usedGlobals.Add(name); return globals[name];
    }
    static string Coerce(Expr e,string type)=>type=="real"&&e.Type=="integer"?$"__jreal({e.Code})":e.Code;
    Expr Call(string name,JassArgumentListSyntax args) {
        usedFunctions.Add(name); var sig=functions[name]; var a=args.ArgumentList.Items.ToArray();
        if(a.Length!=sig.Types.Length) throw new Exception($"Arity mismatch for {name}");
        if(allowMissing) for(int i=0;i<a.Length;i++) {
            if(a[i] is JassIdentifierNameSyntax id && !globals.ContainsKey(Name(id)) && !locals.ContainsKey(Name(id)))
                globals[Name(id)]=unresolved[Name(id)]=sig.Types[i];
        }
        return new($"{Id(name)}({string.Join(", ",a.Select((x,i)=>Coerce(E(x),sig.Types[i])))})",sig.Returns);
    }
    Expr E(JassExpressionSyntax n) {
        switch(n) {
            case JassIdentifierNameSyntax i: return new(Id(Name(i)),Variable(Name(i)));
            case JassFunctionReferenceExpressionSyntax f: usedFunctions.Add(Name(f.IdentifierName)); return new(Id(Name(f.IdentifierName)),"code");
            case JassInvocationExpressionSyntax call: return Call(Name(call.IdentifierName),call.ArgumentList);
            case JassElementAccessExpressionSyntax a: return new($"{Id(Name(a.IdentifierName))}[{E(a.ElementAccessClause.Expression).Code}]",Variable(Name(a.IdentifierName)));
            case JassParenthesizedExpressionSyntax p: var pe=E(p.Expression); return pe with {Code="("+pe.Code+")"};
            case JassLiteralExpressionSyntax l:
                var s=l.Token.Text;
                return l.SyntaxKind switch {
                    JassSyntaxKind.TrueLiteralExpression=>new("true","boolean"),
                    JassSyntaxKind.FalseLiteralExpression=>new("false","boolean"),
                    JassSyntaxKind.NullLiteralExpression=>new("nil","null"),
                    JassSyntaxKind.DecimalLiteralExpression=>new(IntLiteral(unchecked((int)long.Parse(s,CultureInfo.InvariantCulture))),"integer"),
                    JassSyntaxKind.OctalLiteralExpression=>new(IntLiteral(JassLiteral.ParseOctal(s)),"integer"),
                    JassSyntaxKind.HexadecimalLiteralExpression=>new(IntLiteral(JassLiteral.ParseHex(s)),"integer"),
                    JassSyntaxKind.FourCCLiteralExpression=>new($"FourCC({Quote(s[1..^1])})","integer"),
                    JassSyntaxKind.CharacterLiteralExpression=>new(((int)JassLiteral.ParseChar(s)).ToString(),"integer"),
                    JassSyntaxKind.RealLiteralExpression=>new($"__jreal({s})","real"),
                    JassSyntaxKind.StringLiteralExpression=>new(Quote(DecodeJassString(s)),"string"),
                    _=>throw new NotSupportedException(l.SyntaxKind.ToString())
                };
            case JassUnaryExpressionSyntax u:
                var x=E(u.Expression);
                return u.SyntaxKind switch {
                    JassSyntaxKind.UnaryPlusExpression=>x,
                    JassSyntaxKind.UnaryMinusExpression=>new(x.Type=="integer"?$"__jint(-({x.Code}))":$"(-({x.Code}))",x.Type),
                    JassSyntaxKind.LogicalNotExpression=>new($"(not {x.Code})","boolean"),
                    _=>throw new NotSupportedException(u.SyntaxKind.ToString())
                };
            case JassBinaryExpressionSyntax b:
                var left=E(b.Left); var right=E(b.Right);
                var kind=b.SyntaxKind;
                if(kind==JassSyntaxKind.AddExpression&&(left.Type=="string"||right.Type=="string"))
                    return new($"__jconcat({left.Code}, {right.Code})","string");
                bool real=left.Type=="real"||right.Type=="real";
                var lc=real?Coerce(left,"real"):left.Code; var rc=real?Coerce(right,"real"):right.Code;
                var op=kind switch {
                    JassSyntaxKind.AddExpression=>"+",JassSyntaxKind.SubtractExpression=>"-",JassSyntaxKind.MultiplyExpression=>"*",JassSyntaxKind.DivideExpression=>"/",
                    JassSyntaxKind.EqualsExpression=>"==",JassSyntaxKind.NotEqualsExpression=>"~=",JassSyntaxKind.GreaterThanExpression=>">",JassSyntaxKind.LessThanExpression=>"<",
                    JassSyntaxKind.GreaterThanOrEqualExpression=>">=",JassSyntaxKind.LessThanOrEqualExpression=>"<=",JassSyntaxKind.LogicalAndExpression=>"and",JassSyntaxKind.LogicalOrExpression=>"or",
                    _=>throw new NotSupportedException(kind.ToString())
                };
                bool math=op is "+" or "-" or "*" or "/";
                if(!math) return new($"({lc} {op} {rc})","boolean");
                if(op=="/"&&!real) return new($"__jdiv({lc}, {rc})","integer");
                return new($"{(real?"__jreal":"__jint")}({lc} {op} {rc})",real?"real":"integer");
            default: throw new NotSupportedException(n.GetType().Name+": "+n);
        }
    }
    string Declare(JassVariableOrArrayDeclaratorSyntax d,bool local) {
        if(d is JassArrayDeclaratorSyntax a) {
            var name=Name(a.IdentifierName); var type=Type(a.Type);
            (local?locals:globals)[name]=type;
            return $"{(local?"local ":"")}{Id(name)} = __jarray({Default(type)})";
        }
        if(d is JassVariableDeclaratorSyntax v) {
            var name=Name(v.IdentifierName); var type=Type(v.Type);
            var value=v.Value is null?Default(type):Coerce(E(v.Value.Expression),type);
            (local?locals:globals)[name]=type;
            return $"{(local?"local ":"")}{Id(name)} = {value}";
        }
        throw new NotSupportedException(d.GetType().Name);
    }
    void Statements(StringBuilder b,IEnumerable<JassStatementSyntax> stmts,int depth) {
        void Line(string s)=>b.Append(' ',4*depth).AppendLine(s);
        foreach(var s in stmts) switch(s) {
            case JassLocalVariableDeclarationStatementSyntax l: Line(Declare(l.Declarator,true)); break;
            case JassSetStatementSyntax set:
                var name=Name(set.IdentifierName); var type=Variable(name);
                Line(Id(name)+(set.ElementAccessClause is null?"":$"[{E(set.ElementAccessClause.Expression).Code}]")+" = "+Coerce(E(set.Value.Expression),type)); break;
            case JassCallStatementSyntax c: Line(Call(Name(c.IdentifierName),c.ArgumentList).Code); break;
            case JassReturnStatementSyntax r:
                // A do block permits subsequent unreachable source statements, legal in JASS.
                Line("do return"+(r.Value is null?"":" "+Coerce(E(r.Value),returnType))+" end"); break;
            case JassExitStatementSyntax ex: Line("if "+E(ex.Condition).Code+" then break end"); break;
            case JassLoopStatementSyntax loop: Line("while true do"); Statements(b,loop.Statements,depth+1); Line("end"); break;
            case JassIfStatementSyntax i:
                Line("if "+E(i.IfClause.IfClauseDeclarator.Condition).Code+" then"); Statements(b,i.IfClause.Statements,depth+1);
                foreach(var el in i.ElseIfClauses) { Line("elseif "+E(el.ElseIfClauseDeclarator.Condition).Code+" then"); Statements(b,el.Statements,depth+1); }
                if(i.ElseClause is not null) { Line("else"); Statements(b,i.ElseClause.Statements,depth+1); }
                Line("end"); break;
            default: throw new NotSupportedException(s.GetType().Name+": "+s);
        }
    }
    public void Run(string input,string common,string blizzard,string output,string? context=null) {
        allowMissing=context is not null; // Only archival, disabled source may have broken references.
        var api=JassSyntaxFactory.ParseCompilationUnit(File.ReadAllText(common));
        var bj=JassSyntaxFactory.ParseCompilationUnit(File.ReadAllText(blizzard));
        var map=JassSyntaxFactory.ParseCompilationUnit(StripBlockComments(File.ReadAllText(input)));
        Register(api); Register(bj);
        if(context is not null) Register(JassSyntaxFactory.ParseCompilationUnit(File.ReadAllText(context)));
        Register(map); Directory.CreateDirectory(output);
        var g=new StringBuilder(); var names=new List<object>(); int count=0;
        foreach(var d in map.Declarations) switch(d) {
            case JassNativeFunctionDeclarationSyntax: break; // Provided by the Warcraft III Lua VM.
            case JassGlobalsDeclarationSyntax all:
                foreach(var decl in all.GlobalDeclarations) {
                    if(decl is JassGlobalVariableDeclarationSyntax v) g.AppendLine(Declare(v.Declarator,false));
                    else if(decl is JassGlobalConstantDeclarationSyntax c) g.AppendLine(Id(Name(c.IdentifierName))+" = "+Coerce(E(c.Value.Expression),Type(c.Type)));
                    else throw new NotSupportedException(decl.GetType().Name);
                } break;
            case JassFunctionDeclarationSyntax f:
                locals.Clear(); var name=Name(f.FunctionDeclarator.IdentifierName); var sig=functions[name]; returnType=sig.Returns;
                for(int i=0;i<sig.Names.Length;i++) locals[sig.Names[i]]=sig.Types[i];
                var body=new StringBuilder();
                body.AppendLine("function "+Id(name)+"("+string.Join(", ",sig.Names.Select(Id))+")");
                Statements(body,f.Statements,1); body.AppendLine("end");
                File.WriteAllText(Path.Combine(output,name+".lua"),body.ToString());
                names.Add(new {name,luaName=Id(name),parameters=sig.Names,parameterTypes=sig.Types,returns=sig.Returns}); count++; break;
            default: throw new NotSupportedException(d.GetType().Name+": "+d);
        }
        File.WriteAllText(Path.Combine(output,"globals.lua"),g.ToString());
        var apiGlobalCode=new StringBuilder();
        foreach(var decl in api.Declarations.Concat(bj.Declarations).OfType<JassGlobalsDeclarationSyntax>().SelectMany(x=>x.GlobalDeclarations)) {
            if(decl is JassGlobalVariableDeclarationSyntax v) apiGlobalCode.AppendLine(Declare(v.Declarator,false));
            else if(decl is JassGlobalConstantDeclarationSyntax c) apiGlobalCode.AppendLine(Id(Name(c.IdentifierName))+" = "+Coerce(E(c.Value.Expression),Type(c.Type)));
        }
        File.WriteAllText(Path.Combine(output,"api_globals.lua"),apiGlobalCode.ToString());
        File.WriteAllText(Path.Combine(output,"functions.json"),JsonSerializer.Serialize(names,Program.Json));
        File.WriteAllText(Path.Combine(output,"api.json"),JsonSerializer.Serialize(new {functions,globals,usedFunctions=usedFunctions.Order(),usedGlobals=usedGlobals.Order(),unresolved},Program.Json));
        Console.WriteLine($"Converted {count} functions; all expressions resolved against declared types.");
    }
}
