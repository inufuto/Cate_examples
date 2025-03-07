include 'ZeroPage.inc'
include 'Vram.inc'

WindowWidth equ 24
WindowHeight equ 24

ext WindowFront_, RowFlags_
ext Patterns

dseg
Backup_: public Backup_
    defs WindowWidth*WindowHeight

pVram defw 0
xMod defb 0
leftMask defb 0
rightMask defb 0

cseg

Print1_pPattern equ Zp.Word2
Print1_pVram equ Zp.TmpX1
Print1_leftByte equ Zp.Byte
Print1_rightByte equ Zp.Byte2

Print1:
    sta Print1_pPattern
    lda #0 | sta Print1_pPattern+1
    asl Print1_pPattern | rol Print1_pPattern+1 ;*2
    asl Print1_pPattern | rol Print1_pPattern+1 ;*4
    asl Print1_pPattern | rol Print1_pPattern+1 ;*8
    lda Print1_pPattern | clc | adc #low Patterns | sta Print1_pPattern
    lda Print1_pPattern+1 | adc #high Patterns | sta Print1_pPattern+1

    lda pVram | sta Print1_pVram
    lda pVram+1 | sta Print1_pVram+1

    ldy #0
    do
        lda (Print1_pPattern),y | sta Print1_leftByte
        lda #0 | sta Print1_rightByte
        
        ldx xMod
        if ne
            do
                asl Print1_leftByte | rol Print1_rightByte
                dex
            while ne | wend
        endif

        lda (Print1_pVram,x)
        and leftMask | ora Print1_leftByte | ora #$80
        sta (Print1_pVram,x)
        inc Print1_pVram

        asl Print1_leftByte | rol Print1_rightByte

        lda (Print1_pVram,x)
        and rightMask | ora Print1_rightByte | ora #$80
        sta (Print1_pVram,x)
        dec Print1_pVram

        lda Print1_pVram+1 | clc | adc #4 | sta Print1_pVram+1

        iny
        cpy #8
    while ne | wend
NextColumn:
    inc pVram
    inc xMod

    sec | rol leftMask | asl rightMask
    lda leftMask | cmp #$7f
    if eq
        inc pVram

        lda #0 | sta xMod | sta leftMask
        lda #$fe | sta rightMask
    endif
rts


WindowToVram_pWindow equ Zp.TmpX0
WindowToVram_pBackup equ Zp.Word
WindowToVram_pVram equ Zp.Byte3
WindowToVram_yCount equ Zp.Counter0
WindowToVram_flagsOffset equ Zp.Counter1
WindowToVram_bit equ Zp.X
WindowToVram_flags equ Zp.Y

WindowToVramRow:
    lda WindowToVram_pVram | sta pVram
    lda WindowToVram_pVram+1 | sta pVram+1

    lda #0 | sta xMod | sta leftMask
    lda #$fe | sta rightMask

    ldy #0
    do
        tya | pha
            lda (WindowToVram_pWindow),y
            cmp (WindowToVram_pBackup),y
            if ne
                sta (WindowToVram_pBackup),y
                jsr Print1
            else
                jsr NextColumn
            endif
        pla | tay
        iny
        cpy #WindowWidth
    while ne | wend
NextRow:
    lda WindowToVram_pWindow | clc | adc #WindowWidth | sta WindowToVram_pWindow
    lda WindowToVram_pWindow+1 | adc #0 | sta WindowToVram_pWindow+1

    lda WindowToVram_pBackup | clc | adc #WindowWidth | sta WindowToVram_pBackup
    lda WindowToVram_pBackup+1 | adc #0 | sta WindowToVram_pBackup+1

    lda WindowToVram_pVram | clc | adc #VramRowStep | sta WindowToVram_pVram
    lda WindowToVram_pVram+1 | adc #0 | sta WindowToVram_pVram+1
    cmp #$24
    if eq
        lda WindowToVram_pVram | clc | adc #low VramBlockStep | sta WindowToVram_pVram
        lda WindowToVram_pVram+1 | adc #high VramBlockStep | sta WindowToVram_pVram+1
    endif
