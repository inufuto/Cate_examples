cseg

MonoPattern: public MonoPattern
	; ASCII
	defb	0h, 0h, 0h, 0h
	defb	44h, 44h, 4h, 40h
	defb	0aah, 0h, 0h, 0h
	defb	44h, 0e4h, 0e4h, 40h
	defb	4eh, 0ceh, 6eh, 40h
	defb	8ah, 24h, 8ah, 20h
	defb	4ah, 48h, 0aah, 40h
	defb	44h, 40h, 0h, 0h
	defb	48h, 88h, 88h, 40h
	defb	42h, 22h, 22h, 40h
	defb	0ah, 0a4h, 0aah, 0h
	defb	4h, 4eh, 44h, 0h
	defb	0h, 0h, 44h, 80h
	defb	0h, 0eh, 0h, 0h
	defb	0h, 0h, 4h, 40h
	defb	2h, 24h, 88h, 0h
	defb	4ah, 0aah, 0aah, 40h
	defb	22h, 22h, 22h, 20h
	defb	4ah, 22h, 48h, 0e0h
	defb	4ah, 24h, 2ah, 40h
	defb	2ah, 0aeh, 22h, 20h
	defb	0e8h, 8ch, 22h, 0c0h
	defb	4ah, 8ch, 0aah, 40h
	defb	0eah, 22h, 44h, 40h
	defb	4ah, 0a4h, 0aah, 40h
	defb	4ah, 0a6h, 2ah, 40h
	defb	4h, 40h, 44h, 0h
	defb	4h, 40h, 44h, 80h
	defb	2h, 48h, 42h, 0h
	defb	0h, 0e0h, 0e0h, 0h
	defb	8h, 42h, 48h, 0h
	defb	4ah, 24h, 40h, 40h
	defb	4ah, 0aah, 88h, 60h
	defb	4ah, 0aah, 0eah, 0a0h
	defb	0cah, 0ach, 0aah, 0c0h
	defb	4ah, 88h, 8ah, 40h
	defb	0cah, 0aah, 0aah, 0c0h
	defb	0e8h, 8ch, 88h, 0e0h
	defb	0e8h, 8ch, 88h, 80h
	defb	68h, 8ah, 0aah, 40h
	defb	0aah, 0aeh, 0aah, 0a0h
	defb	0e4h, 44h, 44h, 0e0h
	defb	72h, 22h, 2ah, 40h
	defb	0aeh, 0c8h, 0ceh, 0a0h
	defb	44h, 44h, 44h, 70h
	defb	0aeh, 0eeh, 0aah, 0a0h
	defb	0cah, 0aah, 0aah, 0a0h
	defb	4ah, 0aah, 0aah, 40h
	defb	0cah, 0aah, 0c8h, 80h
	defb	4ah, 0aah, 0ach, 60h
	defb	0cah, 0aah, 0cah, 0a0h
	defb	4ah, 84h, 2ah, 40h
	defb	0e4h, 44h, 44h, 40h
	defb	0aah, 0aah, 0aah, 0e0h
	defb	0aah, 0aah, 0a4h, 40h
	defb	0aah, 0aeh, 0eeh, 0a0h
	defb	0aah, 44h, 4ah, 0a0h
	defb	0aah, 0a4h, 44h, 40h
	defb	0e2h, 24h, 88h, 0e0h
	defb	64h, 44h, 44h, 60h
	defb	8h, 84h, 22h, 0h
	defb	0c4h, 44h, 44h, 0c0h
	defb	4ah, 0h, 0h, 0h
	defb	0h, 0h, 0h, 0e0h
	; Logo
	defb	0h, 0h, 0h, 0h
	defb	0cch, 0cch, 0h, 0h
	defb	0h, 0h, 0cch, 0cch
	defb	0cch, 0cch, 0cch, 0cch
	defb	33h, 33h, 0h, 0h
	defb	0ffh, 0ffh, 0h, 0h
	defb	33h, 33h, 0cch, 0cch
	defb	0ffh, 0ffh, 0cch, 0cch
	defb	0h, 0h, 33h, 33h
	defb	0cch, 0cch, 33h, 33h
	defb	0h, 0h, 0ffh, 0ffh
	defb	0cch, 0cch, 0ffh, 0ffh
	defb	33h, 33h, 33h, 33h
	defb	0ffh, 0ffh, 33h, 33h
	defb	33h, 33h, 0ffh, 0ffh
	defb	0ffh, 0ffh, 0ffh, 0ffh

