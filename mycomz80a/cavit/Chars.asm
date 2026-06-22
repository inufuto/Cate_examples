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
	defb	0dfh, 0f7h, 0f7h, 0fbh, 0e7h, 0bdh, 00h, 00h
	defb	05h, 00h, 00h, 0a0h, 10h, 10h, 08h, 08h
	defb	05h, 01h, 10h, 0b0h, 0dh, 08h, 08h, 58h
;	8dot
	defb	00h, 0eeh, 0ah, 00h, 0c0h, 34h, 8ch, 00h
	defb	00h, 0eeh, 0ah, 00h, 20h, 0bdh, 20h, 00h
	defb	00h, 0a0h, 0eeh, 00h, 00h, 0c8h, 43h, 0ch
	defb	00h, 0a0h, 0eeh, 00h, 00h, 02h, 0dbh, 02h
	defb	0c0h, 0cch, 88h, 26h, 10h, 10h, 00h, 31h
	defb	0c0h, 0cch, 0ach, 0c4h, 10h, 10h, 20h, 00h
	defb	80h, 80h, 00h, 0c8h, 30h, 33h, 11h, 46h
	defb	80h, 80h, 40h, 00h, 30h, 33h, 53h, 32h
	defb	00h, 0eeh, 1ah, 1fh, 0c0h, 34h, 9dh, 00h
	defb	00h, 0e0h, 0aeh, 00h, 00h, 0c0h, 29h, 72h
	defb	0f1h, 0a1h, 0eeh, 00h, 00h, 0d9h, 43h, 0ch
	defb	00h, 0eah, 0eh, 00h, 27h, 92h, 0ch, 00h
	defb	0c0h, 0cch, 88h, 26h, 5eh, 54h, 03h, 31h
	defb	80h, 88h, 00h, 88h, 30h, 31h, 0e9h, 18h
	defb	0a7h, 0a2h, 0ch, 0c8h, 30h, 33h, 11h, 46h
	defb	0c0h, 0c8h, 79h, 81h, 10h, 11h, 00h, 11h
	defb	80h, 0feh, 0fah, 8ah, 00h, 0fbh, 37h, 01h
	defb	00h, 0ech, 0e4h, 04h, 20h, 0ffh, 7fh, 23h
	defb	0a8h, 0afh, 0efh, 08h, 10h, 73h, 0bfh, 00h
	defb	40h, 4eh, 0ceh, 00h, 32h, 0f7h, 0ffh, 02h
	defb	80h, 0beh, 0beh, 8eh, 00h, 73h, 7fh, 03h
	defb	00h, 6ch, 6ch, 0ch, 10h, 0f7h, 0ffh, 17h
	defb	0e8h, 0efh, 0efh, 08h, 30h, 0f7h, 37h, 00h
	defb	0c0h, 0ceh, 0ceh, 00h, 71h, 0ffh, 7fh, 01h
	defb	7fh, 01h, 05h, 75h, 0ffh, 06h, 0c8h, 0feh
	defb	0ffh, 13h, 1bh, 0fbh, 0dfh, 00h, 80h, 0dch
	defb	57h, 50h, 10h, 0f7h, 0efh, 8ch, 60h, 0ffh
	defb	0bfh, 0b1h, 31h, 0ffh, 0cdh, 08h, 00h, 0fdh
	defb	17h, 14h, 14h, 0f7h, 0cfh, 08h, 0c8h, 0ffh
	defb	3fh, 39h, 39h, 0ffh, 8dh, 00h, 80h, 0fdh
	defb	17h, 10h, 10h, 0f7h, 0cfh, 08h, 0c8h, 0ffh
	defb	3fh, 31h, 31h, 0ffh, 8dh, 00h, 80h, 0fdh
	defb	60h, 69h, 68h, 69h, 0c0h, 76h, 7fh, 0c6h
	defb	0c0h, 0d6h, 0efh, 84h, 0b7h, 0f7h, 0b6h, 35h
	defb	0e4h, 0c0h, 0c2h, 00h, 32h, 02h, 61h, 69h
	defb	24h, 0cch, 0c2h, 00h, 32h, 02h, 61h, 69h
	defb	8ch, 0ceh, 0c2h, 00h, 00h, 03h, 61h, 69h
	defb	0a4h, 0c4h, 0c2h, 00h, 21h, 01h, 61h, 69h
	defb	00h, 31h, 2ch, 03h, 00h, 50h, 77h, 00h
	defb	62h, 88h, 0cch, 0ch, 13h, 00h, 01h, 01h
	defb	0c4h, 6ah, 0ffh, 0ceh, 63h, 0dh, 0ddh, 64h
