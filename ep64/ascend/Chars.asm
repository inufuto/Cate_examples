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
	defb $3c,$00,$3c,$00,$3c,$00,$3c,$00
	defb $00,$00,$00,$00,$00,$00,$00,$00
	defb $00,$00,$00,$00,$00,$00,$00,$00
	defb $3c,$00,$3c,$00,$3c,$00,$3c,$00
	defb $3c,$00,$3c,$00,$3c,$00,$3c,$00
	defb $3c,$00,$3c,$00,$3c,$00,$3c,$00
	defb $00,$3c,$00,$3c,$00,$3c,$00,$3c
	defb $00,$00,$00,$00,$00,$00,$00,$00
	defb $3c,$3c,$3c,$3c,$3c,$3c,$3c,$3c
	defb $00,$00,$00,$00,$00,$00,$00,$00
	defb $00,$3c,$00,$3c,$00,$3c,$00,$3c
	defb $3c,$00,$3c,$00,$3c,$00,$3c,$00
	defb $3c,$3c,$3c,$3c,$3c,$3c,$3c,$3c
	defb $3c,$00,$3c,$00,$3c,$00,$3c,$00
	defb $00,$00,$00,$00,$00,$00,$00,$00
	defb $00,$3c,$00,$3c,$00,$3c,$00,$3c
	defb $3c,$00,$3c,$00,$3c,$00,$3c,$00
	defb $00,$3c,$00,$3c,$00,$3c,$00,$3c
	defb $00,$00,$00,$00,$00,$00,$00,$00
	defb $3c,$3c,$3c,$3c,$3c,$3c,$3c,$3c
	defb $3c,$00,$3c,$00,$3c,$00,$3c,$00
	defb $3c,$3c,$3c,$3c,$3c,$3c,$3c,$3c
	defb $00,$3c,$00,$3c,$00,$3c,$00,$3c
	defb $00,$3c,$00,$3c,$00,$3c,$00,$3c
	defb $3c,$3c,$3c,$3c,$3c,$3c,$3c,$3c
	defb $00,$3c,$00,$3c,$00,$3c,$00,$3c
	defb $00,$3c,$00,$3c,$00,$3c,$00,$3c
	defb $3c,$3c,$3c,$3c,$3c,$3c,$3c,$3c
	defb $3c,$3c,$3c,$3c,$3c,$3c,$3c,$3c
	defb $3c,$3c,$3c,$3c,$3c,$3c,$3c,$3c
; color8
	defb $40,$00,$40,$c0,$40,$c0,$40,$00
	defb $40,$00,$40,$c0,$40,$c0,$40,$00
	defb $00,$80,$c0,$80,$c0,$80,$00,$80
	defb $00,$80,$c0,$80,$c0,$80,$00,$80
	defb $3c,$3c,$3c,$3c,$3c,$3c,$3c,$3c
	defb $00,$00,$00,$00,$00,$00,$00,$00
	defb $3c,$3c,$3c,$3c,$3c,$3c,$3c,$3c
	defb $3c,$3c,$3c,$3c,$3c,$3c,$3c,$3c
