if (!file.Exists("autorun/vj_base_autorun.lua","LUA")) then return end
---------------------------------------------------------------------------------------------------------------------------------------------
SWEP.Base = "weapon_vj_hlr1_ply_squeak"
SWEP.PrintName = "Penguin"
SWEP.Author = "Cpt. Hazama & oteek"
SWEP.Contact = "http://steamcommunity.com/groups/vrejgaming"
SWEP.Purpose = "This weapon is made for Players and NPCs"
SWEP.Instructions = "Controls are like a regular weapon."
SWEP.MadeForNPCsOnly = true

SWEP.WorldModel = "models/vj_hlr/weapons/w_penguin.mdl"

SWEP.ThrowableNPC = "npc_vj_hlrof_penguin"

SWEP.WorldModel_CustomPositionAngle = Vector(-40,180,0)
SWEP.WorldModel_CustomPositionOrigin = Vector(2,-3,-5)