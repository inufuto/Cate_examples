cseg

CharPattern: public CharPattern
; ascii 30
	; " -0123456789ACEFGHIKMNOPRSTUVY"
	defb $00,$00,$00,$00,$00,$00,$00,$00
	defb $00,$00,$00,$7e,$00,$00,$00,$00
	defb $3e,$63,$67,$6b,$73,$63,$3e,$00
	defb $18,$78,$18,$18,$18,$18,$7e,$00
	defb $3e,$63,$07,$1e,$3c,$70,$7f,$00
	defb $3e,$63,$03,$1e,$03,$63,$3e,$00
	defb $06,$0e,$1e,$36,$66,$7f,$06,$00
	defb $7f,$60,$7e,$03,$03,$63,$3e,$00
	defb $1e,$30,$60,$7e,$63,$63,$3e,$00
	defb $7f,$63,$06,$0c,$18,$18,$18,$00
	defb $3e,$63,$63,$3e,$63,$63,$3e,$00
	defb $3e,$63,$63,$3f,$03,$63,$3e,$00
	defb $1c,$36,$63,$63,$7f,$63,$63,$00
	defb $1e,$33,$60,$60,$60,$33,$1e,$00
	defb $7e,$60,$60,$7e,$60,$60,$7e,$00
	defb $7e,$60,$60,$7e,$60,$60,$60,$00
	defb $1e,$33,$60,$6f,$63,$33,$1f,$00
	defb $63,$63,$63,$7f,$63,$63,$63,$00
	defb $7e,$18,$18,$18,$18,$18,$7e,$00
	defb $63,$66,$6c,$78,$6c,$66,$63,$00
	defb $7e,$6b,$6b,$6b,$6b,$6b,$6b,$00
	defb $63,$73,$7b,$7f,$6f,$67,$63,$00
	defb $3e,$63,$63,$63,$63,$63,$3e,$00
	defb $7e,$63,$63,$63,$7e,$60,$60,$00
	defb $7e,$63,$63,$67,$7c,$6e,$67,$00
	defb $3e,$63,$60,$3e,$03,$63,$3e,$00
	defb $7e,$18,$18,$18,$18,$18,$18,$00
	defb $63,$63,$63,$63,$63,$63,$3e,$00
	defb $63,$63,$63,$36,$36,$1c,$1c,$00
	defb $66,$66,$66,$3c,$18,$18,$18,$00
;	logo
	defb	$f0, $f0, $f0, $f0, $00, $00, $00, $00
	defb	$00, $00, $00, $00, $f0, $f0, $f0, $f0
	defb	$f0, $f0, $f0, $f0, $f0, $f0, $f0, $f0
	defb	$0f, $0f, $0f, $0f, $00, $00, $00, $00
	defb	$ff, $ff, $ff, $ff, $00, $00, $00, $00
	defb	$0f, $0f, $0f, $0f, $f0, $f0, $f0, $f0
	defb	$ff, $ff, $ff, $ff, $f0, $f0, $f0, $f0
	defb	$00, $00, $00, $00, $0f, $0f, $0f, $0f
	defb	$f0, $f0, $f0, $f0, $0f, $0f, $0f, $0f
	defb	$00, $00, $00, $00, $ff, $ff, $ff, $ff
	defb	$f0, $f0, $f0, $f0, $ff, $ff, $ff, $ff
	defb	$0f, $0f, $0f, $0f, $0f, $0f, $0f, $0f
	defb	$ff, $ff, $ff, $ff, $0f, $0f, $0f, $0f
	defb	$0f, $0f, $0f, $0f, $ff, $ff, $ff, $ff
	defb	$ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff
;	remain
	defb	$44, $44, $d6, $ee, $d6, $fe, $fe, $54
