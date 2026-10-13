include "VVram.inc"
include "Direct.inc"
include "Chars.inc"

ext VVram_

; ptr<byte> VVramPtr(byte x, byte y);
cseg
VVramPtr_: public VVramPtr_
    sta <@Temp@Word+1
    clr <@Temp@Word
    lda #VVramWidth
    mul
    addd <@Temp@Word
    addd #VVram_
rts


ext Map_
ext BaseX_, BaseY_

MapStep equ 8

; void MapToVVram();
zseg
MapByte defb 0
cseg
MapToVVram_: public MapToVVram_
    pshs a,b,x,y
        lda BaseY_
        ldb #MapStep
        mul
        addd #Map_
        tfr d,x

        lda BaseX_
        asra
        asra
        asra
        leax a,x

        ldb #1
        lda BaseX_
        anda #7
        do | while ne
            aslb
            deca
        wend
        stb MapByte

        ldy #VVram_
        lda #VVramHeight
        do
            pshs a,x
                lda #VVramWidth
                do
                    pshs a
                        lda ,x
                        anda MapByte
                        if ne
                            lda #Char_Wall
                        else
                            lda #Char_Space
                        endif
                        sta ,y+
                        asl MapByte
                        if eq
                            leax 1,x
                            inc MapByte
                        endif
                    puls a
                    deca
                while ne | wend
            puls a,x
            leax MapStep,x
            deca
        while ne | wend
    puls a,b,x,y
rts