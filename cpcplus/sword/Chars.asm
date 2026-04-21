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
	defb	00h, 00h, 00h, 51h, 00h, 0f3h, 00h, 03h
	defb	00h, 0a3h, 00h, 0a3h, 00h, 0f3h, 00h, 01h
	defb	00h, 00h, 0a2h, 00h, 0f3h, 00h, 53h, 00h
	defb	0f3h, 00h, 0f3h, 00h, 0f3h, 00h, 02h, 00h
	defb	00h, 0bh, 00h, 5bh, 00h, 5bh, 00h, 0bh
	defb	00h, 0bh, 00h, 51h, 00h, 0a2h, 51h, 0a2h
	defb	0a2h, 00h, 0a2h, 00h, 02h, 00h, 0a2h, 00h
	defb	53h, 00h, 51h, 00h, 00h, 0a2h, 51h, 0a2h

SpritePattern: public SpritePattern
;	sprite
	defb	00h, 00h, 00h, 00h, 00h, 0dh, 0d0h, 00h
	defb	00h, 0ddh, 0ddh, 00h, 00h, 88h, 8dh, 00h
	defb	00h, 0d8h, 0ddh, 00h, 00h, 0d8h, 0ddh, 00h
	defb	00h, 0ddh, 0ddh, 00h, 00h, 08h, 80h, 00h
	defb	00h, 0a8h, 0d0h, 00h, 00h, 0adh, 0d0h, 00h
	defb	00h, 0adh, 80h, 00h, 00h, 0a8h, 0d0h, 00h
	defb	00h, 0a8h, 8dh, 00h, 00h, 0dh, 0dh, 00h
	defb	00h, 0d0h, 00h, 0d0h, 0dh, 0d0h, 0dh, 0d0h
	defb	00h, 00h, 00h, 00h, 00h, 0dh, 0d0h, 00h
	defb	00h, 0ddh, 0ddh, 00h, 00h, 88h, 8dh, 00h
	defb	00h, 0d8h, 0ddh, 00h, 00h, 0d8h, 0ddh, 00h
	defb	00h, 0ddh, 0ddh, 00h, 00h, 08h, 80h, 00h
	defb	00h, 0ah, 0a0h, 00h, 0fh, 8ah, 0a0h, 00h
	defb	00h, 0ah, 0a0h, 00h, 00h, 0ah, 0a0h, 00h
	defb	00h, 0ah, 0a0h, 00h, 00h, 00h, 80h, 00h
	defb	00h, 00h, 0d0h, 00h, 00h, 0dh, 0d0h, 00h
	defb	00h, 00h, 00h, 00h, 00h, 0ddh, 00h, 00h
	defb	0dh, 0ddh, 0d0h, 00h, 08h, 88h, 0d0h, 00h
	defb	0dh, 8dh, 0d0h, 00h, 0dh, 8dh, 0d0h, 00h
	defb	0dh, 0ddh, 0d0h, 00h, 00h, 88h, 00h, 00h
	defb	00h, 0dah, 0a0h, 00h, 0d8h, 0dah, 0a0h, 00h
	defb	0d8h, 0dah, 0a0h, 00h, 00h, 0dah, 0a0h, 00h
	defb	00h, 8ah, 0a0h, 00h, 00h, 0d0h, 0ddh, 00h
	defb	00h, 0d0h, 0dh, 00h, 0dh, 0d0h, 0dh, 00h
	defb	00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h
	defb	00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h
	defb	00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h
	defb	00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h
	defb	00h, 00h, 00h, 04h, 00h, 0ffh, 0ffh, 0f4h
	defb	00h, 0fh, 0ffh, 0f4h, 00h, 00h, 00h, 04h
	defb	00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h
	defb	00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h
	defb	00h, 00h, 00h, 00h, 00h, 0dh, 0d0h, 00h
	defb	00h, 0ddh, 0ddh, 00h, 00h, 0d8h, 88h, 00h
	defb	00h, 0ddh, 8dh, 00h, 00h, 0ddh, 8dh, 00h
	defb	00h, 0ddh, 0ddh, 00h, 00h, 08h, 80h, 00h
	defb	00h, 0dh, 80h, 60h, 00h, 0dh, 0ddh, 6fh
	defb	00h, 08h, 0ddh, 6fh, 00h, 08h, 80h, 60h
	defb	00h, 0d8h, 80h, 00h, 00h, 0d0h, 0d0h, 00h
	defb	0dh, 00h, 0dh, 00h, 0dh, 0d0h, 0dh, 0d0h
	defb	00h, 00h, 00h, 00h, 00h, 0dh, 0d0h, 00h
	defb	00h, 0ddh, 0ddh, 00h, 00h, 0d8h, 88h, 00h
	defb	00h, 0ddh, 8dh, 00h, 00h, 0ddh, 8dh, 00h
	defb	00h, 0ddh, 0ddh, 00h, 00h, 08h, 80h, 00h
	defb	00h, 0ddh, 0d0h, 0a0h, 0dh, 6dh, 0d0h, 0a0h
	defb	0dh, 6fh, 0f8h, 0a0h, 0dh, 6fh, 0d8h, 0a0h
	defb	00h, 68h, 80h, 0a0h, 00h, 0dh, 00h, 00h
	defb	00h, 0dh, 00h, 00h, 00h, 0dh, 0d0h, 00h
	defb	00h, 00h, 00h, 00h, 00h, 00h, 0ddh, 00h
	defb	00h, 0dh, 0ddh, 0d0h, 00h, 0dh, 88h, 80h
	defb	00h, 0dh, 0d8h, 0d0h, 00h, 0dh, 0d8h, 0d0h
	defb	00h, 0dh, 0ddh, 0d0h, 00h, 00h, 88h, 00h
	defb	00h, 0dh, 8dh, 00h, 00h, 0dh, 8dh, 0ddh
	defb	00h, 0dh, 0d8h, 0ddh, 00h, 00h, 88h, 00h
	defb	00h, 0dh, 88h, 00h, 00h, 0ddh, 0dh, 00h
	defb	00h, 0d0h, 0dh, 00h, 00h, 0d0h, 0dh, 0d0h
	defb	00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h
	defb	00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h
	defb	00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h
	defb	00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h
	defb	60h, 00h, 00h, 00h, 6fh, 0ffh, 0ffh, 00h
	defb	6fh, 0ffh, 0f0h, 00h, 60h, 00h, 00h, 00h
	defb	00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h
	defb	00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h
	defb	00h, 00h, 00h, 00h, 00h, 0ddh, 0d0h, 00h
	defb	0dh, 0ddh, 0ddh, 00h, 0dh, 0ddh, 0ddh, 00h
	defb	0dh, 0ddh, 0ddh, 00h, 0dh, 0ddh, 0ddh, 00h
	defb	0dh, 0ddh, 0ddh, 00h, 00h, 88h, 80h, 00h
	defb	00h, 0ddh, 0d0h, 00h, 0adh, 0ddh, 0ddh, 00h
	defb	0adh, 0ddh, 0ddh, 00h, 0a0h, 88h, 8dh, 00h
	defb	0a0h, 0d0h, 0d6h, 60h, 0a0h, 0d0h, 0dfh, 00h
	defb	00h, 0d0h, 0dfh, 00h, 00h, 0d0h, 0fh, 00h
	defb	00h, 00h, 00h, 00h, 00h, 0ddh, 0d0h, 00h
	defb	0dh, 0ddh, 0ddh, 00h, 0dh, 0ddh, 0ddh, 00h
	defb	0dh, 0ddh, 0ddh, 00h, 0dh, 0ddh, 0ddh, 00h
	defb	0dh, 0ddh, 0ddh, 00h, 00h, 88h, 80h, 00h
	defb	00h, 0ddh, 0ddh, 00h, 0dh, 0ddh, 0ddh, 0d0h
	defb	0adh, 0ddh, 0d0h, 0d6h, 0adh, 88h, 80h, 60h
	defb	0aah, 0d0h, 0d0h, 00h, 0ah, 0d0h, 0d0h, 00h
	defb	00h, 0d0h, 0d0h, 00h, 00h, 00h, 0d0h, 00h
	defb	00h, 00h, 0dh, 00h, 00h, 00h, 0dh, 00h
	defb	00h, 00h, 0dh, 00h, 00h, 0ddh, 0d8h, 00h
	defb	0dh, 0ddh, 0ddh, 00h, 0dh, 0ddh, 0ddh, 00h
	defb	0dh, 0ddh, 0ddh, 00h, 0dh, 0ddh, 0ddh, 00h
	defb	0dh, 0ddh, 0ddh, 00h, 00h, 88h, 80h, 00h
	defb	00h, 0ddh, 0d0h, 00h, 0dh, 0ddh, 0d0h, 00h
	defb	0adh, 88h, 80h, 00h, 0adh, 0d0h, 0d0h, 00h
	defb	0aah, 0d0h, 0d0h, 00h, 0ah, 0d0h, 0d0h, 00h
	defb	00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h
	defb	00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h
	defb	00h, 00h, 0fh, 00h, 00h, 00h, 0fh, 00h
	defb	00h, 00h, 0fh, 00h, 00h, 00h, 0fh, 00h
	defb	00h, 00h, 0fh, 00h, 00h, 00h, 0fh, 00h
	defb	00h, 00h, 0fh, 00h, 00h, 00h, 0fh, 00h
	defb	00h, 00h, 0fh, 00h, 00h, 00h, 0fh, 00h
	defb	00h, 00h, 66h, 60h, 00h, 00h, 0dh, 00h
	defb	00h, 00h, 00h, 00h, 00h, 0ddh, 0d0h, 00h
	defb	0dh, 0ddh, 0ddh, 00h, 0dh, 88h, 8dh, 00h
	defb	0dh, 0d8h, 0ddh, 00h, 0dh, 0d8h, 0ddh, 00h
	defb	0dh, 0ddh, 0ddh, 00h, 00h, 88h, 80h, 00h
	defb	00h, 0ddh, 0dah, 0a0h, 0dh, 0ddh, 0dah, 0a0h
	defb	0dh, 0ddh, 0dah, 0a0h, 66h, 88h, 8ah, 0a0h
	defb	0fh, 0d0h, 0dah, 0a0h, 0fh, 0d0h, 0d0h, 00h
	defb	0fh, 0d0h, 00h, 00h, 00h, 0d0h, 00h, 00h
	defb	00h, 00h, 00h, 00h, 00h, 0ddh, 0d0h, 00h
	defb	0dh, 0ddh, 0ddh, 00h, 0dh, 88h, 8dh, 00h
	defb	0dh, 0d8h, 0ddh, 00h, 0dh, 0d8h, 0ddh, 00h
	defb	0dh, 0ddh, 0ddh, 00h, 00h, 88h, 80h, 00h
	defb	00h, 0ddh, 0d0h, 0a0h, 0dh, 0ddh, 0ddh, 0a0h
	defb	66h, 0ddh, 0ddh, 0a0h, 0fh, 88h, 80h, 0a0h
	defb	00h, 0d0h, 0d0h, 0a0h, 00h, 0d0h, 0d0h, 00h
	defb	00h, 00h, 0d0h, 00h, 00h, 00h, 0d0h, 00h
	defb	00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h
	defb	00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h
	defb	00h, 0ddh, 0d0h, 00h, 0dh, 0ddh, 0ddh, 00h
	defb	0dh, 0ddh, 0ddh, 00h, 0dh, 88h, 8dh, 00h
	defb	0dh, 0d8h, 0dah, 0a0h, 0dh, 0d8h, 0dah, 0a0h
	defb	00h, 88h, 8ah, 0a0h, 00h, 8dh, 0dah, 0a0h
	defb	0dh, 88h, 8ah, 0a0h, 0dh, 00h, 0d0h, 00h
	defb	0dh, 0d0h, 0ddh, 00h, 00h, 0d0h, 00h, 00h
	defb	00h, 0d0h, 00h, 00h, 06h, 66h, 00h, 00h
	defb	00h, 0f0h, 00h, 00h, 00h, 0f0h, 00h, 00h
	defb	00h, 0f0h, 00h, 00h, 00h, 0f0h, 00h, 00h
	defb	00h, 0f0h, 00h, 00h, 00h, 0f0h, 00h, 00h
	defb	00h, 0f0h, 00h, 00h, 00h, 0f0h, 00h, 00h
	defb	00h, 0f0h, 00h, 00h, 00h, 0f0h, 00h, 00h
	defb	00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h
	defb	00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h
	defb	00h, 00h, 00h, 00h, 00h, 0fh, 0f0h, 00h
	defb	00h, 0ffh, 0ffh, 00h, 00h, 8fh, 8fh, 00h
	defb	00h, 8fh, 8fh, 00h, 00h, 0ffh, 0ffh, 00h
	defb	00h, 0f8h, 0f0h, 00h, 00h, 08h, 80h, 00h
	defb	00h, 08h, 0f0h, 00h, 00h, 0fh, 0f0h, 00h
	defb	00h, 0fh, 80h, 00h, 00h, 08h, 80h, 00h
	defb	00h, 08h, 8fh, 00h, 00h, 0fh, 0fh, 0f0h
	defb	00h, 0fh, 00h, 0f0h, 00h, 0ffh, 00h, 0f0h
	defb	00h, 00h, 00h, 00h, 00h, 0fh, 0f0h, 00h
	defb	00h, 0ffh, 0ffh, 00h, 00h, 8fh, 8fh, 00h
	defb	00h, 8fh, 8fh, 00h, 00h, 0ffh, 0ffh, 00h
	defb	00h, 0f8h, 0f0h, 00h, 00h, 08h, 80h, 00h
	defb	00h, 0fh, 8fh, 00h, 0fh, 88h, 80h, 0f0h
	defb	0fh, 8fh, 0f0h, 0f0h, 00h, 08h, 80h, 00h
	defb	00h, 00h, 0f0h, 00h, 00h, 00h, 0f0h, 00h
	defb	00h, 00h, 0f0h, 00h, 00h, 0fh, 0f0h, 00h
	defb	00h, 00h, 00h, 00h, 00h, 0fh, 0f0h, 00h
	defb	00h, 0ffh, 0ffh, 00h, 00h, 0f8h, 0f8h, 00h
	defb	00h, 0f8h, 0f8h, 00h, 00h, 0ffh, 0ffh, 00h
	defb	00h, 0fh, 8fh, 00h, 00h, 08h, 80h, 00h
	defb	00h, 0fh, 80h, 00h, 00h, 0fh, 0f0h, 00h
	defb	00h, 08h, 0f0h, 00h, 00h, 08h, 80h, 00h
	defb	00h, 0f8h, 80h, 00h, 0fh, 0f0h, 0f0h, 00h
	defb	0fh, 00h, 0f0h, 00h, 0fh, 00h, 0ffh, 00h
	defb	00h, 00h, 00h, 00h, 00h, 0fh, 0f0h, 00h
	defb	00h, 0ffh, 0ffh, 00h, 00h, 0f8h, 0f8h, 00h
	defb	00h, 0f8h, 0f8h, 00h, 00h, 0ffh, 0ffh, 00h
	defb	00h, 0fh, 8fh, 00h, 00h, 08h, 80h, 00h
	defb	00h, 0f8h, 0f0h, 00h, 0fh, 08h, 88h, 0f0h
	defb	0fh, 0fh, 0f8h, 0f0h, 00h, 08h, 80h, 00h
	defb	00h, 0fh, 00h, 00h, 00h, 0fh, 00h, 00h
	defb	00h, 0fh, 00h, 00h, 00h, 0fh, 0f0h, 00h
	defb	00h, 00h, 00h, 00h, 00h, 0ffh, 0f0h, 00h
	defb	0fh, 0ffh, 0ffh, 00h, 0fh, 0ffh, 0ffh, 00h
	defb	0fh, 0ffh, 0ffh, 00h, 0fh, 0ffh, 0ffh, 00h
	defb	00h, 0ffh, 0f0h, 00h, 00h, 88h, 80h, 00h
	defb	0fh, 8fh, 8fh, 00h, 0fh, 8fh, 8fh, 0f0h
	defb	00h, 8fh, 80h, 0f0h, 00h, 88h, 80h, 00h
	defb	00h, 0f0h, 0f0h, 00h, 00h, 0f0h, 0f0h, 00h
	defb	00h, 0f0h, 0f0h, 00h, 00h, 0f0h, 00h, 00h
	defb	00h, 00h, 00h, 00h, 00h, 0ffh, 0f0h, 00h
	defb	0fh, 0ffh, 0ffh, 00h, 0fh, 0ffh, 0ffh, 00h
	defb	0fh, 0ffh, 0ffh, 00h, 0fh, 0ffh, 0ffh, 00h
	defb	00h, 0ffh, 0f0h, 00h, 00h, 88h, 80h, 00h
	defb	0fh, 8fh, 8fh, 00h, 0ffh, 8fh, 8fh, 00h
	defb	0f0h, 8fh, 80h, 00h, 00h, 88h, 80h, 00h
	defb	00h, 0f0h, 0f0h, 00h, 00h, 0f0h, 0f0h, 00h
	defb	00h, 0f0h, 0f0h, 00h, 00h, 00h, 0f0h, 00h
	defb	00h, 00h, 00h, 00h, 00h, 0ffh, 0f0h, 00h
	defb	0fh, 0ffh, 0ffh, 00h, 0fh, 8fh, 8fh, 00h
	defb	0fh, 8fh, 8fh, 00h, 0fh, 0ffh, 0ffh, 00h
	defb	00h, 0f8h, 0f0h, 00h, 00h, 88h, 80h, 00h
	defb	0fh, 88h, 8fh, 00h, 0fh, 88h, 0ffh, 00h
	defb	0fh, 88h, 0f0h, 00h, 00h, 88h, 80h, 00h
	defb	00h, 0f0h, 0f0h, 00h, 00h, 0f0h, 0f0h, 00h
	defb	00h, 0f0h, 0f0h, 00h, 00h, 0f0h, 00h, 00h
	defb	00h, 00h, 00h, 00h, 00h, 0ffh, 0f0h, 00h
	defb	0fh, 0ffh, 0ffh, 00h, 0fh, 8fh, 8fh, 00h
	defb	0fh, 8fh, 8fh, 00h, 0fh, 0ffh, 0ffh, 00h
	defb	00h, 0f8h, 0f0h, 00h, 00h, 88h, 80h, 00h
	defb	0fh, 88h, 8fh, 00h, 0fh, 0f8h, 8fh, 00h
	defb	00h, 0f8h, 8fh, 00h, 00h, 88h, 80h, 00h
	defb	00h, 0f0h, 0f0h, 00h, 00h, 0f0h, 0f0h, 00h
	defb	00h, 0f0h, 0f0h, 00h, 00h, 00h, 0f0h, 00h
	defb	07h, 87h, 78h, 70h, 77h, 77h, 87h, 77h
	defb	77h, 87h, 77h, 87h, 87h, 77h, 77h, 77h
	defb	77h, 77h, 77h, 77h, 77h, 78h, 77h, 78h
	defb	78h, 77h, 78h, 77h, 77h, 77h, 77h, 77h
	defb	87h, 77h, 77h, 77h, 77h, 87h, 87h, 78h
	defb	77h, 77h, 77h, 77h, 77h, 78h, 77h, 87h
	defb	78h, 77h, 87h, 77h, 77h, 77h, 77h, 78h
	defb	77h, 77h, 77h, 87h, 07h, 87h, 78h, 70h
	defb	00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h
	defb	00h, 00h, 70h, 00h, 0fh, 07h, 07h, 00h
	defb	0fh, 07h, 07h, 00h, 0ffh, 07h, 07h, 00h
	defb	0ffh, 07h, 07h, 00h, 0fh, 00h, 70h, 00h
	defb	0fh, 00h, 00h, 70h, 0fh, 00h, 07h, 07h
	defb	0fh, 00h, 07h, 07h, 0fh, 00h, 07h, 07h
	defb	0ffh, 0f0h, 07h, 07h, 00h, 00h, 00h, 70h
	defb	00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h
	defb	00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h
	defb	00h, 00h, 70h, 00h, 0fh, 07h, 07h, 00h
	defb	0ffh, 0f7h, 07h, 00h, 0f0h, 0f7h, 07h, 00h
	defb	00h, 0f7h, 07h, 00h, 00h, 0f0h, 70h, 00h
	defb	0fh, 0f0h, 00h, 70h, 0fh, 00h, 07h, 07h
	defb	0fh, 00h, 07h, 07h, 0f0h, 00h, 07h, 07h
	defb	0ffh, 0f0h, 07h, 07h, 00h, 00h, 00h, 70h
	defb	00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h
	defb	00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h
	defb	00h, 00h, 70h, 00h, 00h, 0f7h, 07h, 00h
	defb	00h, 0f7h, 07h, 00h, 00h, 0f7h, 07h, 00h
	defb	0f0h, 0f7h, 07h, 00h, 0f0h, 0f0h, 70h, 00h
	defb	0f0h, 0f0h, 00h, 70h, 0ffh, 0f0h, 07h, 07h
	defb	0ffh, 0f0h, 07h, 07h, 00h, 0f0h, 07h, 07h
	defb	00h, 0f0h, 07h, 07h, 00h, 00h, 00h, 70h
	defb	00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h
	defb	00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h
	defb	00h, 00h, 70h, 00h, 0fh, 07h, 07h, 00h
	defb	0f0h, 0f7h, 07h, 00h, 0f0h, 0f7h, 07h, 00h
	defb	0f0h, 0f7h, 07h, 00h, 0fh, 00h, 70h, 00h
	defb	0fh, 00h, 00h, 70h, 0f0h, 0f0h, 07h, 07h
	defb	0f0h, 0f0h, 07h, 07h, 0f0h, 0f0h, 07h, 07h
	defb	0fh, 00h, 07h, 07h, 00h, 00h, 00h, 70h
	defb	00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h
	defb	00h, 00h, 00h, 00h, 06h, 66h, 66h, 60h
	defb	06h, 66h, 66h, 60h, 65h, 65h, 66h, 66h
	defb	65h, 65h, 66h, 66h, 65h, 65h, 99h, 96h
	defb	65h, 65h, 99h, 96h, 65h, 65h, 96h, 96h
	defb	65h, 65h, 96h, 96h, 65h, 55h, 99h, 96h
	defb	65h, 55h, 99h, 96h, 66h, 66h, 96h, 66h
	defb	66h, 66h, 96h, 66h, 06h, 66h, 66h, 60h
	defb	06h, 66h, 66h, 60h, 00h, 00h, 00h, 00h
