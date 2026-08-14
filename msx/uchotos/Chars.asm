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
	; logo
	defb 0f0h,0f0h,0f0h,0f0h,00h,00h,00h,00h
	defb 00h,00h,00h,00h,0f0h,0f0h,0f0h,0f0h
	defb 0f0h,0f0h,0f0h,0f0h,0f0h,0f0h,0f0h,0f0h
	defb 0fh,0fh,0fh,0fh,00h,00h,00h,00h
	defb 0ffh,0ffh,0ffh,0ffh,00h,00h,00h,00h
	defb 0fh,0fh,0fh,0fh,0f0h,0f0h,0f0h,0f0h
	defb 0ffh,0ffh,0ffh,0ffh,0f0h,0f0h,0f0h,0f0h
	defb 00h,00h,00h,00h,0fh,0fh,0fh,0fh
	defb 0f0h,0f0h,0f0h,0f0h,0fh,0fh,0fh,0fh
	defb 00h,00h,00h,00h,0ffh,0ffh,0ffh,0ffh
	defb 0f0h,0f0h,0f0h,0f0h,0ffh,0ffh,0ffh,0ffh
	defb 0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh
	defb 0ffh,0ffh,0ffh,0ffh,0fh,0fh,0fh,0fh
	defb 0fh,0fh,0fh,0fh,0ffh,0ffh,0ffh,0ffh
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh
;	ladder
	defb	60h, 7fh, 7fh, 60h, 60h, 7fh, 7fh, 60h
	defb	06h, 0feh, 0feh, 06h, 06h, 0feh, 0feh, 06h
;	mono16
	defb	00h, 00h, 00h, 01h, 01h, 01h, 7fh, 3fh
	defb	00h, 80h, 80h, 0c0h, 0c0h, 0c0h, 0ffh, 0feh
	defb	0fh, 07h, 07h, 07h, 0fh, 0ch, 08h, 00h
	defb	0f8h, 0f0h, 0f0h, 0f0h, 78h, 18h, 08h, 00h
	defb	00h, 08h, 11h, 11h, 11h, 00h, 7fh, 0ffh
	defb	00h, 88h, 10h, 10h, 10h, 00h, 0fch, 0feh
	defb	0ebh, 0f7h, 0ebh, 7fh, 7fh, 3fh, 1fh, 07h
	defb	0aeh, 0deh, 0aeh, 0fch, 0fch, 0f8h, 0f0h, 0c0h
	defb	00h, 07h, 0fh, 0ah, 0ah, 0fh, 07h, 00h
	defb	00h, 80h, 0c0h, 0c0h, 0c0h, 0c0h, 80h, 00h
	defb	1fh, 37h, 37h, 04h, 0ch, 0ch, 0ch, 0ch
	defb	0e0h, 0b0h, 0b0h, 80h, 0c0h, 0c0h, 0c0h, 0c0h

ColorPattern: public ColorPattern
;	floor
	defb	0efh, 0efh, 0efh, 00h, 01h, 0feh, 0feh, 0ffh
	defb	8eh, 6eh, 6eh, 0eh, 0e8h, 6eh, 6eh, 0e0h

