cseg

AsciiPattern: public AsciiPattern
	; ascii 29
	; " 0123456789ACEFGHIKMNOPRSTUVY"
	defb $aa,$aa,$aa,$aa,$aa,$aa,$aa,$aa
	defb $56,$66,$66,$66,$56,$aa,$aa,$aa
	defb $a6,$a6,$a6,$a6,$a6,$aa,$aa,$aa
	defb $56,$a6,$56,$6a,$56,$aa,$aa,$aa
	defb $56,$a6,$56,$a6,$56,$aa,$aa,$aa
	defb $66,$66,$56,$a6,$a6,$aa,$aa,$aa
	defb $56,$6a,$56,$a6,$56,$aa,$aa,$aa
	defb $56,$6a,$56,$66,$56,$aa,$aa,$aa
	defb $56,$a6,$9a,$9a,$9a,$aa,$aa,$aa
	defb $56,$66,$56,$66,$56,$aa,$aa,$aa
	defb $56,$66,$56,$a6,$56,$aa,$aa,$aa
	defb $9a,$66,$66,$56,$66,$aa,$aa,$aa
	defb $9a,$66,$6a,$66,$9a,$aa,$aa,$aa
	defb $56,$6a,$5a,$6a,$56,$aa,$aa,$aa
	defb $56,$6a,$5a,$6a,$6a,$aa,$aa,$aa
	defb $96,$6a,$66,$66,$9a,$aa,$aa,$aa
	defb $66,$66,$56,$66,$66,$aa,$aa,$aa
	defb $56,$9a,$9a,$9a,$56,$aa,$aa,$aa
	defb $66,$66,$5a,$66,$66,$aa,$aa,$aa
	defb $66,$56,$56,$66,$66,$aa,$aa,$aa
	defb $5a,$66,$66,$66,$66,$aa,$aa,$aa
	defb $9a,$66,$66,$66,$9a,$aa,$aa,$aa
	defb $5a,$66,$5a,$6a,$6a,$aa,$aa,$aa
	defb $5a,$66,$5a,$66,$66,$aa,$aa,$aa
	defb $96,$6a,$56,$a6,$5a,$aa,$aa,$aa
	defb $56,$9a,$9a,$9a,$9a,$aa,$aa,$aa
	defb $66,$66,$66,$66,$56,$aa,$aa,$aa
	defb $66,$66,$66,$66,$9a,$aa,$aa,$aa
	defb $66,$66,$9a,$9a,$9a,$aa,$aa,$aa

CharPattern: public CharPattern
;	logo
	defb	$aa, $aa, $aa, $aa, $0a, $0a, $aa, $aa
	defb	$aa, $aa, $0a, $0a, $0a, $0a, $0a, $0a
	defb	$a0, $a0, $aa, $aa, $00, $00, $aa, $aa
	defb	$a0, $a0, $0a, $0a, $00, $00, $0a, $0a
	defb	$aa, $aa, $a0, $a0, $0a, $0a, $a0, $a0
	defb	$aa, $aa, $00, $00, $0a, $0a, $00, $00
	defb	$a0, $a0, $a0, $a0, $00, $00, $a0, $a0
	defb	$a0, $a0, $00, $00, $00, $00, $00, $00
;	8dot
	defb	$08, $22, $80, $22, $08, $22, $82, $28
	defb	$28, $82, $80, $22, $20, $88, $82, $28
	defb	$aa, $af, $f7, $7d, $fa, $fe, $ff, $ff
	defb	$dd, $f5, $bd, $ad, $f5, $5f, $ff, $fa
	defb	$ff, $ea, $ea, $c9, $ff, $97, $57, $5b
	defb	$e1, $c0, $e2, $ff, $6b, $ab, $2b, $ff
