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
	defb	$aa, $a6, $55, $a6, $aa, $9a, $55, $9a
	defb	$a6, $a6, $95, $a6, $9a, $56, $9a, $9a
;	point
	defb	$aa, $a6, $a6, $a6, $a6, $a6, $aa, $aa
	defb	$aa, $56, $a6, $56, $6a, $56, $aa, $aa
	defb	$aa, $66, $66, $56, $a6, $a6, $aa, $aa
	defb	$aa, $56, $66, $56, $66, $56, $aa, $aa
	defb	$aa, $56, $66, $66, $66, $56, $aa, $aa
;	8dot
	defb	$a5, $a5, $a9, $99, $aa, $aa, $6a, $9a
	defb	$a9, $a6, $a6, $a6, $aa, $aa, $6a, $6a
	defb	$a5, $a5, $a9, $99, $aa, $aa, $6a, $9a
	defb	$69, $a6, $a6, $a6, $aa, $aa, $5a, $aa
	defb	$a5, $a5, $a9, $a9, $aa, $aa, $aa, $aa
	defb	$a6, $a9, $a9, $aa, $aa, $aa, $aa, $6a
	defb	$a5, $a5, $a9, $a5, $aa, $aa, $aa, $9a
	defb	$99, $aa, $a6, $a6, $aa, $6a, $96, $aa
	defb	$aa, $aa, $a9, $a6, $5a, $5a, $6a, $66
	defb	$aa, $aa, $a9, $a9, $6a, $9a, $9a, $9a
	defb	$aa, $aa, $a9, $a6, $5a, $5a, $6a, $66
	defb	$aa, $aa, $a5, $aa, $69, $9a, $9a, $9a
	defb	$aa, $aa, $aa, $aa, $5a, $5a, $6a, $6a
	defb	$aa, $aa, $aa, $a9, $9a, $6a, $6a, $aa
	defb	$aa, $aa, $aa, $a6, $5a, $5a, $6a, $5a
	defb	$aa, $a9, $96, $aa, $66, $aa, $9a, $9a
	defb	$aa, $a9, $5a, $55, $aa, $aa, $95, $6a
	defb	$a6, $a9, $aa, $aa, $a5, $aa, $aa, $aa
	defb	$aa, $a9, $5a, $55, $6a, $aa, $95, $6a
	defb	$a6, $a9, $aa, $aa, $a6, $a6, $aa, $aa
	defb	$aa, $aa, $5a, $55, $aa, $aa, $6a, $96
	defb	$aa, $aa, $aa, $aa, $a9, $aa, $aa, $aa
	defb	$aa, $aa, $59, $55, $aa, $6a, $a5, $6a
	defb	$aa, $a9, $aa, $aa, $9a, $a6, $a6, $aa
	defb	$aa, $aa, $a9, $a6, $aa, $aa, $aa, $a5
	defb	$55, $5a, $a9, $aa, $6a, $95, $aa, $aa
	defb	$aa, $aa, $a9, $a6, $aa, $aa, $a6, $a6
	defb	$55, $5a, $a9, $aa, $6a, $95, $aa, $6a
	defb	$aa, $aa, $aa, $aa, $aa, $aa, $aa, $a9
	defb	$55, $5a, $aa, $aa, $96, $6a, $aa, $aa
	defb	$aa, $aa, $a9, $aa, $aa, $a6, $a6, $9a
	defb	$55, $59, $aa, $aa, $6a, $a5, $6a, $aa
	defb	$a9, $a9, $aa, $aa, $9a, $9a, $9a, $6a
	defb	$a6, $a9, $aa, $aa, $66, $6a, $5a, $5a
	defb	$aa, $aa, $56, $a9, $aa, $6a, $a5, $55
	defb	$5a, $aa, $aa, $aa, $9a, $6a, $aa, $aa
	defb	$a6, $99, $99, $a6, $a6, $99, $99, $e6
	defb	$ab, $af, $bf, $ba, $fa, $fe, $ff, $eb
	defb	$ab, $af, $bc, $bc, $fa, $fe, $cf, $cf
	defb	$af, $af, $bf, $ba, $fe, $fe, $ff, $eb
	defb	$55, $6a, $6a, $6a, $55, $a9, $a9, $59
	defb	$66, $66, $6a, $55, $59, $59, $a9, $55
	defb	$aa, $aa, $a9, $59, $aa, $a5, $65, $65
	defb	$59, $5a, $a9, $55, $6a, $a5, $55, $55
	defb	$95, $95, $95, $95, $56, $56, $56, $66
	defb	$95, $95, $95, $95, $66, $56, $56, $56
