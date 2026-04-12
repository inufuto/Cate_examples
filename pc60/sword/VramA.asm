include "Vram.inc"
include "VVram.inc"

ext VVramBack_, VVramFront_
ext CharPattern

dseg
Backup: defs VVramWidth*VVramHeight

cseg

; void ClearScreen();
cseg
Clear:
    do
        ld (hl),e | inc hl
        dec bc
        ld a,c | or b
    while nz | wend
ret
ClearScreen_: public ClearScreen_
    push af | push hl | push de | push bc
        ld e,0aah
        ld hl,Vram
        ld bc,VramRowSize*VramHeight
        call Clear
        
        ld e,0
        ld hl,Backup
        ld bc,VVramWidth*VVramHeight
        call Clear

        ld hl,VVramFront_
        ld bc,VVramWidth*VVramHeight*2
        call Clear
    pop bc | pop de | pop hl | pop af
ret


Put: ;(hl,a)
    push de | push bc
        ex de,hl
            ld l,a | ld h,0
            add hl,hl ; *2
            add hl,hl ; *4
            add hl,hl ; *8
            ld bc,CharPattern | add hl,bc
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
        ld bc,1-VramRowSize | add hl,bc
    pop bc | pop de
ret


; ptr<byte> Put(ptr<byte> pVram, byte c);
cseg
Put_: public Put_
    push af
        ld a,e
        call Put
    pop af
ret


; word PrintC(word vram, byte c);
cseg
CharTable:
    defb " -0123456789ACEFGHIKMNOPRSTUVY"
PrintC_: public PrintC_
    push af | push bc
        push hl
            ld a,e
            ld bc,30*256
            ld hl,CharTable
            do
                cp (hl)
                jr z,PrintC_break
                inc hl
                inc c
            dwnz
            ld c,0
            PrintC_break:
        pop hl
        ld a,c
        call Put
    pop bc | pop af
ret


; void VVramToVram();
cseg
VVramToVram_: public VVramToVram_
    push af | push hl | push de | push bc
        ld de,VVramFront_
        ld hl,Backup
        exx
            ld hl,Vram+VramRowSize*2
        exx
        ld c, VVramHeight-2
        do
            ld b,VVramWidth
            do 
                ld a,(de)
                inc de
                cp (hl)
                if nz
                    ld (hl),a
                    exx
                        call Put
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
                    ld bc,VramRowSize-VVramWidth | add hl,bc
                pop bc
            exx
            dec c
        while nz | wend
    pop bc | pop de | pop hl | pop af
ret
