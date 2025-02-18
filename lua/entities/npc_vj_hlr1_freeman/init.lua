AddCSLuaFile("shared.lua")
include("shared.lua")
/*-----------------------------------------------
	*** Copyright (c) 2012-2025 by DrVrej, All rights reserved. ***
	No parts of this code or any of its contents may be reproduced, copied, modified or adapted,
	without the prior written consent of the author, unless otherwise indicated for stand-alone materials.
-----------------------------------------------*/
ENT.Model = "models/vj_hlr/hl1mp/gordon.mdl"
ENT.StartHealth = 200
ENT.HasHealthRegeneration = true
ENT.HealthRegenerationAmount = 2
ENT.HealthRegenerationDelay = VJ.SET(0.5, 0.5)
ENT.HullType = HULL_HUMAN
ENT.ControllerParams = {
    ThirdP_Offset = Vector(0, 0, -15),
    FirstP_Bone = "Bip01 Head",
    FirstP_Offset = Vector(3, 0, 5),
}
---------------------------------------------------------------------------------------------------------------------------------------------
ENT.BloodColor = VJ.BLOOD_COLOR_RED
ENT.BloodParticle = {"vj_hlr_blood_red"}
ENT.BloodDecal = {"VJ_HLR_Blood_Red"}
ENT.HasBloodPool = false

ENT.VJ_NPC_Class = {"CLASS_PLAYER_ALLY"}
ENT.AlliedWithPlayerAllies = true

ENT.PoseParameterLooking_InvertPitch = true

ENT.WeaponInventory_MeleeList = {"weapon_vj_hlr1_ply_crowbar"}

ENT.HasMeleeAttack = false
ENT.AnimTbl_MeleeAttack = "vjges_shoot_crowbar"
ENT.MeleeAttackDamage = 10
ENT.TimeUntilMeleeAttackDamage = false
ENT.NextMeleeAttackTime = VJ.SET(0, 0.25)
ENT.NextAnyAttackTime_Melee = 0.25

ENT.HasGrenadeAttack = false -- we use a separate weapon for that

ENT.Weapon_OcclusionDelay = false
ENT.AnimTbl_CallForHelp = false

ENT.Weapon_IgnoreSpawnMenu = true
-- ENT.Weapon_CanCrouchAttack = false
-- ENT.DisableWeaponReloadAnimation = true

ENT.AnimTbl_WeaponAttackSecondary = "shoot_m203"
ENT.Weapon_SecondaryFireTime = 0.05

ENT.AnimTbl_ShootWhileMovingWalk = ACT_RUN_AIM
ENT.Weapon_StrafeCooldown = VJ.SET(0, 0.2)

ENT.FootstepSoundTimerRun = 0.3
ENT.FootstepSoundTimerWalk = 0.38

ENT.HasDeathAnimation = true
ENT.AnimTbl_Death = {ACT_DIEBACKWARD,ACT_DIEFORWARD,ACT_DIE_GUTSHOT,ACT_DIE_HEADSHOT,ACT_DIESIMPLE}

ENT.SoundTbl_FootStep = {"vj_hlr/pl_step1.wav", "vj_hlr/pl_step2.wav", "vj_hlr/pl_step3.wav", "vj_hlr/pl_step4.wav"}
ENT.SoundTbl_Death = {"vj_hlr/hl1mp_npc/death_flatline1.wav","vj_hlr/hl1mp_npc/death_flatline2.wav"}

ENT.DeathSoundLevel = 60

ENT.DeathSoundPitch = VJ.SET(95, 105)

ENT.WeaponsList = {
	["Close"] = {
		"weapon_vj_hlr1_ply_hgun",
		"weapon_vj_hlr1_ply_shotgun",
		"weapon_vj_hlr1_ply_grenade",
		"weapon_vj_hlr1_ply_squeak",
	},
	["Normal"] = {
		"weapon_vj_hlr1_ply_357",
		"weapon_vj_hlr1_ply_gauss",
		"weapon_vj_hlr1_ply_mp5",
		"weapon_vj_hlr1_ply_pistol",
		"weapon_vj_hlr1_ply_rpg",
	},
	["Far"] = {
		"weapon_vj_hlr1_ply_crossbow",
	},
}

