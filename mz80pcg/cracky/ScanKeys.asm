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

ScanKeys_:   public ScanKeys_
    push bc
        ld c,0

        ld a,80h or 2 | ld (0e000h),a | ld a,(0e001h)
        bit 3,a ; U
        if z
            set Keys_Bit_Up,c
        endif

        ld a,80h or 3 | ld (0e000h),a | ld a,(0e001h)
        bit 3,a ; I
        if z
            set Keys_Bit_Up,c
        endif

        ld a,80h or 4 | ld (0e000h),a | ld a,(0e001h)
        bit 3,a ; J
        if z
            set Keys_Bit_Left,c
        endif

        ld a,80h or 5 | ld (0e000h),a | ld a,(0e001h)
        bit 2,a ; H
        if z
            set Keys_Bit_Left,c
        endif
        bit 3,a ; K
        if z
            set Keys_Bit_Right,c
        endif

        ld a,80h or 6 | ld (0e000h),a | ld a,(0e001h)
        bit 3,a ; M
        if z
            set Keys_Bit_Down,c
        endif
        bit 7,a ; ッ
        if z
            set Keys_Bit_Up,c
        endif
        ld a,80h or 8 | ld (0e000h),a | ld a,(0e001h)
        bit 4,a ; CR
        if z
            set Keys_Bit_Button1,c
        endif
        bit 7,a ; ー
        if z
            set Keys_Bit_Down,c
        endif

        ld a,80h or 9 | ld (0e000h),a | ld a,(0e001h)
        bit 1,a ; SPACE
        if z
            set Keys_Bit_Button0,c
        endif
        bit 6,a ; ォ
        if z
            set Keys_Bit_Left,c
        endif
        bit 7,a ; 秒
        if z
            set Keys_Bit_Right,c
        endif

        ld a,c
    pop bc
ret 
