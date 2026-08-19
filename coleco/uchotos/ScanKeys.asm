Keys_Left equ 01h
Keys_Right equ 02h
Keys_Up equ 04h
Keys_Down equ 08h
Keys_Dir equ 0fh
Keys_Button0 equ 10h
Keys_Button1 equ 20h

cseg
BitTable:
    defb 01h, Keys_Up
    defb 02h, Keys_Right
    defb 04h, Keys_Down
    defb 08h, Keys_Left
    defb 40h, Keys_Button0

ScanKeys_: public ScanKeys_
    push hl | push de | push bc
        call 1f76h
        xor a
        ex af,af'
            ld a,(73eeh) | ld c,a
            ld hl,BitTable
            ld b,5
            do
                ld e,(hl) | inc hl
                ld d,(hl) | inc hl
                ld a,c
                and e
                if nz
                    ex af,af'
                        or d
                    ex af,af'
                endif
            dwnz
        ex af,af'
    pop bc | pop de | pop hl
    ;     ld a,(73f0h)
    ;     bit 6,a
    ;     if nz
    ;         set Keys_Bit_Button1,c
    ;     endif
    ;     ld a,c
ret 
