AddCSLuaFile()

SWEP.Base = "weapon_vj_base"
SWEP.PrintName = "Knife"
SWEP.Author = "Cpt. Hazama"
SWEP.Contact = "http://steamcommunity.com/groups/vrejgaming"
SWEP.MadeForNPCsOnly = true
SWEP.IsMeleeWeapon = true

SWEP.WorldModel = "models/vj_hlr/weapons/w_knife.mdl"
SWEP.HoldType = "melee"

SWEP.NPC_NextPrimaryFire = 0.2

SWEP.WorldModelOffsetParams = {
	Enabled = true,
	Bone = "Bip01 R Hand",
	Pos = Vector(4.914, 1, 6.193),
	Ang = Angle(-20, 180, -180)
}

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
function SWEP:OnGetBulletPos()
	local owner = self:GetOwner()
	return owner:EyePos()
end
---------------------------------------------------------------------------------------------------------------------------------------------
function SWEP:CustomOnRemove()
	local owner = self:GetOwner()
	if IsValid(owner) then
		owner.SoundTbl_MeleeAttack = {}
		owner.SoundTbl_MeleeAttackMiss = {}
	end
end