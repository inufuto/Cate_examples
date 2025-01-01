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
;	wall
	defb	00h, 00h, 00h, 00h, 88h, 88h, 88h, 88h
	defb	11h, 11h, 11h, 11h, 99h, 99h, 99h, 99h
	defb	0ffh, 00h, 00h, 00h, 77h, 88h, 88h, 88h
	defb	0eeh, 11h, 11h, 11h, 66h, 99h, 99h, 99h
	defb	00h, 00h, 00h, 0ffh, 88h, 88h, 88h, 77h
	defb	11h, 11h, 11h, 0eeh, 99h, 99h, 99h, 66h
	defb	0ffh, 00h, 00h, 0ffh, 77h, 88h, 88h, 77h
	defb	0eeh, 11h, 11h, 0eeh, 66h, 99h, 99h, 66h
;	mono16
	defb	22h, 77h, 22h, 0ffh, 88h, 0cch, 0cch, 0eeh
	defb	77h, 33h, 31h, 10h, 0cch, 0cch, 88h, 0cch
	defb	02h, 27h, 72h, 27h, 08h, 8ch, 0cch, 0cch
	defb	7fh, 0f7h, 33h, 11h, 0ceh, 0ech, 0c8h, 0cch
	defb	11h, 33h, 33h, 77h, 44h, 0eeh, 44h, 0ffh
	defb	33h, 33h, 11h, 33h, 0eeh, 0cch, 0c8h, 80h
	defb	01h, 13h, 33h, 33h, 04h, 4eh, 0e4h, 4eh
	defb	37h, 73h, 31h, 33h, 0efh, 0feh, 0cch, 88h
	defb	11h, 33h, 33h, 77h, 44h, 0eeh, 0eeh, 0ffh
	defb	33h, 33h, 11h, 00h, 0eeh, 0eeh, 0cch, 88h
	defb	00h, 11h, 33h, 33h, 00h, 44h, 0eeh, 0eeh
	defb	33h, 77h, 33h, 11h, 0eeh, 0ffh, 0eeh, 0cch
	defb	22h, 77h, 55h, 0ffh, 88h, 0cch, 44h, 0eeh
	defb	77h, 77h, 33h, 11h, 0cch, 0cch, 88h, 00h
	defb	00h, 22h, 77h, 55h, 00h, 88h, 0cch, 44h
	defb	77h, 0ffh, 77h, 33h, 0cch, 0eeh, 0cch, 88h
	defb	00h, 00h, 00h, 11h, 00h, 00h, 00h, 88h
	defb	11h, 00h, 00h, 00h, 88h, 00h, 00h, 00h

