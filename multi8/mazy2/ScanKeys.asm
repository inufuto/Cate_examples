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
JoystickAvailable_:  public JoystickAvailable_
    defb 0

cseg
InitKey: public InitKey
    push af
        ld a,0ffh | out (10h),a
        nop | nop | nop
        in a,(28h)
        and 1
        ld (JoystickAvailable_),a
    pop af
ret


PrinterTable:
    defb 0feh,Keys_Right
    defb 0fdh,Keys_Left
    defb 0fbh,Keys_Up
    defb 0f7h,Keys_Down
    defb 0efh,Keys_Button1
    defb 0dfh,Keys_Button0
    defb 0
keyTable:
    defb '1', Keys_Left or Keys_Down
    defb '2', Keys_Down
    defb '3', Keys_Right or Keys_Down
    defb '4', Keys_Left
    defb '6', Keys_Right
    defb '7', Keys_Left or Keys_Up
    defb '8', Keys_Up
    defb '9', Keys_Right or Keys_Up
    defb 1dh, Keys_Left
    defb 1ch, Keys_Right
    defb 1fh, Keys_Down
    defb 1eh, Keys_Up
    defb 20h, Keys_Button0
    defb 0dh, Keys_Button1
ScanKeys_:   public ScanKeys_
; out
;   a
    ld a,(JoystickAvailable_)
    or a
    if nz
        push hl | push bc
            ld c,0
            ld hl,PrinterTable
            do
                ld a,(hl)
                or a
            while nz
                inc hl
                out (10h),a
                nop | nop | nop
                in a,(28h) | and 1
                if z
                    ld a,c
                    or (hl)
                    ld c,a
                endif
                inc hl
            wend
            ld a,c
        pop bc | pop hl
        or a
        ret nz
    endif

    in a,(01h)
    and 8
    if z
        in a,(00h)
        push hl | push de | push hl
            ld c,0
            ld hl,keyTable
            ld b,14
            do
                cp (hl)
                if z
                    inc hl
                    ld c,(hl)
                    jr break
                endif
                inc hl
                inc hl
            dwnz
            break:
            ld a,c
        pop hl | pop de | pop bc
    else
        in a,(00h)
        xor a
    endif
ret 

ScanStop_: public ScanStop_
    in a,(01h)
    and 8
    if z
        in a,(00h)
        cp 3
        jr nz,off
        ld a,1
    else
        off:
        xor a
    endif
ret
