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
	defb	$00, $0f, $37, $ff, $df, $3f, $00, $11
	defb	$00, $f0, $dc, $ff, $77, $fc, $00, $10
	defb	$04, $00, $2a, $2a, $ff, $ff, $3f, $00
	defb	$44, $00, $a8, $a8, $ff, $ff, $fc, $00

SpritePattern: public SpritePattern
;	sprite
	defb	$00, $50, $01, $50, $0d, $44, $17, $c0
	defb	$05, $50, $0a, $94, $06, $60, $06, $60
	defb	$0a, $80, $05, $50, $05, $10, $04, $90
	defb	$04, $80, $08, $00, $08, $20, $28, $a0
	defb	$00, $50, $01, $50, $0d, $44, $17, $c0
	defb	$05, $50, $0a, $94, $06, $60, $06, $60
	defb	$0a, $80, $05, $50, $25, $54, $25, $48
	defb	$05, $48, $08, $80, $08, $80, $02, $80
	defb	$05, $00, $05, $40, $11, $70, $03, $d4
	defb	$05, $50, $16, $a0, $09, $90, $09, $90
	defb	$02, $a0, $05, $50, $04, $50, $06, $10
	defb	$02, $10, $00, $20, $08, $20, $0a, $28
	defb	$05, $00, $05, $40, $11, $70, $03, $d4
	defb	$05, $50, $16, $a0, $09, $90, $09, $90
	defb	$02, $a0, $05, $50, $15, $58, $21, $58
	defb	$21, $50, $02, $20, $02, $20, $02, $80
	defb	$15, $00, $05, $40, $05, $40, $05, $40
	defb	$1d, $d0, $57, $54, $55, $54, $15, $50
	defb	$05, $40, $15, $50, $15, $50, $05, $60
	defb	$05, $40, $08, $80, $08, $80, $08, $00
	defb	$15, $00, $05, $40, $05, $40, $05, $40
	defb	$1d, $d0, $57, $54, $55, $54, $15, $50
	defb	$05, $40, $15, $50, $15, $50, $25, $40
	defb	$05, $40, $08, $80, $08, $80, $00, $80
	defb	$01, $50, $05, $40, $0f, $c0, $05, $40
	defb	$15, $50, $5a, $94, $26, $60, $26, $60
	defb	$0a, $80, $05, $50, $25, $90, $25, $80
	defb	$05, $40, $08, $80, $08, $80, $08, $00
	defb	$01, $50, $05, $40, $0f, $c0, $05, $40
	defb	$15, $50, $5a, $94, $26, $60, $26, $60
	defb	$0a, $80, $15, $40, $19, $60, $09, $60
	defb	$05, $40, $08, $80, $08, $80, $00, $80
	defb	$08, $80, $08, $80, $2a, $a0, $2a, $a0
	defb	$19, $a0, $19, $a0, $aa, $a8, $aa, $a8
	defb	$2a, $a0, $2a, $a0, $0a, $a0, $0a, $a0
	defb	$0a, $80, $02, $80, $02, $a0, $00, $a0
	defb	$00, $00, $08, $80, $08, $80, $2a, $a0
	defb	$2a, $a0, $19, $a0, $19, $a0, $2a, $a0
	defb	$2a, $a0, $aa, $a8, $aa, $a8, $2a, $a0
	defb	$0a, $a0, $0a, $80, $02, $a0, $02, $a0
	defb	$02, $20, $02, $20, $0a, $a8, $0a, $a8
	defb	$0a, $64, $0a, $64, $2a, $aa, $2a, $aa
	defb	$0a, $a8, $0a, $a8, $0a, $a0, $0a, $a0
	defb	$02, $a0, $02, $80, $0a, $80, $0a, $00
	defb	$00, $00, $02, $20, $02, $20, $0a, $a8
	defb	$0a, $a8, $0a, $64, $0a, $64, $0a, $a8
	defb	$0a, $a8, $2a, $aa, $2a, $aa, $0a, $a8
	defb	$0a, $a0, $02, $a0, $0a, $80, $0a, $80
	defb	$02, $20, $02, $20, $0a, $a8, $0a, $a8
	defb	$0a, $a8, $0a, $a8, $2a, $aa, $2a, $aa
	defb	$0a, $a8, $0a, $a8, $0a, $a8, $0a, $a8
	defb	$02, $a0, $02, $a0, $00, $80, $00, $80
	defb	$00, $00, $00, $00, $02, $20, $02, $20
	defb	$0a, $a8, $0a, $a8, $0a, $a8, $0a, $a8
	defb	$0a, $a8, $0a, $a8, $2a, $aa, $2a, $aa
	defb	$0a, $a8, $0a, $a8, $02, $a0, $02, $a0
	defb	$08, $80, $08, $80, $2a, $a0, $2a, $a0
	defb	$26, $60, $26, $60, $aa, $a8, $aa, $a8
	defb	$2a, $a0, $2a, $a0, $2a, $a0, $2a, $a0
	defb	$0a, $80, $0a, $80, $02, $00, $02, $00
	defb	$00, $00, $00, $00, $08, $80, $08, $80
	defb	$2a, $a0, $2a, $a0, $26, $60, $26, $60
	defb	$2a, $a0, $2a, $a0, $aa, $a8, $aa, $a8
	defb	$2a, $a0, $2a, $a0, $0a, $80, $0a, $80
	defb	$00, $00, $00, $00, $00, $00, $00, $00
	defb	$00, $00, $00, $f0, $03, $c0, $0f, $c0
	defb	$0e, $c0, $3a, $c0, $3b, $b0, $3a, $c0
	defb	$0f, $c0, $0f, $00, $00, $00, $00, $00
	defb	$00, $00, $00, $00, $03, $00, $03, $00
	defb	$03, $00, $0f, $c0, $0e, $c0, $0e, $c0
	defb	$3a, $b0, $3b, $b0, $3b, $b0, $3b, $b0
	defb	$3a, $b0, $0e, $c0, $0f, $c0, $00, $00
	defb	$00, $00, $00, $00, $00, $80, $22, $20
	defb	$22, $20, $a2, $20, $a2, $20, $20, $80
	defb	$20, $08, $20, $22, $20, $22, $20, $22
	defb	$a8, $22, $00, $08, $00, $00, $00, $00
	defb	$00, $00, $00, $00, $00, $80, $22, $20
	defb	$aa, $20, $8a, $20, $0a, $20, $08, $80
	defb	$28, $08, $20, $22, $20, $22, $80, $22
	defb	$a8, $22, $00, $08, $00, $00, $00, $00
	defb	$00, $00, $00, $00, $00, $80, $0a, $20
	defb	$0a, $20, $0a, $20, $8a, $20, $88, $80
	defb	$88, $08, $a8, $22, $a8, $22, $08, $22
	defb	$08, $22, $00, $08, $00, $00, $00, $00
	defb	$00, $00, $00, $00, $00, $80, $22, $20
	defb	$8a, $20, $8a, $20, $8a, $20, $20, $80
	defb	$20, $08, $88, $22, $88, $22, $88, $22
	defb	$20, $22, $00, $08, $00, $00, $00, $00