;	sprite
	defb	$a0, $aa, $a2, $aa, $0a, $8a, $0a, $aa
	defb	$ae, $ac, $aa, $82, $2a, $aa, $82, $a2
	defb	$a0, $aa, $a2, $aa, $0a, $8a, $0a, $aa
	defb	$ab, $8b, $aa, $a8, $ea, $ea, $aa, $2a
	defb	$80, $aa, $88, $aa, $2a, $2a, $2a, $aa
	defb	$23, $a3, $aa, $82, $ea, $ea, $0a, $8a
	defb	$aa, $aa, $aa, $aa, $aa, $aa, $aa, $aa
	defb	$a5, $a9, $aa, $aa, $55, $55, $aa, $aa
	defb	$a0, $a2, $a0, $aa, $0a, $aa, $8a, $aa
	defb	$a8, $aa, $82, $8a, $aa, $06, $aa, $82
	defb	$a0, $a2, $a0, $aa, $0a, $aa, $8a, $aa
	defb	$a2, $a8, $aa, $a8, $ae, $6e, $aa, $2a
	defb	$a8, $a8, $a8, $aa, $02, $aa, $22, $aa
	defb	$aa, $aa, $a0, $a2, $80, $aa, $aa, $82
	defb	$aa, $aa, $aa, $aa, $aa, $aa, $aa, $aa
	defb	$55, $55, $aa, $aa, $5a, $6a, $aa, $aa
	defb	$a0, $a0, $a0, $aa, $0a, $0a, $0a, $aa
	defb	$c8, $e8, $a2, $a2, $22, $22, $8a, $aa
	defb	$a0, $a0, $a0, $aa, $0a, $0a, $0a, $aa
	defb	$88, $b8, $a2, $aa, $22, $2a, $8a, $8a
	defb	$a0, $a0, $a0, $aa, $0a, $0a, $0a, $aa
	defb	$88, $b8, $a2, $a2, $2a, $2a, $8a, $8a
	defb	$aa, $aa, $aa, $aa, $aa, $aa, $6a, $5a
	defb	$aa, $aa, $aa, $aa, $5a, $5a, $5a, $5a
	defb	$a0, $aa, $a2, $aa, $0a, $8a, $0a, $aa
	defb	$88, $88, $92, $a2, $3e, $3e, $8a, $aa
	defb	$a0, $a2, $a0, $aa, $0a, $aa, $8a, $aa
	defb	$88, $98, $a2, $aa, $23, $2b, $8a, $8a
	defb	$aa, $aa, $a0, $aa, $aa, $aa, $0a, $8a
	defb	$a2, $8a, $8a, $a2, $22, $a3, $ab, $8a
	defb	$a5, $a5, $a5, $a5, $aa, $aa, $aa, $aa
	defb	$a5, $a9, $aa, $aa, $aa, $aa, $aa, $aa
	defb	$a5, $a9, $a5, $a6, $5a, $9a, $5a, $6a
	defb	$aa, $a9, $aa, $96, $aa, $aa, $96, $a6
	defb	$a5, $a9, $a5, $a6, $5a, $9a, $5a, $6a
	defb	$aa, $9a, $aa, $a9, $aa, $a6, $6a, $6a
	defb	$a5, $a6, $a5, $a9, $5a, $6a, $5a, $9a
	defb	$aa, $aa, $96, $9a, $aa, $6a, $aa, $96
	defb	$a5, $a6, $a5, $a9, $5a, $6a, $5a, $9a
	defb	$aa, $9a, $a9, $a9, $aa, $a6, $aa, $6a
	defb	$a5, $a5, $a5, $9a, $5a, $5a, $5a, $a6
	defb	$aa, $aa, $a6, $a6, $a6, $aa, $9a, $aa
	defb	$a5, $a5, $a5, $9a, $5a, $5a, $5a, $a6
	defb	$9a, $aa, $a6, $aa, $aa, $aa, $9a, $9a
	defb	$a5, $a9, $a5, $a6, $5a, $9a, $5a, $66
	defb	$aa, $aa, $a6, $a6, $a6, $aa, $9a, $aa
	defb	$a5, $a6, $a5, $99, $5a, $6a, $5a, $9a
	defb	$9a, $aa, $a6, $aa, $aa, $aa, $9a, $9a
	defb	$99, $55, $59, $95, $96, $65, $56, $95
	defb	$55, $96, $55, $99, $65, $56, $59, $66
	defb	$aa, $9a, $58, $98, $aa, $2a, $8a, $8a
	defb	$9a, $56, $aa, $aa, $22, $88, $88, $a2
	defb	$aa, $9a, $64, $a4, $aa, $2a, $8a, $8a
	defb	$9a, $56, $aa, $aa, $22, $88, $88, $a2
	defb	$aa, $a6, $64, $64, $aa, $2a, $8a, $8a
	defb	$56, $a6, $aa, $aa, $22, $88, $88, $a2
	defb	$aa, $9a, $64, $98, $aa, $2a, $8a, $8a
	defb	$66, $9a, $aa, $aa, $22, $88, $88, $a2
	defb	$80, $33, $33, $33, $02, $00, $54, $44
	defb	$3f, $00, $80, $aa, $54, $40, $02, $aa
