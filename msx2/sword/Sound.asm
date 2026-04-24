ext InitSoundOpll,SoundHandlerPsg,Sound_LooseOpll,Sound_HitOpll,Sound_AttackOpll,Sound_UpOpll
ext Sound_StartOpll,Sound_ClearOpll,Sound_GameOverOpll,StartBGMOpll,StopBGMOpll
ext InitSoundPsg,SoundHandlerOpll,Sound_LoosePsg,Sound_HitPsg,Sound_AttackPsg,Sound_UpPsg
ext Sound_StartPsg,Sound_ClearPsg,Sound_GameOverPsg,StartBGMPsg,StopBGMPsg

dseg
SoundHandler: public SoundHandler
    defs 3
Sound_Loose_: public Sound_Loose_
    defs 3
Sound_Hit_: public Sound_Hit_
    defs 3
Sound_Attack_: public Sound_Attack_
    defs 3
Sound_Up_: public Sound_Up_
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
    defw SoundHandlerOpll,Sound_LooseOpll,Sound_HitOpll,Sound_AttackOpll,Sound_UpOpll
    defw Sound_StartOpll,Sound_ClearOpll,Sound_GameOverOpll,StartBGMOpll,StopBGMOpll
PsgAddresses:
    defw SoundHandlerPsg,Sound_LoosePsg,Sound_HitPsg,Sound_AttackPsg,Sound_UpPsg
    defw Sound_StartPsg,Sound_ClearPsg,Sound_GameOverPsg,StartBGMPsg,StopBGMPsg

cseg
InitSound: public InitSound
    call InitSoundOpll
    or a
    if nz
        
        ld de,OpllAddresses
    else
        Psg:
        call InitSoundPsg
        ld de,PsgAddresses
    endif
    ld b,10
    ld hl,SoundHandler
    do
        ld (hl),0c3h | inc hl
        ld a,(de) | inc de | ld (hl),a | inc hl
        ld a,(de) | inc de | ld (hl),a | inc hl
    dwnz
ret
