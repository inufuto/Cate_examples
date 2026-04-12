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
;	4dot
	defb	00h, 38h, 00h, 38h, 00h, 0f8h, 00h, 0f8h
;	logo
	defb	00h, 0d8h, 00h, 0d8h, 33h, 0d8h, 00h, 0b8h
	defb	0cch, 0d8h, 00h, 0b8h, 0ffh, 0d8h, 00h, 0b8h
	defb	00h, 0b8h, 33h, 0d8h, 33h, 0d8h, 33h, 0d8h
	defb	0cch, 0d8h, 33h, 0d8h, 0ffh, 0d8h, 33h, 0d8h
	defb	00h, 0b8h, 0cch, 0d8h, 33h, 0d8h, 0cch, 0d8h
	defb	0cch, 0d8h, 0cch, 0d8h, 0ffh, 0d8h, 0cch, 0d8h
	defb	00h, 0b8h, 0ffh, 0d8h, 33h, 0d8h, 0ffh, 0d8h
	defb	0cch, 0d8h, 0ffh, 0d8h, 0ffh, 0d8h, 0ffh, 0d8h
;	8dot
	defb	5bh, 38h, 5eh, 38h, 5bh, 38h, 96h, 38h
	defb	69h, 38h, 5eh, 38h, 69h, 38h, 0b5h, 38h
	defb	0c4h, 58h, 6ah, 58h, 0ffh, 58h, 0ceh, 58h
	defb	63h, 58h, 0dh, 58h, 0ddh, 58h, 66h, 58h
	defb	3eh, 0d8h, 99h, 0d8h, 0ddh, 0d8h, 0e1h, 0d8h
	defb	0c7h, 0d8h, 0b9h, 0d8h, 8bh, 0d8h, 7ch, 0d8h
