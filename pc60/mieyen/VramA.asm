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
        ld (hl),0 | inc hl
        dec bc
        ld a,c | or b
    while nz | wend
ret
ClearScreen_: public ClearScreen_
    push af | push hl | push bc
        ld hl,Vram
        ld bc,VramRowSize*VramHeight
        call Clear
        
        ld hl,Backup
        ld bc,VVramWidth*VVramHeight
        call Clear

        ld hl,VVramBack_
        ld bc,VVramWidth*VVramHeight*2
        call Clear
    pop bc | pop hl | pop af
ret


Put1: 
    push af | push hl | push de | push bc
        ld l,a
        ld h,0
        add hl,hl ; *2
        add hl,hl ; *4
        add hl,hl ; *8
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


; void VVramToVram();
cseg
VVramToVram_: public VVramToVram_
    push af | push hl | push de | push bc
        ld de,VVramFront_
        ld hl,Backup
        exx
            ld de,Vram+VramRowSize*2
        exx
        ld c, VVramHeight
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
