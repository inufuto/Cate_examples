include "Vram.inc"
include "VVram.inc"
include "Chars.inc"

ext VVramFront_
ext AsciiPattern,CharPattern

VramTop equ Vram+VramRowSize*2

dseg
Backup: defs VVramWidth*VVramHeight


; void ClearScreen();
cseg
Clear:
    do
        ld (hl),0 | inc hl
        dec bc
        ld a,c | or b
    while nz | wend
ret
ClearScreen_: public ClearScreen_
    push af | push hl | push bc
        ld hl,VramOrg
        ld bc,VramRowSize*VramHeight
        do
            ld (hl),20h | inc hl
            dec bc
            ld a,c | or b
        while nz | wend

        ld hl,Backup
        ld bc,VVramWidth*VVramHeight
        call Clear
    pop bc | pop hl | pop af
ret


Put1: ;(hl,a)
    ex de,hl
        ld l,a | ld h,0
        ld c,l | ld b,h
        add hl,hl ;*2
        add hl,bc ;*3
        ld bc,CharPattern | add hl,bc
    ex de,hl
    ld b,3
    do
        ld a,(de) | inc de
        ld (hl),a | inc hl
    dwnz
ret

; ptr<byte> Put(ptr<byte> pVram, byte c);
cseg
Put_: public Put_
    push af | push de | push bc
        ld a,e
        call Put1
    pop bc | pop de | pop af
ret


; void VVramToVram();
cseg
VVramToVram_: public VVramToVram_
    push af | push hl | push de | push bc
        ld de,VVramFront_+VVramWidth
        ld hl,Backup
        exx
            ld hl,VramTop
        exx
        ld c, VVramHeight-2
        do
            ld b,VVramWidth
            do 
                ld a,(de) | inc de
                cp (hl)
                if nz
                    ld (hl),a
                    exx
                        call Put1
                    exx
                else
                    exx
                        inc hl | inc hl | inc hl
                    exx
                endif
                inc hl
            dwnz
            exx
                ld de,VramRowSize-VVramWidth*VramStep | add hl,de
            exx
            dec c
        while nz | wend
    pop bc | pop de | pop hl | pop af
ret


; ptr<byte> PrintC(ptr<byte> address, byte c);
cseg
CharTable:
    defb " 0123456789ACEFGHIKMNOPRSTUVY"
PrintC_: public PrintC_
    push af | push de | push bc
        ld a,e
        ex de,hl
            ld bc,29 shl 8
            ld hl,CharTable
            do
                cp (hl)
                jr z,PrintC_break
                inc hl
                inc c
            dwnz
            PrintC_break:
            ld a,c
            add a,a ;*2
            add a,c ;*3
            ld l,a | ld h,0
            add hl,hl ;*6
            ld bc,AsciiPattern | add hl,bc
        ex de,hl
        ld c,2
        do
            ld b,3
            do
                ld a,(de) | inc de
                ld (hl),a | inc hl
            dwnz
            push de
                ld de,VramRowSize-3 | add hl,de
            pop de
            dec c
        while nz | wend
        push de
            ld de,3-VramRowSize*2 | add hl,de
        pop de
    pop bc | pop de | pop af
ret
