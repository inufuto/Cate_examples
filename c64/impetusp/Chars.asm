cseg

MonoPattern: public MonoPattern
; ascii 32
	; " '-0123456789ACEFGHIKMNOPRSTUVYZ"
	defb $00,$00,$00,$00,$44,$40,$00,$00
	defb $00,$0e,$00,$00,$4a,$aa,$aa,$40
	defb $44,$44,$44,$40,$4a,$22,$48,$e0
	defb $4a,$24,$2a,$40,$2a,$ae,$22,$20
	defb $e8,$8c,$22,$c0,$4a,$8c,$aa,$40
	defb $ea,$22,$44,$40,$4a,$a4,$aa,$40
	defb $4a,$a6,$2a,$40,$4a,$aa,$ea,$a0
	defb $4a,$88,$8a,$40,$e8,$8c,$88,$e0
	defb $e8,$8c,$88,$80,$68,$8a,$aa,$40
	defb $aa,$ae,$aa,$a0,$e4,$44,$44,$e0
	defb $ae,$c8,$ce,$a0,$ae,$ee,$aa,$a0
	defb $ca,$aa,$aa,$a0,$4a,$aa,$aa,$40
	defb $ca,$aa,$c8,$80,$ca,$aa,$ca,$a0
	defb $4a,$84,$2a,$40,$e4,$44,$44,$40
	defb $aa,$aa,$aa,$e0,$aa,$aa,$a4,$40
	defb $aa,$a4,$44,$40,$e2,$24,$88,$e0
;	logo
	defb	$cc, $cc, $00, $00, $00, $00, $cc, $cc
	defb	$cc, $cc, $cc, $cc, $33, $33, $00, $00
	defb	$ff, $ff, $00, $00, $33, $33, $cc, $cc
	defb	$ff, $ff, $cc, $cc, $00, $00, $33, $33
	defb	$cc, $cc, $33, $33, $00, $00, $ff, $ff
	defb	$cc, $cc, $ff, $ff, $33, $33, $33, $33
	defb	$ff, $ff, $33, $33, $33, $33, $ff, $ff
	defb	$ff, $ff, $ff, $ff
;	remain
	defb	$04, $4e, $ee, $ea

