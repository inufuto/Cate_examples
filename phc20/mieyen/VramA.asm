include "Vram.inc"
include "VVram.inc"

ext AsciiPattern, CharPattern
ext VVram_

CharHeight equ 6
VramTop equ Vram+VramWidth*(CharHeight+2)

dseg
Backup:
    defs VVramWidth*VVramHeight


; void ClearScreen();
cseg
Clear:
    do
        ld (hl),0 | inc hl
        dec bc
        ld a,b | or c
    while nz | wend
ret
ClearScreen_: public ClearScreen_
    push af | push hl | push bc
        ld hl,Vram
        ld bc,400h
        call Clear

        ld hl,Backup
        ld bc,VVramWidth*VVramHeight
        call Clear

        ld hl,VVram_
        ld bc,VVramWidth*VVramHeight
        call Clear
    pop bc | pop hl | pop af
ret


; ptr<byte> PrintC(ptr<byte> pVram, byte c);
cseg
CharTable:
    defb " 0123456789:ACEFGIMNOPRSTUVXZ"
PrintC_: public PrintC_
    push af | push hl | push de | push bc
        push hl
            ld bc,29*256
            ld hl,CharTable
            ld a,e
            do
                cp (hl)
                jr z,PrintC_break
                inc hl
                inc c
            dwnz
            ld c,0
            PrintC_break:
            ld a,c
        pop hl
        ex de,hl
            ld l,a
            ld h,0
            add hl,hl ; *2
            ld c,l | ld b,h
            add hl,hl ; *4
            add hl,bc ; *6
            ld bc,AsciiPattern | add hl,bc
        ex de,hl
        ld bc,VramWidth
        ld a,CharHeight
        do
            ex af,af'
                ld a,(de) | inc de
                ld (hl),a
            ex af,af'
            add hl,bc
            dec a
        while nz | wend
    pop bc | pop de | pop hl | pop af
    inc hl
ret


CharPtrDe:
    push hl
        ld l,e | ld h,0
        ld e,l | ld d,h
        add hl,hl ;*2
        add hl,de ;*3
        ld de,CharPattern | add hl,de
        ex de,hl
    pop hl
ret

WriteL:
    and 0f0h
    ld b,a
    ld a,(hl)
    and 0fh
    or b
    ld (hl),a
ret

WriteR:
    and 0fh
    ld b,a
    ld a,(hl)
    and 0f0h
    or b
    ld (hl),a
ret

NextY:
    ld a,l | add a,VramWidth | ld l,a
    ld a,h | adc a,0 | ld h,a
ret

; ptr<byte> Put3L(ptr<byte> pVram, byte c);
Put3L_: public Put3L_
    push af | push hl | push de | push bc
        call CharPtrDe
        ld a,(de) | inc de
        ld c,a
        call WriteL
        call NextY
        ld a,c
        rrca | rrca | rrca | rrca
        call WriteL
        call NextY
        ld a,(de)
        call WriteL
    pop bc | pop de | pop hl | pop af
ret

; ptr<byte> Put3R(ptr<byte> pVram, byte c);
Put3R_: public Put3R_
    push af | push hl | push de | push bc
        call CharPtrDe
        ld a,(de) | inc de
        ld c,a
        rrca | rrca | rrca | rrca
        call WriteR
        call NextY
        ld a,c
        call WriteR
        call NextY
        ld a,(de)
        rrca | rrca | rrca | rrca
        call WriteR
    pop bc | pop de | pop hl | pop af
    inc hl
ret

; ptr<byte> Put2L(ptr<byte> pVram, byte c);
Put2L_: public Put2L_
    push af | push hl | push de | push bc
        call CharPtrDe
        inc de | inc de
        ld a,(de)
        ld c,a
        call WriteL
        call NextY
        ld a,c
        rrca | rrca | rrca | rrca
        call WriteL
    pop bc | pop de | pop hl | pop af
ret

; ptr<byte> Put2R(ptr<byte> pVram, byte c);
Put2R_: public Put2R_
    push af | push hl | push de | push bc
        call CharPtrDe
        inc de | inc de
        ld a,(de)
        ld c,a
        rrca | rrca | rrca | rrca
        call WriteR
        call NextY
        ld a,c
        call WriteR
    pop bc | pop de | pop hl | pop af
    inc hl
ret


cseg
VVramToVramRow3:
    ld b,VVramWidth/2
    do 
        ld a,(de)
        inc de
        cp (hl)
        if nz
            ld (hl),a
            exx
                push de
                    ld e,a
                    call Put3L_
                pop de
            exx
        endif
        inc hl

        ld a,(de)
        inc de
        cp (hl)
        if nz
            ld (hl),a
            exx
                push de
                    ld e,a
                    call Put3R_
                pop de
            exx
        else
            exx
                inc hl
            exx
        endif
        inc hl
    dwnz
    exx
        push bc
            ld bc,VramWidth*3-VVramWidth/2
            add hl,bc
        pop bc
    exx
ret

VVramToVramRow2:
    ld b,VVramWidth/2
    do 
        ld a,(de)
        inc de
        cp (hl)
        if nz
            ld (hl),a
            exx
                push de
                    ld e,a
                    call Put2L_
                pop de
            exx
        endif
        inc hl

        ld a,(de)
        inc de
        cp (hl)
        if nz
            ld (hl),a
            exx
                push de
                    ld e,a
                    call Put2R_
                pop de
            exx
        else
            exx
                inc hl
            exx
        endif
        inc hl
    dwnz
    exx
        push bc
            ld bc,VramWidth*2-VVramWidth/2
            add hl,bc
        pop bc
    exx
ret


; void VVramToVram();
cseg
VVramToVram_: public VVramToVram_
    push af | push hl | push de | push bc
        ld de,VVram_
        ld hl,Backup
        exx
            ld hl,VramTop
        exx
        ld c, VVramHeight/2
        do
            call VVramToVramRow3
            call VVramToVramRow2
            dec c
        while nz | wend
    pop bc | pop de | pop hl | pop af
ret