rts


; void WindowToVramAll();
WindowToVramAll_: public WindowToVramAll_
    lda #low Vram0 | sta WindowToVram_pVram
    lda #high Vram0 | sta WindowToVram_pVram+1

    lda #low WindowFront_ | sta WindowToVram_pWindow
    lda #high WindowFront_ | sta WindowToVram_pWindow+1

    lda #low Backup_ | sta WindowToVram_pBackup
    lda #high Backup_ | sta WindowToVram_pBackup+1

    lda #WindowHeight
    sta WindowToVram_yCount
    do
        jsr WindowToVramRow
        dec WindowToVram_yCount
    while ne | wend
    lda #0
    sta RowFlags_
    sta RowFlags_+1
    sta RowFlags_+2
rts


; void WindowToVramChanged();
WindowToVramChanged_: public WindowToVramChanged_
    lda #low Vram0 | sta WindowToVram_pVram
    lda #high Vram0 | sta WindowToVram_pVram+1

    lda #low WindowFront_ | sta WindowToVram_pWindow
    lda #high WindowFront_ | sta WindowToVram_pWindow+1

    lda #low Backup_ | sta WindowToVram_pBackup
    lda #high Backup_ | sta WindowToVram_pBackup+1

    ldx #0 | stx WindowToVram_flagsOffset
    lda RowFlags_,x | sta WindowToVram_flags
    lda #1 | sta WindowToVram_bit

    lda #WindowHeight
    sta WindowToVram_yCount
    do
        lda WindowToVram_flags
        and WindowToVram_bit
        if ne
            jsr WindowToVramRow
        else
            jsr NextRow
        endif

        asl WindowToVram_bit
        if eq
            ldx WindowToVram_flagsOffset | inx | stx WindowToVram_flagsOffset
            lda RowFlags_,x | sta WindowToVram_flags
            lda #1 | sta WindowToVram_bit
        endif

        dec WindowToVram_yCount
    while ne | wend
    lda #0
    sta RowFlags_
    sta RowFlags_+1
    sta RowFlags_+2
rts


columns:
    defb 0,0,0,$fe
    defb 1,1,1,$fc
    defb 2,2,3,$f8
    defb 3,3,7,$f0
    defb 4,4,$f,$e0
    defb 5,5,$1f,$c0
    defb 6,6,$3f,0
    defb 8,0,0,$fe
    defb 9,1,1,$fc
    defb 10,2,3,$f8
    defb 11,3,7,$f0
    defb 12,4,$f,$e0
    defb 13,5,$1f,$c0
    defb 14,6,$3f,0
    defb 16,0,0,$fe
    defb 17,1,1,$fc
    defb 18,2,3,$f8
    defb 19,3,7,$f0
    defb 20,4,$f,$e0
    defb 21,5,$1f,$c0
    defb 22,6,$3f,0
    defb 24,0,0,$fe
    defb 25,1,1,$fc
    defb 26,2,3,$f8
    defb 27,3,7,$f0
    defb 28,4,$f,$e0
    defb 29,5,$1f,$c0
    defb 30,6,$3f,0
    defb 32,0,0,$fe
    defb 33,1,1,$fc
    defb 34,2,3,$f8
    defb 35,3,7,$f0
rows:
    defw Vram0+VramRowStep*0
    defw Vram0+VramRowStep*1
    defw Vram0+VramRowStep*2
    defw Vram0+VramRowStep*3
    defw Vram0+VramRowStep*4
    defw Vram0+VramRowStep*5
    defw Vram0+VramRowStep*6
    defw Vram0+VramRowStep*7
    defw Vram1+VramRowStep*0
    defw Vram1+VramRowStep*1
    defw Vram1+VramRowStep*2
    defw Vram1+VramRowStep*3
    defw Vram1+VramRowStep*4
    defw Vram1+VramRowStep*5
    defw Vram1+VramRowStep*6
    defw Vram1+VramRowStep*7
    defw Vram2+VramRowStep*0
    defw Vram2+VramRowStep*1
    defw Vram2+VramRowStep*2
    defw Vram2+VramRowStep*3
    defw Vram2+VramRowStep*4
    defw Vram2+VramRowStep*5
    defw Vram2+VramRowStep*6
    defw Vram2+VramRowStep*7

