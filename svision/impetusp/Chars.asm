cseg
CharPattern: public CharPattern
cseg

CharPattern: public CharPattern
; ascii 29
	; " -0123456789:ABCEFGHIMNORSTUV"
	defb $00,$00,$00,$00,$00,$00,$00,$00
	defb $00,$00,$00,$00,$00,$00,$00,$00
	defb $00,$00,$00,$00,$00,$00,$fc,$3f
	defb $00,$00,$00,$00,$00,$00,$00,$00
	defb $f0,$3f,$3c,$f0,$3c,$fc,$3c,$f3
	defb $fc,$f0,$3c,$f0,$f0,$3f,$00,$00
	defb $c0,$03,$fc,$03,$c0,$03,$c0,$03
	defb $c0,$03,$c0,$03,$fc,$3f,$00,$00
	defb $f0,$3f,$3c,$f0,$00,$fc,$c0,$3f
	defb $f0,$0f,$fc,$00,$fc,$ff,$00,$00
	defb $f0,$3f,$3c,$f0,$00,$f0,$c0,$3f
	defb $00,$f0,$3c,$f0,$f0,$3f,$00,$00
	defb $00,$3c,$00,$3f,$c0,$3f,$f0,$3c
	defb $3c,$3c,$fc,$ff,$00,$3c,$00,$00
	defb $fc,$ff,$3c,$00,$fc,$3f,$00,$f0
	defb $00,$f0,$3c,$f0,$f0,$3f,$00,$00
	defb $c0,$3f,$f0,$00,$3c,$00,$fc,$3f
	defb $3c,$f0,$3c,$f0,$f0,$3f,$00,$00
	defb $fc,$ff,$3c,$f0,$00,$3c,$00,$0f
	defb $c0,$03,$c0,$03,$c0,$03,$00,$00
	defb $f0,$3f,$3c,$f0,$3c,$f0,$f0,$3f
	defb $3c,$f0,$3c,$f0,$f0,$3f,$00,$00
	defb $f0,$3f,$3c,$f0,$3c,$f0,$f0,$ff
	defb $00,$f0,$3c,$f0,$f0,$3f,$00,$00
	defb $00,$00,$00,$00,$c0,$03,$00,$00
	defb $00,$00,$c0,$03,$00,$00,$00,$00
	defb $c0,$0f,$f0,$3c,$3c,$f0,$3c,$f0
	defb $fc,$ff,$3c,$f0,$3c,$f0,$00,$00
	defb $fc,$3f,$3c,$f0,$3c,$f0,$fc,$3f
	defb $3c,$f0,$3c,$f0,$fc,$3f,$00,$00
	defb $c0,$3f,$f0,$f0,$3c,$00,$3c,$00
	defb $3c,$00,$f0,$f0,$c0,$3f,$00,$00
	defb $fc,$3f,$3c,$00,$3c,$00,$fc,$3f
	defb $3c,$00,$3c,$00,$fc,$3f,$00,$00
	defb $fc,$3f,$3c,$00,$3c,$00,$fc,$3f
	defb $3c,$00,$3c,$00,$3c,$00,$00,$00
	defb $c0,$3f,$f0,$f0,$3c,$00,$3c,$ff
	defb $3c,$f0,$f0,$f0,$c0,$ff,$00,$00
	defb $3c,$f0,$3c,$f0,$3c,$f0,$fc,$ff
	defb $3c,$f0,$3c,$f0,$3c,$f0,$00,$00
	defb $fc,$3f,$c0,$03,$c0,$03,$c0,$03
	defb $c0,$03,$c0,$03,$fc,$3f,$00,$00
	defb $fc,$3f,$3c,$f3,$3c,$f3,$3c,$f3
	defb $3c,$f3,$3c,$f3,$3c,$f3,$00,$00
	defb $3c,$f0,$fc,$f0,$fc,$f3,$fc,$ff
	defb $3c,$ff,$3c,$fc,$3c,$f0,$00,$00
	defb $f0,$3f,$3c,$f0,$3c,$f0,$3c,$f0
	defb $3c,$f0,$3c,$f0,$f0,$3f,$00,$00
	defb $fc,$3f,$3c,$f0,$3c,$f0,$3c,$fc
	defb $fc,$0f,$3c,$3f,$3c,$fc,$00,$00
	defb $f0,$3f,$3c,$f0,$3c,$00,$f0,$3f
	defb $00,$f0,$3c,$f0,$f0,$3f,$00,$00
	defb $fc,$3f,$c0,$03,$c0,$03,$c0,$03
	defb $c0,$03,$c0,$03,$c0,$03,$00,$00
	defb $3c,$f0,$3c,$f0,$3c,$f0,$3c,$f0
	defb $3c,$f0,$3c,$f0,$f0,$3f,$00,$00
	defb $3c,$f0,$3c,$f0,$3c,$f0,$f0,$3c
	defb $f0,$3c,$c0,$0f,$c0,$0f,$00,$00
; logo
	defb $aa,$00,$aa,$00,$aa,$00,$aa,$00
	defb $00,$00,$00,$00,$00,$00,$00,$00
	defb $00,$00,$00,$00,$00,$00,$00,$00
	defb $aa,$00,$aa,$00,$aa,$00,$aa,$00
	defb $aa,$00,$aa,$00,$aa,$00,$aa,$00
	defb $aa,$00,$aa,$00,$aa,$00,$aa,$00
	defb $00,$aa,$00,$aa,$00,$aa,$00,$aa
	defb $00,$00,$00,$00,$00,$00,$00,$00
	defb $aa,$aa,$aa,$aa,$aa,$aa,$aa,$aa
	defb $00,$00,$00,$00,$00,$00,$00,$00
	defb $00,$aa,$00,$aa,$00,$aa,$00,$aa
	defb $aa,$00,$aa,$00,$aa,$00,$aa,$00
	defb $aa,$aa,$aa,$aa,$aa,$aa,$aa,$aa
	defb $aa,$00,$aa,$00,$aa,$00,$aa,$00
	defb $00,$00,$00,$00,$00,$00,$00,$00
	defb $00,$aa,$00,$aa,$00,$aa,$00,$aa
	defb $aa,$00,$aa,$00,$aa,$00,$aa,$00
	defb $00,$aa,$00,$aa,$00,$aa,$00,$aa
	defb $00,$00,$00,$00,$00,$00,$00,$00
	defb $aa,$aa,$aa,$aa,$aa,$aa,$aa,$aa
	defb $aa,$00,$aa,$00,$aa,$00,$aa,$00
	defb $aa,$aa,$aa,$aa,$aa,$aa,$aa,$aa
	defb $00,$aa,$00,$aa,$00,$aa,$00,$aa
	defb $00,$aa,$00,$aa,$00,$aa,$00,$aa
	defb $aa,$aa,$aa,$aa,$aa,$aa,$aa,$aa
	defb $00,$aa,$00,$aa,$00,$aa,$00,$aa
	defb $00,$aa,$00,$aa,$00,$aa,$00,$aa
	defb $aa,$aa,$aa,$aa,$aa,$aa,$aa,$aa
	defb $aa,$aa,$aa,$aa,$aa,$aa,$aa,$aa
	defb $aa,$aa,$aa,$aa,$aa,$aa,$aa,$aa
