Keys_Left equ $01
Keys_Right equ $02
Keys_Up equ $04
Keys_Down equ $08
Keys_Dir equ $0f
Keys_Button0 equ $10
Keys_Button1 equ $20


; byte ScanKeys();
ScanKeys_: public ScanKeys_
    ldy #0
    ldx #0

    lda #2 | sta $eE810
    lda $E812
    and #$01 ; Q
    if eq
        tya
        ora #Keys_Button0
        tay
    endif

    lda #3 | sta $eE810
    lda $E812 | tax
    and #$40 ; 8
    if eq
        tya
        ora #Keys_Up
        tay
    endif
    txa
    and #$01 ; D
    if eq
        tya
        ora #Keys_Up
        tay
    endif

    lda #4 | sta $eE810
    lda $E812 | tax
    and #$40 ; 4
    if eq
        tya
        ora #Keys_Left
        tay
    endif
    txa
    and #$80 ; 6
    if eq
        tya
        ora #Keys_Right
        tay
    endif
    txa
    and #$01 ; A
    if eq
        tya
        ora #Keys_Left
        tay
    endif
    txa
    and #$02 ; D
    if eq
        tya
        ora #Keys_Right
        tay
    endif

    lda #5 | sta $eE810
    lda $E812 | tax
    and #$40 ; 5
    if eq
        tya
        ora #Keys_Down
        tay
    endif
    txa
    and #$01 ; S
    if eq
        tya
        ora #Keys_Down
        tay
    endif

    lda #7 | sta $eE810
    lda $E812
    and #$40 ; 2
    if eq
        tya
        ora #Keys_Down
        tay
    endif

    lda #8 | sta $eE810
    lda $E812 | tax
    and #$40 ; 0
    if eq
        tya
        ora #Keys_Button0
        tay
    endif
    txa
    and #$21
    cmp #$21
    if ne
        tya
        ora #Keys_Button1
        tay
    endif

    lda #9 | sta $eE810
    lda $E812 | tax
    and #$04 ; Space
    if eq
        tya
        ora #Keys_Button0
        tay
    endif
    txa
    and #$40 ; .
    if eq
        tya
        ora #Keys_Button1
        tay
    endif
rts