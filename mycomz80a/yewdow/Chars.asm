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
	defb	0a0h, 0bfh, 0efh, 00h, 0f8h, 37h, 0f7h, 0bh
	defb	0a0h, 0bfh, 0efh, 00h, 32h, 0b7h, 7fh, 21h
	defb	00h, 0feh, 0fbh, 0ah, 0b0h, 7fh, 73h, 8fh
	defb	00h, 0feh, 0fbh, 0ah, 12h, 0f7h, 7bh, 23h
	defb	0e0h, 0ffh, 0efh, 00h, 0f1h, 3fh, 77h, 03h
	defb	0e0h, 0ffh, 0efh, 00h, 73h, 37h, 0ffh, 01h
	defb	00h, 0beh, 0bfh, 0eh, 30h, 77h, 0f3h, 1fh
	defb	00h, 0beh, 0bfh, 0eh, 10h, 0ffh, 73h, 37h
	defb	0a8h, 0afh, 0efh, 08h, 10h, 73h, 0bfh, 00h
	defb	40h, 4eh, 0ceh, 00h, 32h, 0f7h, 0ffh, 02h
	defb	80h, 0feh, 0fah, 8ah, 00h, 0fbh, 37h, 01h
	defb	00h, 0ech, 0e4h, 04h, 20h, 0ffh, 7fh, 23h
	defb	0e8h, 0efh, 0efh, 08h, 30h, 0f7h, 37h, 00h
	defb	0c0h, 0ceh, 0ceh, 00h, 71h, 0ffh, 7fh, 01h
	defb	80h, 0beh, 0beh, 8eh, 00h, 73h, 7fh, 03h
	defb	00h, 6ch, 6ch, 0ch, 10h, 0f7h, 0ffh, 17h
	defb	00h, 2ch, 2eh, 84h, 0b7h, 7bh, 0b7h, 7bh
	defb	48h, 0e2h, 0c2h, 00h, 0b7h, 7bh, 0b7h, 7bh
	defb	0c0h, 22h, 22h, 0ch, 0d7h, 57h, 75h, 7dh
	defb	0c0h, 22h, 22h, 0ch, 0f5h, 67h, 76h, 5fh
	defb	80h, 0ech, 8ah, 08h, 10h, 73h, 15h, 01h
	defb	80h, 0a8h, 0ceh, 08h, 10h, 51h, 37h, 01h
	defb	80h, 0ech, 0ceh, 08h, 10h, 70h, 07h, 01h
	defb	80h, 0e0h, 0eh, 08h, 10h, 73h, 37h, 01h
	defb	00h, 0afh, 0a5h, 05h, 80h, 8fh, 00h, 00h
	defb	00h, 0ffh, 37h, 01h, 80h, 8fh, 00h, 00h
	defb	00h, 1fh, 0a1h, 04h, 80h, 9fh, 01h, 00h
	defb	00h, 0ffh, 0ceh, 08h, 80h, 8fh, 00h, 00h
	defb	0e4h, 0c0h, 0c2h, 00h, 32h, 02h, 61h, 69h
	defb	24h, 0cch, 0c2h, 00h, 32h, 02h, 61h, 69h
	defb	8ch, 0ceh, 0c2h, 00h, 00h, 03h, 61h, 69h
	defb	0a4h, 0c4h, 0c2h, 00h, 21h, 01h, 61h, 69h
	defb	1fh, 11h, 11h, 0f1h, 8fh, 88h, 88h, 0f8h
	defb	0c0h, 0d6h, 0efh, 84h, 0b7h, 0f7h, 0b6h, 35h
	defb	0ffh, 0ffh, 0ffh, 0ffh, 0ffh, 0ffh, 0ffh, 0ffh
