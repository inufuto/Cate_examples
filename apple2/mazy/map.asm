include 'zeropage.inc'
include 'map.inc'
include "char.inc"

ext	Stages, Stage.Count, TimeRate
ext Man.Init
ext Kn.Init
ext Mon.Init
ext Put2x2

dseg
stage		defb	0
public stage
map.width	defb	0
map.height	defb	0
public map.width,map.height
stage.width		defb	0
stage.height	defb	0
goal.x defb 0
goal.y defb 0
public goal.x,goal.y
Stage.Time defw 0 | public Stage.Time
blink defb 0
Stage.Clear defb 0 | public Stage.Clear
stage.offset defb 0 | public stage.offset
stage.byte defb 0
stage.bitCount defb 0
map.mask defb 0
map.bits defb 0
map	defs map.size
public map

cseg

ToMapSize: public ToMapSize
    sta Zp.Byte
    asl a
    clc
    adc Zp.Byte
    adc #1
rts

RotBit:
	asl map.mask
	if eq
        lda map.bits
        ldx #0
		sta (Zp.TmpX1,x)
        lda Zp.TmpX1.low
        clc
        adc #1
        sta Zp.TmpX1.low
        lda Zp.TmpX1.high
        adc #0
        sta Zp.TmpX1.high
        inc map.mask
        lda #0
        sta map.bits
	endif
rts

RotBit2:
	asl map.mask
	if eq
        lda map.bits
        ldx #0
		sta (Zp.TmpX1,x)
        ldy #map.step
		sta (Zp.TmpX1),y
        lda Zp.TmpX1.low
        clc
        adc #1
        sta Zp.TmpX1.low
        lda Zp.TmpX1.high
        adc #0
        sta Zp.TmpX1.high
        inc map.mask
        lda #0
        sta map.bits
	endif
rts


InitMap: public	InitMap
    lda #low map
    sta Zp.TmpX0.low
    lda #high map
    sta Zp.TmpX0.high
    lda #map.max.height
    sta Zp.Counter0
    do
        lda #map.step
        sta Zp.Counter1
        lda #0
        ldx #0
        do
            sta [zp.TmpX0,x]
            inc Zp.TmpX0.low
            if eq
                inc zp.TmpX0.high
            endif
            dec Zp.Counter1
        while ne | wend
        dec ZP.Counter0
    while ne | wend

    lda #10
    sta TimeRate
    lda #low Stage.Count
    sta Zp.Byte
    lda stage
    do
        sec
        sbc #low Stage.Count
    while cs
        dec TimeRate
    wend
    lda TimeRate
    cmp #2
    if cc
        lda #2
        sta TimeRate
    endif

    lda #low Stages
    sta Zp.TmpX0.low
    lda #high Stages
    sta Zp.TmpX0.high
    lda stage
    and #15
    asl a
    tay
    lda (Zp.TmpX0),y
    sta Zp.Word.low
    iny
    lda (Zp.TmpX0),y
    sta Zp.Word.high
    ldy #0

    lda (Zp.Word),y
    iny
    sta stage.width
    jsr ToMapSize
    sta map.width
    lda (Zp.Word),y
    iny
    sta stage.height
    jsr ToMapSize
    sta map.height

    sty stage.offset
    lda #low map
    sta Zp.TmpX0.low
    sta Zp.TmpX1.low
    lda #high map
    sta Zp.TmpX0.high
    sta Zp.TmpX1.high
    lda map.width
    sta Zp.Byte
    lda #1
    sta map.mask
    lda #0
    sta map.bits
    do
        lda map.bits
        ora map.mask
        sta map.bits
        jsr RotBit
        dec Zp.Byte
    while ne | wend
    lda map.bits
    ldx #0
    sta (Zp.TmpX1,x)
    
    lda Zp.TmpX0.low
    clc
    adc #map.step
    sta Zp.TmpX0.low
    sta Zp.TmpX1.low
    lda Zp.TmpX0.high
    adc #0
    sta Zp.TmpX0.high
    sta Zp.TmpX1.high

    ldy stage.offset
    lda (Zp.Word),y
    iny
    sty stage.offset
    sta stage.byte
    lda #8
    sta stage.bitCount
    lda stage.height
    sta Zp.Counter0
    do
        lda #1
        sta map.mask
        sta map.bits
        jsr RotBit2
        lda stage.width
        sta Zp.Counter1
        do
            jsr RotBit2
            jsr RotBit2
            lda stage.byte
            and #1
            if ne
                lda map.bits
                ora map.mask
                sta map.bits
            endif
            jsr RotBit2
            lsr stage.byte
            dec stage.bitCount
            if eq
                ldy stage.offset
                lda (Zp.Word),y
                iny
                sty stage.offset
                sta stage.byte
                lda #8
                sta stage.bitCount
            endif
            dec Zp.Counter1
        while ne | wend
        lda map.bits
        ldx #0
        sta (Zp.TmpX1,x)
        ldy #map.step
        sta (Zp.TmpX1),y
        
        lda Zp.TmpX0.low
        clc
        adc #map.step*2
        sta Zp.TmpX0.low
        sta Zp.TmpX1.low
        lda Zp.TmpX0.high
        adc #0
        sta Zp.TmpX0.high
        sta Zp.TmpX1.high

        lda #1
        sta map.mask
        sta map.bits
        jsr RotBit
        lda stage.width
        sta Zp.Counter1
        do
            lda stage.byte
            and #1
            if ne
                lda map.bits
                ora map.mask
                sta map.bits
                jsr RotBit
                lda map.bits
                ora map.mask
                sta map.bits
                jsr RotBit
            else
                jsr RotBit
                jsr RotBit
            endif
            lda map.bits
            ora map.mask
            sta map.bits
            jsr RotBit
            lsr stage.byte
            dec stage.bitCount
            if eq
                ldy stage.offset
                lda (Zp.Word),y
                iny
                sty stage.offset
                sta stage.byte
                lda #8
                sta stage.bitCount
            endif
            dec Zp.Counter1
        while ne | wend
        lda map.bits
        ldx #0
        sta (Zp.TmpX1,x)
        
        lda Zp.TmpX0.low
        clc
        adc #map.step
        sta Zp.TmpX0.low
        sta Zp.TmpX1.low
        lda Zp.TmpX0.high
        adc #0
        sta Zp.TmpX0.high
        sta Zp.TmpX1.high

        dec Zp.Counter0
    while ne | wend

    lda stage.bitCount
    cmp #8
    if eq
        ldy stage.offset
        dey
        sty stage.offset
    endif

    jsr Man.Init
    
    ldy stage.offset
    lda (Zp.Word),y | iny | jsr ToMapSize | sta goal.x
    lda (Zp.Word),y | iny | jsr ToMapSize | sta goal.y
    sty stage.offset
    jsr Kn.Init
    jsr Mon.Init
    ; time
    ldy stage.offset
    lda (Zp.Word),y | iny | sta Stage.Time
    lda (Zp.Word),y | iny | sta Stage.Time+1
