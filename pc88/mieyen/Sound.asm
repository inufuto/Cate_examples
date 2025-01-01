ext InitSoundV1, CallSoundV1, Sound_LooseV1, Sound_HitV1, Sound_StoleV1, Sound_FireV1, Sound_BonusV1
ext Sound_StartV1, Sound_ClearV1, Sound_GameOverV1
ext InitSoundV2, CallSoundV2, Sound_LooseV2, Sound_HitV2, Sound_StoleV2, Sound_FireV2, Sound_BonusV2
ext Sound_StartV2, Sound_ClearV2, Sound_GameOverV2, StartBGM2, StopBGM2, SoundHandlerV2

cseg
Dummy:
ret

InitSound: public InitSound
    push af | push hl
        in a,(31h)
        and 80h
        if nz
            call InitSoundV1
            ld hl,CallSoundV1 | ld (CallSound_+1),hl
            ld hl,Sound_LooseV1 | ld (Sound_Loose_+1),hl
            ld hl,Sound_HitV1 | ld (Sound_Hit_+1),hl
            ld hl,Sound_StoleV1 | ld (Sound_Stole_+1),hl
            ld hl,Sound_FireV1 | ld (Sound_Fire_+1),hl
            ld hl,Sound_BonusV1 | ld (Sound_Bonus_+1),hl
            ld hl,Sound_StartV1 | ld (Sound_Start_+1),hl
            ld hl,Sound_ClearV1 | ld (Sound_Clear_+1),hl
            ld hl,Sound_GameOverV1 | ld (Sound_GameOver_+1),hl
        else
            call InitSoundV2
            ld hl,SoundHandlerV2 | ld (SoundHandler+1),hl
            ld hl,Sound_LooseV2 | ld (Sound_Loose_+1),hl
            ld hl,Sound_HitV2 | ld (Sound_Hit_+1),hl
            ld hl,Sound_StoleV2 | ld (Sound_Stole_+1),hl
            ld hl,Sound_FireV2 | ld (Sound_Fire_+1),hl
            ld hl,Sound_BonusV2 | ld (Sound_Bonus_+1),hl
            ld hl,Sound_StartV2 | ld (Sound_Start_+1),hl
            ld hl,Sound_ClearV2 | ld (Sound_Clear_+1),hl
            ld hl,Sound_GameOverV2 | ld (Sound_GameOver_+1),hl
            ld hl,StartBGM2 | ld (StartBGM_+1),hl
            ld hl,StopBGM2 | ld (StopBGM_+1),hl
        endif
    pop hl | pop af
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