; color16
	defb $00,$00,$00,$55,$00,$ff,$00,$55
	defb $00,$55,$00,$ff,$00,$55,$00,$0c
	defb $00,$00,$aa,$00,$ff,$00,$55,$00
	defb $55,$00,$ff,$00,$aa,$00,$0c,$00
	defb $04,$0c,$04,$04,$41,$04,$00,$11
	defb $00,$22,$00,$22,$00,$22,$00,$82
	defb $0c,$08,$08,$08,$08,$82,$22,$00
	defb $11,$00,$11,$00,$11,$00,$41,$00
	defb $00,$00,$00,$55,$00,$ff,$00,$55
	defb $00,$55,$00,$ff,$00,$55,$00,$04
	defb $00,$00,$aa,$00,$ff,$00,$55,$00
	defb $55,$00,$ff,$00,$aa,$00,$0c,$00
	defb $41,$04,$41,$04,$00,$04,$00,$11
	defb $00,$22,$00,$22,$11,$00,$41,$00
	defb $0c,$08,$08,$08,$08,$82,$22,$00
	defb $11,$22,$11,$82,$00,$00,$00,$00
	defb $00,$00,$00,$55,$00,$ff,$00,$55
	defb $00,$55,$00,$ff,$00,$55,$00,$00
	defb $00,$00,$aa,$00,$ff,$00,$55,$00
	defb $55,$00,$ff,$00,$aa,$00,$08,$00
	defb $00,$00,$00,$04,$00,$04,$00,$04
	defb $00,$00,$00,$11,$00,$11,$00,$41
	defb $08,$00,$08,$00,$00,$00,$00,$00
	defb $00,$00,$00,$00,$00,$00,$00,$00
	defb $00,$00,$00,$55,$00,$ff,$00,$55
	defb $00,$55,$00,$ff,$00,$55,$00,$04
	defb $00,$00,$aa,$00,$ff,$00,$55,$00
	defb $55,$00,$ff,$00,$aa,$00,$08,$00
	defb $41,$0c,$41,$08,$00,$04,$00,$11
	defb $00,$22,$00,$22,$00,$22,$00,$82
	defb $00,$00,$08,$08,$08,$82,$22,$00
	defb $33,$22,$11,$82,$00,$00,$00,$00
	defb $00,$00,$00,$54,$00,$fc,$00,$a8
	defb $00,$a8,$00,$fc,$00,$54,$00,$0c
	defb $00,$00,$a8,$00,$fc,$00,$a8,$00
	defb $a8,$00,$fc,$00,$a8,$00,$0c,$00
	defb $04,$0c,$04,$04,$41,$04,$00,$11
	defb $00,$22,$00,$22,$00,$22,$00,$82
	defb $0c,$08,$08,$08,$08,$82,$22,$00
	defb $11,$00,$11,$00,$11,$00,$41,$00
	defb $00,$00,$00,$55,$00,$ff,$00,$aa
	defb $00,$aa,$00,$ff,$00,$55,$00,$0c
	defb $00,$00,$aa,$00,$ff,$00,$aa,$00
	defb $aa,$00,$ff,$00,$aa,$00,$08,$00
	defb $04,$0c,$04,$04,$41,$04,$00,$11
	defb $11,$22,$41,$22,$00,$00,$00,$00
	defb $08,$82,$08,$82,$08,$00,$22,$00
	defb $11,$00,$11,$00,$00,$22,$00,$82
	defb $00,$00,$00,$55,$00,$ff,$00,$aa
	defb $00,$aa,$00,$ff,$00,$55,$00,$04
	defb $00,$00,$aa,$00,$ff,$00,$aa,$00
	defb $aa,$00,$ff,$00,$aa,$00,$00,$00
	defb $00,$04,$00,$04,$00,$00,$00,$00
	defb $00,$00,$00,$00,$00,$00,$00,$00
	defb $00,$00,$08,$00,$08,$00,$08,$00
	defb $00,$00,$22,$00,$22,$00,$82,$00
	defb $00,$00,$00,$55,$00,$ff,$00,$aa
	defb $00,$aa,$00,$ff,$00,$55,$00,$04
	defb $00,$00,$aa,$00,$ff,$00,$aa,$00
	defb $aa,$00,$ff,$00,$aa,$00,$08,$00
	defb $00,$00,$04,$04,$41,$04,$00,$11
	defb $11,$33,$41,$22,$00,$00,$00,$00
	defb $0c,$82,$04,$82,$08,$00,$22,$00
	defb $11,$00,$11,$00,$11,$00,$41,$00
	defb $00,$00,$00,$55,$00,$ff,$00,$ff
	defb $00,$ff,$00,$ff,$00,$55,$41,$04
	defb $00,$00,$aa,$00,$ff,$00,$ff,$00
	defb $ff,$82,$ff,$82,$aa,$08,$0c,$00
	defb $41,$0c,$00,$0c,$00,$04,$00,$11
	defb $00,$22,$00,$22,$00,$82,$00,$00
	defb $0c,$00,$08,$00,$08,$00,$22,$00
	defb $33,$00,$11,$00,$11,$00,$41,$00
	defb $00,$00,$00,$55,$00,$ff,$00,$ff
	defb $41,$ff,$41,$ff,$04,$55,$00,$0c
	defb $00,$00,$aa,$00,$ff,$00,$ff,$00
	defb $ff,$00,$ff,$00,$aa,$00,$08,$82
	defb $00,$0c,$00,$04,$00,$04,$00,$11
	defb $00,$33,$00,$22,$00,$22,$00,$82
	defb $0c,$82,$0c,$00,$08,$00,$22,$00
	defb $11,$00,$11,$00,$41,$00,$00,$00
	defb $00,$00,$00,$00,$00,$00,$00,$00
	defb $00,$04,$55,$04,$ff,$ae,$aa,$ae
	defb $00,$00,$00,$00,$00,$00,$82,$00
	defb $08,$00,$00,$63,$19,$63,$19,$00
	defb $ff,$ae,$aa,$ae,$55,$04,$00,$04
	defb $00,$00,$00,$00,$00,$00,$00,$00
	defb $19,$00,$19,$63,$00,$63,$08,$00
	defb $82,$00,$00,$00,$00,$00,$00,$00
	defb $00,$82,$00,$22,$00,$22,$00,$22
	defb $00,$11,$41,$04,$04,$04,$04,$0c
	defb $41,$00,$11,$00,$11,$00,$11,$00
	defb $22,$00,$08,$82,$08,$08,$0c,$08
	defb $00,$0c,$00,$55,$00,$ff,$00,$aa
	defb $00,$aa,$00,$ff,$00,$55,$00,$00
	defb $0c,$00,$aa,$00,$ff,$00,$aa,$00
	defb $aa,$00,$ff,$00,$aa,$00,$00,$00
	defb $00,$00,$00,$00,$00,$00,$00,$41
	defb $00,$04,$93,$00,$93,$26,$00,$26
	defb $00,$00,$00,$00,$00,$00,$00,$00
	defb $08,$00,$08,$aa,$5d,$55,$5d,$ff
	defb $00,$26,$93,$26,$93,$00,$00,$04
	defb $00,$41,$00,$00,$00,$00,$00,$00
	defb $5d,$55,$5d,$ff,$08,$aa,$08,$00
	defb $00,$00,$00,$00,$00,$00,$00,$00
	defb $00,$00,$00,$04,$00,$04,$00,$0c
	defb $00,$0c,$04,$0c,$04,$0c,$0c,$0c
	defb $08,$00,$0c,$00,$04,$08,$00,$08
	defb $08,$00,$0c,$00,$0c,$00,$0c,$08
	defb $08,$08,$08,$08,$0c,$0c,$08,$00
	defb $04,$04,$04,$0c,$00,$0c,$00,$00
	defb $0c,$08,$0c,$08,$0c,$08,$0c,$08
	defb $0c,$00,$0c,$00,$08,$00,$00,$00
	defb $00,$00,$00,$00,$00,$04,$00,$04
	defb $00,$0c,$00,$0c,$04,$0c,$04,$0c
	defb $04,$00,$0c,$08,$08,$08,$00,$00
	defb $00,$00,$08,$00,$0c,$00,$0c,$00
	defb $0c,$0c,$08,$08,$08,$08,$0c,$0c
	defb $08,$00,$04,$0c,$00,$0c,$00,$00
	defb $0c,$08,$0c,$08,$0c,$08,$0c,$08
	defb $0c,$08,$0c,$00,$08,$00,$00,$00
	defb $00,$04,$00,$0c,$04,$08,$04,$00
	defb $00,$04,$00,$0c,$00,$0c,$04,$0c
	defb $00,$00,$08,$00,$08,$00,$0c,$00
	defb $0c,$00,$0c,$08,$0c,$08,$0c,$0c
	defb $04,$0c,$04,$0c,$04,$0c,$04,$0c
	defb $00,$0c,$00,$0c,$00,$04,$00,$00
	defb $04,$04,$04,$04,$0c,$0c,$00,$04
	defb $08,$08,$0c,$08,$0c,$00,$00,$00
	defb $00,$08,$04,$0c,$04,$04,$00,$00
	defb $00,$00,$00,$04,$00,$0c,$00,$0c
	defb $00,$00,$00,$00,$08,$00,$08,$00
	defb $0c,$00,$0c,$00,$0c,$08,$0c,$08
	defb $04,$0c,$04,$0c,$04,$0c,$04,$0c
	defb $04,$0c,$00,$0c,$00,$04,$00,$00
	defb $0c,$0c,$04,$04,$04,$04,$0c,$0c
	defb $00,$04,$0c,$08,$0c,$00,$00,$00
	defb $00,$88,$00,$88,$44,$cc,$44,$cc
	defb $00,$88,$00,$88,$cc,$cc,$cc,$cc
	defb $88,$00,$88,$00,$cc,$00,$cc,$00
	defb $cc,$00,$cc,$00,$cc,$88,$cc,$88
	defb $44,$cc,$44,$cc,$00,$cc,$00,$cc
	defb $00,$cc,$00,$44,$00,$44,$00,$00
	defb $cc,$00,$cc,$00,$cc,$00,$cc,$00
	defb $88,$00,$88,$00,$cc,$00,$cc,$00
	defb $00,$00,$00,$88,$00,$88,$44,$cc
	defb $44,$cc,$00,$88,$00,$88,$44,$cc
	defb $00,$00,$88,$00,$88,$00,$cc,$00
	defb $cc,$00,$cc,$00,$e6,$00,$cc,$00
	defb $44,$cc,$cc,$cc,$cc,$cc,$44,$cc
	defb $00,$cc,$00,$cc,$00,$44,$00,$44
	defb $cc,$00,$cc,$88,$cc,$88,$cc,$00
	defb $cc,$00,$88,$00,$cc,$00,$cc,$00
	defb $00,$44,$00,$44,$00,$cc,$00,$cc
	defb $00,$cc,$00,$cc,$44,$cc,$44,$cc
	defb $44,$00,$44,$00,$cc,$88,$cc,$88
	defb $44,$00,$44,$00,$cc,$cc,$cc,$cc
	defb $00,$cc,$00,$cc,$00,$cc,$00,$cc
	defb $00,$44,$00,$44,$00,$cc,$00,$cc
	defb $cc,$88,$cc,$88,$cc,$00,$cc,$00
	defb $cc,$00,$88,$00,$88,$00,$00,$00
	defb $00,$00,$00,$44,$00,$44,$00,$cc
	defb $00,$cc,$00,$cc,$00,$cc,$00,$cc
	defb $00,$00,$44,$00,$44,$00,$cc,$88
	defb $cc,$88,$44,$00,$44,$00,$cc,$88
	defb $00,$cc,$44,$cc,$44,$cc,$00,$cc
	defb $00,$cc,$00,$44,$00,$cc,$00,$cc
	defb $cc,$88,$cc,$cc,$cc,$cc,$cc,$88
	defb $cc,$00,$cc,$00,$88,$00,$88,$00
	defb $00,$00,$10,$30,$10,$30,$31,$31
	defb $31,$31,$31,$31,$31,$31,$31,$31
	defb $00,$00,$30,$20,$30,$20,$30,$30
	defb $30,$30,$c3,$92,$c3,$92,$92,$92
	defb $31,$31,$31,$33,$31,$33,$30,$30
	defb $30,$30,$10,$30,$10,$30,$00,$00
	defb $92,$92,$c3,$92,$c3,$92,$92,$30
	defb $92,$30,$30,$20,$30,$20,$00,$00
	defb $00,$00,$00,$00,$05,$0f,$05,$0f
	defb $0f,$4a,$0f,$4a,$0f,$4a,$0f,$4a
	defb $00,$00,$00,$00,$0f,$00,$0f,$00
	defb $0f,$0a,$0f,$0a,$0f,$0a,$0f,$0a
	defb $0f,$4a,$0f,$4a,$0f,$4a,$0f,$0f
	defb $0f,$4a,$0f,$4a,$05,$0f,$05,$0f
	defb $0f,$0a,$0f,$0a,$0f,$0a,$0f,$0a
	defb $0f,$0a,$0f,$0a,$0f,$00,$0f,$00
	defb $15,$3f,$15,$3f,$3b,$33,$3b,$33
	defb $3b,$3f,$3b,$3f,$3b,$3f,$3b,$3f
	defb $3f,$2a,$3f,$2a,$33,$37,$33,$37
	defb $3f,$37,$3f,$37,$3f,$37,$3f,$37
	defb $3b,$3f,$3b,$3f,$3b,$3f,$3b,$3f
	defb $3b,$33,$3b,$33,$15,$3f,$15,$3f
	defb $3f,$37,$3f,$37,$3f,$37,$3f,$37
	defb $33,$37,$33,$37,$3f,$2a,$3f,$2a
