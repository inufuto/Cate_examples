; Cartridge header template: file offset $00-$201, linked at $8000 (cseg=8000-8201,4000).
; $8050-$8052 is the BIOS sound table pointer { lo, hi, bank }. MakeSoundRom.csx patches it
; in the finished ROM image, so keep it as $00,$00,$00 here.
cseg
	; $8000: title
	defb $b9,$e3,$d6,$dd,$b4,$fa,$b4,$fa
	defb $d0,$c7,$b5,$e7,$d7,$d3,$bf,$c6
	defb $bc,$bc,$d3,$d0,$cf,$de,$b9,$ab
	defb $cb,$be

    defs $36		; $801A-$804F
	defb $00,$00,$00	; $8050: sound table pointer (patched by MakeSoundRom.csx)
    defs $2d		; $8053-$807F
; L8080: public L8080
	defb $30,$20,$00,$00,$00,$00,$00,$00
	defb $3f,$3c,$33,$f0,$00,$00,$00,$00
	defb $00,$00,$00,$03,$fc,$f3,$cc,$ff
	defb $00,$00,$00,$00,$00,$00,$00,$0f
	defb $ff,$cf,$3c,$ff,$c0,$00,$00,$00
	defb $00,$00,$00,$03,$ff,$fc,$f0,$ff
	defb $fc,$00,$00,$00,$00,$00,$00,$00
	defb $ff,$ff,$cc,$ff,$ff,$00,$00,$00
	defb $00,$00,$00,$00,$0f,$ff,$f3,$ff
	defb $ff,$c0,$00,$00,$00,$00,$00,$00
	defb $00,$ff,$0f,$ff,$ff,$f0,$00,$00
	defb $00,$00,$00,$00,$00,$30,$0f,$ff
	defb $ff,$f0,$00,$00,$00,$00,$00,$00
	defb $00,$00,$3f,$ff,$ff,$f0,$00,$00
	defb $00,$00,$00,$00,$00,$00,$ff,$ff
	defb $ff,$f0,$00,$00,$00,$00,$00,$00
	defb $00,$00,$03,$ff,$ff,$f0,$00,$00
	defb $00,$00,$00,$00,$00,$00,$00,$3f
	defb $ff,$f0,$00,$00,$00,$00,$00,$00
	defb $3c,$03,$ff,$ff,$ff,$c0,$00,$00
	defb $00,$00,$00,$00,$ff,$03,$ff,$ff
	defb $ff,$c0,$00,$00,$00,$00,$00,$03
	defb $ff,$cf,$ff,$ff,$ff,$00,$00,$00
	defb $00,$00,$00,$03,$ff,$ff,$ff,$ff
	defb $ff,$00,$00,$00,$00,$00,$00,$00
	defb $3f,$ff,$ff,$ff,$fc,$00
; L814E: public L814E
	defb $00,$00,$00,$00,$00,$28,$03,$ff
	defb $ff,$ff,$f0,$00,$00,$22,$00,$22
	defb $02,$82,$80,$ff,$ff,$ff,$f0,$00
	defb $00,$82,$20,$82,$22,$00,$80,$0f
	defb $ff,$ff,$c0,$00,$00,$82,$00,$82
	defb $02,$82,$80,$00,$ff,$ff,$00,$00
	defb $02,$8a,$a2,$8a,$a2,$aa,$80,$00
	defb $0f,$fc,$00,$00,$00,$82,$02,$82
	defb $02,$28,$00,$00,$00,$f0,$00,$00
	defb $00,$82,$08,$82,$08,$aa,$80,$00
	defb $00,$00,$00,$00,$00,$80,$88,$80
	defb $88,$28,$00,$00,$00,$00,$00,$00
	defb $00,$80,$20,$80,$22,$aa,$a0,$00
	defb $00,$00,$00,$00,$00,$00,$00,$00
	defb $00,$00,$00,$00,$00,$00,$00,$00
	defb $03,$fc,$f3,$2a,$a3,$ff,$0f,$f0
	defb $ff,$0f,$f0,$00,$00,$f0,$f3,$ca
	defb $8f,$c0,$03,$c3,$c3,$c0,$0c,$00
	defb $00,$f0,$f3,$f2,$33,$ff,$03,$c3
	defb $28,$cf,$f0,$00,$00,$f0,$f3,$cc
	defb $c3,$c0,$03,$c3,$c3,$cf,$00,$00
	defb $00,$f0,$f3,$c3,$03,$ff,$03,$c0
	defb $ff,$0f,$00,$00

; RomHeadEnd: public RomHeadEnd