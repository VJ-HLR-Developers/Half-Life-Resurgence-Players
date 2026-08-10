include("entities/npc_vj_hlr1mp_gordon/init.lua")
AddCSLuaFile("shared.lua")
include("shared.lua")
/*-----------------------------------------------
	*** Copyright (c) 2012-2026 by DrVrej, All rights reserved. ***
	No parts of this code or any of its contents may be reproduced, copied, modified or adapted,
	without the prior written consent of the author, unless otherwise indicated for stand-alone materials.
-----------------------------------------------*/
ENT.Model = "models/vj_hlr/hl1mp/skeleton.mdl"
ENT.VJ_NPC_Class = {"CLASS_ZOMBIE"}
ENT.Bleeds = false
ENT.BloodColor = ""
ENT.HasBloodParticle = false
ENT.HasBloodDecal = false
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:PreInit()
	if GetConVar("vj_hlr_dm_ffa"):GetInt() == 1 then
		self.VJ_NPC_Class = {"CLASS_MP_SKELETON"}
		self.AlliedWithPlayerAllies = false
	end
end
---------------------------------------------------------------------------------------------------------------------------------------------
local gibsCollideSd = {"vj_hlr/gsrc/fx/flesh1.wav", "vj_hlr/gsrc/fx/flesh2.wav", "vj_hlr/gsrc/fx/flesh3.wav", "vj_hlr/gsrc/fx/flesh5.wav", "vj_hlr/gsrc/fx/flesh6.wav", "vj_hlr/gsrc/fx/flesh7.wav"}
--
function ENT:HandleGibOnDeath(dmginfo, hitgroup)
		self.HasDeathSounds = false

		self:CreateGibEntity("obj_vj_gib", "models/vj_hlr/gibs/abone_template1.mdl", {CollisionDecal = false, CollisionSound = gibsCollideSd, Pos = self:LocalToWorld(Vector(0, 0, 40))})
		self:CreateGibEntity("obj_vj_gib", "models/vj_hlr/gibs/abone_template1.mdl", {CollisionDecal = false, CollisionSound = gibsCollideSd, Pos = self:LocalToWorld(Vector(0, 0, 20))})
		self:CreateGibEntity("obj_vj_gib", "models/vj_hlr/gibs/abone_template1.mdl", {CollisionDecal = false, CollisionSound = gibsCollideSd, Pos = self:LocalToWorld(Vector(0, 0, 30))})
		self:CreateGibEntity("obj_vj_gib", "models/vj_hlr/gibs/abone_template1.mdl", {CollisionDecal = false, CollisionSound = gibsCollideSd, Pos = self:LocalToWorld(Vector(0, 0, 15))})
		self:CreateGibEntity("obj_vj_gib", "models/vj_hlr/gibs/abone_template1.mdl", {CollisionDecal = false, CollisionSound = gibsCollideSd, Pos = self:LocalToWorld(Vector(0, 0, 35))})
		self:CreateGibEntity("obj_vj_gib", "models/vj_hlr/gibs/bleachbones_pelvis_template1.mdl", {CollisionDecal = false, CollisionSound = gibsCollideSd, Pos = self:LocalToWorld(Vector(0, 0, 35))})
		self:CreateGibEntity("obj_vj_gib", "models/vj_hlr/gibs/bleachbones_jawbone1.mdl", {CollisionDecal = false, CollisionSound = gibsCollideSd, Pos = self:LocalToWorld(Vector(0, 0, 50))})
		self:CreateGibEntity("obj_vj_gib", "models/vj_hlr/gibs/bleachbones_bskull_template1.mdl", {CollisionDecal = false, CollisionSound = gibsCollideSd, Pos = self:LocalToWorld(Vector(0, 0, 55))})
		self:CreateGibEntity("obj_vj_gib", "models/vj_hlr/gibs/bleachbones_ribcage1.mdl", {CollisionDecal = false, CollisionSound = gibsCollideSd, Pos = self:LocalToWorld(Vector(0, 0, 40))})
		self:CreateGibEntity("obj_vj_gib", "models/vj_hlr/gibs/bleachbones_riblet1.mdl", {CollisionDecal = false, CollisionSound = gibsCollideSd, Pos = self:LocalToWorld(Vector(0, 0, 45))})
		self:CreateGibEntity("obj_vj_gib", "models/vj_hlr/gibs/bleachbones_riblet1.mdl", {CollisionDecal = false, CollisionSound = gibsCollideSd, Pos = self:LocalToWorld(Vector(0, 0, 25))})
		self:CreateGibEntity("obj_vj_gib", "models/vj_hlr/gibs/bleachbones_riblet1.mdl", {CollisionDecal = false, CollisionSound = gibsCollideSd, Pos = self:LocalToWorld(Vector(0, 0, 35))})

	return true, {AllowSound = false}
end
---------------------------------------------------------------------------------------------------------------------------------------------
local gibstbl = {"models/vj_hlr/gibs/abone_template1.mdl", "models/vj_hlr/gibs/abone_template1.mdl", "models/vj_hlr/gibs/abone_template1.mdl", "models/vj_hlr/gibs/abone_template1.mdl", "models/vj_hlr/gibs/abone_template1.mdl", "models/vj_hlr/gibs/bleachbones_pelvis_template1.mdl", "models/vj_hlr/gibs/bleachbones_jawbone1.mdl", "models/vj_hlr/gibs/bleachbones_bskull_template1.mdl", "models/vj_hlr/gibs/bleachbones_ribcage1.mdl", "models/vj_hlr/gibs/bleachbones_riblet1.mdl", "models/vj_hlr/gibs/bleachbones_riblet1.mdl", "models/vj_hlr/gibs/bleachbones_riblet1.mdl"}
--
function ENT:OnCreateDeathCorpse(dmginfo, hitgroup, corpse)
	VJ.HLR_ApplyCorpseSystem(self, corpse, gibstbl, {CollisionSound = gibsCollideSd})
end