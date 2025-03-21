SWEP.Base = "weapon_vj_base"
SWEP.PrintName = "Grenade"
SWEP.Author = "Cpt. Hazama & oteek"
SWEP.Contact = "http://steamcommunity.com/groups/vrejgaming"
SWEP.MadeForNPCsOnly = true

SWEP.WorldModel = "models/vj_hlr/weapons/w_grenade.mdl"
SWEP.HoldType = "grenade"

SWEP.WorldModel_UseCustomPosition = true
SWEP.WorldModel_CustomPositionAngle = Vector(0, 0, 0)
SWEP.WorldModel_CustomPositionOrigin = Vector(-2, 2, -3)
SWEP.WorldModel_CustomPositionBone = "Bip01 R Hand"

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
SWEP.Primary.Sound = {"vj_hlr/gsrc/fx/null.wav"}
SWEP.HasDryFireSound = false

SWEP.PrimaryEffects_SpawnMuzzleFlash = false
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
		local plasma = ents.Create("obj_vj_hlr1_grenade")
		plasma:SetPos(self:GetBulletPos())
		plasma:SetAngles(self:GetOwner():GetAngles())
		plasma:SetOwner(self:GetOwner())
		plasma:Spawn()
		plasma:Activate()
		
		local phys = plasma:GetPhysicsObject()
		if IsValid(phys) then
			phys:SetVelocity(self:GetOwner():CalculateProjectile("Curve", self:GetBulletPos(), self:GetOwner():GetEnemy():GetPos() + self:GetOwner():GetEnemy():OBBCenter(), 1500))
		end
	end
end