ENT.NextMouthMove = 0
ENT.NextMouthDistance = 0
ENT.NextWeaponSwitchT = 0
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:Init()
	self:SetCollisionBounds(Vector(15, 15, 78), Vector(-15, -15, 0))
	self.NextWeaponSwitchT = CurTime() + math.Rand(2,4)

	for _,category in pairs(self.WeaponsList) do
		for _,wep in pairs(category) do
			self:Give(wep)
		end
	end

	self:DoChangeWeapon(VJ.PICK(self.WeaponsList["Normal"]),true)
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:OnInput(key, activator, caller, data)
	if key == "body" then
		VJ.EmitSound(self, "vj_hlr/fx/bodydrop"..math.random(3, 4)..".wav", 75, 100)
	end
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:OnThinkActive()
	local ent = self:GetEnemy()
	local dist = self.NearestPointToEnemyDistance
	if IsValid(ent) then
		local wep = self:GetActiveWeapon()
		if self.WeaponInventoryStatus == VJ.WEP_INVENTORY_MELEE then return end
		local selectType = false
		if dist > 2200 then
			selectType = "Far"
		elseif dist <= 2200 && dist > 650 then
			selectType = "Normal"
		else
			selectType = "Close"
		end
		
		if selectType && !self:IsBusy() && CurTime() > self.NextWeaponSwitchT && (!IsValid(wep) or (IsValid(wep) && math.random(1, wep:Clip1() > 0 && (wep:Clip1() <= wep:GetMaxClip1() *0.35) && 1 or (selectType == "Close" && 20 or 150)))) == 1 then
			self:DoChangeWeapon(VJ.PICK(self.WeaponsList[selectType]),true)
			wep = self:GetActiveWeapon()
			self.NextWeaponSwitchT = CurTime() + math.Rand(6,math.Round(math.Clamp(wep:Clip1() *0.5,1,wep:Clip1())))
		end
	end
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:SetAnimationTranslations(h)
	local defIdleAim = ACT_IDLE -- ACT_IDLE_ANGRY
	local defWalkAim = ACT_WALK
	local defRunAim = ACT_RUN
	local defFire = ACT_RANGE_ATTACK1
	local defCrouch = ACT_RANGE_ATTACK1_LOW
	local defCrawl = ACT_RUN_CROUCH
	local defReload = ACT_RELOAD

	if self:GetActiveWeapon().HLR_HoldType then -- Allow for more than default hold types
		h = self:GetActiveWeapon().HLR_HoldType
	end

	if h == "crossbow" then
		defIdleAim = VJ.SequenceToActivity(self,"aim_bow")
		defWalkAim = VJ.SequenceToActivity(self,"walk_bow")
		defRunAim = VJ.SequenceToActivity(self,"run_bow")
		defCrouch = VJ.SequenceToActivity(self,"crouch_bow")
		defCrawl = VJ.SequenceToActivity(self,"crawl_bow")
		defFire = "vjges_shoot_bow"
		defReload = "vjges_reload_bow"
	elseif h == "melee" then
		defIdleAim = VJ.SequenceToActivity(self,"aim_crowbar")
		defWalkAim = VJ.SequenceToActivity(self,"walk_crowbar")
		defRunAim = VJ.SequenceToActivity(self,"run_crowbar")
		defCrouch = VJ.SequenceToActivity(self,"crouch_crowbar")
		defCrawl = VJ.SequenceToActivity(self,"crawl_crowbar")
		defFire = "vjges_shoot_crowbar"
		defReload = "vjges_reload_crowbar"
	elseif h == "ar2" then
		defIdleAim = VJ.SequenceToActivity(self,"aim_gauss")
		defWalkAim = VJ.SequenceToActivity(self,"walk_gauss")
		defRunAim = VJ.SequenceToActivity(self,"run_gauss")
		defCrouch = VJ.SequenceToActivity(self,"crouch_gauss")
		defCrawl = VJ.SequenceToActivity(self,"crawl_gauss")
		defFire = "vjges_shoot_gauss"
		defReload = "vjges_reload_gauss"
	elseif h == "physgun" then
		defIdleAim = VJ.SequenceToActivity(self,"aim_hive")
		defWalkAim = VJ.SequenceToActivity(self,"walk_hive")
		defRunAim = VJ.SequenceToActivity(self,"run_hive")
		defCrouch = VJ.SequenceToActivity(self,"crouch_hive")
		defCrawl = VJ.SequenceToActivity(self,"crawl_hive")
		defFire = "vjges_shoot_hive"
		defReload = "vjges_reload_hive"
	elseif h == "smg" then
		defIdleAim = VJ.SequenceToActivity(self,"aim_mp5")
		defWalkAim = VJ.SequenceToActivity(self,"walk_mp5")
		defRunAim = VJ.SequenceToActivity(self,"run_mp5")
		defCrouch = VJ.SequenceToActivity(self,"crouch_mp5")
		defCrawl = VJ.SequenceToActivity(self,"crawl_mp5")
		defFire = "vjges_shoot_mp5"
		defReload = "vjges_reload_mp5"
	elseif h == "pistol" then
		defIdleAim = VJ.SequenceToActivity(self,"aim_onehanded")
		defWalkAim = VJ.SequenceToActivity(self,"walk_onehanded")
		defRunAim = VJ.SequenceToActivity(self,"run_onehanded")
		defCrouch = VJ.SequenceToActivity(self,"crouch_onehanded")
		defCrawl = VJ.SequenceToActivity(self,"crawl_onehanded")
		defFire = "vjges_shoot_onehanded"
		defReload = "vjges_reload_onehanded"
	elseif h == "revolver" then
		defIdleAim = VJ.SequenceToActivity(self,"aim_python")
		defWalkAim = VJ.SequenceToActivity(self,"walk_python")
		defRunAim = VJ.SequenceToActivity(self,"run_python")
		defCrouch = VJ.SequenceToActivity(self,"crouch_python")
		defCrawl = VJ.SequenceToActivity(self,"crawl_python")
		defFire = "vjges_shoot_python"
		defReload = "vjges_reload_python"
	elseif h == "rpg" then
		defIdleAim = VJ.SequenceToActivity(self,"aim_rpg")
		defWalkAim = VJ.SequenceToActivity(self,"walk_rpg")
		defRunAim = VJ.SequenceToActivity(self,"run_rpg")
		defCrouch = VJ.SequenceToActivity(self,"crouch_rpg")
		defCrawl = VJ.SequenceToActivity(self,"crawl_rpg")
		defFire = "vjges_shoot_rpg"
		defReload = "vjges_reload_rpg"
	elseif h == "shotgun" then
		defIdleAim = VJ.SequenceToActivity(self,"aim_shotgun")
		defWalkAim = VJ.SequenceToActivity(self,"walk_shotgun")
		defRunAim = VJ.SequenceToActivity(self,"run_shotgun")
		defCrouch = VJ.SequenceToActivity(self,"crouch_shotgun")
		defCrawl = VJ.SequenceToActivity(self,"crawl_shotgun")
		defFire = "vjges_shoot_shotgun"
		defReload = "vjges_reload_shotgun"
	elseif h == "slam" then
		defIdleAim = VJ.SequenceToActivity(self,"aim_squeak")
		defWalkAim = VJ.SequenceToActivity(self,"walk_squeak")
		defRunAim = VJ.SequenceToActivity(self,"run_squeak")
		defCrouch = VJ.SequenceToActivity(self,"crouch_squeak")
		defCrawl = VJ.SequenceToActivity(self,"crawl_squeak")
		defFire = "vjges_shoot_squeak"
		defReload = "vjges_reload_squeak"
	elseif h == "grenade" then
		defIdleAim = VJ.SequenceToActivity(self,"aim_crowbar")
		defWalkAim = VJ.SequenceToActivity(self,"walk_crowbar")
		defRunAim = VJ.SequenceToActivity(self,"run_crowbar")
		defCrouch = VJ.SequenceToActivity(self,"crouch_crowbar")
		defCrawl = VJ.SequenceToActivity(self,"crawl_crowbar")
		defFire = "vjges_shoot_gren"
		defReload = "vjges_reload_gren"
	elseif h == "saw" then
		defIdleAim = VJ.SequenceToActivity(self,"aim_saw")
		defWalkAim = VJ.SequenceToActivity(self,"walk_saw")
		defRunAim = VJ.SequenceToActivity(self,"run_saw")
		defCrouch = VJ.SequenceToActivity(self,"crouch_saw")
		defCrawl = VJ.SequenceToActivity(self,"crawl_saw")
		defFire = "vjges_shoot_saw"
		defReload = "vjges_reload_saw"
	elseif h == "sniper" then
		defIdleAim = VJ.SequenceToActivity(self,"aim_sniper")
		defWalkAim = VJ.SequenceToActivity(self,"walk_sniper")
		defRunAim = VJ.SequenceToActivity(self,"run_sniper")
		defCrouch = VJ.SequenceToActivity(self,"crouch_sniper")
		defCrawl = VJ.SequenceToActivity(self,"crawl_sniper")
		defFire = "vjges_shoot_sniper"
		defReload = "vjges_reload_sniper"
	elseif h == "m16" then
		defIdleAim = VJ.SequenceToActivity(self,"aim_m16")
		defWalkAim = VJ.SequenceToActivity(self,"walk_m16")
		defRunAim = VJ.SequenceToActivity(self,"run_m16")
		defCrouch = VJ.SequenceToActivity(self,"crouch_m16")
		defCrawl = VJ.SequenceToActivity(self,"crawl_m16")
		defFire = "vjges_shoot_m16"
		defReload = "vjges_reload_m16"
	elseif h == "shockrifle" then
		defIdleAim = VJ.SequenceToActivity(self,"aim_m16")
		defWalkAim = VJ.SequenceToActivity(self,"walk_m16")
		defRunAim = VJ.SequenceToActivity(self,"run_m16")
		defCrouch = VJ.SequenceToActivity(self,"crouch_m16")
		defCrawl = VJ.SequenceToActivity(self,"crawl_m16")
		defFire = "vjges_shoot_m16"
		defReload = "vjges_reload_null"
	elseif h == "minigun" then
		defIdleAim = VJ.SequenceToActivity(self,"aim_minigun")
		defWalkAim = VJ.SequenceToActivity(self,"walk_minigun")
		defRunAim = VJ.SequenceToActivity(self,"run_minigun")
		defCrouch = VJ.SequenceToActivity(self,"crouch_minigun")
		defCrawl = VJ.SequenceToActivity(self,"crawl_minigun")
		defFire = "vjges_shoot_minigun"
		defReload = "vjges_reload_minigun"
	end

	self.AnimationTranslations[ACT_IDLE] = defIdleAim
	self.AnimationTranslations[ACT_IDLE_ANGRY] = defIdleAim
	self.AnimationTranslations[ACT_WALK] = defWalkAim
	self.AnimationTranslations[ACT_WALK_AIM] = defWalkAim
	self.AnimationTranslations[ACT_RUN] = defRunAim
	self.AnimationTranslations[ACT_RUN_AIM] = defRunAim
	self.AnimationTranslations[ACT_RANGE_ATTACK1] = defIdleAim
	self.AnimationTranslations[ACT_RANGE_ATTACK1_LOW] = defCrouch
	self.AnimationTranslations[ACT_COVER_LOW] = defCrouch
	self.AnimationTranslations[ACT_WALK_CROUCH] = defCrawl
	self.AnimationTranslations[ACT_RUN_CROUCH] = defCrawl
	self.AnimationTranslations[ACT_GESTURE_RANGE_ATTACK1] = defFire
	self.AnimationTranslations[ACT_GESTURE_RANGE_ATTACK2] = defFire
	self.AnimationTranslations[ACT_RELOAD] = defReload
	self.AnimationTranslations[ACT_RELOAD_LOW] = defReload
	return true
