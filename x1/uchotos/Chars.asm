cseg

MonoPattern: public MonoPattern
; ascii 30
	; " -0123456789ACEFGHIKMNOPRSTUVY"
	defb 00h,00h,00h,00h,00h,00h,00h,00h
	defb 00h,00h,00h,7eh,00h,00h,00h,00h
	defb 3eh,63h,67h,6bh,73h,63h,3eh,00h
	defb 18h,78h,18h,18h,18h,18h,7eh,00h
	defb 3eh,63h,07h,1eh,3ch,70h,7fh,00h
	defb 3eh,63h,03h,1eh,03h,63h,3eh,00h
	defb 06h,0eh,1eh,36h,66h,7fh,06h,00h
	defb 7fh,60h,7eh,03h,03h,63h,3eh,00h
	defb 1eh,30h,60h,7eh,63h,63h,3eh,00h
	defb 7fh,63h,06h,0ch,18h,18h,18h,00h
	defb 3eh,63h,63h,3eh,63h,63h,3eh,00h
	defb 3eh,63h,63h,3fh,03h,63h,3eh,00h
	defb 1ch,36h,63h,63h,7fh,63h,63h,00h
	defb 1eh,33h,60h,60h,60h,33h,1eh,00h
	defb 7eh,60h,60h,7eh,60h,60h,7eh,00h
	defb 7eh,60h,60h,7eh,60h,60h,60h,00h
	defb 1eh,33h,60h,6fh,63h,33h,1fh,00h
	defb 63h,63h,63h,7fh,63h,63h,63h,00h
	defb 7eh,18h,18h,18h,18h,18h,7eh,00h
	defb 63h,66h,6ch,78h,6ch,66h,63h,00h
	defb 7eh,6bh,6bh,6bh,6bh,6bh,6bh,00h
	defb 63h,73h,7bh,7fh,6fh,67h,63h,00h
	defb 3eh,63h,63h,63h,63h,63h,3eh,00h
	defb 7eh,63h,63h,63h,7eh,60h,60h,00h
	defb 7eh,63h,63h,67h,7ch,6eh,67h,00h
	defb 3eh,63h,60h,3eh,03h,63h,3eh,00h
	defb 7eh,18h,18h,18h,18h,18h,18h,00h
	defb 63h,63h,63h,63h,63h,63h,3eh,00h
	defb 63h,63h,63h,36h,36h,1ch,1ch,00h
	defb 66h,66h,66h,3ch,18h,18h,18h,00h
;	logo
	defb	0f0h, 0f0h, 0f0h, 0f0h, 00h, 00h, 00h, 00h
	defb	00h, 00h, 00h, 00h, 0f0h, 0f0h, 0f0h, 0f0h
	defb	0f0h, 0f0h, 0f0h, 0f0h, 0f0h, 0f0h, 0f0h, 0f0h
	defb	0fh, 0fh, 0fh, 0fh, 00h, 00h, 00h, 00h
	defb	0ffh, 0ffh, 0ffh, 0ffh, 00h, 00h, 00h, 00h
	defb	0fh, 0fh, 0fh, 0fh, 0f0h, 0f0h, 0f0h, 0f0h
	defb	0ffh, 0ffh, 0ffh, 0ffh, 0f0h, 0f0h, 0f0h, 0f0h
	defb	00h, 00h, 00h, 00h, 0fh, 0fh, 0fh, 0fh
	defb	0f0h, 0f0h, 0f0h, 0f0h, 0fh, 0fh, 0fh, 0fh
	defb	00h, 00h, 00h, 00h, 0ffh, 0ffh, 0ffh, 0ffh
	defb	0f0h, 0f0h, 0f0h, 0f0h, 0ffh, 0ffh, 0ffh, 0ffh
	defb	0fh, 0fh, 0fh, 0fh, 0fh, 0fh, 0fh, 0fh
	defb	0ffh, 0ffh, 0ffh, 0ffh, 0fh, 0fh, 0fh, 0fh
	defb	0fh, 0fh, 0fh, 0fh, 0ffh, 0ffh, 0ffh, 0ffh
	defb	0ffh, 0ffh, 0ffh, 0ffh, 0ffh, 0ffh, 0ffh, 0ffh
