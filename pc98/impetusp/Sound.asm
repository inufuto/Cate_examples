include "Segment.inc"

ext OpnAvailable

ext InitSoundBeep,CallSoundBeep,SoundHandlerBeep,Sound_FireBeep
ext Sound_HitBeep, Sound_LooseBeep, Sound_UpBeep
ext Sound_StartBeep,Sound_GameOverBeep

ext InitSoundOpn,SoundHandlerOpn,Sound_FireOpn, Sound_BeepOpn
ext Sound_SmallBangOpn,Sound_LargeBangOpn, Sound_UpOpn
ext Sound_StartOpn,Sound_GameOverOpn
ext StartBGMOpn, StopBGMOpn

cseg
Dummy:
ret

cseg
InitSound: public InitSound
    call InitSoundOpn
    cmp byte ptr [OpnAvailable],0
    if z
        call InitSoundBeep
        mov word ptr [CallSound_+1],CallSoundBeep
        mov word ptr [SoundHandler+1],SoundHandlerBeep
        mov word ptr [Sound_Fire_+1],Sound_FireBeep
        mov word ptr [Sound_Beep_+1],Sound_FireBeep
        mov word ptr [Sound_Hit_+1],Sound_HitBeep
        mov word ptr [Sound_Loose_+1],Sound_LooseBeep
        mov word ptr [Sound_Up_+1],Sound_UpBeep
        mov word ptr [Sound_Start_+1],Sound_StartBeep
        ; mov word ptr [Sound_Clear_+1],Sound_ClearBeep
        mov word ptr [Sound_GameOver_+1],Sound_GameOverBeep
    else
        mov byte ptr [CallSound_],0c3h
        mov word ptr [SoundHandler+1],SoundHandlerOpn
        mov word ptr [Sound_Fire_+1],Sound_FireOpn
        mov word ptr [Sound_Beep_+1],Sound_BeepOpn
        mov word ptr [Sound_SmallBang_+1],Sound_SmallBangOpn
        mov word ptr [Sound_LargeBang_+1],Sound_LargeBangOpn
        mov word ptr [Sound_Up_+1],Sound_UpOpn
        mov word ptr [Sound_Start_+1],Sound_StartOpn
        ; mov word ptr [Sound_Clear_+1],Sound_ClearOpn
        mov word ptr [Sound_GameOver_+1],Sound_GameOverOpn
        mov word ptr [StartBGM_+1],StartBGMOpn
        mov word ptr [StopBGM_+1],StopBGMOpn
    endif
ret

cseg
CallSound_: public CallSound_
    defb 0eah
    defw Dummy
    defw DefaultSegment

SoundHandler: public SoundHandler
    defb 0eah
    defw Dummy
    defw DefaultSegment

Sound_Fire_: public Sound_Fire_
    defb 0eah
    defw Dummy
    defw DefaultSegment

Sound_Beep_: public Sound_Beep_
    defb 0eah
    defw Dummy
    defw DefaultSegment

Sound_Hit_: public Sound_Hit_
    defb 0eah
    defw Dummy
    defw DefaultSegment

Sound_Loose_: public Sound_Loose_
    defb 0eah
    defw Dummy
    defw DefaultSegment

Sound_SmallBang_: public Sound_SmallBang_
    defb 0eah
    defw Dummy
    defw DefaultSegment

Sound_LargeBang_: public Sound_LargeBang_
    defb 0eah
    defw Dummy
    defw DefaultSegment

Sound_Up_: public Sound_Up_
    defb 0eah
    defw Dummy
    defw DefaultSegment

Sound_Start_: public Sound_Start_
    defb 0eah
    defw Dummy
    defw DefaultSegment

; Sound_Clear_: public Sound_Clear_
;     defb 0eah
;     defw Dummy
;     defw DefaultSegment

Sound_GameOver_: public Sound_GameOver_
    defb 0eah
    defw Dummy
    defw DefaultSegment

StartBGM_: public StartBGM_
    defb 0eah
    defw Dummy
    defw DefaultSegment

StopBGM_: public StopBGM_
    defb 0eah
    defw Dummy
    defw DefaultSegment
