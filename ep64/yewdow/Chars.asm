cseg

CharPattern: public CharPattern
	; ascii
	defb $00,$00,$00,$00,$00,$00,$00,$00
	defb $00,$00,$00,$00,$00,$00,$00,$00
	defb $55,$00,$55,$00,$55,$00,$55,$00
	defb $00,$00,$55,$00,$55,$00,$00,$00
	defb $aa,$aa,$aa,$aa,$00,$00,$00,$00
	defb $00,$00,$00,$00,$00,$00,$00,$00
	defb $55,$00,$55,$00,$ff,$aa,$55,$00
	defb $ff,$aa,$55,$00,$55,$00,$00,$00
	defb $55,$00,$ff,$aa,$ff,$00,$ff,$aa
	defb $55,$aa,$ff,$aa,$55,$00,$00,$00
	defb $aa,$00,$aa,$aa,$00,$aa,$55,$00
	defb $aa,$00,$aa,$aa,$00,$aa,$00,$00
	defb $55,$00,$aa,$aa,$55,$00,$aa,$00
	defb $aa,$aa,$aa,$aa,$55,$00,$00,$00
	defb $55,$00,$55,$00,$55,$00,$00,$00
	defb $00,$00,$00,$00,$00,$00,$00,$00
	defb $55,$00,$aa,$00,$aa,$00,$aa,$00
	defb $aa,$00,$aa,$00,$55,$00,$00,$00
	defb $55,$00,$00,$aa,$00,$aa,$00,$aa
	defb $00,$aa,$00,$aa,$55,$00,$00,$00
	defb $00,$00,$aa,$aa,$aa,$aa,$55,$00
	defb $aa,$aa,$aa,$aa,$00,$00,$00,$00
	defb $00,$00,$55,$00,$55,$00,$ff,$aa
	defb $55,$00,$55,$00,$00,$00,$00,$00
	defb $00,$00,$00,$00,$00,$00,$00,$00
	defb $55,$00,$55,$00,$aa,$00,$00,$00
	defb $00,$00,$00,$00,$00,$00,$ff,$aa
	defb $00,$00,$00,$00,$00,$00,$00,$00
	defb $00,$00,$00,$00,$00,$00,$00,$00
	defb $00,$00,$55,$00,$55,$00,$00,$00
	defb $00,$00,$00,$aa,$00,$aa,$55,$00
	defb $aa,$00,$aa,$00,$00,$00,$00,$00
	defb $55,$00,$aa,$aa,$aa,$aa,$aa,$aa
	defb $aa,$aa,$aa,$aa,$55,$00,$00,$00
	defb $55,$00,$55,$00,$55,$00,$55,$00
	defb $55,$00,$55,$00,$55,$00,$00,$00
	defb $55,$00,$aa,$aa,$00,$aa,$00,$aa
	defb $55,$00,$aa,$00,$ff,$aa,$00,$00
	defb $55,$00,$aa,$aa,$00,$aa,$55,$00
	defb $00,$aa,$aa,$aa,$55,$00,$00,$00
	defb $00,$aa,$aa,$aa,$aa,$aa,$ff,$aa
	defb $00,$aa,$00,$aa,$00,$aa,$00,$00
	defb $ff,$aa,$aa,$00,$aa,$00,$ff,$00
	defb $00,$aa,$00,$aa,$ff,$00,$00,$00
	defb $55,$00,$aa,$aa,$aa,$00,$ff,$00
	defb $aa,$aa,$aa,$aa,$55,$00,$00,$00
	defb $ff,$aa,$aa,$aa,$00,$aa,$00,$aa
	defb $55,$00,$55,$00,$55,$00,$00,$00
	defb $55,$00,$aa,$aa,$aa,$aa,$55,$00
	defb $aa,$aa,$aa,$aa,$55,$00,$00,$00
	defb $55,$00,$aa,$aa,$aa,$aa,$55,$aa
	defb $00,$aa,$aa,$aa,$55,$00,$00,$00
	defb $00,$00,$55,$00,$55,$00,$00,$00
	defb $55,$00,$55,$00,$00,$00,$00,$00
	defb $00,$00,$55,$00,$55,$00,$00,$00
	defb $55,$00,$55,$00,$aa,$00,$00,$00
	defb $00,$00,$00,$aa,$55,$00,$aa,$00
	defb $55,$00,$00,$aa,$00,$00,$00,$00
	defb $00,$00,$00,$00,$ff,$aa,$00,$00
	defb $ff,$aa,$00,$00,$00,$00,$00,$00
	defb $00,$00,$aa,$00,$55,$00,$00,$aa
	defb $55,$00,$aa,$00,$00,$00,$00,$00
	defb $55,$00,$aa,$aa,$00,$aa,$55,$00
	defb $55,$00,$00,$00,$55,$00,$00,$00
	defb $55,$00,$aa,$aa,$aa,$aa,$aa,$aa
	defb $aa,$00,$aa,$00,$55,$aa,$00,$00
	defb $55,$00,$aa,$aa,$aa,$aa,$aa,$aa
	defb $ff,$aa,$aa,$aa,$aa,$aa,$00,$00
	defb $ff,$00,$aa,$aa,$aa,$aa,$ff,$00
	defb $aa,$aa,$aa,$aa,$ff,$00,$00,$00
	defb $55,$00,$aa,$aa,$aa,$00,$aa,$00
	defb $aa,$00,$aa,$aa,$55,$00,$00,$00
	defb $ff,$00,$aa,$aa,$aa,$aa,$aa,$aa
	defb $aa,$aa,$aa,$aa,$ff,$00,$00,$00
	defb $ff,$aa,$aa,$00,$aa,$00,$ff,$00
	defb $aa,$00,$aa,$00,$ff,$aa,$00,$00
	defb $ff,$aa,$aa,$00,$aa,$00,$ff,$00
	defb $aa,$00,$aa,$00,$aa,$00,$00,$00
	defb $55,$aa,$aa,$00,$aa,$00,$aa,$aa
	defb $aa,$aa,$aa,$aa,$55,$00,$00,$00
	defb $aa,$aa,$aa,$aa,$aa,$aa,$ff,$aa
	defb $aa,$aa,$aa,$aa,$aa,$aa,$00,$00
	defb $ff,$aa,$55,$00,$55,$00,$55,$00
	defb $55,$00,$55,$00,$ff,$aa,$00,$00
	defb $55,$aa,$00,$aa,$00,$aa,$00,$aa
	defb $00,$aa,$aa,$aa,$55,$00,$00,$00
	defb $aa,$aa,$ff,$aa,$ff,$00,$aa,$00
	defb $ff,$00,$ff,$aa,$aa,$aa,$00,$00
	defb $aa,$00,$aa,$00,$aa,$00,$aa,$00
	defb $aa,$00,$aa,$00,$ff,$aa,$00,$00
	defb $aa,$aa,$ff,$aa,$ff,$aa,$ff,$aa
	defb $aa,$aa,$aa,$aa,$aa,$aa,$00,$00
	defb $ff,$00,$aa,$aa,$aa,$aa,$aa,$aa
	defb $aa,$aa,$aa,$aa,$aa,$aa,$00,$00
	defb $55,$00,$aa,$aa,$aa,$aa,$aa,$aa
	defb $aa,$aa,$aa,$aa,$55,$00,$00,$00
	defb $ff,$00,$aa,$aa,$aa,$aa,$aa,$aa
	defb $ff,$00,$aa,$00,$aa,$00,$00,$00
	defb $55,$00,$aa,$aa,$aa,$aa,$aa,$aa
	defb $aa,$aa,$ff,$00,$55,$aa,$00,$00
	defb $ff,$00,$aa,$aa,$aa,$aa,$aa,$aa
	defb $ff,$00,$aa,$aa,$aa,$aa,$00,$00
	defb $55,$00,$aa,$aa,$aa,$00,$55,$00
	defb $00,$aa,$aa,$aa,$55,$00,$00,$00
	defb $ff,$aa,$55,$00,$55,$00,$55,$00
	defb $55,$00,$55,$00,$55,$00,$00,$00
	defb $aa,$aa,$aa,$aa,$aa,$aa,$aa,$aa
	defb $aa,$aa,$aa,$aa,$ff,$aa,$00,$00
	defb $aa,$aa,$aa,$aa,$aa,$aa,$aa,$aa
	defb $aa,$aa,$55,$00,$55,$00,$00,$00
	defb $aa,$aa,$aa,$aa,$aa,$aa,$ff,$aa
	defb $ff,$aa,$ff,$aa,$aa,$aa,$00,$00
	defb $aa,$aa,$aa,$aa,$55,$00,$55,$00
	defb $55,$00,$aa,$aa,$aa,$aa,$00,$00
	defb $aa,$aa,$aa,$aa,$aa,$aa,$55,$00
	defb $55,$00,$55,$00,$55,$00,$00,$00
	defb $ff,$aa,$00,$aa,$00,$aa,$55,$00
	defb $aa,$00,$aa,$00,$ff,$aa,$00,$00
	defb $55,$aa,$55,$00,$55,$00,$55,$00
	defb $55,$00,$55,$00,$55,$aa,$00,$00
	defb $00,$00,$aa,$00,$aa,$00,$55,$00
	defb $00,$aa,$00,$aa,$00,$00,$00,$00
	defb $ff,$00,$55,$00,$55,$00,$55,$00
	defb $55,$00,$55,$00,$ff,$00,$00,$00
	defb $55,$00,$aa,$aa,$00,$00,$00,$00
	defb $00,$00,$00,$00,$00,$00,$00,$00
	defb $00,$00,$00,$00,$00,$00,$00,$00
	defb $00,$00,$00,$00,$ff,$aa,$00,$00
