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
	defb	01h, 01h
;	8dot
	defb	00h, 0fch, 0ch, 00h, 0bah, 0b9h, 0b9h, 0ah
	defb	00h, 00h, 00h, 00h, 88h, 88h, 88h, 08h
	defb	00h, 0fch, 0ch, 00h, 32h, 0b5h, 35h, 02h
	defb	1eh, 0ddh, 0ddh, 0e1h, 87h, 0bbh, 0bbh, 78h
	defb	0ebh, 0fch, 0ech, 0bh, 53h, 0dfh, 5fh, 03h
	defb	80h, 0ech, 9dh, 12h, 73h, 0ffh, 5bh, 03h
	defb	0e4h, 0b6h, 4ah, 4eh, 72h, 0e2h, 25h, 17h
	defb	00h, 0c2h, 84h, 7ch, 62h, 0ffh, 0e9h, 6fh
	defb	0ceh, 0ech, 07h, 88h, 0ddh, 36h, 3fh, 01h
	defb	64h, 0dbh, 7bh, 0e2h, 00h, 36h, 11h, 0e2h
	defb	97h, 0abh, 58h, 46h, 12h, 31h, 23h, 00h
;	ufo
	defb	0c0h, 0eeh, 0ffh, 0f9h, 9fh, 0ffh, 0eeh, 0ch
	defb	00h, 63h, 00h, 00h, 00h, 00h, 36h, 00h
