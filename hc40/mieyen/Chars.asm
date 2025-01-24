cseg
AsciiPattern: public AsciiPattern
;	ascii
	defb	00h, 00h, 00h, 00h, 00h, 0e0h, 00h, 00h
	defb	0eah, 0aah, 0e0h, 00h, 22h, 22h, 20h, 00h
	defb	0e2h, 0e8h, 0e0h, 00h, 0e2h, 0e2h, 0e0h, 00h
	defb	0aah, 0e2h, 20h, 00h, 0e8h, 0e2h, 0e0h, 00h
	defb	0e8h, 0eah, 0e0h, 00h, 0e2h, 44h, 40h, 00h
	defb	0eah, 0eah, 0e0h, 00h, 0eah, 0e2h, 0e0h, 00h
	defb	4ah, 0aeh, 0a0h, 00h, 0cah, 0cah, 0c0h, 00h
	defb	4ah, 8ah, 40h, 00h, 0cah, 0aah, 0c0h, 00h
	defb	0e8h, 0c8h, 0e0h, 00h, 0e8h, 0c8h, 80h, 00h
	defb	68h, 0aah, 40h, 00h, 0aah, 0eah, 0a0h, 00h
	defb	0e4h, 44h, 0e0h, 00h, 62h, 2ah, 40h, 00h
	defb	0aah, 0cah, 0a0h, 00h, 88h, 88h, 0e0h, 00h
	defb	0aeh, 0eah, 0a0h, 00h, 0cah, 0aah, 0a0h, 00h
	defb	4ah, 0aah, 40h, 00h, 0eah, 0e8h, 80h, 00h
	defb	4ah, 0ach, 60h, 00h, 0cah, 0cah, 0a0h, 00h
	defb	68h, 0e2h, 0c0h, 00h, 0e4h, 44h, 40h, 00h
	defb	0aah, 0aah, 0e0h, 00h, 0aah, 0aah, 40h, 00h
	defb	0aah, 0eeh, 0a0h, 00h, 0aah, 4ah, 0a0h, 00h
	defb	0aah, 44h, 40h, 00h, 0e2h, 48h, 0e0h, 00h

CharPattern: public CharPattern
;	logo
	defb	00h, 00h, 0cch, 00h, 00h, 0cch, 0cch, 0cch
	defb	33h, 00h, 0ffh, 00h, 33h, 0cch, 0ffh, 0cch
	defb	00h, 33h, 0cch, 33h, 00h, 0ffh, 0cch, 0ffh
	defb	33h, 33h, 0ffh, 33h, 33h, 0ffh, 0ffh, 0ffh
;	wall
	defb	00h, 00h, 88h, 88h, 11h, 11h, 99h, 99h
	defb	0f0h, 00h, 78h, 88h, 0e1h, 11h, 69h, 99h
	defb	00h, 0fh, 88h, 87h, 11h, 1eh, 99h, 96h
	defb	0f0h, 0fh, 78h, 87h, 0e1h, 1eh, 69h, 96h
	defb	80h, 80h
;	point
	defb	22h, 22h, 0c2h, 4eh, 0aah, 0e2h, 0aeh, 0aeh
	defb	0eah, 0aeh
;	8dot
	defb	07h, 31h, 0ech, 0f4h, 30h, 06h, 84h, 84h
	defb	07h, 31h, 0ech, 0f4h, 34h, 01h, 84h, 28h
	defb	73h, 0f2h, 0eh, 0c8h, 12h, 12h, 0c0h, 06h
	defb	73h, 0f2h, 0eh, 0c8h, 12h, 41h, 0c2h, 08h
	defb	73h, 0f3h, 08h, 0e8h, 40h, 22h, 44h, 80h
	defb	73h, 0f3h, 08h, 0e8h, 44h, 20h, 40h, 88h
	defb	13h, 0f5h, 0c8h, 0e4h, 30h, 22h, 84h, 80h
	defb	13h, 0f5h, 0c8h, 0e4h, 34h, 20h, 80h, 88h
	defb	27h, 2fh, 8ch, 0ceh, 73h, 10h, 0cch, 8ch
	defb	02h, 72h, 08h, 0cch, 7fh, 31h, 0ceh, 0cch
	defb	13h, 37h, 4eh, 4fh, 33h, 13h, 0ech, 80h
	defb	01h, 33h, 04h, 0e4h, 37h, 33h, 0efh, 0c8h
	defb	27h, 7fh, 8ch, 0ceh, 77h, 31h, 0cch, 80h
	defb	02h, 77h, 08h, 0cch, 0f7h, 73h, 0ech, 0c8h
	defb	13h, 27h, 4eh, 0afh, 33h, 10h, 0eeh, 0c8h
	defb	01h, 32h, 04h, 0eah, 73h, 31h, 0feh, 0ech
	defb	00h, 12h, 00h, 0c8h, 54h, 30h, 48h, 00h
	defb	01h, 12h, 00h, 08h, 45h, 43h, 44h, 48h
	defb	00h, 01h, 00h, 08h, 10h, 00h, 80h, 00h
	defb	35h, 0f0h, 0ceh, 70h, 70h, 0f7h, 0e0h, 0feh
