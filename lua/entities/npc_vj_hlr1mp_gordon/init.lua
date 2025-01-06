AddCSLuaFile("shared.lua")
include("shared.lua")
/*-----------------------------------------------
	*** Copyright (c) 2012-2025 by DrVrej, All rights reserved. ***
	No parts of this code or any of its contents may be reproduced, copied, modified or adapted,
	without the prior written consent of the author, unless otherwise indicated for stand-alone materials.
-----------------------------------------------*/
ENT.Model = {"models/vj_hlr/hl1mp/gordonmp.mdl"}
ENT.StartHealth = 100
ENT.VJ_NPC_Class = {"CLASS_MP_HEV"}
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:Init()
	self.WeaponsList = {
		["Close"] = {
			"weapon_vj_hlr1_ply_hgun",
			"weapon_vj_hlr1_ply_shotgun",
			"weapon_vj_hlr1_ply_grenade",
			"weapon_vj_hlr1_ply_squeak",
			"weapon_vj_hlr1_ply_squeak_opfor",
		},
		["Normal"] = {
			"weapon_vj_hlr1_ply_357",
			"weapon_vj_hlr1_ply_gauss",
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
			"weapon_vj_hlr1_ply_crossbow",
		},
	}
	self.BaseClass.Init(self)
end