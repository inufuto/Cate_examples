cseg
AsciiPattern: public AsciiPattern
;	ascii
	defb $00,$00,$00,$00,$04,$04,$04,$00
	defb $1f,$11,$1f,$00,$00,$00,$1f,$00
	defb $1d,$15,$17,$00,$15,$15,$1f,$00
	defb $07,$04,$1f,$00,$17,$15,$1d,$00
	defb $1f,$15,$1d,$00,$01,$1d,$03,$00
	defb $1f,$15,$1f,$00,$17,$15,$1f,$00
	defb $1e,$09,$1e,$00,$1f,$15,$0a,$00
	defb $0e,$11,$0a,$00,$1f,$11,$0e,$00
	defb $1f,$15,$11,$00,$1f,$05,$01,$00
	defb $0e,$11,$0d,$00,$1f,$04,$1f,$00
	defb $11,$1f,$11,$00,$08,$11,$0f,$00
	defb $1f,$04,$1b,$00,$1f,$10,$10,$00
	defb $1f,$06,$1f,$00,$1f,$01,$1e,$00
	defb $0e,$11,$0e,$00,$1f,$05,$07,$00
	defb $0e,$19,$16,$00,$1f,$05,$1a,$00
	defb $16,$15,$0d,$00,$01,$1f,$01,$00
	defb $1f,$10,$1f,$00,$0f,$10,$0f,$00
	defb $1f,$0c,$1f,$00,$1b,$04,$1b,$00
	defb $03,$1c,$03,$00,$19,$15,$13,$00

CharPattern: public CharPattern
;	logo
	defb	$00, $00, $33, $00, $cc, $00, $ff, $00
	defb	$30, $03, $33, $03, $fc, $03, $ff, $03
	defb	$c0, $0c, $f3, $0c, $cc, $0c, $ff, $0c
	defb	$f0, $0f, $f3, $0f, $fc, $0f, $ff, $0f
;	wall
	defb	$00, $00, $0f, $00, $00, $0f, $0f, $0f
	defb	$11, $01, $1e, $01, $11, $0e, $1e, $0e
	defb	$88, $08, $87, $08, $88, $07, $87, $07
	defb	$99, $09, $96, $09, $99, $06, $96, $06
	defb	$0f, $00
;	8dot
	defb	$64, $0e, $f7, $05, $90, $09, $a5, $00
	defb	$64, $0e, $f7, $05, $30, $01, $29, $04
	defb	$f5, $07, $6e, $04, $a0, $05, $99, $00
	defb	$f5, $07, $6e, $04, $24, $09, $31, $00
	defb	$54, $0f, $4e, $04, $10, $0c, $34, $00
	defb	$54, $0f, $4e, $04, $30, $04, $1c, $00
	defb	$44, $0e, $d7, $04, $10, $0d, $25, $00
	defb	$c4, $06, $5f, $04, $20, $05, $1d, $00
	defb	$a8, $0f, $eb, $08, $10, $03, $bf, $00
	defb	$40, $0e, $c6, $00, $32, $07, $ff, $02
	defb	$e8, $0b, $af, $08, $b0, $0f, $13, $00
	defb	$c0, $06, $4e, $00, $f2, $0f, $37, $02
	defb	$e8, $0f, $ef, $08, $30, $07, $3f, $00
	defb	$c0, $0e, $ce, $00, $71, $0f, $7f, $01
	defb	$e8, $0b, $af, $08, $30, $0f, $37, $00
	defb	$40, $0e, $c6, $00, $71, $0f, $7f, $01
	defb	$00, $08, $4c, $00, $30, $04, $36, $00
	defb	$00, $08, $86, $00, $70, $08, $8a, $07
	defb	$00, $08, $08, $00, $00, $01, $01, $00
	defb	$56, $07, $73, $06, $d4, $0d, $dd, $04
	defb	$e4, $00, $60, $06, $32, $02, $30, $03
	defb	$aa, $0e, $60, $06, $23, $02, $30, $03
	defb	$8e, $0e, $60, $06, $00, $03, $30, $03
	defb	$ae, $0e, $60, $06, $23, $03, $30, $03
