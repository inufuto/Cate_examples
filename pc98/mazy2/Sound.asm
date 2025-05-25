include "Segment.inc"

ext OpnAvailable

ext InitSoundBeep, SoundHandlerBeep
ext Sound_BeepBeep, Sound_GetBeep, Sound_HitBeep, Sound_LooseBeep
ext Sound_StartBeep, Sound_ClearBeep, Sound_GameOverBeep, StartBGMBeep, StopBGMBeep
ext InitSoundOpn, SoundHandlerOpn, Sound_LooseOpn, Sound_HitOpn, Sound_StoleOpn
ext Sound_BeepOpn, Sound_GetOpn, Sound_HitOpn, Sound_LooseOpn
ext Sound_StartOpn, Sound_ClearOpn, Sound_GameOverOpn, StartBGMOpn, StopBGMOpn

cseg
Dummy:
ret

cseg
InitSound: public InitSound
    call InitSoundOpn
    cmp byte ptr [OpnAvailable],0
    if z
        call InitSoundBeep
        mov word ptr [SoundHandler+1],SoundHandlerBeep
        mov word ptr [Sound_Beep_+1],Sound_BeepBeep
        mov word ptr [Sound_Get_+1],Sound_GetBeep
        mov word ptr [Sound_Hit_+1],Sound_HitBeep
        mov word ptr [Sound_Loose_+1],Sound_LooseBeep
        mov word ptr [Sound_Start_+1],Sound_StartBeep
        mov word ptr [Sound_Clear_+1],Sound_ClearBeep
        mov word ptr [Sound_GameOver_+1],Sound_GameOverBeep
        mov word ptr [StartBGM_+1],StartBGMBeep
        mov word ptr [StopBGM_+1],StopBGMBeep
    else
        mov word ptr [SoundHandler+1],SoundHandlerOpn
        mov word ptr [Sound_Beep_+1],Sound_BeepOpn
        mov word ptr [Sound_Get_+1],Sound_GetOpn
        mov word ptr [Sound_Hit_+1],Sound_HitOpn
        mov word ptr [Sound_Loose_+1],Sound_LooseOpn
        mov word ptr [Sound_Start_+1],Sound_StartOpn
        mov word ptr [Sound_Clear_+1],Sound_ClearOpn
        mov word ptr [Sound_GameOver_+1],Sound_GameOverOpn
        mov word ptr [StartBGM_+1],StartBGMOpn
        mov word ptr [StopBGM_+1],StopBGMOpn
    endif
ret

cseg
SoundHandler: public SoundHandler
    jmp DefaultSegment:Dummy
Sound_Beep_: public Sound_Beep_
    jmp DefaultSegment:Dummy
Sound_Get_: public Sound_Get_
    jmp DefaultSegment:Dummy
Sound_Hit_: public Sound_Hit_
    jmp DefaultSegment:Dummy
Sound_Loose_: public Sound_Loose_
    jmp DefaultSegment:Dummy
Sound_Start_: public Sound_Start_
    jmp DefaultSegment:Dummy
Sound_Clear_: public Sound_Clear_
    jmp DefaultSegment:Dummy
Sound_GameOver_: public Sound_GameOver_
    jmp DefaultSegment:Dummy
StartBGM_: public StartBGM_
    jmp DefaultSegment:Dummy
StopBGM_: public StopBGM_
    jmp DefaultSegment:Dummy
