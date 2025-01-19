include "Vram.inc"
include "VVram.inc"

ext VVram_

VramTop equ Vram+VramRowSize


; void ClearScreen();
cseg
ClearScreen_: public ClearScreen_
    push af | push hl | push bc
        ld hl,Vram
        ld bc,VramRowSize*VramHeight
        do
            ld (hl),20h | inc hl
            dec bc
            ld a,c | or b
        while nz | wend

        ld hl,VVram_
        ld bc,VVramWidth*VVramHeight
        do
            ld (hl),0 | inc hl
            dec bc
            ld a,c | or b
        while nz | wend
    pop bc | pop hl | pop af
ret


; void VVramToVram();
cseg
VVramToVram_: public VVramToVram_
    push af | push hl | push de | push bc | push ix | push iy
        ld ix,VVram_
        ld iy,VramTop
        ld c,7;VVramHeight/3
        do
            ld b,VVramWidth
            do
                ld l,(ix)
                ld h,(ix+VVramWidth)
                
                ld a,l
                and 0fh
                ld e,a
                ld a,h
                rlca | rlca | rlca | rlca
                and 30h
                or e
                or 0c0h
                ld (iy),a

                ld a,l
                rrca | rrca | rrca | rrca
                and 0fh
                ld e,a
                ld a,h
                and 30h
                or e
                or 0c0h
                ld (iy+1),a

                ld l,(ix+VVramWidth*2)

                ld a,l
                rlca | rlca
                and 3ch
                ld e,a
                ld a,h
                rrca | rrca
                and 03h
                or e
                or 0c0h
                ld (iy+VramRowSize),a

                ld a,l
                rrca | rrca
                and 3ch
                ld e,a
                ld a,h
                rlca | rlca
                and 03h
                or e
                or 0c0h
                ld (iy+VramRowSize+1),a

                inc ix
                inc iy | inc iy
            dwnz
            exx
                ld de,VVramWidth*2
                add ix,de
                ld de,VramRowSize
                add iy,de
            exx
            dec c
        while nz | wend

        ld b,VVramWidth
        do
            ld l,(ix)
            
            ld a,l
            and 0fh
            or 0c0h
            ld (iy),a

            ld a,l
            rrca | rrca | rrca | rrca
            and 0fh
            or 0c0h
            ld (iy+1),a

            inc ix
            inc iy | inc iy
        dwnz        
    pop iy | pop ix | pop bc | pop de | pop hl | pop af
ret
