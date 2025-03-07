include 'Apple2.inc'

ext InitVram_

    cseg

Init_:   public Init_
    lda TXTCLR
    lda MIXCLR
    lda TXTPAGE1
    lda HIRES
    jsr InitVram_
rts

Fin_:    public Fin_
    lda TXTSET
rts