;	terrain
	defb	$80, $a0, $c0, $e6, $f0, $b8, $fc, $fb
	defb	$01, $63, $03, $03, $6f, $1f, $3f, $fb
	defb	$d5, $a2, $d4, $ea, $f5, $ba, $fc, $fd
	defb	$ff, $3f, $1f, $0b, $07, $63, $03, $07
	defb	$55, $a2, $54, $8a, $55, $a2, $54, $8a
	defb	$ff, $be, $fc, $fa, $f5, $a2, $d4, $8a
	defb	$ff, $be, $f8, $f6, $e0, $a0, $c0, $86
	defb	$ff, $bf, $ff, $fb, $ff, $bf, $ff, $fb
	defb	$55, $a3, $57, $8b, $5f, $bf, $7f, $fb
	defb	$ff, $ff, $5f, $8b, $57, $a3, $57, $8b
	defb	$00, $60, $00, $06, $00, $60, $00, $06
	defb	$ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff
	defb	$aa, $55, $aa, $55, $aa, $55, $aa, $55
;	fort
	defb	$ff, $bf, $f8, $f7, $e3, $90, $db, $db
	defb	$ff, $bf, $00, $ef, $e0, $0f, $00, $37
	defb	$f3, $ad, $1e, $de, $1e, $ac, $01, $fd
	defb	$cf, $b5, $78, $7b, $78, $35, $80, $bf
	defb	$ff, $fd, $00, $f7, $07, $f0, $00, $ec
	defb	$ff, $fd, $0f, $ef, $c7, $09, $db, $db
	defb	$d8, $99, $e0, $ef, $e0, $d9, $bd, $bd
	defb	$78, $79, $35, $40, $0e, $ce, $ce, $ce
	defb	$01, $99, $bc, $7e, $ff, $ff, $7e, $bc
	defb	$80, $99, $3d, $7e, $ff, $ff, $7e, $3d
	defb	$1e, $9e, $ac, $02, $70, $73, $73, $73
	defb	$1b, $99, $07, $f7, $07, $9b, $bd, $bd
	defb	$d8, $81, $7d, $7d, $00, $6d, $6d, $6d
	defb	$00, $d0, $c3, $c3, $00, $77, $77, $77
	defb	$19, $00, $fe, $fe, $00, $bd, $bd, $bd
	defb	$98, $00, $7f, $7f, $00, $bd, $bd, $bd
	defb	$00, $0b, $c3, $c3, $00, $ee, $ee, $ee
	defb	$1b, $81, $be, $be, $00, $b6, $b6, $b6
	defb	$6d, $6d, $6d, $00, $7d, $7d, $81, $d8
	defb	$77, $77, $77, $00, $c3, $c3, $d0, $00
	defb	$bd, $bd, $bd, $00, $fe, $fe, $00, $19
	defb	$bd, $bd, $bd, $00, $7f, $7f, $00, $98
	defb	$ee, $ee, $ee, $00, $c3, $c3, $0b, $00
	defb	$b6, $b6, $b6, $00, $be, $be, $81, $1b
	defb	$bd, $bd, $d9, $e0, $ef, $e0, $99, $d8
	defb	$ce, $ce, $ce, $0e, $40, $35, $79, $78
	defb	$bc, $7e, $ff, $ff, $7e, $bc, $99, $01
	defb	$3d, $7e, $ff, $ff, $7e, $3d, $99, $80
	defb	$73, $73, $73, $70, $02, $ac, $9e, $1e
	defb	$bd, $bd, $9b, $07, $f7, $07, $99, $1b
	defb	$db, $db, $90, $e3, $f7, $f8, $bf, $ff
	defb	$37, $00, $0f, $e0, $ef, $00, $bf, $ff
	defb	$fd, $01, $ac, $1e, $de, $1e, $ad, $f3
	defb	$bf, $80, $35, $78, $7b, $78, $b5, $cf
	defb	$ec, $00, $f0, $07, $f7, $00, $fd, $ff
	defb	$db, $db, $09, $c7, $ef, $1f, $fd, $ff
