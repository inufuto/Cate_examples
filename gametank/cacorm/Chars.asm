cseg

AsciiPattern: public AsciiPattern
	; ascii 29
	; " -0123456789:ACEFGHIMNOPRSTUV"
	defb $00,$00,$00,$00,$e0,$00,$ea,$aa
	defb $e0,$22,$22,$20,$e2,$e8,$e0,$e2
	defb $e2,$e0,$aa,$e2,$20,$e8,$e2,$e0
	defb $e8,$ea,$e0,$e2,$44,$40,$ea,$ea
	defb $e0,$ea,$e2,$e0,$04,$04,$00,$4a
	defb $ae,$a0,$4a,$8a,$40,$e8,$c8,$e0
	defb $e8,$c8,$80,$68,$aa,$40,$aa,$ea
	defb $a0,$e4,$44,$e0,$ae,$ea,$a0,$ca
	defb $aa,$a0,$4a,$aa,$40,$ea,$e8,$80
	defb $ca,$ca,$a0,$68,$e2,$c0,$e4,$44
	defb $40,$aa,$aa,$e0,$aa,$aa,$40

MonoPattern: public MonoPattern
;	logo
	defb	$00, $00, $cc, $00, $00, $cc, $cc, $cc
	defb	$33, $00, $ff, $00, $33, $cc, $ff, $cc
	defb	$00, $33, $cc, $33, $00, $ff, $cc, $ff
	defb	$33, $33, $ff, $33, $33, $ff, $ff, $ff
;	fence
	defb	$f0, $00
;	mono8
	defb	$ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff
	defb	$11, $f7, $00, $ec, $32, $40, $88, $40
;	line
	defb	$11, $1f, $88, $8f, $f1, $11, $f8, $88
	defb	$88, $88, $11, $11, $f0, $00, $00, $0f
;	line
	defb	$11, $1f, $88, $8f, $f1, $11, $f8, $88
	defb	$88, $88, $11, $11, $f0, $00, $00, $0f

ColorPattern: public ColorPattern
;	remain
	defb	$00, $77, $07, $77, $08, $78, $07, $77
	defb	$70, $00, $77, $00, $77, $00, $77, $00
	defb	$05, $d5, $05, $55, $07, $70, $77, $00
	defb	$55, $70, $55, $70, $77, $00, $07, $70

