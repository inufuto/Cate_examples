include "KeyBits.inc"
include "mazy.inc"
include "char.inc"
include "zeropage.inc"
include "apple2.inc"

dseg
man.x defb 0 | public man.x
man.y defb 0 | public man.y
man.status.die defb 0 | public man.status.die
prevDir: defw 0
seq.ptr defw 0
seq.index defb 0
default defb 0
chr defb 0
lastButton defb 0

cseg

; direction structure
Dir.key equ 0
Dir.x equ Dir.key+1
Dir.y equ Dir.x+1
Dir.seq equ Dir.y+1
Dir.stop equ Dir.seq+1
Dir.knife.dir equ Dir.stop+1
Dir.knife.x equ Dir.knife.dir+1
Dir.knife.y equ Dir.knife.x+1
Dir.size equ Dir.knife.y+1
Dir.count equ 4

Directions:                 public Directions
    ; left direction
    defb Keys.Left
    defb -1,0
    defb Char.Man.Left.0
    defb Char.Man.Stop.Left
    defb 0
    defb 0,0
    ; right direction
    defb Keys.Right
    defb 1,0
    defb Char.Man.Right.0
    defb Char.Man.Stop.Right
    defb 1
    defb 1,0
    ; up direction
    defb Keys.Up
    defb 0,-1
    defb Char.Man.Up.0
    defb Char.Man.Stop.Up
    defb 2
    defb 0,0
    ; down direction
    defb Keys.Down
    defb 0,1
    defb Char.Man.Down.0
    defb Char.Man.Stop.Down
    defb 3
    defb 0,1
Die.Seq:
    defb Char.Man.Stop.Left, Char.Man.Stop.Down, Char.Man.Die.2, Char.Man.Die.3
RunSeq:
    defb 4,0,4,8

ext CG.Man
ext CopyMem
ext ScanKeys
ext stage.offset, ToMapSize
ext map.width, map.height, base.x, base.y, Tst2x2, Put2x2, Stage.Clear
ext Kn.Invent, Kn.Start
ext goal.x,goal.y

Man.Init:    public Man.Init
    ldy stage.offset
    lda (Zp.Word),y
    iny
    jsr ToMapSize
    sta man.x
    lda (Zp.Word),y
    iny
    jsr ToMapSize
    sta man.y
    sty stage.offset
    lda #low(directions + Dir.size) ; right direction
    sta prevDir
    lda #high(directions + Dir.size)
    sta prevDir+1
    lda #Char.Man.Stop.Right
    sta chr
    lda #0
    sta seq.index
    sta man.status.die
UpdateBasePosition:
    lda map.width
    sec
    sbc #window.width
    sta Zp.Counter0
    lda map.height
    sec
    sbc #window.height
    sta Zp.Counter1
    
    lda man.x
    sec
    sbc #window.width/2
    if cc
        lda #0
    endif
    cmp Zp.Counter0
    if cs
        lda Zp.Counter0
    endif
    sta base.x

    lda man.y
    sec
    sbc #window.height/2
    if cc
        lda #0
    endif
    cmp Zp.Counter1
    if cs
        lda Zp.Counter1
    endif
    sta base.y
rts

    dseg
    key defb 0
    cseg
Man.Move:    public Man.Move
    lda man.status.die
    if ne
        rts
    endif

    jsr ScanKeys
    sta key

    lda #low directions | sta Zp.Word.low
    lda #high directions | sta Zp.Word.high

    lda #Dir.count | sta Zp.Counter0
    do
        lda key
        ldy #Dir.key
        and (Zp.Word),y
        if ne
            ldy #Dir.x | lda man.x | clc | adc (Zp.Word),y | sta Zp.X
            ldy #Dir.y | lda man.y | clc | adc (Zp.Word),y | sta Zp.Y
            jsr Tst2x2
            if eq 
                lda Zp.Word.low | sta prevDir
                lda Zp.Word.high | sta prevDir+1
                jmp CanMove
            endif
        endif
        lda Zp.Word.low | clc | adc #Dir.size | sta Zp.Word.low
        lda Zp.Word.high | adc #0 | sta Zp.Word.high

        dec Zp.Counter0
    while ne | wend

    lda key
    and #Keys.Dir
    if ne
        lda prevDir | sta Zp.Word.low
        lda prevDir+1 | sta Zp.Word.high
        ldy #Dir.x | lda man.x | clc | adc (Zp.Word),y | sta Zp.X
        ldy #Dir.y | lda man.y | clc | adc (Zp.Word),y | sta Zp.Y
        jsr Tst2x2
        if eq
            CanMove:
            lda Zp.x | sta man.x
            lda Zp.y | sta man.y

            lda seq.index | clc | adc #1 | and #3 | sta seq.index
            tax
            lda RunSeq,x
            ldy #Dir.seq | clc | adc (Zp.Word),y | sta chr
            jsr UpdateBasePosition

            lda goal.x
            cmp man.x
            if eq
                lda goal.y
                cmp man.y
                if eq 
                    inc Stage.Clear
                endif
            endif
            jmp TestButton
        endif
    endif

    lda prevDir | sta Zp.Word.low
    lda prevDir+1 | sta Zp.Word.high
    ldy #Dir.Stop | lda (Zp.Word),y | sta chr
    lda #-1 | sta seq.index
    
    TestButton:
    lda key
    and #Keys.Button.0
    if eq
        lda #0
        sta lastButton
        rts
    endif
    lda lastButton
    if ne
        rts
    endif
    inc lastButton

    lda Kn.Invent
    if eq
        rts
    endif
    lda man.x
    ldy #Dir.knife.x | clc | adc (Zp.Word),y
    sta Zp.x

    lda man.y
    ldy #Dir.knife.y | clc | adc (Zp.Word),y
    sta Zp.y

    ldy #Dir.knife.dir | lda (Zp.Word),y | sta Zp.Byte
jmp Kn.Start


Man.Draw: public Man.Draw
    lda man.x
    sta Zp.x
    lda man.y
    sta Zp.y
    lda chr
    sta Zp.Byte
    jsr Put2x2
rts


extrn VVramToVram, Snd.Die
Man.Die:    public Man.Die
    ldx #0
    lda #10
    do
        pha
            txa | pha
                lda Die.Seq,x | inx | sta Zp.Byte
                lda man.x | sta Zp.X
                lda man.y | sta Zp.Y
                jsr Put2x2
                jsr VVramToVram
                jsr Snd.Die
            pla | tax
            inx
            cpx #4
            if eq
                ldx #0
            endif
        pla
        sec | sbc #1
    while ne | wend
rts
