SWEP.Base = "weapon_vj_base"
SWEP.PrintName = "Spore Launcher"
SWEP.Author = "Cpt. Hazama"
SWEP.Contact = "http://steamcommunity.com/groups/vrejgaming"
SWEP.Purpose = "This weapon is made for Players and NPCs"
SWEP.Instructions = "Controls are like a regular weapon."
SWEP.MadeForNPCsOnly = true

SWEP.WorldModel = "models/vj_hlr/weapons/w_spore_launcher.mdl"
SWEP.HoldType = "rpg"

SWEP.WorldModel_UseCustomPosition = true
SWEP.WorldModel_CustomPositionAngle = Vector(0,0,0)
SWEP.WorldModel_CustomPositionOrigin = Vector(0,5,0)
SWEP.WorldModel_CustomPositionBone = "Bip01 R Hand"

SWEP.NPC_NextPrimaryFire = 1
SWEP.NPC_FiringDistanceScale = 0.65
SWEP.NPC_ReloadSound			= {"vj_hlr/hl1_weapon/sporelauncher/splauncher_reload.wav"}

SWEP.Primary.Damage = 1
SWEP.Primary.ClipSize = 6
SWEP.Primary.DisableBulletCode = true
SWEP.Primary.Ammo = "357"
SWEP.Primary.TracerType = "VJ_HLR_Tracer"
SWEP.Primary.Sound = {"vj_hlr/hl1_weapon/sporelauncher/splauncher_fire.wav"}
SWEP.Primary.DistantSound = {"vj_hlr/hl1_weapon/sporelauncher/splauncher_fire_distant.wav"}

SWEP.PrimaryEffects_SpawnMuzzleFlash = false
SWEP.PrimaryEffects_SpawnShells = false
---------------------------------------------------------------------------------------------------------------------------------------------
function SWEP:Init()
	self:SetModelScale(0.5)
end
---------------------------------------------------------------------------------------------------------------------------------------------
function SWEP:OnGetBulletPos()
	return self:GetAttachment(1).Pos
end
---------------------------------------------------------------------------------------------------------------------------------------------
function SWEP:PrimaryAttackEffects(owner)
	return
end
---------------------------------------------------------------------------------------------------------------------------------------------
function SWEP:OnPrimaryAttack(status, statusData)
	if status == "Initial" then
		if CLIENT then return end
		local plasma = ents.Create("obj_vj_hlrof_grenade_spore")
		plasma:SetPos(self:GetBulletPos())
		plasma:SetAngles(self:GetOwner():GetAngles())
		plasma:SetOwner(self:GetOwner())
		plasma:Spawn()
		plasma:Activate()
		
		local phys = plasma:GetPhysicsObject()
		if IsValid(phys) then
			phys:SetVelocity(self:GetOwner():CalculateProjectile("Line", self:GetBulletPos(), self:GetOwner():GetEnemy():GetPos() + self:GetOwner():GetEnemy():OBBCenter(), 1500))
		end
	end
end