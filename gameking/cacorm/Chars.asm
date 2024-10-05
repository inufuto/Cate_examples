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
	defb	$3c, $28, $ff, $8a, $3f, $2a, $c3, $c3
	defb	$3c, $28, $ff, $a2, $fc, $a8, $c3, $c3
	defb	$3c, $28, $ff, $aa, $ff, $aa, $c3, $c3
	defb	$3c, $28, $ff, $82, $ff, $aa, $c3, $c3
	defb	$ff, $aa, $ff, $22, $fc, $a8, $3f, $2a
	defb	$ff, $aa, $ff, $88, $3f, $2a, $fc, $a8
	defb	$ff, $aa, $ff, $aa, $ff, $aa, $3c, $28
	defb	$ff, $aa, $ff, $22, $ff, $aa, $3c, $28
	defb	$00, $00, $cc, $88, $cc, $88, $fc, $a8
