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
	defb $30,$30,$30,$30,$30,$30,$30,$30
	defb $00,$00,$00,$00,$00,$00,$00,$00
	defb $14,$00,$14,$3c,$14,$3c,$14,$00
	defb $14,$00,$14,$3c,$14,$3c,$14,$00
	defb $00,$28,$3c,$28,$3c,$28,$00,$28
	defb $00,$28,$3c,$28,$3c,$28,$00,$28
; color16
	defb $00,$00,$00,$55,$00,$ff,$00,$55
	defb $00,$55,$00,$ff,$00,$55,$00,$0c
	defb $00,$00,$aa,$00,$ff,$00,$55,$00
	defb $55,$00,$ff,$00,$aa,$00,$0c,$00
	defb $04,$0c,$04,$04,$14,$04,$00,$40
	defb $00,$80,$00,$80,$00,$80,$00,$28
	defb $0c,$08,$08,$08,$08,$28,$80,$00
	defb $40,$00,$40,$00,$40,$00,$14,$00
	defb $00,$00,$00,$55,$00,$ff,$00,$55
	defb $00,$55,$00,$ff,$00,$55,$00,$04
	defb $00,$00,$aa,$00,$ff,$00,$55,$00
	defb $55,$00,$ff,$00,$aa,$00,$0c,$00
	defb $14,$04,$14,$04,$00,$04,$00,$40
	defb $00,$80,$00,$80,$40,$00,$14,$00
	defb $0c,$08,$08,$08,$08,$28,$80,$00
	defb $40,$80,$40,$28,$00,$00,$00,$00
	defb $00,$00,$00,$55,$00,$ff,$00,$55
	defb $00,$55,$00,$ff,$00,$55,$00,$00
	defb $00,$00,$aa,$00,$ff,$00,$55,$00
	defb $55,$00,$ff,$00,$aa,$00,$08,$00
	defb $00,$00,$00,$04,$00,$04,$00,$04
	defb $00,$00,$00,$40,$00,$40,$00,$14
	defb $08,$00,$08,$00,$00,$00,$00,$00
	defb $00,$00,$00,$00,$00,$00,$00,$00
	defb $00,$00,$00,$55,$00,$ff,$00,$55
	defb $00,$55,$00,$ff,$00,$55,$00,$04
	defb $00,$00,$aa,$00,$ff,$00,$55,$00
	defb $55,$00,$ff,$00,$aa,$00,$08,$00
	defb $14,$0c,$14,$08,$00,$04,$00,$40
	defb $00,$80,$00,$80,$00,$80,$00,$28
	defb $00,$00,$08,$08,$08,$28,$80,$00
	defb $c0,$80,$40,$28,$00,$00,$00,$00
	defb $00,$00,$00,$ff,$55,$ff,$00,$aa
	defb $00,$aa,$55,$ff,$00,$ff,$00,$0c
	defb $00,$00,$00,$00,$aa,$00,$aa,$00
	defb $aa,$00,$aa,$00,$00,$00,$00,$00
	defb $2c,$0c,$2c,$04,$00,$04,$00,$40
	defb $00,$80,$00,$80,$00,$80,$00,$28
	defb $08,$00,$08,$00,$08,$00,$80,$00
	defb $40,$00,$40,$00,$00,$80,$00,$28
	defb $00,$00,$00,$55,$00,$ff,$00,$aa
	defb $00,$aa,$00,$ff,$00,$55,$00,$0c
	defb $00,$00,$aa,$00,$ff,$00,$aa,$00
	defb $aa,$00,$ff,$00,$aa,$00,$0c,$00
	defb $04,$0c,$04,$04,$14,$04,$00,$40
	defb $00,$80,$00,$80,$00,$80,$00,$28
	defb $0c,$08,$08,$08,$08,$28,$80,$00
	defb $40,$00,$40,$00,$40,$00,$14,$00
	defb $00,$00,$00,$55,$00,$ff,$00,$aa
	defb $00,$aa,$00,$ff,$00,$55,$00,$0c
	defb $00,$00,$aa,$00,$ff,$00,$aa,$00
	defb $aa,$00,$ff,$00,$aa,$00,$08,$00
	defb $04,$0c,$04,$04,$14,$04,$00,$40
	defb $40,$80,$14,$80,$00,$00,$00,$00
	defb $08,$28,$08,$28,$08,$00,$80,$00
	defb $40,$00,$40,$00,$00,$80,$00,$28
	defb $00,$00,$00,$55,$00,$ff,$00,$aa
	defb $00,$aa,$00,$ff,$00,$55,$00,$04
	defb $00,$00,$aa,$00,$ff,$00,$aa,$00
	defb $aa,$00,$ff,$00,$aa,$00,$00,$00
	defb $00,$04,$00,$04,$00,$00,$00,$00
	defb $00,$00,$00,$00,$00,$00,$00,$00
	defb $00,$00,$08,$00,$08,$00,$08,$00
	defb $00,$00,$80,$00,$80,$00,$28,$00
	defb $00,$00,$00,$55,$00,$ff,$00,$aa
	defb $00,$aa,$00,$ff,$00,$55,$00,$04
	defb $00,$00,$aa,$00,$ff,$00,$aa,$00
	defb $aa,$00,$ff,$00,$aa,$00,$08,$00
	defb $00,$00,$04,$04,$14,$04,$00,$40
	defb $40,$c0,$14,$80,$00,$00,$00,$00
	defb $0c,$28,$04,$28,$08,$00,$80,$00
	defb $40,$00,$40,$00,$40,$00,$14,$00
	defb $00,$00,$00,$00,$00,$55,$00,$55
	defb $00,$55,$00,$55,$00,$00,$00,$00
	defb $00,$00,$ff,$00,$ff,$aa,$55,$00
	defb $55,$00,$ff,$aa,$ff,$00,$0c,$00
	defb $00,$04,$00,$04,$00,$04,$00,$40
	defb $00,$80,$00,$80,$40,$00,$14,$00
	defb $0c,$1c,$08,$1c,$08,$00,$80,$00
	defb $40,$00,$40,$00,$40,$00,$14,$00
	defb $00,$00,$00,$55,$00,$ff,$00,$ff
	defb $00,$ff,$00,$ff,$00,$55,$14,$04
	defb $00,$00,$aa,$00,$ff,$00,$ff,$00
	defb $ff,$28,$ff,$28,$aa,$08,$0c,$00
	defb $14,$0c,$00,$0c,$00,$04,$00,$40
	defb $00,$80,$00,$80,$00,$28,$00,$00
	defb $0c,$00,$08,$00,$08,$00,$80,$00
	defb $c0,$00,$40,$00,$40,$00,$14,$00
	defb $00,$00,$00,$55,$00,$ff,$00,$ff
	defb $14,$ff,$14,$ff,$04,$55,$00,$0c
	defb $00,$00,$aa,$00,$ff,$00,$ff,$00
	defb $ff,$00,$ff,$00,$aa,$00,$08,$28
	defb $00,$0c,$00,$04,$00,$04,$00,$40
	defb $00,$c0,$00,$80,$00,$80,$00,$28
	defb $0c,$28,$0c,$00,$08,$00,$80,$00
	defb $40,$00,$40,$00,$14,$00,$00,$00
	defb $00,$00,$00,$00,$00,$00,$00,$00
	defb $00,$55,$00,$ff,$00,$ff,$00,$55
	defb $00,$00,$00,$00,$00,$00,$00,$00
	defb $aa,$00,$ff,$00,$ff,$00,$55,$00
	defb $00,$55,$00,$ff,$04,$00,$04,$00
	defb $04,$08,$00,$28,$00,$28,$68,$00
	defb $55,$00,$ff,$00,$00,$08,$00,$08
	defb $04,$08,$14,$00,$14,$00,$00,$94
	defb $00,$00,$00,$00,$00,$00,$00,$00
	defb $00,$04,$55,$04,$ff,$ae,$aa,$ae
	defb $00,$00,$00,$00,$00,$00,$82,$00
	defb $08,$00,$00,$c1,$48,$c1,$48,$00
	defb $ff,$ae,$aa,$ae,$55,$04,$00,$04
	defb $00,$00,$00,$00,$00,$00,$00,$00
	defb $48,$00,$48,$c1,$00,$c1,$08,$00
	defb $82,$00,$00,$00,$00,$00,$00,$00
	defb $00,$28,$00,$80,$00,$80,$00,$80
	defb $00,$40,$14,$04,$04,$04,$04,$0c
	defb $14,$00,$40,$00,$40,$00,$40,$00
	defb $80,$00,$08,$28,$08,$08,$0c,$08
	defb $00,$0c,$00,$55,$00,$ff,$00,$aa
	defb $00,$aa,$00,$ff,$00,$55,$00,$00
	defb $0c,$00,$aa,$00,$ff,$00,$aa,$00
	defb $aa,$00,$ff,$00,$aa,$00,$00,$00
	defb $00,$00,$00,$00,$00,$00,$00,$41
	defb $00,$04,$c2,$00,$c2,$84,$00,$84
	defb $00,$00,$00,$00,$00,$00,$00,$00
	defb $08,$00,$08,$aa,$5d,$55,$5d,$ff
	defb $00,$84,$c2,$84,$c2,$00,$00,$04
	defb $00,$41,$00,$00,$00,$00,$00,$00
	defb $5d,$55,$5d,$ff,$08,$aa,$08,$00
	defb $00,$00,$00,$00,$00,$00,$00,$00
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
	defb $44,$44,$44,$44,$cc,$cc,$cc,$cc
	defb $88,$00,$88,$00,$cc,$00,$cc,$00
	defb $44,$00,$44,$00,$cc,$88,$cc,$88
	defb $44,$cc,$44,$cc,$44,$cc,$44,$cc
	defb $00,$cc,$00,$cc,$00,$44,$00,$44
	defb $cc,$00,$cc,$00,$cc,$00,$cc,$00
	defb $88,$00,$88,$00,$00,$00,$00,$00
	defb $00,$00,$00,$00,$00,$88,$00,$88
	defb $44,$cc,$44,$cc,$44,$44,$44,$44
	defb $00,$00,$00,$00,$88,$00,$88,$00
	defb $cc,$00,$cc,$00,$44,$00,$44,$00
	defb $44,$cc,$44,$cc,$cc,$cc,$cc,$cc
	defb $44,$cc,$44,$cc,$00,$cc,$00,$cc
	defb $cc,$00,$cc,$00,$cc,$88,$cc,$88
	defb $cc,$00,$cc,$00,$88,$00,$88,$00
	defb $00,$fc,$54,$c0,$e8,$c0,$e8,$c0
	defb $e8,$e8,$e8,$e8,$e8,$e8,$e8,$c0
	defb $a8,$00,$d4,$00,$c0,$a8,$c0,$a8
	defb $e8,$a8,$e8,$a8,$e8,$a8,$c0,$a8
	defb $e8,$c0,$e8,$c0,$e8,$c0,$54,$c0
	defb $00,$e8,$00,$54,$00,$00,$00,$00
	defb $c0,$a8,$c0,$a8,$c0,$a8,$d4,$00
	defb $d4,$00,$c0,$a8,$fc,$00,$00,$00
	defb $00,$54,$00,$e8,$54,$c0,$54,$c0
	defb $54,$d4,$54,$d4,$54,$d4,$54,$c0
	defb $fc,$00,$c0,$a8,$c0,$d4,$c0,$d4
	defb $d4,$d4,$d4,$d4,$d4,$d4,$c0,$d4
	defb $54,$c0,$54,$c0,$54,$c0,$00,$e8
	defb $00,$e8,$54,$c0,$00,$fc,$00,$00
	defb $c0,$d4,$c0,$d4,$c0,$d4,$c0,$a8
	defb $d4,$00,$a8,$00,$00,$00,$00,$00
	defb $00,$54,$00,$e8,$54,$c0,$54,$c0
	defb $54,$c0,$54,$c0,$54,$c0,$54,$c0
	defb $fc,$00,$c0,$a8,$c0,$d4,$c0,$d4
	defb $c0,$d4,$c0,$d4,$c0,$d4,$c0,$d4
	defb $54,$c0,$54,$c0,$54,$c0,$00,$e8
	defb $00,$e8,$00,$54,$00,$00,$00,$00
	defb $c0,$d4,$c0,$d4,$c0,$d4,$c0,$a8
	defb $c0,$a8,$d4,$00,$a8,$00,$00,$00
	defb $00,$fc,$54,$c0,$e8,$c0,$e8,$c0
	defb $e8,$e8,$e8,$e8,$e8,$e8,$e8,$c0
	defb $a8,$00,$d4,$00,$c0,$a8,$c0,$a8
	defb $e8,$a8,$e8,$a8,$e8,$a8,$c0,$a8
	defb $e8,$c0,$e8,$c0,$e8,$c0,$54,$c0
	defb $54,$c0,$00,$e8,$00,$54,$00,$00
	defb $c0,$a8,$c0,$a8,$c0,$a8,$d4,$00
	defb $d4,$00,$a8,$00,$00,$00,$00,$00
	defb $15,$3f,$15,$3f,$3b,$33,$3b,$33
	defb $3b,$3f,$3b,$3f,$3b,$3f,$3b,$3f
	defb $3f,$00,$3f,$00,$33,$2a,$33,$2a
	defb $3b,$2a,$3b,$2a,$3b,$2a,$3b,$2a
	defb $3b,$3f,$3b,$3f,$3b,$33,$3b,$33
	defb $15,$3f,$15,$3f,$00,$00,$00,$00
	defb $3b,$2a,$3b,$2a,$33,$2a,$33,$2a
	defb $3f,$00,$3f,$00,$00,$00,$00,$00
	defb $50,$50,$50,$50,$00,$33,$00,$33
	defb $b1,$50,$b1,$50,$a0,$a0,$a0,$a0
	defb $a0,$00,$a0,$00,$11,$a0,$11,$a0
	defb $a0,$a0,$a0,$a0,$11,$a0,$11,$a0
	defb $11,$f0,$11,$f0,$b1,$11,$b1,$11
	defb $50,$a0,$50,$a0,$00,$00,$00,$00
	defb $b1,$00,$b1,$00,$22,$a0,$22,$a0
	defb $f0,$00,$f0,$00,$00,$00,$00,$00
	defb $00,$00,$00,$00,$00,$00,$00,$00
	defb $00,$50,$00,$50,$00,$f0,$00,$f0
	defb $00,$00,$00,$00,$00,$00,$00,$00
	defb $50,$00,$50,$00,$b1,$a0,$b1,$a0
	defb $a0,$a0,$a0,$a0,$b1,$50,$b1,$50
	defb $50,$a0,$50,$a0,$00,$00,$00,$00
	defb $33,$00,$33,$00,$22,$a0,$22,$a0
	defb $f0,$00,$f0,$00,$00,$00,$00,$00
	defb $00,$00,$00,$00,$00,$00,$00,$00
	defb $00,$00,$00,$00,$00,$00,$00,$00
	defb $00,$00,$00,$00,$00,$00,$00,$00
	defb $00,$00,$00,$00,$00,$00,$00,$00
	defb $50,$50,$50,$50,$b1,$a0,$b1,$a0
	defb $50,$50,$50,$50,$00,$00,$00,$00
	defb $a0,$00,$a0,$00,$72,$00,$72,$00
	defb $a0,$a0,$a0,$a0,$00,$00,$00,$00
	defb $00,$00,$00,$00,$00,$00,$00,$00
	defb $00,$00,$00,$00,$00,$00,$00,$00
	defb $00,$00,$00,$00,$00,$00,$00,$00
	defb $00,$00,$00,$00,$00,$00,$00,$00
	defb $00,$00,$00,$00,$00,$00,$00,$00
	defb $50,$b1,$50,$b1,$00,$00,$00,$00
	defb $00,$00,$00,$00,$00,$00,$00,$00
	defb $a0,$a0,$a0,$a0,$00,$00,$00,$00
	defb $00,$00,$00,$00,$00,$00,$00,$00
	defb $00,$50,$00,$50,$00,$f0,$00,$f0
	defb $00,$00,$00,$00,$00,$00,$00,$00
	defb $00,$00,$00,$00,$a0,$00,$a0,$00
	defb $00,$50,$00,$50,$00,$00,$00,$00
	defb $00,$00,$00,$00,$00,$00,$00,$00
	defb $00,$00,$00,$00,$00,$00,$00,$00
	defb $00,$00,$00,$00,$00,$00,$00,$00
	defb $00,$00,$00,$00,$00,$00,$00,$00
	defb $00,$f0,$00,$f0,$00,$f0,$00,$f0
	defb $00,$00,$00,$00,$00,$00,$00,$00
	defb $a0,$00,$a0,$00,$a0,$00,$a0,$00
	defb $00,$f0,$00,$f0,$00,$00,$00,$00
	defb $00,$00,$00,$00,$00,$00,$00,$00
	defb $a0,$00,$a0,$00,$00,$00,$00,$00
	defb $00,$00,$00,$00,$00,$00,$00,$00
	defb $00,$00,$00,$00,$00,$50,$00,$50
	defb $00,$f0,$00,$f0,$50,$b1,$50,$b1
	defb $00,$00,$00,$00,$00,$00,$00,$00
	defb $a0,$00,$a0,$00,$f0,$00,$f0,$00
	defb $00,$f0,$00,$f0,$00,$50,$00,$50
	defb $00,$00,$00,$00,$00,$00,$00,$00
	defb $a0,$00,$a0,$00,$00,$00,$00,$00
	defb $00,$00,$00,$00,$00,$00,$00,$00
	defb $00,$00,$00,$00,$00,$f0,$00,$f0
	defb $50,$33,$50,$33,$50,$72,$50,$72
	defb $00,$00,$00,$00,$a0,$00,$a0,$00
	defb $72,$00,$72,$00,$72,$00,$72,$00
	defb $50,$33,$50,$33,$00,$f0,$00,$f0
	defb $00,$00,$00,$00,$00,$00,$00,$00
	defb $72,$00,$72,$00,$a0,$00,$a0,$00
	defb $00,$00,$00,$00,$00,$00,$00,$00
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
	defb $00,$45,$00,$45,$00,$45,$00,$45
	defb $cf,$cf,$cf,$cf,$45,$cf,$45,$cf
	defb $00,$00,$00,$00,$00,$00,$00,$00
	defb $cf,$8a,$cf,$8a,$cf,$00,$cf,$00
	defb $00,$cf,$00,$cf,$45,$8a,$45,$8a
	defb $45,$00,$45,$00,$00,$00,$00,$00
	defb $8a,$00,$8a,$00,$cf,$00,$cf,$00
	defb $45,$00,$45,$00,$00,$00,$00,$00