; logo
	defb $00,$00,$00,$00,$00,$00,$00,$00
	defb $00,$00,$00,$00,$00,$00,$00,$00
	defb $3f,$00,$3f,$00,$3f,$00,$3f,$00
	defb $00,$00,$00,$00,$00,$00,$00,$00
	defb $00,$00,$00,$00,$00,$00,$00,$00
	defb $3f,$00,$3f,$00,$3f,$00,$3f,$00
	defb $3f,$00,$3f,$00,$3f,$00,$3f,$00
	defb $3f,$00,$3f,$00,$3f,$00,$3f,$00
	defb $00,$3f,$00,$3f,$00,$3f,$00,$3f
	defb $00,$00,$00,$00,$00,$00,$00,$00
	defb $3f,$3f,$3f,$3f,$3f,$3f,$3f,$3f
	defb $00,$00,$00,$00,$00,$00,$00,$00
	defb $00,$3f,$00,$3f,$00,$3f,$00,$3f
	defb $3f,$00,$3f,$00,$3f,$00,$3f,$00
	defb $3f,$3f,$3f,$3f,$3f,$3f,$3f,$3f
	defb $3f,$00,$3f,$00,$3f,$00,$3f,$00
	defb $00,$00,$00,$00,$00,$00,$00,$00
	defb $00,$3f,$00,$3f,$00,$3f,$00,$3f
	defb $3f,$00,$3f,$00,$3f,$00,$3f,$00
	defb $00,$3f,$00,$3f,$00,$3f,$00,$3f
	defb $00,$00,$00,$00,$00,$00,$00,$00
	defb $3f,$3f,$3f,$3f,$3f,$3f,$3f,$3f
	defb $3f,$00,$3f,$00,$3f,$00,$3f,$00
	defb $3f,$3f,$3f,$3f,$3f,$3f,$3f,$3f
	defb $00,$3f,$00,$3f,$00,$3f,$00,$3f
	defb $00,$3f,$00,$3f,$00,$3f,$00,$3f
	defb $3f,$3f,$3f,$3f,$3f,$3f,$3f,$3f
	defb $00,$3f,$00,$3f,$00,$3f,$00,$3f
	defb $00,$3f,$00,$3f,$00,$3f,$00,$3f
	defb $3f,$3f,$3f,$3f,$3f,$3f,$3f,$3f
	defb $3f,$3f,$3f,$3f,$3f,$3f,$3f,$3f
	defb $3f,$3f,$3f,$3f,$3f,$3f,$3f,$3f
