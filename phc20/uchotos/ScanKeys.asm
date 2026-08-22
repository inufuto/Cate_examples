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

; byte ScanKeys();
cseg
ScanKeys_: public ScanKeys_
    push bc
        ld c,0
        
        ld a,(3800h)
        bit 3,a ; X
        if z
            set Keys_Bit_Button1,c
        endif
        bit 5,a ; Down
        if z
            set Keys_Bit_Down,c
        endif

        ld a,(3801h)
        bit 3,a ; Z
        if z
            set Keys_Bit_Button0,c
        endif
        bit 5,a ; Return
        if z
            set Keys_Bit_Button1,c
        endif
        bit 6,a ; ;
        if z
            set Keys_Bit_Up,c
        endif
        bit 7,a ; /
        if z
            set Keys_Bit_Right,c
        endif
        
        ld a,(3802h)
        bit 5,a ; Right
        if z
            set Keys_Bit_Right,c
        endif
        
        ld a,(3803h)
        bit 5,a ; Up
        if z
            set Keys_Bit_Up,c
        endif
        bit 7,a ; Space
        if z
            set Keys_Bit_Button0,c
        endif

        ld a,(3805h)
        bit 5,a ; Left
        if z
            set Keys_Bit_Left,c
        endif

        ld a,(3807h)
        bit 3,a ; ,
        if z
            set Keys_Bit_Left,c
        endif
        bit 6,a ; L
        if z
            set Keys_Bit_UP,c
        endif
        bit 7,a ; .
        if z
            set Keys_Bit_Down,c
        endif

        ld a,c
    pop bc
ret