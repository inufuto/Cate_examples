Port_Keys equ 00h

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

ScanKeys_:   
public ScanKeys_
; out
;   a
    push bc
        ld c,0
        in a,(Port_Keys)
        bit 4,a ;'4'
        if z
            set Keys_Bit_Left,c
        endif
        bit 6,a ;'6'
        if z
            set Keys_Bit_Right,c
        endif
        bit 2,a ;'2'
        if z
            set Keys_Bit_Down,c
        endif
        
        in a,(Port_Keys+1)
        bit 0,a ;'8'
        if z
            set Keys_Bit_Up,c
        endif

        in a,(Port_Keys+3)
        bit 1,a ;'I'
        if z
            set Keys_Bit_Up,c
        endif
        bit 2,a ;'J'
        if z
            set Keys_Bit_Left,c
        endif
        bit 3,a ;'K'
        if z
            set Keys_Bit_Right,c
        endif
        bit 5,a ;'M'
        if z
            set Keys_Bit_Down,c
        endif

        in a,(Port_Keys+8)
        bit 1,a ;Up
        if z
            bit 6,a ;Shift
            if z
                set Keys_Bit_Down,c
            else
                set Keys_Bit_Up,c
            endif
        endif
        bit 2,a ;Right
        if z
            bit 6,a ;Shift
            if z
                set Keys_Bit_Left,c
            else
                set Keys_Bit_Right,c
            endif
        endif
        bit 4,a ;GRPH
        if z
            set Keys_Bit_Button1,c
        endif

        in a,(Port_Keys+9)
        bit 6,a ;SPACE
        if z
            set Keys_Bit_Button0,c
        endif

        in a,(Port_Keys+10)
        bit 1,a ;Down
        if z
            set Keys_Bit_Down,c
        endif
        bit 2,a ;Left
        if z
            set Keys_Bit_Left,c
        endif

        in a,(31h)
        and 80h
        if z
            ld a,14
            out (44h),a
            in a,(45h)
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

            ld a,15
            out (44h),a
            in a,(45h)
            bit 0,a
            if z
                set Keys_Bit_Button0,c
            endif
            bit 1,a
            if z
                set Keys_Bit_Button1,c
            endif
        endif
        
        ld a,c
    pop bc
ret 

ScanStop_:
    public ScanStop_
    in a,(Port_Keys+9)
    and 1
    xor 1
ret 