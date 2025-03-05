include 'Apple2.inc'
include 'ZeroPage.inc'

Keys_Left equ $01
Keys_Right equ $02
Keys_Up equ $04
Keys_Down equ $08
Keys_Dir equ $0f
Keys_Button0 equ $10
Keys_Button1 equ $20

    cseg

ScanKeys_: public ScanKeys_
    lda #0
    sta <ZB0

    ldx #0
    jsr PREAD
    tya
    cmp #$20
    if cc
        lda <ZB0
        ora #Keys_Left
        sta <ZB0
    else
        cmp #$e0
        if cs
            lda <ZB0
            ora #Keys_Right
            sta <ZB0
        endif
    endif

    ldx #1
    jsr PREAD
    tya
    cmp #$20
    if cc
        lda <ZB0
        ora #Keys_Up
        sta <ZB0
    else
        cmp #$e0
        if cs
            lda <ZB0
            ora #Keys_Down
            sta <ZB0
        endif
    endif

    lda PB0
    and #$80
    if ne
        lda <ZB0
        ora #Keys_Button0
        sta <ZB0
    endif

    lda PB1
    and #$80
    if ne
        lda <ZB0
        ora #Keys_Button1
        sta <ZB0
    endif

    ldy <ZB0
rts
