SWEP.Base = "weapon_vj_base"
SWEP.PrintName = "Knife"
SWEP.Author = "Cpt. Hazama"
SWEP.Contact = "http://steamcommunity.com/groups/vrejgaming"
SWEP.MadeForNPCsOnly = true
SWEP.IsMeleeWeapon = true

SWEP.WorldModel = "models/vj_hlr/weapons/w_knife.mdl"
SWEP.HoldType = "melee"

SWEP.NPC_NextPrimaryFire = 0.2

SWEP.WorldModel_UseCustomPosition = true
SWEP.WorldModel_CustomPositionAngle = Vector(-20, 180, 180)
SWEP.WorldModel_CustomPositionOrigin = Vector(-1, -2.5, -7.5)
SWEP.WorldModel_CustomPositionBone = "Bip01 R Hand"

SWEP.Primary.Damage = 10
---------------------------------------------------------------------------------------------------------------------------------------------
function SWEP:Init()
	self:SetModelScale(0.5)
end
---------------------------------------------------------------------------------------------------------------------------------------------
function SWEP:OnDeploy()
	local owner = self:GetOwner()
	if IsValid(owner) then
		owner.SoundTbl_MeleeAttack = {"vj_hlr/gsrc/wep/knife/knife_hit_flesh1.wav", "vj_hlr/gsrc/wep/knife/knife_hit_flesh2.wav"}
		owner.SoundTbl_MeleeAttackMiss = {"vj_hlr/gsrc/wep/knife/knife1.wav", "vj_hlr/gsrc/wep/knife/knife2.wav", "vj_hlr/gsrc/wep/knife/knife3.wav"}
	end
end
---------------------------------------------------------------------------------------------------------------------------------------------
function SWEP:OnHolster(newWep)
	self:CustomOnRemove()
end
---------------------------------------------------------------------------------------------------------------------------------------------
function SWEP:CustomOnRemove()
	local owner = self:GetOwner()
	if IsValid(owner) then
		owner.SoundTbl_MeleeAttack = {}
		owner.SoundTbl_MeleeAttackMiss = {}
	end
end