include "Port.inc"

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

HTAB equ 9
PaperEmpty equ 20h

dseg
PortAvailable:
    defb 0
JoystickAvailable:
    defb 0

cseg
InitKeys: public InitKeys
    ld a,0ffh | out (Ppi2B),a
    in a,(Ppi2A) | and PaperEmpty
    ld (PortAvailable),a
    xor a
    ld (JoystickAvailable),a
ret


; byte ScanKeys();
cseg
CodeTable:
    defb 'W',Keys_Up
    defb 'E',Keys_Up
    defb 'A',Keys_Left
    defb 'S',Keys_Down
    defb 'D',Keys_Right
    defb 'Z',Keys_Button1
    defb 0
PrinterTable:
    defb not 01h,Keys_Right
    defb not 02h,Keys_Left
    defb not 04h,Keys_Up
    defb not 08h,Keys_Down
    defb not 010h,Keys_Button1
    defb not 020h,Keys_Button0
    defb 0
ScanKeys_: public ScanKeys_
    push hl | push de
        ld a,(PortAvailable)
        or a
        if nz
            ld e,0
            ld hl,PrinterTable
            do
                ld a,(hl) | inc hl
                or a
            while nz
                out (Ppi2B),a
                in a,(Ppi2A) | and PaperEmpty
                if z
                    _deb: public _deb
                    ld a,(hl)
                    or e | ld e,a
                endif
                inc hl
            wend
            ld a,e
            or a
            if nz
                ld (JoystickAvailable),a
                jr ScanKeys_exit
            endif
            ld a,(JoystickAvailable)
            if nz
                xor a
                jr ScanKeys_exit
            endif
        endif

        in a,(Ppi1B) | ld e,a
        ld hl,CodeTable
        do
            ld a,(hl) | inc hl
            or a
        while nz
            cp e
            if z
                ld a,(hl)
                jr ScanKeys_break
            endif
            inc hl
        wend
        xor a
        ScanKeys_break:
        ld e,a
        in a,(Ppi1C)
        and 10h ; [SLOW]Key
        ld a,e
        if z
            or Keys_Button0
        endif
        ScanKeys_exit:
    pop de | pop hl 
ret