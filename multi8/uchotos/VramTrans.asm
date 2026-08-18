include "Vram.inc"

cseg
Clear:
    ld hl,8000h
    ld de,8000h+1
    ld bc,4000h-1
    ld (hl),0
    ldir
ret
ClearVram: public ClearVram
    di
        ld a,17h | out (2ah),a
        call Clear
        ld a,18h | out (2ah),a
        call Clear
        xor a | out (2ah),a
    ei
ret


cseg
WriteVram: public WriteVram
    di
        ld b,CharHeight
        do
            ld c,01h
            do
                ld a,3fh
                xor c
                out (2ah),a
                
                ld a,(de) | inc de
                ld (hl),a | inc hl
                ld a,(de) | inc de
                ld (hl),a | dec hl
                
                ld a,c
                add a,a
                ld c,a
                cp 8
            while c | wend
            xor a | out (2ah),a
            ld a,l | add a,VramWidth | ld l,a
            ld a,h | adc a,0 | ld h,a
        dwnz
    ei
    ld a,l | sub low(VramRowSize) | ld l,a
    ld a,h | sbc a,high(VramRowSize) | ld h,a
ret
