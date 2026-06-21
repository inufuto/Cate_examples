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
	defb	80h, 0fch, 0eeh, 8ch, 33h, 00h, 00h, 33h
	defb	0cch, 00h, 00h, 0cch
;	8dot
	defb	0ceh, 0c8h, 0aeh, 8ch, 10h, 65h, 12h, 11h
	defb	0c0h, 0feh, 88h, 00h, 62h, 34h, 0d7h, 07h
	defb	88h, 0e8h, 0dfh, 27h, 10h, 33h, 61h, 03h
	defb	0c8h, 0eah, 8ch, 0ech, 11h, 21h, 56h, 01h
	defb	80h, 7ah, 0ceh, 08h, 0e7h, 6fh, 0d6h, 6dh
	defb	00h, 0fch, 0ch, 00h, 0ech, 0f7h, 0e7h, 0ch
	defb	0e4h, 0b6h, 4ah, 4eh, 72h, 0e2h, 25h, 17h
	defb	00h, 0c2h, 84h, 7ch, 62h, 0ffh, 0e9h, 6fh
	defb	0ceh, 0ech, 07h, 88h, 0ddh, 36h, 3fh, 01h
	defb	64h, 0dbh, 7bh, 0e2h, 00h, 36h, 11h, 0e2h
	defb	97h, 0abh, 58h, 46h, 12h, 31h, 23h, 00h
	defb	1eh, 1fh, 0b3h, 0e3h, 63h, 66h, 64h, 36h
;	fort
	defb	0c8h, 0aeh, 0dbh, 0ddh, 0ddh, 0ddh, 0ddh, 0ddh
	defb	0ddh, 0ddh, 0ddh, 0aah, 0cch, 88h, 63h, 0aeh
	defb	6ah, 66h, 66h, 66h, 66h, 66h, 66h, 66h
	defb	66h, 0aah, 66h, 32h, 00h, 00h, 0d5h, 0ddh
	defb	55h, 0ddh, 0ddh, 5dh, 0d5h, 0ddh, 15h, 00h
	defb	00h, 00h, 00h, 20h, 32h, 11h, 00h, 20h
	defb	0f3h, 0bh, 10h, 31h, 02h, 00h, 00h, 00h
