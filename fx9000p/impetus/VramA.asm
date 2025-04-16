include "Vram.inc"
include "VVram.inc"

ext CharPattern
ext VVram_

dseg
Backup:
    defs VVramWidth*VVramHeight


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
    push af | push hl
        ld hl,7000h
        do
            ld (hl),0 | inc hl
            ld a,h
            cp 80h
        while nz | wend

        ld hl,Backup
        ld bc,VVramWidth*VVramHeight
        call Clear
    pop hl | pop af
ret


cseg
Put1:
    push bc
        ex de,hl
            ld h,0
            sla l | rl h ;*2
            sla l | rl h ;*4
            sla l | rl h ;*8
            ld bc,CharPattern
            add hl,bc
        ex de,hl
        ld b,CharHeight
        do
            ld a,(de) | inc de
            ld (hl),a | dec hl
        dwnz
    pop bc
ret

; ptr<byte> Put(ptr<byte> pVram, byte c);
cseg
Put_: public Put_
    push af | push de
        call Put1
    pop de | pop af
ret


; void VVramToVram();
cseg
VVramToVram_: public VVramToVram_
    push af | push hl | push de | push bc
        ld de,VVram_
        ld hl,Backup
        exx
            ld hl,Vram+VramRowSize*0
        exx
        ld c,VVramHeight
        do
            ld b,VVramWidth
            do
                ld a,(de) | inc de
                cp (hl)
                if nz
                    ld (hl),a
                    exx
                        ld e,a
                        call Put1
                    exx
                else
                    exx
                        ld de,VramStep
                        add hl,de
                    exx
                endif
                inc hl
            dwnz
            exx
                ld de,VramRowSize-VVramWidth*VramStep
                add hl,de
            exx
            dec c
        while nz | wend
    pop bc | pop de | pop hl | pop af
ret
