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
Wait_t:
    defb 0
cseg
Wait_: public Wait_
WaitValue equ 20
    pha
        ldy #4
        sty Wait_t
        do
            ldx #WaitValue
            do
                ldy #WaitValue
                do
                    dey
                while ne | wend
                dex
            while ne | wend
            dec Wait_t
        while ne | wend
        jsr ReadStick
    pla
rts