;	mono8
	defb	60h, 7fh, 7fh, 60h, 60h, 7fh, 7fh, 60h
	defb	06h, 0feh, 0feh, 06h, 06h, 0feh, 0feh, 06h
	defb	0efh, 0efh, 0efh, 00h, 0feh, 0feh, 0feh, 00h
;	mono16
	defb	00h, 00h, 00h, 01h, 01h, 01h, 7fh, 3fh
	defb	00h, 80h, 80h, 0c0h, 0c0h, 0c0h, 0ffh, 0feh
	defb	0fh, 07h, 07h, 07h, 0fh, 0ch, 08h, 00h
	defb	0f8h, 0f0h, 0f0h, 0f0h, 78h, 18h, 08h, 00h

ColorPattern: public ColorPattern
;	color16
	defb	00h, 07h, 0fh, 0ah, 0ah, 0fh, 07h, 00h
	defb	00h, 07h, 0fh, 0ah, 0ah, 0fh, 07h, 00h
	defb	00h, 07h, 0fh, 0ah, 0ah, 0fh, 07h, 00h
	defb	00h, 80h, 0c0h, 0c0h, 0c0h, 0c0h, 80h, 00h
	defb	00h, 80h, 0c0h, 0c0h, 0c0h, 0c0h, 80h, 00h
	defb	00h, 80h, 0c0h, 0c0h, 0c0h, 0c0h, 80h, 00h
	defb	00h, 00h, 07h, 04h, 0ch, 0ch, 00h, 00h
	defb	1fh, 37h, 30h, 00h, 00h, 00h, 0ch, 00h
	defb	00h, 00h, 30h, 00h, 00h, 00h, 0ch, 00h
	defb	00h, 00h, 80h, 80h, 0c0h, 0c0h, 00h, 00h
	defb	0e0h, 0b0h, 30h, 00h, 00h, 00h, 0c0h, 00h
	defb	00h, 00h, 30h, 00h, 00h, 00h, 0c0h, 00h
	defb	00h, 08h, 11h, 11h, 11h, 00h, 3fh, 7fh
	defb	00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h
	defb	00h, 08h, 11h, 11h, 11h, 00h, 3fh, 7fh
	defb	00h, 88h, 10h, 10h, 10h, 00h, 0f8h, 0fch
	defb	00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h
	defb	00h, 88h, 10h, 10h, 10h, 00h, 0f8h, 0fch
	defb	6bh, 77h, 6bh, 3fh, 3fh, 1fh, 07h, 00h
	defb	00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h
	defb	6bh, 77h, 6bh, 3fh, 3fh, 1fh, 07h, 00h
	defb	0ach, 0dch, 0ach, 0f8h, 0f8h, 0f0h, 0c0h, 00h
	defb	00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h
	defb	0ach, 0dch, 0ach, 0f8h, 0f8h, 0f0h, 0c0h, 00h

