include "ZeroPage.inc"
include "VVram.inc"
include "Chars.inc"

ext VVram_

pVVram equ ZW0

; ptr<byte> VVramPtr(byte x, byte y);
dseg
VVramPtr_@Param1: public VVramPtr_@Param1
VVramPtr_y:
	defb 0
cseg
VVramPtr_: public VVramPtr_
	pha
        lda	VVramPtr_y
        asl a | asl a | asl a  ;*8
        sta <pVVram | lda #0 | sta <pVVram+1
        asl <pVVram | rol <pVVram+1 ;16
        asl <pVVram | rol <pVVram+1 ;32
        
        tya | clc|adc <pVVram | tay
        lda <pVVram+1 | adc #0 | tax
        tya | clc|adc #low VVram_ | tay
        txa | adc #high VVram_ | tax
	pla
rts


ext GroundBits_, DotOffset_

Ground_Flat equ 0
Ground_Up equ 1
Ground_Down equ 2
Ground_Space equ 3

pVVram equ ZW0
sourceW equ ZW1
yCount equ ZB0
byteCount equ ZB1
bitCount equ ZB3
gOffset equ ZB4

; void GroundToVVram();
cseg
GroundChars:
    defb Char_Ground ; 0: Ground_Flat,Ground_Flat
    defb Char_GroundUpUp ; 1: Ground_Up,Ground_Flat
    defb 1 ; 2: Ground_Down,Ground_Flat
    defb 1 ; 3: Ground_Space,Ground_Flat
    defb 1 ; 4: Ground_Flat,Ground_Up
    defb 1 ; 5: Ground_Up,Ground_Up
    defb Char_GroundDownUp ; 6: Ground_Down,Ground_Up
    defb Char_GroundUp ; 7: Ground_Space,Ground_Up
    defb Char_GroundDownDown ; 8: Ground_Flat,Ground_Down
    defb Char_GroundUpDown ; 9: Ground_Up,Ground_Down
    defb 1 ; 10: Ground_Down,Ground_Down
    defb 1 ; 11: Ground_Space,Ground_Down
    defb 1 ; 12: Ground_Flat,Ground_Space
    defb 1 ; 13: Ground_Up,Ground_Space
    defb Char_GroundDown ; 14: Ground_Down,Ground_Space
    defb Char_Space ; 15: Ground_Space,Ground_Space
GroundToVVram_: public GroundToVVram_
    pha
        lda #low VVram_ | sta <pVVram
        lda #high VVram_ | sta <pVVram+1

        ldx #2
        do
            lda #0 | tay
            do
                sta (<pVVram),y | iny
                cpy #VVramWidth*5
            while ne | wend
            lda <pVVram | clc|adc #VVramWidth*5 | sta <pVVram
            lda <pVVram+1 | adc #0 | sta <pVVram+1
            dex
        while ne | wend

        ldx #0
        lda #10 | sta <yCount
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
                        tax | lda GroundChars,x
                    ldx <gOffset
                    clc|adc DotOffset_

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
