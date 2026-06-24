SWEP.Base = "weapon_vj_base"
SWEP.PrintName = "Crossbow"
SWEP.Author = "Cpt. Hazama"
SWEP.Contact = "http://steamcommunity.com/groups/vrejgaming"
SWEP.MadeForNPCsOnly = true

SWEP.WorldModel = "models/vj_hlr/weapons/w_crossbow.mdl"
SWEP.HoldType = "crossbow"

SWEP.WorldModel_UseCustomPosition = true
SWEP.WorldModel_CustomPositionAngle = Vector(0, 180, 0)
SWEP.WorldModel_CustomPositionOrigin = Vector(1, -12, 0.5)
SWEP.WorldModel_CustomPositionBone = "Bip01 R Hand"

SWEP.NPC_NextPrimaryFire = 1.25
SWEP.NPC_FiringDistanceScale = 2.5
SWEP.NPC_BulletSpawnAttachment = "muzzle"
SWEP.NPC_ReloadSound = "vj_hlr/gsrc/wep/crossbow/xbow_reload1.wav"

SWEP.Primary.Damage = 1
SWEP.Primary.ClipSize = 5
SWEP.Primary.DisableBulletCode = true
SWEP.Primary.Ammo = "357"
SWEP.Primary.Sound = "vj_hlr/gsrc/wep/crossbow/xbow_fire1.wav"
SWEP.Primary.DistantSound = "vj_hlr/gsrc/wep/crossbow/xbow_fire1_distant.wav"

SWEP.PrimaryEffects_SpawnMuzzleFlash = false
SWEP.PrimaryEffects_SpawnShells = false

SWEP.DryFireSound = "vj_hlr/gsrc/wep/dryfire1.wav"
---------------------------------------------------------------------------------------------------------------------------------------------
function SWEP:Init()
	self:SetModelScale(0.5)
end
---------------------------------------------------------------------------------------------------------------------------------------------
function SWEP:PrimaryAttackEffects(owner)
	return
end
---------------------------------------------------------------------------------------------------------------------------------------------
function SWEP:OnPrimaryAttack(status, statusData)
	if status == "Init" then
		if CLIENT then return end
		local bolt = ents.Create("obj_vj_hlr1_crossbowbolt")
		local spawnpos = self:GetBulletPos()
		bolt:SetPos(spawnpos)
		bolt:SetAngles(self:GetOwner():GetAngles())
		bolt:SetOwner(self:GetOwner())
		bolt:Activate()
		bolt:Spawn()

		local phys = bolt:GetPhysicsObject()
		local ownerEne = self:GetOwner():GetEnemy()
		if IsValid(phys) && IsValid(ownerEne) then
			phys:ApplyForceCenter(VJ.CalculateTrajectory(bolt, ownerEne, "Line", spawnpos, ownerEne:GetPos() + ownerEne:OBBCenter(), 4000) + VectorRand(-30, 30))
		end
	end
end