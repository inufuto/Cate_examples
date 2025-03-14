cseg

AsciiPattern: public AsciiPattern
	; ascii 28
	; " -0123456789:ACEFGHIMNORSTUV"
	defb $00,$00,$00,$00,$e0,$00,$ea,$aa
	defb $e0,$22,$22,$20,$e2,$e8,$e0,$e2
	defb $e2,$e0,$aa,$e2,$20,$e8,$e2,$e0
	defb $e8,$ea,$e0,$e2,$44,$40,$ea,$ea
	defb $e0,$ea,$e2,$e0,$04,$04,$00,$4a
	defb $ae,$a0,$4a,$8a,$40,$e8,$c8,$e0
	defb $e8,$c8,$80,$68,$aa,$40,$aa,$ea
	defb $a0,$e4,$44,$e0,$ae,$ea,$a0,$ca
	defb $aa,$a0,$4a,$aa,$40,$ca,$ca,$a0
	defb $68,$e2,$c0,$e4,$44,$40,$aa,$aa
	defb $e0,$aa,$aa,$40

MonoPattern: public MonoPattern
;	logo
	defb	$00, $00, $cc, $00, $00, $cc, $cc, $cc
	defb	$33, $00, $ff, $00, $33, $cc, $ff, $cc
	defb	$00, $33, $cc, $33, $00, $ff, $cc, $ff
	defb	$33, $33, $ff, $33, $33, $ff, $ff, $ff

ColorPattern: public ColorPattern
;	remain
	defb	$00, $00, $70, $00, $77, $07, $77, $77
	defb	$00, $00, $77, $00, $75, $70, $77, $77
	defb	$07, $78, $00, $07, $00, $77, $00, $00
	defb	$87, $77, $70, $00, $00, $00, $00, $00
;	ground_shift
	defb	$bb, $bb, $bb, $bb, $bb, $bb, $bb, $bb
	defb	$00, $00, $00, $00, $00, $00, $00, $00
	defb	$00, $00, $00, $00, $00, $00, $00, $00
	defb	$00, $00, $00, $00, $00, $00, $00, $0b
	defb	$00, $00, $00, $00, $00, $0b, $00, $bb
	defb	$00, $0b, $00, $0b, $00, $bb, $0b, $bb
	defb	$00, $bb, $00, $bb, $0b, $bb, $bb, $bb
	defb	$0b, $bb, $0b, $bb, $bb, $bb, $bb, $bb
	defb	$bb, $bb, $bb, $bb, $bb, $bb, $bb, $bb
	defb	$00, $0b, $00, $0b, $00, $bb, $0b, $bb
	defb	$00, $b0, $00, $bb, $0b, $bb, $bb, $bb
	defb	$0b, $00, $0b, $bb, $bb, $bb, $bb, $bb
	defb	$b0, $00, $bb, $b0, $bb, $bb, $bb, $bb
	defb	$00, $00, $bb, $00, $bb, $b0, $bb, $bb
	defb	$00, $00, $b0, $00, $bb, $00, $bb, $b0
	defb	$00, $00, $00, $00, $b0, $00, $bb, $00
	defb	$00, $00, $00, $00, $00, $00, $b0, $00
	defb	$bb, $bb, $bb, $bb, $bb, $bb, $bb, $bb
	defb	$bb, $b0, $bb, $bb, $bb, $bb, $bb, $bb
	defb	$bb, $00, $bb, $bb, $bb, $bb, $bb, $bb
	defb	$b0, $00, $bb, $b0, $bb, $bb, $bb, $bb
	defb	$00, $00, $bb, $00, $bb, $b0, $bb, $bb
	defb	$00, $00, $b0, $00, $bb, $00, $bb, $b0
	defb	$00, $00, $00, $00, $b0, $00, $bb, $0b
	defb	$00, $00, $00, $00, $00, $0b, $b0, $bb

