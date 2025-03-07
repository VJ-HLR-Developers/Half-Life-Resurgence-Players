SWEP.Base = "weapon_vj_base"
SWEP.PrintName = "Gauss Cannon"
SWEP.Author = "Cpt. Hazama"
SWEP.Contact = "http://steamcommunity.com/groups/vrejgaming"
SWEP.MadeForNPCsOnly = true

SWEP.WorldModel = "models/vj_hlr/weapons/w_gauss.mdl"
SWEP.HoldType = "ar2"

SWEP.WorldModel_UseCustomPosition = true
SWEP.WorldModel_CustomPositionAngle = Vector(0, 180, 0)
SWEP.WorldModel_CustomPositionOrigin = Vector(1, -6, 2)
SWEP.WorldModel_CustomPositionBone = "Bip01 R Hand"

SWEP.NPC_NextPrimaryFire = 0.18
SWEP.NPC_FiringDistanceScale = 2.5
SWEP.NPC_BulletSpawnAttachment = "muzzle"
SWEP.NPC_ReloadSound = {"vj_hlr/gsrc/fx/null.wav"}

SWEP.Primary.Damage = 1
SWEP.Primary.ClipSize = 20
SWEP.Primary.TakeAmmo = 0
SWEP.Primary.DisableBulletCode = true
SWEP.Primary.Ammo = "357"
SWEP.Primary.Sound = {"vj_hlr/gsrc/wep/gauss/gauss2.wav"}
SWEP.Primary.DistantSound = {"vj_hlr/gsrc/wep/gauss/distant.wav"}

SWEP.PrimaryEffects_SpawnMuzzleFlash = false
SWEP.PrimaryEffects_SpawnShells = false
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

		local owner = self:GetOwner()
		local enemy = owner:GetEnemy()

		local startpos = self:GetBulletPos()
		local tr = util.TraceLine({
			start = startpos,
			endpos = enemy:GetPos() +enemy:OBBCenter() + VectorRand(-10, 10),
			filter = self
		})
		local hitpos = tr.HitPos
		
		local elec = EffectData()
		elec:SetStart(startpos)
		elec:SetOrigin(hitpos)
		elec:SetEntity(self)
		elec:SetAttachment(1)
		util.Effect("VJ_HLR_Tau",elec)
		
		VJ.ApplyRadiusDamage(owner, self, hitpos, 30, 20, DMG_ENERGYBEAM, true, false, {Force=20})
	end
end