include "Zeropage.inc"
include "Port.inc"
include "Vram.inc"
include "VVram.inc"

ext BaseX_, BaseY_
ext WaitVdp

Char_Space equ $00
Char_Wall equ $40
MapStep equ 8

wSource equ ZW0
wDestination equ ZW1
yCount equ ZB0
maskBit equ ZB1

; word VVramAddress(byte x, byte y);
zseg
VVramAddress_x:
    defb 0
dseg
VVramAddress_@Param1: public	VVramAddress_@Param1
VVramAddress_y:	defs 1
cseg
VVramAddress_: public	VVramAddress_
	pha
        sty VVramAddress_x
        lda	VVramAddress_y
        asl a ;*2
        clc|adc VVramAddress_y ;*3
        asl a ;*6
        sta <wDestination | lda #0 | sta <wDestination+1
        asl <wDestination | rol <wDestination+1 ;12
        asl <wDestination | rol <wDestination+1 ;24
        lda VVramAddress_x | clc | adc <wDestination | sta <wDestination
        lda <wDestination+1 | adc #0 | sta <wDestination+1
        lda <wDestination | clc|adc #low VVram | tay
        lda <wDestination+1 | adc #high VVram | tax
	pla
rts


; void MapToVVram();
dseg
rowBuff:
    defs 4
cseg
MapToVVram_: public MapToVVram_
    pha
        lda #0 | sta <wSource+1
        lda BaseY_
        asl a | rol <wSource+1   ; *2
        asl a | rol <wSource+1   ; *4
        asl a | rol <wSource+1   ; *8 : MapStep
        clc|adc #low Map | sta <wSource+0
        lda <wSource+1 | adc #high Map | sta <wSource+1

        lda BaseX_
        lsr a | lsr a | lsr a
        clc|adc <wSource+0 | sta <wSource+0
        lda <wSource+1 | adc #0 | sta <wSource+1
        
        lda #1 | sta <maskBit
        lda BaseX_
        and #7
        tax
        do | while ne
            asl <maskBit
            dex
        wend

        lda #low VVram | sta <wDestination+0
        lda #high VVram or $40 | sta <wDestination+1

        lda #VVramHeight | sta <yCount
        do
            sei
                lda <wSource | sta VdpWritePort+1
                lda <wSource+1 | sta VdpWritePort+1
                ldx #0
                do
                    jsr WaitVdp
                    lda VdpReadPort
                    sta rowBuff,x | inx
                    cpx #4
                while ne | wend
            cli
            sei
                lda <wDestination | sta VdpWritePort+1
                lda <wDestination+1 | sta VdpWritePort+1
                ldx #0
                ldy #VVramWidth
                do
                    lda rowBuff,x
                    and <maskBit
                    if ne
                        lda #Char_Wall
                    else
                        lda #Char_Space
                    endif
                    sta VdpWritePort
                    jsr WaitVdp
                    
                    asl <maskBit
                    if eq
                        inx
                        inc <maskBit
                    endif

                    dey
                while ne | wend
            cli
            lda <wSource+0 | clc|adc #MapStep | sta <wSource+0
            lda <wSource+1 | adc #0 | sta <wSource+1
            
            lda <wDestination+0 | clc|adc #VVramWidth | sta <wDestination+0
            lda <wDestination+1 | adc #0 | sta <wDestination+1

            dec <yCount
        while ne | wend
    pla
rts
