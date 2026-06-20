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
	defb	1fh, 11h, 11h, 0f1h, 8fh, 88h, 88h, 0f8h
	defb	0c4h, 6ah, 0ffh, 0ceh, 63h, 0dh, 0ddh, 66h
	defb	80h, 80h, 0ech, 06h, 20h, 37h, 05h, 00h
;	sprite
	defb	00h, 15h, 75h, 00h, 80h, 0bh, 40h, 0ch
	defb	00h, 15h, 75h, 00h, 20h, 0b0h, 0bh, 00h
	defb	50h, 51h, 07h, 00h, 81h, 3bh, 0c4h, 00h
	defb	00h, 00h, 00h, 00h, 00h, 31h, 33h, 33h
	defb	00h, 57h, 51h, 00h, 0c0h, 14h, 0a2h, 08h
	defb	00h, 57h, 51h, 00h, 00h, 0a1h, 0ah, 03h
	defb	00h, 70h, 15h, 05h, 00h, 4ch, 90h, 19h
	defb	00h, 00h, 00h, 00h, 33h, 33h, 13h, 00h
	defb	00h, 77h, 77h, 00h, 10h, 3ch, 43h, 03h
	defb	00h, 77h, 77h, 00h, 30h, 34h, 0c3h, 01h
	defb	00h, 77h, 77h, 00h, 30h, 3ch, 0c3h, 00h
	defb	00h, 00h, 8ch, 00h, 00h, 00h, 0ffh, 00h
	defb	00h, 15h, 75h, 00h, 10h, 3ch, 43h, 03h
	defb	00h, 57h, 51h, 00h, 30h, 34h, 0c3h, 01h
	defb	00h, 44h, 0c4h, 00h, 60h, 09h, 81h, 03h
	defb	00h, 0ffh, 00h, 00h, 00h, 31h, 00h, 00h
	defb	00h, 7dh, 7dh, 00h, 80h, 28h, 40h, 0ch
	defb	00h, 7dh, 7dh, 00h, 20h, 80h, 0ch, 02h
	defb	00h, 0d7h, 0d7h, 00h, 0c0h, 04h, 82h, 08h
	defb	00h, 0d7h, 0d7h, 00h, 20h, 0c0h, 08h, 02h
	defb	80h, 77h, 77h, 08h, 00h, 0ch, 40h, 01h
	defb	80h, 77h, 77h, 08h, 10h, 04h, 0c0h, 00h
	defb	00h, 7dh, 7dh, 08h, 00h, 0ch, 40h, 01h
	defb	80h, 0d7h, 0d7h, 00h, 10h, 04h, 0c0h, 00h
	defb	0f6h, 0fah, 0d6h, 0afh, 0f5h, 0d7h, 6fh, 5bh
	defb	0e4h, 0c0h, 0c2h, 00h, 32h, 02h, 61h, 69h
	defb	24h, 0cch, 0c2h, 00h, 32h, 02h, 61h, 69h
	defb	0ch, 0ceh, 0c2h, 00h, 11h, 03h, 61h, 69h
	defb	0a4h, 0c4h, 0c2h, 00h, 21h, 01h, 61h, 69h
	defb	1eh, 1fh, 0b3h, 0c3h, 63h, 66h, 64h, 36h
