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
; color8
	defb $00,$55,$00,$55,$00,$55,$00,$55
	defb $00,$55,$00,$55,$00,$55,$00,$55
	defb $41,$82,$41,$82,$c7,$cb,$c7,$cb
	defb $c7,$cb,$c7,$cb,$41,$82,$41,$82
	defb $00,$00,$00,$00,$8a,$8a,$8a,$8a
	defb $45,$45,$45,$45,$00,$00,$00,$00
	defb $3f,$3f,$3f,$3f,$2e,$1d,$2e,$1d
	defb $2e,$1d,$2e,$1d,$3f,$3f,$3f,$3f
; color16
	defb $55,$00,$55,$00,$55,$00,$55,$55
	defb $ff,$55,$fe,$bf,$fe,$3f,$fe,$7f
	defb $55,$00,$55,$00,$55,$00,$55,$00
	defb $55,$aa,$fe,$aa,$7e,$aa,$7e,$aa
	defb $fe,$ff,$fe,$ff,$fe,$ff,$fe,$ff
	defb $55,$55,$55,$00,$00,$00,$00,$00
	defb $fe,$aa,$fe,$aa,$fe,$aa,$fe,$aa
	defb $55,$00,$55,$00,$00,$00,$00,$00
	defb $00,$00,$00,$00,$00,$04,$00,$04
	defb $00,$0c,$00,$59,$04,$0c,$04,$59
	defb $00,$00,$00,$00,$00,$00,$00,$00
	defb $08,$00,$08,$00,$0c,$00,$0c,$00
	defb $0c,$0c,$0c,$0c,$04,$2e,$04,$2e
	defb $00,$1d,$00,$1d,$00,$04,$00,$04
	defb $0c,$08,$0c,$08,$2e,$00,$2e,$00
	defb $08,$00,$08,$00,$00,$00,$00,$00
	defb $00,$04,$00,$04,$00,$1d,$00,$1d
	defb $04,$2e,$04,$2e,$a6,$0c,$a6,$0c
	defb $00,$00,$00,$00,$08,$00,$08,$00
	defb $2e,$00,$2e,$00,$0c,$a2,$0c,$a2
	defb $a6,$59,$a6,$59,$a2,$51,$a2,$51
	defb $00,$51,$00,$51,$00,$00,$00,$00
	defb $0c,$a2,$0c,$a2,$00,$a2,$00,$a2
	defb $00,$00,$00,$00,$00,$00,$00,$00
	defb $00,$a6,$00,$a6,$51,$0c,$51,$0c
	defb $a2,$0c,$a2,$0c,$00,$51,$00,$51
	defb $0c,$08,$0c,$08,$3f,$08,$3f,$08
	defb $1d,$08,$1d,$08,$0c,$08,$0c,$08
	defb $00,$a2,$00,$a2,$00,$00,$00,$00
	defb $00,$00,$00,$00,$00,$00,$00,$00
	defb $0c,$a2,$0c,$a2,$51,$00,$51,$00
	defb $a2,$00,$a2,$00,$00,$00,$00,$00
	defb $51,$f3,$51,$f3,$00,$0c,$00,$0c
	defb $00,$0c,$00,$0c,$f3,$a6,$f3,$a6
	defb $00,$00,$00,$00,$08,$00,$08,$00
	defb $2e,$00,$2e,$00,$1d,$08,$1d,$08
	defb $00,$0c,$00,$0c,$00,$0c,$00,$0c
	defb $51,$f3,$51,$f3,$00,$00,$00,$00
	defb $2e,$00,$2e,$00,$08,$00,$08,$00
	defb $00,$00,$00,$00,$00,$00,$00,$00
	defb $00,$00,$00,$00,$00,$00,$00,$00
	defb $00,$00,$00,$00,$00,$a2,$00,$a2
	defb $00,$00,$00,$00,$a2,$00,$a2,$00
	defb $51,$00,$51,$00,$0c,$a2,$0c,$a2
	defb $00,$51,$00,$51,$a2,$0c,$a2,$0c
	defb $51,$0c,$51,$0c,$00,$a6,$00,$a6
	defb $0c,$08,$0c,$08,$1d,$08,$1d,$08
	defb $3f,$08,$3f,$08,$0c,$08,$0c,$08
	defb $00,$00,$00,$00,$00,$00,$00,$00
	defb $51,$00,$51,$00,$51,$0c,$51,$0c
	defb $00,$00,$00,$00,$a2,$00,$a2,$00
	defb $a2,$51,$a2,$51,$a6,$59,$a6,$59
	defb $51,$0c,$51,$0c,$00,$1d,$00,$1d
	defb $00,$04,$00,$04,$00,$00,$00,$00
	defb $0c,$59,$0c,$59,$1d,$08,$1d,$08
	defb $2e,$00,$2e,$00,$08,$00,$08,$00
	defb $00,$00,$00,$00,$00,$51,$00,$51
	defb $00,$a2,$00,$a2,$51,$0c,$51,$0c
	defb $00,$00,$00,$00,$00,$00,$00,$00
	defb $00,$00,$00,$00,$51,$00,$51,$00
	defb $04,$0c,$04,$0c,$04,$2e,$04,$2e
	defb $04,$3f,$04,$3f,$04,$0c,$04,$0c
	defb $a2,$00,$a2,$00,$0c,$51,$0c,$51
	defb $0c,$a2,$0c,$a2,$59,$00,$59,$00
	defb $00,$00,$00,$00,$00,$04,$00,$04
	defb $00,$1d,$00,$1d,$04,$2e,$04,$2e
	defb $f3,$a2,$f3,$a2,$0c,$00,$0c,$00
	defb $0c,$00,$0c,$00,$59,$f3,$59,$f3
	defb $00,$1d,$00,$1d,$00,$04,$00,$04
	defb $00,$00,$00,$00,$00,$00,$00,$00
	defb $0c,$00,$0c,$00,$0c,$00,$0c,$00
	defb $f3,$a2,$f3,$a2,$00,$00,$00,$00
	defb $04,$0c,$04,$0c,$04,$3f,$04,$3f
	defb $04,$2e,$04,$2e,$04,$0c,$04,$0c
	defb $59,$00,$59,$00,$0c,$a2,$0c,$a2
	defb $0c,$51,$0c,$51,$a2,$00,$a2,$00
	defb $51,$0c,$51,$0c,$00,$a2,$00,$a2
	defb $00,$51,$00,$51,$00,$00,$00,$00
	defb $51,$00,$51,$00,$00,$00,$00,$00
	defb $00,$00,$00,$00,$00,$00,$00,$00
	defb $00,$00,$00,$00,$80,$04,$80,$04
	defb $80,$0c,$c0,$0c,$04,$4d,$04,$0c
	defb $00,$00,$00,$00,$00,$80,$00,$80
	defb $08,$80,$48,$80,$0c,$00,$0c,$00
	defb $04,$4d,$04,$0c,$04,$2e,$04,$2e
	defb $c0,$1d,$80,$1d,$80,$04,$80,$04
	defb $0c,$00,$0c,$00,$2e,$00,$2e,$00
	defb $48,$80,$08,$80,$00,$80,$00,$80
	defb $54,$fc,$54,$fc,$fd,$aa,$fd,$aa
	defb $fd,$55,$fd,$55,$a8,$aa,$a8,$aa
	defb $fc,$a8,$fc,$a8,$55,$fe,$55,$fe
	defb $aa,$fe,$aa,$fe,$55,$54,$55,$54
	defb $a8,$aa,$a8,$aa,$fd,$55,$fd,$55
	defb $fd,$aa,$fd,$aa,$54,$fc,$54,$fc
	defb $55,$54,$55,$54,$aa,$fe,$aa,$fe
	defb $55,$fe,$55,$fe,$fc,$a8,$fc,$a8
	defb $ff,$00,$ff,$00,$ab,$ff,$ab,$ff
	defb $55,$ff,$55,$ff,$55,$aa,$55,$aa
	defb $00,$ff,$00,$ff,$ff,$57,$ff,$57
	defb $ff,$aa,$ff,$aa,$55,$aa,$55,$aa
	defb $55,$aa,$55,$aa,$55,$ff,$55,$ff
	defb $ab,$ff,$ab,$ff,$ff,$00,$ff,$00
	defb $55,$aa,$55,$aa,$ff,$aa,$ff,$aa
	defb $ff,$57,$ff,$57,$00,$ff,$00,$ff
	defb $00,$04,$04,$04,$04,$0c,$04,$49
	defb $04,$c3,$49,$c3,$04,$c7,$04,$c7
	defb $00,$08,$04,$08,$0c,$00,$0c,$04
	defb $86,$0c,$c3,$08,$86,$08,$86,$00
	defb $00,$4d,$04,$c3,$0c,$c3,$04,$49
	defb $00,$49,$00,$0c,$04,$04,$00,$04
	defb $cb,$08,$cb,$86,$c3,$08,$86,$00
	defb $c3,$08,$0c,$08,$00,$08,$00,$00
	defb $00,$00,$00,$00,$00,$00,$00,$08
	defb $00,$0c,$00,$0c,$00,$49,$00,$04
	defb $00,$00,$00,$04,$00,$04,$00,$0c
	defb $00,$49,$0c,$49,$86,$c3,$86,$c3
	defb $00,$04,$00,$0c,$0c,$86,$04,$c3
	defb $04,$49,$00,$0c,$00,$0c,$00,$04
	defb $c3,$cb,$c3,$cb,$c3,$cf,$c7,$cf
	defb $cf,$df,$c7,$ff,$c7,$ff,$c7,$ff
	defb $00,$00,$00,$00,$00,$00,$08,$04
	defb $08,$0c,$08,$0c,$0c,$0c,$86,$86
	defb $00,$00,$08,$00,$08,$00,$08,$00
	defb $08,$00,$00,$00,$04,$08,$04,$00
	defb $86,$86,$c3,$c3,$c3,$cb,$cb,$cb
	defb $cf,$cb,$ef,$c3,$ef,$c3,$ef,$c3
	defb $0c,$00,$0c,$00,$86,$00,$0c,$00
	defb $08,$00,$08,$00,$08,$00,$0c,$00
	defb $00,$49,$00,$49,$04,$c7,$04,$c3
	defb $0c,$c3,$04,$0c,$04,$0c,$00,$49
	defb $df,$ff,$df,$df,$df,$df,$cf,$cf
	defb $c7,$cf,$c3,$c7,$c3,$c3,$c3,$49
	defb $00,$0c,$00,$04,$00,$04,$00,$04
	defb $00,$00,$00,$00,$00,$00,$00,$00
	defb $86,$49,$0c,$49,$08,$49,$00,$0c
	defb $00,$04,$00,$04,$00,$04,$00,$00
	defb $ef,$cf,$ef,$c3,$cf,$c3,$cf,$86
	defb $c7,$86,$c3,$86,$c3,$86,$86,$c3
	defb $86,$00,$c3,$08,$0c,$08,$0c,$0c
	defb $0c,$00,$00,$00,$00,$00,$08,$00
	defb $86,$49,$0c,$0c,$08,$04,$08,$00
	defb $00,$00,$00,$00,$00,$00,$00,$00
	defb $08,$00,$08,$00,$0c,$00,$0c,$00
	defb $04,$00,$00,$00,$00,$00,$00,$00
	defb $00,$00,$05,$0f,$05,$0f,$4b,$4b
	defb $4b,$4b,$4b,$4b,$4b,$4b,$4b,$4b
	defb $00,$00,$0f,$0a,$0f,$0a,$0f,$0f
	defb $0f,$0f,$33,$27,$33,$27,$27,$27
	defb $4b,$4b,$4b,$c3,$4b,$c3,$0f,$0f
	defb $0f,$0f,$05,$0f,$05,$0f,$00,$00
	defb $27,$27,$33,$27,$33,$27,$27,$0f
	defb $27,$0f,$0f,$0a,$0f,$0a,$00,$00
