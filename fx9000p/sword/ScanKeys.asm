BankPort equ 4ff0h

Keys_Left equ 01h
Keys_Right equ 02h
Keys_Up equ 04h
Keys_Down equ 08h
Keys_Dir equ 0fh
Keys_Button0 equ 10h
Keys_Button1 equ 20h

dseg
JoystickAvailable:
    defb 0

cseg
InitKeys: public InitKeys
    ld a,(BankPort)
    and 3fh
    cp 3fh
    if z
        ld a,1
    else
        xor a
    endif
    ld (JoystickAvailable),a
ret


; byte ScanKeys();
cseg
CodeTable:
    ; defb 16h,Keys_Up
    ; defb 18h,Keys_Left
    ; defb 17h,Keys_Down
    ; defb 19h,Keys_Right
    defb 38h,Keys_Up ;8
    defb 34h,Keys_Left ;4
    defb 36h,Keys_Right ;6
    defb 32h,Keys_Down ; 2
    defb 5ah,Keys_Button0 ; Z
    defb 58h,Keys_Button1 ; X
    ; defb 14h,Keys_Up
    ; defb 89h,Keys_Left
    ; defb 15h,Keys_Down
    ; defb 8ah,Keys_Right
    defb 0bh,Keys_Up ;8
    defb 07h,Keys_Left ;4
    defb 09h,Keys_Right ;6
    defb 05h,Keys_Down ; 2
    defb 0
ScanKeys_: public ScanKeys_
    push hl | push de
        ld a,(8319h) | ld e,a
        ld hl,CodeTable
        do
            ld a,(hl) | inc hl
            or a
        while nz
            cp e
            if z
                ld a,(hl)
                jr ScanKeys_exit
            endif
            inc hl
        wend
        xor a
        ScanKeys_exit:
        ld e,a
        ld a,(6001h)
        and 1
        if z
            ld a,e
            or Keys_Button0
            ld e,a
        endif
        ld a,(JoystickAvailable)
        or a
        if nz
            ld a,(BankPort)
            cpl
            and 3fh
            or e
            ld e,a
        endif
        ld a,e
    pop de | pop hl
ret
