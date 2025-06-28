include "VVram.inc"
include "Chars.inc"

ext VVram_, CellMap_
Cell_Type_Floor equ $08
Cell_Type_LiftBottom equ $18

zseg 
Dp.Word0:
    defw 0

; ptr<byte> VVramPtr(byte x, byte y);
cseg
VVramPtr_: public VVramPtr_
    sta <Dp.Word0+1
    clr <Dp.Word0
    lda #VVramWidth
    mul
    addd <Dp.Word0
    addd #VVram_
rts


; void DrawBackGround();
DrawBackGround_: public DrawBackGround_
    pshs a,b,x,y
        ldx #VVram_
        lda #Char_Roof_Left | sta ,x+
        lda #Char_Roof_Center
        ldb #VVramWidth-2
        do
            sta ,x+
            decb
        while ne | wend
        lda #Char_Roof_Right | sta ,x+

        lda #Char_Roof_Center
        ldb #VVramWidth
        do
            sta ,x+
            decb
        while ne | wend

        ldy #CellMap_
        ldb #5
        do
            pshs b
                ldb #16
                do
                    pshs b
                        lda #0
                        ldb #3
                        do
                            sta ,x+
                            sta ,x+
                            leax VVramWidth-2,x
                            decb
                        while ne | wend

                        lda ,y+
                        anda #Cell_Type_LiftBottom
                        cmpa #Cell_Type_LiftBottom
                        if eq
                            lda #Char_LiftBottom
                        else
                            anda #Cell_Type_Floor
                            if ne
                                lda #Char_Floor
                            else
                                lda #Char_Space
                            endif
                        endif
                        sta ,x+
                        sta ,x+
                        leax -VVramWidth*3,x
                    puls b
                    decb
                while ne | wend
                leax VVramWidth*3,x
            puls b
            decb
        while ne | wend
    puls a,b,x,y
rts
