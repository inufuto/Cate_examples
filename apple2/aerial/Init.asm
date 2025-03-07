include 'Apple2.inc'

ext InitVram_, InitSound_
ext ReadStick, stickIndex

cseg

Init_:   public Init_
    lda TXTCLR
    lda MIXCLR
    lda TXTPAGE1
    lda HIRES
    jsr InitVram_
    jsr InitSound_
    lda #0 | sta stickIndex
rts

Fin_:    public Fin_
    lda TXTSET
rts


Wait_: public Wait_
WaitValue equ $28
    ldx #WaitValue
    do
        ldy #WaitValue
        do
            dey
        while ne | wend
        dex
    while ne | wend
    pha
        jsr ReadStick
    pla
rts
