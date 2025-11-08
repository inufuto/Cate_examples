ext Port3eh
ext InitSoundOpll,SoundHandlerOpll
ext Sound_StartOpll, Sound_GameOverOpll
ext StartBGMOpll,StopBGMOpll

ext InitSoundDcsg,SoundHandlerDcsg
ext Sound_StartDcsg, Sound_GameOverDcsg
ext StartBGMDcsg,StopBGMDcsg

Port_Opll equ 0f0h

dseg
SoundHandler: public SoundHandler
    defs 3
Sound_Start_: public Sound_Start_
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
    defw Sound_StartOpll, Sound_GameOverOpll
    defw StartBGMOpll,StopBGMOpll
DcsgAddresses:
    defw SoundHandlerOpll
    defw Sound_StartDcsg, Sound_GameOverDcsg
    defw StartBGMDcsg,StopBGMDcsg

ext ScanKeys_

cseg
InitSound: public InitSound
    call ScanKeys_
    or a
    jr nz,Dcsg

    ld a,(port3eh)
    or 04h
    out (3eh),a
    rst 30h

    ld bc,0*256
    do
        rst 30h
        xor a
        out (Port_Opll+2),a
        rst 30h
        in a,(Port_Opll+2)
        or a
        jr nz,InitSound_ne
    
        rst 30h
        ld a,1
        out (Port_Opll+2),a
        rst 30h
        in a,(Port_Opll+2)
        dec a
        if z
            ld c,1
            jr InitSound_eq
        endif
        InitSound_ne:
    dwnz
    InitSound_eq:
    ld a,(port3eh)
    and 0fbh
    out (3eh),a
    rst 30h
    dec c
    if z
        ld a,3
        out (Port_Opll+2),a
        rst 30h
        call InitSoundOpll
        ld de,OpllAddresses
    else
        Dcsg:
        call InitSoundDcsg
        ld de,DcsgAddresses
    endif
    ld b,5
    ld hl,SoundHandler
    do
        ld (hl),0c3h | inc hl
        ld a,(de) | inc de | ld (hl),a | inc hl
        ld a,(de) | inc de | ld (hl),a | inc hl
    dwnz
ret
