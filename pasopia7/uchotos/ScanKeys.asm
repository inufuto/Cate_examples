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

PortABits equ 90h
PortA equ 0e8h
PortC equ 0eah

RamBios equ 8800h

cseg
InitKeys: public InitKeys
    ld hl,CallBIOS
    ld de,RamBios
    ld bc,JoyTable-CallBIOS
    ldir
ret
CallBIOS:
    di
        in a,(22h)
        and 01h
        out (3ch),a
        call 5
        push af
            in a,(22h)
            and 03h
            or 02h
            out (3ch),a
        pop af
    ei
ret
JoyTable:
    defb Keys_Up, Keys_Up or Keys_Right, Keys_Right, Keys_Right or Keys_Down
    defb Keys_Down, Keys_Down or Keys_Left, Keys_Left, Keys_Left or Keys_Up
ScanKeys_: public ScanKeys_
    push bc
        ld c,0
        di
            ld a,11h
            out (30h),a
            in a,(31h)
            bit 0,a ;GRPH
            if z
                set Keys_Bit_Button1,c
            endif
            ld b,a

            ld a,12h
            out (30h),a
            in a,(31h)
            bit 2,a ;2
            if z
                set Keys_Bit_Down,c
            endif
            bit 4,a ;4
            if z
                set Keys_Bit_Left,c
            endif
            bit 6,a ;6
            if z
                set Keys_Bit_Right,c
            endif

            ld a,14h
            out (30h),a
            in a,(31h)
            bit 0,a ;8
            if z
                set Keys_Bit_Up,c
            endif

            ld a,18h
            out (30h),a
            in a,(31h)
            bit 0,a ;Right
            if z
                set Keys_Bit_Right,c
            endif

            ld a,21h
            out (30h),a
            in a,(31h)
            bit 4,a ;Left
            if z
                set Keys_Bit_Left,c
            endif
            bit 5,a ;Up/Down
            if z
                bit 1,b
                if z
                    set Keys_Bit_Down,c
                else
                    set Keys_Bit_Up,c
                endif
            endif
            bit 7,a ;SPACE
            if z
                set Keys_Bit_Button0,c
            endif

            ld a,42h
            out (30h),a
            in a,(31h)
            bit 4,a ;J
            if z
                set Keys_Bit_Left,c
            endif
            bit 5,a ;I
            if z
                set Keys_Bit_Up,c
            endif

            ld a,44h
            out (30h),a
            in a,(31h)
            bit 5,a ;K
            if z
                set Keys_Bit_Right,c
            endif

            ld a,48h
            out (30h),a
            in a,(31h)
            bit 4,a ;M
            if z
                set Keys_Bit_Down,c
            endif
        ei
        push bc
            ld bc,151h
            call RamBios
        pop bc
        or a
        if nz
            push hl
                add a,low(JoyTable-1) | ld l,a
                ld a,0 | adc a,high(JoyTable-1) | ld h,a
                ld a,c
                or (hl)
                ld c,a
            pop hl
        endif
        push bc
            ld bc,152h
            call RamBios
        pop bc
        or a
        if nz
            set Keys_Bit_Button0,c
        endif
        ld a,c
    pop bc
ret
