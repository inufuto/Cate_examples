include "Direct.inc "
include "Vram.inc"
include "Chars.inc"

ext pNextPage_
ext Background_, DotOffset_
ext PollTimer_

StageWidth equ VramWidth
StageHeight equ 22
TileWidth equ 2
BackgroundWidth equ StageWidth+TileWidth

scope
charOffset equ @Temp@Byte
pGround equ @Temp@Word
pVram equ @Temp@Word2

; void BackgroundToVram();
cseg
BackgroundToVram_: public BackgroundToVram_
    psha | pshb
        ldaa DotOffset_
        anda #3
        staa charOffset

        ldx #Background_ | stx pGround

        ldaa pNextPage_ | ldab #VramRowSize*(1+StatusHeight)
        staa pVram | stab pVram+1

        ldab #StageHeight
        do
            pshb
                ldab #StageWidth
                do
                    ldx pGround | ldaa 0,x | inx | stx pGround
                    cmpa #Char_Background
                    if cc
                        adda charOffset
                    endif
                    ldx pVram | staa 0,x | inx | stx pVram
                    decb
                while ne | wend
                ldaa pVram+1 | adda #VramRowSize-StageWidth*VramStep | staa pVram+1
                ldaa pVram | adca #0 | staa pVram

                ldaa pGround+1 | adda #BackgroundWidth-StageWidth | staa pGround+1
                ldaa pGround | adca #0 | staa pGround
            pulb
            decb
        while ne | wend
    pulb | pula
rts
endscope