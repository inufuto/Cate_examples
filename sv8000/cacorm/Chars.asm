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
	defb	11h, 1fh, 88h, 8fh, 0f1h, 11h, 0f8h, 88h
	defb	88h, 88h, 11h, 11h, 0f0h, 00h, 00h, 0fh
	defb	33h, 0ffh, 0cch, 0ffh, 0ffh, 33h, 0ffh, 0cch
	defb	0cch, 0cch, 33h, 33h, 0ffh, 00h, 00h, 0ffh
;	8dot
	defb	37h, 27h, 8ch, 0cch, 77h, 6ch, 0eeh, 0c6h
	defb	37h, 27h, 8ch, 0cch, 7fh, 21h, 0edh, 0c8h
	defb	13h, 33h, 0ceh, 4eh, 77h, 36h, 0eeh, 63h
	defb	13h, 33h, 0ceh, 4eh, 7bh, 31h, 0efh, 48h
	defb	37h, 77h, 8ch, 0cch, 0f7h, 66h, 0eeh, 0c0h
	defb	37h, 77h, 8ch, 0cch, 0ffh, 60h, 0ech, 0cch
	defb	13h, 23h, 0ceh, 0aeh, 77h, 30h, 0feh, 66h
	defb	13h, 23h, 0ceh, 0aeh, 73h, 33h, 0ffh, 60h
	defb	27h, 2fh, 8ch, 0ceh, 73h, 10h, 0cch, 8ch
	defb	02h, 72h, 08h, 0cch, 7fh, 31h, 0ceh, 0cch
	defb	13h, 37h, 4eh, 4fh, 33h, 13h, 0ech, 80h
	defb	01h, 33h, 04h, 0e4h, 37h, 33h, 0efh, 0c8h
	defb	27h, 7fh, 8ch, 0ceh, 77h, 31h, 0cch, 80h
	defb	02h, 77h, 08h, 0cch, 0f7h, 73h, 0ech, 0c8h
	defb	13h, 27h, 4eh, 0afh, 33h, 10h, 0eeh, 0c8h
	defb	01h, 32h, 04h, 0eah, 73h, 31h, 0feh, 0ech
	defb	04h, 0d5h, 08h, 44h, 4eh, 00h, 0a5h, 52h
	defb	04h, 0b3h, 08h, 44h, 4eh, 00h, 0a5h, 52h
	defb	02h, 0bfh, 08h, 44h, 22h, 00h, 0a5h, 52h
	defb	04h, 0b5h, 08h, 44h, 0a4h, 00h, 0a5h, 52h
	defb	7ah, 0aah, 0efh, 15h, 8fh, 70h, 17h, 0e0h
	defb	0f8h, 88h, 0f1h, 11h, 88h, 8fh, 11h, 1fh
	defb	11h, 0f7h, 00h, 0ech, 32h, 40h, 88h, 40h
