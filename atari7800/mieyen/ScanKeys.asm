include "Atari7800.inc"
include "ZeroPage.inc"

KeyPort equ $fd30
JoyPort equ $ff08

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
    
    lda SWCHA
    tax
    and #$80
    if eq
        tya
        ora #Keys_Right
        tay
    endif
    txa
    and #$40
    if eq
        tya
        ora #Keys_Left
        tay
    endif
    txa
    and #$20
    if eq
        tya
        ora #Keys_Down
        tay
    endif
    txa
    and #$10
    if eq
        tya
        ora #Keys_Up
        tay
    endif

    lda INPT4
    and #$80
    if eq
        tya
        ora #Keys_Button0
        tay
    endif
rts
