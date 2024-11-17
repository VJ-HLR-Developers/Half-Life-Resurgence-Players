SWEP.Base = "weapon_vj_base"
SWEP.PrintName = "Snark"
SWEP.Author = "Cpt. Hazama & oteek"
SWEP.Contact = "http://steamcommunity.com/groups/vrejgaming"
SWEP.Purpose = "This weapon is made for Players and NPCs"
SWEP.Instructions = "Controls are like a regular weapon."
SWEP.MadeForNPCsOnly = true

SWEP.WorldModel = "models/vj_hlr/weapons/w_snark.mdl"
SWEP.HoldType = "slam"

SWEP.ThrowableNPC = "npc_vj_hlr1_snark"

SWEP.WorldModel_UseCustomPosition = true
SWEP.WorldModel_CustomPositionAngle = Vector(-40,180,0)
SWEP.WorldModel_CustomPositionOrigin = Vector(2,-1,0)
SWEP.WorldModel_CustomPositionBone = "Bip01 R Hand"

SWEP.NPC_NextPrimaryFire = 0.25
SWEP.NPC_TimeUntilFire = 0.5
SWEP.NPC_FiringDistanceScale = 0.65
SWEP.NPC_HasReloadSound = false

SWEP.Primary.Damage = 1
SWEP.Primary.ClipSize = 5
SWEP.Primary.TakeAmmo = 0 -- How much ammo should it take from the clip after each shot? | 0 = Unlimited clip
SWEP.Primary.DisableBulletCode = true
SWEP.Primary.Ammo = "grenade"
SWEP.Primary.TracerType = "VJ_HLR_Tracer"
SWEP.Primary.Sound = {"vj_hlr/fx/null.wav"}
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
	return owner:EyePos() + owner:GetForward()*15
end
---------------------------------------------------------------------------------------------------------------------------------------------
function SWEP:PrimaryAttackEffects(owner)
	return
end
---------------------------------------------------------------------------------------------------------------------------------------------
function SWEP:OnPrimaryAttack(status, statusData)
	if status == "Initial" then
		if CLIENT then return end
		local owner = self.Owner
		local snark = ents.Create(self.ThrowableNPC)
		snark:SetPos(self:GetBulletPos())
		snark:SetAngles(owner:GetAngles())
		snark:SetOwner(owner)
		snark:Spawn()
		snark.VJ_NPC_Class = owner.VJ_NPC_Class
		snark.FriendsWithAllPlayerAllies = owner.FriendsWithAllPlayerAllies
		table.insert(snark.VJ_AddCertainEntityAsFriendly,owner)
		table.insert(owner.VJ_AddCertainEntityAsFriendly,snark)
		
		snark:SetGroundEntity(NULL)
		snark:SetLocalVelocity(((owner:GetEnemy():GetPos() +owner:GetEnemy():OBBCenter()) -snark:GetPos()):GetNormalized() *500)
	end
end