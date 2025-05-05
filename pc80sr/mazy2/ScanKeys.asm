Port_Keys equ 00h

Keys_Left equ 01h
Keys_Right equ 02h
Keys_Up equ 04h
Keys_Down equ 08h
Keys_Dir equ 0fh
Keys_Button0 equ 10h
Keys_Button1 equ 20h

Keys_Bit.Left equ 0
Keys_Bit.Right equ 1
Keys_Bit.Up equ 2
Keys_Bit.Down equ 3
Keys_Bit.Button0 equ 4
Keys_Bit.Button1 equ 5

ScanKeys_:   
public ScanKeys_
; out
;   a
    push bc
    ld c,0
    in a,(Port_Keys)
    bit 4,a ;'4'
    if z
        set Keys_Bit.Left,c
    endif
    bit 6,a ;'6'
    if z
        set Keys_Bit.Right,c
    endif
    bit 2,a ;'2'
    if z
        set Keys_Bit.Down,c
    endif
    
    in a,(Port_Keys+1)
    bit 0,a ;'8'
    if z
        set Keys_Bit.Up,c
    endif

    in a,(Port_Keys+7)
    bit 2,a ;':'
    if z
        set Keys_Bit.Up,c
    endif
    bit 3,a ;';'
    if z
        set Keys_Bit.Up,c
    endif
    bit 5,a ;'.'
    if z
        set Keys_Bit.Left,c
    endif
    bit 6,a ;'/'
    if z
        set Keys_Bit.Down,c
    endif
    bit 7,a ;'\'
    if z
        set Keys_Bit.Right,c
    endif

    in a,(Port_Keys+8)
    bit 4,a ;GRPH
    if z
        set Keys_Bit.Button1,c
    endif

    in a,(Port_Keys+9)
    bit 6,a ;SPACE
    if z
        set Keys_Bit.Button0,c
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