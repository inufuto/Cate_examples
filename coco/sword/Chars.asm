cseg

CharPattern: public CharPattern
; ascii 30
	; " -0123456789ACEFGHIKMNOPRSTUVY"
	defb $aa,$aa,$aa,$aa,$aa,$aa,$aa,$aa
	defb $aa,$aa,$aa,$56,$aa,$aa,$aa,$aa
	defb $9a,$66,$66,$66,$66,$66,$9a,$aa
	defb $a6,$a6,$a6,$a6,$a6,$a6,$a6,$aa
	defb $9a,$66,$a6,$a6,$9a,$6a,$56,$aa
	defb $9a,$66,$a6,$9a,$a6,$66,$9a,$aa
	defb $a6,$66,$66,$56,$a6,$a6,$a6,$aa
	defb $56,$6a,$6a,$5a,$a6,$a6,$5a,$aa
	defb $9a,$66,$6a,$5a,$66,$66,$9a,$aa
	defb $56,$66,$a6,$9a,$9a,$9a,$9a,$aa
	defb $9a,$66,$66,$9a,$66,$66,$9a,$aa
	defb $9a,$66,$66,$96,$a6,$66,$9a,$aa
	defb $9a,$66,$66,$66,$56,$66,$66,$aa
	defb $9a,$66,$6a,$6a,$6a,$66,$9a,$aa
	defb $56,$6a,$6a,$5a,$6a,$6a,$56,$aa
	defb $56,$6a,$6a,$5a,$6a,$6a,$6a,$aa
	defb $96,$6a,$6a,$66,$66,$66,$9a,$aa
	defb $66,$66,$66,$56,$66,$66,$66,$aa
	defb $56,$9a,$9a,$9a,$9a,$9a,$56,$aa
	defb $66,$56,$5a,$6a,$5a,$56,$66,$aa
	defb $66,$56,$56,$56,$66,$66,$66,$aa
	defb $5a,$66,$66,$66,$66,$66,$66,$aa
	defb $9a,$66,$66,$66,$66,$66,$9a,$aa
	defb $5a,$66,$66,$66,$5a,$6a,$6a,$aa
	defb $5a,$66,$66,$66,$5a,$66,$66,$aa
	defb $9a,$66,$6a,$9a,$a6,$66,$9a,$aa
	defb $56,$9a,$9a,$9a,$9a,$9a,$9a,$aa
	defb $66,$66,$66,$66,$66,$66,$56,$aa
	defb $66,$66,$66,$66,$66,$9a,$9a,$aa
	defb $66,$66,$66,$9a,$9a,$9a,$9a,$aa
	; logo
	defb $0a,$0a,$0a,$0a,$aa,$aa,$aa,$aa
	defb $aa,$aa,$aa,$aa,$0a,$0a,$0a,$0a
	defb $0a,$0a,$0a,$0a,$0a,$0a,$0a,$0a
	defb $a0,$a0,$a0,$a0,$aa,$aa,$aa,$aa
	defb $00,$00,$00,$00,$aa,$aa,$aa,$aa
	defb $a0,$a0,$a0,$a0,$0a,$0a,$0a,$0a
	defb $00,$00,$00,$00,$0a,$0a,$0a,$0a
	defb $aa,$aa,$aa,$aa,$a0,$a0,$a0,$a0
	defb $0a,$0a,$0a,$0a,$a0,$a0,$a0,$a0
	defb $aa,$aa,$aa,$aa,$00,$00,$00,$00
	defb $0a,$0a,$0a,$0a,$00,$00,$00,$00
	defb $a0,$a0,$a0,$a0,$a0,$a0,$a0,$a0
	defb $00,$00,$00,$00,$a0,$a0,$a0,$a0
	defb $a0,$a0,$a0,$a0,$00,$00,$00,$00
	defb $00,$00,$00,$00,$00,$00,$00,$00
;	16dot
	defb	$08, $28, $22, $80, $80, $82, $28, $08
	defb	$08, $08, $22, $82, $82, $28, $08, $20
	defb	$08, $28, $82, $80, $80, $22, $22, $08
	defb	$20, $20, $88, $82, $82, $22, $08, $08
	defb	$aa, $ab, $af, $bf, $df, $d7, $77, $77
	defb	$fa, $fa, $fe, $fe, $ff, $ff, $ff, $ff
	defb	$dd, $dd, $f5, $f5, $bd, $bd, $ad, $ad
	defb	$fd, $f5, $d7, $5f, $7f, $fe, $fa, $ea
	defb	$ff, $ea, $ea, $ea, $ea, $ea, $ea, $ea
	defb	$ff, $ab, $a7, $a7, $97, $9b, $5b, $5b
	defb	$e9, $d9, $d5, $e5, $d5, $d6, $ea, $ff
	defb	$6b, $6b, $ab, $ab, $6b, $6b, $ab, $ff
