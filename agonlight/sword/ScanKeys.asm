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

; byte ScanKeys();
cseg
ScanKeys_: public ScanKeys_
    push de | push ix
        ld a,1eh
        defb 49h | rst 08h
        
        defb 49h | ld a,(ix+0)

        ld e,0
        defb 49h | ld a,(ix+3)
        and 02h
        if nz
            set Keys_Bit_Left,e
        endif
        defb 49h | ld a,(ix+5)
        and 02h
        if nz
            set Keys_Bit_Down,e
        endif
        defb 49h | ld a,(ix+7)
        and 02h
        if nz
            set Keys_Bit_Up,e
        endif
        defb 49h | ld a,(ix+8)
        and 04h
        if nz
            set Keys_Bit_Button1,e
        endif
        defb 49h | ld a,(ix+12)
        and 02h
        if nz
            set Keys_Bit_Button0,e
        endif
        defb 49h | ld a,(ix+15)
        and 02h
        if nz
            set Keys_Bit_Right,e
        endif
        ld a,e
    pop ix | pop de
ret


; ; byte ScanKeysWait();
; cseg
; ScanKeysWait_: public ScanKeysWait_
;     push bc
;         ld b,100
;         do
;             call ScanKeys_
;             or a
;             jr z,ScanKeysWait_off
;         dwnz
;         ScanKeysWait_off:
;     pop bc
; ret