; fence
	defb $00,$00,$00,$00,$00,$00,$00,$00
	defb $00,$00,$00,$00,$00,$00,$33,$33
	defb $33,$33,$00,$00,$00,$00,$00,$00
	defb $00,$00,$00,$00,$00,$00,$00,$00
; color16
	defb $00,$00,$00,$00,$00,$00,$00,$f0
	defb $50,$7a,$50,$7a,$50,$7a,$50,$7a
	defb $00,$00,$00,$00,$00,$00,$a0,$00
	defb $7a,$00,$3f,$a0,$3f,$a0,$3f,$a0
	defb $f0,$f0,$da,$f0,$da,$f0,$f0,$f0
	defb $f0,$f0,$f4,$f8,$54,$a8,$54,$a8
	defb $f0,$a0,$f0,$f0,$f0,$f0,$f0,$f0
	defb $f0,$f0,$f4,$f8,$54,$a8,$54,$a8
	defb $00,$00,$00,$00,$00,$f0,$50,$7a
	defb $50,$7a,$50,$7a,$50,$7a,$f0,$f0
	defb $00,$00,$00,$00,$a0,$00,$7a,$00
	defb $3f,$a0,$3f,$a0,$3f,$a0,$f0,$a0
	defb $da,$f0,$da,$f0,$f0,$f0,$f0,$f0
	defb $a0,$50,$54,$a8,$54,$a8,$54,$a8
	defb $f0,$f0,$f0,$f0,$f0,$f0,$f0,$f0
	defb $a0,$50,$54,$a8,$54,$a8,$54,$a8
	defb $00,$00,$00,$00,$00,$00,$00,$50
	defb $00,$b5,$50,$3f,$50,$3f,$50,$3f
	defb $00,$00,$00,$00,$00,$00,$f0,$00
	defb $b5,$a0,$b5,$a0,$b5,$a0,$b5,$a0
	defb $50,$f0,$f0,$f0,$f0,$f0,$f0,$f0
	defb $f0,$f0,$f4,$f8,$54,$a8,$54,$a8
	defb $f0,$f0,$f0,$e5,$f0,$e5,$f0,$f0
	defb $f0,$f0,$f4,$f8,$54,$a8,$54,$a8
	defb $00,$00,$00,$00,$00,$50,$00,$b5
	defb $50,$3f,$50,$3f,$50,$3f,$50,$f0
	defb $00,$00,$00,$00,$f0,$00,$b5,$a0
	defb $b5,$a0,$b5,$a0,$b5,$a0,$f0,$f0
	defb $f0,$f0,$f0,$f0,$f0,$f0,$f0,$f0
	defb $a0,$50,$54,$a8,$54,$a8,$54,$a8
	defb $f0,$e5,$f0,$e5,$f0,$f0,$f0,$f0
	defb $a0,$50,$54,$a8,$54,$a8,$54,$a8
	defb $00,$00,$00,$00,$00,$00,$00,$f0
	defb $00,$b5,$50,$3f,$50,$3f,$50,$3f
	defb $00,$00,$00,$00,$00,$00,$f0,$00
	defb $7a,$00,$3f,$a0,$3f,$a0,$3f,$a0
	defb $50,$3f,$a0,$f0,$a0,$f0,$a0,$f0
	defb $78,$50,$f0,$f0,$54,$00,$54,$00
	defb $3f,$a0,$f0,$50,$f0,$50,$f0,$50
	defb $a0,$b4,$f0,$f0,$00,$a8,$00,$a8
	defb $00,$00,$00,$00,$00,$f0,$00,$b5
	defb $50,$3f,$50,$3f,$50,$3f,$50,$3f
	defb $00,$00,$00,$00,$f0,$00,$7a,$00
	defb $3f,$a0,$3f,$a0,$3f,$a0,$3f,$a0
	defb $a0,$f0,$a0,$f0,$a0,$f0,$da,$50
	defb $f0,$f0,$54,$00,$54,$00,$54,$00
	defb $f0,$50,$f0,$50,$f0,$50,$a0,$e5
	defb $f0,$f0,$00,$a8,$00,$a8,$00,$a8
	defb $00,$00,$00,$00,$00,$00,$00,$f0
	defb $00,$b5,$50,$3f,$50,$3f,$50,$3f
	defb $00,$00,$00,$00,$00,$00,$f0,$00
	defb $7a,$00,$3f,$a0,$3f,$a0,$3f,$a0
	defb $50,$b5,$e5,$f0,$e5,$00,$f0,$f0
	defb $f0,$00,$f0,$f0,$54,$00,$54,$00
	defb $7a,$a0,$f0,$da,$00,$da,$f0,$f0
	defb $00,$f0,$f0,$f0,$00,$a8,$00,$a8
	defb $00,$00,$00,$00,$00,$f0,$00,$b5
	defb $50,$3f,$50,$3f,$50,$3f,$50,$b5
	defb $00,$00,$00,$00,$f0,$00,$7a,$00
	defb $3f,$a0,$3f,$a0,$3f,$a0,$7a,$a0
	defb $e5,$f0,$e5,$00,$f0,$f0,$f0,$00
	defb $f0,$f0,$54,$00,$54,$00,$54,$00
	defb $f0,$da,$00,$da,$f0,$f0,$00,$f0
	defb $f0,$f0,$00,$a8,$00,$a8,$00,$a8
	defb $00,$ff,$00,$ff,$55,$ff,$55,$ff
	defb $01,$ab,$01,$ab,$55,$ff,$01,$03
	defb $aa,$00,$aa,$00,$ff,$00,$ff,$00
	defb $ff,$00,$ff,$00,$ff,$00,$03,$00
	defb $15,$3f,$15,$37,$15,$37,$15,$3f
	defb $15,$3f,$55,$aa,$ff,$00,$aa,$00
	defb $3f,$aa,$3f,$aa,$7f,$aa,$7f,$00
	defb $3f,$00,$ff,$00,$55,$aa,$00,$aa
	defb $00,$ff,$00,$ff,$55,$ff,$55,$ff
	defb $01,$ab,$01,$ab,$55,$ff,$01,$03
	defb $aa,$00,$aa,$00,$ff,$00,$ff,$00
	defb $ff,$00,$ff,$00,$ff,$00,$03,$00
	defb $15,$3f,$15,$37,$bf,$37,$bf,$3f
	defb $15,$3f,$55,$aa,$00,$aa,$00,$55
	defb $7f,$00,$7f,$aa,$3f,$aa,$3f,$aa
	defb $3f,$00,$ff,$00,$ff,$00,$aa,$00
	defb $00,$55,$00,$55,$00,$ff,$00,$ff
	defb $00,$ff,$00,$ff,$00,$ff,$00,$03
	defb $ff,$00,$ff,$00,$ff,$aa,$ff,$aa
	defb $57,$02,$57,$02,$ff,$aa,$03,$02
	defb $55,$3f,$55,$3f,$55,$bf,$00,$bf
	defb $00,$3f,$00,$ff,$55,$aa,$55,$00
	defb $3f,$2a,$3b,$2a,$3b,$2a,$3f,$2a
	defb $3f,$2a,$55,$aa,$00,$ff,$00,$55
	defb $00,$55,$00,$55,$00,$ff,$00,$ff
	defb $00,$ff,$00,$ff,$00,$ff,$00,$03
	defb $ff,$00,$ff,$00,$ff,$aa,$ff,$aa
	defb $57,$02,$57,$02,$ff,$aa,$03,$02
	defb $00,$bf,$55,$bf,$55,$3f,$55,$3f
	defb $00,$3f,$00,$ff,$00,$ff,$00,$55
	defb $3f,$2a,$3b,$2a,$3b,$7f,$3f,$7f
	defb $3f,$2a,$55,$aa,$55,$00,$aa,$00
	defb $00,$ff,$00,$ff,$55,$ff,$55,$ff
	defb $55,$ff,$55,$ff,$55,$ff,$00,$00
	defb $aa,$00,$aa,$00,$ff,$00,$ff,$00
	defb $ff,$00,$ff,$00,$ff,$00,$00,$00
	defb $bf,$3f,$bf,$3f,$bf,$3f,$bf,$3f
	defb $55,$aa,$55,$aa,$00,$00,$00,$00
	defb $3f,$aa,$3f,$aa,$3f,$00,$3f,$00
	defb $ff,$00,$ff,$00,$ff,$00,$ff,$00
	defb $00,$ff,$00,$ff,$55,$ff,$55,$ff
	defb $55,$ff,$55,$ff,$55,$ff,$00,$00
	defb $aa,$00,$aa,$00,$ff,$00,$ff,$00
	defb $ff,$00,$ff,$00,$ff,$00,$00,$00
	defb $bf,$3f,$bf,$3f,$15,$3f,$15,$3f
	defb $55,$aa,$55,$aa,$55,$aa,$55,$aa
	defb $3f,$aa,$3f,$aa,$3f,$aa,$3f,$aa
	defb $ff,$00,$ff,$00,$00,$00,$00,$00
	defb $00,$55,$00,$55,$00,$ff,$00,$ff
	defb $00,$ab,$00,$ab,$00,$ff,$00,$00
	defb $ff,$00,$ff,$00,$ff,$aa,$ff,$aa
	defb $ab,$aa,$ab,$aa,$ff,$aa,$00,$00
	defb $55,$3f,$55,$3f,$00,$3f,$00,$3f
	defb $00,$ff,$00,$ff,$00,$ff,$00,$ff
	defb $3f,$7f,$37,$7f,$37,$7f,$3f,$7f
	defb $55,$aa,$55,$aa,$00,$00,$00,$00
	defb $00,$55,$00,$55,$00,$ff,$00,$ff
	defb $00,$ab,$00,$ab,$00,$ff,$00,$00
	defb $ff,$00,$ff,$00,$ff,$aa,$ff,$aa
	defb $ab,$aa,$ab,$aa,$ff,$aa,$00,$00
	defb $55,$3f,$55,$3f,$55,$3f,$55,$3f
	defb $00,$ff,$00,$ff,$00,$00,$00,$00
	defb $3f,$7f,$37,$7f,$37,$2a,$3f,$2a
	defb $55,$aa,$55,$aa,$55,$aa,$55,$aa
	defb $00,$88,$00,$88,$44,$cc,$44,$cc
	defb $01,$89,$01,$89,$cc,$cc,$cc,$cc
	defb $88,$00,$88,$00,$cc,$00,$cc,$00
	defb $cc,$00,$cc,$00,$cc,$88,$cc,$88
	defb $44,$cc,$44,$cc,$00,$cc,$00,$cc
	defb $00,$cc,$00,$44,$00,$44,$00,$00
	defb $cc,$00,$cc,$00,$cc,$00,$cc,$00
	defb $88,$00,$88,$00,$cc,$00,$cc,$00
	defb $00,$00,$00,$88,$00,$88,$44,$cc
	defb $44,$cc,$01,$89,$01,$89,$44,$cc
	defb $00,$00,$88,$00,$88,$00,$cc,$00
	defb $cc,$00,$cc,$00,$e6,$00,$cc,$00
	defb $44,$cc,$cc,$cc,$cc,$cc,$44,$cc
	defb $00,$cc,$00,$cc,$00,$44,$00,$44
	defb $cc,$00,$cc,$88,$cc,$88,$cc,$00
	defb $cc,$00,$88,$00,$cc,$00,$cc,$00
	defb $00,$44,$00,$44,$00,$cc,$00,$cc
	defb $00,$cc,$00,$cc,$44,$cc,$44,$cc
	defb $44,$00,$44,$00,$cc,$88,$cc,$88
	defb $46,$02,$46,$02,$cc,$cc,$cc,$cc
	defb $00,$cc,$00,$cc,$00,$cc,$00,$cc
	defb $00,$44,$00,$44,$00,$cc,$00,$cc
	defb $cc,$88,$cc,$88,$cc,$00,$cc,$00
	defb $cc,$00,$88,$00,$88,$00,$00,$00
	defb $00,$00,$00,$44,$00,$44,$00,$cc
	defb $00,$cc,$00,$cc,$00,$cc,$00,$cc
	defb $00,$00,$44,$00,$44,$00,$cc,$88
	defb $cc,$88,$46,$02,$46,$02,$cc,$88
	defb $00,$cc,$44,$cc,$44,$cc,$00,$cc
	defb $00,$cc,$00,$44,$00,$cc,$00,$cc
	defb $cc,$88,$cc,$cc,$cc,$cc,$cc,$88
	defb $cc,$00,$cc,$00,$88,$00,$88,$00
	defb $00,$44,$00,$44,$00,$cc,$00,$cc
	defb $00,$cc,$00,$cc,$44,$cc,$44,$cc
	defb $44,$00,$44,$00,$cc,$88,$cc,$88
	defb $cc,$88,$cc,$88,$cc,$cc,$cc,$cc
	defb $00,$cc,$00,$cc,$00,$cc,$00,$cc
	defb $00,$44,$00,$44,$00,$00,$00,$00
	defb $cc,$88,$cc,$88,$cc,$88,$cc,$88
	defb $cc,$00,$cc,$00,$88,$00,$88,$00
	defb $00,$00,$00,$00,$00,$44,$00,$44
	defb $00,$cc,$00,$cc,$00,$cc,$00,$cc
	defb $00,$00,$00,$00,$44,$00,$44,$00
	defb $cc,$88,$cc,$88,$cc,$88,$cc,$88
	defb $00,$cc,$00,$cc,$44,$cc,$44,$cc
	defb $00,$cc,$00,$cc,$00,$44,$00,$44
	defb $cc,$88,$cc,$88,$cc,$cc,$cc,$cc
	defb $cc,$88,$cc,$88,$cc,$00,$cc,$00
	defb $00,$88,$00,$88,$44,$cc,$44,$cc
	defb $44,$46,$44,$46,$cc,$cc,$cc,$cc
	defb $88,$00,$88,$00,$cc,$00,$cc,$00
	defb $46,$00,$46,$00,$cc,$88,$cc,$88
	defb $44,$cc,$44,$cc,$44,$cc,$44,$cc
	defb $00,$cc,$00,$cc,$00,$44,$00,$44
	defb $cc,$00,$cc,$00,$cc,$00,$cc,$00
	defb $88,$00,$88,$00,$00,$00,$00,$00
	defb $00,$00,$00,$00,$00,$88,$00,$88
	defb $44,$cc,$44,$cc,$44,$46,$44,$46
	defb $00,$00,$00,$00,$88,$00,$88,$00
	defb $cc,$00,$cc,$00,$46,$00,$46,$00
	defb $44,$cc,$44,$cc,$cc,$cc,$cc,$cc
	defb $44,$cc,$44,$cc,$00,$cc,$00,$cc
	defb $cc,$00,$cc,$00,$cc,$88,$cc,$88
	defb $cc,$00,$cc,$00,$88,$00,$88,$00
	defb $00,$00,$00,$00,$00,$00,$55,$54
	defb $55,$54,$ff,$54,$ff,$54,$55,$00
	defb $00,$00,$00,$00,$a8,$00,$54,$00
	defb $54,$00,$54,$00,$54,$00,$a8,$00
	defb $55,$00,$55,$00,$55,$00,$55,$00
	defb $ff,$aa,$00,$00,$00,$00,$00,$00
	defb $00,$a8,$54,$54,$54,$54,$54,$54
	defb $54,$54,$00,$a8,$00,$00,$00,$00
	defb $00,$00,$00,$00,$00,$00,$55,$54
	defb $ff,$fe,$aa,$fe,$00,$fe,$00,$aa
	defb $00,$00,$00,$00,$a8,$00,$54,$00
	defb $54,$00,$54,$00,$54,$00,$a8,$00
	defb $55,$aa,$55,$00,$55,$00,$aa,$00
	defb $ff,$aa,$00,$00,$00,$00,$00,$00
	defb $00,$a8,$54,$54,$54,$54,$54,$54
	defb $54,$54,$00,$a8,$00,$00,$00,$00
	defb $00,$00,$00,$00,$00,$00,$00,$fe
	defb $00,$fe,$00,$fe,$aa,$fe,$aa,$aa
	defb $00,$00,$00,$00,$a8,$00,$54,$00
	defb $54,$00,$54,$00,$54,$00,$a8,$00
	defb $aa,$aa,$ff,$aa,$ff,$aa,$00,$aa
	defb $00,$aa,$00,$00,$00,$00,$00,$00
	defb $00,$a8,$54,$54,$54,$54,$54,$54
	defb $54,$54,$00,$a8,$00,$00,$00,$00
	defb $00,$00,$00,$00,$00,$00,$55,$54
	defb $aa,$fe,$aa,$fe,$aa,$fe,$55,$00
	defb $00,$00,$00,$00,$a8,$00,$54,$00
	defb $54,$00,$54,$00,$54,$00,$a8,$00
	defb $55,$00,$aa,$aa,$aa,$aa,$aa,$aa
	defb $55,$00,$00,$00,$00,$00,$00,$00
	defb $00,$a8,$54,$54,$54,$54,$54,$54
	defb $54,$54,$00,$a8,$00,$00,$00,$00
	defb $00,$00,$c0,$c0,$c0,$c0,$c0,$d5
	defb $c0,$d5,$c0,$ea,$c0,$ea,$d5,$ff
	defb $00,$00,$c0,$80,$c0,$80,$c0,$80
	defb $c0,$80,$c0,$80,$c0,$80,$ff,$80
	defb $d5,$ff,$c0,$ea,$c0,$ea,$c0,$d5
	defb $c0,$d5,$c0,$c0,$c0,$c0,$00,$00
	defb $ff,$80,$c0,$80,$c0,$80,$c0,$80
	defb $c0,$80,$c0,$80,$c0,$80,$00,$00
	defb $00,$00,$c0,$c0,$c0,$c0,$c0,$d5
	defb $c0,$d5,$c0,$c0,$c0,$c0,$d5,$ff
	defb $00,$00,$c0,$80,$c0,$80,$c0,$80
	defb $c0,$80,$ea,$80,$ea,$80,$ff,$80
	defb $d5,$ff,$c0,$c0,$c0,$c0,$c0,$d5
	defb $c0,$d5,$c0,$c0,$c0,$c0,$00,$00
	defb $ff,$80,$ea,$80,$ea,$80,$c0,$80
	defb $c0,$80,$c0,$80,$c0,$80,$00,$00
	defb $00,$00,$c0,$c0,$c0,$c0,$c0,$d5
	defb $c0,$d5,$c0,$ff,$c0,$ff,$d5,$d5
	defb $00,$00,$c0,$80,$c0,$80,$c0,$80
	defb $c0,$80,$ea,$80,$ea,$80,$d5,$80
	defb $d5,$d5,$c0,$d5,$c0,$d5,$c0,$d5
	defb $c0,$d5,$c0,$c0,$c0,$c0,$00,$00
	defb $d5,$80,$c0,$80,$c0,$80,$c0,$80
	defb $c0,$80,$c0,$80,$c0,$80,$00,$00
	defb $00,$00,$c0,$c0,$c0,$c0,$c0,$d5
	defb $c0,$d5,$c0,$d5,$c0,$d5,$d5,$d5
	defb $00,$00,$c0,$80,$c0,$80,$c0,$80
	defb $c0,$80,$c0,$80,$c0,$80,$d5,$80
	defb $d5,$d5,$c0,$ff,$c0,$ff,$c0,$d5
	defb $c0,$d5,$c0,$c0,$c0,$c0,$00,$00
	defb $d5,$80,$ea,$80,$ea,$80,$c0,$80
	defb $c0,$80,$c0,$80,$c0,$80,$00,$00
	defb $00,$00,$c0,$c0,$c0,$c0,$c0,$c0
	defb $c0,$c0,$c0,$c0,$c0,$c0,$c0,$c0
	defb $00,$00,$c0,$80,$c0,$80,$c0,$80
	defb $c0,$80,$c0,$80,$c0,$80,$c0,$80
	defb $c0,$c0,$c0,$c0,$c0,$c0,$c0,$c0
	defb $c0,$c0,$c0,$c0,$c0,$c0,$00,$00
	defb $c0,$80,$c0,$80,$c0,$80,$c0,$80
	defb $c0,$80,$c0,$80,$c0,$80,$00,$00
	defb $00,$00,$00,$ef,$00,$ef,$00,$ef
	defb $00,$ef,$00,$ef,$00,$ef,$00,$ef
	defb $00,$00,$cf,$8a,$cf,$8a,$cf,$8a
	defb $cf,$8a,$cf,$8a,$cf,$8a,$cf,$8a
	defb $00,$aa,$00,$aa,$00,$aa,$00,$aa
	defb $00,$aa,$00,$aa,$00,$aa,$55,$ff
	defb $00,$00,$00,$00,$00,$00,$00,$00
	defb $00,$00,$00,$00,$00,$00,$00,$00
	defb $00,$00,$00,$ae,$00,$ae,$00,$ae
	defb $00,$ae,$00,$ae,$00,$ae,$00,$ae
	defb $00,$00,$0c,$08,$0c,$08,$0c,$00
	defb $0c,$00,$08,$00,$08,$00,$00,$00
	defb $00,$ae,$00,$aa,$00,$aa,$00,$aa
	defb $00,$aa,$00,$aa,$00,$aa,$55,$ff
	defb $00,$00,$00,$00,$00,$00,$00,$00
	defb $00,$00,$00,$00,$00,$00,$00,$00
	defb $00,$00,$00,$af,$00,$af,$00,$af
	defb $00,$af,$00,$af,$00,$af,$00,$af
	defb $00,$00,$00,$00,$0a,$00,$0f,$00
	defb $0f,$0a,$0f,$0a,$0f,$00,$0a,$00
	defb $00,$af,$00,$aa,$00,$aa,$00,$aa
	defb $00,$aa,$00,$aa,$00,$aa,$55,$ff
	defb $00,$00,$00,$00,$00,$00,$00,$00
	defb $00,$00,$00,$00,$00,$00,$00,$00
	defb $00,$00,$00,$bf,$00,$bf,$00,$bf
	defb $00,$bf,$00,$bf,$00,$bf,$00,$bf
	defb $00,$00,$00,$00,$00,$00,$2a,$00
	defb $2a,$00,$3f,$00,$3f,$00,$3f,$2a
	defb $00,$bf,$00,$aa,$00,$aa,$00,$aa
	defb $00,$aa,$00,$aa,$00,$aa,$55,$ff
	defb $3f,$2a,$00,$00,$00,$00,$00,$00
	defb $00,$00,$00,$00,$00,$00,$00,$00
	defb $00,$54,$00,$fc,$00,$a8,$54,$54
	defb $54,$fc,$54,$54,$54,$fc,$a8,$a8
	defb $00,$00,$a8,$00,$fc,$00,$fc,$00
	defb $54,$a8,$fc,$a8,$fc,$a8,$a8,$fc
	defb $fc,$fc,$fc,$54,$fc,$fc,$fc,$fc
	defb $fc,$fc,$a8,$a8,$54,$54,$00,$fc
	defb $fc,$fc,$54,$fc,$fc,$fc,$fc,$54
	defb $a8,$a8,$fc,$54,$a8,$a8,$54,$00
	defb $33,$33,$33,$33,$33,$33,$33,$33
	defb $33,$33,$33,$33,$33,$33,$33,$33
	defb $33,$33,$33,$33,$33,$33,$33,$33
	defb $33,$33,$33,$33,$33,$33,$33,$33
	defb $33,$33,$33,$33,$33,$33,$33,$33
	defb $33,$33,$33,$33,$33,$33,$33,$33
	defb $33,$33,$33,$33,$33,$33,$33,$33
	defb $33,$33,$33,$33,$33,$33,$33,$33