; remain
	defb $0c,$0c,$0c,$0c,$cf,$3c,$3f,$3f
	defb $cf,$3c,$ff,$3f,$ff,$3f,$cc,$0c
;	terrain
	defb	$55, $55, $55, $55, $55, $55, $55, $55
	defb	$55, $55, $55, $55, $55, $55, $55, $55
	defb	$aa, $2a, $96, $0a, $aa, $0a, $aa, $06
	defb	$96, $00, $2a, $00, $0a, $00, $00, $04
	defb	$a8, $aa, $94, $aa, $a0, $aa, $80, $96
	defb	$00, $aa, $04, $a8, $00, $a0, $00, $04
	defb	$00, $00, $04, $00, $00, $00, $00, $04
	defb	$00, $00, $04, $00, $00, $00, $00, $04
	defb	$26, $00, $19, $00, $06, $00, $00, $04
	defb	$00, $00, $04, $00, $00, $00, $00, $04
	defb	$00, $00, $04, $00, $00, $00, $00, $04
	defb	$00, $00, $04, $80, $00, $a8, $00, $96
	defb	$00, $00, $04, $00, $00, $00, $00, $04
	defb	$00, $00, $05, $00, $26, $00, $a9, $04
	defb	$00, $00, $04, $00, $00, $00, $00, $04
	defb	$00, $00, $04, $80, $00, $a8, $00, $9a
	defb	$00, $66, $04, $98, $00, $a0, $00, $10
	defb	$00, $00, $04, $00, $00, $00, $00, $04
	defb	$96, $00, $2a, $00, $0a, $00, $00, $04
	defb	$00, $00, $04, $00, $00, $00, $00, $04
	defb	$00, $00, $04, $00, $00, $00, $00, $04
	defb	$00, $00, $06, $00, $2a, $00, $aa, $04
	defb	$00, $aa, $04, $a8, $00, $a0, $00, $04
	defb	$00, $00, $04, $00, $00, $00, $00, $04
	defb	$66, $02, $99, $0a, $66, $06, $a9, $19
	defb	$66, $66, $99, $9a, $66, $a6, $a9, $99
	defb	$66, $66, $99, $9a, $66, $a6, $a9, $99
	defb	$66, $26, $99, $0a, $66, $06, $a9, $04
	defb	$66, $66, $99, $9a, $66, $a6, $a9, $99
	defb	$64, $66, $98, $9a, $60, $a6, $80, $99
	defb	$55, $55, $55, $55, $55, $55, $55, $55
	defb	$aa, $aa, $96, $aa, $aa, $aa, $aa, $96
	defb	$aa, $aa, $96, $aa, $aa, $aa, $aa, $96
	defb	$55, $55, $55, $55, $55, $55, $55, $55
	defb	$80, $66, $a4, $9a, $60, $a6, $a8, $99
	defb	$66, $66, $99, $9a, $66, $a6, $a9, $99
	defb	$00, $00, $04, $00, $00, $00, $00, $04
	defb	$55, $55, $55, $55, $55, $55, $55, $55
	defb	$55, $55, $55, $55, $55, $55, $55, $55
	defb	$00, $00, $04, $00, $00, $00, $00, $04
	defb	$66, $66, $99, $9a, $66, $a6, $a9, $99
	defb	$66, $66, $99, $9a, $66, $a6, $a9, $99
	defb	$aa, $02, $96, $0a, $aa, $0a, $aa, $16
	defb	$aa, $aa, $96, $aa, $aa, $aa, $aa, $96
	defb	$80, $aa, $94, $aa, $a0, $aa, $a8, $96
	defb	$aa, $aa, $96, $aa, $aa, $aa, $aa, $96
	defb	$aa, $aa, $96, $aa, $aa, $aa, $aa, $96
	defb	$a8, $aa, $94, $aa, $a0, $aa, $80, $96
	defb	$aa, $aa, $96, $aa, $aa, $aa, $aa, $96
	defb	$aa, $2a, $96, $0a, $aa, $0a, $aa, $06
	defb	$66, $26, $99, $0a, $66, $06, $a9, $04
	defb	$26, $00, $19, $00, $06, $00, $00, $04
	defb	$00, $00, $04, $00, $00, $00, $00, $04
	defb	$66, $66, $99, $9a, $66, $a6, $a9, $99
	defb	$66, $66, $99, $9a, $66, $a6, $a9, $99
	defb	$00, $00, $04, $00, $00, $00, $00, $04
	defb	$00, $00, $05, $00, $26, $00, $a9, $04
	defb	$66, $02, $99, $0a, $66, $06, $a9, $19
	defb	$aa, $aa, $96, $aa, $aa, $aa, $aa, $96
	defb	$aa, $aa, $96, $aa, $aa, $aa, $aa, $96
	defb	$64, $66, $98, $9a, $60, $a6, $80, $99
	defb	$00, $66, $04, $98, $00, $a0, $00, $10
	defb	$00, $00, $04, $80, $00, $a8, $00, $9a
	defb	$80, $66, $a4, $9a, $60, $a6, $a8, $99
	defb	$00, $00, $04, $80, $00, $a8, $00, $96
	defb	$80, $aa, $94, $aa, $a0, $aa, $a8, $96
	defb	$00, $00, $06, $00, $2a, $00, $aa, $04
	defb	$aa, $02, $96, $0a, $aa, $0a, $aa, $16
	defb	$00, $00, $04, $00, $00, $00, $00, $04
	defb	$aa, $aa, $96, $aa, $aa, $aa, $aa, $96
	defb	$aa, $aa, $96, $aa, $aa, $aa, $aa, $96
	defb	$00, $00, $04, $00, $00, $00, $00, $04