SpritePattern: public SpritePattern
;	sprite
	defb	$00, $00, $00, $00, $70, $00, $77, $00
	defb	$77, $07, $75, $70, $77, $77, $77, $77
	defb	$07, $78, $87, $77, $00, $07, $70, $00
	defb	$00, $77, $00, $00, $00, $00, $00, $00
	defb	$00, $07, $00, $00, $00, $77, $00, $00
	defb	$07, $77, $00, $00, $07, $77, $77, $00
	defb	$00, $07, $77, $70, $77, $87, $75, $70
	defb	$07, $78, $77, $70, $00, $00, $07, $00
	defb	$00, $00, $77, $70, $00, $07, $75, $77
	defb	$00, $07, $77, $70, $77, $77, $77, $80
	defb	$07, $77, $78, $70, $00, $77, $07, $70
	defb	$00, $00, $07, $00, $00, $00, $00, $00
	defb	$00, $00, $00, $00, $00, $aa, $00, $0a
	defb	$0a, $5a, $a0, $aa, $aa, $aa, $aa, $aa
	defb	$aa, $a8, $8a, $a0, $00, $0a, $a0, $00
	defb	$00, $00, $aa, $00, $00, $00, $00, $00
	defb	$00, $00, $00, $00, $30, $00, $33, $00
	defb	$33, $03, $35, $30, $33, $33, $33, $33
	defb	$03, $38, $83, $33, $00, $03, $30, $00
	defb	$00, $33, $00, $00, $00, $00, $00, $00
	defb	$00, $0c, $00, $00, $00, $cc, $c0, $00
	defb	$00, $0c, $cc, $00, $0c, $c0, $cc, $c0
	defb	$c5, $c0, $0c, $c0, $cc, $cc, $c8, $8c
	defb	$cc, $cc, $cc, $cc, $0f, $f0, $0f, $f0
	defb	$00, $07, $00, $00, $00, $07, $00, $00
	defb	$00, $77, $70, $00, $00, $77, $70, $00
	defb	$00, $77, $70, $00, $0a, $7a, $7a, $00
	defb	$aa, $7a, $7a, $a0, $aa, $0a, $0a, $a0
	defb	$00, $02, $00, $00, $02, $22, $20, $20
	defb	$22, $6e, $e2, $22, $02, $e6, $6e, $20
	defb	$02, $6e, $6e, $22, $22, $22, $e2, $20
	defb	$02, $02, $20, $20, $00, $02, $00, $00
	defb	$00, $00, $00, $02, $00, $20, $00, $02
	defb	$00, $02, $20, $22, $00, $02, $e2, $2e
	defb	$00, $22, $6e, $6e, $22, $22, $e6, $66
	defb	$02, $22, $e6, $66, $00, $22, $66, $6e
	defb	$00, $00, $20, $00, $20, $02, $20, $00
	defb	$22, $22, $20, $00, $62, $22, $00, $22
	defb	$66, $e2, $22, $20, $ee, $66, $22, $00
	defb	$66, $6e, $20, $00, $66, $ee, $20, $00
	defb	$00, $22, $e6, $ee, $02, $2e, $66, $66
	defb	$22, $e2, $e6, $e6, $00, $22, $ee, $e6
	defb	$00, $02, $22, $ee, $00, $22, $00, $22
	defb	$00, $20, $00, $02, $00, $00, $00, $02
	defb	$66, $6e, $e2, $00, $66, $66, $ee, $20
	defb	$6e, $ee, $e2, $22, $e2, $22, $20, $00
	defb	$e2, $22, $20, $00, $20, $02, $22, $00
	defb	$00, $00, $00, $00, $00, $00, $00, $00
	defb	$00, $00, $00, $00, $07, $70, $00, $00
	defb	$07, $70, $00, $00, $00, $00, $00, $00
	defb	$00, $00, $00, $00, $00, $00, $00, $00
	defb	$00, $00, $00, $00, $00, $00, $00, $00
	defb	$00, $00, $00, $00, $06, $60, $00, $00
	defb	$06, $60, $00, $00, $00, $00, $00, $00
	defb	$00, $00, $00, $00, $00, $00, $00, $00
	defb	$00, $00, $00, $00, $00, $00, $00, $00
	defb	$04, $44, $44, $40, $41, $41, $44, $44
	defb	$41, $41, $22, $24, $41, $41, $24, $24
	defb	$41, $11, $22, $24, $44, $44, $24, $44
	defb	$04, $44, $44, $40, $00, $00, $00, $00

FortPattern : public FortPattern
;	fort
	defb	$00, $00, $00, $55, $05, $5a, $55, $55
	defb	$55, $55, $5a, $aa, $a5, $55, $55, $55
	defb	$55, $55, $aa, $aa, $55, $55, $55, $55
	defb	$55, $55, $aa, $aa, $55, $55, $55, $55
	defb	$55, $55, $aa, $aa, $55, $55, $55, $55
	defb	$55, $00, $aa, $55, $55, $aa, $55, $55
	defb	$00, $aa, $aa, $aa, $55, $00, $55, $55
	defb	$5a, $aa, $55, $55, $05, $5a, $00, $55
	defb	$aa, $aa, $55, $55, $a5, $55, $5a, $aa
	defb	$aa, $aa, $55, $55, $55, $55, $aa, $aa
	defb	$aa, $aa, $55, $55, $55, $55, $aa, $aa
	defb	$aa, $aa, $55, $55, $55, $55, $aa, $aa
	defb	$aa, $aa, $55, $55, $55, $aa, $aa, $55
	defb	$aa, $aa, $55, $55, $55, $00, $0a, $aa
	defb	$00, $00, $00, $00, $00, $00, $00, $00
	defb	$55, $55, $00, $ef, $0e, $ef, $00, $77
	defb	$55, $55, $ee, $ee, $ee, $ee, $70, $00
	defb	$55, $55, $ee, $ee, $ee, $ee, $66, $60
	defb	$55, $55, $ee, $ee, $ee, $ee, $07, $77
	defb	$55, $00, $fe, $00, $fe, $00, $00, $00
	defb	$00, $aa, $00, $00, $00, $00, $00, $00
	defb	$00, $00, $00, $00, $00, $00, $00, $00
	defb	$00, $77, $07, $70, $00, $00, $00, $00
	defb	$70, $06, $00, $05, $00, $06, $00, $00
	defb	$66, $60, $56, $60, $66, $60, $06, $60
	defb	$07, $77, $00, $07, $00, $00, $00, $00
	defb	$00, $00, $70, $00, $00, $00, $00, $00
	defb	$00, $00, $00, $00, $00, $00, $00, $00