; fort
	defb $00,$00,$00,$00,$00,$00,$00,$15
	defb $00,$15,$15,$00,$15,$45,$15,$45
	defb $00,$00,$00,$00,$00,$00,$2a,$3f
	defb $2a,$00,$00,$3f,$00,$00,$54,$51
	defb $00,$08,$00,$08,$04,$0c,$04,$0c
	defb $00,$08,$00,$08,$00,$54,$f3,$f6
	defb $04,$00,$04,$00,$0c,$08,$0c,$08
	defb $04,$00,$04,$00,$a8,$00,$f9,$f3
	defb $00,$00,$00,$00,$00,$00,$3f,$15
	defb $00,$15,$3f,$00,$00,$00,$a2,$a8
	defb $00,$00,$00,$00,$00,$00,$2a,$00
	defb $2a,$00,$00,$2a,$8a,$2a,$8a,$2a
	defb $15,$00,$15,$15,$00,$00,$54,$fc
	defb $00,$00,$04,$08,$04,$08,$04,$08
	defb $54,$00,$54,$50,$54,$00,$00,$00
	defb $00,$aa,$22,$aa,$22,$aa,$22,$aa
	defb $00,$54,$15,$54,$3f,$2a,$3f,$2a
	defb $3f,$2a,$3f,$2a,$3f,$2a,$3f,$2a
	defb $a8,$00,$a8,$2a,$15,$3f,$15,$3f
	defb $15,$3f,$15,$3f,$15,$3f,$15,$3f
	defb $00,$a8,$a0,$a8,$00,$a8,$00,$00
	defb $55,$00,$55,$11,$55,$11,$55,$11
	defb $00,$2a,$2a,$2a,$00,$00,$fc,$a8
	defb $00,$00,$04,$08,$04,$08,$04,$08
	defb $04,$08,$00,$00,$3f,$2a,$3f,$2a
	defb $00,$00,$7e,$2a,$7e,$2a,$7e,$2a
	defb $00,$00,$a0,$82,$a0,$93,$a0,$93
	defb $00,$00,$aa,$3f,$aa,$3f,$aa,$3f
	defb $15,$10,$00,$10,$33,$32,$33,$32
	defb $00,$00,$15,$55,$15,$55,$15,$55
	defb $20,$2a,$20,$00,$31,$33,$31,$33
	defb $00,$00,$aa,$2a,$aa,$2a,$aa,$2a
	defb $00,$00,$41,$50,$63,$50,$63,$50
	defb $00,$00,$3f,$55,$3f,$55,$3f,$55
	defb $04,$08,$00,$00,$15,$3f,$15,$3f
	defb $00,$00,$15,$bd,$15,$bd,$15,$bd
	defb $7e,$2a,$7e,$2a,$7e,$2a,$00,$00
	defb $3f,$2a,$3f,$2a,$00,$00,$04,$08
	defb $aa,$3f,$aa,$3f,$aa,$3f,$00,$00
	defb $a0,$93,$a0,$93,$a0,$82,$00,$00
	defb $15,$55,$15,$55,$15,$55,$00,$00
	defb $33,$32,$33,$32,$00,$10,$15,$10
	defb $aa,$2a,$aa,$2a,$aa,$2a,$00,$00
	defb $31,$33,$31,$33,$20,$00,$20,$2a
	defb $3f,$55,$3f,$55,$3f,$55,$00,$00
	defb $63,$50,$63,$50,$41,$50,$00,$00
	defb $15,$bd,$15,$bd,$15,$bd,$00,$00
	defb $15,$3f,$15,$3f,$00,$00,$04,$08
	defb $04,$08,$04,$08,$04,$08,$00,$00
	defb $54,$fc,$00,$00,$15,$15,$15,$00
	defb $22,$aa,$22,$aa,$22,$aa,$00,$aa
	defb $00,$00,$54,$00,$54,$50,$54,$00
	defb $3f,$2a,$3f,$2a,$3f,$2a,$3f,$2a
	defb $3f,$2a,$3f,$2a,$15,$54,$00,$54
	defb $15,$3f,$15,$3f,$15,$3f,$15,$3f
	defb $15,$3f,$15,$3f,$a8,$2a,$a8,$00
	defb $55,$11,$55,$11,$55,$11,$55,$00
	defb $00,$00,$00,$a8,$a0,$a8,$00,$a8
	defb $04,$08,$04,$08,$04,$08,$00,$00
	defb $fc,$a8,$00,$00,$2a,$2a,$00,$2a
	defb $15,$45,$15,$45,$15,$00,$00,$15
	defb $00,$15,$00,$00,$00,$00,$00,$00
	defb $54,$51,$00,$00,$00,$3f,$2a,$00
	defb $2a,$3f,$00,$00,$00,$00,$00,$00
	defb $f3,$f6,$00,$54,$00,$08,$00,$08
	defb $04,$0c,$04,$0c,$00,$08,$00,$08
	defb $f9,$f3,$a8,$00,$04,$00,$04,$00
	defb $0c,$08,$0c,$08,$04,$00,$04,$00
	defb $a2,$a8,$00,$00,$3f,$00,$00,$15
	defb $3f,$15,$00,$00,$00,$00,$00,$00
	defb $8a,$2a,$8a,$2a,$00,$2a,$2a,$00
	defb $2a,$00,$00,$00,$00,$00,$00,$00
