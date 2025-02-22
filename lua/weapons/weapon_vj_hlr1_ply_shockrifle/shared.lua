SWEP.Base = "weapon_vj_base"
SWEP.PrintName = "Shock Rifle"
SWEP.Author = "Cpt. Hazama"
SWEP.Contact = "http://steamcommunity.com/groups/vrejgaming"
SWEP.MadeForNPCsOnly = true

SWEP.WorldModel = "models/vj_hlr/weapons/w_shockrifle.mdl"
SWEP.HoldType = "smg"
SWEP.HLR_HoldType = "shockrifle"
SWEP.NPC_HasReloadSound = false

SWEP.WorldModel_UseCustomPosition = true
SWEP.WorldModel_CustomPositionAngle = Vector(0, 180, 0)
SWEP.WorldModel_CustomPositionOrigin = Vector(-1, -12, -1)
SWEP.WorldModel_CustomPositionBone = "Bip01 R Hand"

SWEP.NPC_NextPrimaryFire = 0.16
SWEP.NPC_BulletSpawnAttachment = "muzzle"

SWEP.Primary.Damage = 1
SWEP.Primary.ClipSize = 10
SWEP.Primary.DisableBulletCode = true
SWEP.Primary.Ammo = "357"
SWEP.Primary.Sound = {"vj_hlr/hl1_weapon/shockroach/shock_fire.wav"}
SWEP.Primary.DistantSound = {"vj_hlr/hl1_weapon/shockroach/shock_fire_distant.wav"}
SWEP.HasDryFireSound = false

-- SWEP.PrimaryEffects_SpawnMuzzleFlash = false
SWEP.PrimaryEffects_SpawnShells = false
SWEP.PrimaryEffects_MuzzleParticles = {"vj_hlr_shockroach_muzzle"}
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
			self:SetClip1(self:Clip1() +1)
			self:EmitSound("vj_hlr/hl1_weapon/shockroach/shock_recharge.wav")
			self.PLY_NextReloadT = CurTime() +0.5
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
		local plasma = ents.Create("obj_vj_hlrof_plasma")
		plasma:SetPos(self:GetBulletPos())
		plasma:SetAngles(self:GetOwner():GetAngles())
		plasma:SetOwner(self:GetOwner())
		plasma:Spawn()
		plasma:Activate()
		
		local phys = plasma:GetPhysicsObject()
		if IsValid(phys) then
			phys:SetVelocity(self:GetOwner():CalculateProjectile("Line", self:GetBulletPos(), self:GetOwner():GetEnemy():GetPos() + self:GetOwner():GetEnemy():OBBCenter(), 10000))
		end

		self.PLY_NextReloadT = CurTime() +2.5
	end
end