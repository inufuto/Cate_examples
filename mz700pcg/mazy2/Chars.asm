cseg
CharPattern: public CharPattern
;	logo
	defb	00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h
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
;	8dot
	defb	00h, 00h, 04h, 7fh, 3fh, 04h, 00h, 00h
	defb	00h, 00h, 20h, 0feh, 0fch, 20h, 00h, 00h
	defb	00h, 08h, 18h, 18h, 18h, 3ch, 18h, 18h
	defb	18h, 18h, 3ch, 18h, 18h, 18h, 10h, 00h
;	16dot
	defb	00h, 07h, 0fh, 0ah, 0ah, 0fh, 07h, 0fh
	defb	00h, 80h, 0c0h, 0c0h, 0c0h, 0c0h, 80h, 0c0h
	defb	1fh, 37h, 37h, 04h, 0ch, 0ch, 0ch, 0ch
	defb	0e0h, 0b0h, 0b0h, 80h, 0c0h, 0c0h, 0c0h, 0c0h
	defb	00h, 07h, 0fh, 0ah, 0ah, 0fh, 07h, 03h
	defb	00h, 80h, 0c0h, 0c0h, 0c0h, 0c0h, 80h, 80h
	defb	07h, 37h, 37h, 07h, 0eh, 1ch, 38h, 10h
	defb	0e0h, 0f0h, 0b0h, 00h, 0e0h, 0e0h, 00h, 00h
	defb	00h, 07h, 0fh, 0ah, 0ah, 0fh, 07h, 03h
	defb	00h, 80h, 0c0h, 0c0h, 0c0h, 0c0h, 80h, 80h
	defb	03h, 03h, 07h, 06h, 00h, 06h, 06h, 06h
	defb	00h, 00h, 00h, 00h, 80h, 80h, 80h, 00h
	defb	00h, 07h, 0fh, 0ah, 0ah, 0fh, 07h, 03h
	defb	00h, 80h, 0c0h, 0c0h, 0c0h, 0c0h, 80h, 80h
	defb	07h, 1eh, 1dh, 03h, 05h, 0eh, 1ch, 08h
	defb	0a0h, 0b0h, 0b0h, 80h, 0f0h, 70h, 00h, 00h
	defb	00h, 01h, 03h, 03h, 03h, 03h, 01h, 03h
	defb	00h, 0e0h, 0f0h, 50h, 50h, 0f0h, 0e0h, 0f0h
	defb	07h, 0dh, 0dh, 01h, 03h, 03h, 03h, 03h
	defb	0f8h, 0ech, 0ech, 20h, 30h, 30h, 30h, 30h
	defb	00h, 01h, 03h, 03h, 03h, 03h, 01h, 01h
	defb	00h, 0e0h, 0f0h, 50h, 50h, 0f0h, 0e0h, 0c0h
	defb	07h, 0fh, 0dh, 00h, 07h, 07h, 00h, 00h
	defb	0e0h, 0ech, 0ech, 0e0h, 70h, 38h, 1ch, 08h
	defb	00h, 01h, 03h, 03h, 03h, 03h, 01h, 01h
	defb	00h, 0e0h, 0f0h, 50h, 50h, 0f0h, 0e0h, 0c0h
	defb	00h, 00h, 00h, 00h, 01h, 01h, 01h, 00h
	defb	0c0h, 0c0h, 0e0h, 60h, 00h, 60h, 60h, 60h
	defb	00h, 01h, 03h, 03h, 03h, 03h, 01h, 01h
	defb	00h, 0e0h, 0f0h, 50h, 50h, 0f0h, 0e0h, 0c0h
	defb	05h, 0dh, 0dh, 01h, 0fh, 0eh, 00h, 00h
	defb	0e0h, 78h, 0b8h, 0c0h, 0a0h, 70h, 38h, 10h
	defb	00h, 00h, 00h, 00h, 3dh, 67h, 7fh, 67h
	defb	00h, 00h, 60h, 0e0h, 8fh, 0ffh, 0e0h, 0e0h
	defb	7fh, 3dh, 00h, 00h, 00h, 00h, 00h, 00h
	defb	0ffh, 8fh, 0e0h, 60h, 00h, 00h, 00h, 00h
	defb	00h, 00h, 00h, 00h, 3ch, 66h, 7fh, 67h
	defb	00h, 00h, 62h, 67h, 0eh, 0fch, 0f8h, 0f0h
	defb	7fh, 3ch, 00h, 00h, 00h, 00h, 00h, 00h
	defb	0ech, 0cch, 0ech, 60h, 00h, 00h, 00h, 00h
	defb	00h, 00h, 00h, 00h, 3ch, 66h, 7fh, 67h
	defb	00h, 00h, 00h, 00h, 00h, 37h, 0f7h, 0e0h
	defb	7fh, 3ch, 00h, 00h, 00h, 00h, 00h, 00h
	defb	0eh, 00h, 00h, 00h, 00h, 00h, 00h, 00h
	defb	00h, 00h, 00h, 00h, 3ch, 66h, 7fh, 67h
	defb	00h, 00h, 00h, 62h, 67h, 0eeh, 0d4h, 0b8h
	defb	7fh, 3ch, 00h, 00h, 00h, 00h, 00h, 00h
	defb	0f8h, 0ch, 0ech, 6ch, 00h, 00h, 00h, 00h
	defb	00h, 00h, 00h, 00h, 00h, 00h, 3dh, 7fh
	defb	00h, 00h, 00h, 00h, 60h, 0e0h, 8fh, 0ffh
	defb	67h, 7fh, 67h, 3dh, 00h, 00h, 00h, 00h
	defb	0e0h, 0e0h, 0ffh, 8fh, 0e0h, 60h, 00h, 00h
	defb	00h, 00h, 00h, 00h, 00h, 00h, 3ch, 7fh
	defb	00h, 00h, 00h, 00h, 60h, 0ech, 0cch, 0ech
	defb	67h, 7fh, 66h, 3ch, 00h, 00h, 00h, 00h
	defb	0f0h, 0f8h, 0fch, 0eh, 67h, 62h, 00h, 00h
	defb	00h, 00h, 00h, 00h, 00h, 00h, 3ch, 7fh
	defb	00h, 00h, 00h, 00h, 00h, 00h, 00h, 0eh
	defb	67h, 7fh, 66h, 3ch, 00h, 00h, 00h, 00h
	defb	0e0h, 0f7h, 37h, 00h, 00h, 00h, 00h, 00h
	defb	00h, 00h, 00h, 00h, 00h, 00h, 3ch, 7fh
	defb	00h, 00h, 00h, 00h, 6ch, 0ech, 0ch, 0f8h
	defb	67h, 7fh, 66h, 3ch, 00h, 00h, 00h, 00h
	defb	0b8h, 0d4h, 0eeh, 67h, 62h, 00h, 00h, 00h
	defb	03h, 03h, 03h, 03h, 01h, 0dh, 0dh, 07h
	defb	30h, 30h, 30h, 30h, 20h, 0ech, 0ech, 0f8h
	defb	03h, 01h, 03h, 03h, 03h, 03h, 01h, 00h
	defb	0f0h, 0e0h, 0f0h, 50h, 50h, 0f0h, 0e0h, 00h
	defb	00h, 00h, 06h, 07h, 0f1h, 0ffh, 07h, 07h
	defb	00h, 00h, 00h, 00h, 0bch, 0e6h, 0feh, 0e6h
	defb	0ffh, 0f1h, 07h, 06h, 00h, 00h, 00h, 00h
	defb	0feh, 0bch, 00h, 00h, 00h, 00h, 00h, 00h
	defb	00h, 18h, 3ch, 66h, 66h, 66h, 3ch, 1ch
	defb	00h, 18h, 3ch, 66h, 66h, 66h, 3ch, 38h
	defb	0bh, 07h, 1fh, 39h, 36h, 7fh, 73h, 61h
	defb	0d0h, 0e0h, 0f8h, 9ch, 6ch, 0feh, 0ceh, 86h
	defb	00h, 03h, 0fh, 1fh, 1fh, 31h, 31h, 39h
	defb	00h, 0c0h, 0f0h, 0f8h, 0f8h, 8ch, 8ch, 9ch
	defb	3fh, 3ah, 18h, 1ch, 1fh, 3fh, 7bh, 71h
	defb	0fch, 5ch, 18h, 38h, 0f8h, 0fch, 0ceh, 86h
	defb	00h, 00h, 00h, 00h, 11h, 32h, 12h, 12h
	defb	00h, 00h, 00h, 00h, 8ch, 52h, 52h, 52h
	defb	12h, 12h, 39h, 00h, 00h, 00h, 00h, 00h
	defb	52h, 52h, 8ch, 00h, 00h, 00h, 00h, 00h
	defb	00h, 00h, 00h, 00h, 31h, 4ah, 0ah, 12h
	defb	00h, 00h, 00h, 00h, 8ch, 52h, 52h, 52h
	defb	22h, 42h, 79h, 00h, 00h, 00h, 00h, 00h
	defb	52h, 52h, 8ch, 00h, 00h, 00h, 00h, 00h
	defb	00h, 00h, 00h, 00h, 31h, 52h, 52h, 52h
	defb	00h, 00h, 00h, 00h, 8ch, 52h, 52h, 52h
	defb	7ah, 12h, 11h, 00h, 00h, 00h, 00h, 00h
	defb	52h, 52h, 8ch, 00h, 00h, 00h, 00h, 00h
	defb	00h, 00h, 00h, 00h, 31h, 4ah, 4ah, 32h
	defb	00h, 00h, 00h, 00h, 8ch, 52h, 52h, 52h
	defb	4ah, 4ah, 31h, 00h, 00h, 00h, 00h, 00h
	defb	52h, 52h, 8ch, 00h, 00h, 00h, 00h, 00h
	defb	0ffh, 80h, 80h, 80h, 80h, 80h, 80h, 80h
	defb	0ffh, 01h, 01h, 01h, 01h, 1dh, 1dh, 1dh
	defb	81h, 81h, 81h, 9dh, 9dh, 9dh, 80h, 0ffh
	defb	0ddh, 0ddh, 0ddh, 0ddh, 0ddh, 0ddh, 01h, 0ffh
	defb	00h, 00h, 00h, 00h, 00h, 0eh, 0eh, 6eh
	defb	00h, 0eh, 0eh, 0eeh, 0eeh, 0eeh, 0eeh, 0e0h
	defb	6eh, 6eh, 6eh, 60h, 6fh, 0fh, 7fh, 00h
	defb	0eeh, 0eh, 0feh, 0feh, 0feh, 0feh, 0feh, 00h
	defb	00h, 3fh, 3fh, 3fh, 3fh, 3fh, 3fh, 3fh
	defb	00h, 0fch, 0fch, 0fch, 0fch, 0fch, 0ech, 0d4h
	defb	3fh, 3fh, 3fh, 3fh, 3fh, 3fh, 3fh, 00h
	defb	0d4h, 0ech, 0fch, 0fch, 0fch, 0fch, 0fch, 00h
