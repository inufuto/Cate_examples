cseg

MonoPattern: public MonoPattern
; ascii 30
	; " -0123456789ACEFGHIKMNOPRSTUVY"
	defb 00h,00h,00h,00h,00h,0eh,00h,00h
	defb 4ah,0aah,0aah,40h,44h,44h,44h,40h
	defb 4ah,22h,48h,0e0h,4ah,24h,2ah,40h
	defb 2ah,0aeh,22h,20h,0e8h,8ch,22h,0c0h
	defb 4ah,8ch,0aah,40h,0eah,22h,44h,40h
	defb 4ah,0a4h,0aah,40h,4ah,0a6h,2ah,40h
	defb 4ah,0aah,0eah,0a0h,4ah,88h,8ah,40h
	defb 0e8h,8ch,88h,0e0h,0e8h,8ch,88h,80h
	defb 68h,8ah,0aah,40h,0aah,0aeh,0aah,0a0h
	defb 0e4h,44h,44h,0e0h,0aeh,0c8h,0ceh,0a0h
	defb 0aeh,0eeh,0aah,0a0h,0cah,0aah,0aah,0a0h
	defb 4ah,0aah,0aah,40h,0cah,0aah,0c8h,80h
	defb 0cah,0aah,0cah,0a0h,4ah,84h,2ah,40h
	defb 0e4h,44h,44h,40h,0aah,0aah,0aah,0e0h
	defb 0aah,0aah,0a4h,40h,0aah,0a4h,44h,40h
;	logo
	defb	0cch, 0cch, 00h, 00h, 00h, 00h, 0cch, 0cch
	defb	0cch, 0cch, 0cch, 0cch, 33h, 33h, 00h, 00h
	defb	0ffh, 0ffh, 00h, 00h, 33h, 33h, 0cch, 0cch
	defb	0ffh, 0ffh, 0cch, 0cch, 00h, 00h, 33h, 33h
	defb	0cch, 0cch, 33h, 33h, 00h, 00h, 0ffh, 0ffh
	defb	0cch, 0cch, 0ffh, 0ffh, 33h, 33h, 33h, 33h
	defb	0ffh, 0ffh, 33h, 33h, 33h, 33h, 0ffh, 0ffh
	defb	0ffh, 0ffh, 0ffh, 0ffh
;	fence
	defb	00h, 00h, 00h, 0fh, 0f0h, 00h, 00h, 00h
;	mono16
	defb	0d9h, 0a7h, 76h, 9dh, 0ddh, 0a6h, 69h, 0dbh
	defb	0d9h, 67h, 7ah, 0adh, 0bbh, 56h, 6ah, 0ddh

ColorPattern: public ColorPattern
;	color16
	defb	00h, 00h, 00h, 05h, 00h, 0fh, 05h, 0fh
	defb	1fh, 0fh, 1fh, 2fh, 2fh, 2fh, 2fh, 2fh
	defb	0fh, 00h, 0fh, 00h, 0fh, 0ah, 0fh, 0ah
	defb	0fh, 0fh, 0fh, 0fh, 0fh, 0fh, 0fh, 0fh
	defb	1fh, 1fh, 1fh, 1fh, 0fh, 3fh, 0fh, 3fh
	defb	05h, 1fh, 05h, 1fh, 00h, 1fh, 00h, 1fh
	defb	0fh, 1fh, 0fh, 3fh, 1fh, 2fh, 3fh, 0fh
	defb	2fh, 0fh, 0fh, 0ah, 0fh, 00h, 0ah, 00h
	defb	0ch, 0ch, 09h, 03h, 09h, 03h, 09h, 03h
	defb	09h, 03h, 09h, 03h, 09h, 03h, 09h, 03h
	defb	0ch, 0ch, 03h, 06h, 03h, 0aeh, 03h, 0aeh
	defb	57h, 0aeh, 57h, 06h, 0ffh, 06h, 0ffh, 06h
	defb	09h, 57h, 18h, 57h, 18h, 75h, 09h, 30h
	defb	09h, 30h, 09h, 21h, 09h, 03h, 0ch, 0ch
	defb	0abh, 06h, 0abh, 06h, 03h, 06h, 03h, 06h
	defb	21h, 06h, 21h, 06h, 03h, 06h, 0ch, 0ch

