include "atari800.inc"
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
    
    lda #$ff | sta $fd30

    lda STICK0
    tax
    and #8
    if eq
        tya
        ora #Keys_Right
        tay
    endif
    txa
    and #4
    if eq
        tya
        ora #Keys_Left
        tay
    endif
    txa
    and #2
    if eq
        tya
        ora #Keys_Down
        tay
    endif
    txa
    and #1
    if eq
        tya
        ora #Keys_Up
        tay
    endif

    lda STRIG0
    if eq
        tya
        ora #Keys_Button0
        tay
    endif
    ; lda STRIG2
    ; if eq
    ;     tya
    ;     ora #Keys_Button1
    ;     tay
    ; endif
    cpy #0
    if ne
        lda #0 | sta <ATRACT
    endif
rts
