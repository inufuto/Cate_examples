cseg


AsciiPattern: public AsciiPattern
	; ascii 33
	; " -0123456789ABCEFGHIKLMNOPRSTUVWY"
	defb 00h,00h,00h,00h,44h,04h,00h,00h
	defb 1fh,0fh,11h,01h,00h,0fh,00h,01h
	defb 5dh,07h,11h,01h,55h,0fh,11h,01h
	defb 47h,0fh,00h,01h,57h,0dh,11h,01h
	defb 5fh,0dh,11h,01h,0d1h,03h,10h,00h
	defb 5fh,0fh,11h,01h,57h,0fh,11h,01h
	defb 9eh,0eh,01h,01h,5fh,0ah,11h,00h
	defb 1eh,0ah,10h,00h,5fh,01h,11h,01h
	defb 5fh,01h,01h,00h,1eh,0dh,10h,00h
	defb 4fh,0fh,01h,01h,0f1h,01h,11h,01h
	defb 4fh,0bh,01h,01h,0fh,00h,11h,01h
	defb 6fh,0fh,01h,01h,1fh,0eh,01h,01h
	defb 1eh,0eh,10h,00h,5fh,07h,01h,00h
	defb 5fh,0ah,01h,01h,56h,0dh,11h,00h
	defb 0f1h,01h,10h,00h,0fh,0fh,11h,01h
	defb 0fh,0fh,10h,00h,0cfh,0fh,01h,01h
	defb 0c3h,03h,10h,00h

CharPattern: public CharPattern
;	logo
	defb	00h, 00h, 33h, 00h, 0cch, 00h, 0ffh, 00h
	defb	00h, 33h, 33h, 33h, 0cch, 33h, 0ffh, 33h
	defb	00h, 0cch, 33h, 0cch, 0cch, 0cch, 0ffh, 0cch
	defb	00h, 0ffh, 33h, 0ffh, 0cch, 0ffh, 0ffh, 0ffh
;	4dot
	defb	20h, 00h, 00h, 0f0h, 96h, 69h
;	8dot
	defb	57h, 0cbh, 5bh, 07h, 32h, 73h, 33h, 02h
	defb	0c4h, 0dfh, 4fh, 0ch, 20h, 31h, 17h, 01h
	defb	0f8h, 0ceh, 5bh, 07h, 70h, 13h, 56h, 07h
	defb	0a0h, 0ech, 4fh, 0ch, 11h, 57h, 17h, 01h
	defb	62h, 0feh, 6eh, 02h, 57h, 16h, 56h, 07h
	defb	4ch, 0efh, 0ach, 00h, 11h, 57h, 17h, 01h
	defb	57h, 0cbh, 0feh, 08h, 57h, 16h, 73h, 00h
	defb	4ch, 0dfh, 0cfh, 04h, 11h, 37h, 21h, 00h
	defb	0ech, 0fbh, 0ebh, 0ch, 32h, 73h, 33h, 02h
	defb	0c4h, 0dfh, 7fh, 0eh, 20h, 31h, 17h, 01h
	defb	0f8h, 0feh, 0ebh, 0ch, 70h, 73h, 36h, 01h
	defb	0a0h, 0ech, 4fh, 0ch, 11h, 57h, 77h, 03h
	defb	0eah, 0feh, 0eeh, 0ah, 31h, 76h, 36h, 01h
	defb	4ch, 0efh, 0ach, 00h, 73h, 57h, 17h, 01h
	defb	0ech, 0fbh, 0feh, 08h, 31h, 76h, 73h, 00h
	defb	7eh, 0dfh, 0cfh, 04h, 11h, 37h, 21h, 00h
	defb	0e8h, 0ebh, 0ebh, 08h, 10h, 73h, 13h, 00h
	defb	0e0h, 0deh, 4fh, 0ch, 76h, 33h, 33h, 00h
	defb	0c8h, 0feh, 0eah, 04h, 10h, 73h, 32h, 01h
	defb	0f3h, 0eeh, 6eh, 08h, 30h, 53h, 17h, 01h
	defb	0c8h, 0feh, 0ceh, 08h, 30h, 36h, 36h, 00h
	defb	68h, 0eeh, 0feh, 03h, 11h, 57h, 33h, 00h
	defb	0e4h, 0fah, 0ceh, 08h, 31h, 72h, 13h, 00h
	defb	4ch, 0dfh, 0eeh, 00h, 30h, 33h, 73h, 06h
	defb	0fch, 0a4h, 0f4h, 0ch, 73h, 33h, 73h, 03h
	defb	0e4h, 0b6h, 4ah, 4eh, 72h, 0e2h, 25h, 17h
	defb	00h, 0c2h, 84h, 7ch, 62h, 0ffh, 0e9h, 6fh
	defb	0ceh, 0ech, 07h, 88h, 0ddh, 36h, 3fh, 01h
	defb	64h, 0dbh, 7bh, 0e2h, 00h, 36h, 11h, 0e2h
	defb	97h, 0abh, 58h, 46h, 12h, 31h, 23h, 00h
	defb	1eh, 1fh, 0b3h, 0e3h, 63h, 66h, 64h, 36h
