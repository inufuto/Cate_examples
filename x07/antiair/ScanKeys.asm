ext SubParam, Sub01

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
PrevKey: 
    defb 0

cseg
InitKeys: public InitKeys
    xor a | ld (PrevKey),a
ret


; byte ScanKeys();
cseg
ScanKeys_: public ScanKeys_
    ; ld a,02h or 80h
    ; call Sub01
    ; cp 31h
    ; if z
    ;     ld a,Keys_Up
    ;     jr ScanKeys_exit
    ; endif
    ; cp 33h
    ; if z
    ;     ld a,Keys_Right
    ;     jr ScanKeys_exit
    ; endif
    ; cp 35h
    ; if z
    ;     ld a,Keys_Down
    ;     jr ScanKeys_exit
    ; endif
    ; cp 37h
    ; if z
    ;     ld a,Keys_Left
    ;     jr ScanKeys_exit
    ; endif

    ; ld a,04h or 80h
    ; call Sub01
    ; or a
    ; if z
    ;     ld a,Keys_Button0
    ;     jr ScanKeys_exit
    ; endif
    ; xor a
    ; ScanKeys_exit:
    ;----
    push hl | push de | push bc
        ld hl,0100h | ld (SubParam),hl
        ld bc,0201h
        ld hl,SubParam
        ld de,26eh
        ld a,27h
        call 0c92fh
        ld a,(26eh)
        ld (PrevKey),a
        
        ld c,0
        bit 2,a
        if nz 
            set Keys_Bit_Right,c
        endif
        bit 3,a
        if nz 
            set Keys_Bit_Left,c
        endif
        bit 4,a
        if nz 
            set Keys_Bit_Up,c
        endif
        bit 5,a
        if nz 
            set Keys_Bit_Down,c
        endif
        bit 6,a ; Space
        if nz 
            set Keys_Bit_Button0,c
        endif
        bit 0,a ; INS
        if nz 
            set Keys_Bit_Button1,c
        endif
        ld a,c
    pop bc | pop de | pop hl
ret


; bool ScanStop();
cseg
ScanStop_: public ScanStop_
    ; call 0c90ah
    ; if nz
    ;     cp 'Q'
    ;     if z
    ;         ld a,1
    ;         jr ScanStop_exit
    ;     endif
    ; endif
    ; xor a
    ; ScanStop_exit:
    ;----
    ld a,(PrevKey)
    and 02h
    if nz
        ld a,1
    else
        xor a
    endif
ret
