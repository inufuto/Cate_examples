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
;	wall
	defb	00h, 00h, 0fh, 00h, 00h, 0f0h, 0fh, 0f0h
	defb	11h, 11h, 1eh, 11h, 11h, 0e1h, 1eh, 0e1h
	defb	88h, 88h, 87h, 88h, 88h, 78h, 87h, 78h
	defb	99h, 99h, 96h, 99h, 99h, 69h, 96h, 69h
;	point
	defb	00h, 0fh, 0d9h, 0ah, 47h, 0fh, 0afh, 0fh
	defb	9fh, 0fh
;	8dot
	defb	20h, 0e6h, 0f7h, 45h, 80h, 19h, 0a5h, 00h
	defb	20h, 0e6h, 0f7h, 45h, 20h, 91h, 29h, 04h
	defb	54h, 7fh, 6eh, 02h, 00h, 5ah, 91h, 08h
	defb	54h, 7fh, 6eh, 02h, 40h, 92h, 19h, 02h
	defb	54h, 0ffh, 4eh, 04h, 10h, 0ch, 34h, 00h
	defb	54h, 0ffh, 4eh, 04h, 30h, 04h, 1ch, 00h
	defb	0c4h, 0f6h, 0d7h, 04h, 00h, 1dh, 25h, 00h
	defb	0c4h, 0f6h, 0d7h, 04h, 20h, 15h, 0dh, 00h
	defb	0a8h, 0afh, 0efh, 08h, 10h, 73h, 0bfh, 00h
	defb	40h, 4eh, 0ceh, 00h, 32h, 0f7h, 0ffh, 02h
	defb	80h, 0feh, 0fah, 8ah, 00h, 0fbh, 37h, 01h
	defb	00h, 0ech, 0e4h, 04h, 20h, 0ffh, 7fh, 23h
	defb	0e8h, 0efh, 0efh, 08h, 30h, 0f7h, 37h, 00h
	defb	0c0h, 0ceh, 0ceh, 00h, 71h, 0ffh, 7fh, 01h
	defb	80h, 0beh, 0beh, 8eh, 00h, 73h, 7fh, 03h
	defb	00h, 6ch, 6ch, 0ch, 10h, 0f7h, 0ffh, 17h
	defb	00h, 48h, 4ch, 00h, 30h, 54h, 12h, 00h
	defb	00h, 68h, 08h, 00h, 70h, 0a8h, 78h, 00h
	defb	00h, 80h, 08h, 00h, 00h, 10h, 01h, 00h
	defb	64h, 75h, 73h, 46h, 0d4h, 0ddh, 0ddh, 4dh
