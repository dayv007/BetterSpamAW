

local Kill_BM_Spams = {
	"so easy",
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



--- Auto updater by ShadyRetard/Shady#0001

--- Auto updater Variables
local SCRIPT_FILE_NAME = GetScriptName();
local SCRIPT_FILE_ADDR = "https://raw.githubusercontent.com/dayv007/BetterSpamAW/blob/master/BetterSpam.lua";
local VERSION_FILE_ADDR = "https://raw.githubusercontent.com/dayv007/BetterSpamAW/blob/master/version.txt"; --- in case of update i need to update this. (Note by superyu'#7167 "so i don't forget it.")#
local VERSION_NUMBER = "0.1"; --- This too
local version_check_done = false;
local update_downloaded = false;
local update_available = false;


--- Auto Updater GUI Stuff
local BETTERSPAM_UPDATER_TAB = gui.Tab(gui.Reference("Settings"), "betterspam.updater.tab", "BetterSpam Autoupdater")
local BETTERSPAM_UPDATER_GROUP = gui.Groupbox(BETTERSPAM_UPDATER_TAB, "Auto Updater for BetterSpam | v" .. VERSION_NUMBER, 15, 15, 600, 600)
local BETTERSPAM_UPDATER_TEXT = gui.Text(BETTERSPAM_UPDATER_GROUP, "")


local function handleUpdates()

    if (update_available and not update_downloaded) then
        BETTERSPAM_UPDATER_TEXT:SetText("Update is getting downloaded.")
        local new_version_content = http.Get(SCRIPT_FILE_ADDR);
        local old_script = file.Open(SCRIPT_FILE_NAME, "w");
        old_script:Write(new_version_content);
        old_script:Close();
        update_available = false;
        update_downloaded = true;
    end

    if (update_downloaded) then
        BETTERSPAM_UPDATER_TEXT:SetText("Update available, please reload the script.")
        return;
    end

    if (not version_check_done) then
        version_check_done = true;
        local version = http.Get(VERSION_FILE_ADDR);
        if (version ~= VERSION_NUMBER) then
            update_available = true;
        end
    end
end

callbacks.Register("Draw", handleUpdates)