end
---------------------------------------------------------------------------------------------------------------------------------------------
local vec = Vector(0, 0, 0)
--
function ENT:OnDamaged(dmginfo, hitgroup, status)
	if status == "Initial" then
		self.Bleeds = true
		if hitgroup == HITGROUP_GEAR && dmginfo:GetDamagePosition() != vec then
			self.Bleeds = false
			local rico = EffectData()
			rico:SetOrigin(dmginfo:GetDamagePosition())
			rico:SetScale(4)
			rico:SetMagnitude(math.random(1, 2)) -- Effect type | 1 = Animated | 2 = Basic
			util.Effect("VJ_HLR_Rico", rico)
		end
	end
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:OnThink()
	if CurTime() < self.NextMouthMove then
		if self.NextMouthDistance == 0 then
			self.NextMouthDistance = math.random(10, 70)
		else
			self.NextMouthDistance = 0
		end
		self:SetPoseParameter("m", self.NextMouthDistance)
	else
		self:SetPoseParameter("m", 0)
	end
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:OnCreateSound(sdData, sdFile)
	self.NextMouthMove = CurTime() + SoundDuration(sdFile)
end
---------------------------------------------------------------------------------------------------------------------------------------------
local colorRed = VJ.Color2Byte(Color(130, 19, 10))
--
function ENT:HandleGibOnDeath(dmginfo, hitgroup)
	self.HasDeathSounds = false
	if self.HasGibOnDeathEffects then
		local effectData = EffectData()
		effectData:SetOrigin(self:GetPos() + self:OBBCenter())
		effectData:SetColor(colorRed)
		effectData:SetScale(120)
		util.Effect("VJ_Blood1", effectData)
		effectData:SetScale(8)
		effectData:SetFlags(3)
		effectData:SetColor(0)
		util.Effect("bloodspray", effectData)
		util.Effect("bloodspray", effectData)
	end
	
	self:CreateGibEntity("obj_vj_gib","models/vj_hlr/gibs/flesh1.mdl",{CollisionDecal="VJ_HLR_Blood_Red",Pos=self:LocalToWorld(Vector(0,0,40))})
	self:CreateGibEntity("obj_vj_gib","models/vj_hlr/gibs/flesh2.mdl",{CollisionDecal="VJ_HLR_Blood_Red",Pos=self:LocalToWorld(Vector(0,0,40))})
	self:CreateGibEntity("obj_vj_gib","models/vj_hlr/gibs/flesh3.mdl",{CollisionDecal="VJ_HLR_Blood_Red",Pos=self:LocalToWorld(Vector(0,0,40))})
	self:CreateGibEntity("obj_vj_gib","models/vj_hlr/gibs/flesh4.mdl",{CollisionDecal="VJ_HLR_Blood_Red",Pos=self:LocalToWorld(Vector(0,0,40))})
	self:CreateGibEntity("obj_vj_gib","models/vj_hlr/gibs/hgib_b_bone.mdl",{CollisionDecal="VJ_HLR_Blood_Red",Pos=self:LocalToWorld(Vector(0,0,50))})
	self:CreateGibEntity("obj_vj_gib","models/vj_hlr/gibs/hgib_b_gib.mdl",{CollisionDecal="VJ_HLR_Blood_Red",Pos=self:LocalToWorld(Vector(0,0,40))})
	self:CreateGibEntity("obj_vj_gib","models/vj_hlr/gibs/hgib_guts.mdl",{CollisionDecal="VJ_HLR_Blood_Red",Pos=self:LocalToWorld(Vector(0,0,40))})
	self:CreateGibEntity("obj_vj_gib","models/vj_hlr/gibs/hgib_hmeat.mdl",{CollisionDecal="VJ_HLR_Blood_Red",Pos=self:LocalToWorld(Vector(0,0,45))})
	self:CreateGibEntity("obj_vj_gib","models/vj_hlr/gibs/hgib_lung.mdl",{CollisionDecal="VJ_HLR_Blood_Red",Pos=self:LocalToWorld(Vector(0,0,45))})
	self:CreateGibEntity("obj_vj_gib","models/vj_hlr/gibs/hgib_skull.mdl",{CollisionDecal="VJ_HLR_Blood_Red",Pos=self:LocalToWorld(Vector(0,0,60))})
	self:CreateGibEntity("obj_vj_gib","models/vj_hlr/gibs/hgib_legbone.mdl",{CollisionDecal="VJ_HLR_Blood_Red",Pos=self:LocalToWorld(Vector(0,0,15))})
	self:PlaySoundSystem("Gib", "vj_base/gib/splat.wav")
	return true, {AllowSound = false}
end
---------------------------------------------------------------------------------------------------------------------------------------------
local transDeath = {
	[HITGROUP_HEAD] = {ACT_DIE_HEADSHOT},
	[HITGROUP_STOMACH] = {ACT_DIE_GUTSHOT},
}
local defDeath = {ACT_DIESIMPLE, ACT_DIEFORWARD, ACT_DIEBACKWARD}
--
function ENT:OnDeath(dmginfo, hitgroup, status)
	if status == "DeathAnim" then
		self.AnimTbl_Death = transDeath[hitgroup] or defDeath
		self:DeathWeaponDrop(dmginfo, hitgroup)
		if IsValid(self:GetActiveWeapon()) then self:GetActiveWeapon():Remove() end
	end
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:OnCreateDeathCorpse(dmginfo, hitgroup, corpseEnt)
	VJ.HLR_ApplyCorpseSystem(self, corpseEnt)
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:OnFootstepSound(moveType, sdFile)
	if moveType == "Walk" then
		self.FootstepSoundLevel = 52
	elseif moveType == "Run" then
		self.FootstepSoundLevel = 70
	end
end