SpritePattern: public SpritePattern
;	sprite
	defb	$02, $00, $02, $00, $02, $00, $02, $00
	defb	$02, $00, $02, $00, $02, $00, $02, $00
	defb	$00, $00, $00, $00, $00, $00, $00, $00
	defb	$00, $00, $00, $00, $00, $00, $00, $00
	defb	$3c, $00, $3c, $00, $eb, $00, $eb, $00
	defb	$eb, $00, $eb, $00, $3c, $00, $3c, $00
	defb	$00, $00, $00, $00, $00, $00, $00, $00
	defb	$00, $00, $00, $00, $00, $00, $00, $00
	defb	$aa, $00, $aa, $00, $be, $00, $be, $cc
	defb	$be, $33, $be, $00, $aa, $00, $aa, $00
	defb	$00, $00, $00, $00, $00, $00, $00, $00
	defb	$00, $00, $00, $00, $00, $00, $00, $00
	defb	$00, $00, $00, $00, $00, $00, $cc, $cc
	defb	$33, $33, $00, $00, $00, $00, $00, $00
	defb	$00, $00, $00, $00, $00, $00, $00, $00
	defb	$00, $00, $00, $00, $00, $00, $00, $00
	defb	$00, $aa, $00, $aa, $00, $be, $cc, $be
	defb	$33, $be, $00, $be, $00, $aa, $00, $aa
	defb	$00, $00, $00, $00, $00, $00, $00, $00
	defb	$00, $00, $00, $00, $00, $00, $00, $00
	defb	$03, $00, $03, $00, $3f, $cc, $3f, $cc
	defb	$fe, $bf, $fe, $bf, $3b, $ed, $3b, $ed
	defb	$3a, $ef, $3a, $ef, $fe, $bc, $fe, $bc
	defb	$33, $cc, $33, $cc, $03, $00, $03, $00
	defb	$00, $03, $00, $03, $0c, $03, $0c, $03
	defb	$03, $cf, $03, $cf, $03, $be, $03, $be
	defb	$0f, $ee, $0f, $ee, $ff, $bf, $ff, $bf
	defb	$3f, $bf, $3f, $bf, $0f, $fe, $0f, $fe
	defb	$00, $c0, $00, $c0, $c3, $c0, $c3, $c0
	defb	$ff, $c0, $ff, $c0, $ff, $0f, $ff, $0f
	defb	$fb, $fc, $fb, $fc, $af, $f0, $af, $f0
	defb	$fe, $c0, $fe, $c0, $fa, $c0, $fa, $c0
	defb	$0f, $fa, $0f, $fa, $3e, $ff, $3e, $ff
	defb	$fb, $bb, $fb, $bb, $0f, $eb, $0f, $eb
	defb	$03, $fa, $03, $fa, $0f, $0f, $0f, $0f
	defb	$0c, $03, $0c, $03, $00, $03, $00, $03
	defb	$fe, $b0, $fe, $b0, $ef, $ac, $ef, $ac
	defb	$ea, $bf, $ea, $bf, $bf, $c0, $bf, $c0
	defb	$bf, $c0, $bf, $c0, $c3, $f0, $c3, $f0
	defb	$00, $00, $00, $00, $00, $00, $00, $00
	defb	$2a, $a8, $2a, $a8, $99, $aa, $99, $aa
	defb	$99, $56, $99, $56, $99, $66, $99, $66
	defb	$95, $56, $95, $56, $aa, $6a, $aa, $6a
	defb	$2a, $a8, $2a, $a8, $00, $00, $00, $00
	defb	$20, $20, $20, $20, $20, $20, $22, $20
	defb	$a2, $28, $a9, $a8, $a5, $68, $a6, $68
	defb	$aa, $a8, $aa, $a8, $aa, $a8, $aa, $a8
	defb	$22, $20, $30, $30, $00, $00, $00, $00
	defb	$00, $00, $00, $00, $03, $00, $03, $00
	defb	$0f, $c0, $0f, $c0, $3f, $f0, $3f, $f0
	defb	$ff, $fc, $ff, $fc, $37, $70, $37, $70
	defb	$0f, $c0, $0f, $c0, $03, $00, $03, $00
	defb	$03, $00, $03, $00, $0f, $c0, $0f, $c0
	defb	$37, $70, $37, $70, $bf, $f8, $bf, $f8
	defb	$be, $f8, $be, $f8, $82, $08, $82, $08
	defb	$02, $00, $02, $00, $00, $00, $00, $00
	defb	$0b, $fc, $0b, $fc, $2f, $7c, $2f, $7c
	defb	$8f, $dc, $8f, $dc, $02, $fc, $02, $fc
	defb	$08, $f8, $08, $f8, $00, $20, $00, $20
	defb	$00, $80, $00, $80, $00, $00, $00, $00
	defb	$2a, $00, $2a, $00, $0f, $c0, $0f, $c0
	defb	$0f, $70, $0f, $70, $ab, $fc, $ab, $fc
	defb	$0f, $70, $0f, $70, $0f, $c0, $0f, $c0
	defb	$2a, $00, $3f, $00, $00, $00, $00, $00
	defb	$00, $80, $00, $80, $00, $20, $00, $20
	defb	$08, $f8, $08, $f8, $02, $fc, $02, $fc
	defb	$8f, $dc, $8f, $dc, $2f, $7c, $2f, $7c
	defb	$0b, $fc, $0b, $fc, $00, $00, $00, $00
	defb	$02, $00, $02, $00, $82, $08, $82, $08
	defb	$be, $f8, $be, $f8, $bf, $f8, $bf, $f8
	defb	$37, $70, $37, $70, $0f, $c0, $0f, $c0
	defb	$03, $00, $03, $00, $00, $00, $00, $00
	defb	$08, $00, $08, $00, $20, $00, $20, $00
	defb	$bc, $c0, $bc, $c0, $ff, $00, $ff, $00
	defb	$df, $c8, $df, $c8, $f7, $e0, $f7, $e0
	defb	$ff, $80, $ff, $80, $00, $00, $00, $00
	defb	$02, $a0, $02, $a0, $0f, $c0, $0f, $c0
	defb	$37, $c0, $37, $c0, $ff, $a8, $ff, $a8
	defb	$37, $c0, $37, $c0, $0f, $c0, $0f, $c0
	defb	$02, $a0, $02, $a0, $00, $00, $00, $00
	defb	$ff, $80, $ff, $80, $f7, $e0, $f7, $e0
	defb	$df, $c8, $df, $c8, $fe, $00, $fe, $00
	defb	$bc, $80, $bc, $80, $20, $00, $20, $00
	defb	$08, $00, $08, $00, $00, $00, $00, $00
	defb	$00, $00, $00, $00, $83, $08, $83, $08
	defb	$8f, $c8, $8f, $c8, $3d, $f0, $3f, $f0
	defb	$3d, $f0, $3f, $f0, $37, $70, $37, $70
	defb	$8f, $c8, $8f, $c8, $83, $08, $83, $08
	defb	$2a, $a8, $2a, $a8, $a9, $6a, $a9, $6a
	defb	$a6, $9a, $a6, $9a, $9b, $e6, $9b, $e6
	defb	$9b, $e6, $9b, $e6, $a6, $9a, $a6, $9a
	defb	$a9, $6a, $a9, $6a, $2a, $a8, $2a, $a8
	defb	$a0, $0a, $a0, $0a, $9a, $a6, $9a, $a6
	defb	$2a, $a8, $2a, $a8, $2b, $e8, $2b, $e8
	defb	$2b, $e8, $2b, $e8, $2a, $a8, $2a, $a8
	defb	$9a, $a6, $9a, $a6, $a0, $0a, $a0, $0a

