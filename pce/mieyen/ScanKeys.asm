include "ZeroPage.inc"

Keys_Left equ $01
Keys_Right equ $02
Keys_Up equ $04
Keys_Down equ $08
Keys_Dir equ $0f
Keys_Button0 equ $10
Keys_Button1 equ $20

cseg

; byte ScanKeys();
ScanKeys_: public ScanKeys_
    ldy #0

    lda #1 | sta $1000
    lda #3 | sta $1000

    lda #1 | sta $1000
    jsr Wait
    lda $1000

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
        ora #Keys_Right
        tay
    endif
    txa
    and #$04
    if eq
        tya
        ora #Keys_Down
        tay
    endif
    txa
    and #$08
    if eq
        tya
        ora #Keys_Left
        tay
    endif
    
    stz $1000
    jsr Wait
    lda $1000
    
    tax
    and #$01
    if eq
        tya
        ora #Keys_Button0
        tay
    endif
    txa
    and #$02
    if eq
        tya
        ora #Keys_Button1
        tay
    endif
    txa
    and #$04
    if eq
        tya
        ora #Keys_Button1
        tay
    endif
    txa
    and #$08
    if eq
        tya
        ora #Keys_Button0
        tay
    endif
rts


Wait:
    nop | nop | nop | nop | nop
rts
