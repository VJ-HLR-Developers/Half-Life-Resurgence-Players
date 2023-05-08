SWEP.Base = "weapon_vj_base"
SWEP.PrintName = "RPG"
SWEP.Author = "Cpt. Hazama"
SWEP.Contact = "http://steamcommunity.com/groups/vrejgaming"
SWEP.Purpose = "This weapon is made for Players and NPCs"
SWEP.Instructions = "Controls are like a regular weapon."
SWEP.MadeForNPCsOnly = true

SWEP.WorldModel = "models/vj_hlr/weapons/w_rpg.mdl"
SWEP.HoldType = "rpg"
SWEP.NPC_HasReloadSound = false

SWEP.WorldModel_UseCustomPosition = true
SWEP.WorldModel_CustomPositionAngle = Vector(0, 0, 0)
SWEP.WorldModel_CustomPositionOrigin = Vector(-6, 3, -1)
SWEP.WorldModel_CustomPositionBone = "Bip01 R Hand"

SWEP.NPC_NextPrimaryFire = 1

SWEP.Primary.Damage = 1
SWEP.Primary.ClipSize = 1
SWEP.Primary.DisableBulletCode = true
SWEP.Primary.Ammo = "RPG_Round"
SWEP.Primary.Sound = {"vj_hlr/hl1_weapon/rpg/rocketfire1.wav"}
SWEP.Primary.DistantSound = {"vj_hlr/hl1_weapon/rpg/rocketfire1_distant.wav"}

SWEP.PrimaryEffects_SpawnShells = false
---------------------------------------------------------------------------------------------------------------------------------------------
function SWEP:CustomOnInitialize()
	self:SetModelScale(0.5)
end
---------------------------------------------------------------------------------------------------------------------------------------------
function SWEP:CustomBulletSpawnPosition()
	local owner = self:GetOwner()
	local att = self:GetAttachment(1)

	return att.Pos
end
---------------------------------------------------------------------------------------------------------------------------------------------
function SWEP:CustomOnPrimaryAttack_BeforeShoot()
	if CLIENT then return end
	local rocket = ents.Create("obj_vj_hlr1_rocket")
	rocket:SetPos(self:GetNW2Vector("VJ_CurBulletPos"))
	rocket:SetAngles(self:GetOwner():GetAngles())
	rocket:SetOwner(self:GetOwner())
	rocket:Spawn()
	rocket:Activate()
	rocket.HasIdleSounds = false
	local phys = rocket:GetPhysicsObject()
	phys:SetVelocity(rocket:GetForward() * -50 + rocket:GetRight() * -16 - rocket:GetUp() * -50)
	timer.Simple(0.33, function()
		if IsValid(self) then
			rocket.HasIdleSounds = true
			if IsValid(phys) then
				phys:SetVelocity(self:GetOwner():CalculateProjectile("Line", self:GetNW2Vector("VJ_CurBulletPos"), self:GetOwner():GetEnemy():GetPos() + self:GetOwner():GetEnemy():OBBCenter(), 1700))
				rocket:SetAngles(rocket:GetVelocity():GetNormal():Angle())
			end
		end
	end)
	//if IsValid(phys) then
	//	phys:SetVelocity(self:GetOwner():CalculateProjectile("Line", self:GetNW2Vector("VJ_CurBulletPos"), self:GetOwner():GetEnemy():GetPos() + self:GetOwner():GetEnemy():OBBCenter(), 3000))
	//end

	self.NextReloadT = CurTime() +2.5
end
---------------------------------------------------------------------------------------------------------------------------------------------
function SWEP:CustomOnPrimaryAttackEffects()
	self.PrimaryEffects_MuzzleFlash = false
	muz = ents.Create("env_sprite")
	muz:SetKeyValue("model","vj_hl/sprites/muzzleflash2.vmt")
	muz:SetKeyValue("scale",""..math.Rand(1,1.2))
	muz:SetKeyValue("GlowProxySize","2.0") -- Size of the glow to be rendered for visibility testing.
	muz:SetKeyValue("HDRColorScale","1.0")
	muz:SetKeyValue("renderfx","14")
	muz:SetKeyValue("rendermode","3") -- Set the render mode to "3" (Glow)
	muz:SetKeyValue("renderamt","255") -- Transparency
	muz:SetKeyValue("disablereceiveshadows","0") -- Disable receiving shadows
	muz:SetKeyValue("framerate","10.0") -- Rate at which the sprite should animate, if at all.
	muz:SetKeyValue("spawnflags","0")
	muz:SetParent(self)
	muz:Fire("SetParentAttachment",self.PrimaryEffects_MuzzleAttachment)
	muz:SetAngles(Angle(math.random(-100, 100), math.random(-100, 100), math.random(-100, 100)))
	muz:Spawn()
	muz:Activate()
	muz:Fire("Kill","",0.08)
	return true
end