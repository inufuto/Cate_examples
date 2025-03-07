include 'zeropage.inc'
include 'apple2.inc'
include "mazy.inc"
include "char.inc"
include "map.inc"

    cseg
Chars:  public Chars
    ; chars
	defb	$00, $e0, $f0, $60, $60, $f0, $e0, $f0
	defb	$00, $01, $03, $03, $03, $03, $01, $03
	defb	$f8, $ec, $ec, $00, $30, $30, $30, $30
	defb	$07, $0d, $0d, $00, $03, $03, $03, $03
	defb	$00, $e0, $f0, $60, $60, $f0, $e0, $c0
	defb	$00, $01, $03, $03, $03, $03, $01, $01
	defb	$e0, $ec, $ec, $e0, $70, $38, $1c, $18
	defb	$07, $0f, $0d, $00, $07, $07, $00, $00
	defb	$00, $e0, $f0, $60, $60, $f0, $e0, $c0
	defb	$00, $01, $03, $03, $03, $03, $01, $01
	defb	$c0, $c0, $e0, $60, $00, $c0, $c0, $c0
	defb	$00, $00, $00, $00, $00, $00, $00, $00
	defb	$00, $e0, $f0, $60, $60, $f0, $e0, $c0
	defb	$00, $01, $03, $03, $03, $03, $01, $01
	defb	$e0, $f8, $b8, $c0, $80, $70, $38, $30
	defb	$01, $0d, $0d, $00, $0f, $0e, $00, $00
	defb	$00, $80, $c0, $c0, $c0, $c0, $80, $c0
	defb	$00, $07, $0f, $06, $06, $0f, $07, $0f
	defb	$e0, $b0, $b0, $00, $c0, $c0, $c0, $c0
	defb	$1f, $37, $37, $00, $0c, $0c, $0c, $0c
	defb	$00, $80, $c0, $c0, $c0, $c0, $80, $80
	defb	$00, $07, $0f, $06, $06, $0f, $07, $03
	defb	$e0, $f0, $b0, $00, $e0, $e0, $00, $00
	defb	$07, $37, $37, $07, $0e, $1c, $38, $18
	defb	$00, $80, $c0, $c0, $c0, $c0, $80, $80
	defb	$00, $07, $0f, $06, $06, $0f, $07, $03
	defb	$00, $00, $00, $00, $00, $00, $00, $00
	defb	$03, $03, $07, $06, $00, $03, $03, $03
	defb	$00, $80, $c0, $c0, $c0, $c0, $80, $80
	defb	$00, $07, $0f, $06, $06, $0f, $07, $03
	defb	$80, $b0, $b0, $00, $f0, $70, $00, $00
	defb	$07, $1f, $1d, $03, $01, $0e, $1c, $0c
	defb	$00, $00, $00, $00, $bc, $e6, $fe, $e6
	defb	$00, $00, $06, $07, $f1, $ff, $07, $07
	defb	$fe, $bc, $00, $00, $00, $00, $00, $00
	defb	$ff, $f1, $07, $06, $00, $00, $00, $00
	defb	$00, $00, $00, $00, $3c, $66, $fe, $e6
	defb	$00, $00, $06, $e6, $70, $3f, $1f, $0f
	defb	$fe, $3c, $00, $00, $00, $00, $00, $00
	defb	$37, $33, $37, $06, $00, $00, $00, $00
	defb	$00, $00, $00, $00, $3c, $66, $fe, $e6
	defb	$00, $00, $00, $00, $00, $0c, $ef, $e7
	defb	$fe, $3c, $00, $00, $00, $00, $00, $00
	defb	$00, $70, $00, $00, $00, $00, $00, $00
	defb	$00, $00, $00, $00, $3c, $66, $fe, $e6
	defb	$00, $00, $00, $c6, $e6, $77, $33, $0f
	defb	$fe, $3c, $00, $00, $00, $00, $00, $00
	defb	$1f, $30, $36, $36, $00, $00, $00, $00
	defb	$00, $00, $00, $00, $00, $00, $bc, $fe
	defb	$00, $00, $00, $00, $06, $07, $f1, $ff
	defb	$e6, $fe, $e6, $bc, $00, $00, $00, $00
	defb	$07, $07, $ff, $f1, $07, $06, $00, $00
	defb	$00, $00, $00, $00, $00, $00, $3c, $fe
	defb	$00, $00, $00, $00, $06, $37, $33, $37
	defb	$e6, $fe, $66, $3c, $00, $00, $00, $00
	defb	$0f, $1f, $3f, $70, $e6, $06, $00, $00
	defb	$00, $00, $00, $00, $00, $00, $3c, $fe
	defb	$00, $00, $00, $00, $00, $00, $70, $00
	defb	$e6, $fe, $66, $3c, $00, $00, $00, $00
	defb	$e7, $ef, $0c, $00, $00, $00, $00, $00
	defb	$00, $00, $00, $00, $00, $00, $3c, $fe
	defb	$00, $00, $00, $00, $36, $36, $30, $1f
	defb	$e6, $fe, $66, $3c, $00, $00, $00, $00
	defb	$0f, $33, $77, $e6, $c6, $00, $00, $00
	defb	$00, $18, $3c, $66, $66, $66, $3c, $38
	defb	$00, $18, $3c, $66, $66, $66, $3c, $1c
	defb	$a0, $a8, $a8, $8a, $22, $aa, $aa, $82
	defb	$02, $0a, $0a, $28, $22, $2a, $2a, $20
	defb	$00, $a0, $a8, $a8, $aa, $82, $82, $8a
	defb	$00, $02, $0a, $0a, $2a, $20, $20, $28
	defb	$aa, $8a, $08, $08, $28, $aa, $aa, $82
	defb	$2a, $28, $08, $08, $0a, $2a, $2a, $20
	defb	$00, $fc, $fc, $fc, $fc, $fc, $fc, $fc
	defb	$00, $3f, $3f, $3f, $3f, $3f, $33, $33
	defb	$fc, $fc, $fc, $fc, $fc, $fc, $fc, $00
	defb	$33, $3f, $3f, $3f, $3f, $3f, $3f, $00
	defb	$00, $80, $a0, $84, $a8, $d2, $e0, $f0
	defb	$00, $00, $02, $10, $0a, $05, $2b, $07
	defb	$ff, $f0, $ea, $d0, $a8, $84, $a0, $80
	defb	$7f, $07, $2b, $05, $0a, $10, $02, $00
	defb	$c0, $c0, $c0, $c0, $00, $b0, $b0, $e0
	defb	$0c, $0c, $0c, $0c, $00, $37, $37, $1f
	defb	$c0, $80, $c0, $c0, $c0, $c0, $80, $00
	defb	$0f, $07, $0f, $06, $06, $0f, $07, $00
	defb	$00, $00, $60, $e0, $8f, $ff, $e0, $e0
	defb	$00, $00, $00, $00, $3d, $67, $7f, $67
	defb	$ff, $8f, $e0, $60, $00, $00, $00, $00
	defb	$7f, $3d, $00, $00, $00, $00, $00, $00
    ; knife
	defb	$00, $00, $30, $7e, $7c, $30, $00, $00
	defb	$00, $00, $0c, $7f, $3f, $0c, $00, $00
	defb	$00, $18, $18, $18, $18, $3c, $18, $18
	defb	$18, $18, $3c, $18, $18, $18, $18, $00
    ; wall
	defb	$55, $55, $55, $55, $55, $55, $55, $55
    ;defb	$55, $55, $aa, $aa, $ff, $ff, $55, $55
    ; space
	defb	$00, $00, $00, $00, $00, $00, $00, $00
