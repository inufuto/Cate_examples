ext PollVSync_

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


ScanKeys_: public ScanKeys_
    push bc
        call PollVSync_
        
        xor a

        ld bc,0feffh
        in b,(c)
        bit 3,b ; RTN
        if z
            set Keys_Bit_Button0,a
        endif
        bit 5,b ; .
        if z
            set Keys_Bit_Right,a
        endif

        ld b,0fdh
        in b,(c)
        bit 4,b ; L
        if z
            set Keys_Bit_Up,a
        endif
        bit 5,b ; ,
        if z
            set Keys_Bit_Down,a
        endif

        ld b,0fbh
        in b,(c)
        bit 2,b ; K
        if z
            set Keys_Bit_Up,a
        endif
        bit 3,b ; M
        if z
            set Keys_Bit_Left,a
        endif

        ld b,0efh
        in b,(c)
        bit 4,b ; C
        if z
            set Keys_Bit_Right,a
        endif

        ld b,0dfh
        in b,(c)
        bit 4,b ; D
        if z
            set Keys_Bit_Up,a
        endif
        bit 5,b ; X
        if z
            set Keys_Bit_Down,a
        endif

        ld b,0bfh
        in b,(c)
        bit 2,b ; S
        if z
            set Keys_Bit_Up,a
        endif
        bit 3,b ; Z
        if z
            set Keys_Bit_Left,a
        endif
        bit 4,b ; Space
        if z
            set Keys_Bit_Button0,a
        endif

        ld b,07fh
        in b,(c)
        bit 4,b ; Shift
        if z
            set Keys_Bit_Button1,a
        endif
    pop bc
ret
