SWEP.Base = "weapon_vj_base"
SWEP.PrintName = "Shotgun"
SWEP.Author = "Cpt. Hazama"
SWEP.Contact = "http://steamcommunity.com/groups/vrejgaming"
SWEP.MadeForNPCsOnly = true

SWEP.WorldModel = "models/vj_hlr/weapons/w_shotgun.mdl"
SWEP.HoldType = "shotgun"

SWEP.WorldModel_UseCustomPosition = true
SWEP.WorldModel_CustomPositionAngle = Vector(0, 180, 90)
SWEP.WorldModel_CustomPositionOrigin = Vector(-1.5, -15, 0)
SWEP.WorldModel_CustomPositionBone = "Bip01 R Hand"

SWEP.NPC_NextPrimaryFire = 1
SWEP.NPC_FiringDistanceScale = 0.5
SWEP.NPC_CustomSpread	 		= 2.5
SWEP.NPC_ReloadSound			= {"vj_hlr/gsrc/wep/shotgun/shotgun_reload.wav"}
SWEP.NPC_ExtraFireSound			= {"vj_hlr/gsrc/wep/shotgun/scock1.wav"}
SWEP.NPC_ExtraFireSoundTime		= 0.2

SWEP.Primary.Damage				= 5
SWEP.Primary.NumberOfShots		= 5
SWEP.Primary.ClipSize			= 8
SWEP.Primary.Ammo = "Buckshot"
SWEP.Primary.TracerType = "VJ_HLR_Tracer"
SWEP.Primary.Sound				= {"vj_hlr/gsrc/wep/shotgun/sbarrel1.wav"}
SWEP.Primary.DistantSound		= {"vj_hlr/gsrc/wep/shotgun/sbarrel1_distant2.wav"}

SWEP.PrimaryEffects_ShellType = "ShotgunShellEject"
SWEP.PrimaryEffects_MuzzleFlash = false
---------------------------------------------------------------------------------------------------------------------------------------------
function SWEP:Init()
	self:SetModelScale(0.85)
end
---------------------------------------------------------------------------------------------------------------------------------------------
function SWEP:PrimaryAttackEffects(owner)
	local muz = ents.Create("env_sprite")
	muz:SetKeyValue("model", "vj_hl/sprites/muzzleflash2.vmt")
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