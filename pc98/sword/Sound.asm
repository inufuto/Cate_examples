include "Segment.inc"

ext OpnAvailable

ext InitSoundBeep,SoundHandlerBeep,Sound_LooseBeep,Sound_HitBeep,Sound_UpBeep,Sound_AttackBeep
ext Sound_StartBeep,Sound_ClearBeep,Sound_GameOverBeep
ext StartBGMBeep, StopBGMBeep

ext InitSoundOpn,SoundHandlerOpn,Sound_LooseOpn,Sound_HitOpn,Sound_UpOpn,Sound_AttackOpn
ext Sound_StartOpn,Sound_ClearOpn,Sound_GameOverOpn
ext StartBGMOpn, StopBGMOpn

cseg
Dummy:
ret


InitSound: public InitSound
    call InitSoundOpn
    cmp byte ptr [OpnAvailable],0
    if z
        call InitSoundBeep
        mov word ptr [SoundHandler+1],SoundHandlerBeep
        mov word ptr [Sound_Loose_+1],Sound_LooseBeep
        mov word ptr [Sound_Hit_+1],Sound_HitBeep
        mov word ptr [Sound_Up_+1],Sound_UpBeep
        mov word ptr [Sound_Attack_+1],Sound_AttackBeep
        mov word ptr [Sound_Start_+1],Sound_StartBeep
        mov word ptr [Sound_Clear_+1],Sound_ClearBeep
        mov word ptr [Sound_GameOver_+1],Sound_GameOverBeep
        mov word ptr [StartBGM_+1],StartBGMBeep
        mov word ptr [StopBGM_+1],StopBGMBeep
    else
        mov word ptr [SoundHandler+1],SoundHandlerOpn
        mov word ptr [Sound_Loose_+1],Sound_LooseOpn
        mov word ptr [Sound_Hit_+1],Sound_HitOpn
        mov word ptr [Sound_Up_+1],Sound_UpOpn
        mov word ptr [Sound_Attack_+1],Sound_AttackOpn
        mov word ptr [Sound_Start_+1],Sound_StartOpn
        mov word ptr [Sound_Clear_+1],Sound_ClearOpn
        mov word ptr [Sound_GameOver_+1],Sound_GameOverOpn
        mov word ptr [StartBGM_+1],StartBGMOpn
        mov word ptr [StopBGM_+1],StopBGMOpn
    endif
ret

SoundHandler: public SoundHandler
    defb 0eah
    defw Dummy
    defw DefaultSegment

Sound_Loose_: public Sound_Loose_
    defb 0eah
    defw Dummy
    defw DefaultSegment

Sound_Hit_: public Sound_Hit_
    defb 0eah
    defw Dummy
    defw DefaultSegment

Sound_Up_: public Sound_Up_
    defb 0eah
    defw Dummy
    defw DefaultSegment

Sound_Attack_: public Sound_Attack_
    defb 0eah
    defw Dummy
    defw DefaultSegment

Sound_Start_: public Sound_Start_
    defb 0eah
    defw Dummy
    defw DefaultSegment

Sound_Clear_: public Sound_Clear_
    defb 0eah
    defw Dummy
    defw DefaultSegment

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
