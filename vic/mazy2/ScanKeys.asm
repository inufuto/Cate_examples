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

    lda #$fb
    sta $9120
    lda $9121
    tay
    and #$20    ;L
    if eq
        lda <ZB0
        ora #Keys_Up
        sta <ZB0
    endif
    tya
    and #$40    ;;
    if eq
        lda <ZB0
        ora #Keys_Up
        sta <ZB0
    endif

    lda #$f7
    sta $9120
    lda $9121
    tay
    and #$20    ;,
    if eq
        lda <ZB0
        ora #Keys_Left
        sta <ZB0
    endif
    tya
    and #$40    ;/
    if eq
        lda <ZB0
        ora #Keys_Right
        sta <ZB0
    endif

    lda #$ef
    sta $9120
    lda $9121
    tay
    and #$01    ;SPACE
    if eq
        lda <ZB0
        ora #Keys_Button0
        sta <ZB0
    endif
    tya
    and #$02    ;Z
    if eq
        lda <ZB0
        ora #Keys_Button1
        sta <ZB0
    endif
    tya
    and #$20    ;.
    if eq
        lda <ZB0
        ora #Keys_Down
        sta <ZB0
    endif

    lda $9122
    pha
        and #$7f
        sta $9122

        lda $911f
        tay
        and #$04    ;Up
        if eq
            lda <ZB0
            ora #Keys_Up
            sta <ZB0
        endif
        tya
        and #$08    ;Down
        if eq
            lda <ZB0
            ora #Keys_Down
            sta <ZB0
        endif
        tya
        and #$10    ;Left
        if eq
            lda <ZB0
            ora #Keys_Left
            sta <ZB0
        endif
        tya
        and #$20    ;Trigger
        if eq
            lda <ZB0
            ora #Keys_Button0
            sta <ZB0
        endif

        lda $9120
        and #$80    ;Right
        if eq
            lda <ZB0
            ora #Keys_Right
            sta <ZB0
        endif
    pla
    sta $9122
    
    ldy <ZB0
rts
