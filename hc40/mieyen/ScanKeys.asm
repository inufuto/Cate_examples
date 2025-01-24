include "hc40.inc"
                include "Vram.inc"
                ext  PrintByteNumber3_

Keys_Left equ 01h
Keys_Right equ 02h
Keys_Up equ 04h
Keys_Down equ 08h
Keys_Dir equ 0fh
Keys_Button0 equ 10h
Keys_Button1 equ 20h

Keys_Bit_Left equ 0
Keys_Bit_Right equ 1
Keys_Bit_Up equ 2
Keys_Bit_Down equ 3
Keys_Bit_Button0 equ 4
Keys_Bit_Button1 equ 5

dseg
saveVEC7508:
    defw 0
saveRZIER:
    defb 0
Stopped:
    defb 0
DirBits:
    defb 0
ButtonBits:
    defb 0
PrinterError:
    defb 0
JoystickAvailable_:  public JoystickAvailable_
    defb 0

cseg
InitKeys: public InitKeys
    xor a
    ld (Stopped),a
    ld (ButtonBits),a
    ld (DirBits),a
    ld (JoystickAvailable_),a
    out (PDR),a
    in a,(IOSTR)
    rrca | and 01h
    ld (PrinterError),a

    di
        ld a,0dh | call SendTo7508 ; 1 sec interrupt off

        ld a,09h | out (IER),a
        ld hl,(VEC7508) | ld (saveVEC7508),hl
        ld hl,KeyHandler | ld (VEC7508),hl
    ei
ret


ExitKeys: public ExitKeys
    di
        ld a,1dh | call SendTo7508 ; 1 sec interrupt on

        ld a,(RZIER) | out (IER),a
        ld hl,(saveVEC7508) | ld (VEC7508),hl
    ei
ret


KeyHandler: public KeyHandler
    push af
        ld a,02h | call SendTo7508 ; status / key
        call RecieveFrom7508
        cp 10h ; stop
        if z
            ld a,1 | ld (Stopped),a
            jr KeyHandler_exit
        endif
        cp 0b3h ; shift on
        if z
            ld a,(ButtonBits)
            or Keys_Button0
            ld (ButtonBits),a
            jr KeyHandler_exit
        endif
        cp 0a3h ; shift off
        if z
            ld a,(ButtonBits)
            and not Keys_Button0
            ld (ButtonBits),a
            jr KeyHandler_exit
        endif
        cp 0b2h ; ctrl on
        if z
            ld a,(ButtonBits)
            or Keys_Button1
            ld (ButtonBits),a
            jr KeyHandler_exit
        endif
        cp 0a2h ; ctrl off
        if z
            ld a,(ButtonBits)
            and not Keys_Button1
            ld (ButtonBits),a
            jr KeyHandler_exit
        endif
        cp 55h ; up
        if z
            ld a,Keys_Up
            ld (DirBits),a
            jr KeyHandler_exit
        endif
        cp 64h ; down
        if z
            ld a,Keys_Down
            ld (DirBits),a
            jr KeyHandler_exit
        endif
        cp 63h ; left
        if z
            ld a,Keys_Left
            ld (DirBits),a
            jr KeyHandler_exit
        endif
        cp 65h ; right
        if z
            ld a,Keys_Right
            ld (DirBits),a
            jr KeyHandler_exit
        endif
        xor a
        ld (DirBits),a
        KeyHandler_exit:
    pop af
ei | reti
SendTo7508:
    push af
        do
            in a,(STR)
            and 08h
        while z | wend
    pop af
    out (SIOR),a
    push af
        ld a,02h | out (CMDR),a
    pop af
ret
RecieveFrom7508:
    do
        in a,(STR)
        and 08h
    while z | wend
    in a,(SIOR)
ret


; byte ScanKeys();
cseg
PrinterTable:
    defb 01h,Keys_Right
    defb 02h,Keys_Left
    defb 04h,Keys_Up
    defb 08h,Keys_Down
    defb 10h,Keys_Button1
    defb 20h,Keys_Button0
    defb 0
ScanKeys_: public ScanKeys_
    push hl
        ld a,(PrinterError)
        or a
        if nz
            push bc
                ld c,0
                ld hl,PrinterTable
                do
                    ld a,(hl)
                    or a
                while nz
                    inc hl
                    out (PDR),a
                    ld b,30h
                    do
                    dwnz
                    in a,(IOSTR) | and 02h
                    if z
                        ld a,c
                        or (hl)
                        ld c,a
                    endif
                    inc hl
                wend
                ld a,c
            pop bc
            or a
            if nz
                push af
                    ld a,1
                    ld (JoystickAvailable_),a
                pop af
                jr ScanKeys_exit
            endif
        endif
        ld a,(JoystickAvailable_)
        or a
        if z
            ld hl,DirBits
            ld a,(hl) | inc hl
            or (hl)
        else
            xor a
        endif
        ScanKeys_exit:
    pop hl
ret


; bool ScanStop();
cseg
ScanStop_: public ScanStop_
    ld a,(Stopped)
    push af
        xor a
        ld (Stopped),a
    pop af
ret