Chars_end: public Chars_end
    ; title 
	defb	$fc, $fc, $3c, $3c, $3c, $3c, $3c, $3c
	defb	$3f, $3f, $f3, $f3, $f3, $f3, $f3, $f3
	defb	$3c, $3c, $3c, $3c, $3c, $3c, $00, $00
	defb	$f3, $f3, $f3, $f3, $f3, $f3, $00, $00
	defb	$40, $40, $50, $50, $14, $14, $14, $14
	defb	$05, $05, $14, $14, $50, $50, $50, $50
	defb	$54, $54, $14, $14, $14, $14, $00, $00
	defb	$55, $55, $50, $50, $50, $50, $00, $00
	defb	$a8, $a8, $00, $00, $00, $00, $80, $80
	defb	$aa, $aa, $28, $28, $0a, $0a, $02, $02
	defb	$a0, $a0, $28, $28, $a8, $a8, $00, $00
	defb	$00, $00, $00, $00, $aa, $aa, $00, $00
	defb	$3c, $3c, $3c, $3c, $3c, $3c, $f0, $f0
	defb	$3c, $3c, $3c, $3c, $3c, $3c, $0f, $0f
	defb	$c0, $c0, $c0, $c0, $c0, $c0, $00, $00
	defb	$03, $03, $03, $03, $03, $03, $00, $00
    ; ascii
	defb	$00, $00, $00, $00, $00, $00, $00, $00
	defb	$18, $18, $18, $18, $18, $00, $18, $00
	defb	$6c, $6c, $6c, $00, $00, $00, $00, $00
	defb	$60, $ec, $7c, $ee, $7c, $6e, $0c, $00
	defb	$18, $fc, $1e, $7c, $d8, $7e, $18, $00
	defb	$00, $c6, $66, $30, $18, $cc, $c6, $00
	defb	$1c, $36, $36, $1c, $c6, $66, $dc, $00
	defb	$30, $18, $0c, $00, $00, $00, $00, $00
	defb	$30, $18, $0c, $0c, $0c, $18, $30, $00
	defb	$0c, $18, $30, $30, $30, $18, $0c, $00
	defb	$00, $66, $18, $7e, $18, $66, $00, $00
	defb	$00, $18, $18, $7e, $18, $18, $00, $00
	defb	$00, $00, $00, $00, $18, $18, $0c, $00
	defb	$00, $00, $00, $7e, $00, $00, $00, $00
	defb	$00, $00, $00, $00, $00, $18, $18, $00
	defb	$00, $c0, $60, $30, $18, $0c, $06, $00
	defb	$38, $6c, $c6, $c6, $c6, $6c, $38, $00
	defb	$18, $1e, $18, $18, $18, $18, $7e, $00
	defb	$7c, $c6, $e0, $78, $3c, $0e, $fe, $00
	defb	$7c, $c6, $c0, $78, $c0, $c6, $7c, $00
	defb	$60, $70, $78, $6c, $66, $fe, $60, $00
	defb	$fe, $06, $7e, $c0, $c0, $c6, $7c, $00
	defb	$78, $0c, $06, $7e, $c6, $c6, $7c, $00
	defb	$fe, $c6, $60, $30, $18, $18, $18, $00
	defb	$7c, $c6, $c6, $7c, $c6, $c6, $7c, $00
	defb	$7c, $c6, $c6, $fc, $c0, $c6, $7c, $00
	defb	$00, $00, $18, $00, $00, $18, $00, $00
	defb	$00, $00, $18, $00, $00, $18, $0c, $00
	defb	$60, $30, $18, $0c, $18, $30, $60, $00
	defb	$00, $00, $7e, $00, $7e, $00, $00, $00
	defb	$0c, $18, $30, $60, $30, $18, $0c, $00
	defb	$7c, $c6, $c0, $70, $18, $00, $18, $00
	defb	$78, $cc, $c6, $f6, $66, $0c, $78, $00
	defb	$38, $6c, $c6, $c6, $fe, $c6, $c6, $00
	defb	$7e, $c6, $c6, $7e, $c6, $c6, $7e, $00
	defb	$78, $cc, $06, $06, $06, $cc, $78, $00
	defb	$3e, $66, $c6, $c6, $c6, $66, $3e, $00
	defb	$fe, $06, $06, $fe, $06, $06, $fe, $00
	defb	$fe, $06, $06, $fe, $06, $06, $06, $00
	defb	$78, $cc, $06, $f6, $c6, $cc, $f8, $00
	defb	$c6, $c6, $c6, $fe, $c6, $c6, $c6, $00
	defb	$7e, $18, $18, $18, $18, $18, $7e, $00
	defb	$60, $60, $60, $60, $60, $66, $3c, $00
	defb	$c6, $66, $36, $1e, $36, $66, $c6, $00
	defb	$06, $06, $06, $06, $06, $06, $7e, $00
	defb	$c6, $ee, $fe, $fe, $c6, $c6, $c6, $00
	defb	$c6, $ce, $de, $fe, $f6, $e6, $c6, $00
	defb	$7c, $c6, $c6, $c6, $c6, $c6, $7c, $00
	defb	$7e, $c6, $c6, $c6, $7e, $06, $06, $00
	defb	$7c, $c6, $c6, $c6, $f6, $66, $dc, $00
	defb	$7e, $c6, $c6, $e6, $3e, $76, $e6, $00
	defb	$7c, $c6, $06, $7c, $c0, $c6, $7c, $00
	defb	$7e, $18, $18, $18, $18, $18, $18, $00
	defb	$c6, $c6, $c6, $c6, $c6, $c6, $7c, $00
	defb	$c6, $c6, $c6, $6c, $6c, $38, $38, $00
	defb	$c6, $c6, $c6, $fe, $fe, $ee, $c6, $00
	defb	$c6, $c6, $6c, $38, $6c, $c6, $c6, $00
	defb	$66, $66, $66, $3c, $18, $18, $18, $00
	defb	$fe, $60, $30, $18, $0c, $06, $fe, $00
	defb	$3c, $0c, $0c, $0c, $0c, $0c, $3c, $00
	defb	$00, $06, $0c, $18, $30, $60, $c0, $00
	defb	$78, $60, $60, $60, $60, $60, $78, $00
	defb	$18, $3c, $66, $00, $00, $00, $00, $00
	defb	$00, $00, $00, $00, $00, $00, $fe, $00


    dseg