; terrain
	defb $fc,$fc,$a8,$00,$a8,$00,$a8,$00
	defb $a8,$00,$a8,$00,$a8,$00,$a8,$00
	defb $a8,$00,$a8,$00,$a8,$00,$a8,$00
	defb $a8,$00,$a8,$00,$a8,$00,$a8,$00
	defb $10,$00,$00,$10,$20,$00,$00,$20
	defb $10,$00,$00,$10,$20,$00,$00,$20
	defb $00,$00,$00,$00,$00,$00,$00,$00
	defb $00,$00,$00,$00,$00,$00,$fc,$fc
	defb $fc,$fc,$00,$54,$00,$54,$00,$54
	defb $00,$54,$00,$54,$00,$54,$00,$54
	defb $a8,$00,$a8,$00,$a8,$00,$a8,$00
	defb $a8,$00,$a8,$00,$a8,$00,$fc,$fc
	defb $00,$54,$00,$54,$00,$54,$00,$54
	defb $00,$54,$00,$54,$00,$54,$fc,$fc
	defb $00,$0a,$00,$00,$0a,$00,$00,$00
	defb $05,$00,$00,$00,$00,$05,$00,$00
	defb $fc,$fc,$00,$00,$00,$00,$00,$00
	defb $00,$00,$00,$00,$00,$00,$00,$00
	defb $00,$54,$00,$54,$00,$54,$00,$54
	defb $00,$54,$00,$54,$00,$54,$00,$54
