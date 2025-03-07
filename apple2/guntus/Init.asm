include "apple2.inc"

ext InitVram_, InitSound_
ext stickIndex

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
