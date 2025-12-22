AddCSLuaFile("shared.lua")
include("shared.lua")
/*-----------------------------------------------
	*** Copyright (c) 2012-2025 by DrVrej, All rights reserved. ***
	No parts of this code or any of its contents may be reproduced, copied, modified or adapted,
	without the prior written consent of the author, unless otherwise indicated for stand-alone materials.
-----------------------------------------------*/
ENT.Model = "models/vj_hlr/hl1mp/dm_colette.mdl"

ENT.SoundTbl_CombatIdle = {"vj_hlr/hl1mp_npc/colette/colette_attack0.wav", "vj_hlr/hl1mp_npc/colette/colette_attack1.wav", "vj_hlr/hl1mp_npc/colette/colette_attack2.wav", "vj_hlr/hl1mp_npc/colette/colette_attack3.wav", "vj_hlr/hl1mp_npc/colette/colette_attacked2.wav"}
ENT.SoundTbl_ReceiveOrder = {"vj_hlr/hl1mp_npc/colette/colette_use2.wav", "vj_hlr/hl1mp_npc/colette/colette_use3.wav"}
ENT.SoundTbl_FollowPlayer = {"vj_hlr/hl1mp_npc/colette/colette_use0.wav", "vj_hlr/hl1mp_npc/colette/colette_use1.wav", "vj_hlr/hl1mp_npc/colette/colette_use2.wav", "vj_hlr/hl1mp_npc/colette/colette_use3.wav", "vj_hlr/hl1mp_npc/colette/colette_use4.wav", "vj_hlr/hl1mp_npc/colette/colette_use5.wav"}
ENT.SoundTbl_UnFollowPlayer = {"vj_hlr/hl1mp_npc/colette/colette_unuse0.wav", "vj_hlr/hl1mp_npc/colette/colette_unuse1.wav", "vj_hlr/hl1mp_npc/colette/colette_unuse2.wav", "vj_hlr/hl1mp_npc/colette/colette_unuse3.wav", "vj_hlr/hl1mp_npc/colette/colette_unuse4.wav"}
ENT.SoundTbl_BecomeEnemyToPlayer = {"vj_hlr/hl1mp_npc/colette/colette_attack3.wav"}
ENT.SoundTbl_WeaponReload = {"vj_hlr/hl1mp_npc/colette/colette_attacked3.wav"}
ENT.SoundTbl_KilledEnemy = {"vj_hlr/hl1mp_npc/colette/colette_kill0.wav", "vj_hlr/hl1mp_npc/colette/colette_kill1.wav", "vj_hlr/hl1mp_npc/colette/colette_kill2.wav", "vj_hlr/hl1mp_npc/colette/colette_kill3.wav", "vj_hlr/hl1mp_npc/colette/colette_kill4.wav"}
ENT.SoundTbl_AllyDeath = {"vj_hlr/hl1mp_npc/colette/colette_attacked0.wav"}
ENT.SoundTbl_Pain = {"vj_hlr/hl1mp_npc/colette/colette_attacked1.wav", "vj_hlr/hl1mp_npc/colette/colette_pain0.wav", "vj_hlr/hl1mp_npc/colette/colette_pain1.wav", "vj_hlr/hl1mp_npc/colette/colette_pain2.wav", "vj_hlr/hl1mp_npc/colette/colette_pain3.wav"}
ENT.SoundTbl_Impact = {}
ENT.SoundTbl_DamageByPlayer = {"vj_hlr/hl1mp_npc/colette/colette_mad0.wav", "vj_hlr/hl1mp_npc/colette/colette_mad1.wav", "vj_hlr/hl1mp_npc/colette/colette_mad2.wav"}
ENT.SoundTbl_Death = {"vj_hlr/hl1mp_npc/colette/colette_die0.wav", "vj_hlr/hl1mp_npc/colette/colette_die1.wav", "vj_hlr/hl1mp_npc/colette/colette_die2.wav"}

ENT.DeathSoundLevel = 80
ENT.MainSoundPitch = 100

-- played when the npc cannot get to you and automatically unfollows you:
-- vj_hlr/hl1mp_npc/colette/colette_stop0.wav
-- vj_hlr/hl1mp_npc/colette/colette_stop1.wav
-- vj_hlr/hl1mp_npc/colette/colette_stop2.wav