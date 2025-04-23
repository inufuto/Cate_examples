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
    di
        push bc
            xor a
            ld bc,0f782h | out (c),c
            ld bc,0f40eh | out (c),c
            ld bc,0f6c0h | out (c),c
            out (c),a
            ld bc,0f792h | out (c),c
            
            ld bc,0f640h | out (c),c
            ld b,0f4h | in c,(c)
            bit 0,c ; Up
            if z
                set Keys_Bit_Up,a
            endif
            bit 1,c ; Right
            if z
                set Keys_Bit_Right,a
            endif
            bit 2,c ; Down
            if z
                set Keys_Bit_Down,a
            endif

            ld bc,0f641h | out (c),c
            ld b,0f4h | in c,(c)
            bit 0,c ; Left
            if z
                set Keys_Bit_Left,a
            endif

            ld bc,0f642h | out (c),c
            ld b,0f4h | in c,(c)
            bit 5,c ; Shift
            if z
                set Keys_Bit_Button1,a
            endif

            ld bc,0f643h | out (c),c
            ld b,0f4h | in c,(c)
            bit 3,c ; P
            if z
                set Keys_Bit_Right,a
            endif

            ld bc,0f644h | out (c),c
            ld b,0f4h | in c,(c)
            bit 2,c ; O
            if z
                set Keys_Bit_Left,a
            endif

            ld bc,0f645h | out (c),c
            ld b,0f4h | in c,(c)
            bit 7,c ; Space
            if z
                set Keys_Bit_Button0,a
            endif

            ld bc,0f648h | out (c),c
            ld b,0f4h | in c,(c)
            bit 3,c ; Q
            if z
                set Keys_Bit_Up,a
            endif
            bit 5,c ; A
            if z
                set Keys_Bit_Down,a
            endif

            ld bc,0f649h | out (c),c
            ld b,0f4h | in c,(c)
            bit 0,c ; Up
            if z
                set Keys_Bit_Up,a
            endif
            bit 1,c ; Down
            if z
                set Keys_Bit_Down,a
            endif
            bit 2,c ; Left
            if z
                set Keys_Bit_Left,a
            endif
            bit 3,c ; Right
            if z
                set Keys_Bit_Right,a
            endif
            bit 4,c ; Fire1
            if z
                set Keys_Bit_Button0,a
            endif
            bit 5,c ; Fire2
            if z
                set Keys_Bit_Button1,a
            endif

            ld bc,0f782h | out (c),c            
        pop bc
    ei
ret