window.size equ window.width*window.height
vvram defs window.size
public vvram
backup defs window.size
base.x	defb	0
base.y	defb	0
public base.x, base.y
status.x equ window.width + 1

map.offset defb 0
map.byte defb 0
char defb 0

ext map, Score, HiScore

ShiftedPatterns equ $4000
PatternSize equ $600

    cseg

InitPatterns: public InitPatterns
    lda #0 | sta Zp.Counter0
    lda #high ShiftedPatterns | sta Zp.TmpX1.high
    ldx #0
    ldy #1
    do
        lda #low Chars | sta Zp.TmpX0.low
        lda #high Chars | sta Zp.TmpX0.high
        lda #0 | sta Zp.TmpX1.low
        
        lda #low (PatternSize/2) | sta Zp.X
        lda #high (PatternSize/2) | sta Zp.Y
        do
            lda (Zp.TmpX0,x) | sta Zp.Word.low
            lda #0 | sta Zp.Word.high
            lda Zp.Counter0
            if ne
                sta Zp.Counter1
                do
                    asl Zp.Word.low
                    rol Zp.Word.high
                    dec Zp.Counter1
                while ne | wend
            endif

            asl Zp.Word.high
            lda Zp.Word.low
            and #$80
            if ne
                lda Zp.Word.high
                ora #1
                sta Zp.Word.high
            endif

            lda Zp.Word.low | and #$7f | ora #$80 | sta (Zp.TmpX1,x)
            lda Zp.Word.high | and #$7f | ora #$80 | sta (Zp.TmpX1),y

            lda Zp.TmpX0.low | clc | adc #1 | sta Zp.TmpX0.low
            lda Zp.TmpX0.high | adc #0 | sta Zp.TmpX0.high

            lda Zp.TmpX1.low | clc | adc #2 | sta Zp.TmpX1.low
            lda Zp.TmpX1.high | adc #0 | sta Zp.TmpX1.high

            lda Zp.X | sec | sbc #1 | sta Zp.X
            lda Zp.Y | sbc #0 | sta Zp.Y
            lda Zp.X | ora Zp.Y
        while ne | wend

        inc Zp.Counter0
        lda Zp.Counter0
        cmp #7
    while ne | wend
