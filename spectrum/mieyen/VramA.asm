include "Vram.inc"
include "VVram.inc"
include "Chars.inc"

ext VVramBack_, VVramFront_
ext CharPattern
ext FillMemory_

VramTop equ Vram+VramRowSize*2

dseg
Backup:
    defs VVramWidth*VVramHeight
CharColors:
    defs Char_End


cseg
ColorTable:
defb 64,47h ; Ascii
defb 16,05h ; Logo
defb 16,01h ; Wall
defb 32,47h ; Man
defb 32,43h ; Monster
defb 4,42h ; FireBullet
defb 4,42h ; Fire
defb 4,46h ; Dot
defb 4,46h ; Food
defb 0
InitVram: public InitVram
    ld hl,ColorTable
    ld de,CharColors
    do
        ld a,(hl)
        or a
    while nz
        ld b,a
        inc hl
        ld a,(hl) | inc hl
        or 40h
        do
            ld (de),a | inc de
        dwnz
    wend
ret


; void ClearScreen();
cseg
ClearScreen_: public ClearScreen_
    push hl | push de | push bc 
        ld hl,Vram0
        ld de,ColorMap-Vram0
        ld c,0
        call FillMemory_

        ld hl,ColorMap
        ld de,5B00h-ColorMap
        ld c,47h
        call FillMemory_

        ld hl,Backup
        ld de,VVramWidth*VVramHeight
        ld c,0
        call FillMemory_

        ld hl,VVramBack_
        ld de,VVramWidth*VVramHeight*2
        ld c,0
        call FillMemory_
    pop bc | pop de | pop hl
ret


; word Put(word vram, byte c);
cseg
Put_: public Put_
    push af | push hl | push de | push bc
        push hl
            push de
                ld c,a
                ex de,hl
                    ld h,0
                    add hl,hl ;*2
                    add hl,hl ;*4
                    add hl,hl ;*8
                    ld bc,CharPattern
                    add hl,bc
                ex de,hl
                sla h | sla h | sla h
                set 6,h
                ld b,CharHeight
                do
                    ld a,(de)
                    inc de
                    ld (hl),a
                    inc h
                dwnz
            pop de
            ld d,0
            ld hl,CharColors
            add hl,de
            ld a,(hl)
        pop hl
        ld bc,ColorMap
        add hl,bc
        ld (hl),a
    pop bc | pop de | pop hl | pop af
    inc hl
ret


; void VVramToVram();
VVramToVram_: public VVramToVram_
    push af | push hl | push de | push bc
        ld de,VVramFront_
        ld hl,Backup
        exx
            ld hl,VramTop
        exx
        ld c,VVramHeight
        do
            ld b,VVramWidth
            do 
                push bc 
                    ld a,(de)
                    inc de
                    cp (hl)
                    if nz
                        ld (hl),a
                        exx
                            push de
                                ld e,a
                                call Put_
                            pop de
                        exx
                    else
                        exx
                            inc hl
                        exx
                    endif
                    inc hl
                pop bc
            dwnz
            dec c
        while nz | wend
    pop bc | pop de | pop hl | pop af
ret
