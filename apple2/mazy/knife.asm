include "char.inc"
include "zeropage.inc"

count equ 4

; offsets
xPos equ 0
yPos equ 1
status equ 2
unitSize equ 3

; statuses
status.none equ 0
status.floor equ 1
status.held equ 2
status.flying equ 3

dseg
knives defs unitSize * count | public knives

Kn.Invent defb 0 | public Kn.Invent
blink defb 0

xDiff defb 0
yDiff defb 0
xDis defb 0
yDis defb 0
defs 256

cseg

ext ToMapSize, Tst1x1
ext Put1x1, Print.Kn.Invent
ext man.x, man.y
ext goal.x, goal.y, stage.offset
ext Snd.Get ;, Snd.Hit

directions:
    defb -1,0,1,0,0,-1,0,1

DirectionToGoal:
    lda goal.x
    sec
    sbc knives+xPos,x
    sta xDiff
    if mi
        eor $ff | clc | adc #1
    endif
    sta xDis
    lda goal.y
    sec
    sbc knives+yPos,x
    sta yDiff
    if mi
        eor $ff | clc | adc #1
    endif
    sta yDis
    cmp xDis
    if cc
        lda xDiff
        and #$80
        if eq
            lda #1 shl 2
        else
            lda #0
        endif
    else
        lda yDiff
        and #$80
        if eq
            lda #3 shl 2
        else
            lda #2 shl 2
        endif
    endif
rts


Kn.Init:  public Kn.Init
    ldy stage.offset
    lda (Zp.Word),y | iny
    sta Zp.Counter0

    ldx #0
    lda #count
    sta Zp.Counter1
    do
        lda (Zp.Word),y | iny
        jsr ToMapSize
        sta knives+xPos,x

        lda (Zp.Word),y | iny
        jsr ToMapSize
        sta knives+yPos,x

        jsr DirectionToGoal
        ora #status.floor
        sta knives+status,x

        txa | clc | adc #unitSize | tax

        dec Zp.Counter1
        dec Zp.Counter0
    while ne | wend

    lda Zp.Counter1
    do | while ne
        lda #status.none
        sta knives+status,x    
        txa | clc | adc #unitSize | tax
        dec Zp.Counter1
    wend

    lda #0
    sta Kn.Invent
    
    sty stage.offset
rts


Kn.Start: public Kn.Start
; in
;   Zp.x
;   Zp.y
;   Zp.Byte: direction
    ldx #0
    lda #count
    sta Zp.Counter0
    do
        lda knives+status,x
        and #3
        cmp #status.held
        if eq
            lda Zp.x
            sta knives+xPos,x
            lda Zp.y
            sta knives+yPos,x
            lda Zp.Byte
            asl a
            asl a
            ora #status.flying
            sta knives+status,x
            dec Kn.Invent
            jsr Snd.Get
            jsr Print.Kn.Invent
            rts
        endif
        txa | clc | adc #unitSize | tax
        dec Zp.Counter0
    while ne | wend
rts


Kn.Move: public Kn.Move
    ldx #0
    lda #count
    do
        pha
            lda knives+status,x
            and #3    
            beq Move.Next   ;   none
            cmp #status.floor
            if eq
                lda knives+xPos,x
                sec | sbc man.x
                if ne
                    sec | sbc #1
                    bne Move.Next
                endif
                
                lda knives+yPos,x
                sec | sbc man.y
                if ne
                    sec | sbc #1
                    bne Move.Next
                endif
                lda knives+status,x
                and #$fc
                ora #status.held
                sta knives+status,x
                inc Kn.Invent
                jsr Snd.Get
                jsr Print.Kn.Invent
                jmp Move.Next
            endif
            cmp #status.held
            beq Move.Next
            cmp #status.flying
            if eq
                lda knives+status,x
                and #$0c
                lsr a
                tay
                lda directions+0,y
                sta Zp.x
                lda directions+1,y
                sta Zp.y

                lda knives+xPos,x
                clc | adc Zp.x
                sta Zp.x

                lda knives+yPos,x
                clc | adc Zp.y
                sta Zp.y
                jsr Tst1x1
                if eq
                    lda Zp.x
                    sta knives+xPos,x
                    lda Zp.y
                    sta knives+yPos,x
                    jsr TestHit
                    jmp Move.Next
                endif
                jsr DirectionToGoal
                ora #status.floor
                sta knives+status,x
            endif
            Move.Next:
            txa | clc | adc #unitSize | tax
        pla
        sec | sbc #1
    while ne | wend
rts


extrn  Mon.TestHit.Kn, Snd.Hit, Snd.Address
TestHit:
    stx Zp.Byte2
    jsr Mon.TestHit.Kn
    ora #0
    if ne
        lda #low Snd.Hit | sta Snd.Address
        lda #high Snd.Hit | sta Snd.Address+1
        ldx Zp.Byte2
        jsr DirectionToGoal
        ora #status.floor
        sta knives+status,x
    endif   
rts


Kn.Draw: public Kn.Draw
    inc blink
    ldx #0
    lda #count
    sta Zp.Counter0
    do
        lda knives+status,x
        and #3    
        beq Draw.Next   ;   none
        cmp #status.floor
        if eq
            lda blink
            and #1
            beq kd1
            jmp Draw.Next
        endif
        cmp #status.held
        beq Draw.Next
        kd1:
            lda knives+xPos,x
            sta Zp.x
            lda knives+yPos,x
            sta Zp.y
            lda knives+status,x
            lsr a
            lsr a
            and #3
            clc
            adc #Char.Kn.Left
            sta Zp.Byte
            jsr Put1x1
        Draw.Next:
        
        txa | clc | adc #unitSize | tax

        dec Zp.Counter0
    while ne | wend
rts
