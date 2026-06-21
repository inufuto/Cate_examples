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
;	fence
	defb	88h, 88h, 11h, 11h
;	8dot
	defb	7bh, 0deh, 7bh, 0eh, 73h, 56h, 73h, 06h
	defb	1eh, 0ddh, 1dh, 0eh, 43h, 55h, 45h, 03h
	defb	1ch, 58h, 05h, 0eh, 42h, 15h, 45h, 02h
	defb	00h, 0c8h, 48h, 08h, 43h, 25h, 44h, 02h
	defb	00h, 00h, 00h, 00h, 52h, 52h, 25h, 04h
	defb	00h, 00h, 00h, 00h, 40h, 04h, 04h, 04h
	defb	00h, 0c8h, 08h, 00h, 00h, 10h, 00h, 00h
	defb	00h, 0cch, 0ch, 00h, 00h, 11h, 01h, 00h
	defb	80h, 6ch, 8ch, 00h, 00h, 31h, 01h, 00h
	defb	0c0h, 0a2h, 0c2h, 00h, 10h, 22h, 12h, 00h
	defb	00h, 75h, 75h, 00h, 00h, 0a8h, 41h, 0ch
	defb	00h, 75h, 75h, 00h, 00h, 82h, 1eh, 02h
	defb	00h, 57h, 57h, 00h, 0c0h, 14h, 8ah, 00h
	defb	00h, 57h, 57h, 00h, 20h, 0e1h, 28h, 00h
	defb	80h, 77h, 77h, 08h, 80h, 2eh, 62h, 05h
	defb	80h, 77h, 77h, 08h, 50h, 26h, 0e2h, 08h
	defb	80h, 75h, 75h, 08h, 81h, 2eh, 62h, 05h
	defb	80h, 57h, 57h, 08h, 50h, 26h, 0e2h, 18h
	defb	0a8h, 0afh, 0efh, 08h, 10h, 73h, 0bfh, 00h
	defb	40h, 4eh, 0ceh, 00h, 32h, 0f7h, 0ffh, 02h
	defb	80h, 0feh, 0fah, 8ah, 00h, 0fbh, 37h, 01h
	defb	00h, 0ech, 0e4h, 04h, 20h, 0ffh, 7fh, 23h
	defb	0e8h, 0efh, 0efh, 08h, 30h, 0f7h, 37h, 00h
	defb	0c0h, 0ceh, 0ceh, 00h, 71h, 0ffh, 7fh, 01h
	defb	80h, 0beh, 0beh, 8eh, 00h, 73h, 7fh, 03h
	defb	00h, 6ch, 6ch, 0ch, 10h, 0f7h, 0ffh, 17h
	defb	0e4h, 0c0h, 0c2h, 00h, 32h, 02h, 61h, 69h
	defb	24h, 0cch, 0c2h, 00h, 32h, 02h, 61h, 69h
	defb	8ch, 0ceh, 0c2h, 00h, 00h, 03h, 61h, 69h
	defb	0a4h, 0c4h, 0c2h, 00h, 21h, 01h, 61h, 69h
