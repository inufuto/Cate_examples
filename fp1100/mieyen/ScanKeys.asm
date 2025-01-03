include "SubMain_.inc"

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

ext SendSub

    cseg
ScanKeys_:   public ScanKeys_
    push de | push bc
        ld c,0

        ld b,1
        call Scan
        bit 0,a ; SHIFT
        if nz
            set Keys_Bit_Button1,c
        endif

        ld b,5
        call Scan
        bit 2,a ; 6
        if nz
            set Keys_Bit_Right,c
        endif
        bit 5,a ; Right
        if nz
            set Keys_Bit_Right,c
        endif

        ld b,6
        call Scan
        bit 6,a ; SPACE
        if nz
            set Keys_Bit_Button0,c
        endif

        ld b,7
        call Scan
        bit 2,a ; 8
        if nz
            set Keys_Bit_Up,c
        endif
        bit 5,a ; Down
        if nz
            set Keys_Bit_Down,c
        endif

        ld b,8
        call Scan
        bit 5,a ; Up
        if nz
            set Keys_Bit_Up,c
        endif
        bit 6,a ; 2
        if nz
            set Keys_Bit_Down,c
        endif

        ld b,9
        call Scan
        bit 2,a ; 4
        if nz
            set Keys_Bit_Left,c
        endif

        ld b,10
        call Scan
        bit 5,a ; Left
        if nz
            set Keys_Bit_Left,c
        endif

        ld a,c
    pop bc | pop de
ret

Scan:
    push de | push bc
        ld a,low Sub.Address
        call SendSub
        ld de,0e400h
        ld a,e
        call SendSub
        ld a,d
        call SendSub

        ld a,low Sub.Store
        call SendSub
        ld a,b
        or 20h
        call SendSub

        ld a,low Sub.Scan
        call SendSub

        ld bc,0ff80h
        do
            in a,(c)
            bit 7,a
        while z | wend
        and not 80h
        
        ld e,0C0h
        out (c),e
        ld e,20h
        out (c),e

        do
            in e,(c)
            bit 7,e
        while nz | wend
    pop bc | pop de
ret