;	fort6
	defb	$00, $00, $04, $00, $00, $fc, $00, $57
	defb	$c0, $5f, $74, $ff, $70, $5d, $70, $5d
	defb	$00, $00, $04, $00, $ff, $ff, $d5, $55
	defb	$d5, $ff, $ff, $55, $ff, $ff, $af, $57
	defb	$c0, $3f, $b4, $ea, $af, $aa, $ad, $aa
	defb	$bf, $ea, $dd, $fa, $ff, $bf, $55, $b5
	defb	$fc, $03, $ab, $0e, $aa, $fa, $aa, $7a
	defb	$ab, $fe, $af, $77, $fe, $ff, $5e, $55
	defb	$00, $00, $04, $00, $ff, $ff, $55, $57
	defb	$ff, $57, $55, $ff, $ff, $ff, $d5, $fa
	defb	$00, $00, $04, $00, $3f, $00, $d5, $00
	defb	$f5, $03, $ff, $0d, $75, $0d, $75, $0d
	defb	$70, $fd, $74, $7d, $f0, $ff, $f0, $55
	defb	$f0, $ff, $b4, $7e, $ac, $7a, $ac, $7a
	defb	$ab, $fe, $ab, $7e, $af, $77, $f7, $ff
	defb	$ff, $ea, $f5, $ea, $f5, $ea, $f5, $ea
	defb	$ff, $bf, $7d, $bd, $5d, $f5, $57, $d5
	defb	$55, $55, $55, $55, $57, $d5, $5d, $f5
	defb	$fe, $ff, $7e, $7d, $5f, $75, $57, $d5
	defb	$55, $55, $55, $55, $57, $d5, $5f, $75
	defb	$bf, $ea, $bd, $ea, $dd, $fa, $ff, $df
	defb	$ab, $ff, $ab, $5f, $ab, $5f, $ab, $5f
	defb	$7f, $0d, $7d, $0d, $ff, $0f, $55, $0f
	defb	$ff, $0f, $bd, $0e, $ad, $3a, $ad, $3a
	defb	$b0, $fe, $fc, $7f, $57, $75, $57, $75
	defb	$ff, $ff, $57, $77, $57, $77, $57, $77
	defb	$ff, $ff, $75, $ff, $f5, $5f, $f5, $5f
	defb	$ff, $ff, $ab, $57, $ab, $57, $ab, $57
	defb	$7f, $fd, $ff, $ff, $55, $d5, $55, $d5
	defb	$ff, $ff, $5d, $75, $5d, $75, $5d, $75
	defb	$7f, $fd, $ff, $ff, $57, $55, $57, $55
	defb	$ff, $ff, $5d, $75, $5d, $75, $5d, $75
	defb	$ff, $ff, $ff, $5d, $f5, $5f, $f5, $5f
	defb	$ff, $ff, $d5, $ea, $d5, $ea, $d5, $ea
	defb	$bf, $0e, $fd, $3f, $5d, $d5, $5d, $d5
	defb	$ff, $ff, $dd, $d5, $dd, $d5, $dd, $d5
	defb	$57, $77, $57, $77, $57, $77, $ff, $ff
	defb	$57, $75, $57, $75, $fc, $7f, $b0, $fe
	defb	$ab, $57, $ab, $57, $ab, $57, $ff, $ff
	defb	$f5, $5f, $f5, $5f, $75, $ff, $ff, $ff
	defb	$5d, $75, $5d, $75, $5d, $75, $ff, $ff
	defb	$55, $d5, $55, $d5, $ff, $ff, $7f, $fd
	defb	$5d, $75, $5d, $75, $5d, $75, $ff, $ff
	defb	$57, $55, $57, $55, $ff, $ff, $7f, $fd
	defb	$d5, $ea, $d5, $ea, $d5, $ea, $ff, $ff
	defb	$f5, $5f, $f5, $5f, $ff, $5d, $ff, $ff
	defb	$dd, $d5, $dd, $d5, $dd, $d5, $ff, $ff
	defb	$5d, $d5, $5d, $d5, $fd, $3f, $bf, $0e
	defb	$ac, $7a, $ac, $7a, $b0, $7e, $f0, $ff
	defb	$f0, $55, $f4, $ff, $70, $7d, $70, $fd
	defb	$f5, $ea, $f5, $ea, $f5, $ea, $ff, $ea
	defb	$f7, $ff, $af, $77, $ab, $7e, $ab, $fe
	defb	$5d, $f5, $57, $d5, $55, $55, $55, $55
	defb	$57, $d5, $5d, $f5, $7d, $bd, $ff, $bf
	defb	$5f, $75, $57, $d5, $55, $55, $55, $55
	defb	$57, $d5, $5f, $75, $7e, $7d, $fe, $ff
	defb	$ab, $5f, $ab, $5f, $ab, $5f, $ab, $ff
	defb	$ff, $df, $dd, $fa, $bd, $ea, $bf, $ea
	defb	$ad, $3a, $ad, $3a, $bd, $0e, $ff, $0f
	defb	$55, $0f, $ff, $0f, $7d, $0d, $7f, $0d
	defb	$70, $5d, $74, $5d, $70, $ff, $c0, $5f
	defb	$00, $57, $04, $fc, $00, $00, $00, $04
	defb	$af, $57, $ff, $ff, $ff, $55, $d5, $ff
	defb	$d5, $55, $ff, $ff, $00, $00, $00, $04
	defb	$55, $b5, $ff, $bf, $dd, $fa, $bf, $ea
	defb	$ad, $aa, $af, $aa, $b0, $ea, $c0, $3f
	defb	$5e, $55, $fe, $ff, $af, $77, $ab, $fe
	defb	$aa, $7a, $aa, $fa, $ab, $0e, $fc, $07
	defb	$d5, $fa, $ff, $ff, $55, $ff, $ff, $57
	defb	$55, $57, $ff, $ff, $00, $00, $00, $04
	defb	$75, $0d, $75, $0d, $ff, $0d, $f5, $03
	defb	$d5, $00, $3f, $00, $00, $00, $00, $04
