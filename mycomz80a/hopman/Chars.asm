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
	defb	33h, 33h, 0fch, 0ch
;	8dot
	defb	80h, 0f5h, 7dh, 08h, 10h, 3ch, 0c3h, 01h
	defb	00h, 0f5h, 0fdh, 00h, 90h, 34h, 43h, 05h
	defb	00h, 75h, 7dh, 00h, 00h, 0d0h, 0c1h, 00h
	defb	00h, 0f5h, 7dh, 00h, 10h, 2dh, 43h, 05h
	defb	80h, 0d7h, 5fh, 08h, 10h, 3ch, 0c3h, 01h
	defb	00h, 0dfh, 5fh, 00h, 50h, 34h, 43h, 09h
	defb	00h, 0d7h, 57h, 00h, 00h, 1ch, 0dh, 00h
	defb	00h, 0d7h, 5fh, 00h, 50h, 34h, 0d2h, 01h
	defb	4ch, 0ach, 8ah, 44h, 13h, 53h, 15h, 22h
	defb	80h, 0c3h, 3ch, 08h, 10h, 0beh, 0afh, 01h
	defb	44h, 0a8h, 0cah, 0c8h, 22h, 51h, 35h, 32h
	defb	0a8h, 0afh, 0efh, 08h, 10h, 73h, 0bfh, 00h
	defb	40h, 4eh, 0ceh, 00h, 32h, 0f7h, 0ffh, 02h
	defb	80h, 0feh, 0fah, 8ah, 00h, 0fbh, 37h, 01h
	defb	00h, 0ech, 0e4h, 04h, 20h, 0ffh, 7fh, 23h
	defb	0f7h, 0bbh, 0b1h, 7fh, 00h, 11h, 11h, 00h
	defb	0f7h, 1bh, 0bbh, 7fh, 00h, 11h, 11h, 00h
	defb	0f7h, 9dh, 0d9h, 7fh, 00h, 11h, 11h, 00h
	defb	0f7h, 9bh, 0b9h, 7fh, 00h, 11h, 11h, 00h
	defb	00h, 0afh, 0a5h, 05h, 80h, 8fh, 00h, 00h
;	goal
	defb	1eh, 5dh, 1fh, 1dh, 3fh, 35h, 1fh, 0efh
	defb	0c7h, 0cdh, 0cfh, 0cdh, 0cfh, 0cfh, 0cfh, 7dh
	defb	0e0h, 0eh, 00h, 00h, 00h, 00h, 0e0h, 0eh
	defb	0f0h, 0fh, 00h, 00h, 00h, 00h, 0f0h, 0fh
