Stage.Count	equ	10
	public	Stage.Count
cseg
Stages_: public Stages_
	defw	Stage0
	defw	Stage1
	defw	Stage2
	defw	Stage3
	defw	Stage4
	defw	Stage5
	defw	Stage6
	defw	Stage7
	defw	Stage8
	defw	Stage9
Stage0:	defb	6,6
	defb	$a4,$04,$9f,$2d,$85,$d6,$60,$45
	defb	$ff
	defb	0,0
	defb	5,5
	defb	2
	defb	2,1
	defb	0,5
	defb	2
	defb	5,131
	defb	4,68
	defw	36
Stage1:	defb	7,7
	defb	$e0,$5b,$91,$ae,$56,$5d,$51,$4e
	defb	$59,$50,$07,$fe,$03
	defb	5,2
	defb	0,0
	defb	1
	defb	6,2
	defb	3
	defb	2,64
	defb	6,128
	defb	1,133
	defw	49
Stage2:	defb	8,8
	defb	$d4,$55,$a1,$6a,$a6,$b9,$96,$6a
	defb	$90,$2e,$f9,$ac,$f7,$10,$84,$ff
	defb	7,0
	defb	3,5
	defb	1
	defb	7,2
	defb	3
	defb	0,128
	defb	1,5
	defb	4,135
	defw	64
Stage3:	defb	9,9
	defb	$b4,$2d,$11,$b4,$86,$b7,$e5,$58
	defb	$da,$43,$f1,$92,$5c,$4b,$d0,$1d
	defb	$4e,$23,$c4,$ff,$03
	defb	0,3
	defb	8,8
	defb	2
	defb	1,3
	defb	8,3
	defb	3
	defb	2,129
	defb	7,134
	defb	8,134
	defw	81
Stage4:	defb	10,9
	defb	$44,$4b,$55,$6b,$45,$59,$b3,$75
	defb	$36,$2e,$84,$ca,$d5,$b5,$6b,$1a
	defb	$0a,$c6,$a6,$49,$34,$ff,$0f
	defb	0,0
	defb	8,4
	defb	1
	defb	4,8
	defb	4
	defb	3,128
	defb	5,128
	defb	7,66
	defb	9,4
	defw	90
Stage5:	defb	10,9
	defb	$0c,$17,$27,$73,$69,$5e,$ca,$44
	defb	$7e,$0d,$25,$b3,$62,$bf,$cc,$08
	defb	$ba,$8b,$ba,$1b,$40,$fe,$0f
	defb	9,0
	defb	0,0
	defb	4
	defb	4,2
	defb	5,2
	defb	9,5
	defb	9,7
	defb	6
	defb	0,66
	defb	0,133
	defb	0,134
	defb	0,135
	defb	1,136
	defb	2,136
	defw	90
Stage6:	defb	11,10
	defb	$64,$ac,$29,$53,$69,$96,$51,$d7
	defb	$16,$55,$ad,$50,$dd,$42,$79,$69
	defb	$25,$c2,$ea,$67,$93,$a4,$dd,$36
	defb	$0a,$03,$ff,$0f
	defb	3,5
	defb	8,4
	defb	2
	defb	2,2
	defb	8,7
	defb	7
	defb	5,130
	defb	10,130
	defb	6,132
	defb	10,133
	defb	8,70
	defb	2,137
	defb	5,9
	defw	110
Stage7:	defb	12,11
	defb	$d8,$e8,$d2,$a4,$59,$4b,$59,$cc
	defb	$72,$82,$e9,$ab,$6b,$4c,$19,$a2
	defb	$9a,$59,$8f,$4c,$ee,$a3,$8d,$49
	defb	$b5,$c9,$aa,$8a,$5e,$1e,$10,$f8
	defb	$ff
	defb	4,1
	defb	11,7
	defb	4
	defb	2,0
	defb	11,0
	defb	5,5
	defb	7,8
	defb	5
	defb	3,133
	defb	11,133
	defb	8,134
	defb	8,135
	defb	8,136
	defw	132
Stage8:	defb	12,12
	defb	$24,$ef,$1a,$34,$d9,$68,$ac,$3d
	defb	$4a,$4c,$6a,$b7,$34,$e9,$b4,$e9
	defb	$ca,$92,$2c,$5b,$8a,$54,$a9,$d2
	defb	$e6,$be,$12,$41,$ae,$1b,$30,$ad
	defb	$35,$05,$fa,$ff
	defb	11,0
	defb	2,0
	defb	4
	defb	5,2
	defb	10,2
	defb	11,8
	defb	9,11
	defb	8
	defb	6,130
	defb	0,3
	defb	2,3
	defb	4,3
	defb	8,3
	defb	0,133
	defb	5,133
	defb	11,74
	defw	144
Stage9:	defb	12,12
	defb	$75,$c8,$70,$c4,$58,$a7,$ba,$dd
	defb	$18,$87,$8a,$de,$d5,$4d,$45,$af
	defb	$0f,$1a,$9c,$68,$da,$2c,$39,$b7
	defb	$07,$8f,$1e,$99,$c8,$d6,$48,$49
	defb	$92,$a4,$fa,$ff
	defb	10,9
	defb	0,11
	defb	4
	defb	2,0
	defb	6,0
	defb	5,9
	defb	11,11
	defb	8
	defb	8,128
	defb	8,129
	defb	7,130
	defb	4,131
	defb	8,131
	defb	3,133
	defb	2,137
	defb	1,75
	defw	144