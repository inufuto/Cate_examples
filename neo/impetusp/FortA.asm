include "neo6502.inc"
include "Zeropage.inc"
include "Vram.inc"
include "VVram.inc"
include "Chars.inc"

ext VVram_
ext FortDotOffset_
ext FortPattern

dseg
FortPatternRam: public FortPatternRam
    defs PatternSize*(Char_FortEnd-Char_End)

cseg
GroundPattern:
	defb $44,$44,$44,$44,$4c,$44,$44,$44
	defb $44,$44,$44,$44,$44,$44,$4c,$44
	defb $44,$44,$44,$44,$4c,$44,$44,$44
	defb $44,$44,$44,$44,$44,$44,$4c,$44

scope
pUpperSource equ ZW0
pLowerSource equ ZW1
pDestination equ ZW2
upperCount equ ZB0
lowerCount equ ZB1
cCount equ ZB2
sourceOffset equ ZB3
destinationOffset equ ZB4
cseg
UpdateFortChars_: public UpdateFortChars_
    pha
        lda #low FortPatternRam | sta pDestination
        lda #high FortPatternRam | sta pDestination+1

        lda #low(FortPattern) | sta pLowerSource
        lda #high(FortPattern) | sta pLowerSource+1

        lda FortDotOffset_ | and #7
        asl a | asl a | asl a | sta upperCount
        lda #CharHeight*4 | sec|sbc upperCount | sta lowerCount

        lda #6 | sta cCount
        do
            lda #low(GroundPattern) | sta pUpperSource
            lda #high(GroundPattern) | sta pUpperSource+1
            jsr UpdateC
            dec cCount
        while ne | wend

        lda #low(FortPattern) | clc|adc lowerCount | sta pUpperSource
        lda #high(FortPattern) | adc #0 | sta pUpperSource+1
        lda #6*5 | sta cCount
        do
            jsr UpdateC
            dec cCount
        while ne | wend

        lda #6 | sta cCount
        do
            lda #low(GroundPattern) | clc|adc upperCount | sta pLowerSource
            lda #high(GroundPattern) | adc #0 | sta pLowerSource+1
            jsr UpdateC
            dec cCount
        while ne | wend
    pla
rts
UpdateC:
    stz destinationOffset
    ldx upperCount
    if ne
        stz sourceOffset
        do
            ldy sourceOffset | lda (pUpperSource),y | iny | sty sourceOffset
            ldy destinationOffset | sta (pDestination),y | iny | sty destinationOffset
            dex
        while ne | wend
    endif
    stz sourceOffset
    ldx lowerCount
    do
        ldy sourceOffset | lda (pLowerSource),y | iny | sty sourceOffset
        ldy destinationOffset | sta (pDestination),y | iny | sty destinationOffset
        dex
    while ne | wend
    ldx #pUpperSource | jsr AddH
    ldx #pLowerSource | jsr AddH
    ldx #pDestination | jsr AddH
rts
AddH:
    lda 0,x | clc|adc #CharHeight*4 | sta 0,x
    if cs
        inc 1,x
    endif
rts
endscope

scope
pVVram equ ZW0
yPos equ ZB0
yCount equ ZB1
char equ ZB2
; void DrawFort(byte x, byte y);
dseg
DrawFort_@Param1: public DrawFort_@Param1
DrawFort_y:
    defb 0
cseg
DrawFort_: public DrawFort_
    pha
        lda #0 | sta pVVram+1
        lda DrawFort_y | sta yPos
        clc|adc #16+2
        asl a | rol pVVram+1 ;*2
        asl a | rol pVVram+1 ;*4
        asl a | rol pVVram+1 ;*8
        asl a | rol pVVram+1 ;*16
        asl a | rol pVVram+1 ;*32
        clc|adc #low(VVram_-VVramWidth*(16+2)) | sta pVVram
        lda pVVram+1 | adc #high(VVram_-VVramWidth*(16+2)) | sta pVVram+1

        lda  #Char_Fort | sta char

        lda #7 | sta yCount
        do
            lda yPos
            cmp #VVramWidth
            if cc
                ldx #6
                do
                    lda char 
                    sta (pVVram),y | iny
                    inc char
                    dex
                while ne | wend
                tya | clc|adc #VVramWidth-6 | tay
            else
                lda char | clc|adc #6 | sta char
                tya | clc|adc #VVramWidth | tay
            endif
            inc yPos
            dec yCount
        while ne | wend
    pla
rts
endscope