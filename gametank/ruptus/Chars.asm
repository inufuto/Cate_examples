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
;	star
	defb	$80, $00, $40, $00, $20, $00, $10, $00
	defb	$08, $00, $04, $00, $02, $00, $01, $00
	defb	$00, $80, $00, $40, $00, $20, $00, $10
	defb	$00, $08, $00, $04, $00, $02, $00, $01

ColorPattern: public ColorPattern
;	color4
	defb	$66, $66, $00, $00, $00, $00, $00, $00
	defb	$00, $00, $00, $00, $66, $66, $00, $00
	defb	$60, $00, $60, $00, $60, $00, $60, $00
	defb	$00, $60, $00, $60, $00, $60, $00, $60
	defb	$11, $11, $11, $11, $11, $11, $11, $11
	defb	$55, $51, $55, $51, $55, $51, $11, $11
;	remain
	defb	$00, $07, $00, $77, $00, $75, $07, $77
	defb	$00, $00, $70, $00, $70, $00, $77, $00
	defb	$77, $77, $0a, $07, $00, $07, $00, $00
	defb	$77, $70, $0a, $00, $00, $00, $00, $00
;	fort
	defb	$00, $aa, $0a, $aa, $aa, $aa, $aa, $aa
	defb	$00, $00, $a0, $00, $aa, $00, $a8, $85
	defb	$00, $00, $00, $00, $05, $55, $55, $55
	defb	$00, $00, $00, $00, $50, $00, $55, $58
	defb	$00, $aa, $0a, $aa, $aa, $aa, $8a, $aa
	defb	$00, $00, $a0, $00, $aa, $00, $aa, $00
	defb	$0a, $aa, $08, $88, $05, $55, $08, $88
	defb	$88, $58, $55, $58, $55, $58, $88, $88
	defb	$88, $88, $66, $88, $60, $ff, $8f, $ff
	defb	$88, $85, $66, $85, $06, $85, $f8, $88
	defb	$88, $aa, $55, $88, $55, $55, $88, $88
	defb	$a0, $00, $80, $00, $50, $00, $80, $00
	defb	$03, $33, $01, $88, $01, $84, $01, $84
	defb	$33, $88, $88, $18, $48, $18, $48, $18
	defb	$ff, $ff, $ff, $00, $8f, $ff, $8f, $ff
	defb	$ff, $88, $ff, $81, $f8, $81, $f8, $81
	defb	$33, $33, $00, $00, $04, $40, $04, $40
	defb	$30, $00, $10, $00, $10, $00, $10, $00
	defb	$01, $88, $03, $33, $08, $88, $05, $55
	defb	$88, $18, $33, $88, $88, $88, $55, $58
	defb	$ff, $00, $ff, $ff, $8f, $ff, $60, $ff
	defb	$ff, $81, $ff, $88, $f8, $88, $06, $85
	defb	$00, $00, $33, $33, $88, $88, $55, $55
	defb	$10, $00, $30, $00, $80, $00, $50, $00
	defb	$08, $88, $0a, $aa, $aa, $aa, $aa, $aa
	defb	$55, $58, $88, $58, $a8, $85, $aa, $00
	defb	$66, $88, $88, $88, $55, $55, $05, $55
	defb	$66, $85, $88, $85, $55, $58, $50, $00
	defb	$55, $88, $88, $aa, $8a, $aa, $aa, $aa
	defb	$80, $00, $a0, $00, $aa, $00, $aa, $00
	defb	$0a, $aa, $00, $aa, $00, $00, $00, $00
	defb	$a0, $00, $00, $00, $00, $00, $00, $00
	defb	$00, $00, $00, $00, $00, $00, $00, $00
	defb	$00, $00, $00, $00, $00, $00, $00, $00
	defb	$0a, $aa, $00, $aa, $00, $00, $00, $00
	defb	$a0, $00, $00, $00, $00, $00, $00, $00
	defb	$00, $00, $00, $0a, $00, $aa, $00, $aa
	defb	$aa, $00, $aa, $a0, $aa, $aa, $aa, $a8
	defb	$00, $00, $00, $00, $00, $05, $85, $55
	defb	$00, $00, $00, $00, $55, $50, $55, $55
	defb	$00, $00, $00, $0a, $00, $aa, $58, $8a
	defb	$aa, $00, $aa, $a0, $aa, $aa, $aa, $aa
	defb	$00, $0a, $00, $08, $00, $05, $00, $08
	defb	$aa, $88, $88, $55, $55, $55, $88, $88
	defb	$58, $88, $58, $66, $58, $60, $88, $8f
	defb	$88, $88, $88, $66, $ff, $06, $ff, $f8
	defb	$85, $88, $85, $55, $85, $55, $88, $88
	defb	$aa, $a0, $88, $80, $55, $50, $88, $80
	defb	$00, $03, $00, $01, $00, $01, $00, $01
	defb	$33, $33, $88, $88, $84, $48, $84, $48
	defb	$88, $ff, $18, $ff, $18, $8f, $18, $8f
	defb	$ff, $ff, $00, $ff, $ff, $f8, $ff, $f8
	defb	$88, $33, $81, $00, $81, $04, $81, $04
	defb	$33, $30, $00, $10, $40, $10, $40, $10
	defb	$00, $01, $00, $03, $00, $08, $00, $05
	defb	$88, $88, $33, $33, $88, $88, $55, $55
	defb	$18, $ff, $88, $ff, $88, $8f, $58, $60
	defb	$00, $ff, $ff, $ff, $ff, $f8, $ff, $06
	defb	$81, $00, $88, $33, $88, $88, $85, $55
	defb	$00, $10, $33, $30, $88, $80, $55, $50
	defb	$00, $08, $00, $0a, $00, $aa, $00, $aa
	defb	$88, $55, $aa, $88, $aa, $a8, $aa, $aa
	defb	$58, $66, $58, $88, $85, $55, $00, $05
	defb	$88, $66, $88, $88, $55, $55, $55, $50
	defb	$85, $55, $85, $88, $58, $8a, $00, $aa
	defb	$88, $80, $aa, $a0, $aa, $aa, $aa, $aa
	defb	$00, $0a, $00, $00, $00, $00, $00, $00
	defb	$aa, $a0, $aa, $00, $00, $00, $00, $00
	defb	$00, $00, $00, $00, $00, $00, $00, $00
	defb	$00, $00, $00, $00, $00, $00, $00, $00
	defb	$00, $0a, $00, $00, $00, $00, $00, $00
	defb	$aa, $a0, $aa, $00, $00, $00, $00, $00
	defb	$00, $00, $00, $00, $00, $aa, $0a, $aa
	defb	$00, $00, $00, $00, $00, $00, $a0, $00
	defb	$00, $00, $00, $00, $00, $00, $00, $00
	defb	$00, $00, $00, $00, $00, $00, $00, $00
	defb	$00, $00, $00, $00, $00, $aa, $0a, $aa
	defb	$00, $00, $00, $00, $00, $00, $a0, $00
	defb	$aa, $aa, $aa, $aa, $0a, $aa, $08, $88
	defb	$aa, $00, $a8, $85, $88, $58, $55, $58
	defb	$05, $55, $55, $55, $88, $88, $66, $88
	defb	$50, $00, $55, $58, $88, $85, $66, $85
	defb	$aa, $aa, $8a, $aa, $88, $aa, $55, $88
	defb	$aa, $00, $aa, $00, $a0, $00, $80, $00
	defb	$05, $55, $08, $88, $03, $33, $01, $88
	defb	$55, $58, $88, $88, $33, $88, $88, $18
	defb	$60, $ff, $8f, $ff, $ff, $ff, $ff, $00
	defb	$06, $85, $f8, $88, $ff, $88, $ff, $81
	defb	$55, $55, $88, $88, $33, $33, $00, $00
	defb	$50, $00, $80, $00, $30, $00, $10, $00
	defb	$01, $84, $01, $84, $01, $88, $03, $33
	defb	$48, $18, $48, $18, $88, $18, $33, $88
	defb	$8f, $ff, $8f, $ff, $ff, $00, $ff, $ff
	defb	$f8, $81, $f8, $81, $ff, $81, $ff, $88
	defb	$04, $40, $04, $40, $00, $00, $33, $33
	defb	$10, $00, $10, $00, $10, $00, $30, $00
	defb	$08, $88, $05, $55, $08, $88, $0a, $aa
	defb	$88, $88, $55, $58, $55, $58, $88, $58
	defb	$8f, $ff, $60, $ff, $66, $88, $88, $88
	defb	$f8, $88, $06, $85, $66, $85, $88, $85
	defb	$88, $88, $55, $55, $55, $88, $88, $aa
	defb	$80, $00, $50, $00, $80, $00, $a0, $00
	defb	$aa, $aa, $aa, $aa, $0a, $aa, $00, $aa
	defb	$a8, $85, $aa, $00, $a0, $00, $00, $00
	defb	$55, $55, $05, $55, $00, $00, $00, $00
	defb	$55, $58, $50, $00, $00, $00, $00, $00
	defb	$8a, $aa, $aa, $aa, $0a, $aa, $00, $aa
	defb	$aa, $00, $aa, $00, $a0, $00, $00, $00
	defb	$00, $00, $00, $00, $00, $00, $00, $0a
	defb	$00, $00, $00, $00, $aa, $00, $aa, $a0
	defb	$00, $00, $00, $00, $00, $00, $00, $00
	defb	$00, $00, $00, $00, $00, $00, $00, $00
	defb	$00, $00, $00, $00, $00, $00, $00, $0a
	defb	$00, $00, $00, $00, $aa, $00, $aa, $a0
	defb	$00, $aa, $00, $aa, $00, $0a, $00, $08
	defb	$aa, $aa, $aa, $a8, $aa, $88, $88, $55
	defb	$00, $05, $85, $55, $58, $88, $58, $66
	defb	$55, $50, $55, $55, $88, $88, $88, $66
	defb	$00, $aa, $58, $8a, $85, $88, $85, $55
	defb	$aa, $aa, $aa, $aa, $aa, $a0, $88, $80
	defb	$00, $05, $00, $08, $00, $03, $00, $01
	defb	$55, $55, $88, $88, $33, $33, $88, $88
	defb	$58, $60, $88, $8f, $88, $ff, $18, $ff
	defb	$ff, $06, $ff, $f8, $ff, $ff, $00, $ff
	defb	$85, $55, $88, $88, $88, $33, $81, $00
	defb	$55, $50, $88, $80, $33, $30, $00, $10
	defb	$00, $01, $00, $01, $00, $01, $00, $03
	defb	$84, $48, $84, $48, $88, $88, $33, $33
	defb	$18, $8f, $18, $8f, $18, $ff, $88, $ff
	defb	$ff, $f8, $ff, $f8, $00, $ff, $ff, $ff
	defb	$81, $04, $81, $04, $81, $00, $88, $33
	defb	$40, $10, $40, $10, $00, $10, $33, $30
	defb	$00, $08, $00, $05, $00, $08, $00, $0a
	defb	$88, $88, $55, $55, $88, $55, $aa, $88
	defb	$88, $8f, $58, $60, $58, $66, $58, $88
	defb	$ff, $f8, $ff, $06, $88, $66, $88, $88
	defb	$88, $88, $85, $55, $85, $55, $85, $88
	defb	$88, $80, $55, $50, $88, $80, $aa, $a0
	defb	$00, $aa, $00, $aa, $00, $0a, $00, $00
	defb	$aa, $a8, $aa, $aa, $aa, $a0, $aa, $00
	defb	$85, $55, $00, $05, $00, $00, $00, $00
	defb	$55, $55, $55, $50, $00, $00, $00, $00
	defb	$58, $8a, $00, $aa, $00, $0a, $00, $00
	defb	$aa, $aa, $aa, $aa, $aa, $a0, $aa, $00

