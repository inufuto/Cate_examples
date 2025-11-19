ext InitSoundBeep, CallSoundBeep, Sound_FireBeep, Sound_HitBeep, Sound_LooseBeep
ext Sound_UpBeep, Sound_StartBeep, Sound_GameOverBeep

ext InitSoundPsg, Sound_FirePsg, Sound_SmallBangPsg, Sound_LargeBangPsg
ext Sound_UpPsg, Sound_StartPsg, Sound_GameOverPsg
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
        ld hl,Sound_FireBeep | ld (Sound_Fire_+1),hl
        ld hl,Sound_HitBeep | ld (Sound_Hit_+1),hl
        ld hl,Sound_LooseBeep | ld (Sound_Loose_+1),hl
        ld hl,Sound_UpBeep | ld (Sound_Up_+1),hl
        ld hl,Sound_StartBeep | ld (Sound_Start_+1),hl
        ld hl,Sound_GameOverBeep | ld (Sound_GameOver_+1),hl
    else
        call InitSoundPsg
        ld hl,SoundHandlerPsg | ld (SoundHandler+1),hl
        ld hl,Sound_FirePsg | ld (Sound_Fire_+1),hl
        ld hl,Sound_SmallBangPsg | ld (Sound_SmallBang_+1),hl
        ld hl,Sound_LargeBangPsg | ld (Sound_LargeBang_+1),hl
        ld hl,Sound_UpPsg | ld (Sound_Up_+1),hl
        ld hl,Sound_StartPsg | ld (Sound_Start_+1),hl
        ld hl,Sound_GameOverPsg | ld (Sound_GameOver_+1),hl
        ld hl,StartBGMPsg | ld (StartBGM_+1),hl
        ld hl,StopBGMPsg | ld (StopBGM_+1),hl
    endif
ret


CallSound_: public CallSound_
jp Dummy

SoundHandler: public SoundHandler
jp Dummy

Sound_Fire_: public Sound_Fire_
jp Dummy

Sound_Up_: public Sound_Up_
jp Dummy

Sound_Hit_: public Sound_Hit_
jp Dummy

Sound_Loose_: public Sound_Loose_
jp Dummy

Sound_SmallBang_: public Sound_SmallBang_
jp Dummy

Sound_LargeBang_: public Sound_LargeBang_
jp Dummy

Sound_Start_: public Sound_Start_
jp Dummy

Sound_GameOver_: public Sound_GameOver_
jp Dummy

StartBGM_: public StartBGM_
jp Dummy

StopBGM_: public StopBGM_
jp Dummy