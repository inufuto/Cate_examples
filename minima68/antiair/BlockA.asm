include "Direct.inc "
include "Vram.inc"
include "Chars.inc"

ext pNextPage_
ext Ground_

Ground_BlockMask equ $03
Ground_BombMask equ $0c


scope
pGround equ @Temp@Word
pVram equ @Temp@Word2

; void DrawBackground();
cseg
DrawBackground_: public DrawBackground_
    psha | pshb
        ldaa pNextPage_ | staa pVram
        ldaa #VramRowSize*WindowTop staa pVram+1
        ldx pVram
        ldab #WindowHeight-2
        do
            ldaa #WindowWidth
            do
                clr 0,x | inx
                deca
            while ne | wend
            decb
        while ne | wend
        stx pVram

        ldx #Ground_ | stx pGround
        ldab #WindowWidth
        do
            ldx pGround
            ldaa 0,x | inx | stx pGround
            ldx pVram
            bita #Ground_BombMask
            if ne
                anda #Ground_BombMask
                lsra | lsra
                adda #Char_BlockC-1
                bra DrawBackground_write
            endif
            bita #Ground_BlockMask
            if ne
                deca
                adda #Char_BlockA
                DrawBackground_write:
                ldx pVram
                staa 0,x
                adda #2
                staa VramRowSize,x
            else
                clr 0,x
                clr VramRowSize,x
            endif
            inx
            stx pVram
            decb
        while ne | wend
    pulb | pula
rts
endscope