ColorPattern: public ColorPattern
;	color16
	defb	00h, 00h, 01h, 02h, 09h, 0ah, 16h, 2ah
	defb	05h, 0ah, 0fh, 0fh, 03h, 0bh, 03h, 0bh
	defb	50h, 0a0h, 50h, 0a0h, 44h, 88h, 80h, 80h
	defb	50h, 0a0h, 0d4h, 0e8h, 30h, 0b0h, 30h, 0b0h
	defb	0fh, 0fh, 05h, 05h, 05h, 05h, 04h, 06h
	defb	04h, 06h, 0ch, 0ch, 0ch, 0ch, 28h, 3ch
	defb	0c0h, 0c0h, 50h, 50h, 10h, 90h, 90h, 0d0h
	defb	80h, 0e0h, 00h, 0a0h, 30h, 30h, 0a0h, 0f0h
	defb	00h, 00h, 01h, 02h, 09h, 0ah, 16h, 2ah
	defb	05h, 0ah, 0fh, 0fh, 03h, 0bh, 03h, 0bh
	defb	50h, 0a0h, 50h, 0a0h, 44h, 88h, 80h, 80h
	defb	50h, 0a0h, 0d4h, 0e8h, 30h, 0b0h, 30h, 0b0h
	defb	0fh, 0fh, 05h, 05h, 25h, 35h, 25h, 35h
	defb	05h, 05h, 0ch, 0ch, 0ch, 0ch, 02h, 03h
	defb	0c0h, 0c0h, 50h, 50h, 54h, 54h, 48h, 4ch
	defb	48h, 4ch, 0c0h, 0c0h, 0c0h, 0c0h, 80h, 0c0h
	defb	05h, 0ah, 05h, 0ah, 11h, 22h, 02h, 02h
	defb	05h, 0ah, 17h, 2bh, 0ch, 0eh, 0ch, 0eh
	defb	00h, 00h, 40h, 80h, 60h, 0a0h, 94h, 0a8h
	defb	50h, 0a0h, 0f0h, 0f0h, 0c0h, 0e0h, 0c0h, 0e0h
	defb	03h, 03h, 05h, 05h, 04h, 06h, 06h, 07h
	defb	02h, 0bh, 00h, 0ah, 0ch, 0ch, 0ah, 0fh
	defb	0f0h, 0f0h, 50h, 50h, 50h, 50h, 10h, 90h
	defb	10h, 90h, 30h, 30h, 30h, 30h, 28h, 3ch
	defb	05h, 0ah, 05h, 0ah, 11h, 22h, 02h, 02h
	defb	05h, 0ah, 17h, 2bh, 0ch, 0eh, 0ch, 0eh
	defb	00h, 00h, 40h, 80h, 60h, 0a0h, 94h, 0a8h
	defb	50h, 0a0h, 0f0h, 0f0h, 0c0h, 0e0h, 0c0h, 0e0h
	defb	03h, 03h, 05h, 05h, 15h, 15h, 21h, 31h
	defb	21h, 31h, 03h, 03h, 03h, 03h, 02h, 03h
	defb	0f0h, 0f0h, 50h, 50h, 58h, 5ch, 58h, 5ch
	defb	50h, 50h, 30h, 30h, 30h, 30h, 80h, 0c0h
	defb	15h, 2ah, 05h, 0ah, 05h, 0ah, 05h, 0ah
	defb	19h, 2ah, 56h, 0aah, 55h, 0aah, 15h, 2ah
	defb	00h, 00h, 40h, 80h, 40h, 80h, 40h, 80h
	defb	90h, 0a0h, 54h, 0a8h, 54h, 0a8h, 50h, 0a0h
	defb	05h, 0ah, 15h, 15h, 15h, 15h, 05h, 05h
	defb	05h, 05h, 0ch, 0ch, 0ch, 0ch, 08h, 0ch
	defb	40h, 80h, 50h, 50h, 50h, 50h, 60h, 70h
	defb	40h, 40h, 0c0h, 0c0h, 80h, 0c0h, 00h, 00h
	defb	15h, 2ah, 05h, 0ah, 05h, 0ah, 05h, 0ah
	defb	19h, 2ah, 56h, 0aah, 55h, 0aah, 15h, 2ah
	defb	00h, 00h, 40h, 80h, 40h, 80h, 40h, 80h
	defb	90h, 0a0h, 54h, 0a8h, 54h, 0a8h, 50h, 0a0h
	defb	05h, 0ah, 15h, 15h, 15h, 15h, 25h, 35h
	defb	05h, 05h, 0ch, 0ch, 08h, 0ch, 00h, 00h
	defb	40h, 80h, 50h, 50h, 50h, 50h, 40h, 40h
	defb	40h, 40h, 0c0h, 0c0h, 0c0h, 0c0h, 80h, 0c0h
	defb	01h, 02h, 05h, 0ah, 0ah, 0ah, 05h, 0ah
	defb	15h, 2ah, 5fh, 0afh, 33h, 3bh, 33h, 3bh
	defb	50h, 0a0h, 40h, 80h, 80h, 80h, 40h, 80h
	defb	50h, 0a0h, 0d4h, 0e8h, 30h, 0b0h, 30h, 0b0h
	defb	0fh, 0fh, 05h, 05h, 25h, 35h, 25h, 35h
	defb	05h, 05h, 0ch, 0ch, 0ch, 0ch, 08h, 0ch
	defb	0c0h, 0c0h, 50h, 50h, 90h, 0d0h, 80h, 0c0h
	defb	40h, 40h, 0c0h, 0c0h, 80h, 0c0h, 00h, 00h
	defb	01h, 02h, 05h, 0ah, 0ah, 0ah, 05h, 0ah
	defb	15h, 2ah, 5fh, 0afh, 33h, 3bh, 33h, 3bh
	defb	50h, 0a0h, 40h, 80h, 80h, 80h, 40h, 80h
	defb	50h, 0a0h, 0d4h, 0e8h, 30h, 0b0h, 30h, 0b0h
	defb	0fh, 0fh, 15h, 15h, 19h, 1dh, 09h, 0dh
	defb	05h, 05h, 0ch, 0ch, 08h, 0ch, 00h, 00h
	defb	0c0h, 0c0h, 40h, 40h, 60h, 70h, 60h, 70h
	defb	40h, 40h, 0c0h, 0c0h, 0c0h, 0c0h, 80h, 0c0h
	defb	00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h
	defb	00h, 00h, 00h, 00h, 02h, 02h, 0ah, 0ah
	defb	00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h
	defb	00h, 00h, 0a0h, 0a0h, 80h, 80h, 80h, 80h
	defb	0ah, 08h, 2ah, 20h, 2ah, 23h, 2ah, 20h
	defb	0ah, 0ah, 0ah, 0ah, 00h, 00h, 00h, 00h
	defb	80h, 80h, 80h, 80h, 0a0h, 20h, 80h, 80h
	defb	80h, 80h, 00h, 00h, 00h, 00h, 00h, 00h
	defb	00h, 00h, 00h, 00h, 02h, 02h, 02h, 02h
	defb	02h, 02h, 0ah, 0ah, 0ah, 08h, 0ah, 08h
	defb	00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h
	defb	00h, 00h, 80h, 80h, 80h, 80h, 80h, 80h
	defb	2ah, 20h, 2ah, 23h, 2ah, 23h, 2ah, 23h
	defb	2ah, 20h, 0ah, 08h, 0ah, 0ah, 00h, 00h
	defb	0a0h, 20h, 0a0h, 20h, 0a0h, 20h, 0a0h, 20h
	defb	0a0h, 20h, 80h, 80h, 80h, 80h, 00h, 00h
	defb	00h, 00h, 0ah, 00h, 22h, 08h, 0aah, 00h
	defb	8ah, 20h, 2ah, 00h, 00h, 00h, 22h, 11h
	defb	00h, 00h, 0a0h, 00h, 88h, 20h, 0aah, 00h
	defb	22h, 88h, 0a8h, 00h, 00h, 00h, 20h, 10h
	defb	08h, 04h, 00h, 00h, 2ah, 2ah, 2ah, 2ah
	defb	0aah, 00h, 0aah, 00h, 2ah, 00h, 00h, 00h
	defb	88h, 44h, 00h, 00h, 0a8h, 0a8h, 0a8h, 0a8h
	defb	0aah, 00h, 0aah, 00h, 0a8h, 00h, 00h, 00h
