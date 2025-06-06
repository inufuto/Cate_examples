﻿include "Vram.inc"
include "Chars.inc"

ext EraseBackup_, DrawSprite_

InvalidPattern equ 0ffh
Sprite_End equ 15

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
	defs unitSize*Sprite_End

; void HideAllSprites();
cseg
HideAllSprites_: public HideAllSprites_
	push af | push hl | push bc
		ld hl,Sprites
		ld a,InvalidPattern
		ld b,unitSize*Sprite_End
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
		ld b,Sprite_End
		do
			ld a,(ix+old1Pattern)
			cp InvalidPattern
			if nz
				ld c,2
				cp Pattern_Knife
				if nc
					dec c
				endif
				ld e,(ix+old1Y)
				ld a,(ix+old1X)
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
		ld b,Sprite_End
		do
			ld a,(ix+nowPattern)
			cp InvalidPattern
			if nz
				ld c,a
				ld e,(ix+nowY)
				ld a,(ix+nowX)
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
