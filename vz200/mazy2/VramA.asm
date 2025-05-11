include "Vram.inc"
include "VVram.inc"

ext VVramBack_, VVramFront_
ext AsciiPattern, CharPattern
ext RowOffset_

VramTop equ Vram+VramWidth*6+VramWidth

dseg
Backup: defs VVramWidth*VVramHeight


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
        ld bc,VramWidth*64
        call Clear
        
        ld e,0
        ld hl,Backup
        ld bc,VVramWidth*VVramHeight
        call Clear

        ld hl,VVramBack_
        ld bc,VVramWidth*VVramHeight*2
        call Clear
    pop bc | pop de | pop hl | pop af
ret


Put1: 
    push af | push hl | push de | push bc
        ld l,a | ld h,0
        ld c,l | ld b,h
        add hl,hl ; *2
        add hl,bc ; *3
        ld bc,CharPattern
        add hl,bc
        ld bc,VramWidth
        ld a,CharHeight
        do
            ex af,af'
                ld a,(hl)
                inc hl
                ld (de),a
            ex af,af'
            ex de,hl
                add hl,bc
            ex de,hl
            dec a
        while nz | wend
    pop bc | pop de | pop hl | pop af
ret


; ptr<byte> Put(ptr<byte> pVram, byte c);
cseg
; ptr<byte> Put(ptr<byte> pVram, byte c);
cseg
Put_: public Put_
    push af
        ld a,e
        ex de,hl
            call Put1
        ex de,hl
    pop af
    inc hl
ret


; void VVramToVram();
cseg
VVramToVram_: public VVramToVram_
    push af | push hl | push de | push bc
        ld de,VVramFront_
        ld hl,(RowOffset_)
        add hl,de
        ex de,hl

        ld hl,Backup
        exx
            ld de,VramTop
        exx
        ld c, WindowHeight
        do
            ld b,VVramWidth
            do 
                ld a,(de)
                inc de
                cp (hl)
                if nz
                    ld (hl),a
                    exx
                        call Put1
                    exx
                endif
                exx
                    inc de
                exx
                inc hl
            dwnz
            exx
                ex de,hl
                    push bc
                        ld bc,VramRowSize-VVramWidth
                        add hl,bc
                    pop bc
                ex de,hl
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
        ld a,AsciiHeight
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
