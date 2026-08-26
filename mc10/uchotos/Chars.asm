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
;	4dot
	defb	$9a, $95, $9a, $95, $a6, $56, $a6, $56
	defb	$ff, $ff, $ff, $aa
;	8dot
	defb	$a9, $a9, $55, $95, $aa, $aa, $56, $5a
	defb	$a5, $a6, $9a, $aa, $6a, $6a, $9a, $aa
;	sprite
	defb	$a5, $a9, $a5, $99, $5a, $9a, $5a, $66
	defb	$99, $a9, $a6, $a6, $66, $6a, $9a, $9a
	defb	$a5, $a9, $a5, $a9, $5a, $9a, $5a, $5a
	defb	$99, $a9, $a6, $9a, $66, $6a, $96, $aa
	defb	$a5, $a9, $a5, $aa, $5a, $9a, $5a, $6a
	defb	$a9, $aa, $a9, $a9, $6a, $aa, $9a, $9a
	defb	$a5, $a9, $a5, $a9, $5a, $9a, $5a, $6a
	defb	$96, $a9, $a6, $a6, $66, $6a, $96, $aa
	defb	$a5, $a6, $a5, $99, $5a, $6a, $5a, $66
	defb	$99, $a9, $a6, $a6, $66, $6a, $9a, $9a
	defb	$a5, $a6, $a5, $a5, $5a, $6a, $5a, $6a
	defb	$99, $a9, $96, $aa, $66, $6a, $9a, $a6
	defb	$a5, $a6, $a5, $a9, $5a, $6a, $5a, $aa
	defb	$a9, $aa, $a6, $a6, $6a, $aa, $6a, $6a
	defb	$a5, $a6, $a5, $a9, $5a, $6a, $5a, $6a
	defb	$99, $a9, $96, $aa, $96, $6a, $9a, $9a
	defb	$a5, $a5, $aa, $99, $5a, $5a, $a6, $5a
	defb	$a5, $a9, $a6, $aa, $6a, $6a, $9a, $9a
	defb	$a5, $a5, $9a, $a5, $5a, $5a, $aa, $66
	defb	$a9, $a9, $a6, $a6, $5a, $6a, $9a, $aa
	defb	$a0, $80, $22, $22, $2a, $0a, $02, $00
	defb	$80, $aa, $88, $a2, $02, $aa, $8a, $22
	defb	$aa, $a0, $80, $22, $aa, $2a, $0a, $02
	defb	$22, $80, $aa, $88, $00, $02, $aa, $8a
	defb	$a8, $a0, $80, $00, $0a, $02, $88, $88
	defb	$80, $aa, $a2, $88, $02, $aa, $22, $8a
	defb	$aa, $a8, $a0, $80, $aa, $0a, $02, $88
	defb	$00, $80, $aa, $a2, $88, $02, $aa, $22
	defb	$a2, $88, $aa, $80, $22, $8a, $aa, $02
	defb	$08, $02, $88, $a0, $20, $80, $22, $0a
	defb	$aa, $aa, $ab, $ad, $aa, $aa, $fa, $ea
	defb	$b7, $b5, $af, $aa, $7a, $ea, $aa, $aa
	defb	$80, $33, $33, $33, $02, $00, $54, $44
	defb	$3f, $00, $80, $aa, $54, $40, $02, $aa