SpritePattern: public SpritePattern
;	sprite
	defb	00h, 00h, 00h, 51h, 00h, 0f3h, 00h, 03h
	defb	00h, 0a3h, 00h, 0a3h, 00h, 0f3h, 00h, 01h
	defb	00h, 00h, 0a2h, 00h, 0f3h, 00h, 53h, 00h
	defb	0f3h, 00h, 0f3h, 00h, 0f3h, 00h, 02h, 00h
	defb	00h, 0bh, 00h, 5bh, 00h, 5bh, 00h, 0bh
	defb	00h, 0bh, 00h, 51h, 00h, 0a2h, 51h, 0a2h
	defb	0a2h, 00h, 0a2h, 00h, 02h, 00h, 0a2h, 00h
	defb	53h, 00h, 51h, 00h, 00h, 0a2h, 51h, 0a2h
	defb	00h, 00h, 00h, 51h, 00h, 0f3h, 00h, 03h
	defb	00h, 0a3h, 00h, 0a3h, 00h, 0f3h, 00h, 01h
	defb	00h, 00h, 0a2h, 00h, 0f3h, 00h, 53h, 00h
	defb	0f3h, 00h, 0f3h, 00h, 0f3h, 00h, 02h, 00h
	defb	00h, 05h, 55h, 07h, 00h, 05h, 00h, 05h
	defb	00h, 05h, 00h, 00h, 00h, 00h, 00h, 51h
	defb	0ah, 00h, 0ah, 00h, 0ah, 00h, 0ah, 00h
	defb	0ah, 00h, 02h, 00h, 0a2h, 00h, 0a2h, 00h
	defb	00h, 00h, 00h, 0f3h, 51h, 0f3h, 01h, 03h
	defb	51h, 53h, 51h, 53h, 51h, 0f3h, 00h, 03h
	defb	00h, 00h, 00h, 00h, 0a2h, 00h, 0a2h, 00h
	defb	0a2h, 00h, 0a2h, 00h, 0a2h, 00h, 00h, 00h
	defb	00h, 0a7h, 0a3h, 0a7h, 0a3h, 0a7h, 00h, 0a7h
	defb	00h, 07h, 00h, 0a2h, 00h, 0a2h, 51h, 0a2h
	defb	0ah, 00h, 0ah, 00h, 0ah, 00h, 0ah, 00h
	defb	0ah, 00h, 0f3h, 00h, 51h, 00h, 51h, 00h
	defb	00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h
	defb	00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h
	defb	00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h
	defb	00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h
	defb	00h, 00h, 00h, 0ffh, 00h, 55h, 00h, 00h
	defb	00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h
	defb	00h, 10h, 0ffh, 0bah, 0ffh, 0bah, 00h, 10h
	defb	00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h
	defb	00h, 00h, 00h, 51h, 00h, 0f3h, 00h, 0a3h
	defb	00h, 0f3h, 00h, 0f3h, 00h, 0f3h, 00h, 01h
	defb	00h, 00h, 0a2h, 00h, 0f3h, 00h, 03h, 00h
	defb	53h, 00h, 53h, 00h, 0f3h, 00h, 02h, 00h
	defb	00h, 51h, 00h, 51h, 00h, 01h, 00h, 01h
	defb	00h, 0a3h, 00h, 0a2h, 51h, 00h, 51h, 0a2h
	defb	02h, 28h, 0f3h, 7dh, 0f3h, 7dh, 02h, 28h
	defb	02h, 00h, 0a2h, 00h, 51h, 00h, 51h, 0a2h
	defb	00h, 00h, 00h, 51h, 00h, 0f3h, 00h, 0a3h
	defb	00h, 0f3h, 00h, 0f3h, 00h, 0f3h, 00h, 01h
	defb	00h, 00h, 0a2h, 00h, 0f3h, 00h, 03h, 00h
	defb	53h, 00h, 53h, 00h, 0f3h, 00h, 02h, 00h
	defb	00h, 0f3h, 51h, 79h, 51h, 7dh, 51h, 7dh
	defb	00h, 29h, 00h, 51h, 00h, 51h, 00h, 51h
	defb	0a2h, 0ah, 0a2h, 0ah, 0abh, 0ah, 0a3h, 0ah
	defb	02h, 0ah, 00h, 00h, 00h, 00h, 0a2h, 00h
	defb	00h, 00h, 00h, 00h, 00h, 51h, 00h, 51h
	defb	00h, 51h, 00h, 51h, 00h, 51h, 00h, 00h
	defb	00h, 00h, 0f3h, 00h, 0f3h, 0a2h, 03h, 02h
	defb	0a3h, 0a2h, 0a3h, 0a2h, 0f3h, 0a2h, 03h, 00h
	defb	00h, 51h, 00h, 51h, 00h, 51h, 00h, 00h
	defb	00h, 51h, 00h, 0f3h, 00h, 0a2h, 00h, 0a2h
	defb	53h, 00h, 53h, 0f3h, 0a3h, 0f3h, 03h, 00h
	defb	03h, 00h, 51h, 00h, 51h, 00h, 51h, 0a2h
	defb	00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h
	defb	00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h
	defb	00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h
	defb	00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h
	defb	28h, 00h, 7dh, 0ffh, 7dh, 0ffh, 28h, 00h
	defb	00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h
	defb	00h, 00h, 0ffh, 00h, 0aah, 00h, 00h, 00h
	defb	00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h
	defb	00h, 00h, 00h, 0f3h, 51h, 0f3h, 51h, 0f3h
	defb	51h, 0f3h, 51h, 0f3h, 51h, 0f3h, 00h, 03h
	defb	00h, 00h, 0a2h, 00h, 0f3h, 00h, 0f3h, 00h
	defb	0f3h, 00h, 0f3h, 00h, 0f3h, 00h, 02h, 00h
	defb	00h, 0f3h, 5bh, 0f3h, 5bh, 0f3h, 0ah, 03h
	defb	0ah, 0a2h, 0ah, 0a2h, 00h, 0a2h, 00h, 0a2h
	defb	0a2h, 00h, 0f3h, 00h, 0f3h, 00h, 53h, 00h
	defb	0b6h, 28h, 0f7h, 00h, 0f7h, 00h, 55h, 00h
	defb	00h, 00h, 00h, 0f3h, 51h, 0f3h, 51h, 0f3h
	defb	51h, 0f3h, 51h, 0f3h, 51h, 0f3h, 00h, 03h
	defb	00h, 00h, 0a2h, 00h, 0f3h, 00h, 0f3h, 00h
	defb	0f3h, 00h, 0f3h, 00h, 0f3h, 00h, 02h, 00h
	defb	00h, 0f3h, 51h, 0f3h, 5bh, 0f3h, 5bh, 03h
	defb	0fh, 0a2h, 05h, 0a2h, 00h, 0a2h, 00h, 00h
	defb	0f3h, 00h, 0f3h, 0a2h, 0a2h, 0b6h, 02h, 28h
	defb	0a2h, 00h, 0a2h, 00h, 0a2h, 00h, 0a2h, 00h
	defb	00h, 00h, 00h, 00h, 00h, 00h, 00h, 0f3h
	defb	51h, 0f3h, 51h, 0f3h, 51h, 0f3h, 51h, 0f3h
	defb	51h, 00h, 51h, 00h, 51h, 00h, 0a3h, 00h
	defb	0f3h, 00h, 0f3h, 00h, 0f3h, 00h, 0f3h, 00h
	defb	51h, 0f3h, 00h, 03h, 00h, 0f3h, 51h, 0f3h
	defb	5bh, 03h, 5bh, 0a2h, 0fh, 0a2h, 05h, 0a2h
	defb	0f3h, 00h, 02h, 00h, 0a2h, 00h, 0a2h, 00h
	defb	02h, 00h, 0a2h, 00h, 0a2h, 00h, 0a2h, 00h
	defb	00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h
	defb	00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h
	defb	00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h
	defb	55h, 00h, 55h, 00h, 55h, 00h, 55h, 00h
	defb	00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h
	defb	00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h
	defb	55h, 00h, 55h, 00h, 55h, 00h, 55h, 00h
	defb	55h, 00h, 55h, 00h, 3ch, 28h, 51h, 00h
	defb	00h, 00h, 00h, 0f3h, 51h, 0f3h, 51h, 03h
	defb	51h, 0a3h, 51h, 0a3h, 51h, 0f3h, 00h, 03h
	defb	00h, 00h, 0a2h, 00h, 0f3h, 00h, 53h, 00h
	defb	0f3h, 00h, 0f3h, 00h, 0f3h, 00h, 02h, 00h
	defb	00h, 0f3h, 51h, 0f3h, 51h, 0f3h, 3ch, 03h
	defb	55h, 0a2h, 55h, 0a2h, 55h, 0a2h, 00h, 0a2h
	defb	0a7h, 0ah, 0a7h, 0ah, 0a7h, 0ah, 07h, 0ah
	defb	0a7h, 0ah, 0a2h, 00h, 00h, 00h, 00h, 00h
	defb	00h, 00h, 00h, 0f3h, 51h, 0f3h, 51h, 03h
	defb	51h, 0a3h, 51h, 0a3h, 51h, 0f3h, 00h, 03h
	defb	00h, 00h, 0a2h, 00h, 0f3h, 00h, 53h, 00h
	defb	0f3h, 00h, 0f3h, 00h, 0f3h, 00h, 02h, 00h
	defb	00h, 0f3h, 51h, 0f3h, 3ch, 0f3h, 55h, 03h
	defb	00h, 0a2h, 00h, 0a2h, 00h, 00h, 00h, 00h
	defb	0a2h, 0ah, 0f3h, 0ah, 0f3h, 0ah, 02h, 0ah
	defb	0a2h, 0ah, 0a2h, 00h, 0a2h, 00h, 0a2h, 00h
	defb	00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h
	defb	00h, 0f3h, 51h, 0f3h, 51h, 0f3h, 51h, 03h
	defb	00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h
	defb	0a2h, 00h, 0f3h, 00h, 0f3h, 00h, 53h, 00h
	defb	51h, 0a3h, 51h, 0a3h, 00h, 03h, 00h, 53h
	defb	51h, 03h, 51h, 00h, 51h, 0a2h, 00h, 0a2h
	defb	0a7h, 0ah, 0a7h, 0ah, 07h, 0ah, 0a7h, 0ah
	defb	07h, 0ah, 0a2h, 00h, 0f3h, 00h, 00h, 00h
	defb	00h, 0a2h, 14h, 3ch, 00h, 0aah, 00h, 0aah
	defb	00h, 0aah, 00h, 0aah, 00h, 0aah, 00h, 0aah
	defb	00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h
	defb	00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h
	defb	00h, 0aah, 00h, 0aah, 00h, 0aah, 00h, 0aah
	defb	00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h
	defb	00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h
	defb	00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h
	defb	00h, 00h, 00h, 55h, 00h, 0ffh, 00h, 57h
	defb	00h, 57h, 00h, 0ffh, 00h, 0abh, 00h, 01h
	defb	00h, 00h, 0aah, 00h, 0ffh, 00h, 57h, 00h
	defb	57h, 00h, 0ffh, 00h, 0aah, 00h, 02h, 00h
	defb	00h, 01h, 00h, 55h, 00h, 55h, 00h, 01h
	defb	00h, 01h, 00h, 55h, 00h, 55h, 00h, 0ffh
	defb	0aah, 00h, 0aah, 00h, 02h, 00h, 02h, 00h
	defb	57h, 00h, 55h, 0aah, 00h, 0aah, 00h, 0aah
	defb	00h, 00h, 00h, 55h, 00h, 0ffh, 00h, 57h
	defb	00h, 57h, 00h, 0ffh, 00h, 0abh, 00h, 01h
	defb	00h, 00h, 0aah, 00h, 0ffh, 00h, 57h, 00h
	defb	57h, 00h, 0ffh, 00h, 0aah, 00h, 02h, 00h
	defb	00h, 55h, 55h, 03h, 55h, 57h, 00h, 01h
	defb	00h, 00h, 00h, 00h, 00h, 00h, 00h, 55h
	defb	57h, 00h, 02h, 0aah, 0aah, 0aah, 02h, 00h
	defb	0aah, 00h, 0aah, 00h, 0aah, 00h, 0aah, 00h
	defb	00h, 00h, 00h, 55h, 00h, 0ffh, 00h, 0abh
	defb	00h, 0abh, 00h, 0ffh, 00h, 55h, 00h, 01h
	defb	00h, 00h, 0aah, 00h, 0ffh, 00h, 0abh, 00h
	defb	0abh, 00h, 0ffh, 00h, 57h, 00h, 02h, 00h
	defb	00h, 55h, 00h, 55h, 00h, 01h, 00h, 01h
	defb	00h, 0abh, 55h, 0aah, 55h, 00h, 55h, 00h
	defb	02h, 00h, 0aah, 00h, 0aah, 00h, 02h, 00h
	defb	02h, 00h, 0aah, 00h, 0aah, 00h, 0ffh, 00h
	defb	00h, 00h, 00h, 55h, 00h, 0ffh, 00h, 0abh
	defb	00h, 0abh, 00h, 0ffh, 00h, 55h, 00h, 01h
	defb	00h, 00h, 0aah, 00h, 0ffh, 00h, 0abh, 00h
	defb	0abh, 00h, 0ffh, 00h, 57h, 00h, 02h, 00h
	defb	00h, 0abh, 55h, 01h, 55h, 55h, 00h, 01h
	defb	00h, 55h, 00h, 55h, 00h, 55h, 00h, 55h
	defb	0aah, 00h, 03h, 0aah, 0abh, 0aah, 02h, 00h
	defb	00h, 00h, 00h, 00h, 00h, 00h, 0aah, 00h
	defb	00h, 00h, 00h, 0ffh, 55h, 0ffh, 55h, 0ffh
	defb	55h, 0ffh, 55h, 0ffh, 00h, 0ffh, 00h, 03h
	defb	00h, 00h, 0aah, 00h, 0ffh, 00h, 0ffh, 00h
	defb	0ffh, 00h, 0ffh, 00h, 0aah, 00h, 02h, 00h
	defb	55h, 57h, 55h, 57h, 00h, 57h, 00h, 03h
	defb	00h, 0aah, 00h, 0aah, 00h, 0aah, 00h, 0aah
	defb	57h, 00h, 57h, 0aah, 02h, 0aah, 02h, 00h
	defb	0aah, 00h, 0aah, 00h, 0aah, 00h, 00h, 00h
	defb	00h, 00h, 00h, 0ffh, 55h, 0ffh, 55h, 0ffh
	defb	55h, 0ffh, 55h, 0ffh, 00h, 0ffh, 00h, 03h
	defb	00h, 00h, 0aah, 00h, 0ffh, 00h, 0ffh, 00h
	defb	0ffh, 00h, 0ffh, 00h, 0aah, 00h, 02h, 00h
	defb	55h, 57h, 0ffh, 57h, 0aah, 57h, 00h, 03h
	defb	00h, 0aah, 00h, 0aah, 00h, 0aah, 00h, 00h
	defb	57h, 00h, 57h, 00h, 02h, 00h, 02h, 00h
	defb	0aah, 00h, 0aah, 00h, 0aah, 00h, 0aah, 00h
	defb	00h, 00h, 00h, 0ffh, 55h, 0ffh, 55h, 57h
	defb	55h, 57h, 55h, 0ffh, 00h, 0abh, 00h, 03h
	defb	00h, 00h, 0aah, 00h, 0ffh, 00h, 57h, 00h
	defb	57h, 00h, 0ffh, 00h, 0aah, 00h, 02h, 00h
	defb	55h, 03h, 55h, 03h, 55h, 03h, 00h, 03h
	defb	00h, 0aah, 00h, 0aah, 00h, 0aah, 00h, 0aah
	defb	57h, 00h, 0ffh, 00h, 0aah, 00h, 02h, 00h
	defb	0aah, 00h, 0aah, 00h, 0aah, 00h, 00h, 00h
	defb	00h, 00h, 00h, 0ffh, 55h, 0ffh, 55h, 57h
	defb	55h, 57h, 55h, 0ffh, 00h, 0abh, 00h, 03h
	defb	00h, 00h, 0aah, 00h, 0ffh, 00h, 57h, 00h
	defb	57h, 00h, 0ffh, 00h, 0aah, 00h, 02h, 00h
	defb	55h, 03h, 55h, 0abh, 00h, 0abh, 00h, 03h
	defb	00h, 0aah, 00h, 0aah, 00h, 0aah, 00h, 00h
	defb	57h, 00h, 57h, 00h, 57h, 00h, 02h, 00h
	defb	0aah, 00h, 0aah, 00h, 0aah, 00h, 0aah, 00h
	defb	54h, 56h, 0fch, 0fch, 0fch, 56h, 56h, 0fch
	defb	0fch, 0fch, 0fch, 0a9h, 0a9h, 0fch, 0fch, 0fch
	defb	0a9h, 0a8h, 56h, 0fch, 0fch, 56h, 0fch, 0fch
	defb	0fch, 0fch, 0fch, 0a9h, 0a9h, 0fch, 0fch, 0fch
	defb	56h, 0fch, 0fch, 56h, 0fch, 0fch, 0fch, 0a9h
	defb	0a9h, 0fch, 0fch, 0fch, 0fch, 0fch, 54h, 56h
	defb	0fch, 0fch, 56h, 0a9h, 0fch, 0fch, 0fch, 56h
	defb	56h, 0fch, 0fch, 0a9h, 0fch, 56h, 0a9h, 0a8h
	defb	00h, 00h, 00h, 00h, 00h, 00h, 55h, 54h
	defb	55h, 54h, 0ffh, 54h, 0ffh, 54h, 55h, 00h
	defb	00h, 00h, 00h, 00h, 0a8h, 00h, 54h, 00h
	defb	54h, 00h, 54h, 00h, 54h, 00h, 0a8h, 00h
	defb	55h, 00h, 55h, 00h, 55h, 00h, 55h, 00h
	defb	0ffh, 0aah, 00h, 00h, 00h, 00h, 00h, 00h
	defb	00h, 0a8h, 54h, 54h, 54h, 54h, 54h, 54h
	defb	54h, 54h, 00h, 0a8h, 00h, 00h, 00h, 00h
	defb	00h, 00h, 00h, 00h, 00h, 00h, 55h, 54h
	defb	0ffh, 0feh, 0aah, 0feh, 00h, 0feh, 00h, 0aah
	defb	00h, 00h, 00h, 00h, 0a8h, 00h, 54h, 00h
	defb	54h, 00h, 54h, 00h, 54h, 00h, 0a8h, 00h
	defb	55h, 0aah, 55h, 00h, 55h, 00h, 0aah, 00h
	defb	0ffh, 0aah, 00h, 00h, 00h, 00h, 00h, 00h
	defb	00h, 0a8h, 54h, 54h, 54h, 54h, 54h, 54h
	defb	54h, 54h, 00h, 0a8h, 00h, 00h, 00h, 00h
	defb	00h, 00h, 00h, 00h, 00h, 00h, 00h, 0feh
	defb	00h, 0feh, 00h, 0feh, 0aah, 0feh, 0aah, 0aah
	defb	00h, 00h, 00h, 00h, 0a8h, 00h, 54h, 00h
	defb	54h, 00h, 54h, 00h, 54h, 00h, 0a8h, 00h
	defb	0aah, 0aah, 0ffh, 0aah, 0ffh, 0aah, 00h, 0aah
	defb	00h, 0aah, 00h, 00h, 00h, 00h, 00h, 00h
	defb	00h, 0a8h, 54h, 54h, 54h, 54h, 54h, 54h
	defb	54h, 54h, 00h, 0a8h, 00h, 00h, 00h, 00h
	defb	00h, 00h, 00h, 00h, 00h, 00h, 55h, 54h
	defb	0aah, 0feh, 0aah, 0feh, 0aah, 0feh, 55h, 00h
	defb	00h, 00h, 00h, 00h, 0a8h, 00h, 54h, 00h
	defb	54h, 00h, 54h, 00h, 54h, 00h, 0a8h, 00h
	defb	55h, 00h, 0aah, 0aah, 0aah, 0aah, 0aah, 0aah
	defb	55h, 00h, 00h, 00h, 00h, 00h, 00h, 00h
	defb	00h, 0a8h, 54h, 54h, 54h, 54h, 54h, 54h
	defb	54h, 54h, 00h, 0a8h, 00h, 00h, 00h, 00h
	defb	00h, 00h, 14h, 3ch, 14h, 3ch, 78h, 78h
	defb	78h, 78h, 78h, 78h, 78h, 78h, 78h, 78h
	defb	00h, 00h, 3ch, 28h, 3ch, 28h, 3ch, 3ch
	defb	3ch, 3ch, 0c3h, 96h, 0c3h, 96h, 96h, 96h
	defb	78h, 78h, 78h, 0f0h, 78h, 0f0h, 3ch, 3ch
	defb	3ch, 3ch, 14h, 3ch, 14h, 3ch, 00h, 00h
	defb	96h, 96h, 0c3h, 96h, 0c3h, 96h, 96h, 3ch
	defb	96h, 3ch, 3ch, 28h, 3ch, 28h, 00h, 00h
