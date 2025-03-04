/*--------------------------------------------------
	=============== Autorun File ===============
	*** Copyright (c) 2012-2025 by DrVrej, All rights reserved. ***
	No parts of this code or any of its contents may be reproduced, copied, modified or adapted,
	without the prior written consent of the author, unless otherwise indicated for stand-alone materials.
--------------------------------------------------*/
------------------ Addon Information ------------------
local AddonName = "Half-Life Resurgence: Players"
local AddonType = "NPC"
-------------------------------------------------------

local VJExists = file.Exists("lua/autorun/vj_base_autorun.lua", "GAME")
if VJExists == true then
	include("autorun/vj_controls.lua")
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
------ GoldSrc Engine ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
	local spawnCategory = "HL Resurgence: GoldSrc Players"
	VJ.AddCategoryInfo(spawnCategory, {Icon = "vj_hl/icons/hl1dm.png"})

	VJ.AddNPC("Gordon Freeman", "npc_vj_hlr1_freeman", spawnCategory)
	VJ.AddNPC("Xen Survey Team Member", "npc_vj_hlr1_xensurvey", spawnCategory)	-- needs a cool spawnicon, preferrably somewhere in a xen themed map
	VJ.AddNPC("Barney Calhoun", "npc_vj_hlrbs_barney", spawnCategory)
	VJ.AddNPC("Adrian Shephard", "npc_vj_hlrof_shepard", spawnCategory)
	VJ.AddNPC("Gina Cross", "npc_vj_hlrdc_gina", spawnCategory)
	VJ.AddNPC("Colette Green", "npc_vj_hlrdc_colette", spawnCategory)
	-- HL1DM models: (TODO: make them colorable?)
		VJ.AddNPC("HL1DM Barney", "npc_vj_hlr1mp_barney", spawnCategory)
		VJ.AddNPC("HL1DM Gina", "npc_vj_hlr1mp_gina", spawnCategory)
		VJ.AddNPC("HL1DM G-Man", "npc_vj_hlr1mp_gman", spawnCategory)
		VJ.AddNPC("HL1DM Gordon", "npc_vj_hlr1mp_gordon", spawnCategory)
		VJ.AddNPC("HL1DM Helmet", "npc_vj_hlr1mp_helmet", spawnCategory)
		VJ.AddNPC("HL1DM HGrunt", "npc_vj_hlr1mp_hgrunt", spawnCategory)
		VJ.AddNPC("HL1DM Recon", "npc_vj_hlr1mp_recon", spawnCategory)
		VJ.AddNPC("HL1DM Robo", "npc_vj_hlr1mp_robo", spawnCategory)
		VJ.AddNPC("HL1DM Scientist", "npc_vj_hlr1mp_scientist", spawnCategory)
		VJ.AddNPC("HL1DM Zombie", "npc_vj_hlr1mp_zombie", spawnCategory)
		-- from HL: Further Data CD, official Valve-made addon for HL1:
			VJ.AddNPC("HL1DM Cannibal", "npc_vj_hlr1mp_cannibal", spawnCategory)
			VJ.AddNPC("HL1DM Skeleton", "npc_vj_hlr1mp_skeleton", spawnCategory) -- not colorable
			VJ.AddNPC("Ken Birdwell", "npc_vj_hlr1mp_ken", spawnCategory)
			VJ.AddNPC("Too Much Coffee Man", "npc_vj_hlr1mp_tmcm", spawnCategory)
			-- cut from HL: Further Data, released after 2023 Valve repo leaks
			VJ.AddNPC("Rat Fink", "npc_vj_hlr1mp_rfink", spawnCategory)
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
------ Source Engine ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
	spawnCategory = "HL Resurgence: Source Players"
	VJ.AddCategoryInfo(spawnCategory, {Icon = "vj_hl/icons/hl2dm.png"})

	

-- !!!!!! DON'T TOUCH ANYTHING BELOW THIS !!!!!! -------------------------------------------------------------------------------------------------------------------------
	AddCSLuaFile()
	VJ.AddAddonProperty(AddonName, AddonType)
else
	if CLIENT then
		chat.AddText(Color(0, 200, 200), AddonName, 
		Color(0, 255, 0), " was unable to install, you are missing ", 
		Color(255, 100, 0), "VJ Base!")
	end
	
	timer.Simple(1, function()
		if not VJBASE_ERROR_MISSING then
			VJBASE_ERROR_MISSING = true
			if CLIENT then
				// Get rid of old error messages from addons running on older code...
				if VJF && type(VJF) == "Panel" then
					VJF:Close()
				end
				VJF = true
				
				local frame = vgui.Create("DFrame")
				frame:SetSize(600, 160)
				frame:SetPos((ScrW() - frame:GetWide()) / 2, (ScrH() - frame:GetTall()) / 2)
				frame:SetTitle("Error: VJ Base is missing!")
				frame:SetBackgroundBlur(true)
				frame:MakePopup()
	
				local labelTitle = vgui.Create("DLabel", frame)
				labelTitle:SetPos(250, 30)
				labelTitle:SetText("VJ BASE IS MISSING!")
				labelTitle:SetTextColor(Color(255, 128, 128))
				labelTitle:SizeToContents()
				
				local label1 = vgui.Create("DLabel", frame)
				label1:SetPos(170, 50)
				label1:SetText("Garry's Mod was unable to find VJ Base in your files!")
				label1:SizeToContents()
				
				local label2 = vgui.Create("DLabel", frame)
				label2:SetPos(10, 70)
				label2:SetText("You have an addon installed that requires VJ Base but VJ Base is missing. To install VJ Base, click on the link below. Once\n                                                   installed, make sure it is enabled and then restart your game.")
				label2:SizeToContents()
				
				local link = vgui.Create("DLabelURL", frame)
				link:SetSize(300, 20)
				link:SetPos(195, 100)
				link:SetText("VJ_Base_Download_Link_(Steam_Workshop)")
				link:SetURL("https://steamcommunity.com/sharedfiles/filedetails/?id=131759821")
				
				local buttonClose = vgui.Create("DButton", frame)
				buttonClose:SetText("CLOSE")
				buttonClose:SetPos(260, 120)
				buttonClose:SetSize(80, 35)
				buttonClose.DoClick = function()
					frame:Close()
				end
			elseif (SERVER) then
				VJF = true
				timer.Remove("VJBASEMissing")
				timer.Create("VJBASE_ERROR_CONFLICT", 5, 0, function()
					print("VJ Base is missing! Download it from the Steam Workshop! Link: https://steamcommunity.com/sharedfiles/filedetails/?id=131759821")
				end)
			end
		end
	end)
end