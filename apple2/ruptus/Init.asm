include 'Apple2.inc'

    cseg

Init_:   public Init_
    lda TXTCLR
    lda MIXCLR
    lda TXTPAGE1
    lda HIRES
rts

Fin_:    public Fin_
    lda TXTSET
rts
