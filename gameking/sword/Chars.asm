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
	defb	$3c, $3c, $3c, $3c, $0c, $0c, $33, $33
	defb	$3c, $3c, $3c, $3c, $0c, $0c, $0c, $0c
	defb	$f0, $f0, $f0, $f0, $30, $30, $cc, $cc
	defb	$00, $00, $0c, $08, $ff, $5a, $0c, $08
	defb	$3c, $3c, $3c, $3c, $30, $30, $cc, $cc
	defb	$3c, $3c, $3c, $3c, $30, $30, $30, $30
	defb	$0f, $0f, $0f, $0f, $0c, $0c, $33, $33
	defb	$00, $00, $30, $20, $ff, $a5, $30, $20
	defb	$00, $00, $f3, $f3, $fc, $fc, $03, $03
	defb	$00, $00, $f0, $f0, $ff, $ff, $00, $00
	defb	$f3, $f3, $fc, $fc, $03, $03, $00, $00
	defb	$0c, $04, $0c, $04, $3f, $2a, $0c, $08
	defb	$03, $03, $fc, $fc, $f3, $f3, $00, $00
	defb	$00, $00, $ff, $ff, $f0, $f0, $00, $00
	defb	$00, $00, $03, $03, $fc, $fc, $f3, $f3
	defb	$0c, $08, $3f, $2a, $0c, $04, $0c, $04
	defb	$ff, $aa, $ff, $22, $ff, $aa, $cc, $88
	defb	$ff, $99, $ff, $66, $ff, $99, $ff, $66
	defb	$00, $00, $cc, $88, $cc, $88, $fc, $a8