SpritePattern: public SpritePattern
;	sprite
	defb	$00, $07, $00, $00, $00, $77, $70, $00
	defb	$00, $75, $70, $00, $07, $77, $77, $00
	defb	$77, $77, $77, $70, $0a, $07, $0a, $00
	defb	$00, $07, $00, $00, $00, $00, $00, $00
	defb	$00, $00, $00, $70, $00, $07, $77, $00
	defb	$77, $77, $57, $00, $a7, $77, $77, $00
	defb	$00, $77, $70, $00, $07, $07, $70, $00
	defb	$00, $0a, $70, $00, $00, $00, $00, $00
	defb	$00, $70, $00, $00, $0a, $77, $00, $00
	defb	$00, $77, $77, $00, $77, $77, $57, $70
	defb	$00, $77, $77, $00, $0a, $77, $00, $00
	defb	$00, $70, $00, $00, $00, $00, $00, $00
	defb	$00, $0a, $70, $00, $07, $07, $70, $00
	defb	$00, $77, $70, $00, $a7, $77, $77, $00
	defb	$77, $77, $57, $00, $00, $07, $77, $00
	defb	$00, $00, $00, $70, $00, $00, $00, $00
	defb	$00, $07, $00, $00, $0a, $07, $0a, $00
	defb	$77, $77, $77, $70, $07, $77, $77, $00
	defb	$00, $75, $70, $00, $00, $77, $70, $00
	defb	$00, $07, $00, $00, $00, $00, $00, $00
	defb	$00, $7a, $00, $00, $00, $77, $07, $00
	defb	$00, $77, $70, $00, $07, $77, $77, $a0
	defb	$07, $57, $77, $70, $07, $77, $00, $00
	defb	$70, $00, $00, $00, $00, $00, $00, $00
	defb	$00, $00, $70, $00, $00, $07, $7a, $00
	defb	$07, $77, $70, $00, $77, $57, $77, $70
	defb	$07, $77, $70, $00, $00, $07, $7a, $00
	defb	$00, $00, $70, $00, $00, $00, $00, $00
	defb	$70, $00, $00, $00, $07, $77, $00, $00
	defb	$07, $57, $77, $70, $07, $77, $77, $a0
	defb	$00, $77, $70, $00, $00, $77, $07, $00
	defb	$00, $7a, $00, $00, $00, $00, $00, $00
	defb	$00, $0a, $00, $00, $00, $aa, $a0, $00
	defb	$0a, $5a, $5a, $00, $3a, $aa, $aa, $30
	defb	$3a, $a3, $aa, $30, $30, $03, $00, $30
	defb	$00, $03, $00, $00, $00, $00, $00, $00
	defb	$00, $3a, $aa, $a0, $03, $aa, $5a, $a0
	defb	$30, $aa, $a5, $a0, $00, $03, $aa, $a0
	defb	$00, $30, $aa, $30, $00, $00, $03, $00
	defb	$00, $00, $30, $00, $00, $00, $00, $00
	defb	$03, $33, $00, $00, $00, $aa, $a0, $00
	defb	$00, $aa, $5a, $00, $33, $3a, $aa, $a0
	defb	$00, $aa, $5a, $00, $00, $aa, $a0, $00
	defb	$03, $33, $00, $00, $00, $00, $00, $00
	defb	$00, $00, $30, $00, $00, $00, $03, $00
	defb	$00, $30, $aa, $30, $00, $03, $aa, $a0
	defb	$30, $aa, $a5, $a0, $03, $aa, $5a, $a0
	defb	$00, $3a, $aa, $a0, $00, $00, $00, $00
	defb	$00, $03, $00, $00, $30, $03, $00, $30
	defb	$3a, $a3, $aa, $30, $3a, $aa, $aa, $30
	defb	$0a, $5a, $5a, $00, $00, $aa, $a0, $00
	defb	$00, $0a, $00, $00, $00, $00, $00, $00
	defb	$00, $30, $00, $00, $03, $00, $00, $00
	defb	$3a, $a0, $30, $00, $aa, $a3, $00, $00
	defb	$a5, $aa, $a0, $30, $aa, $5a, $a3, $00
	defb	$aa, $aa, $30, $00, $00, $00, $00, $00
	defb	$00, $03, $33, $00, $00, $aa, $a0, $00
	defb	$0a, $5a, $a0, $00, $aa, $aa, $33, $30
	defb	$0a, $5a, $a0, $00, $00, $aa, $a0, $00
	defb	$00, $03, $33, $00, $00, $00, $00, $00
	defb	$aa, $aa, $30, $00, $aa, $5a, $a3, $00
	defb	$a5, $aa, $a0, $30, $aa, $a3, $00, $00
	defb	$3a, $a0, $30, $00, $03, $00, $00, $00
	defb	$00, $30, $00, $00, $00, $00, $00, $00
	defb	$07, $00, $00, $00, $07, $00, $00, $00
	defb	$07, $00, $00, $00, $07, $00, $00, $00
	defb	$00, $00, $00, $00, $00, $00, $00, $00
	defb	$00, $00, $00, $00, $00, $00, $00, $00
	defb	$00, $07, $00, $00, $00, $70, $00, $00
	defb	$07, $00, $00, $00, $70, $00, $00, $00
	defb	$00, $00, $00, $00, $00, $00, $00, $00
	defb	$00, $00, $00, $00, $00, $00, $00, $00
	defb	$00, $00, $00, $00, $77, $77, $00, $00
	defb	$00, $00, $00, $00, $00, $00, $00, $00
	defb	$00, $00, $00, $00, $00, $00, $00, $00
	defb	$00, $00, $00, $00, $00, $00, $00, $00
	defb	$70, $00, $00, $00, $07, $00, $00, $00
	defb	$00, $70, $00, $00, $00, $07, $00, $00
	defb	$00, $00, $00, $00, $00, $00, $00, $00
	defb	$00, $00, $00, $00, $00, $00, $00, $00
	defb	$06, $60, $00, $00, $66, $66, $00, $00
	defb	$66, $66, $00, $00, $06, $60, $00, $00
	defb	$00, $00, $00, $00, $00, $00, $00, $00
	defb	$00, $00, $00, $00, $00, $00, $00, $00
	defb	$55, $55, $00, $00, $5a, $a5, $00, $00
	defb	$5a, $a5, $00, $00, $55, $55, $00, $00
	defb	$00, $00, $00, $00, $00, $00, $00, $00
	defb	$00, $00, $00, $00, $00, $00, $00, $00
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
	defb	$04, $44, $44, $40, $41, $41, $44, $44
	defb	$41, $41, $22, $24, $41, $41, $24, $24
	defb	$41, $11, $22, $24, $44, $44, $24, $44
	defb	$04, $44, $44, $40, $00, $00, $00, $00
	defb	$70, $00, $00, $00, $00, $00, $00, $00
	defb	$00, $00, $00, $00, $00, $00, $00, $00
	defb	$00, $00, $00, $00, $00, $00, $00, $00
	defb	$00, $00, $00, $00, $00, $00, $00, $00
