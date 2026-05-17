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

cseg
Table:
    defb 01h,Keys_Up
    defb 02h,Keys_Down
    defb 04h,Keys_Left
    defb 08h,Keys_Right
    defb 10h,Keys_Button0
    defb 20h,Keys_Button1

ScanKeys_: public ScanKeys_
    push hl | push de | push bc
        ld e,0
        in a,(0dch)
        ld c,a
        ld hl,Table
        ld b,6
        do
            ld a,c 
            ld d,(hl) | inc hl
            and d
            if z
                ld a,e
                or (hl)
                ld e,a
            endif
            inc hl
        dwnz
        ld a,e
    pop bc | pop de | pop hl
ret
