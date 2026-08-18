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
InitKeys: public InitKeys
    in a,(1dh)
    and 04h
    if z
        ld hl,ScanKeys777
    else
        ld hl,ScanKeys70
    endif
    ld (ScanKeys_+1),hl
ret


ScanKeys_: public ScanKeys_
    jp 0
ScanKeys777:
    push bc
        call ReadJoystick
        
        in a,(1bh)
        bit 2,a
        if nz
            in a,(1ah)
            cp 9
            if z
                set Keys_Bit_Button1,c
            endif
        endif

        ld a,c
    pop bc
ret

ScanKeys70:
    push bc
        call ReadJoystick
        ld a,c
    pop bc
    or a
    ret nz

    in a,(1bh)
    and 04h
    ret z
    push de
        in a,(1ah) | ld e,a
        ld hl,KeyTable
        do
            ld a,(hl) | inc hl
            or a
        while nz
            cp e
            if z
                ld a,(hl)
                jp ScanKeys_break
            endif
            inc hl
        wend
        xor a
        ScanKeys_break:
    pop de
ret
KeyTable:
    defb 16h,Keys_Left ; Left
    defb 17h,Keys_Up ; Up
    defb 1ch,Keys_Down ; Down
    defb 19h,Keys_Right ; Right
    defb 20h,Keys_Button0 ; Space
    defb 09h,Keys_Button1 ; TAB
    defb 69h,Keys_Up ; I
    defb 6ah,Keys_Left ; J
    defb 6bh,Keys_Right ; K
    defb 6dh,Keys_Down ; M
    defb 75h,Keys_Left or Keys_Up ; U
    defb 6fh,Keys_Right or Keys_Up ; O
    defb 6eh,Keys_Left or Keys_Down ; N
    defb 2ch,Keys_Right or Keys_Down ; <
    defb 0

ReadJoystick:
    ld bc,151h
    in a,(c)
    or a | ret z

    ld c,0

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
ret