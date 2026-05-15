KEYOUT equ 11h
KEYIN equ 10h

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


Wait:
    push bc
        ld bc,50h
        do
            dec bc
            ld a,c
            or b
        while nz | wend
    pop bc
ret


; byte ScanKeys();
cseg
ScanKeys_: public ScanKeys_
    push bc
        ld c,0

        xor a | out (KEYOUT),a
        call Wait
        ld a,08h | out (KEYOUT),a
        call Wait
        in a,(KEYIN)
        bit 3,a ; Kana
        if nz
            set Keys_Bit_Button1,c
        endif
        bit 5,a ; SPACE
        if nz
            set Keys_Bit_Button0,c
        endif
        bit 6,a ; Down
        if nz
            set Keys_Bit_Down,c
        endif
        bit 7,a ; Up
        if nz
            set Keys_Bit_Up,c
        endif

        xor a | out (KEYOUT),a
        call Wait
        ld a,10h | out (KEYOUT),a
        in a,(KEYIN)
        bit 0,a ; Left
        if nz
            set Keys_Bit_Left,c
        endif
        bit 1,a ; Right
        if nz
            set Keys_Bit_Right,c
        endif

        ld a,c
    pop bc
ret 


; bool ScanStop();
cseg
ScanStop_: public ScanStop_
    xor a | out (KEYOUT),a
    call Wait
    ld a,10h | out (KEYOUT),a
    call Wait
    in a,(KEYIN)
    and 04h
    if nz
        ld a,1
    else
        xor a
    endif
ret
