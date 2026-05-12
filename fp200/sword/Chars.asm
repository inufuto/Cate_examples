cseg
AsciiPattern: public AsciiPattern
	; ascii 29
	; " 0123456789ACEFGHIKMNOPRSTUVY"
	defb 00h,00h,00h,00h,57h,55h,07h,00h
	defb 44h,44h,04h,00h,47h,17h,07h,00h
	defb 47h,47h,07h,00h,55h,47h,04h,00h
	defb 17h,47h,07h,00h,17h,57h,07h,00h
	defb 47h,22h,02h,00h,57h,57h,07h,00h
	defb 57h,47h,07h,00h,52h,75h,05h,00h
	defb 52h,51h,02h,00h,17h,13h,07h,00h
	defb 17h,13h,01h,00h,16h,55h,02h,00h
	defb 55h,57h,05h,00h,27h,22h,07h,00h
	defb 55h,53h,05h,00h,75h,57h,05h,00h
	defb 53h,55h,05h,00h,52h,55h,02h,00h
	defb 57h,17h,01h,00h,53h,53h,05h,00h
	defb 16h,47h,03h,00h,27h,22h,02h,00h
	defb 55h,55h,07h,00h,55h,55h,02h,00h
	defb 55h,22h,02h,00h

CharPattern: public CharPattern
;	logo
	defb	00h, 00h, 33h, 00h, 00h, 33h, 33h, 33h
	defb	0cch, 00h, 0ffh, 00h, 0cch, 33h, 0ffh, 33h
	defb	00h, 0cch, 33h, 0cch, 00h, 0ffh, 33h, 0ffh
	defb	0cch, 0cch, 0ffh, 0cch, 0cch, 0ffh, 0ffh, 0ffh
;	8dot
	defb	1fh, 11h, 8fh, 88h, 11h, 0f1h, 88h, 0f8h
	defb	0c0h, 6bh, 73h, 0ffh, 35h, 46h, 0c3h, 3fh
	defb	00h, 0a0h, 60h, 37h, 0ech, 04h, 01h, 01h
;	sprite
	defb	0ch, 04h, 23h, 03h, 44h, 60h, 00h, 46h
	defb	0ch, 04h, 23h, 03h, 0a8h, 80h, 11h, 10h
	defb	0eh, 0ah, 11h, 01h, 0cdh, 60h, 00h, 23h
	defb	00h, 00h, 00h, 00h, 8ch, 00h, 0ffh, 00h
	defb	4ch, 0ch, 03h, 02h, 08h, 26h, 30h, 60h
	defb	4ch, 0ch, 03h, 02h, 84h, 80h, 54h, 10h
	defb	88h, 08h, 07h, 05h, 00h, 4ch, 0eh, 60h
	defb	00h, 00h, 00h, 00h, 0ffh, 00h, 13h, 00h
	defb	0cch, 0ch, 33h, 03h, 8ah, 44h, 55h, 02h
	defb	0cch, 0ch, 33h, 03h, 0aah, 04h, 15h, 22h
	defb	0cch, 0ch, 33h, 03h, 0aah, 44h, 11h, 22h
	defb	00h, 00h, 00h, 31h, 00h, 00h, 33h, 33h
	defb	0ch, 04h, 23h, 03h, 8ah, 44h, 55h, 02h
	defb	4ch, 0ch, 03h, 02h, 0aah, 04h, 15h, 22h
	defb	00h, 0ch, 00h, 23h, 24h, 42h, 45h, 20h
	defb	0cch, 0cch, 00h, 00h, 8ch, 00h, 00h, 00h
	defb	8ch, 4ch, 23h, 13h, 80h, 60h, 00h, 46h
	defb	8ch, 4ch, 23h, 13h, 20h, 80h, 40h, 11h
	defb	4ch, 8ch, 13h, 23h, 00h, 26h, 10h, 60h
	defb	4ch, 8ch, 13h, 23h, 20h, 88h, 40h, 10h
	defb	0cch, 2ch, 33h, 43h, 00h, 44h, 04h, 02h
	defb	0cch, 2ch, 33h, 43h, 02h, 04h, 00h, 22h
	defb	8ch, 4ch, 23h, 53h, 00h, 44h, 04h, 02h
	defb	4ch, 0ach, 13h, 23h, 02h, 04h, 00h, 22h
	defb	0fah, 0ebh, 0d6h, 0e7h, 6fh, 0afh, 7dh, 5bh
	defb	20h, 0abh, 10h, 22h, 72h, 00h, 0a5h, 4ah
	defb	20h, 0cdh, 10h, 22h, 72h, 00h, 0a5h, 4ah
	defb	40h, 0ddh, 10h, 22h, 47h, 00h, 0a5h, 4ah
	defb	20h, 0adh, 10h, 22h, 25h, 00h, 0a5h, 4ah
	defb	5eh, 55h, 77h, 0a8h, 0f1h, 0eh, 0e8h, 07h
