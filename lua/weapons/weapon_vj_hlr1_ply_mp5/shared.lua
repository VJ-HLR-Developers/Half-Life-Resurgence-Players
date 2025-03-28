SWEP.Base = "weapon_vj_base"
SWEP.PrintName = "MP5"
SWEP.Author = "Cpt. Hazama"
SWEP.Contact = "http://steamcommunity.com/groups/vrejgaming"
SWEP.MadeForNPCsOnly = true

SWEP.WorldModel = "models/vj_hlr/weapons/w_9mmar.mdl"
SWEP.HoldType = "smg"

SWEP.WorldModel_UseCustomPosition = true
SWEP.WorldModel_CustomPositionAngle = Vector(90, 180, 90)
SWEP.WorldModel_CustomPositionOrigin = Vector(10, -4, -0)
SWEP.WorldModel_CustomPositionBone = "Bip01 R Hand"

SWEP.NPC_ReloadSound = {"vj_hlr/gsrc/wep/mp5/mp_reload.wav"}
SWEP.NPC_NextPrimaryFire = 0.08
-- SWEP.NPC_BulletSpawnAttachment = "0"
SWEP.NPC_HasSecondaryFire = true
SWEP.NPC_SecondaryFireEnt = "obj_vj_hlr1_grenade_40mm"
SWEP.NPC_SecondaryFireChance = 1
SWEP.NPC_SecondaryFireSound = {"vj_hlr/gsrc/wep/mp5/glauncher.wav", "vj_hlr/gsrc/wep/mp5/glauncher2.wav"}

SWEP.Primary.Damage = 5
SWEP.Primary.ClipSize = 50
SWEP.Primary.Ammo = "SMG1"
SWEP.Primary.TracerType = "VJ_HLR_Tracer"
SWEP.Primary.Sound = {"vj_hlr/gsrc/wep/mp5/hks1.wav", "vj_hlr/gsrc/wep/mp5/hks2.wav", "vj_hlr/gsrc/wep/mp5/hks3.wav"}
SWEP.Primary.DistantSound = {"vj_hlr/gsrc/wep/mp5/hks_distant_new.wav"}

-- SWEP.PrimaryEffects_MuzzleAttachment = "0"
SWEP.PrimaryEffects_SpawnShells = false
SWEP.PrimaryEffects_ShellType = "ShellEject"
SWEP.PrimaryEffects_MuzzleFlash = false
---------------------------------------------------------------------------------------------------------------------------------------------
function SWEP:Init()
	self:SetModelScale(0.75)
end
---------------------------------------------------------------------------------------------------------------------------------------------
function SWEP:PrimaryAttackEffects(owner)
	local muz = ents.Create("env_sprite")
	muz:SetKeyValue("model", "vj_hl/sprites/muzzleflash1.vmt")
	muz:SetKeyValue("scale", "" .. math.Rand(0.3, 0.5))
	muz:SetKeyValue("GlowProxySize", "2.0") -- Size of the glow to be rendered for visibility testing.
	muz:SetKeyValue("HDRColorScale", "1.0")
	muz:SetKeyValue("renderfx", "14")
	muz:SetKeyValue("rendermode", "3") -- Set the render mode to "3" (Glow)
	muz:SetKeyValue("renderamt", "255") -- Transparency
	muz:SetKeyValue("disablereceiveshadows", "0") -- Disable receiving shadows
	muz:SetKeyValue("framerate", "10.0") -- Rate at which the sprite should animate, if at all.
	muz:SetKeyValue("spawnflags", "0")
	muz:SetParent(self)
	muz:Fire("SetParentAttachment", self.PrimaryEffects_MuzzleAttachment)
	muz:SetAngles(Angle(math.random(-100, 100), math.random(-100, 100), math.random(-100, 100)))
	muz:Spawn()
	muz:Activate()
	muz:Fire("Kill", "", 0.08)
	self.BaseClass.PrimaryAttackEffects(self, owner)
end