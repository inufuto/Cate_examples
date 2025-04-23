include "char.inc"

	extrn	Stages, Stage.Count, TimeRate

map.max.width	equ	64
map.max.height	equ	64
map.step		equ map.max.width / 8
map.size 		equ map.step * map.max.height

	dseg
map			defs	map.size
stage		defb	0
map.width	defb	0
map.height	defb	0
stage.width		defb	0
stage.height	defb	0
goal.x defb 0
goal.y defb 0
Stage.Time defw 0
blink defb 0
Stage.Clear defb 0

	extrn Man.Init
	extrn Kn.Init
	extrn Mon.Init
	extrn Put2x2
	public	map, map.step, stage, map.width,map.height
	public goal.x,goal.y, Stage.Clear, Stage.Time

	cseg	
ToMapSize:
	public ToMapSize
	ld c,a
	add a,a
	add a,c
	inc a
	ret
RotBit:
	rlc c
	if c
		ld (ix), a
		xor a
		inc ix
	endif
	ret
RotBit2:
	rlc c
	if c
		ld (ix), a
		ld (ix+map.step), a
		xor a
		inc ix
	endif
	ret

InitMap: public	InitMap
	ld hl,map
	ld bc,map.size
	do
		ld (hl),0
		inc hl
		dec bc
		ld a,b
		or c
	while nz|wend

	ld bc,Stage.Count
	ld a,(stage)
	ld b,10
	do
		sub c
	while nc
		dec b
	wend
	add a,c
	push af
		ld a,b
		cp 2
		if c 
			ld a,2
		endif
		ld (TimeRate),a
	pop af
	
	add	a,a
	ld	e,a
	ld	d,0
	ld	ix, Stages
	add	ix,de
	ld	l,(ix)
	ld	h,(ix+1)

	ld	a,(hl)
	ld (stage.width),a
	call ToMapSize
	ld	(map.width),a
	inc hl
	ld	a,(hl)
	ld (stage.height),a
	call ToMapSize
	ld	(map.height),a
	inc hl
	ld ix,map

	push ix
		ld a,(map.width)
		ld b,a
		ld c,1
		xor a
		do
			or c
			call RotBit
		dwnz
		ld (ix), a
	pop ix
	ld de,map.step
	add ix,de

	ld d,(hl)
	inc hl
	ld e,8
	ld a,(stage.height)
	ld b,a
	do
		push bc
			push ix
				ld a,(stage.width)
				ld b,a
				ld c,1
				ld a,c
				call RotBit2
				do
					call RotBit2
					call RotBit2
					bit 0,d
					if nz
						or c
					endif
					call RotBit2
					srl d
					dec e
					if z
						ld d,(hl)
						inc hl
						ld e,8
					endif
				dwnz
				ld (ix), a
				ld (ix+map.step), a
			pop ix
			ld bc,map.step*2
			add ix,bc
			
			push ix
				ld a,(stage.width)
				ld b,a
				ld c,1
				ld a,c
				call RotBit
				do
					bit 0,d
					if nz
						or c
						call RotBit
						or c
						call RotBit
					else
						call RotBit
						call RotBit
					endif
					or c
					call RotBit
					srl d
					dec e
					if z
						ld d,(hl)
						inc hl
						ld e,8
					endif
				dwnz
				ld (ix), a
			pop ix
			ld bc,map.step
			add ix,bc
		pop bc
	dwnz

	ld a,e
	cp 8
	if z
		dec hl
	endif
	
	; man
	call Man.init
	; goal
	ld a,(hl) | inc hl | call ToMapSize | ld(goal.x),a
	ld a,(hl) | inc hl | call ToMapSize | ld(goal.y),a
	; knives
	ld b,(hl)
	inc hl
	call Kn.Init
	; monsters
	ld b,(hl)
	inc hl
	call Mon.Init
	; time
	ld e,(hl)
	inc hl
	ld d,(hl)
	ex de,hl
	ld (Stage.Time),hl
ret

Tst2x2:  public Tst2x2
; in
;	l: x
;	h: y
; out
;	z = 0: can move
; use af
	push hl
	push de
	push bc
		ld a,l
		ld l,h
		ld h,0
		add hl,hl   ;*2
		add hl,hl   ;*4
		add hl,hl   ;*8: map.step
		push af
			and 0f8h
			rrca
			rrca
			rrca
			ld e,a
			ld d,0
			add hl,de
		pop af
		ld de,3
		and 7
		if nz
			ld b,a
			do
				sla e
				rl d
			dwnz
		endif
		ld bc,map
		add hl,bc
		ld b,2
		do
			ld a,(hl)
			and e
			jp nz, tm4end
			bit 0,d
			if nz
				inc hl
				ld a,(hl)
				dec hl
				and d
				jp nz, tm4end
			endif
			push de
				ld de,map.step
				add hl,de
			pop de
		dwnz
tm4end:
	pop bc
	pop de
	pop hl
ret	

Tst1x1:
	public Tst1x1
; in
;	l: x
;	h: y
; out
;	z = 0: can move
; use af
	push hl
	push de
	push bc
		ld a,l
		ld l,h
		ld h,0
		add hl,hl   ;*2
		add hl,hl   ;*4
		add hl,hl   ;*8: map.step
		push af
			srl a
			srl a
			srl a
			ld e,a
			ld d,0
			add hl,de
		pop af
		ld e,1
		and 07h
		if nz
			ld b,a
			do
				sla e
			dwnz
		endif
		ld bc,map
		add hl,bc
		ld a,(hl)
		and e
	pop bc
	pop de
	pop hl
ret	


Goal.Draw: public Goal.Draw
	ld a,(blink)
	inc a
	ld (blink),a
	and 1
	ret z
	ld hl,(goal.x)
	ld a,Char.Goal
	call Put2x2
ret	