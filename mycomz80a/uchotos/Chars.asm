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
	defb	0f0h, 0aah, 0aah, 0fh, 77h, 77h
;	8dot
	defb	0c4h, 0fch, 0cch, 04h, 40h, 13h, 43h, 00h
;	sprite
	defb	80h, 0f5h, 7dh, 08h, 10h, 3ch, 0c3h, 01h
	defb	00h, 0f5h, 0fdh, 00h, 90h, 34h, 43h, 05h
	defb	00h, 75h, 7dh, 00h, 00h, 0d0h, 0c1h, 00h
	defb	00h, 0f5h, 7dh, 00h, 10h, 2dh, 43h, 05h
	defb	80h, 0d7h, 5fh, 08h, 10h, 3ch, 0c3h, 01h
	defb	00h, 0dfh, 5fh, 00h, 50h, 34h, 43h, 09h
	defb	00h, 0d7h, 57h, 00h, 00h, 1ch, 0dh, 00h
	defb	00h, 0d7h, 5fh, 00h, 50h, 34h, 0d2h, 01h
	defb	80h, 0b3h, 0bbh, 04h, 00h, 35h, 0c3h, 00h
	defb	40h, 0bbh, 3bh, 08h, 00h, 3ch, 53h, 00h
	defb	2ch, 3fh, 0efh, 8ch, 50h, 59h, 59h, 09h
	defb	48h, 6eh, 0ceh, 08h, 0a1h, 0a3h, 0b3h, 13h
	defb	0c8h, 0feh, 0f3h, 0c2h, 90h, 95h, 95h, 05h
	defb	80h, 0ech, 0e6h, 84h, 31h, 3bh, 3ah, 1ah
	defb	0a0h, 0a9h, 0a9h, 09h, 73h, 0dah, 0adh, 37h
	defb	00h, 48h, 4ch, 00h, 30h, 54h, 12h, 00h
	defb	1eh, 1fh, 0b3h, 0c3h, 63h, 66h, 64h, 36h
