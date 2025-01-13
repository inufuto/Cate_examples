include 'ZeroPage.inc'

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
    sei
        lda #8 | sta $fe05

        lda $bffe | tax
        and #$01 ; Right
        if ne
            tya | ora #Keys_Right | tay
        endif
        txa
        and #$08 ; Space
        if ne
            tya | ora #Keys_Button0 | tay
        endif

        lda $bffd | tax
        and #$01 ; Left
        if ne
            tya | ora #Keys_Left | tay
        endif
        txa
        and #$02 ; Down
        if ne
            tya | ora #Keys_Down | tay
        endif
        txa
        and #$04 ; Return
        if ne
            tya | ora #Keys_Button0 | tay
        endif

        lda $bffb | tax
        and #$02 ; Up
        if ne
            tya | ora #Keys_Up | tay
        endif
        txa
        and #$04 ; *
        if ne
            tya | ora #Keys_Up | tay
        endif

        lda $bff7
        and #$08 ; ?
        if ne
            tya | ora #Keys_Down | tay
        endif

        lda $bfdf | tax
        and #$02 ; I
        if ne
            tya | ora #Keys_Up | tay
        endif
        txa
        and #$04 ; K
        if ne
            tya | ora #Keys_Right | tay
        endif

        lda $bfbf | tax
        and #$04 ; J
        if ne
            tya | ora #Keys_Left | tay
        endif
        txa
        and #$08 ; M
        if ne
            tya | ora #Keys_Down | tay
        endif

        lda $b7ff
        and #$08 ; X
        if ne
            tya | ora #Keys_Right | tay
        endif
        
        lda $afff
        and #$08 ; Z
        if ne
            tya | ora #Keys_Left | tay
        endif

        lda $9fff
        and #$08 ; Shift
        if ne
            tya | ora #Keys_Button1 | tay
        endif

        lda $f4 | sta $fe05
    cli
rts