; void VLocate(byte x, byte y);
dseg
VLocate_@Param0: public VLocate_@Param0
VLocate_x: defb 0
VLocate_@Param1: public VLocate_@Param1
VLocate_y: defb 0
cseg
VLocate_: public VLocate_
    lda VLocate_y | asl a | tax 
    lda rows,x | sta pVram
    lda rows+1,x | sta pVram+1

    lda VLocate_x | asl a | asl a | tax
    lda columns,x | clc | adc pVram | sta pVram
    lda columns+1,x | sta xMod
    lda columns+2,x | sta leftMask
    lda columns+3,x | sta rightMask
rts    


; void VPut1(byte c);
dseg
VPut1_@Param0: public VPut1_@Param0
VPut1_c: defb 0
cseg
VPut1_: public VPut1_
    lda VPut1_c
jmp Print1


; void PrintC(byte c);
dseg
PrintC_@Param0: public PrintC_@Param0
PrintC_c: defb 0
cseg
PrintC_: public PrintC_
    lda PrintC_c
    sec | sbc #' '
jmp Print1


; void PlotMarker(byte x, byte y, byte xMod, byte yMod);
dseg
PlotMarker_@Param0: public PlotMarker_@Param0
PlotMarker_x: defb 0
PlotMarker_@Param1: public PlotMarker_@Param1
PlotMarker_y: defb 0
PlotMarker_@Param2: public PlotMarker_@Param2
PlotMarker_xMod: defb 0
PlotMarker_@Param3: public PlotMarker_@Param3
PlotMarker_yMod: defb 0

PlotMarker_pVram equ Zp.TmpX1
PlotMarker_shift equ Zp.Counter0
PlotMarker_leftByte equ Zp.Byte
PlotMarker_rightByte equ Zp.Byte2

cseg
PlotMarker_: public PlotMarker_
    lda PlotMarker_y | asl a | tax 
    lda rows,x | sta PlotMarker_pVram
    lda rows+1,x | sta PlotMarker_pVram+1

    lda PlotMarker_x | asl a | asl a | tax
    lda columns,x | clc | adc PlotMarker_pVram | sta PlotMarker_pVram
    lda columns+1,x | clc | adc PlotMarker_xMod | sta PlotMarker_shift

    ldx PlotMarker_yMod
    if ne
        lda PlotMarker_pVram+1
        do
            clc| adc #4
            dex
        while ne | wend
        sta PlotMarker_pVram+1
    endif

    lda #2 | sta PlotMarker_leftByte
    lda #0 | sta PlotMarker_rightByte
    ldx PlotMarker_shift
    if ne
        do
            asl PlotMarker_leftByte | rol PlotMarker_rightByte
            dex
        while ne | wend
    endif

    asl PlotMarker_rightByte
    lda PlotMarker_leftByte
    and #$80
    if ne
        lda PlotMarker_rightByte | ora #1 | sta PlotMarker_rightByte
    endif
    lda PlotMarker_leftByte | and #$7f | sta PlotMarker_leftByte
    lda PlotMarker_rightByte | and #$7f | sta PlotMarker_rightByte

    ldy #2
    do
        lda (PlotMarker_pVram,x) | eor PlotMarker_leftByte | sta (PlotMarker_pVram,x)
        inc PlotMarker_pVram

        lda (PlotMarker_pVram,x) | eor PlotMarker_rightByte | sta (PlotMarker_pVram,x)
        dec PlotMarker_pVram    

        lda PlotMarker_pVram+1 | clc | adc #4 | sta PlotMarker_pVram+1
        dey
    while ne | wend
rts