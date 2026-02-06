include "ZeroPage.inc"
include "Port.inc"

Keys_Left equ 01h
Keys_Right equ 02h
Keys_Up equ 04h
Keys_Down equ 08h
Keys_Dir equ 0fh
Keys_Button0 equ 10h
Keys_Button1 equ 20h


cseg
ScanKeys_: public ScanKeys_
    ldy #0
    sei    
        lda #$00
        sta PiaPort+1 ; A Control
        sta PiaPort+3 ; B Control
        sta PiaPort+2 ; B Data Direction
        lda #$0f | sta PiaPort+0 ; A Data Direction

        lda #$04
        sta PiaPort+1 ; A Control
        sta PiaPort+3 ; B Control
        
        lda #not $01
        jsr WriteRead
        tax
        and #$02
        if eq
            tya | ora #Keys_Down | tay
        endif
        txa
        and #$04
        if eq
            tya | ora #Keys_Right | tay
        endif
        txa
        and #$08
        if eq
            tya | ora #Keys_Up | tay
        endif
        txa
        and #$20
        if eq
            tya | ora #Keys_Left | tay
        endif
        txa
        and #$80
        if eq
            tya | ora #Keys_Button1 | tay
        endif

        lda #not $02
        jsr WriteRead
        and #$80
        if eq
            tya | ora #Keys_Button0 | tay
        endif

        lda #not $00 | sta PiaPort+0 ; A Out
    cli
rts

WriteRead:
    sta PiaPort+0 ; A Out
    ; ldx #5
    ; do
    ;     dex
    ; while ne | wend
    nop | nop | nop | nop
    lda PiaPort+2 ; B In
rts