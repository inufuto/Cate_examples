ext Port3eh
ext InitSoundOpll,SoundHandlerDcsg,Sound_LooseOpll,Sound_HitOpll,Sound_AttackOpll,Sound_UpOpll
ext Sound_StartOpll,Sound_ClearOpll,Sound_GameOverOpll,StartBGMOpll,StopBGMOpll
ext InitSoundDcsg,SoundHandlerOpll,Sound_LooseDcsg,Sound_HitDcsg,Sound_AttackDcsg,Sound_UpDcsg
ext Sound_StartDcsg,Sound_ClearDcsg,Sound_GameOverDcsg,StartBGMDcsg,StopBGMDcsg

Port_Opll equ 0f0h

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
DcsgAddresses:
    defw SoundHandlerDcsg,Sound_LooseDcsg,Sound_HitDcsg,Sound_AttackDcsg,Sound_UpDcsg
    defw Sound_StartDcsg,Sound_ClearDcsg,Sound_GameOverDcsg,StartBGMDcsg,StopBGMDcsg

cseg
InitSound: public InitSound
    ld a,(port3eh)
    or 04h
    out (3eh),a
    rst 30h

    ld bc,100*256
    do
        xor a
        out (Port_Opll+2),a
        rst 30h
        in a,(Port_Opll+2)
        or a
        jr nz,InitSoundne
    
        ld a,1
        out (Port_Opll+2),a
        rst 30h
        in a,(Port_Opll+2)
        dec a
        if z
            ld c,1
            jr InitSoundeq
        endif
        InitSoundne:
    dwnz
    InitSoundeq:
    ld a,(port3eh)
    and 0fbh
    out (3eh),a
    rst 30h
    dec c
    if z
        call InitSoundOpll
        ld de,OpllAddresses
    else
        Dcsg:
        call InitSoundDcsg
        ld de,DcsgAddresses
    endif
    ld b,10
    ld hl,SoundHandler
    do
        ld (hl),0c3h | inc hl
        ld a,(de) | inc de | ld (hl),a | inc hl
        ld a,(de) | inc de | ld (hl),a | inc hl
    dwnz
ret
