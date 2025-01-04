ext InitSoundBeep, CallSoundBeep, Sound_LooseBeep, Sound_HitBeep, Sound_StoleBeep
ext Sound_FireBeep, Sound_BonusBeep
ext Sound_StartBeep, Sound_ClearBeep, Sound_GameOverBeep

ext InitSoundPsg, CallSoundPsg, Sound_LoosePsg, Sound_HitPsg, Sound_StolePsg
ext Sound_FirePsg, Sound_BonusPsg
ext Sound_StartPsg, Sound_ClearPsg, Sound_GameOverPsg
ext StartBGMPsg, StopBGMPsg, SoundHandlerPsg, IsPsgAvailable_

cseg
Dummy:
ret

InitSound: public InitSound
    call IsPsgAvailable_
    or a
    if z
        call InitSoundBeep
        ld hl,CallSoundBeep | ld (CallSound_+1),hl
        ld hl,Sound_LooseBeep | ld (Sound_Loose_+1),hl
        ld hl,Sound_HitBeep | ld (Sound_Hit_+1),hl
        ld hl,Sound_StoleBeep | ld (Sound_Stole_+1),hl
        ld hl,Sound_FireBeep | ld (Sound_Fire_+1),hl
        ld hl,Sound_BonusBeep | ld (Sound_Bonus_+1),hl
        ld hl,Sound_StartBeep | ld (Sound_Start_+1),hl
        ld hl,Sound_ClearBeep | ld (Sound_Clear_+1),hl
        ld hl,Sound_GameOverBeep | ld (Sound_GameOver_+1),hl
    else
        ld hl,SoundHandlerPsg | ld (SoundHandler+1),hl
        call InitSoundPsg
        ld hl,Sound_LoosePsg | ld (Sound_Loose_+1),hl
        ld hl,Sound_HitPsg | ld (Sound_Hit_+1),hl
        ld hl,Sound_StolePsg | ld (Sound_Stole_+1),hl
        ld hl,Sound_FirePsg | ld (Sound_Fire_+1),hl
        ld hl,Sound_BonusPsg | ld (Sound_Bonus_+1),hl
        ld hl,Sound_StartPsg | ld (Sound_Start_+1),hl
        ld hl,Sound_ClearPsg | ld (Sound_Clear_+1),hl
        ld hl,Sound_GameOverPsg | ld (Sound_GameOver_+1),hl
        ld hl,StartBGMPsg | ld (StartBGM_+1),hl
        ld hl,StopBGMPsg | ld (StopBGM_+1),hl
    endif
ret


CallSound_: public CallSound_
jp Dummy

SoundHandler: public SoundHandler
jp Dummy

Sound_Loose_: public Sound_Loose_
jp Dummy

Sound_Hit_: public Sound_Hit_
jp Dummy

Sound_Stole_: public Sound_Stole_
jp Dummy

Sound_Fire_: public Sound_Fire_
jp Dummy

Sound_Bonus_: public Sound_Bonus_
jp Dummy

Sound_Start_: public Sound_Start_
jp Dummy

Sound_Clear_: public Sound_Clear_
jp Dummy

Sound_GameOver_: public Sound_GameOver_
jp Dummy

StartBGM_: public StartBGM_
jp Dummy

StopBGM_: public StopBGM_
jp Dummy