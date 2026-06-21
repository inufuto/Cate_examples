cseg

AsciiPattern: public AsciiPattern
	; ascii 34
	; " -0123456789ABCDEGHIKLMNOPRSTUVWXY"
	defb 00h,00h,00h,00h,44h,04h,00h,00h
	defb 1fh,0fh,11h,01h,00h,0fh,00h,01h
	defb 5dh,07h,11h,01h,55h,0fh,11h,01h
	defb 47h,0fh,00h,01h,57h,0dh,11h,01h
	defb 5fh,0dh,11h,01h,0d1h,03h,10h,00h
	defb 5fh,0fh,11h,01h,57h,0fh,11h,01h
	defb 9eh,0eh,01h,01h,5fh,0ah,11h,00h
	defb 1eh,0ah,10h,00h,1fh,0eh,11h,00h
	defb 5fh,01h,11h,01h,1eh,0dh,10h,00h
	defb 4fh,0fh,01h,01h,0f1h,01h,11h,01h
	defb 4fh,0bh,01h,01h,0fh,00h,11h,01h
	defb 6fh,0fh,01h,01h,1fh,0eh,01h,01h
	defb 1eh,0eh,10h,00h,5fh,07h,01h,00h
	defb 5fh,0ah,01h,01h,56h,0dh,11h,00h
	defb 0f1h,01h,10h,00h,0fh,0fh,11h,01h
	defb 0fh,0fh,10h,00h,0cfh,0fh,01h,01h
	defb 4bh,0bh,01h,01h,0c3h,03h,10h,00h

CharPattern: public CharPattern
;	4dot
	defb	00h, 00h, 62h, 66h, 66h, 26h, 0f0h, 0eh
	defb	0f0h, 07h, 0a5h, 0a5h
;	8dot
	defb	80h, 0f5h, 7dh, 08h, 10h, 3ch, 0c3h, 01h
	defb	00h, 0f5h, 0fdh, 00h, 90h, 34h, 43h, 05h
	defb	00h, 75h, 7dh, 00h, 00h, 0d0h, 0c1h, 00h
	defb	00h, 0f5h, 7dh, 00h, 10h, 2dh, 43h, 05h
	defb	80h, 0d7h, 5fh, 08h, 10h, 3ch, 0c3h, 01h
	defb	00h, 0dfh, 5fh, 00h, 50h, 34h, 43h, 09h
	defb	00h, 0d7h, 57h, 00h, 00h, 1ch, 0dh, 00h
	defb	00h, 0d7h, 5fh, 00h, 50h, 34h, 0d2h, 01h
	defb	8ch, 0ach, 8ah, 44h, 23h, 53h, 15h, 22h
	defb	8ch, 8ch, 8ah, 24h, 23h, 33h, 15h, 06h
	defb	8ch, 0ch, 08h, 88h, 23h, 13h, 01h, 22h
	defb	8ch, 8ch, 86h, 44h, 23h, 13h, 15h, 06h
	defb	4ch, 0ach, 8ah, 44h, 13h, 53h, 15h, 22h
	defb	4ch, 0cch, 8ah, 06h, 13h, 13h, 15h, 42h
	defb	4ch, 8ch, 08h, 44h, 13h, 03h, 01h, 11h
	defb	4ch, 8ch, 8ah, 06h, 13h, 13h, 16h, 22h
	defb	80h, 0c3h, 3ch, 08h, 10h, 0beh, 0afh, 01h
	defb	44h, 0a8h, 0cah, 0c8h, 22h, 51h, 35h, 32h
	defb	60h, 69h, 68h, 69h, 0c0h, 36h, 3fh, 0c6h
	defb	0c0h, 3eh, 3fh, 0ceh, 0c0h, 37h, 3fh, 0c7h
	defb	0f0h, 0ffh, 7fh, 0fh, 0f0h, 0ffh, 0efh, 0fh
	defb	20h, 84h, 8eh, 24h, 90h, 35h, 3fh, 95h
	defb	0f0h, 1fh, 1fh, 0efh, 70h, 07h, 07h, 77h
	defb	0c0h, 3eh, 31h, 0ceh, 70h, 17h, 11h, 77h
	defb	10h, 91h, 7dh, 13h, 60h, 57h, 44h, 44h
	defb	70h, 8fh, 0f8h, 07h, 00h, 70h, 07h, 00h
