cseg

AsciiPattern: public AsciiPattern
	; ascii 30
	; " -0123456789ACEFGHIKMNOPRSTUVY"
	defb 00h,00h,00h,00h,44h,04h,00h,00h
	defb 1fh,0fh,11h,01h,00h,0fh,00h,01h
	defb 5dh,07h,11h,01h,55h,0fh,11h,01h
	defb 47h,0fh,00h,01h,57h,0dh,11h,01h
	defb 5fh,0dh,11h,01h,0d1h,03h,10h,00h
	defb 5fh,0fh,11h,01h,57h,0fh,11h,01h
	defb 9eh,0eh,01h,01h,1eh,0ah,10h,00h
	defb 5fh,01h,11h,01h,5fh,01h,01h,00h
	defb 1eh,0dh,10h,00h,4fh,0fh,01h,01h
	defb 0f1h,01h,11h,01h,4fh,0bh,01h,01h
	defb 6fh,0fh,01h,01h,1fh,0eh,01h,01h
	defb 1eh,0eh,10h,00h,5fh,07h,01h,00h
	defb 5fh,0ah,01h,01h,56h,0dh,11h,00h
	defb 0f1h,01h,10h,00h,0fh,0fh,11h,01h
	defb 0fh,0fh,10h,00h,0c3h,03h,10h,00h

CharPattern: public CharPattern
;	logo
	defb	00h, 0d8h, 00h, 0d8h, 33h, 0d8h, 00h, 0d8h
	defb	0cch, 0d8h, 00h, 0d8h, 0ffh, 0d8h, 00h, 0d8h
	defb	00h, 0d8h, 33h, 0d8h, 33h, 0d8h, 33h, 0d8h
	defb	0cch, 0d8h, 33h, 0d8h, 0ffh, 0d8h, 33h, 0d8h
	defb	00h, 0d8h, 0cch, 0d8h, 33h, 0d8h, 0cch, 0d8h
	defb	0cch, 0d8h, 0cch, 0d8h, 0ffh, 0d8h, 0cch, 0d8h
	defb	00h, 0d8h, 0ffh, 0d8h, 33h, 0d8h, 0ffh, 0d8h
	defb	0cch, 0d8h, 0ffh, 0d8h, 0ffh, 0d8h, 0ffh, 0d8h
; white
	defb 00h,0f8h,00h,0f8h
;	4dot
	defb	0f0h, 0d8h, 0aah, 0d8h, 0aah, 0d8h, 0fh, 0d8h
	defb	77h, 38h, 77h, 38h
;	8dot
	defb	0c4h, 0d8h, 0fch, 0d8h, 0cch, 0d8h, 04h, 0d8h
	defb	40h, 0d8h, 13h, 0d8h, 43h, 0d8h, 00h, 0f8h
;	sprite
	defb	80h, 0f8h, 0f5h, 0f8h, 7dh, 0f8h, 08h, 0f8h
	defb	10h, 0f8h, 3ch, 0f8h, 0c3h, 0f8h, 01h, 0f8h
	defb	00h, 0f8h, 0f5h, 0f8h, 0fdh, 0f8h, 00h, 0f8h
	defb	90h, 0f8h, 34h, 0f8h, 43h, 0f8h, 05h, 0f8h
	defb	00h, 0f8h, 75h, 0f8h, 7dh, 0f8h, 00h, 0f8h
	defb	00h, 0f8h, 0d0h, 0f8h, 0c1h, 0f8h, 00h, 0f8h
	defb	00h, 0f8h, 0f5h, 0f8h, 7dh, 0f8h, 00h, 0f8h
	defb	10h, 0f8h, 2dh, 0f8h, 43h, 0f8h, 05h, 0f8h
	defb	80h, 0f8h, 0d7h, 0f8h, 5fh, 0f8h, 08h, 0f8h
	defb	10h, 0f8h, 3ch, 0f8h, 0c3h, 0f8h, 01h, 0f8h
	defb	00h, 0f8h, 0dfh, 0f8h, 5fh, 0f8h, 00h, 0f8h
	defb	50h, 0f8h, 34h, 0f8h, 43h, 0f8h, 09h, 0f8h
	defb	00h, 0f8h, 0d7h, 0f8h, 57h, 0f8h, 00h, 0f8h
	defb	00h, 0f8h, 1ch, 0f8h, 0dh, 0f8h, 00h, 0f8h
	defb	00h, 0f8h, 0d7h, 0f8h, 5fh, 0f8h, 00h, 0f8h
	defb	50h, 0f8h, 34h, 0f8h, 0d2h, 0f8h, 01h, 0f8h
	defb	80h, 0f8h, 0b3h, 0f8h, 0bbh, 0f8h, 04h, 0f8h
	defb	00h, 0f8h, 35h, 0f8h, 0c3h, 0f8h, 00h, 0f8h
	defb	40h, 0f8h, 0bbh, 0f8h, 3bh, 0f8h, 08h, 0f8h
	defb	00h, 0f8h, 3ch, 0f8h, 53h, 0f8h, 00h, 0f8h
	defb	2ch, 0b8h, 3fh, 0b8h, 0efh, 0b8h, 8ch, 0b8h
	defb	50h, 0b8h, 59h, 0b8h, 59h, 0b8h, 09h, 0b8h
	defb	48h, 0b8h, 6eh, 0b8h, 0ceh, 0b8h, 08h, 0b8h
	defb	0a1h, 0b8h, 0a3h, 0b8h, 0b3h, 0b8h, 13h, 0b8h
	defb	0c8h, 0b8h, 0feh, 0b8h, 0f3h, 0b8h, 0c2h, 0b8h
	defb	90h, 0b8h, 95h, 0b8h, 95h, 0b8h, 05h, 0b8h
	defb	80h, 0b8h, 0ech, 0b8h, 0e6h, 0b8h, 84h, 0b8h
	defb	31h, 0b8h, 3bh, 0b8h, 3ah, 0b8h, 1ah, 0b8h
	defb	0a0h, 0b8h, 0a9h, 0b8h, 0a9h, 0b8h, 09h, 0b8h
	defb	73h, 0b8h, 0dah, 0b8h, 0adh, 0b8h, 37h, 0b8h
	defb	00h, 58h, 48h, 58h, 4ch, 58h, 00h, 58h
	defb	30h, 58h, 54h, 58h, 12h, 58h, 00h, 58h
	defb	1eh, 98h, 1fh, 98h, 0b3h, 98h, 0c3h, 98h
	defb	63h, 98h, 66h, 98h, 64h, 98h, 36h, 98h
