include "Apple2.inc"

ext InitVram_, InitSound_, Main_
ext ReadStick, stickIndex

cseg
    lda TXTCLR
    lda MIXCLR
    lda TXTPAGE1
    lda HIRES
    jsr InitVram_
    jsr InitSound_
    lda #0 | sta stickIndex
jmp Main_


dseg
Wait_@Param0: public Wait_@Param0
    defb 0
cseg
Wait_: public Wait_
WaitValue equ $28
    do
        ldx #WaitValue
        do
            ldy #WaitValue
            do
                dey
            while ne | wend
            dex
        while ne | wend
        dec Wait_@Param0
    while ne | wend
    pha
        jsr ReadStick
    pla
rts
