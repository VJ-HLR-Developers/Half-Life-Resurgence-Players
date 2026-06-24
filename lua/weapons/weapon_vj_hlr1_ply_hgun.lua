AddCSLuaFile()

SWEP.Base = "weapon_vj_base"
SWEP.PrintName = "Hive Gun"
SWEP.Author = "Cpt. Hazama"
SWEP.Contact = "http://steamcommunity.com/groups/vrejgaming"
SWEP.MadeForNPCsOnly = true

SWEP.WorldModel = "models/vj_hlr/weapons/w_hgun.mdl"
SWEP.HoldType = "physgun"
SWEP.NPC_HasReloadSound = false

SWEP.WorldModel_UseCustomPosition = true
SWEP.WorldModel_CustomPositionAngle = Vector(0, 180, 0)
SWEP.WorldModel_CustomPositionOrigin = Vector(-1, -6, -3)
SWEP.WorldModel_CustomPositionBone = "Bip01 R Hand"

SWEP.NPC_NextPrimaryFire = 0.165
SWEP.NPC_FiringDistanceScale = 0.5
SWEP.NPC_BulletSpawnAttachment = "muzzle"

SWEP.Primary.Damage = 1
SWEP.Primary.ClipSize = 8
SWEP.Primary.TakeAmmo = 0
SWEP.Primary.DisableBulletCode = true
SWEP.Primary.Ammo = "357"
SWEP.Primary.Sound = {"vj_hlr/gsrc/npc/agrunt/ag_fire1.wav", "vj_hlr/gsrc/npc/agrunt/ag_fire2.wav", "vj_hlr/gsrc/npc/agrunt/ag_fire3.wav"}
SWEP.HasDryFireSound = false

SWEP.PrimaryEffects_SpawnMuzzleFlash = false
SWEP.PrimaryEffects_SpawnShells = false
SWEP.PrimaryEffects_MuzzleFlash = false
---------------------------------------------------------------------------------------------------------------------------------------------
function SWEP:Init()
	self:SetModelScale(0.5)
	self.PLY_NextReloadT = CurTime()
end
---------------------------------------------------------------------------------------------------------------------------------------------
function SWEP:OnGetBulletPos()
	local owner = self:GetOwner()
	local att = owner:GetAttachment(2)

	return att.Pos +att.Ang:Forward() *20
end
---------------------------------------------------------------------------------------------------------------------------------------------
function SWEP:PrimaryAttackEffects(owner)
	local muz = ents.Create("env_sprite")
	muz:SetKeyValue("model", "vj_hl/sprites/muz4.vmt")
	muz:SetKeyValue("scale", "" .. math.Rand(0.3, 0.5))
	muz:SetKeyValue("GlowProxySize", "2.0") -- Size of the glow to be rendered for visibility testing.
	muz:SetKeyValue("HDRColorScale", "1.0")
	muz:SetKeyValue("renderfx", "14")
	muz:SetKeyValue("rendermode", "3") -- Set the render mode to "3" (Glow)
	muz:SetKeyValue("renderamt", "255") -- Transparency
	muz:SetKeyValue("disablereceiveshadows", "0") -- Disable receiving shadows
	muz:SetKeyValue("framerate", "10.0") -- Rate at which the sprite should animate, if at all.
	muz:SetKeyValue("spawnflags", "0")
	muz:SetPos(self:OnGetBulletPos())
	-- muz:SetParent(self)
	-- muz:Fire("SetParentAttachment", self.PrimaryEffects_MuzzleAttachment)
	muz:SetAngles(Angle(math.random(-100, 100), math.random(-100, 100), math.random(-100, 100)))
	muz:Spawn()
	muz:Activate()
	muz:Fire("Kill", "", 0.08)
	self.BaseClass.PrimaryAttackEffects(self, owner)
end
---------------------------------------------------------------------------------------------------------------------------------------------
function SWEP:NPC_Reload()
	self:SetClip1(self.LastClip)
	local owner = self:GetOwner()
	owner:SetWeaponState()
	owner.NextChaseTime = 0
end
---------------------------------------------------------------------------------------------------------------------------------------------
function SWEP:OnThink()
	if SERVER then
		local owner = self:GetOwner()
		self.LastClip = self:Clip1()
		if CurTime() > self.PLY_NextReloadT && self:Clip1() < self:GetMaxClip1() then
			self:SetClip1(self:Clip1() + 1)
			self.PLY_NextReloadT = CurTime() + 1
			owner:SetWeaponState(VJ.WEP_STATE_RELOADING)
		elseif self:Clip1() >= self:GetMaxClip1() then
			owner:SetWeaponState()
		end
	end
end
---------------------------------------------------------------------------------------------------------------------------------------------
function SWEP:OnPrimaryAttack(status, statusData)
	if status == "Init" then
		if CLIENT then return end
		local hornet = ents.Create("obj_vj_hlr1_hornet")
		local spawnpos = self:GetBulletPos()
		hornet:SetPos(spawnpos)
		hornet:SetAngles(self:GetOwner():GetAngles())
		hornet:SetOwner(self:GetOwner())
		hornet:Activate()
		hornet:Spawn()

		self.PLY_NextReloadT = CurTime() + 1

		local phys = hornet:GetPhysicsObject()
		local ownerEne = self:GetOwner():GetEnemy()
		if IsValid(phys) && IsValid(ownerEne) then
			hornet.Track_Ent = ownerEne
			phys:ApplyForceCenter(VJ.CalculateTrajectory(hornet, hornet.Track_Ent, "Line", spawnpos, ownerEne:GetPos() + ownerEne:OBBCenter(), 4000) + VectorRand(-30, 30))
		end
	end
end