;	fort7
	defb	$00, $00, $04, $00, $00, $00, $00, $04
	defb	$00, $00, $04, $00, $00, $fc, $00, $57
	defb	$00, $00, $04, $00, $00, $00, $00, $04
	defb	$00, $00, $04, $00, $ff, $ff, $d5, $55
	defb	$00, $00, $04, $00, $00, $00, $00, $04
	defb	$c0, $3f, $b4, $ea, $af, $aa, $ad, $aa
	defb	$00, $00, $04, $00, $00, $00, $00, $04
	defb	$fc, $03, $ab, $0e, $aa, $fa, $aa, $7a
	defb	$00, $00, $04, $00, $00, $00, $00, $04
	defb	$00, $00, $04, $00, $ff, $ff, $55, $57
	defb	$00, $00, $04, $00, $00, $00, $00, $04
	defb	$00, $00, $04, $00, $3f, $00, $d5, $00
	defb	$c0, $5f, $74, $ff, $70, $5d, $70, $5d
	defb	$70, $fd, $74, $7d, $f0, $ff, $f0, $55
	defb	$d5, $ff, $ff, $55, $ff, $ff, $af, $57
	defb	$ab, $fe, $ab, $7e, $af, $77, $f7, $ff
	defb	$bf, $ea, $dd, $fa, $ff, $bf, $55, $b5
	defb	$ff, $bf, $7d, $bd, $5d, $f5, $57, $d5
	defb	$ab, $fe, $af, $77, $fe, $ff, $5e, $55
	defb	$fe, $ff, $7e, $7d, $5f, $75, $57, $d5
	defb	$ff, $57, $55, $ff, $ff, $ff, $d5, $fa
	defb	$bf, $ea, $bd, $ea, $dd, $fa, $ff, $df
	defb	$f5, $03, $ff, $0d, $75, $0d, $75, $0d
	defb	$7f, $0d, $7d, $0d, $ff, $0f, $55, $0f
	defb	$f0, $ff, $b4, $7e, $ac, $7a, $ac, $7a
	defb	$b0, $fe, $fc, $7f, $57, $75, $57, $75
	defb	$ff, $ea, $f5, $ea, $f5, $ea, $f5, $ea
	defb	$ff, $ff, $75, $ff, $f5, $5f, $f5, $5f
	defb	$55, $55, $55, $55, $57, $d5, $5d, $f5
	defb	$7f, $fd, $ff, $ff, $55, $d5, $55, $d5
	defb	$55, $55, $55, $55, $57, $d5, $5f, $75
	defb	$7f, $fd, $ff, $ff, $57, $55, $57, $55
	defb	$ab, $ff, $ab, $5f, $ab, $5f, $ab, $5f
	defb	$ff, $ff, $ff, $5d, $f5, $5f, $f5, $5f
	defb	$ff, $0f, $bd, $0e, $ad, $3a, $ad, $3a
	defb	$bf, $0e, $fd, $3f, $5d, $d5, $5d, $d5
	defb	$ff, $ff, $57, $77, $57, $77, $57, $77
	defb	$57, $77, $57, $77, $57, $77, $ff, $ff
	defb	$ff, $ff, $ab, $57, $ab, $57, $ab, $57
	defb	$ab, $57, $ab, $57, $ab, $57, $ff, $ff
	defb	$ff, $ff, $5d, $75, $5d, $75, $5d, $75
	defb	$5d, $75, $5d, $75, $5d, $75, $ff, $ff
	defb	$ff, $ff, $5d, $75, $5d, $75, $5d, $75
	defb	$5d, $75, $5d, $75, $5d, $75, $ff, $ff
	defb	$ff, $ff, $d5, $ea, $d5, $ea, $d5, $ea
	defb	$d5, $ea, $d5, $ea, $d5, $ea, $ff, $ff
	defb	$ff, $ff, $dd, $d5, $dd, $d5, $dd, $d5
	defb	$dd, $d5, $dd, $d5, $dd, $d5, $ff, $ff
	defb	$57, $75, $57, $75, $fc, $7f, $b0, $fe
	defb	$ac, $7a, $ac, $7a, $b0, $7e, $f0, $ff
	defb	$f5, $5f, $f5, $5f, $75, $ff, $ff, $ff
	defb	$f5, $ea, $f5, $ea, $f5, $ea, $ff, $ea
	defb	$55, $d5, $55, $d5, $ff, $ff, $7f, $fd
	defb	$5d, $f5, $57, $d5, $55, $55, $55, $55
	defb	$57, $55, $57, $55, $ff, $ff, $7f, $fd
	defb	$5f, $75, $57, $d5, $55, $55, $55, $55
	defb	$f5, $5f, $f5, $5f, $ff, $5d, $ff, $ff
	defb	$ab, $5f, $ab, $5f, $ab, $5f, $ab, $ff
	defb	$5d, $d5, $5d, $d5, $fd, $3f, $bf, $0e
	defb	$ad, $3a, $ad, $3a, $bd, $0e, $ff, $0f
	defb	$f0, $55, $f4, $ff, $70, $7d, $70, $fd
	defb	$70, $5d, $74, $5d, $70, $ff, $c0, $5f
	defb	$f7, $ff, $af, $77, $ab, $7e, $ab, $fe
	defb	$af, $57, $ff, $ff, $ff, $55, $d5, $ff
	defb	$57, $d5, $5d, $f5, $7d, $bd, $ff, $bf
	defb	$55, $b5, $ff, $bf, $dd, $fa, $bf, $ea
	defb	$57, $d5, $5f, $75, $7e, $7d, $fe, $ff
	defb	$5e, $55, $fe, $ff, $af, $77, $ab, $fe
	defb	$ff, $df, $dd, $fa, $bd, $ea, $bf, $ea
	defb	$d5, $fa, $ff, $ff, $55, $ff, $ff, $57
	defb	$55, $0f, $ff, $0f, $7d, $0d, $7f, $0d
	defb	$75, $0d, $75, $0d, $ff, $0d, $f5, $03
	defb	$00, $57, $04, $fc, $00, $00, $00, $04
	defb	$00, $00, $04, $00, $00, $00, $00, $04
	defb	$d5, $55, $ff, $ff, $00, $00, $00, $04
	defb	$00, $00, $04, $00, $00, $00, $00, $04
	defb	$ad, $aa, $af, $aa, $b0, $ea, $c0, $3f
	defb	$00, $00, $04, $00, $00, $00, $00, $04
	defb	$aa, $7a, $aa, $fa, $ab, $0e, $fc, $07
	defb	$00, $00, $04, $00, $00, $00, $00, $04
	defb	$55, $57, $ff, $ff, $00, $00, $00, $04
	defb	$00, $00, $04, $00, $00, $00, $00, $04
	defb	$d5, $00, $3f, $00, $00, $00, $00, $04
	defb	$00, $00, $04, $00, $00, $00, $00, $04