rts        


MapToVVram: public MapToVVram
    lda base.y
    sta Zp.TmpX0.low
    lda #0
    sta Zp.TmpX0.high
    asl Zp.TmpX0.low    ; *2
    rol Zp.TmpX0.high
    asl Zp.TmpX0.low    ; *4
    rol Zp.TmpX0.high
    asl Zp.TmpX0.low    ; *8 : map.step
    rol Zp.TmpX0.high
    lda Zp.TmpX0.low
    clc
    adc #low map
    sta Zp.TmpX0.low
    lda Zp.TmpX0.high
    adc #high map
    sta Zp.TmpX0.high

    lda base.x
    lsr a
    lsr a
    lsr a
    clc
    adc Zp.TmpX0.low
    sta Zp.TmpX0.low 
    lda Zp.TmpX0.high
    adc #0
    sta Zp.TmpX0.high
    ldy #0
    sty map.offset

    lda #1
    sta map.byte
    lda base.x
    and #7
    sta Zp.Counter0
    do | while ne
        asl map.byte
        dec Zp.Counter0
    wend
    lda #low vvram
    sta Zp.TmpX1.low
    lda #high vvram
    sta Zp.TmpX1.high
    lda #window.height
    sta Zp.Counter0
    ldx #0
    do
        lda #window.width
        sta Zp.Counter1
        ldy map.offset
        do
            lda (Zp.TmpX0),y
            and map.byte
            if ne
                lda #Char.Wall
            else
                lda #Char.Space
            endif
            sta (Zp.TmpX1,x)
            lda Zp.TmpX1.low
            clc
            adc #1
            sta Zp.TmpX1.low
            lda Zp.TmpX1.high
            adc #0
            sta Zp.TmpX1.high
            asl map.byte
            if eq
                iny
                inc map.byte
            endif
            dec Zp.Counter1
        while ne | wend
        lda map.offset
        clc
        adc #map.step
        sta map.offset
        dec Zp.Counter0
    while ne | wend
