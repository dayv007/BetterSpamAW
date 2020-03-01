

local Kill_BM_Spams = {
	"so ez",
	"get clapped",
	"did that hurt?",
	"do you want me to blow on that?",
	"btw you are supposed to shoot me.",
	"sry I didn't know you were retarded",
	"join my discord: https://discord.gg/WhyUs0b4d",
	"CSGO->Game->Game->TurnOnInstructorMessages that might help you",
	"better luck next time",
	"bro how did you hit the accept button with that aim???",
	"ff?",
	"I can teach you if you want.",
	"xD my cat killed you",
	"better do you homework"
};
local Death_BM_Spams = {
	"nice luck",
	"sry my brother was playing",
	"doesn't count my mom came in",
	"ok now I start playing",
	"I think you should be in bed already",
	"welcome to the scoreboard"
};



-- Better Spam Tab
local ref = gui.Tab(gui.Reference("Misc"), "better_spam.settings", "Better Spam")

--Kill BM Spam
local Kill_BM_Group = gui.Groupbox(ref, "Kill Message", 15, 15, 297);
local Kill_BM_Act = gui.Combobox( Kill_BM_Group, "lua_combobox", "Enable", "off", "automated", "on Key" );

--Death BM Spam
local Death_BM_Group = gui.Groupbox(ref, "Death Message", 300, 15, 297);
local Death_BM_Act = gui.Combobox( Death_BM_Group, "lua_combobox", "Enable", "off", "automated", "on Key" );


--Kill/Death Trigger
local function CHAT_KillSay( Event )

   if ( Event:GetName() == 'player_death' ) then

       local ME = client.GetLocalPlayerIndex();

       local INT_UID = Event:GetInt( 'userid' );
       local INT_ATTACKER = Event:GetInt( 'attacker' );

       local NAME_Victim = client.GetPlayerNameByUserID( INT_UID );
       local INDEX_Victim = client.GetPlayerIndexByUserID( INT_UID );

       local NAME_Attacker = client.GetPlayerNameByUserID( INT_ATTACKER );
       local INDEX_Attacker = client.GetPlayerIndexByUserID( INT_ATTACKER );

       if ( INDEX_Attacker == ME and INDEX_Victim ~= ME and Kill_BM_Act:GetValue()==1) then

           client.ChatSay( ' ' .. tostring( Kill_BM_Spams[math.random(1,table.getn(Kill_BM_Spams))] ) .. ' @' .. NAME_Victim );

       elseif ( INDEX_Victim == ME and INDEX_Attacker ~= ME and Death_BM_Act:GetValue()==1) then

           client.ChatSay( ' ' .. tostring( Death_BM_Spams[math.random(1,table.getn(Death_BM_Spams))] ) .. ' ' .. NAME_Attacker );

       end

   end

end

client.AllowListener( 'player_death' );

callbacks.Register( 'FireGameEvent', 'AWKS', CHAT_KillSay );