;	sprite
	defb	$aa, $a8, $a0, $aa, $a2, $a2, $a0, $aa
	defb	$aa, $2a, $0a, $8a, $0a, $0a, $0a, $aa
	defb	$ae, $ae, $ae, $ae, $ae, $aa, $a2, $82
	defb	$2a, $2a, $aa, $2a, $8a, $8a, $a2, $82
	defb	$aa, $a8, $a0, $aa, $a2, $a2, $a0, $aa
	defb	$aa, $2a, $0a, $8a, $0a, $0a, $0a, $aa
	defb	$ab, $9b, $ab, $ab, $ab, $aa, $aa, $a8
	defb	$ea, $ea, $ea, $ea, $ea, $aa, $2a, $2a
	defb	$aa, $a0, $80, $aa, $88, $88, $80, $aa
	defb	$aa, $aa, $2a, $2a, $2a, $2a, $2a, $aa
	defb	$a3, $23, $23, $a3, $ab, $a2, $a2, $82
	defb	$ea, $ea, $ea, $ea, $ea, $0a, $8a, $8a
	defb	$aa, $aa, $aa, $aa, $aa, $aa, $aa, $aa
	defb	$aa, $aa, $aa, $aa, $aa, $aa, $aa, $aa
	defb	$aa, $a5, $a9, $aa, $aa, $aa, $aa, $aa
	defb	$a9, $55, $55, $a9, $aa, $aa, $aa, $aa
	defb	$aa, $a8, $a0, $a2, $a0, $a0, $a0, $aa
	defb	$aa, $2a, $0a, $aa, $8a, $8a, $0a, $aa
	defb	$a8, $a8, $aa, $aa, $a2, $a2, $8a, $82
	defb	$a6, $05, $05, $a6, $aa, $aa, $8a, $82
	defb	$aa, $a8, $a0, $a2, $a0, $a0, $a0, $aa
	defb	$aa, $2a, $0a, $aa, $8a, $8a, $0a, $aa
	defb	$a0, $84, $85, $85, $a6, $a8, $a8, $a8
	defb	$2e, $2e, $6e, $2e, $ae, $aa, $aa, $2a
	defb	$aa, $aa, $a8, $a8, $a8, $a8, $a8, $aa
	defb	$aa, $0a, $02, $aa, $22, $22, $02, $aa
	defb	$a8, $a8, $a8, $aa, $a8, $a0, $a2, $a2
	defb	$8a, $80, $20, $aa, $aa, $8a, $8a, $82
	defb	$aa, $aa, $aa, $aa, $aa, $aa, $aa, $aa
	defb	$aa, $aa, $aa, $aa, $aa, $aa, $aa, $aa
	defb	$6a, $55, $55, $6a, $aa, $aa, $aa, $aa
	defb	$aa, $5a, $6a, $aa, $aa, $aa, $aa, $aa
	defb	$aa, $a0, $80, $80, $80, $80, $80, $aa
	defb	$aa, $2a, $0a, $0a, $0a, $0a, $0a, $aa
	defb	$a0, $c0, $c0, $ea, $e2, $e2, $a2, $a2
	defb	$2a, $0a, $0a, $8a, $16, $1a, $1a, $9a
	defb	$aa, $a0, $80, $80, $80, $80, $80, $aa
	defb	$aa, $2a, $0a, $0a, $0a, $0a, $0a, $aa
	defb	$a0, $80, $c0, $ca, $f2, $b2, $a2, $aa
	defb	$0a, $02, $21, $a6, $2a, $2a, $2a, $2a
	defb	$aa, $aa, $aa, $a0, $80, $80, $80, $80
	defb	$8a, $8a, $8a, $2a, $0a, $0a, $0a, $0a
	defb	$80, $aa, $a0, $80, $ca, $c2, $f2, $b2
	defb	$0a, $aa, $2a, $2a, $aa, $2a, $2a, $2a
	defb	$aa, $aa, $aa, $aa, $aa, $aa, $aa, $aa
	defb	$aa, $aa, $aa, $aa, $9a, $9a, $9a, $9a
	defb	$aa, $aa, $aa, $aa, $aa, $aa, $aa, $aa
	defb	$9a, $9a, $9a, $9a, $9a, $9a, $56, $8a
	defb	$aa, $a0, $80, $8a, $82, $82, $80, $aa
	defb	$aa, $2a, $0a, $8a, $0a, $0a, $0a, $aa
	defb	$a0, $80, $80, $5a, $92, $92, $92, $a2
	defb	$3e, $3e, $3e, $be, $3e, $2a, $aa, $aa
	defb	$aa, $a0, $80, $8a, $82, $82, $80, $aa
	defb	$aa, $2a, $0a, $8a, $0a, $0a, $0a, $aa
	defb	$a0, $80, $50, $9a, $a2, $a2, $aa, $aa
	defb	$2e, $0e, $0e, $ae, $2e, $2a, $2a, $2a
	defb	$aa, $aa, $aa, $aa, $a0, $80, $80, $8a
	defb	$aa, $aa, $aa, $aa, $2a, $0a, $0a, $8a
	defb	$82, $82, $aa, $a8, $8a, $8a, $82, $a2
	defb	$3e, $3e, $be, $3e, $be, $2a, $0a, $aa
	defb	$a2, $95, $a6, $a6, $a6, $a6, $a6, $a6
	defb	$aa, $aa, $aa, $aa, $aa, $aa, $aa, $aa
	defb	$a6, $a6, $a6, $a6, $aa, $aa, $aa, $aa
	defb	$aa, $aa, $aa, $aa, $aa, $aa, $aa, $aa
	defb	$aa, $a9, $a5, $a9, $a9, $a5, $a6, $aa
	defb	$aa, $6a, $5a, $9a, $9a, $5a, $6a, $aa
	defb	$aa, $a9, $a9, $aa, $aa, $aa, $a9, $a5
	defb	$6a, $6a, $aa, $aa, $9a, $96, $a6, $a6
	defb	$aa, $a9, $a5, $a9, $a9, $a5, $a6, $aa
	defb	$aa, $6a, $5a, $9a, $9a, $5a, $6a, $aa
	defb	$a9, $9a, $99, $aa, $aa, $aa, $aa, $a9
	defb	$9a, $a6, $66, $aa, $6a, $6a, $6a, $6a
	defb	$aa, $a9, $a5, $a6, $a6, $a5, $a9, $aa
	defb	$aa, $6a, $5a, $6a, $6a, $5a, $9a, $aa
	defb	$a9, $a9, $aa, $aa, $a6, $96, $9a, $9a
	defb	$aa, $6a, $6a, $aa, $aa, $aa, $6a, $5a
	defb	$aa, $a9, $a5, $a6, $a6, $a5, $a9, $aa
	defb	$aa, $6a, $5a, $6a, $6a, $5a, $9a, $aa
	defb	$a6, $9a, $99, $aa, $a9, $a9, $a9, $a9
	defb	$6a, $a6, $66, $aa, $aa, $aa, $aa, $6a
	defb	$aa, $a5, $95, $95, $95, $95, $a5, $aa
	defb	$aa, $6a, $5a, $5a, $5a, $5a, $6a, $aa
	defb	$99, $99, $a9, $aa, $a6, $a6, $a6, $a6
	defb	$9a, $96, $a6, $aa, $6a, $6a, $6a, $aa
	defb	$aa, $a5, $95, $95, $95, $95, $a5, $aa
	defb	$aa, $6a, $5a, $5a, $5a, $5a, $6a, $aa
	defb	$99, $59, $69, $aa, $a6, $a6, $a6, $aa
	defb	$9a, $9a, $aa, $aa, $6a, $6a, $6a, $6a
	defb	$aa, $a5, $95, $99, $99, $95, $a6, $aa
	defb	$aa, $6a, $5a, $9a, $9a, $5a, $6a, $aa
	defb	$9a, $9a, $9a, $aa, $a6, $a6, $a6, $a6
	defb	$9a, $5a, $6a, $aa, $6a, $6a, $6a, $aa
	defb	$aa, $a5, $95, $99, $99, $95, $a5, $aa
	defb	$aa, $6a, $5a, $9a, $9a, $5a, $6a, $aa
	defb	$9a, $96, $a6, $aa, $a6, $a6, $a6, $aa
	defb	$9a, $9a, $9a, $aa, $6a, $6a, $6a, $6a
	defb	$99, $55, $59, $95, $55, $56, $65, $55
	defb	$66, $95, $59, $55, $55, $56, $65, $55
	defb	$95, $59, $55, $56, $65, $55, $55, $99
	defb	$55, $96, $55, $59, $95, $56, $59, $66
	defb	$aa, $aa, $aa, $88, $88, $08, $08, $8a
	defb	$aa, $aa, $2a, $8a, $8a, $8a, $8a, $2a
	defb	$8a, $8a, $8a, $8a, $02, $aa, $aa, $aa
	defb	$a2, $88, $88, $88, $88, $a2, $aa, $aa
	defb	$aa, $aa, $aa, $88, $00, $20, $a0, $a2
	defb	$aa, $aa, $2a, $8a, $8a, $8a, $8a, $2a
	defb	$82, $8a, $0a, $2a, $02, $aa, $aa, $aa
	defb	$a2, $88, $88, $88, $88, $a2, $aa, $aa
	defb	$aa, $aa, $aa, $a0, $a0, $a0, $20, $22
	defb	$aa, $aa, $2a, $8a, $8a, $8a, $8a, $2a
	defb	$22, $02, $02, $a2, $a2, $aa, $aa, $aa
	defb	$a2, $88, $88, $88, $88, $a2, $aa, $aa
	defb	$aa, $aa, $aa, $88, $00, $20, $20, $8a
	defb	$aa, $aa, $2a, $8a, $8a, $8a, $8a, $2a
	defb	$8a, $22, $22, $22, $8a, $aa, $aa, $aa
	defb	$a2, $88, $88, $88, $88, $a2, $aa, $aa
	defb	$aa, $80, $80, $11, $11, $11, $11, $11
	defb	$aa, $02, $02, $00, $00, $fc, $fc, $cc
	defb	$11, $15, $15, $00, $00, $80, $80, $aa
	defb	$cc, $fc, $fc, $c0, $c0, $02, $02, $aa
