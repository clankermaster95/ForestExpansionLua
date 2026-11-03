#nullable disable
namespace ForestPort
{
    public partial class TriggerRenderer
    {
        private void RenderForLoopA(TriggerFunction function, TriggerRendererContext context)
        {
            RenderForLoop(function, context, "bj_forLoopAIndex", "bj_forLoopAIndexEnd");
        }

        private void RenderForLoopB(TriggerFunction function, TriggerRendererContext context)
        {
            RenderForLoop(function, context, "bj_forLoopBIndex", "bj_forLoopBIndexEnd");
        }

        private void RenderForLoop(TriggerFunction function, TriggerRendererContext context, string indexName, string indexEndName)
        {
            var argumentTypes = GetArgumentTypes(function);

            context.Writer.WriteSet(indexName, GetParameter(function.Parameters[0], argumentTypes[0], 0, context.TrigFunctionIdentifierBuilder));
            context.Writer.WriteSet(indexEndName, GetParameter(function.Parameters[1], argumentTypes[1], 1, context.TrigFunctionIdentifierBuilder));

            context.Writer.WriteLoop();
            context.Writer.WriteExitWhen(JassExpression.GreaterThan(
                indexName,
                indexEndName));

            RenderTriggerAction(function.Parameters[2].Function, context);

            context.Writer.WriteSet(
                indexName,
                JassExpression.Add(indexName, "1"));

            context.Writer.WriteEndLoop();
        }

        private void RenderForLoopVar(TriggerFunction function, TriggerRendererContext context)
        {
            RenderLoopBody(function, context, true, false);
        }

        private void RenderForLoopAMultiple(TriggerFunction function, TriggerRendererContext context)
        {
            RenderLoopBody(function, context, false, true, "bj_forLoopAIndex", "bj_forLoopAIndexEnd");
        }

        private void RenderForLoopBMultiple(TriggerFunction function, TriggerRendererContext context)
        {
            RenderLoopBody(function, context, false, true, "bj_forLoopBIndex", "bj_forLoopBIndexEnd");
        }

        private void RenderForLoopVarMultiple(TriggerFunction function, TriggerRendererContext context)
        {
            RenderLoopBody(function, context, true, true);
        }

        // Missing in upstream 6.1.2. Match World Editor's JASS loop expansion,
        // including re-evaluating the end expression for a user-variable loop.
        private void RenderLoopBody(TriggerFunction f, TriggerRendererContext c, bool variable, bool multiple,
            string index = null, string bound = null)
        {
            var types = GetArgumentTypes(f);
            string P(int n) => GetParameter(f.Parameters[n], types[n], n, c.TrigFunctionIdentifierBuilder);
            int offset = variable ? 1 : 0;
            if (variable) index = P(0);
            c.Writer.WriteSet(index, P(offset));
            if (variable) bound = P(offset + 1);
            else c.Writer.WriteSet(bound, P(offset + 1));
            c.Writer.WriteLoop();
            c.Writer.WriteExitWhen(JassExpression.GreaterThan(index, bound));
            if (multiple)
            {
                c.TrigFunctionIdentifierBuilder.Append("Func");
                for (int i = 0; i < f.ChildFunctions.Count; i++)
                {
                    var child = f.ChildFunctions[i];
                    if (!child.IsEnabled || child.Type != TriggerFunctionType.Action) continue;
                    c.TrigFunctionIdentifierBuilder.Append(i + 1);
                    RenderTriggerAction(child, c);
                    c.TrigFunctionIdentifierBuilder.Remove();
                }
                c.TrigFunctionIdentifierBuilder.Remove();
            }
            else RenderTriggerAction(f.Parameters[offset + 2].Function, c);
            c.Writer.WriteSet(index, JassExpression.Add(index, "1"));
            c.Writer.WriteEndLoop();
        }
    }
}