rts

vram_left_top equ $e0
vram_top equ vram_left_top+2
vram_ptr equ vram_top+2
mask_low equ vram_ptr+2
mask_high equ mask_low+1
vram_x_mod equ mask_high+1
pattern_address equ vram_x_mod+1
pattern_low equ pattern_address+1
pattern_high equ pattern_low+1
count_in_block equ pattern_high+1

VVramToVram: public VVramToVram
    ldx #0

    lda #low VVram
    sta Zp.TmpX0.low
    lda #high VVram
    sta Zp.TmpX0.high

    lda #low backup
    sta Zp.TmpX1.low
    lda #high backup
    sta Zp.TmpX1.high

    lda #low Vram0
    sta vram_left_top
    lda #high Vram0
    sta vram_left_top+1

    lda #window.height
    sta Zp.Counter0
    lda #8
    sta count_in_block
    do
        lda vram_left_top
        sta vram_top
        lda vram_left_top+1
        sta vram_top+1

        lda #high ShiftedPatterns
        sta pattern_address
        lda #0
        sta mask_low
        lda #$fe
        sta mask_high

        lda #window.width
        sta Zp.Counter1
        do
            lda (Zp.TmpX0,x)
            cmp (Zp.TmpX1,x)
            if ne
                sta (Zp.TmpX1,x)
                sta Zp.Word.low
                lda #0 | sta Zp.Word.high
                asl Zp.Word.low | rol Zp.Word.high  ; *2
                asl Zp.Word.low | rol Zp.Word.high  ; *4
                asl Zp.Word.low | rol Zp.Word.high  ; *8
                asl Zp.Word.low | rol Zp.Word.high  ; *16
                lda pattern_address | clc | adc Zp.Word.high | sta Zp.Word.high

                lda vram_top | sta vram_ptr
                lda vram_top+1 | sta vram_ptr+1

                ldy #0
                do
                    lda (vram_ptr,x)
                    and mask_low
                    ora (Zp.Word),y
                    sta (vram_ptr,x)
                    iny
                    inc vram_ptr

                    lda (vram_ptr,x) 
                    and mask_high
                    ora (Zp.Word),y
                    sta (vram_ptr,x)
                    iny
                    dec vram_ptr

                    lda vram_ptr+1 | clc | adc #4 | sta vram_ptr+1

                    cpy #8*2
                while ne | wend
            endif   
        
            lda Zp.TmpX0.low
            clc
            adc #1
            sta Zp.TmpX0.low
            lda Zp.TmpX0.high
            adc #0
            sta Zp.TmpX0.high

            lda Zp.TmpX1.low
            clc
            adc #1
            sta Zp.TmpX1.low
            lda Zp.TmpX1.high
            adc #0
            sta Zp.TmpX1.high

            inc vram_top

            sec
            rol mask_low
            asl mask_high

            lda pattern_address | clc | adc #high PatternSize | sta pattern_address
            cmp #high (ShiftedPatterns+PatternSize*7)
            if eq
                inc vram_top

                lda #high ShiftedPatterns
                sta pattern_address
                lda #0
                sta mask_low
                lda #$fe
                sta mask_high
            endif

            dec Zp.Counter1
        while ne | wend
        dec count_in_block
        if eq
            lda vram_left_top
            clc
            adc #low (VramBlockStep -VramRowStep*7)
            sta vram_left_top
            lda vram_left_top+1
            adc #high (VramBlockStep -VramRowStep*7)
            sta vram_left_top+1

            lda #8
            sta count_in_block
        else
            lda vram_left_top
            clc
            adc #VramRowStep
            sta vram_left_top
            lda vram_left_top+1
            adc #0
            sta vram_left_top+1
        endif
        dec Zp.Counter0
    while ne | wend
