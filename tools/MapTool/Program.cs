using System.Reflection;
using System.Text;
using System.Text.Json;
using System.Text.Json.Serialization;
using War3Net.Build.Extensions;
using War3Net.Build.Info;
using War3Net.Build;
using War3Net.Build.Script;
using War3Net.CodeAnalysis;

static class Program
{
    public static readonly JsonSerializerOptions Json = new() { WriteIndented = true };
    static readonly Dictionary<string,string> Formats = new() {
        [".w3i"]="MapInfo", [".w3e"]="MapEnvironment", [".wpm"]="MapPathingMap",
        [".w3u"]="UnitObjectData", [".w3t"]="ItemObjectData", [".w3a"]="AbilityObjectData",
        [".w3b"]="DestructableObjectData", [".w3d"]="DoodadObjectData", [".w3h"]="BuffObjectData",
        [".w3q"]="UpgradeObjectData", [".w3r"]="MapRegions", [".w3s"]="MapSounds",
        [".w3c"]="MapCameras", [".wtg"]="MapTriggers", [".wct"]="MapCustomTextTriggers",
        [".mmp"]="MapPreviewIcons", [".imp"]="ImportedFiles"
    };
    static Type FileType(string path) {
        string name=Path.GetFileName(path).Equals("war3mapUnits.doo",StringComparison.OrdinalIgnoreCase)
            ? "MapUnits" : Path.GetExtension(path)==".doo" ? "MapDoodads" : Formats[Path.GetExtension(path)];
        return typeof(MapInfo).Assembly.GetTypes().Single(t=>t.Name==name);
    }
    static object Read(string path,Type type) {
        using var s=File.OpenRead(path); using var r=new BinaryReader(s,Encoding.UTF8);
        var method=typeof(War3Net.Build.Extensions.BinaryReaderExtensions).GetMethod("Read"+type.Name,[typeof(BinaryReader)])!;
        var data=method.Invoke(null,[r])!;
        if(s.Position!=s.Length) throw new Exception($"Unparsed bytes in {path}: {s.Length-s.Position}");
        return data;
    }
    static byte[] Write(object data,Type type) {
        using var s=new MemoryStream(); using var w=new BinaryWriter(s,Encoding.UTF8);
        var method=typeof(War3Net.Build.Extensions.BinaryWriterExtensions).GetMethod("Write",[typeof(BinaryWriter),type])!;
        method.Invoke(null,[w,data]); w.Flush(); return s.ToArray();
    }
    static void Main(string[] args) {
        Json.Converters.Add(new JsonStringEnumConverter());
        if(args[0]=="transpile") { new LuaPort().Run(args[1],args[2],args[3],args[4],args.Length>5?args[5]:null); return; }
        if(args[0]=="model") { ReferenceModel.Export(args[1],args[2],args[3],args[4]); return; }
        if(args[0]=="inspect-text") {
            var map=Map.Open(args[1]);
            var parsed=map.TriggerStrings!.Strings;
            var strings=parsed.GroupBy(s=>s.Key).ToDictionary(g=>g.Key,g=>g.First().Value);
            string? Resolve(string? value) => value is not null && value.StartsWith("TRIGSTR_")
                ? strings.GetValueOrDefault(uint.Parse(value[8..])) : value;
            var info=map.Info!;
            Console.WriteLine(JsonSerializer.Serialize(new {stringCount=strings.Count,parsedCount=parsed.Count,
                duplicates=parsed.GroupBy(s=>s.Key).Where(g=>g.Count()>1).Select(g=>new {key=g.Key,count=g.Count()}).Take(10),
                first=parsed.Take(5),
                mapName=Resolve(info.MapName),description=Resolve(info.MapDescription),
                author=Resolve(info.MapAuthor),players=Resolve(info.RecommendedPlayers)},Json));
            return;
        }
        if(args[0]=="editor-code") {
            var triggers=Read(Path.Combine(args[1],"war3map.wtg"),FileType("war3map.wtg"));
            var text=Read(Path.Combine(args[1],"war3map.wct"),FileType("war3map.wct"));
            File.WriteAllText(args[2],JsonSerializer.Serialize(new {Triggers=triggers,Text=text},Json)); return;
        }
        if(args[0]=="disabled") {
            var map=Map.Open(args[1]); int index=0; var result=new StringBuilder();
            // A deleted variable is still referenced by the original disabled Flag Destroyed
            // trigger. Its OperatorInt usage determines the type. Keep it disabled.
            map.Triggers!.Variables.Add(new VariableDefinition { Name="GARATHORflagCounters",Type="integer",IsArray=true });
            result.AppendLine("globals\ninteger array udg_GARATHORflagCounters\nendglobals");
            foreach(var t in map.Triggers!.TriggerItems.OfType<TriggerDefinition>()) {
                if(t.IsComment) continue;
                var code=map.CustomTextTriggers!.CustomTextTriggers[index++].Code;
                if(t.IsEnabled) continue;
                result.AppendLine("// Trigger: "+t.Name);
                if(t.IsCustomTextTrigger) result.AppendLine((code??"").TrimEnd('\0'));
                else {
                    using var sw=new StringWriter(); using var iw=new IndentedTextWriter(sw);
                    new ForestPort.TriggerRenderer(iw,TriggerData.Default,map.Triggers.Variables).RenderTrigger(t);
                    result.AppendLine(sw.ToString());
                }
            }
            File.WriteAllText(args[2],result.ToString()); return;
        }
        if(args[0]=="export") {
            Directory.CreateDirectory(args[2]); var result=new List<object>();
            foreach(var path in Directory.GetFiles(args[1]).Order()) {
                if(!Formats.ContainsKey(Path.GetExtension(path)) && Path.GetExtension(path)!=".doo") continue;
                var type=FileType(path); var data=Read(path,type);
                var json=JsonSerializer.Serialize(data,type,Json);
                var round=Write(JsonSerializer.Deserialize(json,type,Json)!,type);
                if(!File.ReadAllBytes(path).SequenceEqual(round)) throw new Exception("Non-lossless codec: "+path);
                File.WriteAllText(Path.Combine(args[2],Path.GetFileName(path)+".json"),json+"\n");
                result.Add(new { file=Path.GetFileName(path),type=type.Name,bytes=round.Length,byteExact=true });
                Console.WriteLine($"{Path.GetFileName(path)}: byte-exact binary > JSON > binary");
            }
            File.WriteAllText(Path.Combine(args[2],"_roundtrip.json"),JsonSerializer.Serialize(result,Json));
            return;
        }
        if(args[0]=="import") {
            // Usage: import data.json target.w3u. Type is inferred from the target filename.
            var type=FileType(args[2]); var data=JsonSerializer.Deserialize(File.ReadAllText(args[1]),type,Json)!;
            File.WriteAllBytes(args[2],Write(data,type)); return;
        }
        if(args[0]=="lua-flag") {
            var b=File.ReadAllBytes(args[1]); var type=typeof(MapInfo); var data=(MapInfo)Read(args[1],type);
            var original=Write(data,type);
            if(!b.SequenceEqual(original)) throw new Exception("Map info does not round-trip");
            data.ScriptLanguage=ScriptLanguage.Lua; var changed=Write(data,type);
            var diffs=Enumerable.Range(0,b.Length).Where(i=>b[i]!=changed[i]).ToArray();
            if(diffs.Length>1) throw new Exception("Language patch changed unrelated bytes");
            File.WriteAllBytes(args[2],changed);
            Console.WriteLine(JsonSerializer.Serialize(new {data.FormatVersion,data.GameVersion,data.ScriptLanguage,changedOffsets=diffs},Json));
            return;
        }
        throw new ArgumentException("Expected transpile, export, import, or lua-flag");
    }
}
