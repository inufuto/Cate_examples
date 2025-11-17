include "neo6502.inc"
include "ZeroPage.inc"
include "Vram.inc"
include "VVram.inc"
include "Chars.inc"

ext CharPattern
ext VVram_
ext PollTimer
ext FortPatternRam

dseg
Backup:
    defs VVramWidth*VVramHeight
BltSource:
    defs 12

zseg
pChar:
    defw 0

scope
cseg
PaletteValues:
	defb	$00, $00, $00, $00, $00, $ff, $ff, $00
	defb	$00, $ff, $00, $ff, $00, $ff, $00, $00
	defb	$ff, $ff, $ff, $ff, $00, $ff, $ff, $ff
	defb	$00, $00, $00, $00, $00, $bf, $bf, $00
	defb	$00, $00, $5f, $00, $00, $bf, $00, $00
	defb	$bf, $ff, $ff, $bf, $00, $bf, $bf, $bf
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
endscope


scope
pBackup equ ZW0
; void ClearScreen();
cseg
ClearScreen_: public ClearScreen_
    pha
        ; jsr WaitMessage
        lda #API_FN_CLEAR_SCREEN | sta API_FUNCTION
        lda #API_GROUP_CONSOLE | sta API_COMMAND

        lda #low(Backup) | sta pBackup
        lda #high(Backup) | sta pBackup+1
        ldx #VVramHeight
        do
            ldy #0 | tya
            do
                sta (pBackup),y | iny
                cpy #VVramWidth
            while ne | wend
            lda pBackup | clc|adc #VVramWidth | sta pBackup
            if cs
                inc pBackup+1
            endif
            dex
        while ne | wend
    pla
rts
endscope


scope
xPos equ ZW0
yPos equ ZW1
pVVram equ ZW2
pBackup equ ZW3
cseg
Mul32:
    stz <pChar+1
    asl a | rol <pChar+1 ;*2
    asl a | rol <pChar+1 ;*4
    asl a | rol <pChar+1 ;*8
    asl a | rol <pChar+1 ;*16
    asl a | rol <pChar+1 ;*32
rts
Put:
    cmp #Char_Fort
    if cc
        jsr Mul32
        clc|adc #low CharPattern | sta BltSource+0
        lda <pChar+1 | adc #high CharPattern | sta BltSource+1
    else
        sec|sbc #Char_Fort
        jsr Mul32
        clc|adc #low FortPatternRam | sta BltSource+0
        lda <pChar+1 | adc #high FortPatternRam | sta BltSource+1
    endif
    do
        lda #1 | sta API_FUNCTION
        lda #12 | sta API_COMMAND
        jsr WaitMessage
        lda API_PARAMETERS+0
    while ne | wend

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
PrepareXY:
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
rts

dseg
Put_@Param1: public Put_@Param1
; PutF_@Param1: public PutF_@Param1
Put_c:
PrintC_@Param1: public PrintC_@Param1
PrintC_c:
    defb 0

; word Put(word vram, byte c);
cseg
Put_: public Put_
    pha
        jsr PrepareXY
        lda Put_c
        jsr Put
    pla
    iny
rts

; ptr<byte> PrintC(ptr<byte> pVram, byte c);
cseg
CharTable:
    defb " -0123456789:ACEFGHIMNORSTUVXZ"
PrintC_: public PrintC_
    pha
        phx | phy
            jsr PrepareXY
            lda PrintC_c
            ldx #0
            do
                cmp CharTable,x
                beq PrintC_exit
                inx
                cpx #30
            while ne | wend
            ldx #Char_Space
            PrintC_exit:
            txa
            jsr Put
        ply | plx
        iny
    pla
rts

; void VVramToVram();
cseg
VVramToVram_: public VVramToVram_
    pha
        stz <xPos+1 | stz <yPos+1

        lda #low VVram_ | sta <pVVram
        lda #high VVram_ | sta <pVVram+1
        
        lda #low Backup | sta <pBackup
        lda #high Backup | sta <pBackup+1

        stz <yPos
        ldx #VVramHeight
        do
            stz <xPos
            ldy #0
            do
                lda (<pVVram),y
                cmp #Char_End
                bcs VVramToVram_force
                cmp (<pBackup),y
                if ne
                    VVramToVram_force:
                    sta (<pBackup),y
                    jsr Put
                endif
                next:
                lda <xPos | clc|adc #8 | sta <xPos
                iny
                cpy #VVramWidth
            while ne | wend
            lda <pVVram | clc | adc #low VVramWidth | sta <pVVram
            lda <pVVram+1 | adc #high VVramWidth | sta <pVVram+1

            lda <pBackup | clc | adc #low VVramWidth | sta <pBackup
            lda <pBackup+1 | adc #high VVramWidth | sta <pBackup+1

            lda <yPos | clc|adc #8 | sta <yPos
            dex
        while ne | wend
    pla
    jsr PollTimer
rts
endscope