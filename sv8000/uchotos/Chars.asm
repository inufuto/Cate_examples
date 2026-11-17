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
	defb	47h, 47h, 2eh, 2eh, 0ffh, 0f0h
;	8dot
	defb	11h, 0f7h, 00h, 0ech, 32h, 40h, 88h, 40h
;	sprite
	defb	31h, 35h, 0c4h, 0cah, 51h, 22h, 0a8h, 44h
	defb	31h, 31h, 0c4h, 0cch, 51h, 24h, 0a8h, 60h
	defb	31h, 30h, 0c4h, 0c8h, 10h, 11h, 80h, 44h
	defb	31h, 31h, 0c4h, 0c8h, 61h, 22h, 0a8h, 60h
	defb	32h, 35h, 0c8h, 0cah, 51h, 22h, 0a8h, 44h
	defb	32h, 33h, 0c8h, 0c8h, 51h, 60h, 0a8h, 42h
	defb	32h, 31h, 0c8h, 0c0h, 10h, 22h, 80h, 88h
	defb	32h, 31h, 0c8h, 0c8h, 51h, 60h, 68h, 44h
	defb	33h, 05h, 0cch, 2ch, 31h, 20h, 88h, 44h
	defb	33h, 43h, 0cch, 0ah, 11h, 22h, 0c8h, 40h
	defb	37h, 0aah, 8ch, 0efh, 70h, 52h, 0e0h, 4ah
	defb	03h, 7ah, 08h, 0ceh, 0a7h, 05h, 0feh, 04h
	defb	13h, 7fh, 0ceh, 55h, 70h, 25h, 0e0h, 0a4h
	defb	01h, 37h, 0ch, 0e5h, 0f7h, 02h, 5eh, 0ah
	defb	25h, 07h, 0a4h, 0eh, 0deh, 53h, 0b7h, 0ach
	defb	00h, 12h, 00h, 0c8h, 54h, 30h, 48h, 00h
	defb	7ah, 0aah, 0eeh, 15h, 8fh, 70h, 17h, 0e0h
