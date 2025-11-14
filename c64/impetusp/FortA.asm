include "Zeropage.inc"
include "Vram.inc"
include "VVram.inc"
include "Chars.inc"

ext VVram_
ext FortDotOffset_, FortCharOffset_
ext FortPattern

scope
GroundByte equ $aa
pUpperSource equ ZW0
pLowerSource equ ZW1
pDestination equ ZW2
upperCount equ ZB0
lowerCount equ ZB1
cCount equ ZB2
sourceOffset equ ZB3
destinationOffset equ ZB4

; void UpdateFortChars();
cseg
AddH:
    lda 0,x | clc|adc #CharHeight | sta 0,x
    if cs
        inc 1,x
    endif
rts
UpdateFortChars_: public UpdateFortChars_
    pha
        lda FortCharOffset_
        if eq
            ldy #low(PatternRam+CharHeight*Char_Fort0)
            ldx #high(PatternRam+CharHeight*Char_Fort0)
        else
            ldy #low(PatternRam+CharHeight*Char_Fort1)
            ldx #high(PatternRam+CharHeight*Char_Fort1)
        endif
        sty pDestination | stx pDestination+1

        lda #low(FortPattern) | sta pUpperSource | sta pLowerSource
        lda #high(FortPattern) | sta pUpperSource+1 | sta pLowerSource+1

        lda FortDotOffset_ | and #7 | sta upperCount
        lda #8 | sec|sbc upperCount | sta lowerCount

        lda #6 | sta cCount
        do
            ldy #0 | sty sourceOffset
            ldx upperCount
            if ne
                lda #GroundByte
                do
                    sta (pDestination),y | iny
                    dex
                while ne | wend
            endif
            sty destinationOffset
            ldx lowerCount
            do
                ldy sourceOffset | lda (pLowerSource),y | iny | sty sourceOffset
                ldy destinationOffset | sta (pDestination),y | iny | sty destinationOffset
                dex
            while ne | wend
            ldx #pLowerSource | jsr AddH
            ldx #pDestination | jsr AddH

            dec cCount
        while ne | wend

        lda #6*5 | sta cCount
        do
            lda #0 | sta destinationOffset
            ldx upperCount
            if ne
                lda lowerCount | sta sourceOffset
                do
                    ldy sourceOffset | lda (pUpperSource),y | iny | sty sourceOffset
                    ldy destinationOffset | sta (pDestination),y | iny | sty destinationOffset
                    dex
                while ne | wend
            endif
            lda #0 | sta sourceOffset
            ldx lowerCount
            do
                ldy sourceOffset | lda (pLowerSource),y | iny | sty sourceOffset
                ldy destinationOffset | sta (pDestination),y | iny | sty destinationOffset
                dex
            while ne | wend
            ldx #pUpperSource | jsr AddH
            ldx #pLowerSource | jsr AddH
            ldx #pDestination | jsr AddH
            dec cCount
        while ne | wend

        lda #6 | sta cCount
        do
            lda #0 | sta destinationOffset
            ldx upperCount
            if ne
                lda lowerCount | sta sourceOffset
                do
                    ldy sourceOffset | lda (pUpperSource),y | iny | sty sourceOffset
                    ldy destinationOffset | sta (pDestination),y | iny | sty destinationOffset
                    dex
                while ne | wend
            endif
            ldy destinationOffset
            lda #GroundByte
            ldx lowerCount
            do
                sta (pDestination),y | iny
                dex
            while ne | wend
            ldx #pUpperSource | jsr AddH
            ldx #pDestination | jsr AddH
            dec cCount
        while ne | wend
    pla
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

        lda FortCharOffset_ | clc|adc #Char_Fort | sta char

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