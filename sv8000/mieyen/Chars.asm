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
;	point
	defb	22h, 22h, 0c2h, 4eh, 0aah, 0e2h, 0aeh, 0aeh
	defb	0eah, 0aeh
;	8dot
	defb	07h, 31h, 0ech, 0f4h, 30h, 06h, 84h, 84h
	defb	07h, 31h, 0ech, 0f4h, 34h, 01h, 84h, 28h
	defb	73h, 0f2h, 0eh, 0c8h, 12h, 12h, 0c0h, 06h
	defb	73h, 0f2h, 0eh, 0c8h, 12h, 41h, 0c2h, 08h
	defb	73h, 0f3h, 08h, 0e8h, 40h, 22h, 44h, 80h
	defb	73h, 0f3h, 08h, 0e8h, 44h, 20h, 40h, 88h
	defb	13h, 0f5h, 0c8h, 0e4h, 30h, 22h, 84h, 80h
	defb	13h, 0f5h, 0c8h, 0e4h, 34h, 20h, 80h, 88h
	defb	27h, 2fh, 8ch, 0ceh, 73h, 10h, 0cch, 8ch
	defb	02h, 72h, 08h, 0cch, 7fh, 31h, 0ceh, 0cch
	defb	13h, 37h, 4eh, 4fh, 33h, 13h, 0ech, 80h
	defb	01h, 33h, 04h, 0e4h, 37h, 33h, 0efh, 0c8h
	defb	27h, 7fh, 8ch, 0ceh, 77h, 31h, 0cch, 80h
	defb	02h, 77h, 08h, 0cch, 0f7h, 73h, 0ech, 0c8h
	defb	13h, 27h, 4eh, 0afh, 33h, 10h, 0eeh, 0c8h
	defb	01h, 32h, 04h, 0eah, 73h, 31h, 0feh, 0ech
	defb	00h, 12h, 00h, 0c8h, 54h, 30h, 48h, 00h
	defb	01h, 12h, 00h, 08h, 45h, 43h, 44h, 48h
	defb	00h, 01h, 00h, 08h, 10h, 00h, 80h, 00h
	defb	35h, 0f0h, 0ceh, 70h, 70h, 0f7h, 0e0h, 0feh
