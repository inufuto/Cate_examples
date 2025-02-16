include "Vram.inc"

ext EraseBackup_, DrawSprite_

CoordRate equ 2
InvalidPattern equ 0ffh
MaxX equ (32-2)*CoordRate+1
MaxY equ (22-2)*CoordRate+1
SpriteCount equ 23

nowX equ 0
nowY equ 1
nowPattern equ 2
old0X equ 3
old0Y equ 4
old0Pattern equ 5
old1X equ 6
old1Y equ 7
old1Pattern equ 8
unitSize equ 9

dseg
Sprites: public Sprites
	defs unitSize*SpriteCount

; void HideAllSprites();
cseg
HideAllSprites_: public HideAllSprites_
	push af | push hl | push bc
		ld hl,Sprites
		ld a,InvalidPattern
		ld b,unitSize*SpriteCount
		do
			ld (hl),a | inc hl
		dwnz
	pop bc | pop hl | pop af
ret


; void ShowSprite(ptr<Movable> pMovable, byte pattern);
cseg
ShowSprite_: public ShowSprite_
	push af | push hl | push bc
		ld l,(ix+2) ; index
		ld h,0
		ld c,l | ld b,h
		add hl,hl ;*2
		add hl,hl ;*4
		add hl,hl ;*8
		add hl,bc ;*9
		ld bc,Sprites | add hl,bc
		ld a,(ix) | ld (hl),a | inc hl ;x
		ld a,(ix+1) | ld (hl),a | inc hl ;y
		ld (hl),e
	pop bc | pop hl | pop af
ret


; void HideSprite(byte index);
cseg
HideSprite_: public HideSprite_
	push af | push hl | push de
		ld l,a | ld h,0
		ld e,l | ld d,h
		add hl,hl ;*2
		add hl,hl ;*4
		add hl,hl ;*8
		add hl,de ;*9
		ld de,Sprites+nowPattern | add hl,de
		ld (hl),InvalidPattern
	pop de | pop hl | pop af
ret


; void EraseSprites();
cseg
EraseSprites_: public EraseSprites_
	push af | push bc | push de | push ix
		ld ix,Sprites
		ld b,SpriteCount
		do
			ld a,(ix+old1Pattern)
			cp InvalidPattern
			if nz
				ld a,(ix+old1Y)
				cp MaxY
				jr nc,EraseSprites_next
				ld e,a
				ld a,(ix+old1X)
				cp MaxX
				jr nc,EraseSprites_next
				call EraseBackup_
			endif
			EraseSprites_next:
			ld a,(ix+old0Pattern)
			cp InvalidPattern
			if nz
				ld a,(ix+old0X) | ld (ix+old1X),a
				ld a,(ix+old0Y) | ld (ix+old1Y),a
				ld a,(ix+old0Pattern) | ld (ix+old1Pattern),a
			endif
			ld de,unitSize | add ix,de
		dwnz
	pop ix | pop de | pop bc | pop af
ret


; void DrawSprites()
cseg
DrawSprites_: public DrawSprites_
	push af | push bc | push de | push ix
		ld ix,Sprites
		ld b,SpriteCount
		do
			ld a,(ix+nowPattern)
			cp InvalidPattern
			if nz
				ld c,a
				ld a,(ix+nowY)
				cp MaxY
				jr nc,DrawSprites_next
				ld e,a
				ld a,(ix+nowX)
				cp MaxX
				jr nc,DrawSprites_next
				call DrawSprite_
			endif
			DrawSprites_next:
			ld a,(ix+nowX) | ld (ix+old0X),a
			ld a,(ix+nowY) | ld (ix+old0Y),a
			ld a,(ix+nowPattern) | ld (ix+old0Pattern),a

			ld de,unitSize | add ix,de
		dwnz
	pop ix | pop de | pop bc | pop af
ret