rts


ClearVram:  public ClearVram
    lda #low Vram0
    sta Zp.TmpX0.low
    lda #high Vram0
    sta Zp.TmpX0.high
    ldx #0
    do
        lda #0
        sta (Zp.TmpX0,x)

        lda Zp.TmpX0.low
        clc
        adc #1
        sta Zp.TmpX0.low
        lda Zp.TmpX0.high
        adc #0
        sta Zp.TmpX0.high

        cmp #(high Vram0) + $20
    while ne | wend

    lda #low backup
    sta Zp.TmpX0.low
    lda #high backup
    sta Zp.TmpX0.high

    lda #low window.size
    sta Zp.Word.low
    lda #high window.size
    sta Zp.Word.high
    do
        lda #Char.Space
        sta (Zp.TmpX0,x)

        lda Zp.TmpX0.low
        clc
        adc #1
        sta Zp.TmpX0.low
        lda Zp.TmpX0.high
        adc #0
        sta Zp.TmpX0.high
     
        lda Zp.Word.low
        sec
        sbc #1
        sta Zp.Word.low
        lda Zp.Word.high
        sbc #0
        sta Zp.Word.high

        lda Zp.Word.low
        ora Zp.Word.high
    while ne | wend     
rts


ToAddress:
    lda #low vvram
    sta Zp.TmpX1.low
    lda #high vvram
    sta Zp.TmpX1.high
    
    lda Zp.y
    asl a       ; *2
    clc
    adc Zp.y    ; *3
    sta Zp.Word.low
    lda #0
    sta Zp.Word.high
    asl Zp.Word.low | rol Zp.Word.high  ; * 6
    asl Zp.Word.low | rol Zp.Word.high  ; * 12
    asl Zp.Word.low | rol Zp.Word.high  ; * 24

    lda Zp.TmpX1.low
    clc 
    adc Zp.Word.low
    sta Zp.TmpX1.low
    lda Zp.TmpX1.high
    adc Zp.Word.high
    sta Zp.TmpX1.high

    lda Zp.TmpX1.low
    clc 
    adc Zp.x
    sta Zp.TmpX1.low
    lda Zp.TmpX1.high
    adc #0
    sta Zp.TmpX1.high
rts

