AddCSLuaFile("shared.lua")
include("shared.lua")
/*-----------------------------------------------
	*** Copyright (c) 2012-2024 by DrVrej, All rights reserved. ***
	No parts of this code or any of its contents may be reproduced, copied, modified or adapted,
	without the prior written consent of the author, unless otherwise indicated for stand-alone materials.
-----------------------------------------------*/
ENT.Model = {"models/vj_hlr/hl1mp/skeleton.mdl"}
ENT.Bleeds = false
ENT.BloodColor = ""
ENT.HasBloodParticle = false
ENT.HasBloodDecal = false
---------------------------------------------------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:HandleGibOnDeath(dmginfo, hitgroup)
        self.HasDeathSounds = false

        self:CreateGibEntity("obj_vj_gib","models/vj_hlr/gibs/abone_template1.mdl",{BloodDecal="",Pos=self:LocalToWorld(Vector(0,0,40))})
        self:CreateGibEntity("obj_vj_gib","models/vj_hlr/gibs/abone_template1.mdl",{BloodDecal="",Pos=self:LocalToWorld(Vector(0,0,20))})
        self:CreateGibEntity("obj_vj_gib","models/vj_hlr/gibs/abone_template1.mdl",{BloodDecal="",Pos=self:LocalToWorld(Vector(0,0,30))})
        self:CreateGibEntity("obj_vj_gib","models/vj_hlr/gibs/abone_template1.mdl",{BloodDecal="",Pos=self:LocalToWorld(Vector(0,0,15))})
        self:CreateGibEntity("obj_vj_gib","models/vj_hlr/gibs/abone_template1.mdl",{BloodDecal="",Pos=self:LocalToWorld(Vector(0,0,35))})
        self:CreateGibEntity("obj_vj_gib","models/vj_hlr/gibs/bleachbones_pelvis_template1.mdl",{BloodDecal="",Pos=self:LocalToWorld(Vector(0,0,35))})
        self:CreateGibEntity("obj_vj_gib","models/vj_hlr/gibs/bleachbones_jawbone1.mdl",{BloodDecal="",Pos=self:LocalToWorld(Vector(0,0,50))})
        self:CreateGibEntity("obj_vj_gib","models/vj_hlr/gibs/bleachbones_bskull_template1.mdl",{BloodDecal="",Pos=self:LocalToWorld(Vector(0,0,55))})
        self:CreateGibEntity("obj_vj_gib","models/vj_hlr/gibs/bleachbones_ribcage1.mdl",{BloodDecal="",Pos=self:LocalToWorld(Vector(0,0,40))})
        self:CreateGibEntity("obj_vj_gib","models/vj_hlr/gibs/bleachbones_riblet1.mdl",{BloodDecal="",Pos=self:LocalToWorld(Vector(0,0,45))})
        self:CreateGibEntity("obj_vj_gib","models/vj_hlr/gibs/bleachbones_riblet1.mdl",{BloodDecal="",Pos=self:LocalToWorld(Vector(0,0,25))})
        self:CreateGibEntity("obj_vj_gib","models/vj_hlr/gibs/bleachbones_riblet1.mdl",{BloodDecal="",Pos=self:LocalToWorld(Vector(0,0,35))})

	return true, {AllowSound = false}
end
---------------------------------------------------------------------------------------------------------------------------------------------
local gibstbl = {"models/vj_hlr/gibs/abone_template1.mdl","models/vj_hlr/gibs/abone_template1.mdl","models/vj_hlr/gibs/abone_template1.mdl","models/vj_hlr/gibs/abone_template1.mdl","models/vj_hlr/gibs/abone_template1.mdl","models/vj_hlr/gibs/bleachbones_pelvis_template1.mdl","models/vj_hlr/gibs/bleachbones_jawbone1.mdl","models/vj_hlr/gibs/bleachbones_bskull_template1.mdl","models/vj_hlr/gibs/bleachbones_ribcage1.mdl","models/vj_hlr/gibs/bleachbones_riblet1.mdl","models/vj_hlr/gibs/bleachbones_riblet1.mdl","models/vj_hlr/gibs/bleachbones_riblet1.mdl"}
--
function ENT:OnCreateDeathCorpse(dmginfo, hitgroup, corpseEnt)
        VJ.HLR_ApplyCorpseSystem(self, corpseEnt, gibstbl)
end