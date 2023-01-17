AddCSLuaFile("shared.lua")
include('shared.lua')
/*-----------------------------------------------
	*** Copyright (c) 2012-2023 by DrVrej, All rights reserved. ***
	No parts of this code or any of its contents may be reproduced, copied, modified or adapted,
	without the prior written consent of the author, unless otherwise indicated for stand-alone materials.
-----------------------------------------------*/
ENT.Model = {"models/vj_hlr/hl1mp/dm_gina.mdl"}

	-- ====== File Path Variables ====== --
	-- Leave blank if you don't want any sounds to play
ENT.SoundTbl_FollowPlayer = {"vj_hlr/hl1mp_npc/gina/gina_use0.wav","vj_hlr/hl1mp_npc/gina/gina_use1.wav","vj_hlr/hl1mp_npc/gina/gina_use2.wav","vj_hlr/hl1mp_npc/gina/gina_use3.wav","vj_hlr/hl1mp_npc/gina/gina_use4.wav","vj_hlr/hl1mp_npc/gina/gina_use5.wav"}
ENT.SoundTbl_UnFollowPlayer = {"vj_hlr/hl1mp_npc/gina/gina_stop1.wav","vj_hlr/hl1mp_npc/gina/gina_unuse0.wav","vj_hlr/hl1mp_npc/gina/gina_unuse1.wav","vj_hlr/hl1mp_npc/gina/gina_unuse2.wav","vj_hlr/hl1mp_npc/gina/gina_unuse3.wav","vj_hlr/hl1mp_npc/gina/gina_unuse4.wav"}
ENT.SoundTbl_Alert = {"vj_hlr/hl1mp_npc/gina/gina_attack0.wav","vj_hlr/hl1mp_npc/gina/gina_attack1.wav","vj_hlr/hl1mp_npc/gina/gina_attack2.wav","vj_hlr/hl1mp_npc/gina/gina_attack3.wav"}
ENT.SoundTbl_WeaponReload = {"vj_hlr/hl1mp_npc/gina/gina_attacked3.wav"}
ENT.SoundTbl_OnGrenadeSight = {"vj_hlr/hl1mp_npc/gina/gina_attacked2.wav"}
ENT.SoundTbl_OnDangerSight = {"vj_hlr/hl1mp_npc/gina/gina_attacked2.wav"}
ENT.SoundTbl_OnKilledEnemy = {"vj_hlr/hl1mp_npc/gina/gina_kill0.wav","vj_hlr/hl1mp_npc/gina/gina_kill1.wav","vj_hlr/hl1mp_npc/gina/gina_kill2.wav","vj_hlr/hl1mp_npc/gina/gina_kill3.wav","vj_hlr/hl1mp_npc/gina/gina_kill4.wav"}
ENT.SoundTbl_Pain = {"vj_hlr/hl1mp_npc/gina/gina_attacked0.wav","vj_hlr/hl1mp_npc/gina/gina_attacked1.wav","vj_hlr/hl1mp_npc/gina/gina_pain0.wav","vj_hlr/hl1mp_npc/gina/gina_pain1.wav","vj_hlr/hl1mp_npc/gina/gina_pain2.wav","vj_hlr/hl1mp_npc/gina/gina_pain3.wav"}
ENT.SoundTbl_DamageByPlayer = {"vj_hlr/hl1mp_npc/gina/gina_mad0.wav","vj_hlr/hl1mp_npc/gina/gina_mad1.wav","vj_hlr/hl1mp_npc/gina/gina_mad2.wav"}
ENT.SoundTbl_Death = {"vj_hlr/hl1mp_npc/gina/gina_die0.wav","vj_hlr/hl1mp_npc/gina/gina_die1.wav","vj_hlr/hl1mp_npc/gina/gina_die2.wav"}

ENT.DeathSoundLevel = 80
ENT.GeneralSoundPitch1 = 100

-- played when the npc cannot get to you and automatically unfollows you:
-- vj_hlr/hl1mp_npc/gina/gina_stop0.wav
-- vj_hlr/hl1mp_npc/gina/gina_stop2.wav
---------------------------------------------------------------------------------------------------------------------------------------------