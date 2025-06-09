include "ngp.inc"
include "SubBin.inc"
include "Sound.inc"

ext SubBin
ext ClearWatchDogTimer_

cseg
InitSound: public InitSound
    ldw (Sound_Enable),0aaaah
    ld xhl,SubBin
    ld xde,SoundRam
    ld bc,SubBin_size
    ldir

    ld (SoundRam+SoundCmd),SoundCmd_init

    ldw (Sound_Enable),05555h
    
    do
        ld a,(SoundRam+SoundCmd)
        or a,a
    while nz | wend
ret


SendCmd:
    ld (SoundRam+SoundCmd),a
    do
        call ClearWatchDogTimer_
        ld a,(SoundRam+SoundCmd)
        or a,a
    while nz | wend
ret


Sound_Beep_: public Sound_Beep_
    push a
        ld a,SoundCmd_Beep
        call SendCmd
    pop a
ret


Sound_Get_: public Sound_Get_
    push a
        ld a,SoundCmd_Get
        call SendCmd
    pop a
ret


Sound_Hit_: public Sound_Hit_
    push a
        ld a,SoundCmd_Hit
        call SendCmd
    pop a
ret


Sound_Loose_: public Sound_Loose_
    push a
        ld a,SoundCmd_Loose
        call SendCmd
    pop a
ret


Sound_Start_: public Sound_Start_
    push a
        ld a,SoundCmd_Start
        call SendCmd
    pop a
ret


Sound_Clear_: public Sound_Clear_
    push a
        ld a,SoundCmd_Clear
        call SendCmd
    pop a
ret


Sound_GameOver_: public Sound_GameOver_
    push a
        ld a,SoundCmd_GameOver
        call SendCmd
    pop a
ret


StartBGM_: public StartBGM_
    push a
        ld a,SoundCmd_StartBGM
        call SendCmd
    pop a
ret


StopBGM_: public StopBGM_
    push a
        ld a,SoundCmd_StopBGM
        call SendCmd
    pop a
ret


WaitSound_: public WaitSound_
    do
        call ClearWatchDogTimer_
        cpw (SoundRam+SoundChannels),0
    while nz | wend
ret
