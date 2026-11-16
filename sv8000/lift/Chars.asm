cseg

AsciiPattern: public AsciiPattern
	; ascii 28
	; " 0123456789:ACEFGHIMNOPRSTUV"
	defb 00h,00h,00h,0eah,0aah,0e0h,22h,22h
	defb 20h,0e2h,0e8h,0e0h,0e2h,0e2h,0e0h,0aah
	defb 0e2h,20h,0e8h,0e2h,0e0h,0e8h,0eah,0e0h
	defb 0e2h,44h,40h,0eah,0eah,0e0h,0eah,0e2h
	defb 0e0h,04h,04h,00h,4ah,0aeh,0a0h,4ah
	defb 8ah,40h,0e8h,0c8h,0e0h,0e8h,0c8h,80h
	defb 68h,0aah,40h,0aah,0eah,0a0h,0e4h,44h
	defb 0e0h,0aeh,0eah,0a0h,0cah,0aah,0a0h,4ah
	defb 0aah,40h,0eah,0e8h,80h,0cah,0cah,0a0h
	defb 68h,0e2h,0c0h,0e4h,44h,40h,0aah,0aah
	defb 0e0h,0aah,0aah,40h

CharPattern: public CharPattern
;	logo
	defb	00h, 00h, 0cch, 00h, 00h, 0cch, 0cch, 0cch
	defb	33h, 00h, 0ffh, 00h, 33h, 0cch, 0ffh, 0cch
	defb	00h, 33h, 0cch, 33h, 00h, 0ffh, 0cch, 0ffh
	defb	33h, 33h, 0ffh, 33h, 33h, 0ffh, 0ffh, 0ffh
;	4dot
	defb	0ffh, 00h, 0a5h, 0a5h, 0ffh, 0ffh, 37h, 0ffh
	defb	0ceh, 0ffh
;	8dot
	defb	31h, 31h, 0c4h, 0cch, 51h, 24h, 0a8h, 60h
	defb	31h, 30h, 0c4h, 0c8h, 10h, 11h, 80h, 44h
	defb	31h, 31h, 0c4h, 0c8h, 61h, 22h, 0a8h, 60h
	defb	31h, 35h, 0c4h, 0cah, 51h, 22h, 0a8h, 44h
	defb	32h, 33h, 0c8h, 0c8h, 51h, 60h, 0a8h, 42h
	defb	32h, 31h, 0c8h, 0c0h, 10h, 22h, 80h, 88h
	defb	32h, 31h, 0c8h, 0c8h, 51h, 60h, 68h, 44h
	defb	32h, 35h, 0c8h, 0cah, 51h, 22h, 0a8h, 44h
	defb	01h, 0ebh, 08h, 3ch, 0fah, 10h, 0c3h, 80h
	defb	22h, 15h, 44h, 8ah, 53h, 23h, 0ach, 8ch
	defb	01h, 0c3h, 08h, 5fh, 3ch, 10h, 0d7h, 80h
	defb	27h, 2fh, 8ch, 0ceh, 73h, 10h, 0cch, 8ch
	defb	02h, 72h, 08h, 0cch, 7fh, 31h, 0ceh, 0cch
	defb	13h, 37h, 4eh, 4fh, 33h, 13h, 0ech, 80h
	defb	01h, 33h, 04h, 0e4h, 37h, 33h, 0efh, 0c8h
	defb	0f8h, 84h, 0f1h, 12h, 30h, 00h, 0c0h, 00h
	defb	04h, 0d5h, 08h, 44h, 4eh, 00h, 0a5h, 52h
	defb	04h, 0b3h, 08h, 44h, 4eh, 00h, 0a5h, 52h
	defb	02h, 0bfh, 08h, 44h, 22h, 00h, 0a5h, 52h
	defb	04h, 0b5h, 08h, 44h, 0a4h, 00h, 0a5h, 52h
	defb	23h, 23h, 0a4h, 0a4h, 22h, 27h, 00h, 00h
	defb	33h, 33h, 0ech, 80h, 22h, 27h, 00h, 00h
	defb	32h, 22h, 84h, 24h, 32h, 27h, 80h, 00h
	defb	33h, 33h, 08h, 0ceh, 22h, 27h, 00h, 00h
