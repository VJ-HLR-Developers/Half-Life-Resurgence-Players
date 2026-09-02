AddCSLuaFile()

SWEP.Base = "weapon_vj_base"
SWEP.PrintName = "Grenade"
SWEP.Author = "Cpt. Hazama & oteek"
SWEP.Contact = "http://steamcommunity.com/groups/vrejgaming"
SWEP.MadeForNPCsOnly = true

SWEP.WorldModel = "models/vj_hlr/weapons/w_grenade.mdl"
SWEP.HoldType = "grenade"

SWEP.WorldModelOffsetParams = {
	Enabled = true,
	Bone = "Bip01 R Hand",
	Pos = Vector(2, 2, -3),
	Ang = Angle(0, 0, 0)
}

SWEP.NPC_NextPrimaryFire = 2.5
SWEP.NPC_TimeUntilFire = 0.8
SWEP.NPC_FiringDistanceScale = 0.65
SWEP.NPC_HasReloadSound = false

SWEP.Primary.Damage = 1
SWEP.Primary.ClipSize = 10
SWEP.Primary.TakeAmmo = 0
SWEP.Primary.DisableBulletCode = true
SWEP.Primary.Ammo = "grenade"
SWEP.Primary.TracerType = "VJ_HLR_Tracer"
SWEP.Primary.Sound = "vj_hlr/null.wav"
SWEP.HasDryFireSound = false

SWEP.PrimaryEffects_MuzzleFlash = false
SWEP.PrimaryEffects_SpawnShells = false
---------------------------------------------------------------------------------------------------------------------------------------------
function SWEP:Init()
	self:SetModelScale(0.5)
end
---------------------------------------------------------------------------------------------------------------------------------------------
function SWEP:OnGetBulletPos()
	local owner = self:GetOwner()

	return owner:GetPos() + owner:GetUp() + Vector(0, 0, 50)
end
---------------------------------------------------------------------------------------------------------------------------------------------
function SWEP:PrimaryAttackEffects(owner)
	return
end
---------------------------------------------------------------------------------------------------------------------------------------------
function SWEP:OnPrimaryAttack(status, statusData)
	if status == "Init" then
		if CLIENT then return end
		local owner = self:GetOwner()
		local grenade = ents.Create("obj_vj_hlr1_grenade")
		local spawnpos = self:GetBulletPos()
		grenade:SetPos(spawnpos)
		grenade:SetAngles(owner:GetAngles())
		grenade:SetOwner(owner)
		grenade:Spawn()
		grenade:Activate()

		local phys = grenade:GetPhysicsObject()
		local ownerEne = owner:GetEnemy()
		if IsValid(phys) && IsValid(ownerEne) then
			phys:SetVelocity(VJ.CalculateTrajectory(owner, ownerEne, "CurveOld", spawnpos, ownerEne:GetPos() + ownerEne:OBBCenter(), 1500))
		end
	end
end