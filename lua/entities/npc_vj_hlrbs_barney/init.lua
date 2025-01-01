AddCSLuaFile("shared.lua")
include("shared.lua")
/*-----------------------------------------------
	*** Copyright (c) 2012-2024 by DrVrej, All rights reserved. ***
	No parts of this code or any of its contents may be reproduced, copied, modified or adapted,
	without the prior written consent of the author, unless otherwise indicated for stand-alone materials.
-----------------------------------------------*/
ENT.Model = {"models/vj_hlr/hl1mp/barney.mdl"}
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:Init()
	self.WeaponsList = {
		["Close"] = {
			"weapon_vj_hlr1_ply_hgun",
			"weapon_vj_hlr1_ply_shotgun",
			-- "weapon_vj_hlr1_ply_squeak",
		},
		["Normal"] = {
			"weapon_vj_hlr1_ply_357",
			"weapon_vj_hlr1_ply_mp5",
			"weapon_vj_hlr1_ply_pistol",
		},
		["Far"] = {
			"weapon_vj_hlr1_ply_crossbow",
		},
	}
	self.BaseClass.Init(self)
end