SpritePattern: public SpritePattern
;	sprite
	defb	$c0, $c0, $00, $00, $00, $00, $00, $00
	defb	$f0, $30, $03, $03, $00, $00, $00, $00
	defb	$f0, $30, $03, $03, $00, $00, $00, $00
	defb	$f0, $30, $03, $03, $00, $00, $00, $00
	defb	$f0, $30, $03, $03, $00, $00, $00, $00
	defb	$f0, $30, $03, $03, $00, $00, $00, $00
	defb	$f0, $30, $03, $03, $00, $00, $00, $00
	defb	$c0, $c0, $00, $00, $00, $00, $00, $00
	defb	$00, $00, $00, $00, $00, $00, $00, $00
	defb	$00, $00, $00, $00, $00, $00, $00, $00
	defb	$00, $00, $00, $00, $00, $00, $00, $00
	defb	$00, $00, $00, $00, $00, $00, $00, $00
	defb	$00, $00, $00, $00, $00, $00, $00, $00
	defb	$00, $00, $00, $00, $00, $00, $00, $00
	defb	$00, $00, $00, $00, $00, $00, $00, $00
	defb	$00, $00, $00, $00, $00, $00, $00, $00
	defb	$00, $00, $00, $00, $00, $00, $00, $00
	defb	$f0, $f0, $0f, $0f, $00, $00, $00, $00
	defb	$fc, $7c, $3f, $3d, $00, $00, $00, $00
	defb	$fc, $5c, $3f, $35, $00, $00, $00, $00
	defb	$fc, $5c, $3f, $35, $00, $00, $00, $00
	defb	$fc, $7c, $3f, $3d, $00, $00, $00, $00
	defb	$f0, $f0, $0f, $0f, $00, $00, $00, $00
	defb	$00, $00, $00, $00, $00, $00, $00, $00
	defb	$00, $00, $00, $00, $00, $00, $00, $00
	defb	$00, $00, $00, $00, $00, $00, $00, $00
	defb	$00, $00, $00, $00, $00, $00, $00, $00
	defb	$00, $00, $00, $00, $00, $00, $00, $00
	defb	$00, $00, $00, $00, $00, $00, $00, $00
	defb	$00, $00, $00, $00, $00, $00, $00, $00
	defb	$00, $00, $00, $00, $00, $00, $00, $00
	defb	$00, $00, $00, $00, $00, $00, $00, $00
	defb	$f0, $f0, $0f, $0f, $00, $00, $00, $00
	defb	$fc, $0c, $3f, $30, $00, $00, $00, $00
	defb	$ff, $83, $ff, $c2, $ff, $ff, $ff, $ff
	defb	$ff, $a3, $ff, $ca, $ff, $55, $ff, $55
	defb	$ff, $a3, $ff, $ca, $ff, $55, $ff, $55
	defb	$ff, $83, $ff, $c2, $ff, $ff, $ff, $ff
	defb	$fc, $0c, $3f, $30, $00, $00, $00, $00
	defb	$f0, $f0, $0f, $0f, $00, $00, $00, $00
	defb	$00, $00, $00, $00, $00, $00, $00, $00
	defb	$00, $00, $00, $00, $00, $00, $00, $00
	defb	$00, $00, $00, $00, $00, $00, $00, $00
	defb	$00, $00, $00, $00, $00, $00, $00, $00
	defb	$00, $00, $00, $00, $00, $00, $00, $00
	defb	$00, $00, $00, $00, $00, $00, $00, $00
	defb	$00, $00, $00, $00, $00, $00, $00, $00
	defb	$00, $00, $00, $00, $00, $00, $00, $00
	defb	$00, $00, $00, $00, $00, $00, $00, $00
	defb	$00, $00, $00, $00, $00, $00, $00, $00
	defb	$ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff
	defb	$ff, $55, $ff, $55, $ff, $55, $ff, $55
	defb	$ff, $55, $ff, $55, $ff, $55, $ff, $55
	defb	$ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff
	defb	$00, $00, $00, $00, $00, $00, $00, $00
	defb	$00, $00, $00, $00, $00, $00, $00, $00
	defb	$00, $00, $00, $00, $00, $00, $00, $00
	defb	$00, $00, $00, $00, $00, $00, $00, $00
	defb	$00, $00, $00, $00, $00, $00, $00, $00
	defb	$00, $00, $00, $00, $00, $00, $00, $00
	defb	$00, $00, $00, $00, $00, $00, $00, $00
	defb	$00, $00, $00, $00, $00, $00, $00, $00
	defb	$00, $00, $00, $00, $00, $00, $00, $00
	defb	$00, $00, $00, $00, $00, $00, $00, $00
	defb	$00, $00, $00, $00, $f0, $f0, $0f, $0f
	defb	$00, $00, $00, $00, $fc, $0c, $3f, $30
	defb	$ff, $ff, $ff, $ff, $ff, $83, $ff, $c2
	defb	$ff, $55, $ff, $55, $ff, $a3, $ff, $ca
	defb	$ff, $55, $ff, $55, $ff, $a3, $ff, $ca
	defb	$ff, $ff, $ff, $ff, $ff, $83, $ff, $c2
	defb	$00, $00, $00, $00, $fc, $0c, $3f, $30
	defb	$00, $00, $00, $00, $f0, $f0, $0f, $0f
	defb	$00, $00, $00, $00, $00, $00, $00, $00
	defb	$00, $00, $00, $00, $00, $00, $00, $00
	defb	$00, $00, $00, $00, $00, $00, $00, $00
	defb	$00, $00, $00, $00, $00, $00, $00, $00
	defb	$00, $00, $00, $00, $00, $00, $00, $00
	defb	$00, $00, $00, $00, $00, $00, $00, $00
	defb	$00, $00, $00, $00, $00, $00, $00, $00
	defb	$00, $00, $00, $00, $00, $00, $00, $00
	defb	$00, $00, $c0, $c0, $00, $00, $0c, $0c
	defb	$30, $30, $c0, $c0, $c3, $c3, $0f, $0f
	defb	$f0, $f0, $f0, $f0, $ff, $ff, $03, $03
	defb	$f0, $f0, $ff, $bf, $ff, $ff, $c3, $c3
	defb	$f0, $b0, $ff, $ae, $ff, $be, $ff, $ff
	defb	$ff, $bf, $ff, $6a, $ff, $aa, $3f, $3f
	defb	$fc, $fc, $ff, $56, $ff, $e9, $0f, $0f
	defb	$f0, $f0, $ff, $5b, $ff, $f9, $03, $03
	defb	$c0, $c0, $ff, $5b, $ff, $e5, $0f, $0f
	defb	$f0, $f0, $ff, $aa, $ff, $a5, $ff, $ff
	defb	$ff, $bf, $ff, $ba, $ff, $aa, $3f, $3f
	defb	$fc, $bc, $ff, $bf, $ff, $ae, $03, $03
	defb	$f0, $f0, $ff, $bf, $ff, $bf, $0f, $0f
	defb	$c0, $c0, $f3, $f3, $ff, $ff, $0f, $0f
	defb	$c0, $c0, $c0, $c0, $03, $03, $0f, $0f
	defb	$00, $00, $c0, $c0, $00, $00, $00, $00
	defb	$00, $00, $00, $00, $00, $00, $30, $30
	defb	$00, $00, $00, $00, $00, $00, $fc, $fc
	defb	$00, $00, $03, $03, $00, $00, $fc, $fc
	defb	$00, $00, $3f, $3f, $00, $00, $ff, $ff
	defb	$00, $00, $fc, $fc, $c3, $c3, $ff, $ef
	defb	$00, $00, $fc, $fc, $ff, $ff, $ff, $af
	defb	$00, $00, $fc, $bc, $ff, $fe, $ff, $ab
	defb	$00, $00, $f0, $f0, $ff, $fa, $ff, $ab
	defb	$00, $00, $f0, $f0, $ff, $ea, $ff, $9a
	defb	$c0, $c0, $ff, $ff, $ff, $ab, $ff, $9a
	defb	$ff, $ff, $ff, $fa, $ff, $6b, $ff, $55
	defb	$fc, $fc, $ff, $ab, $ff, $5a, $ff, $51
	defb	$f0, $f0, $ff, $bf, $ff, $56, $ff, $41
	defb	$c0, $c0, $ff, $ff, $ff, $6a, $ff, $41
	defb	$00, $00, $ff, $ff, $ff, $6b, $ff, $01
	defb	$00, $00, $fc, $bc, $ff, $5a, $ff, $00
	defb	$00, $00, $00, $00, $3c, $3c, $00, $00
	defb	$00, $00, $00, $00, $3f, $3f, $00, $00
	defb	$00, $00, $c0, $c0, $0f, $0f, $00, $00
	defb	$03, $03, $fc, $fc, $0f, $0f, $00, $00
	defb	$03, $03, $ff, $ff, $0f, $0f, $00, $00
	defb	$cf, $cf, $ff, $ff, $03, $03, $00, $00
	defb	$ff, $ff, $ff, $ef, $03, $03, $3f, $3f
	defb	$ff, $fe, $ff, $eb, $f3, $f3, $0f, $0f
	defb	$ff, $fe, $ff, $ea, $ff, $ff, $03, $03
	defb	$ff, $ba, $ff, $e6, $ff, $ff, $03, $03
	defb	$ff, $aa, $ff, $a5, $ff, $fa, $00, $00
	defb	$ff, $69, $ff, $a5, $3f, $3f, $00, $00
	defb	$ff, $55, $ff, $a9, $0f, $0f, $00, $00
	defb	$ff, $40, $ff, $e9, $0f, $0f, $00, $00
	defb	$ff, $40, $ff, $ea, $3f, $3f, $00, $00
	defb	$ff, $50, $ff, $a9, $ff, $ff, $00, $00
	defb	$00, $00, $fc, $ac, $ff, $3e, $ff, $0c
	defb	$00, $00, $ff, $eb, $ff, $0f, $ff, $3f
	defb	$f0, $f0, $ff, $eb, $ff, $c3, $ff, $3f
	defb	$fc, $fc, $ff, $fa, $ff, $ff, $ff, $ff
	defb	$ff, $bf, $ff, $aa, $ff, $fe, $ff, $ef
	defb	$fc, $fc, $ff, $ff, $ff, $ba, $ff, $ea
	defb	$f0, $f0, $ff, $ff, $ff, $be, $ff, $ea
	defb	$00, $00, $ff, $bf, $ff, $ea, $ff, $af
	defb	$00, $00, $fc, $bc, $ff, $fe, $ff, $af
	defb	$00, $00, $f0, $b0, $3f, $3f, $ff, $bf
	defb	$00, $00, $f0, $f0, $0f, $0f, $ff, $bf
	defb	$00, $00, $f0, $f0, $00, $00, $fc, $bc
	defb	$00, $00, $30, $30, $00, $00, $fc, $fc
	defb	$00, $00, $00, $00, $00, $00, $f0, $f0
	defb	$00, $00, $00, $00, $00, $00, $f0, $f0
	defb	$00, $00, $00, $00, $00, $00, $30, $30
	defb	$ff, $fc, $ff, $ff, $ff, $fa, $03, $03
	defb	$ff, $bc, $ff, $aa, $ff, $aa, $0f, $0f
	defb	$ff, $ff, $ff, $aa, $ff, $ff, $3f, $3f
	defb	$ff, $ff, $ff, $fa, $ff, $ff, $ff, $ff
	defb	$ff, $eb, $ff, $fb, $ff, $ff, $00, $00
	defb	$ff, $aa, $ff, $eb, $03, $03, $00, $00
	defb	$ff, $ba, $ff, $ea, $03, $03, $00, $00
	defb	$ff, $fa, $ff, $ab, $0f, $0f, $00, $00
	defb	$ff, $fe, $ff, $af, $0f, $0f, $00, $00
	defb	$ff, $ff, $ff, $ff, $0f, $0f, $00, $00
	defb	$3f, $3f, $f0, $f0, $3f, $3f, $00, $00
	defb	$0f, $0f, $c0, $c0, $3f, $3f, $00, $00
	defb	$03, $03, $00, $00, $3c, $3c, $00, $00
	defb	$00, $00, $00, $00, $00, $00, $00, $00
	defb	$00, $00, $00, $00, $00, $00, $00, $00
	defb	$00, $00, $00, $00, $00, $00, $00, $00
	defb	$00, $00, $00, $00, $00, $00, $00, $00
	defb	$00, $00, $00, $00, $00, $00, $00, $00
	defb	$c0, $c0, $ff, $ff, $ff, $ff, $03, $03
	defb	$f0, $70, $ff, $55, $ff, $55, $0f, $0d
	defb	$fc, $5c, $ff, $55, $ff, $55, $3f, $35
	defb	$ff, $d7, $ff, $5d, $ff, $f7, $ff, $d7
	defb	$ff, $f7, $ff, $5d, $ff, $77, $ff, $dd
	defb	$ff, $d7, $ff, $5d, $ff, $77, $ff, $dd
	defb	$ff, $d7, $ff, $5d, $ff, $f7, $ff, $d7
	defb	$ff, $d7, $ff, $5d, $ff, $77, $ff, $d5
	defb	$ff, $f7, $ff, $f7, $ff, $75, $ff, $d5
	defb	$fc, $5c, $ff, $55, $ff, $55, $3f, $35
	defb	$f0, $70, $ff, $55, $ff, $55, $0f, $0d
	defb	$c0, $c0, $ff, $ff, $ff, $ff, $03, $03
	defb	$00, $00, $00, $00, $00, $00, $00, $00
	defb	$00, $00, $00, $00, $00, $00, $00, $00
	defb	$c0, $c0, $00, $00, $c0, $c0, $00, $00
	defb	$f0, $30, $03, $03, $f0, $30, $03, $03
	defb	$f0, $30, $03, $03, $f0, $30, $03, $03
	defb	$fc, $0c, $c3, $c3, $f0, $30, $0f, $0c
	defb	$fc, $0c, $f3, $33, $f3, $33, $0f, $0c
	defb	$ff, $03, $ff, $8f, $ff, $3c, $3f, $30
	defb	$ff, $03, $ff, $23, $ff, $32, $3f, $30
	defb	$ff, $03, $ff, $03, $ff, $30, $3f, $30
	defb	$ff, $03, $ff, $03, $ff, $30, $3f, $30
	defb	$ff, $03, $ff, $03, $ff, $30, $3f, $30
	defb	$ff, $03, $ff, $03, $ff, $30, $3f, $30
	defb	$ff, $c3, $fc, $0c, $cf, $cc, $3f, $30
	defb	$fc, $cc, $f0, $f0, $c3, $c3, $0f, $0c
	defb	$f0, $b0, $00, $00, $c0, $80, $03, $03
	defb	$00, $00, $00, $00, $00, $00, $00, $00
	defb	$00, $00, $00, $00, $00, $00, $00, $00
	defb	$00, $00, $c0, $c0, $00, $00, $00, $00
	defb	$00, $00, $f0, $70, $03, $03, $00, $00
	defb	$00, $00, $fc, $5c, $0f, $0d, $00, $00
	defb	$00, $00, $fc, $5c, $0f, $0d, $00, $00
	defb	$00, $00, $ff, $f7, $3f, $37, $00, $00
	defb	$0c, $0c, $ff, $57, $3f, $35, $0c, $0c
	defb	$3f, $37, $ff, $57, $3f, $35, $3f, $37
	defb	$ff, $d7, $ff, $fd, $ff, $df, $3f, $35
	defb	$ff, $57, $ff, $55, $ff, $55, $3f, $35
	defb	$fc, $5c, $ff, $55, $ff, $55, $0f, $0d
	defb	$f0, $70, $ff, $5d, $ff, $5d, $03, $03
	defb	$c0, $c0, $ff, $f5, $ff, $d7, $00, $00
	defb	$00, $00, $ff, $57, $3f, $35, $00, $00
	defb	$00, $00, $fc, $5c, $0f, $0d, $00, $00
	defb	$00, $00, $f0, $f0, $03, $03, $00, $00
	defb	$00, $00, $00, $00, $00, $00, $00, $00
	defb	$00, $00, $00, $00, $00, $00, $00, $00
	defb	$00, $00, $f0, $f0, $03, $03, $00, $00
	defb	$00, $00, $fc, $5c, $0f, $0d, $00, $00
	defb	$00, $00, $ff, $f7, $3f, $37, $00, $00
	defb	$00, $00, $ff, $5f, $3f, $3d, $00, $00
	defb	$f0, $f0, $ff, $57, $ff, $f5, $03, $03
	defb	$fc, $ac, $ff, $57, $ff, $b5, $0f, $0e
	defb	$fc, $ac, $ff, $57, $ff, $b5, $0f, $0e
	defb	$ff, $ab, $ff, $57, $ff, $b5, $3f, $3a
	defb	$ff, $eb, $ff, $d7, $ff, $f5, $3f, $3a
	defb	$3c, $3c, $ff, $f7, $3f, $37, $0f, $0f
	defb	$00, $00, $cc, $cc, $0c, $0c, $00, $00
	defb	$00, $00, $c0, $c0, $00, $00, $00, $00
	defb	$00, $00, $c0, $c0, $00, $00, $00, $00
	defb	$00, $00, $c0, $c0, $00, $00, $00, $00
	defb	$00, $00, $00, $00, $00, $00, $00, $00
	defb	$00, $00, $00, $00, $00, $00, $00, $00
	defb	$00, $00, $00, $00, $ff, $ff, $00, $00
	defb	$f0, $f0, $ff, $ff, $ff, $55, $03, $03
	defb	$fc, $ac, $ff, $7a, $ff, $7f, $0f, $0d
	defb	$ff, $ab, $ff, $7a, $ff, $f5, $0f, $0d
	defb	$fc, $fc, $ff, $5e, $ff, $d5, $0f, $0d
	defb	$00, $00, $ff, $57, $ff, $d5, $0f, $0d
	defb	$c0, $c0, $ff, $55, $ff, $55, $03, $03
	defb	$c0, $c0, $ff, $7f, $ff, $f5, $03, $03
	defb	$00, $00, $fc, $7c, $ff, $ad, $03, $03
	defb	$00, $00, $f3, $73, $ff, $ab, $03, $03
	defb	$c0, $c0, $f0, $f0, $fc, $ac, $03, $03
	defb	$00, $00, $00, $00, $fc, $ac, $03, $03
	defb	$00, $00, $00, $00, $fc, $ec, $00, $00
	defb	$00, $00, $00, $00, $30, $30, $00, $00
	defb	$00, $00, $00, $00, $00, $00, $00, $00
	defb	$00, $00, $f0, $f0, $00, $00, $00, $00
	defb	$00, $00, $fc, $ac, $0f, $0f, $00, $00
	defb	$00, $00, $fc, $ac, $3f, $3a, $00, $00
	defb	$00, $00, $f0, $b0, $3f, $3a, $00, $00
	defb	$00, $00, $fc, $fc, $ff, $ff, $03, $03
	defb	$00, $00, $ff, $57, $ff, $d5, $0f, $0d
	defb	$00, $00, $fc, $5c, $ff, $55, $3f, $37
	defb	$fc, $fc, $ff, $7f, $ff, $55, $3f, $37
	defb	$00, $00, $fc, $5c, $ff, $55, $3f, $37
	defb	$00, $00, $ff, $57, $ff, $d5, $0f, $0d
	defb	$00, $00, $fc, $fc, $ff, $ff, $03, $03
	defb	$00, $00, $f0, $b0, $3f, $3a, $00, $00
	defb	$00, $00, $fc, $ac, $3f, $3a, $00, $00
	defb	$00, $00, $fc, $ac, $0f, $0f, $00, $00
	defb	$00, $00, $f0, $f0, $00, $00, $00, $00
	defb	$00, $00, $00, $00, $00, $00, $00, $00
	defb	$00, $00, $00, $00, $c0, $c0, $00, $00
	defb	$00, $00, $00, $00, $f0, $b0, $03, $03
	defb	$00, $00, $00, $00, $f0, $b0, $0f, $0e
	defb	$00, $00, $c3, $c3, $f3, $b3, $0f, $0e
	defb	$00, $00, $cc, $cc, $ff, $ad, $0f, $0e
	defb	$00, $00, $f0, $f0, $ff, $b5, $0f, $0e
	defb	$00, $00, $ff, $ff, $ff, $d5, $0f, $0f
	defb	$00, $00, $ff, $57, $ff, $55, $0f, $0d
	defb	$00, $00, $fc, $5c, $ff, $55, $3f, $37
	defb	$f0, $f0, $ff, $7b, $ff, $55, $3f, $37
	defb	$fc, $ac, $ff, $ea, $ff, $d5, $3f, $37
	defb	$f0, $b0, $ff, $ea, $ff, $fd, $3f, $35
	defb	$c0, $c0, $ff, $ff, $ff, $57, $0f, $0d
	defb	$00, $00, $00, $00, $fc, $fc, $03, $03
	defb	$00, $00, $00, $00, $00, $00, $00, $00
	defb	$00, $00, $00, $00, $00, $00, $00, $00
	defb	$00, $00, $00, $00, $00, $00, $00, $00
	defb	$00, $00, $00, $00, $03, $03, $00, $00
	defb	$00, $00, $00, $00, $03, $03, $00, $00
	defb	$00, $00, $00, $00, $03, $03, $00, $00
	defb	$00, $00, $30, $30, $33, $33, $00, $00
	defb	$f0, $f0, $fc, $dc, $ff, $df, $3c, $3c
	defb	$fc, $ac, $ff, $5f, $ff, $d7, $ff, $eb
	defb	$fc, $ac, $ff, $5e, $ff, $d5, $ff, $ea
	defb	$f0, $b0, $ff, $5e, $ff, $d5, $3f, $3a
	defb	$f0, $b0, $ff, $5e, $ff, $d5, $3f, $3a
	defb	$c0, $c0, $ff, $5f, $ff, $d5, $0f, $0f
	defb	$00, $00, $fc, $7c, $ff, $f5, $00, $00
	defb	$00, $00, $fc, $dc, $ff, $df, $00, $00
	defb	$00, $00, $f0, $70, $3f, $35, $00, $00
	defb	$00, $00, $c0, $c0, $0f, $0f, $00, $00
	defb	$00, $00, $00, $00, $00, $00, $00, $00
	defb	$00, $00, $0c, $0c, $00, $00, $00, $00
	defb	$00, $00, $3f, $3b, $00, $00, $00, $00
	defb	$c0, $c0, $3f, $3a, $00, $00, $00, $00
	defb	$c0, $c0, $3f, $3a, $0f, $0f, $03, $03
	defb	$c0, $c0, $ff, $ea, $cf, $cd, $00, $00
	defb	$c0, $c0, $ff, $7a, $3f, $3d, $00, $00
	defb	$c0, $c0, $ff, $5f, $ff, $fd, $03, $03
	defb	$c0, $c0, $ff, $55, $ff, $55, $03, $03
	defb	$f0, $70, $ff, $57, $ff, $d5, $00, $00
	defb	$f0, $70, $ff, $57, $ff, $b5, $3f, $3f
	defb	$f0, $70, $ff, $5f, $ff, $ad, $ff, $ea
	defb	$f0, $70, $ff, $fd, $ff, $ad, $3f, $3a
	defb	$c0, $c0, $ff, $55, $ff, $ff, $0f, $0f
	defb	$00, $00, $ff, $ff, $00, $00, $00, $00
	defb	$00, $00, $00, $00, $00, $00, $00, $00
	defb	$00, $00, $00, $00, $00, $00, $00, $00
	defb	$00, $00, $00, $00, $00, $00, $00, $00
	defb	$00, $00, $00, $00, $0f, $0f, $00, $00
	defb	$00, $00, $f0, $f0, $3f, $3a, $00, $00
	defb	$00, $00, $fc, $ac, $3f, $3a, $00, $00
	defb	$00, $00, $fc, $ac, $0f, $0e, $00, $00
	defb	$c0, $c0, $ff, $ff, $3f, $3f, $00, $00
	defb	$f0, $70, $ff, $57, $ff, $d5, $00, $00
	defb	$fc, $dc, $ff, $55, $3f, $35, $00, $00
	defb	$fc, $dc, $ff, $55, $ff, $fd, $3f, $3f
	defb	$fc, $dc, $ff, $55, $3f, $35, $00, $00
	defb	$f0, $70, $ff, $57, $ff, $d5, $00, $00
	defb	$c0, $c0, $ff, $ff, $3f, $3f, $00, $00
	defb	$00, $00, $fc, $ac, $0f, $0e, $00, $00
	defb	$00, $00, $fc, $ac, $3f, $3a, $00, $00
	defb	$00, $00, $f0, $f0, $3f, $3a, $00, $00
	defb	$00, $00, $00, $00, $0f, $0f, $00, $00
	defb	$00, $00, $00, $00, $00, $00, $00, $00
	defb	$00, $00, $00, $00, $00, $00, $00, $00
	defb	$c0, $c0, $3f, $3f, $00, $00, $00, $00
	defb	$f0, $70, $ff, $d5, $ff, $ff, $03, $03
	defb	$fc, $5c, $ff, $7f, $ff, $ab, $0f, $0e
	defb	$fc, $dc, $ff, $57, $ff, $ab, $3f, $3a
	defb	$fc, $dc, $ff, $55, $ff, $ed, $0f, $0f
	defb	$fc, $dc, $ff, $55, $3f, $35, $00, $00
	defb	$f0, $70, $ff, $55, $ff, $d5, $00, $00
	defb	$f0, $f0, $ff, $57, $ff, $ff, $00, $00
	defb	$f0, $b0, $ff, $5e, $0f, $0f, $00, $00
	defb	$f0, $b0, $ff, $7a, $33, $33, $00, $00
	defb	$f0, $b0, $cf, $ce, $c3, $c3, $00, $00
	defb	$f0, $b0, $0f, $0e, $00, $00, $00, $00
	defb	$c0, $c0, $0f, $0e, $00, $00, $00, $00
	defb	$00, $00, $03, $03, $00, $00, $00, $00
	defb	$0c, $0c, $00, $00, $00, $00, $0c, $0c
	defb	$3f, $3b, $f0, $f0, $03, $03, $3f, $3b
	defb	$ff, $eb, $fc, $5c, $cf, $cd, $3f, $3a
	defb	$ff, $ab, $ff, $57, $ff, $b5, $3f, $3a
	defb	$ff, $eb, $ff, $f5, $ff, $d7, $3f, $3a
	defb	$fc, $ec, $ff, $5d, $ff, $dd, $0f, $0e
	defb	$f0, $f0, $ff, $55, $ff, $d5, $03, $03
	defb	$c0, $c0, $ff, $55, $ff, $d5, $00, $00
	defb	$f0, $f0, $ff, $55, $ff, $d5, $03, $03
	defb	$fc, $ec, $ff, $5d, $ff, $dd, $0f, $0e
	defb	$ff, $eb, $ff, $f5, $ff, $d7, $3f, $3a
	defb	$ff, $ab, $ff, $57, $ff, $b5, $3f, $3a
	defb	$ff, $eb, $fc, $5c, $cf, $cd, $3f, $3a
	defb	$3f, $3b, $f0, $f0, $03, $03, $3f, $3b
	defb	$0c, $0c, $00, $00, $00, $00, $0c, $0c
	defb	$00, $00, $00, $00, $00, $00, $00, $00
	defb	$fc, $fc, $ff, $ff, $ff, $ff, $0f, $0f
	defb	$ff, $5f, $ff, $55, $ff, $55, $3f, $3d
	defb	$ff, $77, $ff, $55, $ff, $55, $3f, $3b
	defb	$ff, $d7, $ff, $ff, $ff, $ff, $3f, $3a
	defb	$ff, $d7, $ff, $f5, $ff, $d7, $3f, $3a
	defb	$ff, $d7, $ff, $dd, $ff, $dd, $3f, $3a
	defb	$ff, $d7, $ff, $57, $ff, $f5, $3f, $3a
	defb	$ff, $d7, $ff, $5f, $ff, $fd, $3f, $3a
	defb	$ff, $d7, $ff, $57, $ff, $f5, $3f, $3a
	defb	$ff, $d7, $ff, $dd, $ff, $dd, $3f, $3a
	defb	$ff, $d7, $ff, $f5, $ff, $d7, $3f, $3a
	defb	$ff, $d7, $ff, $ff, $ff, $ff, $3f, $3a
	defb	$ff, $b7, $ff, $aa, $ff, $aa, $3f, $3a
	defb	$ff, $af, $ff, $aa, $ff, $aa, $3f, $3e
	defb	$fc, $fc, $ff, $ff, $ff, $ff, $0f, $0f
	defb	$00, $00, $00, $00, $00, $00, $00, $00
	defb	$fc, $fc, $00, $00, $c0, $c0, $0f, $0f
	defb	$ff, $57, $ff, $ff, $ff, $7f, $3f, $35
	defb	$ff, $d7, $ff, $55, $ff, $d5, $3f, $35
	defb	$ff, $77, $ff, $55, $ff, $55, $3f, $37
	defb	$fc, $5c, $ff, $f5, $ff, $57, $0f, $0e
	defb	$fc, $5c, $ff, $dd, $ff, $5d, $0f, $0e
	defb	$fc, $5c, $ff, $57, $ff, $75, $0f, $0e
	defb	$fc, $5c, $ff, $5f, $ff, $7d, $0f, $0e
	defb	$fc, $5c, $ff, $57, $ff, $75, $0f, $0e
	defb	$fc, $5c, $ff, $dd, $ff, $5d, $0f, $0e
	defb	$fc, $5c, $ff, $f5, $ff, $97, $0f, $0e
	defb	$ff, $77, $ff, $55, $ff, $a5, $3f, $37
	defb	$ff, $d7, $ff, $aa, $ff, $ea, $3f, $35
	defb	$ff, $57, $ff, $ff, $ff, $7f, $3f, $35
	defb	$fc, $fc, $00, $00, $c0, $c0, $0f, $0f
	defb	$00, $00, $00, $00, $00, $00, $00, $00
