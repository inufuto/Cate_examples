include "Vram.inc"
include "VVram.inc"
include "Chars.inc"

ext VVramBack_, VVramFront_
ext CharPattern

VramTop equ Vram+VramRowSize*2

dseg
Backup:
    defs VVramWidth*VVramHeight
CharColors:
    defs Char_End


cseg
ColorTable:
defb 64,47h ; Ascii
defb 16,45h ; Logo
defb 4,07h ; Knife
defb 72,47h ; Man
defb 4,43h ; Chaser
defb 4,42h ; Disturber
defb 16,47h ; Point
defb 8,07h ; Stair
defb 4,46h ; Goal
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
Clear:
    do
        ld (hl),c
        inc hl
        dec de
        ld a,e | or d
    while nz | wend
ret
ClearScreen_: public ClearScreen_
    push hl | push de | push bc 
        ld hl,Vram0
        ld de,ColorMap-Vram0
        ld c,0
        call Clear

        ld hl,ColorMap
        ld de,5B00h-ColorMap
        ld c,47h
        call Clear

        ld hl,Backup
        ld de,VVramWidth*VVramHeight
        ld c,0
        call Clear
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
