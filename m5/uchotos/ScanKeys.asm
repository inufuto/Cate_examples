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
ScanKeys_: public ScanKeys_
    push bc
        ld c,0

        in a,(30h)
        bit 0,a ; Ctrl
        if nz 
            set Keys_Bit_Button0,c
        endif
        bit 2,a ; Shift
        if nz
            set Keys_Bit_Button1,c
        endif
        ; bit 6,a ; Space
        ; if nz 
        ;     set Keys_Bit_Button0,c
        ; endif
        
        ; in a,(32h)
        ; bit 7,a ; I
        ; if nz 
        ;     set Keys_Bit_Up,c
        ; endif

        ; in a,(33h)
        ; bit 6,a ; J
        ; if nz 
        ;     set Keys_Bit_Left,c
        ; endif
        ; bit 7,a ; K
        ; if nz 
        ;     set Keys_Bit_Right,c
        ; endif

        in a,(34h)
        bit 0,a ; Z
        if nz 
            set Keys_Bit_Button0,c
        endif
        bit 1,a ; X
        if nz 
            set Keys_Bit_Button1,c
        endif
        ; bit 6,a ; M
        ; if nz 
        ;     set Keys_Bit_Down,c
        ; endif

        in a,(35h)
        bit 5,a ; /
        if nz 
            set Keys_Bit_Down,c
        endif

        in a,(36h)
        bit 2,a ; @
        if nz 
            set Keys_Bit_Up,c
        endif
        bit 5,a ; ;
        if nz 
            set Keys_Bit_Left,c
        endif
        bit 6,a ; :
        if nz 
            set Keys_Bit_Right,c
        endif


        in a,(37h)
        bit 0,a
        if nz 
            set Keys_Bit_Right,c
        endif
        bit 1,a
        if nz 
            set Keys_Bit_Up,c
        endif
        bit 2,a
        if nz 
            set Keys_Bit_Left,c
        endif
        bit 3,a
        if nz 
            set Keys_Bit_Down,c
        endif

        in a,(31h)
        bit 0,a
        if nz 
            set Keys_Bit_Button0,c
        endif
        bit 1,a
        if nz 
            set Keys_Bit_Button1,c
        endif

        ld a,c
    pop bc
ret 
