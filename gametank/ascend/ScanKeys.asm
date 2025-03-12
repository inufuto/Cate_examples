include "gametank.inc"

Keys_Left equ $01
Keys_Right equ $02
Keys_Up equ $04
Keys_Down equ $08
Keys_Dir equ $0f
Keys_Button0 equ $10
Keys_Button1 equ $20

zseg
lowValue: public lowValue
    defb 0
highValue:
    defb 0

; byte ScanKeys();
cseg
ScanKeys_: public ScanKeys_
    pha
        lda GAME_PAD2
        ldy #0
        lda GAME_PAD1 | sta <lowValue
        lda GAME_PAD1 | sta <highValue

        tax
        and #$01 ; Right
        if eq
            tya | ora #Keys_Right | tay
        endif
        txa
        and #$02 ; Left
        if eq
            tya | ora #Keys_Left | tay
        endif
        txa
        and #$04
        if eq
            tya | ora #Keys_Down | tay
        endif
        txa
        and #$08
        if eq
            tya | ora #Keys_Up | tay
        endif
        txa
        and #$10 ; B
        if eq
            tya | ora #Keys_Button1 | tay
        endif
        txa
        and #$20 ; C
        if eq
            tya | ora #Keys_Button1 | tay
        endif

        lda <lowValue        
        tax
        and #$10 ; A
        if eq
            tya | ora #Keys_Button0 | tay
        endif
        txa
        and #$20 ; S
        if eq
            tya | ora #Keys_Button0 | tay
        endif
    pla
rts
