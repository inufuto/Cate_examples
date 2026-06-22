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
	defb	00h, 0f0h, 40h, 12h, 88h, 88h, 21h, 04h
	defb	96h, 69h, 42h, 42h, 0a0h, 05h, 9fh, 0f9h
	defb	20h, 00h, 88h, 0f8h
;	8dot
	defb	80h, 0feh, 8eh, 00h, 31h, 71h, 31h, 01h
	defb	0cch, 0ech, 0eeh, 01h, 20h, 71h, 07h, 00h
	defb	0a8h, 0efh, 0cch, 08h, 20h, 37h, 11h, 00h
	defb	0a8h, 0fch, 8fh, 00h, 11h, 31h, 33h, 04h
	defb	0e4h, 0fch, 0ech, 04h, 00h, 73h, 03h, 00h
	defb	80h, 0ffh, 0ach, 08h, 34h, 33h, 11h, 01h
	defb	0c8h, 0ech, 0afh, 08h, 10h, 31h, 27h, 00h
	defb	0e1h, 0eeh, 0cch, 0ch, 00h, 77h, 21h, 00h
	defb	0c8h, 0fah, 0cah, 08h, 13h, 71h, 11h, 03h
	defb	24h, 0f7h, 0bdh, 0fh, 00h, 01h, 35h, 01h
	defb	98h, 0ffh, 0cah, 08h, 40h, 77h, 12h, 00h
	defb	00h, 84h, 0edh, 0ch, 21h, 77h, 65h, 07h
	defb	0ceh, 0fch, 0cch, 0eh, 10h, 72h, 12h, 00h
	defb	0ech, 8dh, 04h, 00h, 67h, 75h, 27h, 01h
	defb	0c8h, 0fah, 9fh, 08h, 10h, 72h, 47h, 00h
	defb	0bfh, 0fdh, 27h, 04h, 31h, 05h, 01h, 00h
	defb	0e4h, 0b6h, 4ah, 4eh, 72h, 0e2h, 25h, 17h
	defb	00h, 0c2h, 84h, 7ch, 62h, 0ffh, 0e9h, 6fh
	defb	0ceh, 0ech, 07h, 88h, 0ddh, 36h, 3fh, 01h
	defb	64h, 0dbh, 7bh, 0e2h, 00h, 36h, 11h, 0e2h
	defb	97h, 0abh, 58h, 46h, 12h, 31h, 23h, 00h
	defb	1eh, 1fh, 0b3h, 0e3h, 63h, 66h, 64h, 36h
;	fort
	defb	0ech, 0ffh, 4eh, 80h, 0c8h, 0ech, 0ceh, 8ch
	defb	08h, 0e4h, 0ffh, 0ceh, 50h, 55h, 66h, 07h
	defb	0a6h, 0cch, 0cch, 6ah, 70h, 66h, 55h, 05h
	defb	10h, 0d9h, 9dh, 60h, 0ffh, 0adh, 0dah, 0ffh
	defb	06h, 0d9h, 9dh, 01h, 80h, 0b9h, 9bh, 60h
	defb	0ffh, 5bh, 0b5h, 0ffh, 06h, 0b9h, 9bh, 08h
	defb	0a0h, 0aah, 66h, 0eh, 56h, 33h, 33h, 65h
	defb	0e0h, 66h, 0aah, 0ah, 73h, 0ffh, 27h, 10h
	defb	31h, 73h, 37h, 13h, 01h, 72h, 0ffh, 37h