Put2x2: public Put2x2
; in
;   Zp.Byte: index
;   Zp.x: y
;   Zp.y: x
    lda #2
    sta Zp.Counter0
    sta Zp.Counter1

    lda Zp.x
    sec
    sbc base.x
    if cc
        adc #1
        if eq 
            rts
        endif
        dec Zp.Counter0
        inc Zp.Byte
    endif
    cmp #window.width
    if cs
        rts
    endif
    cmp #window.width-1
    if eq
        dec Zp.Counter0
    endif
    sta Zp.x

    lda Zp.y
    sec
    sbc base.y
    if cc
        adc #1
        if eq 
            rts
        endif
        dec Zp.Counter1
        inc Zp.Byte
        inc Zp.Byte
    endif
    cmp #window.height
    if cs
        rts
    endif
    cmp #window.height-1
    if eq
        dec Zp.Counter1
    endif
    sta Zp.y

    jsr ToAddress

    ldy #0
    do
        lda Zp.Counter0
        sta Zp.Byte2
        tya
        pha
            do
                lda Zp.Byte
                sta (Zp.TmpX1),y
                iny
                inc Zp.Byte
                dec Zp.Byte2
            while ne | wend
        pla
        clc
        adc #window.width
        tay

        dec Zp.Counter1
    while ne | wend
rts


Put1x1: public Put1x1
; in
;   Zp.Byte: index
;   Zp.x: y
;   Zp.y: x
    lda Zp.x
    sec
    sbc base.x
    if cc
        rts
    endif
    cmp #window.width
    if cs
        rts
    endif
    sta Zp.x

    lda Zp.y
    sec
    sbc base.y
    if cc
        rts
    endif
    cmp #window.height
    if cs
        rts
    endif
    sta Zp.y

    jsr ToAddress

    lda Zp.Byte
    ldy #0
    sta (Zp.TmpX1),y
rts


Print1:
    lda Zp.Byte
    sta Zp.Word.low
    lda #0
    sta Zp.Word.high
    asl Zp.Word.low ; *2
    rol Zp.Word.high
    asl Zp.Word.low ; *4
    rol Zp.Word.high
    asl Zp.Word.low ; *8
    rol Zp.Word.high
    lda Zp.Word.low
    clc
    adc #low Chars
    sta Zp.Word.low
    lda Zp.Word.high
    adc #high Chars
    sta Zp.Word.high

    lda vram_top
    sta vram_ptr
    lda vram_top+1
    sta vram_ptr+1

    ldx #0
    ldy #0
    lda #8
    sta Zp.Byte
    do
        lda (Zp.Word),y
        sta pattern_low
        lda #0
        sta pattern_high
        
        lda vram_x_mod
        if ne
            do
                asl pattern_low
                rol pattern_high
                sec
                sbc #1
            while ne | wend
        endif

        lda (vram_ptr,x)
        and mask_low
        ora pattern_low
        ora #$80
        sta (vram_ptr,x)
        inc vram_ptr

        asl pattern_low
        rol pattern_high

        lda (vram_ptr,x)
        and mask_high
        ora pattern_high
        ora #$80
        sta (vram_ptr,x)
        dec vram_ptr

        lda vram_ptr+1
        clc
        adc #4
        sta vram_ptr+1

        iny
        dec Zp.Byte
    while ne | wend

    inc vram_top
    inc vram_x_mod
    sec
    rol mask_low
    asl mask_high
    lda mask_low
    cmp #$7f
    if eq
        inc vram_top

        lda #0
        sta vram_x_mod
        sta mask_low
        lda #$fe
        sta mask_high
    endif
rts

columns:
    defb 0,0,0,$fe
    defb 1,1,1,$fc
    defb 2,2,3,$f8
    defb 3,3,7,$f0
    defb 4,4,$f,$e0
    defb 5,5,$1f,$c0
    defb 6,6,$3f,0
    defb 8,0,0,$fe
    defb 9,1,1,$fc
    defb 10,2,3,$f8
    defb 11,3,7,$f0
    defb 12,4,$f,$e0
    defb 13,5,$1f,$c0
    defb 14,6,$3f,0
    defb 16,0,0,$fe
    defb 17,1,1,$fc
    defb 18,2,3,$f8
    defb 19,3,7,$f0
    defb 20,4,$f,$e0
    defb 21,5,$1f,$c0
    defb 22,6,$3f,0
    defb 24,0,0,$fe
    defb 25,1,1,$fc
    defb 26,2,3,$f8
    defb 27,3,7,$f0
    defb 28,4,$f,$e0
    defb 29,5,$1f,$c0
    defb 30,6,$3f,0
    defb 32,0,0,$fe
    defb 33,1,1,$fc
    defb 34,2,3,$f8
    defb 35,3,7,$f0


