cseg

AsciiPattern: public AsciiPattern
	; ascii 37
	defb $00,$00,$00,$00,$00
	defb $fc,$cc,$cc,$cc,$fc
	defb $0c,$0c,$0c,$0c,$0c
	defb $fc,$0c,$fc,$c0,$fc
	defb $fc,$0c,$fc,$0c,$fc
	defb $cc,$cc,$fc,$0c,$0c
	defb $fc,$c0,$fc,$0c,$fc
	defb $fc,$c0,$fc,$cc,$fc
	defb $fc,$0c,$30,$30,$30
	defb $fc,$cc,$fc,$cc,$fc
	defb $fc,$cc,$fc,$0c,$fc
	defb $30,$cc,$cc,$fc,$cc
	defb $f0,$cc,$f0,$cc,$f0
	defb $30,$cc,$c0,$cc,$30
	defb $f0,$cc,$cc,$cc,$f0
	defb $fc,$c0,$f0,$c0,$fc
	defb $fc,$c0,$f0,$c0,$c0
	defb $3c,$c0,$cc,$cc,$30
	defb $cc,$cc,$fc,$cc,$cc
	defb $fc,$30,$30,$30,$fc
	defb $3c,$0c,$0c,$cc,$30
	defb $cc,$cc,$f0,$cc,$cc
	defb $c0,$c0,$c0,$c0,$fc
	defb $cc,$fc,$fc,$cc,$cc
	defb $f0,$cc,$cc,$cc,$cc
	defb $30,$cc,$cc,$cc,$30
	defb $fc,$cc,$fc,$c0,$c0
	defb $30,$cc,$cc,$f0,$3c
	defb $f0,$cc,$f0,$cc,$cc
	defb $3c,$c0,$fc,$0c,$f0
	defb $fc,$30,$30,$30,$30
	defb $cc,$cc,$cc,$cc,$fc
	defb $cc,$cc,$cc,$cc,$30
	defb $cc,$cc,$fc,$fc,$cc
	defb $cc,$cc,$30,$cc,$cc
	defb $cc,$cc,$30,$30,$30
	defb $fc,$0c,$30,$c0,$fc

SpritePattern: public SpritePattern
;	sprite
	defb	$3c, $3c, $3c, $3c, $ff, $ff, $ff, $aa
	defb	$00, $00, $00, $00, $00, $00, $ff, $aa
	defb	$3c, $3c, $3c, $3c, $ff, $ff, $ff, $d7
	defb	$ff, $aa, $ff, $96, $ff, $96, $ff, $aa
	defb	$c3, $c3, $3c, $28, $ff, $aa, $3c, $28
	defb	$0f, $0a, $3c, $3c, $ff, $f3, $3c, $3c
	defb	$3c, $28, $ff, $96, $ff, $92, $3c, $28
	defb	$c3, $82, $3f, $29, $ff, $a0, $ff, $91
	defb	$c3, $82, $fc, $a8, $ff, $1a, $fc, $08
	defb	$ff, $a0, $3f, $24, $3f, $2a, $c3, $82
	defb	$ff, $46, $ff, $2a, $fc, $68, $c3, $82