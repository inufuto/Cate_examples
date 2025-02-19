include "Vram.inc"
include "VVram.inc"

ext EraseBackup_, DrawSprite_

CoordRate equ 2
InvalidPattern equ 0ffh
MaxX equ (VVramWidth-2)*CoordRate+1
MaxY equ (VVramHeight-2)*CoordRate+1
SpriteCount equ 28

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


; void ShowSprite(byte index, byte x, byte y, sbyte pattern);
dseg
ShowSprite_@Param3: public ShowSprite_@Param3
ShowSprite_pattern:
	defb 0
cseg
ShowSprite_: public ShowSprite_
	push af | push hl | push bc
		ld l,a
		ld h,0
		ld a,c
			ld c,l | ld b,h
			add hl,hl ;*2
			add hl,hl ;*4
			add hl,hl ;*8
			add hl,bc ;*9
			ld bc,Sprites | add hl,bc
		ld c,a
		ld (hl),e | inc hl ;x
		ld (hl),c | inc hl ;y
		ld a,(ShowSprite_pattern) | ld (hl),a
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