SpritePattern: public SpritePattern
;	sprite
	defb	00h, 07h, 0fh, 0ah, 0ah, 0fh, 07h, 00h
	defb	1fh, 37h, 37h, 04h, 0ch, 0ch, 0ch, 0ch
	defb	00h, 80h, 0c0h, 0c0h, 0c0h, 0c0h, 80h, 00h
	defb	0e0h, 0b0h, 0b0h, 80h, 0c0h, 0c0h, 0c0h, 0c0h
	defb	00h, 07h, 0fh, 0ah, 0ah, 0fh, 07h, 03h
	defb	07h, 37h, 37h, 07h, 0eh, 1ch, 38h, 10h
	defb	00h, 80h, 0c0h, 0c0h, 0c0h, 0c0h, 80h, 80h
	defb	0e0h, 0f0h, 0b0h, 00h, 0e0h, 0e0h, 00h, 00h
	defb	00h, 07h, 0fh, 0ah, 0ah, 0fh, 07h, 03h
	defb	03h, 03h, 07h, 06h, 00h, 06h, 06h, 06h
	defb	00h, 80h, 0c0h, 0c0h, 0c0h, 0c0h, 80h, 80h
	defb	00h, 00h, 00h, 00h, 80h, 80h, 80h, 00h
	defb	00h, 07h, 0fh, 0ah, 0ah, 0fh, 07h, 03h
	defb	07h, 1eh, 1dh, 03h, 05h, 0eh, 1ch, 08h
	defb	00h, 80h, 0c0h, 0c0h, 0c0h, 0c0h, 80h, 80h
	defb	0a0h, 0b0h, 0b0h, 80h, 0f0h, 70h, 00h, 00h
	defb	00h, 01h, 03h, 03h, 03h, 03h, 01h, 00h
	defb	07h, 0dh, 0dh, 01h, 03h, 03h, 03h, 03h
	defb	00h, 0e0h, 0f0h, 50h, 50h, 0f0h, 0e0h, 00h
	defb	0f8h, 0ech, 0ech, 20h, 30h, 30h, 30h, 30h
	defb	00h, 01h, 03h, 03h, 03h, 03h, 01h, 01h
	defb	07h, 0fh, 0dh, 00h, 07h, 07h, 00h, 00h
	defb	00h, 0e0h, 0f0h, 50h, 50h, 0f0h, 0e0h, 0c0h
	defb	0e0h, 0ech, 0ech, 0e0h, 70h, 38h, 1ch, 08h
	defb	00h, 01h, 03h, 03h, 03h, 03h, 01h, 01h
	defb	00h, 00h, 00h, 00h, 01h, 01h, 01h, 00h
	defb	00h, 0e0h, 0f0h, 50h, 50h, 0f0h, 0e0h, 0c0h
	defb	0c0h, 0c0h, 0e0h, 60h, 00h, 60h, 60h, 60h
	defb	00h, 01h, 03h, 03h, 03h, 03h, 01h, 01h
	defb	05h, 0dh, 0dh, 01h, 0fh, 0eh, 00h, 00h
	defb	00h, 0e0h, 0f0h, 50h, 50h, 0f0h, 0e0h, 0c0h
	defb	0e0h, 78h, 0b8h, 0c0h, 0a0h, 70h, 38h, 10h
	defb	00h, 03h, 07h, 07h, 07h, 07h, 03h, 18h
	defb	1fh, 1fh, 0bh, 03h, 06h, 06h, 00h, 00h
	defb	00h, 0c0h, 0e0h, 0e0h, 0ech, 0ech, 0cch, 18h
	defb	0f0h, 0e0h, 0c0h, 0c0h, 60h, 60h, 60h, 60h
	defb	00h, 03h, 07h, 07h, 37h, 37h, 33h, 18h
	defb	0fh, 07h, 03h, 03h, 06h, 06h, 06h, 06h
	defb	00h, 0c0h, 0e0h, 0e0h, 0e0h, 0e0h, 0c0h, 18h
	defb	0f8h, 0f8h, 0d0h, 0c0h, 60h, 60h, 00h, 00h
	defb	07h, 1fh, 3fh, 7fh, 0ffh, 0edh, 0edh, 0edh
	defb	7fh, 3fh, 00h, 22h, 22h, 22h, 11h, 00h
	defb	80h, 0e0h, 0f0h, 0f8h, 0fch, 0feh, 0feh, 0feh
	defb	0fch, 0f0h, 00h, 20h, 20h, 20h, 10h, 00h
	defb	00h, 07h, 1fh, 3fh, 7fh, 0ffh, 0edh, 0edh
	defb	0edh, 7fh, 00h, 11h, 11h, 11h, 08h, 00h
	defb	00h, 80h, 0e0h, 0f0h, 0f8h, 0fch, 0feh, 0feh
	defb	0feh, 0f8h, 00h, 10h, 10h, 10h, 88h, 00h
	defb	01h, 07h, 0fh, 1fh, 3fh, 7fh, 7fh, 7fh
	defb	3fh, 0fh, 00h, 04h, 04h, 04h, 08h, 00h
	defb	0e0h, 0f8h, 0fch, 0feh, 0ffh, 0b7h, 0b7h, 0b7h
	defb	0feh, 0fch, 00h, 44h, 44h, 44h, 88h, 00h
	defb	00h, 01h, 07h, 0fh, 1fh, 3fh, 7fh, 7fh
	defb	7fh, 1fh, 00h, 08h, 08h, 08h, 11h, 00h
	defb	00h, 0e0h, 0f8h, 0fch, 0feh, 0ffh, 0b7h, 0b7h
	defb	0b7h, 0feh, 00h, 88h, 88h, 88h, 10h, 00h
	defb	00h, 08h, 11h, 11h, 11h, 00h, 7fh, 0ffh
	defb	0ebh, 0f7h, 0ebh, 7fh, 7fh, 3fh, 1fh, 07h
	defb	00h, 88h, 10h, 10h, 10h, 00h, 0fch, 0feh
	defb	0aeh, 0deh, 0aeh, 0fch, 0fch, 0f8h, 0f0h, 0c0h
	defb	00h, 00h, 00h, 00h, 00h, 00h, 03h, 0eh
	defb	08h, 1ah, 13h, 18h, 0fh, 07h, 00h, 00h
	defb	00h, 00h, 00h, 00h, 00h, 0f0h, 0a0h, 40h
	defb	28h, 70h, 20h, 60h, 0c0h, 00h, 00h, 00h
	defb	00h, 00h, 00h, 3fh, 7fh, 0dbh, 9bh, 0dbh
	defb	0dbh, 0dbh, 8ch, 7fh, 3fh, 00h, 00h, 00h
	defb	00h, 00h, 00h, 0f8h, 0fch, 46h, 5ah, 5ah
	defb	46h, 5eh, 0deh, 0fch, 0f8h, 00h, 00h, 00h
