include 'ZeroPage.inc'

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
ReadPort:
    sei
        do
            stx KeyPort
            stx JoyPort
            lda JoyPort
            stx KeyPort
            stx KeyPort
            cmp JoyPort
        while ne | wend
    cli
rts


ScanKeys_: public ScanKeys_
    ldy #0
    
    lda #$ff | sta $fd30

    ldx #not $02
    jsr ReadPort
    tax
    and #$80    ;shift
    if eq
        tya
        ora #Keys_Button1
        tay
    endif

    ldx #not $04
    jsr ReadPort
    tax
    and #$01    ;5
    if eq
        tya
        ora #Keys_Up
        tay
    endif
    txa
    and #$02    ;R
    if eq
        tya
        ora #Keys_Down
        tay
    endif
    txa
    and #$04    ;D
    if eq
        tya
        ora #Keys_Left
        tay
    endif
    txa
    and #$08    ;6
    if eq
        tya
        ora #Keys_Right
        tay
    endif
    txa
    and #$40    ;T
    if eq
        tya
        ora #Keys_Button0
        tay
    endif

    ldx #not $10
    jsr ReadPort
    tax
    and #$02    ;I
    if eq
        tya
        ora #Keys_Up
        tay
    endif
    txa
    and #$04    ;J
    if eq
        tya
        ora #Keys_Left
        tay
    endif
    txa
    and #$10    ;M
    if eq
        tya
        ora #Keys_Down
        tay
    endif
    txa
    and #$20    ;K
    if eq
        tya
        ora #Keys_Right
        tay
    endif

    ldx #not $20
    jsr ReadPort
    tax
    and #$01    ;down
    if eq
        tya
        ora #Keys_Down
        tay
    endif
    txa
    and #$08    ;up
    if eq
        tya
        ora #Keys_Up
        tay
    endif

    ldx #not $40
    jsr ReadPort
    tax
    and #$01    ;left
    if eq
        tya
        ora #Keys_Left
        tay
    endif
    txa
    and #$08    ;right
    if eq
        tya
        ora #Keys_Right
        tay
    endif

    ldx #not $80
    jsr ReadPort
    ; stx $fd30
    ; lda KeyPort
    tax
    and #$10    ;space
    if eq
        tya
        ora #Keys_Button0
        tay
    endif
rts
