include "GameKing.inc"

Keys_Left equ $01
Keys_Right equ $02
Keys_Up equ $04
Keys_Down equ $08
Keys_Dir equ $0f
Keys_Button0 equ $10
Keys_Button1 equ $20

; byte ScanKeys();
cseg
ScanKeys_: public ScanKeys_
    ldy #0
    lda <StartButtonPort
    and #$02 ; Start
    if eq
        tya | ora #Keys_Button0 | tay
    endif
    
    lda #$fe | sta <ControllerPort
    lda <ControllerPort
    tax
    and #$02 ; Select
    if eq
        tya | ora #Keys_Button1 | tay
    endif
    txa
    and #$04 ; A
    if eq
        tya | ora #Keys_Button0 | tay
    endif
    txa
    and #$08 ; B
    if eq
        tya | ora #Keys_Button1 | tay
    endif
    txa
    and #$10
    if eq
        tya | ora #Keys_Up | tay
    endif
    txa
    and #$20
    if eq
        tya | ora #Keys_Down | tay
    endif
    txa
    and #$40
    if eq
        tya | ora #Keys_Left | tay
    endif
    txa
    and #$80
    if eq
        tya | ora #Keys_Right | tay
    endif
    tya
rts
