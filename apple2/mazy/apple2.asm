include "apple2.inc"
include "KeyBits.inc"
include "ZeroPage.inc"

ext InitPatterns, ClearVram

dseg
Stick0: public Stick0
    defb 0
Stick1: public Stick1
    defb 0
stickIndex: public stickIndex
    defb 0

cseg
Init: public Init
    lda TXTCLR
    lda MIXCLR
    lda TXTPAGE1
    lda HIRES
    lda #0 | sta stickIndex

    jsr ClearVram
    jsr InitPatterns
rts

Fin:    public Fin
    lda TXTSET
rts

ReadStick: public ReadStick
    lda stickIndex
    if eq
        ldx #0
        jsr PREAD
        sty Stick0
        lda #1
    else
        ldx #1
        jsr PREAD
        sty Stick1
        lda #0
    endif            
    sta stickIndex
rts

cseg
ScanKeys: public ScanKeys
    jsr ReadStick

    lda #0
    sta <Zp.Byte

    lda Stick0
    cmp #$20
    if cc
        lda <Zp.Byte
        ora #Keys.Left
        sta <Zp.Byte
    else
        cmp #$e0
        if cs
            lda <Zp.Byte
            ora #Keys.Right
            sta <Zp.Byte
        endif
    endif

    lda Stick1
    cmp #$20
    if cc
        lda <Zp.Byte
        ora #Keys.Up
        sta <Zp.Byte
    else
        cmp #$e0
        if cs
            lda <Zp.Byte
            ora #Keys.Down
            sta <Zp.Byte
        endif
    endif

    lda PB0
    and #$80
    if ne
        lda <Zp.Byte
        ora #Keys.Button.0
        sta <Zp.Byte
    endif

    lda PB1
    and #$80
    if ne
        lda <Zp.Byte
        ora #Keys.Button.1
        sta <Zp.Byte
    endif
    lda <Zp.Byte
rts
