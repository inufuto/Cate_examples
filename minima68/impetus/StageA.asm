include "Direct.inc "
include "Vram.inc"
include "Chars.inc"

ext GroundCharOffset_, GroundOffset_, Ground_
ext TerrainPattern_
ext pNextPage_

Char_Count equ (Char_TerrainEnd-Char_Terrain)/2
TileSize equ 4
GroundHeight equ VramHeight+TileSize

scope
pSource equ @Temp@Word
pDestination equ @Temp@Word2

; void UpdateGroundChars();
cseg
UpdateGroundChars_: public UpdateGroundChars_
    psha | pshb
        ldab GroundOffset_
        aslb ; *(CharHeight/CoordRate)
        negb
        addb #CharHeight-1
        aslb ;*2
        clra
        addb #low TerrainPattern_ | adca #high TerrainPattern_
        staa pSource | stab pSource+1

        ldab GroundCharOffset_
        addb #Char_Terrain
        clra
        aslb | rola ;*2
        aslb | rola ;*4
        aslb | rola ;*8
        aslb | rola ;*16
        adda #high CharPatternRam
        staa pDestination | stab pDestination+1

        ldab #Char_Count
        do
            pshb
                ldab #2*CharHeight
                do
                    ldx pSource | ldaa 0,x | inx | stx pSource
                    ldx pDestination | staa 0,x | inx | stx pDestination
                    decb
                while ne | wend
                ldaa pSource+1 | adda #2*(15-CharHeight) | staa pSource+1
                ldaa pSource | adca #0 | staa pSource
            pulb
            decb
        while ne | wend
    pulb | pula
rts
endscope


; void RollDown();
cseg
RollDown_: public RollDown_
    psha | pshb
        ldx #Ground_+VramWidth*(GroundHeight-1)
        do
            dex
            ldaa 0,x | staa VramWidth,x
            cpx #Ground_
        while ne | wend
    pulb | pula
rts


scope
pGround equ @Temp@Word
pVram equ @Temp@Word2
count equ @Temp@Word3
charOffset equ @Temp@Byte

; void GroundToVram();
cseg
GroundToVram_: public GroundToVram_
    psha | pshb
        ldaa GroundCharOffset_ | staa charOffset
        
        ldx #Ground_+VramWidth*TileSize | stx pGround
        ldx pNextPage_ | stx pVram
        ldx #VramWidth*VramHeight | stx count
        do
            ldx pGround | ldaa 0,x | inx | stx pGround
            adda charOffset
            ldx pVram | staa 0,x | inx | stx pVram
            ldx count | dex | stx count
        while ne | wend
    pulb | pula
rts
endscope
