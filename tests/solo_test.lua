-- Test the registered callbacks and multiplayer/ownership gates, not just parsing.
local checks,players,triggers,event,timers,created,items,messages=0
local function check(v,m) assert(v,m); checks=checks+1 end
function Player(i) if not players[i] then players[i]={id=i,controller='computer',playing=false,gold=0,lumber=0} end; return players[i] end
function GetPlayerController(p) return p.controller end
function GetPlayerSlotState(p) return p.playing and 'playing' or 'empty' end
function GetPlayerState(p,k) return p[k] end
function SetPlayerState(p,k,v) p[k]=v end
function GetOwningPlayer(u) return u.owner end
function GetUnitTypeId(u) return u and not u.removed and u.kind or 0 end
function GetWidgetLife(u) return u.life end
function SetWidgetLife(u,v) u.life=v end
function GetUnitState(u,k) return u[k] end
function SetUnitState(u,k,v) u[k]=v end
function GetUnitX(u) return u.x end
function GetUnitY(u) return u.y end
function GetUnitFacing() return 270 end
function GetPlayerStartLocation(p) return p.id end
function GetStartLocationX(i) return i*100 end
function GetStartLocationY() return 200 end
function FourCC(s) return s end
function CreateUnit(p,raw,x,y) local u={owner=p,kind=raw,x=x,y=y,life=100}; created[#created+1]=u; return u end
function CreateItem(raw,x,y) local i={kind=raw,x=x,y=y};items[#items+1]=i;return i end
function GetItemTypeId(i) return i and i.kind or 0 end
function UnitItemInSlot(u,i) return u.slots and u.slots[i] end
function DisplayTextToPlayer(p,x,y,s) messages[#messages+1]=s end
function CreateTrigger() local t={conditions={}}; triggers[#triggers+1]=t; return t end
function Condition(f) return f end
function TriggerAddCondition(t,f) t.conditions[#t.conditions+1]=f end
function TriggerRegisterPlayerChatEvent(t,p,pattern,exact) t.kind='chat';t.player=p end
function TriggerRegisterPlayerUnitEventSimple(t,p,e) t.kind=e;t.player=p end
function TriggerAddAction(t,f) t.action=f end
function GetTriggerUnit() return event.unit end
function GetTriggerPlayer() return event.player end
function GetEventPlayerChatString() return event.text end
function CreateTimer() local t={};timers[#timers+1]=t;return t end
function TimerStart(t,d,periodic,f) t.callback=f end
function DestroyTimer(t) t.destroyed=true end
function IsUnitType(u) return u.hero end
function AddHeroXP(u,n) u.xp=(u.xp or 0)+n end
function GetHeroLevel(u) return u.level end
function SetHeroLevel(u,n) u.level=math.max(u.level,n) end
function UnitStripHeroLevel(u,n) u.level=u.level-n end
function UnitResetCooldown(u) u.cooldown=0 end
function SetUnitInvulnerable(u,v) u.invul=v end
function KillUnit(u) u.life=0 end
function RemoveUnit(u) u.removed=true end
function ReviveHero(u) u.life=100 end
function SetUnitMoveSpeed(u,n) u.speed=n end
function SetTimeOfDay(n) hour=n end
function CreateFogModifierRect(p) return {owner=p} end
function FogModifierStart(f) f.active=true end
function FogModifierStop(f) f.active=false end
function DestroyFogModifier(f) f.destroyed=true end
local guide,quests
function CreateQuest() local q={};quests[#quests+1]=q;if not guide then guide=q end;return q end
function QuestSetTitle(q,s) q.title=s end
function QuestSetDescription(q,s) q.description=s end
function QuestSetRequired(q,v) q.required=v end
function QuestSetDiscovered(q,v) q.discovered=v end
function QuestSetEnabled(q,v) q.enabled=v end
function QuestSetIconPath(q,s) q.icon=s end
function DisableTrigger(t) t.disabled=true end
function PauseTimer(t) t.paused=true end
function TimerDialogDisplay(d,v) d.visible=v end
function RemoveUnitFromStock(s,id) s.stock[id]=nil end
function AddUnitToStock(s,id,n) s.stock[id]=n;s.adds=(s.adds or 0)+1 end
function GetLocalPlayer() error('Game mutation must not query local player') end
function GroupEnumUnitsSelected() error('No unsynchronized selection reads') end
bj_MAX_PLAYER_SLOTS=28; MAP_CONTROL_USER='user'; PLAYER_SLOT_STATE_PLAYING='playing'
PLAYER_STATE_RESOURCE_GOLD='gold'; PLAYER_STATE_RESOURCE_LUMBER='lumber'
EVENT_PLAYER_UNIT_SELECTED='selected'; UNIT_TYPE_HERO='hero'
UNIT_STATE_MAX_LIFE='maxlife';UNIT_STATE_MAX_MANA='maxmana';UNIT_STATE_MANA='mana'
FOG_OF_WAR_VISIBLE='visible';bj_mapInitialPlayableArea={}
local function emit(kind,p,u,text)
    event={player=p,unit=u,text=text}
    for _,t in ipairs(triggers) do if t.kind==kind and t.player==p then t.action() end end
end
local function reset(humans)
    players={};triggers={};timers={};created={};items={};messages={};quests={};guide=nil;udg_AncientUnit=nil
    for _,slot in ipairs(humans) do local p=Player(slot);p.controller='user';p.playing=true end
    dofile('src/commands/test_data.lua');dofile('src/commands/solo_test.lua')
    FE_Shops={initDebug=function(p) check(FE_Test.allowed(p),'shop diagnostics only initialized for solo player') end}
    for _,name in ipairs(FE_Test.resultTriggers) do _G[name]={conditions={}} end
    FE_Test.init()
    for _,t in ipairs(timers) do t.callback() end
end
reset({0,6}); check(FE_Test.player==nil and #triggers==0,'multiplayer creates no cheat listeners')
check(#gg_trg_Extermination.conditions==0 and FE_Test.matchResultsEnabled(),'multiplayer victory logic remains enabled')
Player(6).playing=false; FE_Test.run(Player(0),'-gold 10000')
check(Player(0).gold==0,'multiplayer cannot become debug lobby after other players leave')
reset({6});local p=Player(6)
check(FE_Test.player==p and #triggers==2,'solo Ancient starts enabled')
for _,name in ipairs(FE_Test.resultTriggers) do
    check(#_G[name].conditions==1 and not _G[name].conditions[1](),'solo mode suppresses every result trigger before announcements')
end
check(#quests==0,'solo mode does not add debug pages to Information/F9')
emit('chat',p,nil,'-test help')
local helpText=table.concat(messages,'\n')
check(helpText:find('DEBUG_REFERENCE.md',1,true) and not helpText:find('F9',1,true),'help points to the separate reference document')
gg_trg_Spawn_Races={};gg_trg_Spawn_Ancients={};gg_trg_TimeToExpanderSpawn={};gg_trg_TimeToAncientSpawn={}
for _,entry in ipairs(FE_TestData.pickers) do _G[entry.shop]={kind='shop',stock={}};_G[entry.ban]=0 end
local banned=FE_TestData.pickers[1];_G[banned.ban]=1
local countdown={timer={},dialog={visible=true}};FE_Test.countdowns={countdown}
emit('chat',p,nil,'-test skip')
check(FE_Test.skipped and gg_trg_Spawn_Ancients.disabled and gg_trg_Spawn_Races.disabled,'skip disables later stock initialization')
check(countdown.timer.paused and not countdown.dialog.visible,'skip hides active pick countdown')
for _,entry in ipairs(FE_TestData.pickers) do
    local expected=1;if entry.ban==banned.ban then expected=nil end
    check(_G[entry.shop].stock[entry.raw]==expected,'skip stocks allowed picks immediately')
end
local ancientShop=_G[FE_TestData.pickers[#FE_TestData.pickers].shop];local adds=ancientShop.adds
emit('chat',p,nil,'-test skip');check(ancientShop.adds==adds,'skip is idempotent')
FE_Test.init();check(#triggers==2,'initialization is idempotent')
emit('chat',p,nil,'-gold 10000');emit('chat',p,nil,'-test lumber 5000')
check(p.gold==10000 and p.lumber==5000,'resource aliases and prefixed command work')
emit('chat',p,nil,'-gold -20000');check(p.gold==0,'negative resource bounded at zero')
for _,arg in ipairs({'nan','inf','1e99','9999999999999999999','1.5','1000001',''}) do emit('chat',p,nil,'-gold '..arg) end
check(p.gold==0,'invalid numeric inputs do not mutate resources')
FE_Test.run(Player(0),'-gold 10000');check(Player(0).gold==0,'different sender rejected')
Player(0).controller='user';Player(0).playing=true;emit('chat',p,nil,'-gold 10000')
check(p.gold==0,'unexpected second human disables commands at execution')
Player(0).playing=false
emit('chat',p,nil,'-spawn h000 3');check(#created==3 and created[1].owner==p,'spawn works at player start without selected unit')
local u=created[1];u.hero=true;u.level=1;u.maxlife=800;u.maxmana=200;u.life=50;u.mana=10
emit('selected',p,u);emit('chat',p,nil,'-test xp 500');emit('chat',p,nil,'-lvl 10')
check(u.xp==500 and u.level==10,'XP and level affect selected own hero')
emit('chat',p,nil,'-lvl 3');check(u.level==3,'level command can lower hero level')
local foreign={owner=Player(0),kind='h000',life=100,x=0,y=0};emit('selected',p,foreign)
emit('chat',p,nil,'-heal');check(u.life==800 and u.mana==200 and foreign.life==100,'enemy selection does not replace own test target')
emit('chat',p,nil,'-test item I001 2');check(#items==2 and items[1].x==u.x+64,'validated item spawning')
emit('chat',p,nil,'-spawn xxxx');emit('chat',p,nil,'-spawn h000 999');emit('chat',p,nil,'-item h000')
check(#created==3 and #items==2,'unknown/cross-kind IDs and excessive spawn counts rejected')
emit('chat',p,nil,'-invul');check(u.invul,'invulnerability enabled')
emit('chat',p,nil,'-vul');check(not u.invul,'invulnerability disabled')
u.cooldown=8;emit('chat',p,nil,'-test cooldown');check(u.cooldown==0,'cooldown resets')
emit('chat',p,nil,'-test kill');check(u.life==0,'kill own target')
emit('chat',p,nil,'-test revive');check(u.life==100,'revive dead own hero')
emit('chat',p,nil,'-mh');local f=FE_Test.vision;emit('chat',p,nil,'-mh')
check(f.destroyed and FE_Test.vision.active,'repeated reveal releases previous modifier')
f=FE_Test.vision;emit('chat',p,nil,'-nomh');check(f.destroyed and FE_Test.vision==nil,'hide releases modifier')
local n=#messages;emit('chat',p,nil,'-test find human');check(#messages>n,'catalog lookup is available')
messages={};emit('chat',p,nil,'-test items 2')
check(messages[1]:find('[items]',1,true) and messages[13]:find('page 2/',1,true),'items browse second page separately')
messages={};emit('chat',p,nil,'-test units human')
check(messages[1]:find('[units]',1,true),'units list filters names independently')
emit('chat',p,nil,'-test time 12');check(hour==12,'time command')
u.owner=Player(0);emit('chat',p,nil,'-test kill');check(u.life==100,'ownership rechecked after selected unit changes owner')
reset({0});check(FE_Test.player==Player(0),'solo mode also works for Red expander')
print('Solo test checks passed: '..checks..' assertions; registered chat/selection callbacks and start-time human gate')
