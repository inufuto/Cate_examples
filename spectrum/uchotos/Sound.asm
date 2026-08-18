ext InitSoundBeep, CallSoundBeep
ext Sound_FireBeep, Sound_HitBeep, Sound_LooseBeep, Sound_BeepBeep, Sound_PushBeep, Sound_UpBeep
ext Sound_StartBeep, Sound_ClearBeep, Sound_GameOverBeep

ext InitSoundPsg, SoundHandlerPsg, IsPsgAvailable_
ext Sound_FirePsg, Sound_HitPsg, Sound_LoosePsg, Sound_BeepPsg, Sound_PushPsg, Sound_UpPsg
ext Sound_StartPsg, Sound_ClearPsg, Sound_GameOverPsg
ext StartBGMPsg, StopBGMPsg, SoundHandlerPsg

cseg
InitSound: public InitSound
    call IsPsgAvailable_
    or a
    if z
        call InitSoundBeep
        ld hl,CallSoundBeep | ld (CallSound_+1),hl
        ld hl,Sound_FireBeep | ld (Sound_Fire_+1),hl
        ld hl,Sound_LooseBeep | ld (Sound_Loose_+1),hl
        ld hl,Sound_HitBeep | ld (Sound_Hit_+1),hl
        ld hl,Sound_BeepBeep | ld (Sound_Beep_+1),hl
        ld hl,Sound_PushBeep | ld (Sound_Push_+1),hl
        ld hl,Sound_UpBeep | ld (Sound_Up_+1),hl
        ld hl,Sound_StartBeep | ld (Sound_Start_+1),hl
        ld hl,Sound_ClearBeep | ld (Sound_Clear_+1),hl
        ld hl,Sound_GameOverBeep | ld (Sound_GameOver_+1),hl
    else
        ld hl,SoundHandlerPsg | ld (SoundHandler+1),hl
        call InitSoundPsg
        ld hl,Sound_FirePsg | ld (Sound_Fire_+1),hl
        ld hl,Sound_LoosePsg | ld (Sound_Loose_+1),hl
        ld hl,Sound_HitPsg | ld (Sound_Hit_+1),hl
        ld hl,Sound_BeepPsg | ld (Sound_Beep_+1),hl
        ld hl,Sound_PushPsg | ld (Sound_Push_+1),hl
        ld hl,Sound_UpPsg | ld (Sound_Up_+1),hl
        ld hl,Sound_StartPsg | ld (Sound_Start_+1),hl
        ld hl,Sound_ClearPsg | ld (Sound_Clear_+1),hl
        ld hl,Sound_GameOverPsg | ld (Sound_GameOver_+1),hl
        ld hl,StartBGMPsg | ld (StartBGM_+1),hl
        ld hl,StopBGMPsg | ld (StopBGM_+1),hl
    endif
ret

Dummy:
ret

CallSound_: public CallSound_
jp Dummy

SoundHandler: public SoundHandler
jp Dummy

Sound_Fire_: public Sound_Fire_
jp Dummy

Sound_Loose_: public Sound_Loose_
jp Dummy

Sound_Hit_: public Sound_Hit_
jp Dummy

Sound_Beep_: public Sound_Beep_
jp Dummy

Sound_Push_: public Sound_Push_
jp Dummy

Sound_Up_: public Sound_Up_
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