include "ZeroPage.inc"
include "Vram.inc"
include "VVram.inc"

ext VVram_
ext GroundBits_, DotOffset_


; word VVramPtr(byte x, byte y);
dseg
VVramPtr_@Param1: public VVramPtr_@Param1
VVramPtr_y:
	defs 1
cseg
Table:
    defw VVramWidth*0,VVramWidth*1,VVramWidth*2,VVramWidth*3,VVramWidth*4,VVramWidth*5,VVramWidth*6,VVramWidth*7
    defw VVramWidth*8,VVramWidth*9,VVramWidth*10,VVramWidth*11,VVramWidth*12,VVramWidth*13,VVramWidth*14,VVramWidth*15
VVramPtr_: public VVramPtr_
	pha
        lda	VVramPtr_y
        asl a | tax
        lda Table,x | inx
        sta <pVVram
        lda Table,x
        sta <pVVram+1
        tya |clc|adc <pVVram | tay
        lda <pVVram+1 | adc #0 | tax
        tya | clc|adc #low VVram_ | tay
        txa | adc #high VVram_ | tax
	pla
rts


Ground_Flat equ 0
Ground_Up equ 1
Ground_Down equ 2
Ground_Space equ 3

Char_Ground equ $55
Char_GroundUp0 equ $00
Char_GroundUp1 equ $01
Char_GroundUpUp0 equ $15
Char_GroundUpUp1 equ $55
Char_GroundUpDown0 equ $15
Char_GroundUpDown1 equ $55
Char_GroundDown0 equ $45
Char_GroundDown1 equ $04
Char_GroundDownDown0 equ $55
Char_GroundDownDown1 equ $55
Char_GroundDownUp0 equ $45
Char_GroundDownUp1 equ $05

pVVram equ ZW0
sourceW equ ZW1
yCount equ ZB0
byteCount equ ZB1
bitCount equ ZB3
gOffset equ ZB4

; void GroundToVVram();
cseg
GroundChars:
    defb Char_Ground,Char_Ground ; 0: Ground_Flat,Ground_Flat
    defb Char_GroundUpUp0,Char_GroundUpUp1 ; 1: Ground_Up,Ground_Flat
    defs 2 ; 2: Ground_Down,Ground_Flat
    defs 2 ; 3: Ground_Space,Ground_Flat
    defs 2 ; 4: Ground_Flat,Ground_Up
    defs 2 ; 5: Ground_Up,Ground_Up
    defb Char_GroundDownUp0,Char_GroundDownUp1 ; 6: Ground_Down,Ground_Up
    defb Char_GroundUp0,Char_GroundUp1 ; 7: Ground_Space,Ground_Up
    defb Char_GroundDownDown0,Char_GroundDownDown1 ; 8: Ground_Flat,Ground_Down
    defb Char_GroundUpDown0,Char_GroundUpDown1 ; 9: Ground_Up,Ground_Down
    defs 2 ; 10: Ground_Down,Ground_Down
    defs 2 ; 11: Ground_Space,Ground_Down
    defs 2 ; 12: Ground_Flat,Ground_Space
    defs 2 ; 13: Ground_Up,Ground_Space
    defb Char_GroundDown0,Char_GroundDown1 ; 14: Ground_Down,Ground_Space
    defb Char_Space,Char_Space ; 15: Ground_Space,Ground_Space
GroundToVVram_: public GroundToVVram_
    pha
        lda #low VVram_ | sta <pVVram
        lda #high VVram_ | sta <pVVram+1

        ldx #2
        do
            lda #0 | tay
            do
                sta (<pVVram),y | iny
                cpy #VVramWidth*3
            while ne | wend
            lda <pVVram | clc|adc #VVramWidth*3 | sta <pVVram
            lda <pVVram+1 | adc #0 | sta <pVVram+1
            dex
        while ne | wend

        ldx #0
        lda #6 | sta <yCount
        do
            ldy #0
            lda #VVramWidth/4 | sta <byteCount
            do
                lda GroundBits_,x | inx | sta <sourceW
                lda GroundBits_,x | sta <sourceW+1
                lda #4 | sta <bitCount
                do
                    lda <sourceW
                    and #$0f
                    if eq
                        ; Ground_Flat
                        lda #Char_Ground
                        jmp GroundToVram_write
                    endif
                    cmp #$0f
                    if eq
                        lda #Char_Space
                        jmp GroundToVram_write
                    endif
                    stx <gOffset
                        asl a
                        clc|adc DotOffset_
                        tax | lda GroundChars,x
                    ldx <gOffset

                    GroundToVram_write:
                    sta (<pVVram),y | iny

                    lsr <sourceW+1 | ror <sourceW
                    lsr <sourceW+1 | ror <sourceW

                    dec <bitCount
                while ne | wend
                dec <byteCount
            while ne | wend
            inx

            lda <pVVram | clc|adc #VVramWidth | sta <pVVram
            lda <pVVram+1 | adc #0 | sta <pVVram+1
            
            dec <yCount
        while ne | wend

        lda #Char_Ground
        ldy #0
        do
            sta (<pVVram),y | iny
            cpy #VVramWidth*2
        while ne | wend
    pla
rts