SpritePattern: public SpritePattern
;	sprite
	defb	07h, 80h, 0fh, 0c0h, 1fh, 0e0h, 1fh, 0e0h
	defb	1fh, 0e0h, 1fh, 0e0h, 0fh, 0c0h, 1fh, 0e0h
	defb	20h, 10h, 48h, 48h, 4fh, 0c8h, 3fh, 0f0h
	defb	1fh, 0e0h, 1fh, 0e0h, 13h, 20h, 0ch, 0c0h
	defb	07h, 80h, 0fh, 0c0h, 1fh, 0e0h, 1fh, 0e0h
	defb	1fh, 0e0h, 1fh, 0e0h, 0fh, 0c0h, 1fh, 0e0h
	defb	3fh, 0f0h, 7fh, 0f8h, 78h, 78h, 3bh, 70h
	defb	13h, 20h, 13h, 20h, 1fh, 0e0h, 0ch, 0c0h
	defb	00h, 00h, 07h, 80h, 0fh, 0c0h, 0ah, 0c0h
	defb	0ah, 0c0h, 0fh, 0c0h, 07h, 80h, 00h, 00h
	defb	00h, 00h, 00h, 00h, 30h, 30h, 00h, 00h
	defb	00h, 00h, 00h, 00h, 0ch, 0c0h, 00h, 00h
	defb	07h, 80h, 0fh, 0c0h, 1fh, 0e0h, 1fh, 0e0h
	defb	1fh, 0e0h, 1fh, 0e0h, 0fh, 0c0h, 3fh, 0e0h
	defb	48h, 10h, 48h, 48h, 3fh, 0c8h, 0fh, 0f0h
	defb	1fh, 0d0h, 3fh, 0d0h, 44h, 0e0h, 38h, 00h
	defb	07h, 80h, 0fh, 0c0h, 1fh, 0e0h, 1fh, 0e0h
	defb	1fh, 0e0h, 1fh, 0e0h, 0fh, 0c0h, 3fh, 0e0h
	defb	7fh, 0f0h, 7fh, 0f8h, 38h, 78h, 08h, 0f0h
	defb	11h, 30h, 23h, 30h, 7ch, 0e0h, 38h, 00h
	defb	00h, 00h, 07h, 80h, 0fh, 0c0h, 0ah, 0c0h
	defb	0ah, 0c0h, 0fh, 0c0h, 07h, 80h, 00h, 00h
	defb	20h, 00h, 20h, 00h, 00h, 30h, 00h, 00h
	defb	00h, 20h, 00h, 20h, 38h, 00h, 00h, 00h
	defb	07h, 80h, 0fh, 0c0h, 1fh, 0e0h, 1fh, 0e0h
	defb	1fh, 0e0h, 1fh, 0e0h, 0fh, 0c0h, 07h, 80h
	defb	04h, 80h, 04h, 80h, 08h, 80h, 09h, 80h
	defb	07h, 0c0h, 0fh, 0c0h, 09h, 40h, 06h, 80h
	defb	07h, 80h, 0fh, 0c0h, 1fh, 0e0h, 1fh, 0e0h
	defb	1fh, 0e0h, 1fh, 0e0h, 0fh, 0c0h, 07h, 80h
	defb	07h, 80h, 07h, 80h, 0fh, 80h, 0fh, 80h
	defb	07h, 40h, 09h, 40h, 0fh, 0c0h, 06h, 80h
	defb	00h, 00h, 07h, 80h, 0fh, 0c0h, 0ah, 0c0h
	defb	0ah, 0c0h, 0fh, 0c0h, 07h, 80h, 00h, 00h
	defb	00h, 00h, 00h, 00h, 00h, 00h, 06h, 00h
	defb	00h, 00h, 00h, 00h, 06h, 80h, 00h, 00h
	defb	07h, 80h, 0fh, 0c0h, 1fh, 0e0h, 1fh, 0e0h
	defb	1fh, 0e0h, 1fh, 0e0h, 0fh, 0c0h, 07h, 0e0h
	defb	18h, 50h, 21h, 48h, 23h, 0c8h, 1fh, 0f0h
	defb	0fh, 0d0h, 1fh, 0d0h, 22h, 0e0h, 1ch, 00h
	defb	07h, 80h, 0fh, 0c0h, 1fh, 0e0h, 1fh, 0e0h
	defb	1fh, 0e0h, 1fh, 0e0h, 0fh, 0c0h, 07h, 0e0h
	defb	1fh, 0f0h, 3fh, 0f8h, 3eh, 78h, 1ch, 70h
	defb	0ah, 30h, 11h, 30h, 3eh, 0e0h, 1ch, 00h
	defb	00h, 00h, 07h, 80h, 0fh, 0c0h, 0ah, 0c0h
	defb	0ah, 0c0h, 0fh, 0c0h, 07h, 80h, 00h, 00h
	defb	00h, 00h, 10h, 00h, 10h, 30h, 00h, 00h
	defb	00h, 20h, 00h, 20h, 1ch, 00h, 00h, 00h
	defb	01h, 0e0h, 03h, 0f0h, 07h, 0f8h, 07h, 0f8h
	defb	07h, 0f8h, 07h, 0f8h, 03h, 0f0h, 07h, 0f8h
	defb	08h, 04h, 12h, 12h, 13h, 0f2h, 0fh, 0fch
	defb	07h, 0f8h, 07h, 0f8h, 04h, 0c8h, 03h, 30h
	defb	01h, 0e0h, 03h, 0f0h, 07h, 0f8h, 07h, 0f8h
	defb	07h, 0f8h, 07h, 0f8h, 03h, 0f0h, 07h, 0f8h
	defb	0fh, 0fch, 1fh, 0feh, 1eh, 1eh, 0eh, 0dch
	defb	04h, 0c8h, 04h, 0c8h, 07h, 0f8h, 03h, 30h
	defb	00h, 00h, 01h, 0e0h, 03h, 0f0h, 03h, 50h
	defb	03h, 50h, 03h, 0f0h, 01h, 0e0h, 00h, 00h
	defb	00h, 00h, 00h, 00h, 0ch, 0ch, 00h, 00h
	defb	00h, 00h, 00h, 00h, 03h, 30h, 00h, 00h
	defb	01h, 0e0h, 03h, 0f0h, 07h, 0f8h, 07h, 0f8h
	defb	07h, 0f8h, 07h, 0f8h, 03h, 0f0h, 07h, 0fch
	defb	08h, 12h, 12h, 12h, 13h, 0fch, 0fh, 0f0h
	defb	0bh, 0f8h, 0bh, 0fch, 07h, 22h, 00h, 1ch
	defb	01h, 0e0h, 03h, 0f0h, 07h, 0f8h, 07h, 0f8h
	defb	07h, 0f8h, 07h, 0f8h, 03h, 0f0h, 07h, 0fch
	defb	0fh, 0feh, 1fh, 0feh, 1eh, 1ch, 0fh, 10h
	defb	0ch, 88h, 0ch, 0c4h, 07h, 3eh, 00h, 1ch
	defb	00h, 00h, 01h, 0e0h, 03h, 0f0h, 03h, 50h
	defb	03h, 50h, 03h, 0f0h, 01h, 0e0h, 00h, 00h
	defb	00h, 04h, 00h, 04h, 0ch, 00h, 00h, 00h
	defb	04h, 00h, 04h, 00h, 00h, 1ch, 00h, 00h
	defb	01h, 0e0h, 03h, 0f0h, 07h, 0f8h, 07h, 0f8h
	defb	07h, 0f8h, 07h, 0f8h, 03h, 0f0h, 01h, 0e0h
	defb	01h, 20h, 01h, 20h, 01h, 10h, 01h, 90h
	defb	03h, 0e0h, 03h, 0f0h, 02h, 90h, 01h, 60h
	defb	01h, 0e0h, 03h, 0f0h, 07h, 0f8h, 07h, 0f8h
	defb	07h, 0f8h, 07h, 0f8h, 03h, 0f0h, 01h, 0e0h
	defb	01h, 0e0h, 01h, 0e0h, 01h, 0f0h, 01h, 0f0h
	defb	02h, 0e0h, 02h, 90h, 03h, 0f0h, 01h, 60h
	defb	00h, 00h, 01h, 0e0h, 03h, 0f0h, 03h, 50h
	defb	03h, 50h, 03h, 0f0h, 01h, 0e0h, 00h, 00h
	defb	00h, 00h, 00h, 00h, 00h, 00h, 00h, 60h
	defb	00h, 00h, 00h, 00h, 01h, 60h, 00h, 00h
	defb	01h, 0e0h, 03h, 0f0h, 07h, 0f8h, 07h, 0f8h
	defb	07h, 0f8h, 07h, 0f8h, 03h, 0f0h, 07h, 0e0h
	defb	0ah, 18h, 12h, 84h, 13h, 0c4h, 0fh, 0f8h
	defb	0bh, 0f0h, 0bh, 0f8h, 07h, 44h, 00h, 38h
	defb	01h, 0e0h, 03h, 0f0h, 07h, 0f8h, 07h, 0f8h
	defb	07h, 0f8h, 07h, 0f8h, 03h, 0f0h, 07h, 0e0h
	defb	0fh, 0f8h, 1fh, 0fch, 1eh, 7ch, 0eh, 38h
	defb	0ch, 50h, 0ch, 88h, 07h, 7ch, 00h, 38h
	defb	00h, 00h, 01h, 0e0h, 03h, 0f0h, 03h, 50h
	defb	03h, 50h, 03h, 0f0h, 01h, 0e0h, 00h, 00h
	defb	00h, 00h, 00h, 08h, 0ch, 08h, 00h, 00h
	defb	04h, 00h, 04h, 00h, 00h, 38h, 00h, 00h
	defb	07h, 80h, 0fh, 0c0h, 1fh, 0e0h, 1fh, 0f8h
	defb	1fh, 0e4h, 1fh, 0e4h, 3fh, 0c4h, 4fh, 88h
	defb	40h, 10h, 40h, 20h, 28h, 20h, 1fh, 0e0h
	defb	0fh, 0e0h, 09h, 0e0h, 07h, 20h, 00h, 0c0h
	defb	07h, 80h, 0fh, 0c0h, 1fh, 0e0h, 1fh, 0f8h
	defb	1fh, 0fch, 1fh, 0fch, 3fh, 0fch, 7fh, 0f8h
	defb	7fh, 0f0h, 7fh, 0e0h, 3fh, 0e0h, 18h, 20h
	defb	09h, 20h, 0fh, 20h, 07h, 0e0h, 00h, 0c0h
	defb	00h, 00h, 07h, 80h, 0fh, 0c0h, 0fh, 0c0h
	defb	0fh, 0d8h, 0fh, 0c0h, 07h, 80h, 30h, 00h
	defb	00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h
	defb	00h, 00h, 06h, 00h, 00h, 0c0h, 00h, 00h
	defb	01h, 0e0h, 03h, 0f0h, 07h, 0f8h, 1fh, 0f8h
	defb	27h, 0f8h, 27h, 0f8h, 23h, 0fch, 11h, 0f2h
	defb	08h, 02h, 04h, 02h, 04h, 14h, 07h, 0f8h
	defb	07h, 0f0h, 07h, 90h, 04h, 0e0h, 03h, 00h
	defb	01h, 0e0h, 03h, 0f0h, 07h, 0f8h, 1fh, 0f8h
	defb	3fh, 0f8h, 3fh, 0f8h, 3fh, 0fch, 1fh, 0feh
	defb	0fh, 0feh, 07h, 0feh, 07h, 0fch, 04h, 18h
	defb	04h, 90h, 04h, 0f0h, 07h, 0e0h, 03h, 00h
	defb	00h, 00h, 01h, 0e0h, 03h, 0f0h, 03h, 0f0h
	defb	1bh, 0f0h, 03h, 0f0h, 01h, 0e0h, 00h, 0ch
	defb	00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h
	defb	00h, 00h, 00h, 60h, 03h, 00h, 00h, 00h
	defb	0fh, 0c0h, 1fh, 0f0h, 3fh, 0f8h, 7fh, 0fch
	defb	0ffh, 0feh, 0ffh, 0ffh, 0ffh, 0ffh, 0ffh, 0ffh
	defb	7fh, 0feh, 3fh, 0fch, 1fh, 0f0h, 3bh, 0b8h
	defb	3bh, 0b8h, 3bh, 0b8h, 1dh, 0dch, 08h, 88h
	defb	0fh, 0c0h, 10h, 30h, 20h, 08h, 40h, 04h
	defb	80h, 02h, 92h, 01h, 92h, 01h, 92h, 01h
	defb	40h, 02h, 20h, 0ch, 1fh, 0f0h, 2ah, 0a8h
	defb	2ah, 0a8h, 2ah, 0a8h, 15h, 54h, 08h, 88h
	defb	00h, 00h, 0fh, 0c0h, 1fh, 0f0h, 3fh, 0f8h
	defb	7fh, 0fch, 6dh, 0feh, 6dh, 0feh, 6dh, 0feh
	defb	3fh, 0fch, 1fh, 0f0h, 00h, 00h, 11h, 10h
	defb	11h, 10h, 11h, 10h, 08h, 88h, 00h, 00h
	defb	00h, 00h, 0fh, 0c0h, 1fh, 0f0h, 3fh, 0f8h
	defb	7fh, 0fch, 0ffh, 0feh, 0ffh, 0ffh, 0ffh, 0ffh
	defb	0ffh, 0ffh, 7fh, 0feh, 3fh, 0fch, 1dh, 0dch
	defb	1dh, 0dch, 1dh, 0dch, 0eh, 0eeh, 04h, 44h
	defb	00h, 00h, 0fh, 0c0h, 10h, 30h, 20h, 08h
	defb	40h, 04h, 80h, 02h, 92h, 01h, 92h, 01h
	defb	92h, 01h, 40h, 02h, 3fh, 0fch, 15h, 54h
	defb	15h, 54h, 15h, 54h, 0ah, 0aah, 04h, 44h
	defb	00h, 00h, 00h, 00h, 0fh, 0c0h, 1fh, 0f0h
	defb	3fh, 0f8h, 7fh, 0fch, 6dh, 0feh, 6dh, 0feh
	defb	6dh, 0feh, 3fh, 0fch, 00h, 00h, 08h, 88h
	defb	08h, 88h, 08h, 88h, 04h, 44h, 00h, 00h
	defb	03h, 0f0h, 0fh, 0f8h, 1fh, 0fch, 3fh, 0feh
	defb	7fh, 0ffh, 0ffh, 0ffh, 0ffh, 0ffh, 0ffh, 0ffh
	defb	7fh, 0feh, 3fh, 0fch, 0fh, 0f8h, 1dh, 0dch
	defb	1dh, 0dch, 1dh, 0dch, 3bh, 0b8h, 11h, 10h
	defb	03h, 0f0h, 0ch, 08h, 10h, 04h, 20h, 02h
	defb	40h, 01h, 80h, 49h, 80h, 49h, 80h, 49h
	defb	40h, 02h, 30h, 04h, 0fh, 0f8h, 15h, 54h
	defb	15h, 54h, 15h, 54h, 2ah, 0a8h, 11h, 10h
	defb	00h, 00h, 03h, 0f0h, 0fh, 0f8h, 1fh, 0fch
	defb	3fh, 0feh, 7fh, 0b6h, 7fh, 0b6h, 7fh, 0b6h
	defb	3fh, 0fch, 0fh, 0f8h, 00h, 00h, 08h, 88h
	defb	08h, 88h, 08h, 88h, 11h, 10h, 00h, 00h
	defb	00h, 00h, 03h, 0f0h, 0fh, 0f8h, 1fh, 0fch
	defb	3fh, 0feh, 7fh, 0ffh, 0ffh, 0ffh, 0ffh, 0ffh
	defb	0ffh, 0ffh, 7fh, 0feh, 3fh, 0fch, 3bh, 0b8h
	defb	3bh, 0b8h, 3bh, 0b8h, 77h, 70h, 22h, 20h
	defb	00h, 00h, 03h, 0f0h, 0ch, 08h, 10h, 04h
	defb	20h, 02h, 40h, 01h, 80h, 49h, 80h, 49h
	defb	80h, 49h, 40h, 02h, 3fh, 0fch, 2ah, 0a8h
	defb	2ah, 0a8h, 2ah, 0a8h, 55h, 50h, 22h, 20h
	defb	00h, 00h, 00h, 00h, 03h, 0f0h, 0fh, 0f8h
	defb	1fh, 0fch, 3fh, 0feh, 7fh, 0b6h, 7fh, 0b6h
	defb	7fh, 0b6h, 3fh, 0fch, 00h, 00h, 11h, 10h
	defb	11h, 10h, 11h, 10h, 22h, 20h, 00h, 00h
	defb	08h, 88h, 1dh, 0dch, 3bh, 0b8h, 3bh, 0b8h
	defb	3bh, 0b8h, 3fh, 0f8h, 7fh, 0fch, 0ffh, 0feh
	defb	0ffh, 0feh, 0ffh, 0feh, 0ffh, 0feh, 7fh, 0fch
	defb	7fh, 0fch, 3fh, 0f8h, 1fh, 0f0h, 07h, 0c0h
	defb	08h, 88h, 15h, 54h, 2ah, 0a8h, 2ah, 0a8h
	defb	2ah, 0a8h, 3fh, 0f8h, 40h, 04h, 80h, 02h
	defb	94h, 52h, 88h, 22h, 94h, 52h, 40h, 04h
	defb	40h, 04h, 20h, 08h, 18h, 30h, 07h, 0c0h
	defb	00h, 00h, 08h, 88h, 11h, 10h, 11h, 10h
	defb	11h, 10h, 00h, 00h, 3fh, 0f8h, 7fh, 0fch
	defb	6bh, 0ach, 77h, 0dch, 6bh, 0ach, 3fh, 0f8h
	defb	3fh, 0f8h, 1fh, 0f0h, 07h, 0c0h, 00h, 00h
	defb	00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h
	defb	00h, 0f0h, 03h, 08h, 0ch, 10h, 10h, 28h
	defb	10h, 14h, 20h, 08h, 20h, 10h, 20h, 10h
	defb	10h, 20h, 08h, 0c0h, 07h, 00h, 00h, 00h
	defb	00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h
	defb	00h, 0f0h, 03h, 0f8h, 0fh, 0f0h, 1fh, 0e8h
	defb	1fh, 0fch, 3fh, 0f8h, 3fh, 0f0h, 3fh, 0f0h
	defb	1fh, 0e0h, 0fh, 0c0h, 07h, 00h, 00h, 00h
	defb	00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h
	defb	00h, 00h, 00h, 00h, 00h, 40h, 01h, 80h
	defb	07h, 0c0h, 05h, 80h, 0ch, 0c0h, 07h, 80h
	defb	00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h
	defb	00h, 00h, 00h, 00h, 1fh, 0f8h, 20h, 04h
	defb	40h, 02h, 94h, 0b9h, 0b4h, 0a5h, 94h, 0a5h
	defb	94h, 0b9h, 94h, 0a1h, 0bbh, 21h, 40h, 02h
	defb	20h, 04h, 1fh, 0f8h, 00h, 00h, 00h, 00h
	defb	00h, 00h, 00h, 00h, 1fh, 0f8h, 20h, 04h
	defb	40h, 02h, 80h, 01h, 80h, 01h, 80h, 01h
	defb	80h, 01h, 80h, 01h, 80h, 01h, 40h, 02h
	defb	20h, 04h, 1fh, 0f8h, 00h, 00h, 00h, 00h
	defb	00h, 00h, 00h, 00h, 00h, 00h, 1fh, 0f8h
	defb	3fh, 0fch, 6bh, 46h, 4bh, 5ah, 6bh, 5ah
	defb	6bh, 46h, 6bh, 5eh, 44h, 0deh, 3fh, 0fch
	defb	1fh, 0f8h, 00h, 00h, 00h, 00h, 00h, 00h
