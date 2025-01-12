include "atari5200.inc"
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
    
    lda PADDL0
    cmp #255-64
    if cs
        tya
        ora #Keys_Right
        tay
        jmp horz_end
    endif
    cmp #64
    if cc
        tya
        ora #Keys_Left
        tay
    endif
    horz_end:

    lda PADDL1
    cmp #228-57
    if cs
        tya
        ora #Keys_Down
        tay
        jmp vert_end
    endif
    cmp #57
    if cc
        tya
        ora #Keys_Up
        tay
    endif
    vert_end:

    lda TRIG0
    if eq
        tya
        ora #Keys_Button0
        tay
    endif
    lda TRIG1
    if eq
        tya
        ora #Keys_Button0
        tay
    endif
    lda TRIG2
    if eq
        tya
        ora #Keys_Button1
        tay
    endif
    lda TRIG3
    if eq
        tya
        ora #Keys_Button1
        tay
    endif
    cpy #0
    if ne
        lda #0 | sta <ATRACT
    endif
rts
