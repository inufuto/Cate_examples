include 'Apple2.inc'

ext InitVram_
ext stickIndex

cseg

Init_:   public Init_
    lda TXTCLR
    lda MIXCLR
    lda TXTPAGE1
    lda HIRES
    jsr InitVram_
    lda #0 | sta stickIndex
rts

Fin_:    public Fin_
    lda TXTSET
rts