;	sprite
	defb	00h, 0b8h, 15h, 0b8h, 75h, 0b8h, 00h, 0b8h
	defb	80h, 0b8h, 0bh, 0b8h, 40h, 0b8h, 0ch, 0b8h
	defb	00h, 0b8h, 15h, 0b8h, 75h, 0b8h, 00h, 0b8h
	defb	20h, 0b8h, 0b0h, 0b8h, 0bh, 0b8h, 00h, 0b8h
	defb	50h, 0b8h, 51h, 0b8h, 07h, 0b8h, 00h, 0b8h
	defb	81h, 0b8h, 3bh, 0b8h, 0c4h, 0b8h, 00h, 0b8h
	defb	00h, 0f8h, 00h, 0f8h, 00h, 0f8h, 00h, 0f8h
	defb	00h, 0f8h, 31h, 0f8h, 33h, 0f8h, 33h, 0f8h
	defb	00h, 0b8h, 57h, 0b8h, 51h, 0b8h, 00h, 0b8h
	defb	0c0h, 0b8h, 14h, 0b8h, 0a2h, 0b8h, 08h, 0b8h
	defb	00h, 0b8h, 57h, 0b8h, 51h, 0b8h, 00h, 0b8h
	defb	00h, 0b8h, 0a1h, 0b8h, 0ah, 0b8h, 03h, 0b8h
	defb	00h, 0b8h, 70h, 0b8h, 15h, 0b8h, 05h, 0b8h
	defb	00h, 0b8h, 4ch, 0b8h, 90h, 0b8h, 19h, 0b8h
	defb	00h, 0f8h, 00h, 0f8h, 00h, 0f8h, 00h, 0f8h
	defb	33h, 0f8h, 33h, 0f8h, 13h, 0f8h, 00h, 0f8h
	defb	00h, 0b8h, 77h, 0b8h, 77h, 0b8h, 00h, 0b8h
	defb	10h, 0b8h, 3ch, 0b8h, 43h, 0b8h, 03h, 0b8h
	defb	00h, 0b8h, 77h, 0b8h, 77h, 0b8h, 00h, 0b8h
	defb	30h, 0b8h, 34h, 0b8h, 0c3h, 0b8h, 01h, 0b8h
	defb	00h, 0b8h, 77h, 0b8h, 77h, 0b8h, 00h, 0b8h
	defb	30h, 0b8h, 3ch, 0b8h, 0c3h, 0b8h, 00h, 0b8h
	defb	00h, 0f8h, 00h, 0f8h, 8ch, 0f8h, 00h, 0f8h
	defb	00h, 0f8h, 00h, 0f8h, 0ffh, 0f8h, 00h, 0f8h
	defb	00h, 0b8h, 15h, 0b8h, 75h, 0b8h, 00h, 0b8h
	defb	10h, 0b8h, 3ch, 0b8h, 43h, 0b8h, 03h, 0b8h
	defb	00h, 0b8h, 57h, 0b8h, 51h, 0b8h, 00h, 0b8h
	defb	30h, 0b8h, 34h, 0b8h, 0c3h, 0b8h, 01h, 0b8h
	defb	00h, 0b8h, 44h, 0b8h, 0c4h, 0b8h, 00h, 0b8h
	defb	60h, 0b8h, 09h, 0b8h, 81h, 0b8h, 03h, 0b8h
	defb	00h, 0f8h, 0ffh, 0f8h, 00h, 0f8h, 00h, 0f8h
	defb	00h, 0f8h, 31h, 0f8h, 00h, 0f8h, 00h, 0f8h
	defb	00h, 0f8h, 7dh, 0f8h, 7dh, 0f8h, 00h, 0f8h
	defb	80h, 0f8h, 28h, 0f8h, 40h, 0f8h, 0ch, 0f8h
	defb	00h, 0f8h, 7dh, 0f8h, 7dh, 0f8h, 00h, 0f8h
	defb	20h, 0f8h, 80h, 0f8h, 0ch, 0f8h, 02h, 0f8h
	defb	00h, 0f8h, 0d7h, 0f8h, 0d7h, 0f8h, 00h, 0f8h
	defb	0c0h, 0f8h, 04h, 0f8h, 82h, 0f8h, 08h, 0f8h
	defb	00h, 0f8h, 0d7h, 0f8h, 0d7h, 0f8h, 00h, 0f8h
	defb	20h, 0f8h, 0c0h, 0f8h, 08h, 0f8h, 02h, 0f8h
	defb	80h, 0f8h, 77h, 0f8h, 77h, 0f8h, 08h, 0f8h
	defb	00h, 0f8h, 0ch, 0f8h, 40h, 0f8h, 01h, 0f8h
	defb	80h, 0f8h, 77h, 0f8h, 77h, 0f8h, 08h, 0f8h
	defb	10h, 0f8h, 04h, 0f8h, 0c0h, 0f8h, 00h, 0f8h
	defb	00h, 0f8h, 7dh, 0f8h, 7dh, 0f8h, 08h, 0f8h
	defb	00h, 0f8h, 0ch, 0f8h, 40h, 0f8h, 01h, 0f8h
	defb	80h, 0f8h, 0d7h, 0f8h, 0d7h, 0f8h, 00h, 0f8h
	defb	10h, 0f8h, 04h, 0f8h, 0c0h, 0f8h, 00h, 0f8h
	defb	0f6h, 0f8h, 0fah, 0f8h, 0d6h, 0f8h, 0afh, 0f8h
	defb	0f5h, 0f8h, 0d7h, 0f8h, 6fh, 0f8h, 5bh, 0f8h
	defb	0e4h, 0f8h, 0c0h, 0f8h, 0c2h, 0f8h, 00h, 0f8h
	defb	32h, 0f8h, 02h, 0f8h, 61h, 0f8h, 69h, 0f8h
	defb	24h, 0f8h, 0cch, 0f8h, 0c2h, 0f8h, 00h, 0f8h
	defb	32h, 0f8h, 02h, 0f8h, 61h, 0f8h, 69h, 0f8h
	defb	0ch, 0f8h, 0ceh, 0f8h, 0c2h, 0f8h, 00h, 0f8h
	defb	11h, 0f8h, 03h, 0f8h, 61h, 0f8h, 69h, 0f8h
	defb	0a4h, 0f8h, 0c4h, 0f8h, 0c2h, 0f8h, 00h, 0f8h
	defb	21h, 0f8h, 01h, 0f8h, 61h, 0f8h, 69h, 0f8h
	defb	1eh, 98h, 1fh, 98h, 0b3h, 98h, 0c3h, 98h
	defb	63h, 98h, 66h, 98h, 64h, 98h, 36h, 98h
; white
	defb 20h,0f8h,0f4h,0f8h,24h,0f8h,00h,0f8h
