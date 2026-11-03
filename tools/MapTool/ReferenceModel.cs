using System.Text.Json;
using War3Net.CodeAnalysis.Jass.Syntax;

// Neutral syntax export for the independent Python JASS evaluator in tests/.
// It keeps JASS literals/operators rather than Lua emission or compatibility calls.
static class ReferenceModel
{
    static string N(JassIdentifierNameSyntax n)=>n.Token.Text;
    static object[] Args(JassArgumentListSyntax a)=>a.ArgumentList.Items.Select(E).ToArray();
    static object E(JassExpressionSyntax e)=>e switch {
        JassIdentifierNameSyntax v=>new object[]{"var",N(v)},
        JassFunctionReferenceExpressionSyntax f=>new object[]{"code",N(f.IdentifierName)},
        JassLiteralExpressionSyntax l=>new object[]{"literal",l.SyntaxKind.ToString(),l.Token.Text},
        JassInvocationExpressionSyntax c=>new object[]{"call",N(c.IdentifierName),Args(c.ArgumentList)},
        JassElementAccessExpressionSyntax a=>new object[]{"array",N(a.IdentifierName),E(a.ElementAccessClause.Expression)},
        JassParenthesizedExpressionSyntax p=>E(p.Expression),
        JassUnaryExpressionSyntax u=>new object[]{"unary",u.SyntaxKind.ToString(),E(u.Expression)},
        JassBinaryExpressionSyntax b=>new object[]{"binary",b.SyntaxKind.ToString(),E(b.Left),E(b.Right)},
        _=>throw new NotSupportedException(e.GetType().Name)
    };
    static object D(JassVariableOrArrayDeclaratorSyntax d)=>d switch {
        JassVariableDeclaratorSyntax v=>new object?[]{"decl",N(v.IdentifierName),v.Type.ToString(),false,v.Value is null?null:E(v.Value.Expression)},
        JassArrayDeclaratorSyntax a=>new object?[]{"decl",N(a.IdentifierName),a.Type.ToString(),true,null},
        _=>throw new NotSupportedException(d.GetType().Name)
    };
    static object[] Body(IEnumerable<JassStatementSyntax> stmts)=>stmts.Select(S).ToArray();
    static object S(JassStatementSyntax s)=>s switch {
        JassLocalVariableDeclarationStatementSyntax l=>D(l.Declarator),
        JassSetStatementSyntax v=>new object?[]{"set",N(v.IdentifierName),v.ElementAccessClause is null?null:E(v.ElementAccessClause.Expression),E(v.Value.Expression)},
        JassCallStatementSyntax c=>new object[]{"call",N(c.IdentifierName),Args(c.ArgumentList)},
        JassReturnStatementSyntax r=>new object?[]{"return",r.Value is null?null:E(r.Value)},
        JassExitStatementSyntax x=>new object[]{"exit",E(x.Condition)},
        JassLoopStatementSyntax l=>new object[]{"loop",Body(l.Statements)},
        JassIfStatementSyntax i=>new object[]{"if",
            new object[]{new object[]{E(i.IfClause.IfClauseDeclarator.Condition),Body(i.IfClause.Statements)}}
                .Concat(i.ElseIfClauses.Select(c=>(object)new object[]{E(c.ElseIfClauseDeclarator.Condition),Body(c.Statements)})).ToArray(),
            i.ElseClause is null?Array.Empty<object>():Body(i.ElseClause.Statements)},
        _=>throw new NotSupportedException(s.GetType().Name)
    };
    static object[] Globals(JassCompilationUnitSyntax unit)=>unit.Declarations.OfType<JassGlobalsDeclarationSyntax>()
        .SelectMany(g=>g.GlobalDeclarations).Select(d=>d switch {
            JassGlobalVariableDeclarationSyntax v=>D(v.Declarator),
            JassGlobalConstantDeclarationSyntax c=>new object?[]{"decl",N(c.IdentifierName),c.Type.ToString(),false,E(c.Value.Expression)},
            _=>throw new NotSupportedException(d.GetType().Name)
        }).ToArray();
    static object Params(JassParameterListOrEmptyParameterListSyntax p)=>p is JassParameterListSyntax ps
        ?ps.ParameterList.Items.Select(x=>new[]{N(x.IdentifierName),x.Type.ToString()}).ToArray():Array.Empty<string[]>();
    public static void Export(string input,string common,string blizzard,string output) {
        var unit=JassSyntaxFactory.ParseCompilationUnit(File.ReadAllText(input));
        var api=JassSyntaxFactory.ParseCompilationUnit(File.ReadAllText(common));
        var bj=JassSyntaxFactory.ParseCompilationUnit(File.ReadAllText(blizzard));
        var functions=unit.Declarations.OfType<JassFunctionDeclarationSyntax>().ToDictionary(f=>N(f.FunctionDeclarator.IdentifierName),
            f=>new {parameters=Params(f.FunctionDeclarator.ParameterList),returns=f.FunctionDeclarator.ReturnClause.ReturnType.ToString(),body=Body(f.Statements)});
        File.WriteAllText(output,JsonSerializer.Serialize(new {globals=Globals(unit),apiGlobals=Globals(api).Concat(Globals(bj)),functions}));
    }
}