VramAddress:
    lda #0
    sta vram_left_top
    lda Zp.Y
    and #7
    sta vram_left_top+1
    lsr vram_left_top+1
    ror vram_left_top
    lda vram_left_top+1
    clc
    adc #high Vram0
    sta vram_left_top+1

    lda Zp.Y
    lsr a   ; /2
    lsr a   ; /4
    lsr a   ; /8
    if ne
        sta Zp.Counter0
        lda vram_left_top
        do
            clc
            adc #40
            dec Zp.Counter0
        while ne | wend
        sta vram_left_top
    endif
    
    lda Zp.X
    asl a
    asl a
    tax
    lda columns,x
    inx
    clc
    adc vram_left_top
    sta vram_left_top

    lda columns,x
    inx
    sta vram_x_mod

    lda columns,x
    inx
    sta mask_low
    lda columns,x
    sta mask_high
rts


Locate: public Locate
    jsr VramAddress
    lda vram_left_top
    sta vram_top
    lda vram_left_top+1
    sta vram_top+1
rts


PrintC: public PrintC
    lda Zp.Byte
    clc | adc #(Char.Ascii-' ')
    sta Zp.Byte
jmp Print1


PrintS: public PrintS
    jsr Locate

    ldy #0
    do
        lda (Zp.TmpX0),y
    while ne
        clc
        adc #(Char.Ascii-' ')
        sta Zp.Byte

        iny
        tya
        pha
            jsr Print1
        pla
        tay
    wend
rts

Print2x2: public Print2x2
    jsr VramAddress
    
    lda #2
    sta Zp.Counter0
    do
        lda vram_left_top
        sta vram_top
        lda vram_left_top+1
        sta vram_top+1

        lda mask_low | pha
        lda mask_high | pha
        lda vram_x_mod | pha
            lda #2
            sta Zp.Counter1
            do
                lda Zp.Byte | pha
                    jsr Print1
                pla | sta Zp.Byte
                inc Zp.Byte
                dec Zp.Counter1
            while ne | wend
        pla | sta vram_x_mod
        pla | sta mask_high
        pla | sta mask_low

        lda vram_left_top | clc | adc #low VramRowStep | sta vram_left_top
        lda vram_left_top+1 | adc #high VramRowStep | sta vram_left_top+1

        dec Zp.X
        inc Zp.Y
        lda Zp.Y
        and #7
        if eq
            lda vram_left_top
            clc | adc #low (VramBlockStep -VramRowStep*8)
            sta vram_left_top
            lda vram_left_top+1
            adc #high (VramBlockStep -VramRowStep*8)
            sta vram_left_top+1
        endif

        dec Zp.Counter0
    while ne | wend
rts


PrintSpace2x2: public PrintSpace2x2
    jsr VramAddress
    
    lda #2 | sta Zp.Counter0
    do
        lda vram_left_top
        sta vram_top
        lda vram_left_top+1
        sta vram_top+1

        lda mask_low | pha
        lda mask_high | pha
        lda vram_x_mod | pha
            lda #2
            sta Zp.Counter1
            do
                lda #Char.Space | sta Zp.Byte
                jsr Print1
                dec Zp.Counter1
            while ne | wend
        pla | sta vram_x_mod
        pla | sta mask_high
        pla | sta mask_low

                                            _deb : public _deb
        lda vram_left_top | clc | adc #low VramRowStep | sta vram_left_top
        lda vram_left_top+1 | adc #high VramRowStep | sta vram_left_top+1

        dec Zp.X
        inc Zp.Y
        lda Zp.Y
        and #7
        if eq
            lda vram_left_top
            clc | adc #low (VramBlockStep -VramRowStep*8)
            sta vram_left_top
            lda vram_left_top+1
            adc #high (VramBlockStep -VramRowStep*8)
            sta vram_left_top+1
        endif

        dec Zp.Counter0
    while ne | wend
rts


Print1x1: public Print1x1
    jsr VramAddress
    lda vram_left_top
    sta vram_top
    lda vram_left_top+1
    sta vram_top+1
    jsr Print1
rts
