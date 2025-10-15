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

dseg
JoystickAvailable:
    defb 0

cseg
ReadStick:
    push bc
        ld a,7 | out (0c1h),a
        in a,(0c1h) | ld b,a
        ld a,80h | out (0c0h),a

        ld a,15 | out (0c1h),a
        ld a,0c0h | out (0c0h),a

        ld a,14 | out (0c1h),a
        in a,(0c1h) | ld c,a
        
        ld a,7 | out (0c1h),a
        ld a,b | out (0c0h),a
        ld a,c
    pop bc
ret
InitKeys: public InitKeys
    call ReadStick
    and 1fh
    cp 1fh
    if z
        ld a,1
    else
        xor a
    endif
    ld (JoystickAvailable),a
ret

cseg
KeyTable:
    defb 06h,Keys_Button0 ; Space
    defb 1dh,Keys_Down ; 2
    defb 2ch,Keys_Left ; 4
    defb 2eh,Keys_Right ; 6
    defb 3eh,Keys_Up ; 8
    defb 49h,Keys_Left ; Left
    defb 4ah,Keys_Right ; Right
    defb 4bh,Keys_Up ; Up
    defb 4ch,Keys_Down ; Down
    defb 50h,Keys_Button1 ; Left Shift
    defb 51h,Keys_Button1 ; Right Shift
ScanKeys_:
    public ScanKeys_
    push hl | push de | push bc
        ld c,0
        ld a,(JoystickAvailable)
        or a
        if nz
            call ReadStick
            bit 0,a ; Up
            if z
                set Keys_Bit_Up,c
            endif
            bit 1,a ; Down
            if z
                set Keys_Bit_Down,c
            endif
            bit 2,a ; Left
            if z
                set Keys_Bit_Left,c
            endif
            bit 3,a ; Right
            if z
                set Keys_Bit_Right,c
            endif
            bit 4,a ; Button0
            if z
                set Keys_Bit_Button0,c
            endif
            bit 5,a ; Button1
            if z
                set Keys_Bit_Button1,c
            endif
        endif

        ld b,11
        ld hl,KeyTable
        ld d,78h
        do
            ld e,(hl)
            inc hl
            ld a,(de)
            and 1
            if z
                ld a,c
                or (hl)
                ld c,a
            endif
            inc hl
        dwnz
        ld a,c
    pop bc | pop de | pop hl
ret 
