cseg


AsciiPattern: public AsciiPattern
	; ascii 29
	; " 0123456789ACEFGHIKMNOPRSTUVY"
	defb $00,$00,$00,$00,$00,$00,$00,$00
	defb $54,$44,$44,$44,$54,$00,$00,$00
	defb $04,$04,$04,$04,$04,$00,$00,$00
	defb $54,$04,$54,$40,$54,$00,$00,$00
	defb $54,$04,$54,$04,$54,$00,$00,$00
	defb $44,$44,$54,$04,$04,$00,$00,$00
	defb $54,$40,$54,$04,$54,$00,$00,$00
	defb $54,$40,$54,$44,$54,$00,$00,$00
	defb $54,$04,$10,$10,$10,$00,$00,$00
	defb $54,$44,$54,$44,$54,$00,$00,$00
	defb $54,$44,$54,$04,$54,$00,$00,$00
	defb $10,$44,$44,$54,$44,$00,$00,$00
	defb $10,$44,$40,$44,$10,$00,$00,$00
	defb $54,$40,$50,$40,$54,$00,$00,$00
	defb $54,$40,$50,$40,$40,$00,$00,$00
	defb $14,$40,$44,$44,$10,$00,$00,$00
	defb $44,$44,$54,$44,$44,$00,$00,$00
	defb $54,$10,$10,$10,$54,$00,$00,$00
	defb $44,$44,$50,$44,$44,$00,$00,$00
	defb $44,$54,$54,$44,$44,$00,$00,$00
	defb $50,$44,$44,$44,$44,$00,$00,$00
	defb $10,$44,$44,$44,$10,$00,$00,$00
	defb $50,$44,$50,$40,$40,$00,$00,$00
	defb $50,$44,$50,$44,$44,$00,$00,$00
	defb $14,$40,$54,$04,$50,$00,$00,$00
	defb $54,$10,$10,$10,$10,$00,$00,$00
	defb $44,$44,$44,$44,$54,$00,$00,$00
	defb $44,$44,$44,$44,$10,$00,$00,$00
	defb $44,$44,$10,$10,$10,$00,$00,$00

CharPattern: public CharPattern
;	logo
	defb	$00, $00, $00, $00, $a0, $a0, $00, $00
	defb	$00, $00, $a0, $a0, $a0, $a0, $a0, $a0
	defb	$0a, $0a, $00, $00, $aa, $aa, $00, $00
	defb	$0a, $0a, $a0, $a0, $aa, $aa, $a0, $a0
	defb	$00, $00, $0a, $0a, $a0, $a0, $0a, $0a
	defb	$00, $00, $aa, $aa, $a0, $a0, $aa, $aa
	defb	$0a, $0a, $0a, $0a, $aa, $aa, $0a, $0a
	defb	$0a, $0a, $aa, $aa, $aa, $aa, $aa, $aa
;	wall
	defb	$00, $00, $00, $00, $80, $80, $80, $80
	defb	$02, $02, $02, $02, $82, $82, $82, $82
	defb	$aa, $00, $00, $00, $2a, $80, $80, $80
	defb	$a8, $02, $02, $02, $28, $82, $82, $82
	defb	$00, $00, $00, $aa, $80, $80, $80, $2a
	defb	$02, $02, $02, $a8, $82, $82, $82, $28
	defb	$aa, $00, $00, $aa, $2a, $80, $80, $2a
	defb	$a8, $02, $02, $a8, $28, $82, $82, $28
;	point
	defb	$04, $04, $04, $04, $50, $04, $10, $54
	defb	$44, $44, $54, $04, $44, $54, $44, $54
	defb	$54, $44, $44, $54
;	8dot
	defb	$00, $2a, $05, $09, $a8, $f0, $6a, $90
	defb	$05, $0a, $0a, $14, $40, $90, $40, $10
	defb	$00, $2a, $05, $09, $a8, $f0, $6a, $90
	defb	$05, $1a, $0a, $01, $40, $90, $84, $40
	defb	$2a, $0f, $a9, $06, $00, $a8, $50, $60
	defb	$01, $06, $01, $04, $50, $a0, $a0, $14
	defb	$2a, $0f, $a9, $06, $00, $a8, $50, $60
	defb	$01, $06, $12, $01, $50, $a4, $a0, $40
	defb	$2a, $0f, $aa, $0a, $00, $c0, $a8, $80
	defb	$1a, $0a, $04, $04, $90, $90, $40, $00
	defb	$2a, $0f, $aa, $0a, $00, $c0, $a8, $80
	defb	$1a, $1a, $04, $00, $90, $80, $40, $40
	defb	$02, $0f, $aa, $19, $a0, $c0, $a8, $90
	defb	$05, $0a, $04, $04, $40, $90, $40, $00
	defb	$02, $0f, $aa, $19, $a0, $c0, $a8, $90
	defb	$05, $1a, $04, $00, $40, $80, $40, $40
	defb	$0c, $3f, $2e, $ff, $c0, $f0, $f0, $fc
	defb	$3f, $0f, $03, $00, $f0, $f0, $c0, $f0
	defb	$00, $0c, $3f, $2e, $00, $c0, $f0, $f0
	defb	$3f, $ff, $0f, $03, $f0, $fc, $f0, $f0
	defb	$03, $0f, $0f, $3f, $30, $fc, $b8, $ff
	defb	$0f, $0f, $03, $0f, $fc, $f0, $c0, $00
	defb	$00, $03, $0f, $0f, $00, $30, $fc, $b8
	defb	$0f, $3f, $0f, $0f, $fc, $ff, $f0, $c0
	defb	$03, $0f, $0f, $3f, $30, $fc, $fc, $ff
	defb	$0f, $0f, $03, $00, $fc, $fc, $f0, $c0
	defb	$00, $03, $0f, $0f, $00, $30, $fc, $fc
	defb	$3f, $0f, $0f, $03, $ff, $fc, $fc, $f0
	defb	$0c, $3f, $3b, $ff, $c0, $f0, $b0, $fc
	defb	$3f, $3f, $0f, $03, $f0, $f0, $c0, $00
	defb	$00, $0c, $3f, $3b, $00, $c0, $f0, $b0
	defb	$3f, $ff, $3f, $0f, $f0, $fc, $f0, $c0
	defb	$00, $00, $03, $0d, $00, $00, $f0, $c0
	defb	$37, $35, $0f, $00, $70, $c0, $00, $00
	defb	$00, $03, $03, $0d, $00, $00, $00, $c0
	defb	$35, $37, $35, $0f, $70, $70, $70, $c0
	defb	$00, $00, $00, $01, $00, $00, $00, $40
	defb	$01, $00, $00, $00, $40, $00, $00, $00
	defb	$05, $1d, $55, $2a, $50, $54, $d5, $a8
	defb	$2e, $3f, $55, $15, $ec, $fc, $55, $54
