include("entities/npc_vj_hlr1_freeman/init.lua")
AddCSLuaFile("shared.lua")
include("shared.lua")
/*-----------------------------------------------
	*** Copyright (c) 2012-2026 by DrVrej, All rights reserved. ***
	No parts of this code or any of its contents may be reproduced, copied, modified or adapted,
	without the prior written consent of the author, unless otherwise indicated for stand-alone materials.
-----------------------------------------------*/
ENT.Model = "models/vj_hlr/hl1mp/x22miku.mdl"
ENT.BloodColor = ""
ENT.HasBloodParticle = false
ENT.HasBloodDecal = false

ENT.WeaponInventory_MeleeList = "weapon_vj_hlr1_ply_crowbar"
ENT.WeaponsList = {
	["Close"] = {
		"weapon_vj_hlr1_ply_hgun",
		"weapon_vj_hlr1_ply_shotgun",
		"weapon_vj_hlr1_ply_grenade",
		"weapon_vj_hlr1_ply_squeak"
	},
	["Normal"] = {
		"weapon_vj_hlr1_ply_357",
		"weapon_vj_hlr1_ply_gauss",
		"weapon_vj_hlr1_ply_mp5",
		"weapon_vj_hlr1_ply_pistol",
	},
	["Far"] = {
		"weapon_vj_hlr1_ply_crossbow"
		"weapon_vj_hlr1_ply_rpg"
	},
}

---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:PreInit()
	if GetConVar("vj_hlr_dm_ffa"):GetInt() == 1 then
		self.VJ_NPC_Class = {"CLASS_MP_MIKE"}
		self.AlliedWithPlayerAllies = false
	end
end

---------------------------------------------------------------------------------------------------------------------------------------------
local gibsCollideSd = {"vj_hlr/gsrc/fx/metal1.wav", "vj_hlr/gsrc/fx/metal2.wav", "vj_hlr/gsrc/fx/metal3.wav", "vj_hlr/gsrc/fx/metal4.wav", "vj_hlr/gsrc/fx/metal5.wav"}
--
function ENT:HandleGibOnDeath(dmginfo, hitgroup)
	self.HasDeathSounds = false
	local upPos = self.Sentry_OrientationType == 1 and -30 or 20
	local attPos = self.Sentry_GroundType == 1 and self:GetAttachment(self:LookupAttachment("center")).Pos or nil -- Decay sentry gun
	
	self:CreateGibEntity("obj_vj_gib", "models/vj_hlr/gibs/metalgib_p1.mdl", {CollisionDecal = false, Pos = self:LocalToWorld(Vector(0, 0, 40)), CollisionSound = gibsCollideSd})
	self:CreateGibEntity("obj_vj_gib", "models/vj_hlr/gibs/metalgib_p2.mdl", {CollisionDecal = false, Pos = self:LocalToWorld(Vector(0, 1, 40)), CollisionSound = gibsCollideSd})
	self:CreateGibEntity("obj_vj_gib", "models/vj_hlr/gibs/metalgib_p3.mdl", {CollisionDecal = false, Pos = self:LocalToWorld(Vector(0, 0, 50)), CollisionSound = gibsCollideSd})
	self:CreateGibEntity("obj_vj_gib", "models/vj_hlr/gibs/metalgib_p4.mdl", {CollisionDecal = false, Pos = self:LocalToWorld(Vector(1, 0, 40)), CollisionSound = gibsCollideSd})
	self:CreateGibEntity("obj_vj_gib", "models/vj_hlr/gibs/metalgib_p5.mdl", {CollisionDecal = false, Pos = self:LocalToWorld(Vector(1, 1, 40)), CollisionSound = gibsCollideSd})
	self:CreateGibEntity("obj_vj_gib", "models/vj_hlr/gibs/metalgib_p6.mdl", {CollisionDecal = false, Pos = self:LocalToWorld(Vector(0, 0, 45)), CollisionSound = gibsCollideSd})
	self:CreateGibEntity("obj_vj_gib", "models/vj_hlr/gibs/metalgib_p7.mdl", {CollisionDecal = false, Pos = self:LocalToWorld(Vector(0, 1, 45)), CollisionSound = gibsCollideSd})
	self:CreateGibEntity("obj_vj_gib", "models/vj_hlr/gibs/rgib_cog1.mdl", {CollisionDecal = false, Pos = self:LocalToWorld(Vector(0, 0, 60)), CollisionSound = gibsCollideSd})
	self:CreateGibEntity("obj_vj_gib", "models/vj_hlr/gibs/rgib_cog2.mdl", {CollisionDecal = false, Pos = self:LocalToWorld(Vector(0, 0, 15)), CollisionSound = gibsCollideSd})
	self:CreateGibEntity("obj_vj_gib", "models/vj_hlr/gibs/rgib_rib.mdl", {CollisionDecal = false, Pos = self:LocalToWorld(Vector(0, 1, 15)), CollisionSound = gibsCollideSd})
	self:CreateGibEntity("obj_vj_gib", "models/vj_hlr/gibs/rgib_screw.mdl", {CollisionDecal = false, Pos = self:LocalToWorld(Vector(1, 0, 15)), CollisionSound = gibsCollideSd})
	self:CreateGibEntity("obj_vj_gib", "models/vj_hlr/gibs/rgib_screw.mdl", {CollisionDecal = false, Pos = self:LocalToWorld(Vector(1, 1, 15)), CollisionSound = gibsCollideSd})
	self:CreateGibEntity("obj_vj_gib", "models/vj_hlr/gibs/rgib_screw.mdl", {CollisionDecal = false, Pos = self:LocalToWorld(Vector(1, 2, 15)), CollisionSound = gibsCollideSd})
	self:CreateGibEntity("obj_vj_gib", "models/vj_hlr/gibs/rgib_spring.mdl", {CollisionDecal = false, Pos = self:LocalToWorld(Vector(2, 1, 15)), CollisionSound = false})

	VJ.EmitSound(self, "vj_hlr/gsrc/wep/explosion/debris3.wav", 100, 100)
	self:PlaySoundSystem("Gib", "vj_hlr/gsrc/npc/rgrunt/rb_gib.wav")
	return true, {AllowSound = false}
end
---------------------------------------------------------------------------------------------------------------------------------------------
local gibs = {"models/vj_hlr/gibs/metalgib_p1.mdl", "models/vj_hlr/gibs/metalgib_p2.mdl", "models/vj_hlr/gibs/metalgib_p3.mdl", "models/vj_hlr/gibs/metalgib_p4.mdl", "models/vj_hlr/gibs/metalgib_p5.mdl", "models/vj_hlr/gibs/metalgib_p6.mdl", "models/vj_hlr/gibs/rgib_cog1.mdl", "models/vj_hlr/gibs/rgib_cog2.mdl", "models/vj_hlr/gibs/rgib_rib.mdl", "models/vj_hlr/gibs/rgib_screw.mdl", "models/vj_hlr/gibs/rgib_screw.mdl", "models/vj_hlr/gibs/rgib_screw.mdl"}
--
function ENT:OnCreateDeathCorpse(dmginfo, hitgroup, corpse)
	VJ.HLR_ApplyCorpseSystem(self, corpse, gibs, {CollisionSound = gibsCollideSd, ExpSound = {"vj_hlr/gsrc/npc/rgrunt/rb_gib.wav"}})
end