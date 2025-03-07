include "char.inc"
include "zeropage.inc"

count equ 8

;offsets
xPos equ 0
yPos equ 1
type equ 2
status equ 3
clock equ 4
unitSize equ 5

status.none equ 0
status.live equ 1
status.die equ 2
type.horizontal equ 0
type.vertical equ 1
type.chase equ 2

dseg
monsters defs unitSize * count
public monsters
current defw 0
current.Hi equ current
current.Lo equ current+1
hits defb 0

ext ToMapSize, Tst2x2
ext stage.offset
ext man.x, man.y, man.status.die
ext Put2x2

cseg

Mon.Init: public Mon.Init
    ldy stage.offset
    lda (Zp.Word),y | iny
    sta Zp.Counter0

    ldx #0
    lda #count
    sta ZP.Counter1
    do
        lda (Zp.Word),y | iny
        jsr ToMapSize
        sta monsters+xPos,x
        
        lda (Zp.Word),y | iny
        pha
            and #$3f
            jsr ToMapSize
            sta monsters+yPos,x
        pla
        lsr a
        lsr a
        lsr a
        lsr a
        lsr a
        lsr a
        sta monsters+type,x

        lda #status.live
        sta monsters+status,x

        txa | clc | adc #unitSize | tax
        dec Zp.Counter1
        dec Zp.Counter0
    while ne | wend
    sty stage.offset

    lda Zp.Counter1
    do | while ne
        lda #status.none
        sta monsters+status,x

        txa | clc | adc #unitSize | tax
        dec Zp.Counter1
    wend
rts


Mon.Move:   public Mon.Move
    ldx #0
    lda #count
    do
        pha
            inc monsters+clock,x
            lda monsters+status,x
            beq Move.Next
            cmp #status.live
            if eq
                jsr TestHit.Man
                lda monsters+type,x
                if eq
                    ; type.horizontal
                    lda monsters+xPos,x
                    cmp man.x
                    beq Move.Next
                    if cc
                        adc #1
                    else
                        sbc #1
                    endif
                    sta Zp.x
                    lda monsters+yPos,x
                    sta Zp.y
                    jmp TryToMove
                endif
                cmp #type.vertical
                if eq
                    lda monsters+yPos,x 
                    cmp man.y
                    beq Move.Next
                    if cc
                        adc #1
                    else
                        sbc #1
                    endif
                    sta Zp.y
                    lda monsters+xPos,x
                    sta Zp.x
                    TryToMove:
                    jsr TestMove
                    bne Move.Next
                    CanMove:
                    lda Zp.x
                    sta monsters+xPos,x
                    lda Zp.y
                    sta monsters+yPos,x
                    jsr TestHit.Man
                    jmp Move.Next
                endif
                cmp #type.chase
                if eq
                    lda monsters+clock,x
                    and #1
                    beq Move.Next

                    lda monsters+xPos,x
                    sta Zp.x
                    lda monsters+yPos,x
                    sta Zp.y
                    lda man.x
                    cmp Zp.x
                    if ne
                        if cc
                            dec Zp.x
                        else
                            inc Zp.x
                        endif
                        jsr TestMove
                        beq CanMove
                        lda monsters+xPos,x
                        sta Zp.x
                    endif
                    lda man.y
                    cmp Zp.y
                    beq Move.Next
                    if cc
                        dec Zp.y
                    else
                        inc Zp.y
                    endif
                    jsr TestMove
                    beq CanMove
                    jmp Move.Next
                endif
            endif
            cmp #status.die
            if eq
                lda monsters+clock,x
                cmp #4
                if eq
                    lda #status.none
                    sta monsters+status,x
                endif
            endif
            Move.Next:
            txa | clc | adc #unitSize | tax
        pla
        sec | sbc #1
    while ne | wend
rts


TestMove: public TestMove
    jsr Tst2x2
    stx Zp.Byte
    if eq
        ldy #0
        lda #count
        sta Zp.Counter0
        do
            cpy Zp.Byte
            if ne
                lda monsters+status,y
                cmp #status.live
                if eq
                    lda Zp.x
                    sec | sbc monsters+xPos,y
                    clc | adc #1
                    cmp #3
                    if cc
                        lda Zp.y
                        sec | sbc monsters+yPos,y
                        clc | adc #1
                        cmp #3
                        if cc
                            lda #1;  z := 0
                            rts
                        endif
                    endif
                endif
            endif
            tya | clc | adc #unitSize | tay
            dec Zp.Counter0
        while ne | wend
        lda #0 ; z := 1
    endif
rts


TestHit.Man:
    lda man.x
    sec | sbc monsters+xPos,x
    clc | adc #1
    cmp #3
    if cc
        lda man.y
        sec | sbc monsters+yPos,x
        clc | adc #1
        cmp #3
        if cc
            inc Man.Status.Die
        endif
    endif
rts


Mon.Draw:   public Mon.Draw
    ldx #0
    lda #count
    do
        pha
            lda monsters+status,x
            beq DrawNext
            cmp #status.live
            if eq
                lda monsters+type,x
                cmp #type.chase
                if eq
                    lda #Char.Chaser
                    jmp put
                endif
                lda #Char.Disturber
                jmp put
            endif
            cmp #status.die
            if eq
                lda #Char.Bang
                put:
                sta Zp.Byte
                lda monsters+xPos,x
                sta ZP.x
                lda monsters+yPos,x
                sta Zp.y
                jsr Put2x2
            endif
            DrawNext:
            txa | clc | adc #unitSize | tax
        pla
        sec | sbc #1
    while ne | wend
rts


ext AddScore
Mon.TestHit.Kn: public Mon.TestHit.Kn
    ldx #0
    stx hits
    lda #count
    do  
        pha
            lda monsters+status,x
            cmp #status.live
            if eq
                lda Zp.x
                sec | sbc monsters+xPos,x
                beq hit_x
                cmp #1
                if eq
                    hit_x:
                    lda Zp.y
                    sec | sbc monsters+yPos,x
                    beq hit_y
                    cmp #1
                    if eq
                        hit_y:
                        lda #status.die
                        sta monsters+status,x
                        lda #0
                        sta monsters+clock,x
                        inc hits
                        lda monsters+type,x
                        cmp #type.chase
                        if eq
                            lda #30 ; 300 Pts.
                        else
                            lda #10 ; 
                        endif
                        jsr AddScore
                    endif
                endif
            endif
            txa | clc | adc #unitSize | tax
        pla
        sec | sbc #1
    while ne | wend
    lda hits
rts