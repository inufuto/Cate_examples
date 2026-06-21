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
	defb	4ah, 0ah, 0ah, 0ah, 0eeh, 0eh, 0eh, 0eeh
	defb	0ffh, 0ffh, 06h, 06h, 06h, 00h, 88h, 88h
	defb	00h, 0f0h, 88h, 88h, 11h, 11h
;	8dot
	defb	80h, 73h, 55h, 08h, 0c0h, 15h, 32h, 8ch
	defb	00h, 7bh, 55h, 00h, 00h, 0d0h, 09h, 00h
	defb	80h, 55h, 37h, 08h, 0c8h, 23h, 51h, 0ch
	defb	00h, 55h, 0b7h, 00h, 00h, 90h, 0dh, 00h
	defb	28h, 55h, 25h, 08h, 03h, 3fh, 16h, 00h
	defb	28h, 55h, 25h, 08h, 03h, 37h, 0fh, 01h
	defb	28h, 77h, 27h, 08h, 01h, 37h, 0fh, 00h
	defb	28h, 77h, 27h, 08h, 00h, 3fh, 07h, 01h
	defb	80h, 76h, 65h, 08h, 0c0h, 15h, 32h, 8ch
	defb	00h, 7eh, 65h, 00h, 00h, 0d0h, 09h, 00h
	defb	80h, 56h, 67h, 08h, 0c8h, 23h, 51h, 0ch
	defb	00h, 56h, 0e7h, 00h, 00h, 90h, 0dh, 00h
	defb	68h, 57h, 67h, 08h, 03h, 3fh, 16h, 00h
	defb	68h, 57h, 67h, 08h, 03h, 37h, 0fh, 01h
	defb	68h, 77h, 67h, 08h, 01h, 37h, 0fh, 00h
	defb	68h, 77h, 67h, 08h, 00h, 3fh, 07h, 01h
	defb	0e4h, 0b6h, 4ah, 4eh, 72h, 0e2h, 25h, 17h
	defb	00h, 0c2h, 84h, 7ch, 62h, 0ffh, 0e9h, 6fh
	defb	0ceh, 0ech, 07h, 88h, 0ddh, 36h, 3fh, 01h
	defb	64h, 0dbh, 7bh, 0e2h, 00h, 36h, 11h, 0e2h
	defb	97h, 0abh, 58h, 46h, 12h, 31h, 23h, 00h
;	fort
	defb	00h, 00h, 00h, 00h, 00h, 0ech, 0afh, 00h
	defb	80h, 6ch, 3ah, 0ddh, 0d1h, 0e2h, 2eh, 0fh
	defb	0dch, 45h, 55h, 0cch, 0ddh, 0c5h, 5ch, 0ddh
	defb	00h, 0a8h, 0efh, 0ch, 00h, 00h, 00h, 00h
	defb	0c0h, 0a6h, 2eh, 0aeh, 0ddh, 0bch, 8bh, 0eh
	defb	0a4h, 0aah, 0aah, 6ah, 0a6h, 0aah, 0aah, 4ah
