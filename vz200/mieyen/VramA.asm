include "Vram.inc"
include "VVram.inc"

ext VVramBack_, VVramFront_
ext AsciiPattern, CharPattern

VramTop equ Vram+VramWidth*(6+2)
CharHeight equ 6

dseg
Backup: defs VVramWidth*VVramHeight


; void ClearScreen();
cseg
Clear:
    do
        ld (hl),0
        inc hl
        dec bc
        ld a,c
        or b
    while nz | wend
ret
ClearScreen_: public ClearScreen_
    push af | push hl | push bc
        ld hl,Vram
        ld bc,VramWidth*64
        call Clear

        ld hl,Backup
        ld bc,VVramWidth*VVramHeight
        call Clear

        ld hl,VVramBack_
        ld bc,VVramWidth*VVramHeight*2
        call Clear
    pop bc | pop hl | pop af
ret


CharPtrDe:
    push hl
        ld l,a | ld h,0
        ld e,l | ld d,h
        add hl,hl ;*2
        add hl,hl ;*4
        add hl,de ;*5
        ld de,CharPattern | add hl,de
        ex de,hl
    pop hl
ret


; ptr<byte> Put3(ptr<byte> pVram, byte c);
cseg
Put3_: public Put3_
    push af | push hl | push de | push bc
        ld a,e
        call CharPtrDe
        ld bc,VramWidth
        ld a,(de) | inc de
        ld (hl),a | add hl,bc
        ld a,(de) | inc de
        ld (hl),a | add hl,bc
        ld a,(de)
        ld (hl),a
    pop bc | pop de | pop hl | pop af
    inc hl
ret


; ptr<byte> Put2(ptr<byte> pVram, byte c);
cseg
Put2_: public Put2_
    push af | push hl | push de | push bc
        ld a,e
        call CharPtrDe
        ld bc,VramWidth
        inc de | inc de | inc de
        ld a,(de) | inc de
        ld (hl),a | add hl,bc
        ld a,(de)
        ld (hl),a
    pop bc | pop de | pop hl | pop af
    inc hl
ret


cseg
VVramToVramRow3:
    ld b,VVramWidth
    do 
        ld a,(de)
        inc de
        cp (hl)
        if nz
            ld (hl),a
            exx
                push de
                    ld e,a
                    call Put3_
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
            ld bc,VramWidth*3-VVramWidth
            add hl,bc
        pop bc
    exx
ret

VVramToVramRow2:
    ld b,VVramWidth
    do 
        ld a,(de)
        inc de
        cp (hl)
        if nz
            ld (hl),a
            exx
                push de
                    ld e,a
                    call Put2_
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
            ld bc,VramWidth*2-VVramWidth
            add hl,bc
        pop bc
    exx
ret


; void VVramToVram();
cseg
VVramToVram_: public VVramToVram_
    push af | push hl | push de | push bc
        ld de,VVramFront_
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


; ptr<byte> PrintC(ptr<byte> address, byte c);
cseg
CharTable:
    defb " 0123456789ACEFGHIKMNOPRSTUVY"
PrintC_: public PrintC_
    push af | push hl | push de | push bc
        push hl
            ld bc,29 shr 8
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
            ld bc,AsciiPattern
            add hl,bc
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
