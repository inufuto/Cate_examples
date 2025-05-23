include "Vram.inc"

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
    sei
        ldy #0

        lda #0 or VideoMode | sta $b000
        lda $b001
        ; tax
        and #$80 ; Shift
        if eq
            tya | ora #Keys_Button1 | tay
        endif

        lda #1 or VideoMode | sta $b000
        lda $b001
        tax
        and #$04 ; <
        if eq
            tya | ora #Keys_Left | tay
        endif
        txa
        and #$20 ; Z
        if eq
            tya | ora #Keys_Left | tay
        endif

        lda #2 or VideoMode | sta $b000
        lda $b001
        ; tax
        and #$04 ; ;
        if eq
            tya | ora #Keys_Up | tay
        endif

        lda #3 or VideoMode | sta $b000
        lda $b001
        ; tax
        and #$20 ; X
        if eq
            tya | ora #Keys_Right | tay
        endif

        lda #5 or VideoMode | sta $b000
        lda $b001
        ; tax
        and #$10 ; L
        if eq
            tya | ora #Keys_Up | tay
        endif

        ; lda #6 or VideoMode | sta $b000
        ; lda $b001
        ; tax
        ; and #$02 ; Return
        ; if eq
        ;     tya | ora #Keys_Button1 | tay
        ; endif

        lda #8 or VideoMode | sta $b000
        lda $b001
        ; tax
        and #$08 ; /
        if eq
            tya | ora #Keys_Right | tay
        endif

        lda #9 or VideoMode | sta $b000
        lda $b001
        tax
        and #$01 ; Space
        if eq
            tya | ora #Keys_Button0 | tay
        endif
        txa
        and #$08 ; >
        if eq
            tya | ora #Keys_Down | tay
        endif
    cli
rts