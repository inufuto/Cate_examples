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
scanBit: defb 0
results: defs 4
pResult: defw 0
    cseg
InitKey_: public InitKey_
    push af | push hl | push bc
        ld a,1
        ld (scanBit),a
        out (0fdh),a
        ld hl,results
        ld (pResult),hl

        ld b,4
        ld hl,results
        ld a,0ffh
        do
            ld (hl),a
            inc hl
        dwnz
    pop bc | pop hl | pop af
ret

UpdateScan_: public UpdateScan_
    push af | push hl
        in a,(0fdh)
        ld hl,(pResult)
        ld (hl),a
        inc hl
        ld a,(scanBit)
        add a,a
        and 0fh
        if z
            ld a,1
            ld hl,results
        endif
        ld (scanBit),a
        out (0fdh),a
        ld (pResult),hl
    pop hl | pop af
ret


ScanKeys_: public ScanKeys_
    push bc
        ld c,0

        ld a,(results+1)
        bit 0,a
        if nz 
            set Keys_Bit_Down,c
        endif
        bit 1,a
        if nz 
            set Keys_Bit_Right,c
        endif

        ld a,(results+2)
        bit 0,a
        if nz 
            set Keys_Bit_Left,c
        endif
        bit 1,a
        if nz 
            set Keys_Bit_Up,c
        endif

        ld a,(results+3)
        bit 0,a
        if nz 
            set Keys_Bit_Button0,c
        endif
        bit 1,a
        if nz 
            set Keys_Bit_Button1,c
        endif
        xor a | out (0fdh),a

        ld a,c
    pop bc
ret 