FortPattern: public FortPattern
;	fort
	defb	$aa, $aa, $aa, $af, $a3, $b0, $b1, $b1
	defb	$aa, $aa, $aa, $cf, $c0, $0f, $00, $31
	defb	$ae, $bf, $bf, $3f, $3f, $cc, $03, $54
	defb	$ba, $fe, $fe, $fc, $fc, $33, $c0, $15
	defb	$aa, $aa, $aa, $f3, $03, $f0, $00, $4c
	defb	$aa, $aa, $aa, $fa, $ca, $0e, $4e, $4e
	defb	$b0, $bc, $bc, $bd, $8c, $b0, $bc, $bc
	defb	$fc, $fc, $30, $03, $33, $f3, $f3, $f0
	defb	$03, $30, $fc, $ff, $fd, $fd, $ff, $fc
	defb	$c0, $0c, $3f, $ff, $7f, $7f, $ff, $3f
	defb	$3f, $3f, $0c, $c0, $cc, $cf, $cf, $0f
	defb	$0e, $3e, $3e, $7e, $32, $0e, $3e, $3e
	defb	$b0, $80, $fc, $fc, $00, $cf, $cf, $cf
	defb	$04, $f0, $c3, $cf, $00, $3c, $3c, $3c
	defb	$30, $00, $ff, $ff, $00, $4f, $4f, $4f
	defb	$0c, $00, $ff, $ff, $00, $f1, $f1, $f1
	defb	$10, $0f, $c3, $f3, $00, $3c, $3c, $3c
	defb	$0e, $02, $3f, $3f, $00, $f3, $f3, $f3
	defb	$cf, $cf, $cf, $00, $fc, $fc, $80, $b0
	defb	$3c, $3c, $3c, $00, $cf, $c3, $f0, $04
	defb	$4f, $4f, $4f, $00, $ff, $ff, $00, $30
	defb	$f1, $f1, $f1, $00, $ff, $ff, $00, $0c
	defb	$3c, $3c, $3c, $00, $f3, $c3, $0f, $10
	defb	$f3, $f3, $f3, $00, $3f, $3f, $02, $0e
	defb	$bc, $bc, $b0, $8c, $bd, $bc, $bc, $b0
	defb	$f0, $f3, $f3, $33, $03, $30, $fc, $fc
	defb	$fc, $ff, $fd, $fd, $ff, $fc, $30, $03
	defb	$3f, $ff, $7f, $7f, $ff, $3f, $0c, $c0
	defb	$0f, $cf, $cf, $cc, $c0, $0c, $3f, $3f
	defb	$3e, $3e, $0e, $32, $7e, $3e, $3e, $0e
	defb	$b1, $b1, $b0, $a3, $af, $aa, $aa, $aa
	defb	$31, $00, $0f, $c0, $cf, $aa, $aa, $aa
	defb	$54, $03, $cc, $3f, $3f, $bf, $bf, $ae
	defb	$15, $c0, $33, $fc, $fc, $fe, $fe, $ba
	defb	$4c, $00, $f0, $03, $f3, $aa, $aa, $aa
	defb	$4e, $4e, $0e, $ca, $fa, $aa, $aa, $aa
