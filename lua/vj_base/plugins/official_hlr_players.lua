/*-----------------------------------------------
	*** Copyright (c) 2012-2026 by DrVrej, All rights reserved. ***
	No parts of this code or any of its contents may be reproduced, copied, modified or adapted,
	without the prior written consent of the author, unless otherwise indicated for stand-alone materials.
-----------------------------------------------*/
VJ.AddPlugin("Half-Life Resurgence: Players", "NPC")

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
------ GoldSrc Engine ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
local spawnCategory = "HL Resurgence: GoldSrc Players"
VJ.AddCategoryInfo(spawnCategory, {Icon = "vj_hl/icons/hl1dm.png"})

local subCategory = "Protagonist Players"
VJ.AddNPC("Gordon Freeman", "npc_vj_hlr1_freeman", spawnCategory, {SubCategory = subCategory})
VJ.AddNPC("Xen Survey Team Member", "npc_vj_hlr1_xensurvey", spawnCategory, {SubCategory = subCategory}) -- needs a cool spawnicon, preferably somewhere in a xen themed map
VJ.AddNPC("Barney Calhoun", "npc_vj_hlrbs_barney", spawnCategory, {SubCategory = subCategory})
VJ.AddNPC("Adrian Shephard", "npc_vj_hlrof_shephard", spawnCategory, {SubCategory = subCategory})
VJ.AddNPC("Gina Cross", "npc_vj_hlrdc_gina", spawnCategory, {SubCategory = subCategory})
VJ.AddNPC("Colette Green", "npc_vj_hlrdc_colette", spawnCategory, {SubCategory = subCategory})
-- HL1DM models: (TODO: make them colorable?)
    subCategory = "Deathmatch Players"
	VJ.AddNPC("HL1DM Barney", "npc_vj_hlr1mp_barney", spawnCategory, {SubCategory = subCategory})
	VJ.AddNPC("HL1DM Gina", "npc_vj_hlr1mp_gina", spawnCategory, {SubCategory = subCategory})
	VJ.AddNPC("HL1DM G-Man", "npc_vj_hlr1mp_gman", spawnCategory, {SubCategory = subCategory})
	VJ.AddNPC("HL1DM Gordon", "npc_vj_hlr1mp_gordon", spawnCategory, {SubCategory = subCategory})
	VJ.AddNPC("HL1DM Helmet", "npc_vj_hlr1mp_helmet", spawnCategory, {SubCategory = subCategory})
	VJ.AddNPC("HL1DM HGrunt", "npc_vj_hlr1mp_hgrunt", spawnCategory, {SubCategory = subCategory})
	VJ.AddNPC("HL1DM Recon", "npc_vj_hlr1mp_recon", spawnCategory, {SubCategory = subCategory})
	VJ.AddNPC("HL1DM Robo", "npc_vj_hlr1mp_robo", spawnCategory, {SubCategory = subCategory})
	VJ.AddNPC("HL1DM Scientist", "npc_vj_hlr1mp_scientist", spawnCategory, {SubCategory = subCategory})
	VJ.AddNPC("HL1DM Zombie", "npc_vj_hlr1mp_zombie", spawnCategory, {SubCategory = subCategory})
	-- from HL: Further Data CD, official Valve-made addon for HL1:
		VJ.AddNPC("HL1DM Cannibal", "npc_vj_hlr1mp_cannibal", spawnCategory, {SubCategory = subCategory})
		VJ.AddNPC("HL1DM Skeleton", "npc_vj_hlr1mp_skeleton", spawnCategory, {SubCategory = subCategory}) -- not colorable
		VJ.AddNPC("Ken Birdwell", "npc_vj_hlr1mp_ken", spawnCategory, {SubCategory = subCategory})
		VJ.AddNPC("Too Much Coffee Man", "npc_vj_hlr1mp_tmcm", spawnCategory, {SubCategory = subCategory})
		-- cut from HL: Further Data, released after 2023 Valve repo leaks
		VJ.AddNPC("Rat Fink", "npc_vj_hlr1mp_rfink", spawnCategory, {SubCategory = subCategory})
		-- HATSUNE MIKU?!!??!?
		if util.IsValidModel("models/xinus22/mikuhl1.mdl") then -- Only list if required playermodel addon is on the server: https://steamcommunity.com/sharedfiles/filedetails/?id=3448004915
			VJ.AddNPC("Hatsune Miku", "npc_vj_hlr1mp_mike", spawnCategory, {SubCategory = subCategory})
		end
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
------ Source Engine ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
spawnCategory = "HL Resurgence: Source Players"
VJ.AddCategoryInfo(spawnCategory, {Icon = "vj_hl/icons/hl2dm.png"})