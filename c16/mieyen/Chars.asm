cseg

MonoPattern: public MonoPattern
;	ascii
	defb	$00, $00, $00, $00, $44, $44, $04, $40
	defb	$aa, $00, $00, $00, $44, $e4, $e4, $40
	defb	$4e, $ce, $6e, $40, $8a, $24, $8a, $20
	defb	$4a, $48, $aa, $40, $44, $40, $00, $00
	defb	$48, $88, $88, $40, $42, $22, $22, $40
	defb	$0a, $a4, $aa, $00, $04, $4e, $44, $00
	defb	$00, $00, $44, $80, $00, $0e, $00, $00
	defb	$00, $00, $04, $40, $02, $24, $88, $00
	defb	$4a, $aa, $aa, $40, $44, $44, $44, $40
	defb	$4a, $22, $48, $e0, $4a, $24, $2a, $40
	defb	$2a, $ae, $22, $20, $e8, $8c, $22, $c0
	defb	$4a, $8c, $aa, $40, $ea, $22, $44, $40
	defb	$4a, $a4, $aa, $40, $4a, $a6, $2a, $40
	defb	$04, $40, $44, $00, $04, $40, $44, $80
	defb	$02, $48, $42, $00, $00, $e0, $e0, $00
	defb	$08, $42, $48, $00, $4a, $24, $40, $40
	defb	$4a, $aa, $88, $60, $4a, $aa, $ea, $a0
	defb	$ca, $ac, $aa, $c0, $4a, $88, $8a, $40
	defb	$ca, $aa, $aa, $c0, $e8, $8c, $88, $e0
	defb	$e8, $8c, $88, $80, $68, $8a, $aa, $40
	defb	$aa, $ae, $aa, $a0, $e4, $44, $44, $e0
	defb	$62, $22, $2a, $40, $ae, $c8, $ce, $a0
	defb	$88, $88, $88, $e0, $ae, $ee, $aa, $a0
	defb	$ca, $aa, $aa, $a0, $4a, $aa, $aa, $40
	defb	$ca, $aa, $c8, $80, $4a, $aa, $ac, $60
	defb	$ca, $aa, $ca, $a0, $4a, $84, $2a, $40
	defb	$e4, $44, $44, $40, $aa, $aa, $aa, $e0
	defb	$aa, $aa, $a4, $40, $aa, $ae, $ee, $a0
	defb	$aa, $44, $4a, $a0, $aa, $a4, $44, $40
	defb	$e2, $24, $88, $e0, $64, $44, $44, $60
	defb	$08, $84, $22, $00, $c4, $44, $44, $c0
	defb	$4a, $00, $00, $00, $00, $00, $00, $e0
;	logo
	defb	$00, $00, $00, $00, $cc, $cc, $00, $00
	defb	$00, $00, $cc, $cc, $cc, $cc, $cc, $cc
	defb	$33, $33, $00, $00, $ff, $ff, $00, $00
	defb	$33, $33, $cc, $cc, $ff, $ff, $cc, $cc
	defb	$00, $00, $33, $33, $cc, $cc, $33, $33
	defb	$00, $00, $ff, $ff, $cc, $cc, $ff, $ff
	defb	$33, $33, $33, $33, $ff, $ff, $33, $33
	defb	$33, $33, $ff, $ff, $ff, $ff, $ff, $ff
;	wall
	defb	$00, $00, $00, $00, $88, $88, $88, $88
	defb	$11, $11, $11, $11, $99, $99, $99, $99
	defb	$ff, $00, $00, $00, $77, $88, $88, $88
	defb	$ee, $11, $11, $11, $66, $99, $99, $99
	defb	$00, $00, $00, $ff, $88, $88, $88, $77
	defb	$11, $11, $11, $ee, $99, $99, $99, $66
	defb	$ff, $00, $00, $ff, $77, $88, $88, $77
	defb	$ee, $11, $11, $ee, $66, $99, $99, $66
;	dot
	defb	$00, $00, $00, $11, $00, $00, $00, $88
	defb	$11, $00, $00, $00, $88, $00, $00, $00

