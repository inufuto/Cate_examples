cseg
CharPattern: public CharPattern
;	wall
	defb	00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h
	defb	0c0h, 0c0h, 0c0h, 0c0h, 0c0h, 0c0h, 0c0h, 0c0h
	defb	03h, 03h, 03h, 03h, 03h, 03h, 03h, 03h
	defb	0c3h, 0c3h, 0c3h, 0c3h, 0c3h, 0c3h, 0c3h, 0c3h
	defb	0ffh, 0ffh, 00h, 00h, 00h, 00h, 00h, 00h
	defb	7fh, 0ffh, 0c0h, 0c0h, 0c0h, 0c0h, 0c0h, 0c0h
	defb	0feh, 0ffh, 03h, 03h, 03h, 03h, 03h, 03h
	defb	7eh, 0ffh, 0c3h, 0c3h, 0c3h, 0c3h, 0c3h, 0c3h
	defb	00h, 00h, 00h, 00h, 00h, 00h, 0ffh, 0ffh
	defb	0c0h, 0c0h, 0c0h, 0c0h, 0c0h, 0c0h, 0ffh, 7fh
	defb	03h, 03h, 03h, 03h, 03h, 03h, 0ffh, 0feh
	defb	0c3h, 0c3h, 0c3h, 0c3h, 0c3h, 0c3h, 0ffh, 7eh
	defb	0ffh, 0ffh, 00h, 00h, 00h, 00h, 0ffh, 0ffh
	defb	7fh, 0ffh, 0c0h, 0c0h, 0c0h, 0c0h, 0ffh, 7fh
	defb	0feh, 0ffh, 03h, 03h, 03h, 03h, 0ffh, 0feh
	defb	7eh, 0ffh, 0c3h, 0c3h, 0c3h, 0c3h, 0ffh, 7eh
