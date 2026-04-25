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

; extern byte ScanKeys();
cseg
WaitKey:
    ret
KeyBytes:
    defb 2
    defb 04h,Keys_Up ; :
    defb 08h,Keys_Up ; ;
    defb 40h,Keys_Left ; .
    defb 80h,Keys_Down ; /
    defb 0
    defb 6
    defb 01h,Keys_Button1 ; X
    defb 04h,Keys_Button0 ; Z
    defb 80h,Keys_Right ; LR
    defb 0
    defb 7
    defb 01h,Keys_Button0 ; Space
    defb 02h,Keys_Down
    defb 04h,Keys_Up
    defb 08h,Keys_Right
    defb 10h,Keys_Left
    defb 0
    defb 9
    defb 04h,Keys_Button1 ; Shift
    defb 0
    defb 10
    defb 01h,Keys_Up
    defb 02h,Keys_Up or Keys_Left
    defb 04h,Keys_Left
    defb 08h,Keys_Button0
    defb 0
    defb 11
    defb 01h,Keys_Down or Keys_Left
    defb 02h,Keys_Up or Keys_Right
    defb 0
    defb 12
    defb 01h,Keys_Down
    defb 02h,Keys_Down or Keys_Right
    defb 04h,Keys_Right
    defb 08h,Keys_Button1
    defb 0
    defb 0
ScanKeys_: public ScanKeys_
    push hl | push de | push bc
        ld c,0
        ld hl,KeyBytes
        do
            ld a,(hl) | inc hl
            or a
        while nz
            out (0f4h),a
            call WaitKey
            in a,(0f4h)
            ld e,a
            do
                ld b,(hl) | inc hl
                inc b | dec b
            while nz
                ld a,e
                and b
                if nz
                    ld a,(hl)
                    or c
                    ld c,a
                endif
                inc hl
            wend
        wend
        ld a,c
    pop bc | pop de | pop hl
ret