ColorPattern: public ColorPattern
;	color16
	defb	$00, $01, $09, $16, $05, $0f, $07, $07
	defb	$50, $50, $44, $80, $50, $d4, $70, $70
	defb	$0f, $05, $05, $04, $04, $0c, $0c, $3c
	defb	$c0, $50, $10, $d0, $c0, $00, $30, $f0
	defb	$00, $01, $09, $16, $05, $0f, $07, $07
	defb	$50, $50, $44, $80, $50, $d4, $70, $70
	defb	$0f, $05, $35, $35, $05, $0c, $0c, $03
	defb	$c0, $50, $54, $4c, $4c, $c0, $c0, $c0
	defb	$05, $05, $11, $02, $05, $17, $0d, $0d
	defb	$00, $40, $60, $94, $50, $f0, $d0, $d0
	defb	$03, $05, $04, $07, $03, $00, $0c, $0f
	defb	$f0, $50, $50, $10, $10, $30, $30, $3c
	defb	$05, $05, $11, $02, $05, $17, $0d, $0d
	defb	$00, $40, $60, $94, $50, $f0, $d0, $d0
	defb	$03, $05, $15, $31, $31, $03, $03, $03
	defb	$f0, $50, $5c, $5c, $50, $30, $30, $c0
	defb	$15, $05, $05, $05, $19, $56, $55, $15
	defb	$00, $40, $40, $40, $90, $54, $54, $50
	defb	$05, $15, $15, $05, $05, $0c, $0c, $0c
	defb	$40, $50, $50, $70, $40, $c0, $c0, $00
	defb	$15, $05, $05, $05, $19, $56, $55, $15
	defb	$00, $40, $40, $40, $90, $54, $54, $50
	defb	$05, $15, $15, $35, $05, $0c, $0c, $00
	defb	$40, $50, $50, $40, $40, $c0, $c0, $c0
	defb	$01, $05, $0a, $05, $15, $5f, $37, $37
	defb	$50, $40, $80, $40, $50, $d4, $70, $70
	defb	$0f, $05, $35, $35, $05, $0c, $0c, $0c
	defb	$c0, $50, $d0, $c0, $40, $c0, $c0, $00
	defb	$01, $05, $0a, $05, $15, $5f, $37, $37
	defb	$50, $40, $80, $40, $50, $d4, $70, $70
	defb	$0f, $15, $1d, $0d, $05, $0c, $0c, $00
	defb	$c0, $40, $70, $70, $40, $c0, $c0, $c0
	defb	$0c, $0c, $3f, $3f, $1d, $1d, $ff, $ff
	defb	$c0, $c0, $f0, $f0, $f0, $f0, $fc, $fc
	defb	$3f, $3f, $0f, $0f, $0f, $03, $03, $00
	defb	$f0, $f0, $f0, $f0, $c0, $c0, $f0, $f0
	defb	$00, $0c, $0c, $3f, $3f, $1d, $1d, $3f
	defb	$00, $c0, $c0, $f0, $f0, $f0, $f0, $f0
	defb	$3f, $ff, $ff, $3f, $0f, $0f, $03, $03
	defb	$f0, $fc, $fc, $f0, $f0, $c0, $f0, $f0
	defb	$03, $03, $0f, $0f, $0f, $0f, $3f, $3f
	defb	$30, $30, $fc, $fc, $74, $74, $ff, $ff
	defb	$0f, $0f, $0f, $0f, $03, $03, $0f, $0f
	defb	$fc, $fc, $f0, $f0, $f0, $c0, $c0, $00
	defb	$00, $03, $03, $0f, $0f, $0f, $0f, $0f
	defb	$00, $30, $30, $fc, $fc, $74, $74, $fc
	defb	$0f, $3f, $3f, $0f, $0f, $03, $0f, $0f
	defb	$fc, $ff, $ff, $fc, $f0, $f0, $c0, $c0
	defb	$03, $03, $0f, $0f, $0f, $0f, $3f, $3f
	defb	$30, $30, $fc, $fc, $fc, $fc, $ff, $ff
	defb	$0f, $0f, $0f, $0f, $03, $03, $00, $00
	defb	$fc, $fc, $fc, $fc, $f0, $f0, $c0, $c0
	defb	$00, $00, $03, $03, $0f, $0f, $0f, $0f
	defb	$00, $00, $30, $30, $fc, $fc, $fc, $fc
	defb	$0f, $0f, $3f, $3f, $0f, $0f, $03, $03
	defb	$fc, $fc, $ff, $ff, $fc, $fc, $f0, $f0
	defb	$0c, $0c, $3f, $3f, $37, $37, $ff, $ff
	defb	$c0, $c0, $f0, $f0, $70, $70, $fc, $fc
	defb	$3f, $3f, $3f, $3f, $0f, $0f, $03, $03
	defb	$f0, $f0, $f0, $f0, $c0, $c0, $00, $00
	defb	$00, $00, $0c, $0c, $3f, $3f, $37, $37
	defb	$00, $00, $c0, $c0, $f0, $f0, $70, $70
	defb	$3f, $3f, $ff, $ff, $3f, $3f, $0f, $0f
	defb	$f0, $f0, $fc, $fc, $f0, $f0, $c0, $c0
	defb	$00, $00, $00, $00, $00, $00, $02, $0a
	defb	$00, $00, $00, $00, $00, $a0, $80, $80
	defb	$0b, $2f, $2e, $2f, $0a, $0a, $00, $00
	defb	$80, $80, $e0, $80, $80, $00, $00, $00
	defb	$00, $00, $02, $02, $02, $0a, $0b, $0b
	defb	$00, $00, $00, $00, $00, $80, $80, $80
	defb	$2f, $2e, $2e, $2e, $2f, $0b, $0a, $00
	defb	$e0, $e0, $e0, $e0, $e0, $80, $80, $00
	defb	$00, $0f, $37, $ff, $df, $3f, $00, $11
	defb	$00, $f0, $dc, $ff, $77, $fc, $00, $10
	defb	$04, $00, $2a, $2a, $ff, $ff, $3f, $00
	defb	$44, $00, $a8, $a8, $ff, $ff, $fc, $00