SpritePattern: public SpritePattern
;	sprite
	defb	$00, $77, $70, $00, $07, $77, $77, $00
	defb	$08, $78, $77, $00, $07, $77, $77, $00
	defb	$05, $d5, $55, $70, $05, $55, $55, $70
	defb	$07, $70, $77, $00, $77, $00, $07, $70
	defb	$00, $77, $70, $00, $07, $77, $77, $00
	defb	$08, $78, $77, $00, $07, $77, $77, $00
	defb	$05, $d5, $55, $70, $75, $55, $55, $07
	defb	$00, $70, $77, $00, $00, $07, $70, $00
	defb	$00, $07, $77, $00, $00, $77, $77, $70
	defb	$00, $77, $87, $80, $00, $77, $77, $70
	defb	$07, $55, $5d, $50, $07, $55, $55, $50
	defb	$00, $77, $07, $70, $07, $70, $00, $77
	defb	$00, $07, $77, $00, $00, $77, $77, $70
	defb	$00, $77, $87, $80, $00, $77, $77, $70
	defb	$07, $55, $5d, $50, $70, $55, $55, $57
	defb	$00, $77, $07, $00, $00, $07, $70, $00
	defb	$00, $77, $70, $00, $07, $77, $77, $00
	defb	$07, $77, $77, $00, $07, $77, $77, $00
	defb	$75, $55, $55, $70, $75, $55, $55, $00
	defb	$07, $70, $77, $00, $00, $00, $77, $00
	defb	$00, $77, $70, $00, $07, $77, $77, $00
	defb	$07, $77, $77, $00, $07, $77, $77, $00
	defb	$75, $55, $55, $70, $05, $55, $55, $70
	defb	$07, $70, $77, $00, $07, $70, $00, $00
	defb	$00, $07, $77, $00, $00, $77, $77, $70
	defb	$00, $78, $78, $70, $00, $77, $77, $70
	defb	$07, $55, $d5, $57, $00, $55, $55, $57
	defb	$00, $77, $07, $70, $00, $77, $00, $00
	defb	$00, $07, $77, $00, $00, $77, $77, $70
	defb	$00, $78, $78, $70, $00, $77, $77, $70
	defb	$07, $55, $d5, $57, $07, $55, $55, $50
	defb	$00, $77, $07, $70, $00, $00, $07, $70
	defb	$00, $30, $30, $00, $03, $33, $33, $00
	defb	$08, $38, $33, $00, $33, $33, $33, $30
	defb	$03, $33, $33, $00, $00, $33, $33, $00
	defb	$00, $03, $30, $00, $00, $00, $33, $00
	defb	$00, $00, $00, $00, $00, $30, $30, $00
	defb	$03, $33, $33, $00, $08, $38, $33, $00
	defb	$03, $33, $33, $00, $33, $33, $33, $30
	defb	$00, $33, $33, $00, $00, $03, $33, $00
	defb	$00, $03, $03, $00, $00, $33, $33, $30
	defb	$00, $33, $83, $80, $03, $33, $33, $33
	defb	$00, $33, $33, $30, $00, $33, $33, $00
	defb	$00, $03, $30, $00, $00, $33, $00, $00
	defb	$00, $00, $00, $00, $00, $03, $03, $00
	defb	$00, $33, $33, $30, $00, $33, $83, $80
	defb	$00, $33, $33, $30, $03, $33, $33, $33
	defb	$00, $33, $33, $00, $00, $33, $30, $00
	defb	$00, $03, $03, $00, $00, $33, $33, $30
	defb	$00, $33, $33, $30, $03, $33, $33, $33
	defb	$00, $33, $33, $30, $00, $33, $33, $30
	defb	$00, $03, $33, $00, $00, $00, $30, $00
	defb	$00, $00, $00, $00, $00, $03, $03, $00
	defb	$00, $33, $33, $30, $00, $33, $33, $30
	defb	$00, $33, $33, $30, $03, $33, $33, $33
	defb	$00, $33, $33, $30, $00, $03, $33, $00
	defb	$00, $30, $30, $00, $03, $33, $33, $00
	defb	$03, $83, $83, $00, $33, $33, $33, $30
	defb	$03, $33, $33, $00, $03, $33, $33, $00
	defb	$00, $33, $30, $00, $00, $03, $00, $00
	defb	$00, $00, $00, $00, $00, $30, $30, $00
	defb	$03, $33, $33, $00, $03, $83, $83, $00
	defb	$03, $33, $33, $00, $33, $33, $33, $30
	defb	$03, $33, $33, $00, $00, $33, $30, $00
	defb	$00, $00, $00, $00, $07, $00, $f0, $00
	defb	$77, $0f, $0f, $00, $07, $0f, $0f, $00
	defb	$07, $00, $f0, $70, $77, $70, $07, $07
	defb	$00, $00, $07, $07, $00, $00, $00, $70
	defb	$00, $00, $00, $00, $07, $00, $f0, $00
	defb	$70, $7f, $0f, $00, $00, $7f, $0f, $00
	defb	$07, $00, $f0, $70, $77, $70, $07, $07
	defb	$00, $00, $07, $07, $00, $00, $00, $70
	defb	$00, $00, $00, $00, $00, $70, $f0, $00
	defb	$70, $7f, $0f, $00, $77, $7f, $0f, $00
	defb	$00, $70, $f0, $70, $00, $70, $07, $07
	defb	$00, $00, $07, $07, $00, $00, $00, $70
	defb	$00, $00, $00, $00, $07, $00, $f0, $00
	defb	$70, $7f, $0f, $00, $07, $0f, $0f, $00
	defb	$70, $70, $f0, $70, $07, $00, $07, $07
	defb	$00, $00, $07, $07, $00, $00, $00, $70
	defb	$04, $44, $44, $40, $41, $41, $44, $44
	defb	$41, $41, $aa, $a4, $41, $41, $a4, $a4
	defb	$41, $11, $aa, $a4, $44, $44, $a4, $44
	defb	$04, $44, $44, $40, $00, $00, $00, $00