ColorPattern: public ColorPattern
;	8dot
	defb	00h, 00h, 0ch, 0ch, 0ch, 0ch, 0ffh, 5fh
	defb	0ffh, 5fh, 0ch, 0ch, 0ch, 0ch, 00h, 00h
	defb	00h, 00h, 30h, 30h, 30h, 30h, 0ffh, 0f5h
	defb	0ffh, 0f5h, 30h, 30h, 30h, 30h, 00h, 00h
	defb	0ch, 04h, 0ch, 04h, 0ch, 04h, 0ch, 04h
	defb	3fh, 3fh, 3fh, 3fh, 0ch, 0ch, 0ch, 0ch
	defb	30h, 30h, 30h, 30h, 0fch, 0fch, 0fch, 0fch
	defb	30h, 10h, 30h, 10h, 30h, 10h, 30h, 10h
;	16dot
	defb	0fh, 0fh, 0fh, 0fh, 0fh, 0fh, 0fh, 0fh
	defb	02h, 02h, 02h, 02h, 22h, 32h, 22h, 32h
	defb	00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h
	defb	80h, 80h, 80h, 80h, 20h, 30h, 20h, 30h
	defb	02h, 02h, 02h, 02h, 04h, 04h, 04h, 04h
	defb	04h, 04h, 04h, 04h, 04h, 04h, 04h, 04h
	defb	00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h
	defb	40h, 40h, 40h, 40h, 40h, 40h, 40h, 40h
	defb	0fh, 0fh, 0fh, 0fh, 0fh, 0fh, 0fh, 0fh
	defb	02h, 02h, 02h, 02h, 22h, 22h, 22h, 22h
	defb	00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h
	defb	80h, 80h, 80h, 80h, 20h, 30h, 20h, 30h
	defb	82h, 0c2h, 82h, 0c2h, 04h, 04h, 04h, 04h
	defb	04h, 04h, 04h, 04h, 04h, 04h, 04h, 04h
	defb	00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h
	defb	50h, 50h, 50h, 50h, 00h, 00h, 00h, 00h
	defb	0fh, 0fh, 0fh, 0fh, 0fh, 0fh, 0fh, 0fh
	defb	02h, 02h, 02h, 02h, 02h, 02h, 02h, 02h
	defb	00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h
	defb	00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h
	defb	08h, 0ch, 08h, 0ch, 01h, 01h, 01h, 01h
	defb	01h, 01h, 01h, 01h, 00h, 00h, 00h, 00h
	defb	00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h
	defb	00h, 00h, 00h, 00h, 40h, 40h, 40h, 40h
	defb	0fh, 0fh, 0fh, 0fh, 0fh, 0fh, 0fh, 0fh
	defb	02h, 02h, 02h, 02h, 0ah, 0ah, 0ah, 0ah
	defb	00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h
	defb	00h, 00h, 00h, 00h, 20h, 30h, 20h, 30h
	defb	22h, 32h, 22h, 32h, 00h, 00h, 00h, 00h
	defb	04h, 04h, 04h, 04h, 04h, 04h, 04h, 04h
	defb	00h, 00h, 00h, 00h, 40h, 40h, 40h, 40h
	defb	14h, 14h, 14h, 14h, 00h, 00h, 00h, 00h
	defb	00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h
	defb	02h, 02h, 02h, 02h, 08h, 0ch, 08h, 0ch
	defb	0f0h, 0f0h, 0f0h, 0f0h, 0f0h, 0f0h, 0f0h, 0f0h
	defb	80h, 80h, 80h, 80h, 88h, 8ch, 88h, 8ch
	defb	00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h
	defb	01h, 01h, 01h, 01h, 01h, 01h, 01h, 01h
	defb	80h, 80h, 80h, 80h, 10h, 10h, 10h, 10h
	defb	10h, 10h, 10h, 10h, 10h, 10h, 10h, 10h
	defb	00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h
	defb	02h, 02h, 02h, 02h, 08h, 0ch, 08h, 0ch
	defb	0f0h, 0f0h, 0f0h, 0f0h, 0f0h, 0f0h, 0f0h, 0f0h
	defb	80h, 80h, 80h, 80h, 88h, 88h, 88h, 88h
	defb	00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h
	defb	05h, 05h, 05h, 05h, 00h, 00h, 00h, 00h
	defb	82h, 83h, 82h, 83h, 10h, 10h, 10h, 10h
	defb	10h, 10h, 10h, 10h, 10h, 10h, 10h, 10h
	defb	00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h
	defb	00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h
	defb	0f0h, 0f0h, 0f0h, 0f0h, 0f0h, 0f0h, 0f0h, 0f0h
	defb	80h, 80h, 80h, 80h, 80h, 80h, 80h, 80h
	defb	00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h
	defb	00h, 00h, 00h, 00h, 01h, 01h, 01h, 01h
	defb	20h, 30h, 20h, 30h, 40h, 40h, 40h, 40h
	defb	40h, 40h, 40h, 40h, 00h, 00h, 00h, 00h
	defb	00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h
	defb	00h, 00h, 00h, 00h, 08h, 0ch, 08h, 0ch
	defb	0f0h, 0f0h, 0f0h, 0f0h, 0f0h, 0f0h, 0f0h, 0f0h
	defb	80h, 80h, 80h, 80h, 0a0h, 0a0h, 0a0h, 0a0h
	defb	00h, 00h, 00h, 00h, 01h, 01h, 01h, 01h
	defb	14h, 14h, 14h, 14h, 00h, 00h, 00h, 00h
	defb	88h, 8ch, 88h, 8ch, 00h, 00h, 00h, 00h
	defb	10h, 10h, 10h, 10h, 10h, 10h, 10h, 10h
	defb	00h, 00h, 00h, 00h, 02h, 03h, 02h, 03h
	defb	0f0h, 0f0h, 0f0h, 0f0h, 0fah, 0fah, 0fah, 0fah
	defb	00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h
	defb	15h, 15h, 15h, 15h, 80h, 80h, 80h, 80h
	defb	08h, 08h, 08h, 08h, 02h, 03h, 02h, 03h
	defb	00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h
	defb	05h, 05h, 05h, 05h, 00h, 00h, 00h, 00h
	defb	00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h
	defb	00h, 00h, 00h, 00h, 02h, 02h, 02h, 02h
	defb	0f0h, 0f0h, 0f0h, 0f0h, 0fah, 0fah, 0fah, 0fah
	defb	80h, 0c0h, 80h, 0c0h, 00h, 00h, 00h, 00h
	defb	15h, 15h, 15h, 15h, 80h, 80h, 80h, 80h
	defb	08h, 08h, 08h, 08h, 02h, 03h, 02h, 03h
	defb	00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h
	defb	04h, 04h, 04h, 04h, 04h, 04h, 04h, 04h
	defb	00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h
	defb	00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h
	defb	0f0h, 0f0h, 0f0h, 0f0h, 0fah, 0fah, 0fah, 0fah
	defb	00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h
	defb	80h, 0c0h, 80h, 0c0h, 14h, 14h, 14h, 14h
	defb	00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h
	defb	00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h
	defb	01h, 01h, 01h, 01h, 00h, 00h, 00h, 00h
	defb	00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h
	defb	00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h
	defb	0f2h, 0f2h, 0f2h, 0f2h, 0fah, 0fah, 0fah, 0fah
	defb	00h, 00h, 00h, 00h, 80h, 0c0h, 80h, 0c0h
	defb	05h, 05h, 05h, 05h, 80h, 80h, 80h, 80h
	defb	00h, 00h, 00h, 00h, 02h, 03h, 02h, 03h
	defb	00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h
	defb	10h, 10h, 10h, 10h, 04h, 04h, 04h, 04h
	defb	04h, 04h, 04h, 04h, 00h, 00h, 00h, 00h
	defb	00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h
	defb	02h, 03h, 02h, 03h, 08h, 08h, 08h, 08h
	defb	00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h
	defb	00h, 00h, 00h, 00h, 05h, 05h, 05h, 05h
	defb	0fah, 0fah, 0fah, 0fah, 0f0h, 0f0h, 0f0h, 0f0h
	defb	02h, 03h, 02h, 03h, 00h, 00h, 00h, 00h
	defb	80h, 80h, 80h, 80h, 15h, 15h, 15h, 15h
	defb	00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h
	defb	00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h
	defb	02h, 03h, 02h, 03h, 08h, 08h, 08h, 08h
	defb	00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h
	defb	04h, 04h, 04h, 04h, 04h, 04h, 04h, 04h
	defb	0fah, 0fah, 0fah, 0fah, 0f0h, 0f0h, 0f0h, 0f0h
	defb	02h, 02h, 02h, 02h, 00h, 00h, 00h, 00h
	defb	80h, 80h, 80h, 80h, 15h, 15h, 15h, 15h
	defb	00h, 00h, 00h, 00h, 80h, 0c0h, 80h, 0c0h
	defb	00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h
	defb	00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h
	defb	00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h
	defb	00h, 00h, 00h, 00h, 01h, 01h, 01h, 01h
	defb	0fah, 0fah, 0fah, 0fah, 0f0h, 0f0h, 0f0h, 0f0h
	defb	00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h
	defb	14h, 14h, 14h, 14h, 80h, 0c0h, 80h, 0c0h
	defb	00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h
	defb	00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h
	defb	02h, 03h, 02h, 03h, 00h, 00h, 00h, 00h
	defb	00h, 00h, 00h, 00h, 04h, 04h, 04h, 04h
	defb	04h, 04h, 04h, 04h, 10h, 10h, 10h, 10h
	defb	0fah, 0fah, 0fah, 0fah, 0f2h, 0f2h, 0f2h, 0f2h
	defb	00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h
	defb	80h, 80h, 80h, 80h, 05h, 05h, 05h, 05h
	defb	80h, 0c0h, 80h, 0c0h, 00h, 00h, 00h, 00h
	defb	01h, 01h, 01h, 01h, 01h, 01h, 01h, 01h
	defb	00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h
	defb	10h, 10h, 10h, 10h, 10h, 10h, 10h, 10h
	defb	10h, 10h, 10h, 10h, 80h, 80h, 80h, 80h
	defb	08h, 0ch, 08h, 0ch, 02h, 02h, 02h, 02h
	defb	00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h
	defb	88h, 8ch, 88h, 8ch, 80h, 80h, 80h, 80h
	defb	0f0h, 0f0h, 0f0h, 0f0h, 0f0h, 0f0h, 0f0h, 0f0h
	defb	00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h
	defb	54h, 54h, 54h, 54h, 02h, 02h, 02h, 02h
	defb	00h, 00h, 00h, 00h, 80h, 0c0h, 80h, 0c0h
	defb	0fh, 0fh, 0fh, 0fh, 0afh, 0afh, 0afh, 0afh
	defb	50h, 50h, 50h, 50h, 00h, 00h, 00h, 00h
	defb	00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h
	defb	20h, 20h, 20h, 20h, 80h, 0c0h, 80h, 0c0h
	defb	00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h
	defb	0ch, 0ch, 3fh, 3fh, 3fh, 3fh, 33h, 3bh
	defb	33h, 3bh, 3fh, 3fh, 3fh, 3fh, 0ch, 0ch
	defb	0ch, 0ch, 3fh, 3fh, 3fh, 3fh, 33h, 3bh
	defb	33h, 3bh, 3fh, 3fh, 3fh, 3fh, 0cch, 0ch
	defb	03h, 00h, 0fh, 00h, 0fh, 00h, 3ch, 02h
	defb	33h, 08h, 3fh, 00h, 3ch, 00h, 30h, 00h
	defb	0f0h, 00h, 0fch, 00h, 0fch, 00h, 0cfh, 20h
	defb	33h, 88h, 0ffh, 00h, 0cfh, 00h, 0c3h, 00h
	defb	02h, 02h, 0ah, 0ah, 0ah, 0ah, 2ah, 2ah
	defb	22h, 2eh, 20h, 2fh, 28h, 2bh, 2ah, 2ah
	defb	0a0h, 0a0h, 0a8h, 0a8h, 0a8h, 0a8h, 0aah, 0aah
	defb	0a2h, 0aeh, 82h, 0beh, 8ah, 0bah, 0aah, 0aah
	defb	22h, 2ah, 20h, 2ah, 28h, 2ah, 08h, 0ah
	defb	0ah, 0ah, 2ah, 2ah, 22h, 22h, 20h, 20h
	defb	22h, 0aah, 02h, 0aah, 0ah, 0aah, 88h, 0a8h
	defb	0a8h, 0a8h, 0aah, 0aah, 0a2h, 0a2h, 82h, 82h
	defb	0ffh, 0ffh, 0c0h, 0eah, 0c0h, 0eah, 0c0h, 0eah
	defb	0c0h, 0eah, 0c0h, 0eah, 0c0h, 0eah, 0c0h, 0eah
	defb	0ffh, 0ffh, 03h, 0abh, 03h, 0abh, 03h, 0abh
	defb	03h, 0abh, 03h, 0abh, 3fh, 97h, 3fh, 97h
	defb	0c0h, 0eah, 0cfh, 0e5h, 0cfh, 0e5h, 0cfh, 0e5h
	defb	0cfh, 0e5h, 0cfh, 0e5h, 0cfh, 0e5h, 0ffh, 0ffh
	defb	3fh, 97h, 3fh, 97h, 3fh, 97h, 3fh, 97h
	defb	3fh, 97h, 3fh, 97h, 3fh, 97h, 0ffh, 0ffh
	defb	00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h
	defb	03h, 01h, 03h, 01h, 03h, 01h, 0f3h, 59h
	defb	00h, 00h, 0fh, 05h, 0fh, 05h, 0fh, 05h
	defb	0cfh, 65h, 0cfh, 65h, 0cfh, 65h, 0c0h, 6ah
	defb	0f3h, 59h, 0f3h, 59h, 0f0h, 5ah, 0f3h, 59h
	defb	0f3h, 59h, 03h, 0a9h, 0ffh, 55h, 00h, 00h
	defb	0cfh, 65h, 0cfh, 65h, 0fh, 0a5h, 0ffh, 55h
	defb	0ffh, 55h, 0ffh, 55h, 0ffh, 55h, 00h, 00h
	defb	2ah, 00h, 2ah, 00h, 2ah, 00h, 2ah, 00h
	defb	2ah, 00h, 2ah, 00h, 2ah, 00h, 2ah, 00h
	defb	0a8h, 00h, 0a8h, 00h, 0a8h, 00h, 0a8h, 00h
	defb	0a8h, 00h, 0a8h, 00h, 0a8h, 00h, 88h, 20h
	defb	2ah, 00h, 2ah, 00h, 2ah, 00h, 2ah, 00h
	defb	2ah, 00h, 2ah, 00h, 2ah, 00h, 2ah, 00h
	defb	88h, 20h, 0a8h, 00h, 0a8h, 00h, 0a8h, 00h
	defb	0a8h, 00h, 0a8h, 00h, 0a8h, 00h, 0a8h, 00h
