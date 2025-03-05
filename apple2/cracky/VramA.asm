include "ZeroPage.inc"
include "Vram.inc"
include "VVram.inc"

ext VVramFront_, RowFlags_, Chars_, CharColors_
ext ClearRowFlags_

VramTop equ Vram0+VramRowStep*2
VVramTop equ VVramFront_+VVramWidth


    dseg
Backup_: public Backup_
    defs VVramWidth*(VVramHeight-2)
pVram:
    defw 0
xMod:
    defb 0
leftMask:
    defb 0
rightMask:
    defb 0

Print1_pPattern equ ZW1
Print1_pVram equ ZW3
Print1_leftByte equ ZB0
Print1_rightByte equ ZB2
ColorBit equ ZB3

    cseg
Print1:
    sta Print1_pPattern
    cmp #0
    if ne
        tax
        lda CharColors_,x
        sta ColorBit
    endif
    lda #0 | sta Print1_pPattern+1
    asl Print1_pPattern | rol Print1_pPattern+1 ;*2
    asl Print1_pPattern | rol Print1_pPattern+1 ;*4
    asl Print1_pPattern | rol Print1_pPattern+1 ;*8
    lda Print1_pPattern | clc | adc #low Chars_ | sta Print1_pPattern
    lda Print1_pPattern+1 | adc #high Chars_ | sta Print1_pPattern+1

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
        and leftMask | ora Print1_leftByte | and #$7f | ora ColorBit
        sta (Print1_pVram,x)
        inc Print1_pVram

        asl Print1_leftByte | rol Print1_rightByte

        lda (Print1_pVram,x)
        and rightMask | ora Print1_rightByte | and #$7f | ora ColorBit
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


VVramToVram_pVVram equ ZW2
VVramToVram_pBackup equ ZW0
VVramToVram_pVram equ ZW4
VVramToVram_flagsOffset equ ZB4
VVramToVram_bit equ ZB5
VVramToVram_flags equ ZB6
dseg
VVramToVram_yCount:
    defb 0
cseg
VVramToVramRow:
    lda VVramToVram_pVram | sta pVram
    lda VVramToVram_pVram+1 | sta pVram+1

    lda #0 | sta xMod | sta leftMask
    lda #$fe | sta rightMask
    lda #$80 | sta ColorBit

    ldy #0
    do
        tya | pha
            lda (VVramToVram_pVVram),y
            cmp (VVramToVram_pBackup),y
            if ne
                sta (VVramToVram_pBackup),y
                jsr Print1
            else
                jsr NextColumn
            endif
        pla | tay
        iny
        cpy #VVramWidth
    while ne | wend
NextRow:
    lda VVramToVram_pVVram | clc | adc #VVramWidth | sta VVramToVram_pVVram
    lda VVramToVram_pVVram+1 | adc #0 | sta VVramToVram_pVVram+1

    lda VVramToVram_pBackup | clc | adc #VVramWidth | sta VVramToVram_pBackup
    lda VVramToVram_pBackup+1 | adc #0 | sta VVramToVram_pBackup+1
                                                        _deb:  public _deb
    lda VVramToVram_pVram | clc | adc #VramRowStep | sta VVramToVram_pVram
    lda VVramToVram_pVram+1 | adc #0 | sta VVramToVram_pVram+1
    cmp #$24
    if eq
        lda VVramToVram_pVram | clc | adc #low VramBlockStep | sta VVramToVram_pVram
        lda VVramToVram_pVram+1 | adc #high VramBlockStep | sta VVramToVram_pVram+1
    endif
rts


; void VVramToVramAll();
VVramToVramAll_: public VVramToVramAll_
    lda #low VramTop | sta VVramToVram_pVram
    lda #high VramTop | sta VVramToVram_pVram+1

    lda #low VVramTop | sta VVramToVram_pVVram
    lda #high VVramTop | sta VVramToVram_pVVram+1

    lda #low Backup_ | sta VVramToVram_pBackup
    lda #high Backup_ | sta VVramToVram_pBackup+1

    lda #VVramHeight-2 | sta VVramToVram_yCount
    do
        jsr VVramToVramRow
        dec VVramToVram_yCount
    while ne | wend
    jsr ClearRowFlags_
rts


; void VVramToVramChanged();
VVramToVramChanged_: public VVramToVramChanged_
    lda #low VramTop | sta VVramToVram_pVram
    lda #high VramTop | sta VVramToVram_pVram+1

    lda #low VVramTop | sta VVramToVram_pVVram
    lda #high VVramTop | sta VVramToVram_pVVram+1

    lda #low Backup_ | sta VVramToVram_pBackup
    lda #high Backup_ | sta VVramToVram_pBackup+1

    ldx #0 | stx VVramToVram_flagsOffset
    lda RowFlags_,x | sta VVramToVram_flags
    lda #2 | sta VVramToVram_bit

    lda #VVramHeight-2 | sta VVramToVram_yCount
    do
        lda VVramToVram_flags
        and VVramToVram_bit
        if ne
            jsr VVramToVramRow
        else
            jsr NextRow
        endif

        asl VVramToVram_bit
        if eq
            ldx VVramToVram_flagsOffset | inx | stx VVramToVram_flagsOffset
            lda RowFlags_,x | sta VVramToVram_flags
            lda #1 | sta VVramToVram_bit
        endif

        dec VVramToVram_yCount
    while ne | wend
    jsr ClearRowFlags_
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
    sec | sbc #" "
jmp Print1
