include "Share.inc"
include "Sub.inc"

ext InitKey, KeyboardInterrupt, ReadJoystick
ext ClearVram, DefChar, DrawChar1, DrawChar2
ext InitTimer, PollTimer, ResetTimerCount
ext InitSound, PlaySound

cseg
; The IPL interrupt trampoline jumps here after saving IX/IY.
    jp KeyboardInterrupt
defs 10
SubStart: public SubStart
    di
    call InitKey
    call MakeBusy

    ld c,TGdcParamPort
    ld hl,InitTGdc | call SendSeq

    ld a,07h | out (CrtControlPort + 1),a ; crt1 on
    ld a,01h | out (CrtControlPort + 4),a ; color mode

    ld c,GGdcParamPort
    ld hl,InitGGdc | call SendSeq
    im 1
    ei

    call InitSound
    call InitTimer

CmdLoop: public CmdLoop
    call MakeReady
    do
        call PollTimer
        ld a,(SubShareRam+Share_Command)
        or a
    while z | wend
    call MakeBusy
    call ReadJoystick

    dec a
    add a,a
    ld l,a | ld h,0
    ld de,JumpTable | add hl,de
    ld a,(hl) | inc hl
    ld h,(hl) | ld l,a
jp (hl)

JumpTable:
    defw CmdLoop,ClearVram,DefChar,DrawChar1,DrawChar2,ResetTimerCount,PlaySound

MakeBusy:
    push af
        ld a,80h | out (31h),a
    pop af
ret

MakeReady:
    push af
        xor a | ld (SubShareRam+Share_Command),a
        ld a,0c0h | out (31h),a
    pop af
ret

InitTGdc:
    defb CCharCmd,3, 0fh,0,0
    defb 0
InitGGdc:
    defb SyncCmd,8, 16h,26h,0a4h,14h,07h,0bh,90h,65h ; 400
    ; defb SyncCmd,8, 16h,26h,05h,1eh,08h,13h,0c8h,70h ; 200
    defb PitchCmd,1, 40
    defb PRamCmd,4, 0,0,0,19h
    defb FigsCmd,1, 2
    defb 0

WaitGdc:; c=port
    push af
        do
            in a,(c)
            and 2
        while nz | wend
    pop af
ret
SendSeq:; hl=pointer to sequence, c=port
    do
        ld a,(hl)
        or a
    while nz
        inc hl
        call WaitGdc
        inc c
        out (c),a
        dec c
        ld a,(hl) | inc hl
        or a
        if nz
            ld b,a
            do
                ld a,(hl) | inc hl
                call WaitGdc
                out (c),a
            dwnz
        endif
    wend
ret
