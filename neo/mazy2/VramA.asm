include "neo6502.inc"
include "ZeroPage.inc"
include "Vram.inc"

ext CharPattern
ext VVram_

dseg
BltSource:
    defs 12

pChar equ ZW0
xPos equ ZW3
yPos equ ZW4


cseg
PaletteValues:
	defb	$00, $00, $00, $5a, $39, $de, $ff, $00
	defb	$00, $ff, $9c, $de, $00, $ff, $00, $3c
	defb	$9d, $ff, $ff, $ff, $00, $ff, $ff, $ff
	defb	$00, $00, $00, $7b, $7b, $7b, $9c, $5a
	defb	$39, $de, $7b, $7b, $00, $7b, $00, $00
	defb	$5a, $9c, $de, $bd, $9c, $bd, $bd, $bd
InitVram: public InitVram
    ldy #0
    ldx #0
    do
        sty API_PARAMETERS+0
        lda PaletteValues+0,x | sta API_PARAMETERS+1
        lda PaletteValues+1,x | sta API_PARAMETERS+2
        lda PaletteValues+2,x | sta API_PARAMETERS+3
        lda #API_FN_SET_PALETTE | sta API_FUNCTION
        lda #API_GROUP_GRAPHICS | sta API_COMMAND
        inx | inx | inx
        iny
        cpy #16
    while ne | wend

    ldx #3
    do
        do
            sty API_PARAMETERS+0
            lda PaletteValues+0,x | sta API_PARAMETERS+1
            lda PaletteValues+1,x | sta API_PARAMETERS+2
            lda PaletteValues+2,x | sta API_PARAMETERS+3
            lda #API_FN_SET_PALETTE | sta API_FUNCTION
            lda #API_GROUP_GRAPHICS | sta API_COMMAND
            iny | tya | and #$0f
        while ne | wend
        inx | inx | inx
        cpy #0
    while ne | wend

    stz BltSource+2 | stz BltSource+3
    lda #4 | sta BltSource+4 | stz BltSource+5 ; stride
    lda #1 | sta BltSource+6 ; format
    stz BltSource+7 | stz BltSource+8
    lda #8 | sta BltSource+9 ; height
    lda #8 | sta BltSource+10 | stz BltSource+11 ; width
rts


; void ClearScreen();
cseg
ClearScreen_: public ClearScreen_
    pha
        ; jsr WaitMessage
        lda #API_FN_CLEAR_SCREEN | sta API_FUNCTION
        lda #API_GROUP_CONSOLE | sta API_COMMAND
    pla
rts



cseg
Put:
    stz <pChar+1
    lda <pChar
    asl a | rol <pChar+1 ;*2
    asl a | rol <pChar+1 ;*4
    asl a | rol <pChar+1 ;*8
    asl a | rol <pChar+1 ;*16
    asl a | rol <pChar+1 ;*32
    sta <pChar

    do
        lda #1 | sta API_FUNCTION
        lda #12 | sta API_COMMAND
        jsr WaitMessage
        lda API_PARAMETERS+0
    while ne | wend

    lda <pChar | clc|adc #low CharPattern | sta BltSource+0
    lda <pChar+1 | adc #high CharPattern | sta BltSource+1

    stz API_PARAMETERS+0
    lda #low BltSource | sta API_PARAMETERS+1
    lda #high BltSource | sta API_PARAMETERS+2
    lda <xPos | sta API_PARAMETERS+3
    lda <xPos+1 | sta API_PARAMETERS+4
    lda <yPos | sta API_PARAMETERS+5
    lda <yPos+1 | sta API_PARAMETERS+6
    lda #4 | sta API_PARAMETERS+7
    lda #4 | sta API_FUNCTION
    lda #12 | sta API_COMMAND
rts


; extern word Put(word vram, byte c);
dseg
Put_@Param1: public Put_@Param1
Put_c:
    defb 0
cseg
Put_: public Put_
    pha
        stz <xPos+1
        tya
        asl a | rol <xPos+1
        asl a | rol <xPos+1
        asl a | rol <xPos+1
        sta <xPos
        
        stz <yPos+1
        txa
        asl a | rol <yPos+1
        asl a | rol <yPos+1
        asl a | rol <yPos+1
        sta <yPos

        lda Put_c | sta <pChar
        jsr Put
    pla
    iny
rts
