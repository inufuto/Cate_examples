include "VVram.inc"
include "Chars.inc"

ext @Temp@Byte, @Temp@Byte2, @Temp@Byte3
ext @Temp@Word, @Temp@Word2, @Temp@Word3

ext VVram_
ext BaseX_, BaseY_, Map_

MapStep equ 8

pMapRow equ @Temp@Word
pMapByte equ @Temp@Word2
pVVram equ @Temp@Word3
mask equ @Temp@Byte
yCount equ @Temp@Byte2
xCount equ @Temp@Byte3

; ptr<byte> VVramPtr(byte x, byte y);
dseg
VVramPtr_@Param1: public VVramPtr_@Param1
VVramPtr_y:
    defs 1
cseg
VVramPtr_: public	VVramPtr_
	psha | pshb
        ldab VVramPtr_y
        aslb ;*2
        addb VVramPtr_y ;*3
        stab <pVVram+1 | clr <pVVram
        asl <pVVram+1 | rol <pVVram ;6
        asl <pVVram+1 | rol <pVVram ;12
        asl <pVVram+1 | rol <pVVram ;24
        adda <pVVram+1 | staa <pVVram+1
        ldaa <pVVram | adca #0 | staa <pVVram
        ldaa <pVVram+1 | adda #low VVram_ | staa <pVVram+1
        ldaa <pVVram | adca #high VVram_ | staa <pVVram
        ldx <pVVram
	pulb | pula
rts


; void MapToVVram();
cseg
MapToVVram_: public MapToVVram_
	psha | pshb
        ldab BaseY_
        clra
        aslb | rola ;*2
        aslb | rola ;*4
        aslb | rola ;*8
        addb #low Map_ | adca #high Map_
        stab <pMapRow+1
        ldab BaseX_
        lsrb | lsrb | lsrb
        addb <pMapRow+1 | adca #0
        staa <pMapRow | stab <pMapRow+1
        ldaa #1
        ldab BaseX_
        andb #7
        do | while ne
            asla
            decb
        wend
        staa <mask
        ldx #VVram_ | stx <pVVram
        ldaa #VVramHeight | staa <yCount
        do
            ldx <pMapRow | stx <pMapByte
            ldaa #VVramWidth | staa <xCount
            do
                ldx <pMapByte
                ldab 0,x
                andb <mask
                if ne
                    ldaa #Char_Wall
                else
                    ldaa #Char_Space
                endif
                ldx <pVVram
                staa 0,x | inx
                stx <pVVram
                asl <mask
                if eq
                    ldaa #1 | staa <mask
                    ldx <pMapByte | inx | stx <pMapByte
                endif
                dec <xCount
            while ne | wend
            ldaa <pMapRow | ldab <pMapRow+1
            addb #low MapStep | adca #high MapStep
            staa <pMapRow | stab <pMapRow+1
            dec <yCount
        while ne | wend
	pulb | pula
rts