;	16dot
	defb	00h, 03h, 7ch, 1fh, 00h, 0fh, 0ah, 0ah
	defb	0f0h, 0f8h, 04h, 0f0h, 0f8h, 1ch, 0e0h, 0e0h
	defb	07h, 00h, 07h, 07h, 00h, 06h, 0ch, 1ch
	defb	0c0h, 00h, 0d0h, 0b0h, 70h, 60h, 10h, 70h
	defb	00h, 03h, 7ch, 1fh, 00h, 0fh, 0ah, 0ah
	defb	0f0h, 0f8h, 04h, 0f0h, 0f8h, 1ch, 0e0h, 0e0h
	defb	07h, 00h, 07h, 37h, 30h, 02h, 01h, 03h
	defb	0c0h, 18h, 0ech, 0e6h, 06h, 40h, 0c0h, 80h
	defb	0fh, 1fh, 20h, 0fh, 1fh, 38h, 07h, 07h
	defb	00h, 0c0h, 3eh, 0f8h, 00h, 0f0h, 50h, 50h
	defb	03h, 00h, 0bh, 0dh, 0eh, 06h, 08h, 0eh
	defb	0e0h, 00h, 0e0h, 0e0h, 00h, 60h, 30h, 38h
	defb	0fh, 1fh, 20h, 0fh, 1fh, 38h, 07h, 07h
	defb	00h, 0c0h, 3eh, 0f8h, 00h, 0f0h, 50h, 50h
	defb	03h, 18h, 37h, 67h, 60h, 02h, 03h, 01h
	defb	0e0h, 00h, 0e0h, 0ech, 0ch, 40h, 80h, 0c0h
	defb	0fh, 17h, 07h, 0fh, 37h, 79h, 3eh, 1fh
	defb	80h, 0c0h, 0e0h, 0e0h, 0d8h, 3ch, 0f8h, 0f0h
	defb	07h, 00h, 0fh, 2fh, 20h, 0eh, 0eh, 0eh
	defb	0c0h, 00h, 0f0h, 0f0h, 00h, 0e0h, 0e0h, 00h
	defb	0fh, 17h, 07h, 0fh, 37h, 79h, 3eh, 1fh
	defb	80h, 0c0h, 0e0h, 0e0h, 0d8h, 3ch, 0f8h, 0f0h
	defb	07h, 00h, 1fh, 1fh, 00h, 0eh, 0eh, 00h
	defb	0c0h, 00h, 0e0h, 0e8h, 08h, 0e0h, 0e0h, 0e0h
	defb	03h, 07h, 00h, 1fh, 30h, 6fh, 2dh, 0dh
	defb	0e0h, 0d0h, 00h, 0f0h, 18h, 0ech, 68h, 60h
	defb	07h, 00h, 0fh, 2fh, 20h, 0eh, 0eh, 0eh
	defb	0c0h, 00h, 0d0h, 0b0h, 60h, 00h, 0c0h, 00h
	defb	03h, 07h, 00h, 1fh, 30h, 6fh, 2dh, 0dh
	defb	0e0h, 0d0h, 00h, 0f0h, 18h, 0ech, 68h, 60h
	defb	07h, 00h, 17h, 1bh, 0ch, 00h, 06h, 00h
	defb	0c0h, 00h, 0e0h, 0e8h, 08h, 0e0h, 0e0h, 0e0h
	defb	04h, 06h, 0fh, 1ah, 1ah, 1fh, 15h, 50h
	defb	80h, 0c0h, 0e0h, 0f0h, 0f0h, 0f0h, 70h, 76h
	defb	6fh, 3fh, 1fh, 0fh, 07h, 03h, 01h, 00h
	defb	0eeh, 0fch, 0f8h, 0f0h, 0e0h, 0e0h, 0f0h, 78h
	defb	00h, 04h, 06h, 0fh, 1ah, 1ah, 1fh, 15h
	defb	00h, 80h, 0c0h, 0e0h, 0f0h, 0f0h, 0f0h, 70h
	defb	10h, 3fh, 7fh, 0dfh, 0fh, 07h, 03h, 01h
	defb	70h, 0f8h, 0fch, 0f6h, 0f0h, 0e0h, 0f6h, 0fch
	defb	01h, 03h, 07h, 0fh, 0fh, 0fh, 0eh, 6eh
	defb	20h, 60h, 0f0h, 58h, 58h, 0f8h, 0a8h, 0ah
	defb	77h, 3fh, 1fh, 0fh, 07h, 07h, 0fh, 1eh
	defb	0f6h, 0fch, 0f8h, 0f0h, 0e0h, 0c0h, 80h, 00h
	defb	00h, 01h, 03h, 07h, 0fh, 0fh, 0fh, 0eh
	defb	00h, 20h, 60h, 0f0h, 58h, 58h, 0f8h, 0a8h
	defb	0eh, 1fh, 3fh, 6fh, 0fh, 07h, 6fh, 3fh
	defb	08h, 0fch, 0feh, 0fbh, 0f0h, 0e0h, 0c0h, 80h
	defb	02h, 06h, 0fh, 1fh, 1fh, 1fh, 1fh, 5fh
	defb	40h, 60h, 0f0h, 0f8h, 0f8h, 0f8h, 0f8h, 0fah
	defb	6fh, 3fh, 1fh, 0fh, 0fh, 07h, 03h, 01h
	defb	0f6h, 0fch, 0f8h, 0f0h, 0f0h, 0e0h, 0c0h, 80h
	defb	00h, 02h, 06h, 0fh, 1fh, 1fh, 1fh, 1fh
	defb	00h, 40h, 60h, 0f0h, 0f8h, 0f8h, 0f8h, 0f8h
	defb	1fh, 0fh, 3fh, 6fh, 0fh, 0fh, 07h, 03h
	defb	0f8h, 0f0h, 0fch, 0f6h, 0f0h, 0f0h, 0e0h, 0c0h
	defb	02h, 06h, 0fh, 1dh, 1dh, 1fh, 1ah, 58h
	defb	40h, 60h, 0f0h, 0b8h, 0b8h, 0f8h, 58h, 1ah
	defb	6fh, 3fh, 1fh, 0fh, 0fh, 07h, 03h, 01h
	defb	0f6h, 0fch, 0f8h, 0f0h, 0f0h, 0e0h, 0c0h, 80h
	defb	00h, 02h, 06h, 0fh, 1dh, 1dh, 1fh, 1ah
	defb	00h, 40h, 60h, 0f0h, 0b8h, 0b8h, 0f8h, 58h
	defb	18h, 0fh, 3fh, 6fh, 0fh, 0fh, 07h, 03h
	defb	18h, 0f0h, 0fch, 0f6h, 0f0h, 0f0h, 0e0h, 0c0h
	defb	00h, 00h, 00h, 00h, 00h, 00h, 03h, 0eh
	defb	00h, 00h, 00h, 00h, 00h, 0f0h, 0a0h, 40h
	defb	08h, 1ah, 13h, 18h, 0fh, 07h, 00h, 00h
	defb	28h, 70h, 20h, 60h, 0c0h, 00h, 00h, 00h
	defb	00h, 00h, 01h, 01h, 03h, 16h, 1ch, 14h
	defb	00h, 00h, 00h, 00h, 80h, 0d0h, 70h, 50h
	defb	31h, 23h, 27h, 37h, 13h, 18h, 07h, 00h
	defb	18h, 88h, 0c8h, 0d8h, 90h, 30h, 0c0h, 00h
	defb	00h, 00h, 00h, 00h, 00h, 00h, 01h, 03h
	defb	00h, 00h, 00h, 00h, 00h, 00h, 80h, 0c0h
	defb	03h, 01h, 00h, 00h, 00h, 00h, 00h, 00h
	defb	0c0h, 80h, 00h, 00h, 00h, 00h, 00h, 00h
	defb	00h, 07h, 1fh, 3dh, 77h, 3fh, 00h, 2ah
	defb	00h, 0e0h, 0f8h, 0dch, 76h, 0fch, 00h, 0a8h
	defb	15h, 00h, 3fh, 3fh, 00h, 7fh, 3fh, 00h
	defb	54h, 00h, 0fch, 0fch, 00h, 0feh, 0fch, 00h