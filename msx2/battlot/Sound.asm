ext InitSoundOpll,SoundHandlerPsg
ext Sound_StartOpll,Sound_ClearOpll,Sound_GameOverOpll,StartBGMOpll,StopBGMOpll
ext InitSoundPsg,SoundHandlerOpll
ext Sound_StartPsg,Sound_ClearPsg,Sound_GameOverPsg,StartBGMPsg,StopBGMPsg

dseg
SoundHandler: public SoundHandler
    defs 3
Sound_Start_: public Sound_Start_
    defs 3
Sound_Clear_: public Sound_Clear_
    defs 3
Sound_GameOver_: public Sound_GameOver_
    defs 3
StartBGM_: public StartBGM_
    defs 3
StopBGM_: public StopBGM_
    defs 3

cseg
Dummy:
ret

OpllAddresses:
    defw SoundHandlerOpll
    defw Sound_StartOpll,Sound_ClearOpll,Sound_GameOverOpll,StartBGMOpll,StopBGMOpll
PsgAddresses:
    defw SoundHandlerPsg
    defw Sound_StartPsg,Sound_ClearPsg,Sound_GameOverPsg,StartBGMPsg,StopBGMPsg

cseg
InitSound: public InitSound
    call InitSoundPsg
    call InitSoundOpll
    or a
    if nz
        
        ld de,OpllAddresses
    else
        ld de,PsgAddresses
    endif
    ld b,6
    ld hl,SoundHandler
    do
        ld (hl),0c3h | inc hl
        ld a,(de) | inc de | ld (hl),a | inc hl
        ld a,(de) | inc de | ld (hl),a | inc hl
    dwnz
ret
