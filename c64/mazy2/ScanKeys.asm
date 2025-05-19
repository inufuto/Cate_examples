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
    ldy #0

    lda #$ff
    sta $dc00
    lda $dc01
    tax
    and #$01
    if eq
        tya
        ora #Keys_Up
        tay
    endif
    txa
    and #$02
    if eq
        tya
        ora #Keys_Down
        tay
    endif
    txa
    and #$04
    if eq
        tya
        ora #Keys_Left
        tay
    endif
    txa
    and #$08
    if eq
        tya
        ora #Keys_Right
        tay
    endif
    txa
    and #$10
    if eq
        tya
        ora #Keys_Button0
        tay
    endif
    tya
    bne exit

    lda #$fd
    sta $dc00
    lda $dc01
    and #$10    ;Z
    if eq
        tya
        ora #Keys_Button1
        tay
    endif

    lda #$ef
    sta $dc00
    lda $dc01
    tax
    and #$20    ;K
    if eq
        tya
        ora #Keys_Right
        tay
    endif
    txa
    and #$10    ;M
    if eq
        tya
        ora #Keys_Down
        tay
    endif
    txa
    and #$04    ;J
    if eq
        tya
        ora #Keys_Left
        tay
    endif
    txa
    and #$02    ;I
    if eq
        tya
        ora #Keys_Up
        tay
    endif

    lda #$7f
    sta $dc00
    lda $dc01
    and #$10    ;SPACE
    if eq
        tya
        ora #Keys_Button0
        tay
    endif
exit:
rts
