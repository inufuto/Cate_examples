cseg

AsciiPattern: public AsciiPattern
	; ascii 31
	; " 0123456789ABCEFGHIKLMNOPRSTUVY"
	defb 00h,00h,00h,00h,0eah,0aah,0e0h,00h
	defb 22h,22h,20h,00h,0e2h,0e8h,0e0h,00h
	defb 0e2h,0e2h,0e0h,00h,0aah,0e2h,20h,00h
	defb 0e8h,0e2h,0e0h,00h,0e8h,0eah,0e0h,00h
	defb 0e2h,44h,40h,00h,0eah,0eah,0e0h,00h
	defb 0eah,0e2h,0e0h,00h,4ah,0aeh,0a0h,00h
	defb 0cah,0cah,0c0h,00h,4ah,8ah,40h,00h
	defb 0e8h,0c8h,0e0h,00h,0e8h,0c8h,80h,00h
	defb 68h,0aah,40h,00h,0aah,0eah,0a0h,00h
	defb 0e4h,44h,0e0h,00h,0aah,0cah,0a0h,00h
	defb 88h,88h,0e0h,00h,0aeh,0eah,0a0h,00h
	defb 0cah,0aah,0a0h,00h,4ah,0aah,40h,00h
	defb 0eah,0e8h,80h,00h,0cah,0cah,0a0h,00h
	defb 68h,0e2h,0c0h,00h,0e4h,44h,40h,00h
	defb 0aah,0aah,0e0h,00h,0aah,0aah,40h,00h
	defb 0aah,44h,40h,00h

CharPattern: public CharPattern
;	logo
	defb	00h, 00h, 0cch, 00h, 00h, 0cch, 0cch, 0cch
	defb	33h, 00h, 0ffh, 00h, 33h, 0cch, 0ffh, 0cch
	defb	00h, 33h, 0cch, 33h, 00h, 0ffh, 0cch, 0ffh
	defb	33h, 33h, 0ffh, 33h, 33h, 0ffh, 0ffh, 0ffh
;	8dot
	defb	0f8h, 88h, 0f1h, 11h, 88h, 8fh, 11h, 1fh
	defb	03h, 0d6h, 0ceh, 0ffh, 0ach, 62h, 0c3h, 0fch
	defb	00h, 05h, 06h, 0ech, 37h, 20h, 80h, 80h
;	sprite
	defb	30h, 20h, 0c4h, 0c0h, 22h, 06h, 00h, 62h
	defb	30h, 20h, 0c4h, 0c0h, 15h, 01h, 88h, 08h
	defb	70h, 50h, 88h, 80h, 0b3h, 06h, 00h, 0c4h
	defb	00h, 00h, 00h, 00h, 31h, 00h, 0ffh, 00h
	defb	32h, 30h, 0c0h, 40h, 10h, 64h, 0ch, 06h
	defb	32h, 30h, 0c0h, 40h, 21h, 01h, 2ah, 08h
	defb	11h, 10h, 0e0h, 0a0h, 00h, 32h, 70h, 06h
	defb	00h, 00h, 00h, 00h, 0ffh, 00h, 0c8h, 00h
	defb	33h, 30h, 0cch, 0c0h, 51h, 22h, 0aah, 40h
	defb	33h, 30h, 0cch, 0c0h, 55h, 20h, 0a8h, 44h
	defb	33h, 30h, 0cch, 0c0h, 55h, 22h, 88h, 44h
	defb	00h, 00h, 00h, 8ch, 00h, 00h, 0cch, 0cch
	defb	30h, 20h, 0c4h, 0c0h, 51h, 22h, 0aah, 40h
	defb	32h, 30h, 0c0h, 40h, 55h, 20h, 0a8h, 44h
	defb	00h, 30h, 00h, 0c4h, 24h, 42h, 0a2h, 04h
	defb	33h, 33h, 00h, 00h, 31h, 00h, 00h, 00h
	defb	31h, 32h, 0c4h, 0c8h, 01h, 06h, 00h, 62h
	defb	31h, 32h, 0c4h, 0c8h, 04h, 01h, 02h, 88h
	defb	32h, 31h, 0c8h, 0c4h, 00h, 64h, 08h, 06h
	defb	32h, 31h, 0c8h, 0c4h, 04h, 11h, 02h, 08h
	defb	33h, 34h, 0cch, 0c2h, 00h, 22h, 20h, 40h
	defb	33h, 34h, 0cch, 0c2h, 40h, 20h, 00h, 44h
	defb	31h, 32h, 0c4h, 0cah, 00h, 22h, 20h, 40h
	defb	32h, 35h, 0c8h, 0c4h, 40h, 20h, 00h, 44h
	defb	5fh, 0d7h, 6bh, 0e7h, 0f6h, 0f5h, 0beh, 0dah
	defb	04h, 0d5h, 08h, 44h, 4eh, 00h, 0a5h, 52h
	defb	04h, 0b3h, 08h, 44h, 4eh, 00h, 0a5h, 52h
	defb	02h, 0bbh, 08h, 44h, 0e2h, 00h, 0a5h, 52h
	defb	04h, 0b5h, 08h, 44h, 0a4h, 00h, 0a5h, 52h
	defb	7ah, 0aah, 0eeh, 15h, 8fh, 70h, 17h, 0e0h
