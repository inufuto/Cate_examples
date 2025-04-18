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
KeyboardAvialable_: public KeyboardAvialable_
    defb 0

cseg

InitKeys_: public InitKeys_
    ld a,92h
    out (0dfh),a

    xor a
    out (0deh),a
    rst 30h
    in a,(0deh)
    or a
    if z
        inc a
    else
        xor a
    endif
    ld (KeyboardAvialable_),a
ret


Scan:
    out (0deh),a
    in a,(0dch)
ret

ScanKeys_: public ScanKeys_
    push bc
        ld c,0

        ld a,(KeyboardAvialable_)
        or a
        if nz
            ld a,1 | call Scan
            bit 4,a ; Space
            if z 
                set Keys_Bit_Button0,c
            endif

            ld a,4 | call Scan
            bit 5,a
            if z 
                set Keys_Bit_Down,c
            endif

            ld a,5 | call Scan
            bit 5,a
            if z 
                set Keys_Bit_Left,c
            endif

            ld a,6 | call Scan
            bit 5,a
            if z 
                set Keys_Bit_Right,c
            endif
            bit 6,a
            if z 
                set Keys_Bit_Up,c
            endif
            in a,(0ddh)
            bit 1,a
            if z 
                set Keys_Bit_Button1,c
            endif

            ld a,7 | call Scan
            bit 0,a
            if z 
                set Keys_Bit_Up,c
            endif
            bit 1,a
            if z 
                set Keys_Bit_Down,c
            endif
            bit 2,a
            if z 
                set Keys_Bit_Left,c
            endif
            bit 3,a
            if z 
                set Keys_Bit_Right,c
            endif
            bit 4,a
            if z 
                set Keys_Bit_Button0,c
            endif
            bit 5,a
            if z 
                set Keys_Bit_Button1,c
            endif
        else
            in a,(0dch)
            bit 0,a
            if z
                set Keys_Bit_Up,c
            endif
            bit 1,a
            if z
                set Keys_Bit_Down,c
            endif
            bit 2,a
            if z
                set Keys_Bit_Left,c
            endif
            bit 3,a
            if z
                set Keys_Bit_Right,c
            endif
            bit 4,a
            if z
                set Keys_Bit_Button0,c
            endif
            bit 5,a
            if z
                set Keys_Bit_Button1,c
            endif
        endif

        ld a,c
    pop bc
ret 
