SWEP.Base = "weapon_vj_base"
SWEP.PrintName = "Deagle"
SWEP.Author = "Cpt. Hazama"
SWEP.Contact = "http://steamcommunity.com/groups/vrejgaming"
SWEP.MadeForNPCsOnly = true

SWEP.WorldModel = "models/vj_hlr/weapons/w_desert_eagle.mdl"
SWEP.HoldType = "revolver"

SWEP.WorldModel_UseCustomPosition = true
SWEP.WorldModel_CustomPositionAngle = Vector(80, 0, 0)
SWEP.WorldModel_CustomPositionOrigin = Vector(0.5, -0.5, -35)
SWEP.WorldModel_CustomPositionBone = "Bip01 R Hand"

SWEP.NPC_NextPrimaryFire = 0.5
SWEP.NPC_ReloadSound = {"vj_hlr/gsrc/wep/deagle/desert_eagle_reload.wav"}

SWEP.Primary.Damage = 15
SWEP.Primary.ClipSize = 7
SWEP.Primary.Ammo = "357"
SWEP.Primary.TracerType = "VJ_HLR_Tracer"
SWEP.Primary.Sound				= {"vj_hlr/gsrc/wep/deagle/desert_eagle_fire.wav"}
SWEP.Primary.DistantSound		= {"vj_hlr/gsrc/wep/deagle/desert_eagle_fire_distant_final.wav"}

SWEP.PrimaryEffects_ShellType = "ShellEject"
SWEP.PrimaryEffects_MuzzleFlash = false
---------------------------------------------------------------------------------------------------------------------------------------------
function SWEP:Init()
	-- self:SetModelScale(0.5)
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