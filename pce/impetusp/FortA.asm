include "ZeroPage.inc"
include "Vram.inc"
include "Chars.inc"

ext NextPage
ext FortDotOffset_, FortCharOffset_
ext FortPattern
ext DisableNmi, EnableNmi

cseg
GroundPattern:
	defb	$00, $00, $00, $00, $00, $00, $00, $00
	defb	$00, $00, $00, $00, $00, $00, $00, $00
	defb	$ff, $00, $ff, $40, $ff, $00, $ff, $04
	defb	$ff, $00, $ff, $40, $ff, $00, $ff, $04


scope
pUpperSource equ ZW0
pLowerSource equ ZW1
wDestination equ ZW2
upperCount equ ZB0
lowerCount equ ZB1
upperCount2 equ ZB2
lowerCount2 equ ZB3
cCount equ ZB4
plCount equ ZB5

; void UpdateFortChars();
UpdateFortChars_: public UpdateFortChars_
    pha
        lda FortCharOffset_
        if eq
            ldy #low(CharPatternRam+CharPatternSize/2*Char_Fort0)
            ldx #high(CharPatternRam+CharPatternSize/2*Char_Fort0)
        else
            ldy #low(CharPatternRam+CharPatternSize/2*Char_Fort1)
            ldx #high(CharPatternRam+CharPatternSize/2*Char_Fort1)
        endif
        sty wDestination | stx wDestination+1

        lda #low(FortPattern) | sta pLowerSource
        lda #high(FortPattern) | sta pLowerSource+1

        lda FortDotOffset_ | and #7 | sta upperCount
        asl a | sta upperCount2
        lda #CharHeight | sec|sbc upperCount | sta lowerCount
        asl a | sta lowerCount2

        lda #6 | sta cCount
        do
            lda #low(GroundPattern) | sta pUpperSource
            lda #high(GroundPattern) | sta pUpperSource+1
            jsr UpdateC
            dec cCount
        while ne | wend

        lda #low(FortPattern) | clc|adc lowerCount2 | sta pUpperSource
        lda #high(FortPattern) | adc #0 | sta pUpperSource+1
        lda #6*5 | sta cCount
        do
            jsr UpdateC
            dec cCount
        while ne | wend

        lda #6 | sta cCount
        do
            lda #low(GroundPattern) | clc|adc upperCount2 | sta pLowerSource
            lda #high(GroundPattern) | adc #0 | sta pLowerSource+1
            jsr UpdateC
            dec cCount
        while ne | wend
    pla
rts
UpdateC:
    sei
        defb $03,$00 ; st0 Memory Address Write
        sty >$0002
        lda wDestination | sta >$0002
        lda wDestination+1 | sta >$0003

        lda #PlaneCount/2 | sta plCount
        do
            ldx upperCount
            if ne
                ldy #0
                do
                    defb $03,$02 ; st0 Vram Data
                    lda (pUpperSource),y | iny | sta >$0002
                    lda (pUpperSource),y | iny | sta >$0003
                    dex
                while ne | wend
            endif
            ldy #0
            ldx lowerCount
            do
                defb $03,$02 ; st0 Vram Data
                lda (pLowerSource),y | iny | sta >$0002
                lda (pLowerSource),y | iny | sta >$0003
                dex
            while ne | wend
            ldx #pUpperSource | jsr AddH
            ldx #pLowerSource | jsr AddH
            dec plCount
        while ne | wend
    cli
    ldx #wDestination | jsr AddH
rts
AddH:
    lda 0,x | clc|adc #CharHeight*2 | sta 0,x
    if cs
        inc 1,x
    endif
rts
endscope


scope
; void DrawFort(byte x, byte y);
wVram equ ZW0
yPos equ ZB0
yCount equ ZB1
char equ ZB2
dseg
DrawFort_@Param1: public DrawFort_@Param1
DrawFort_y:
    defb 0
cseg
DrawFort_: public DrawFort_
    pha
        stz wVram+1
        lda DrawFort_y | sta yPos
        clc|adc #16+2
        asl a | rol wVram+1 ;*2
        asl a | rol wVram+1 ;*4
        asl a | rol wVram+1 ;*8
        asl a | rol wVram+1 ;*16
        asl a | rol wVram+1 ;*32
        clc|adc #low(Vram0-VramRowSize*(16+2)) | sta wVram
        lda wVram+1 | adc #high(Vram0-VramRowSize*(16+2)) | clc|adc NextPage | sta wVram+1
        tya | clc|adc wVram | sta wVram
        if cs
            inc wVram+1
        endif

        lda FortCharOffset_ | clc|adc #Char_Fort | sta char

        lda #7 | sta yCount
        do
            lda yPos
            cmp #VramHeight
            if cc
                sei
                    defb $03,$00 ; st0 Memory Address Write
                    sty >$0002
                    lda wVram | sta >$0002
                    lda wVram+1 | sta >$0003
                    ldx #6
                    do
                        lda char 
                        defb $03,$02 ; st0 Vram Data
                        sta >$0002
                        defb $23,$01 ; st2
                        inc char
                        dex
                    while ne | wend
                cli
            else
                lda char | clc|adc #6 | sta char
            endif
            lda wVram | clc|adc #VramRowSize | sta wVram
            if cs
                inc wVram+1
            endif
            inc yPos
            dec yCount
        while ne | wend
    pla
rts
endscope