rts


MapAddress:
    lda Zp.y
    sta Zp.TmpX0.low
    lda #0
    sta Zp.TmpX0.high
    asl Zp.TmpX0.low | rol Zp.TmpX0.high  ; *2
    asl Zp.TmpX0.low | rol Zp.TmpX0.high  ; *4
    asl Zp.TmpX0.low | rol Zp.TmpX0.high  ; *8 : map.step
    lda Zp.TmpX0.low | clc | adc #low map | sta Zp.TmpX0.low
    lda Zp.TmpX0.high | adc #high map | sta Zp.TmpX0.high

    lda Zp.x
    lsr a   ; /2
    lsr a   ; /4
    lsr a   ; /8
    clc | adc Zp.TmpX0.low | sta Zp.TmpX0.low
    lda Zp.TmpX0.high | adc #0 | sta Zp.TmpX0.high
rts


Tst2x2:  public Tst2x2
    jsr MapAddress

    lda #3 | sta Zp.TmpX1.low
    lda #0 | sta Zp.TmpX1.high

    lda Zp.X
    and #7
    do | while ne
        asl Zp.TmpX1.low | rol Zp.TmpX1.high
        sec | sbc #1
    wend

    lda #2 | sta Zp.Byte
    do
        ldy #0
        lda (Zp.TmpX0),y
        and Zp.TmpX1.low
        bne Tst2x2_Exit
        iny
        lda (Zp.TmpX0),y
        and Zp.TmpX1.high
        bne Tst2x2_Exit

        lda Zp.TmpX0.low | clc | adc #map.step | sta Zp.TmpX0.low
        lda Zp.TmpX0.high | adc #0 | sta Zp.TmpX0.high

        dec Zp.Byte
    while ne | wend
Tst2x2_Exit:
rts


Tst1x1:  public Tst1x1
    jsr MapAddress

    lda #1 | sta Zp.Byte

    lda Zp.X
    and #7
    do | while ne
        asl Zp.Byte
        sec | sbc #1
    wend

    ldy #0 | lda (Zp.TmpX0),y
    and Zp.Byte
rts


Goal.Draw: public Goal.Draw
    inc blink
    lda blink
    and #1
    if ne
        lda goal.x | sta Zp.x
        lda goal.y | sta Zp.y
        lda #Char.Goal | sta Zp.Byte
        jsr Put2x2
    endif
rts