AddCSLuaFile("shared.lua")
include("shared.lua")
/*-----------------------------------------------
	*** Copyright (c) 2012-2024 by DrVrej, All rights reserved. ***
	No parts of this code or any of its contents may be reproduced, copied, modified or adapted,
	without the prior written consent of the author, unless otherwise indicated for stand-alone materials.
-----------------------------------------------*/
ENT.Model = {"models/vj_hlr/hl1mp/shepard.mdl"}

ENT.VJ_NPC_Class = {"CLASS_UNITED_STATES"}
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:Init()
	self.WeaponsList = {
		["Close"] = {
			"weapon_vj_hlr1_ply_shotgun",
			"weapon_vj_hlr1_ply_grenade",
			"weapon_vj_hlr1_ply_squeak_opfor",
		},
		["Normal"] = {
			"weapon_vj_hlr1_ply_deagle",
			"weapon_vj_hlr1_ply_mp5",
			"weapon_vj_hlr1_ply_pistol",
			"weapon_vj_hlr1_ply_saw",
			"weapon_vj_hlr1_ply_shockrifle",
			"weapon_vj_hlr1_ply_sporelauncher",
			"weapon_vj_hlr1_ply_rpg",
		},
		["Far"] = {
			"weapon_vj_hlr1_ply_m40a1",
		},
	}
	self.BaseClass.Init(self)
end