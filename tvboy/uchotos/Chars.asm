cseg

AsciiPattern: public AsciiPattern
	; ascii 28
	; " 0123456789ABCEFGHIMNOPRSTUV"
	defb $aa,$aa,$aa,$aa,$aa,$aa,$56,$66
	defb $66,$66,$56,$aa,$a6,$a6,$a6,$a6
	defb $a6,$aa,$56,$a6,$56,$6a,$56,$aa
	defb $56,$a6,$56,$a6,$56,$aa,$66,$66
	defb $56,$a6,$a6,$aa,$56,$6a,$56,$a6
	defb $56,$aa,$56,$6a,$56,$66,$56,$aa
	defb $56,$a6,$9a,$9a,$9a,$aa,$56,$66
	defb $56,$66,$56,$aa,$56,$66,$56,$a6
	defb $56,$aa,$9a,$66,$66,$56,$66,$aa
	defb $5a,$66,$5a,$66,$5a,$aa,$9a,$66
	defb $6a,$66,$9a,$aa,$56,$6a,$5a,$6a
	defb $56,$aa,$56,$6a,$5a,$6a,$6a,$aa
	defb $96,$6a,$66,$66,$9a,$aa,$66,$66
	defb $56,$66,$66,$aa,$56,$9a,$9a,$9a
	defb $56,$aa,$66,$56,$56,$66,$66,$aa
	defb $5a,$66,$66,$66,$66,$aa,$9a,$66
	defb $66,$66,$9a,$aa,$5a,$66,$5a,$6a
	defb $6a,$aa,$5a,$66,$5a,$66,$66,$aa
	defb $96,$6a,$56,$a6,$5a,$aa,$56,$9a
	defb $9a,$9a,$9a,$aa,$66,$66,$66,$66
	defb $56,$aa,$66,$66,$66,$66,$9a,$aa

CharPattern: public CharPattern
	;logo
	defb $aa,$aa,$aa,$aa,$aa,$0a,$0a,$aa
	defb $0a,$aa,$aa,$0a,$0a,$aa,$0a,$0a
	defb $0a,$0a,$0a,$0a,$a0,$a0,$aa,$a0
	defb $aa,$00,$00,$aa,$00,$aa,$a0,$00
	defb $0a,$a0,$0a,$00,$00,$0a,$00,$0a
	defb $aa,$a0,$a0,$aa,$a0,$0a,$00,$a0
	defb $0a,$a0,$aa,$00,$00,$aa,$00,$0a
	defb $00,$00,$0a,$00,$a0,$a0,$a0,$a0
	defb $a0,$00,$00,$a0,$00,$a0,$a0,$00
	defb $00,$a0,$00,$00,$00,$00,$00,$00
	;4dot
	defb $9a,$9a,$95,$9a,$95,$a6,$a6,$56
	defb $a6,$56,$ff,$ff,$aa,$ff,$aa
	;8dot
	defb $a9,$a9,$95,$a9,$a9,$aa,$aa,$5a
	defb $aa,$aa,$95,$a5,$9a,$a5,$9a,$5a
	defb $6a,$9a,$6a,$9a
	;sprite
	defb $a5,$a9,$af,$a5,$a9,$5a,$9a,$fa
	defb $5a,$9a,$af,$bb,$a6,$bb,$a6,$fa
	defb $ee,$9a,$ee,$9a,$a5,$a9,$ab,$a5
	defb $a9,$5a,$9a,$fa,$5a,$9a,$ab,$bb
	defb $a6,$bb,$a6,$fa,$ee,$96,$ee,$96
	defb $a5,$a9,$aa,$a5,$a9,$5a,$9a,$ea
	defb $5a,$9a,$aa,$ab,$a9,$ab,$a9,$ea
	defb $ea,$9a,$ea,$9a,$a5,$a9,$ab,$a5
	defb $a9,$5a,$9a,$ea,$5a,$9a,$ab,$be
	defb $a6,$be,$a6,$ea,$ee,$96,$ee,$96
	defb $a5,$a6,$af,$a5,$a6,$5a,$6a,$fa
	defb $5a,$6a,$af,$bb,$a6,$bb,$a6,$fa
	defb $ee,$9a,$ee,$9a,$a5,$a6,$af,$a5
	defb $a6,$5a,$6a,$ea,$5a,$6a,$af,$bb
	defb $96,$bb,$96,$ea,$ee,$9a,$ee,$9a
	defb $a5,$a6,$ab,$a5,$a6,$5a,$6a,$aa
	defb $5a,$6a,$ab,$ab,$a6,$ab,$a6,$aa
	defb $ea,$6a,$ea,$6a,$a5,$a6,$ab,$a5
	defb $a6,$5a,$6a,$ea,$5a,$6a,$ab,$bb
	defb $96,$bb,$96,$ea,$be,$9a,$be,$9a
	defb $a5,$a5,$bf,$a5,$a5,$5a,$5e,$fa
	defb $5a,$5e,$bf,$af,$a6,$af,$a6,$fa
	defb $ea,$9a,$ea,$9a,$a5,$b5,$af,$a5
	defb $b5,$5a,$5a,$fe,$5a,$5a,$af,$ab
	defb $a6,$ab,$a6,$fe,$fa,$9a,$fa,$9a
	defb $a0,$80,$22,$a0,$80,$2a,$0a,$00
	defb $2a,$0a,$22,$80,$88,$80,$88,$00
	defb $02,$8a,$02,$8a,$aa,$a0,$80,$aa
	defb $a0,$aa,$2a,$0a,$aa,$2a,$80,$22
	defb $80,$22,$80,$0a,$00,$02,$00,$02
	defb $a8,$a0,$00,$a8,$a0,$0a,$02,$88
	defb $0a,$02,$00,$80,$a2,$80,$a2,$88
	defb $02,$22,$02,$22,$aa,$a8,$a0,$aa
	defb $a8,$aa,$0a,$02,$aa,$0a,$a0,$00
	defb $80,$00,$80,$02,$88,$02,$88,$02
	defb $88,$80,$00,$88,$80,$8a,$02,$00
	defb $8a,$02,$00,$8a,$a0,$8a,$a0,$00
	defb $a2,$0a,$a2,$0a,$aa,$ab,$ad,$aa
	defb $ab,$aa,$aa,$fa,$aa,$aa,$ad,$b5
	defb $af,$b5,$af,$fa,$ea,$aa,$ea,$aa
	defb $80,$33,$33,$80,$33,$02,$54,$44
	defb $02,$54,$33,$3f,$80,$3f,$80,$44
	defb $54,$42,$54,$42
