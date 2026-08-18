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
;	mono8
	defb	47h, 74h, 47h, 74h, 2eh, 0e2h, 2eh, 0e2h
	defb	0ffh, 0ffh, 0ffh, 0f0h
;	mono16
	defb	11h, 11h, 0ffh, 77h, 00h, 00h, 0eeh, 0cch
	defb	33h, 66h, 44h, 00h, 88h, 0cch, 44h, 00h

ColorPattern: public ColorPattern

SpritePattern: public SpritePattern
;	sprite
	defb	00h, 00h, 00h, 55h, 00h, 0ffh, 00h, 57h
	defb	00h, 57h, 00h, 0ffh, 00h, 55h, 00h, 0fh
	defb	00h, 00h, 0aah, 00h, 0ffh, 00h, 57h, 00h
	defb	57h, 00h, 0ffh, 00h, 0aah, 00h, 0fh, 00h
	defb	05h, 0fh, 05h, 05h, 04h, 05h, 00h, 41h
	defb	00h, 82h, 00h, 82h, 00h, 82h, 00h, 08h
	defb	0fh, 0ah, 0ah, 0ah, 0ah, 08h, 82h, 00h
	defb	41h, 00h, 41h, 00h, 41h, 00h, 04h, 00h
	defb	00h, 00h, 00h, 55h, 00h, 0ffh, 00h, 57h
	defb	00h, 57h, 00h, 0ffh, 00h, 55h, 00h, 05h
	defb	00h, 00h, 0aah, 00h, 0ffh, 00h, 57h, 00h
	defb	57h, 00h, 0ffh, 00h, 0aah, 00h, 0fh, 00h
	defb	04h, 07h, 04h, 07h, 00h, 05h, 00h, 41h
	defb	00h, 82h, 00h, 82h, 41h, 00h, 04h, 00h
	defb	0fh, 0ah, 0ah, 0ah, 0ah, 08h, 82h, 00h
	defb	41h, 82h, 41h, 08h, 00h, 00h, 00h, 00h
	defb	00h, 00h, 00h, 55h, 00h, 0ffh, 00h, 57h
	defb	00h, 57h, 00h, 0ffh, 00h, 55h, 00h, 01h
	defb	00h, 00h, 0aah, 00h, 0ffh, 00h, 57h, 00h
	defb	57h, 00h, 0ffh, 00h, 0aah, 00h, 0ah, 00h
	defb	00h, 01h, 00h, 05h, 00h, 05h, 00h, 04h
	defb	00h, 01h, 00h, 41h, 00h, 41h, 00h, 04h
	defb	0ah, 00h, 0ah, 00h, 02h, 00h, 00h, 00h
	defb	00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h
	defb	00h, 00h, 00h, 55h, 00h, 0ffh, 00h, 57h
	defb	00h, 57h, 00h, 0ffh, 00h, 55h, 00h, 05h
	defb	00h, 00h, 0aah, 00h, 0ffh, 00h, 57h, 00h
	defb	57h, 00h, 0ffh, 00h, 0aah, 00h, 0ah, 00h
	defb	04h, 0fh, 04h, 0bh, 00h, 05h, 00h, 41h
	defb	00h, 83h, 00h, 82h, 00h, 82h, 00h, 08h
	defb	02h, 00h, 0bh, 0ah, 0bh, 08h, 82h, 00h
	defb	0c3h, 82h, 41h, 08h, 00h, 00h, 00h, 00h
	defb	00h, 00h, 00h, 55h, 00h, 0ffh, 00h, 0abh
	defb	00h, 0abh, 00h, 0ffh, 00h, 55h, 00h, 0fh
	defb	00h, 00h, 0aah, 00h, 0ffh, 00h, 0abh, 00h
	defb	0abh, 00h, 0ffh, 00h, 0aah, 00h, 0fh, 00h
	defb	05h, 0fh, 05h, 05h, 04h, 05h, 00h, 41h
	defb	00h, 82h, 00h, 82h, 00h, 82h, 00h, 08h
	defb	0fh, 0ah, 0ah, 0ah, 0ah, 08h, 82h, 00h
	defb	41h, 00h, 41h, 00h, 41h, 00h, 04h, 00h
	defb	00h, 00h, 00h, 55h, 00h, 0ffh, 00h, 0abh
	defb	00h, 0abh, 00h, 0ffh, 00h, 55h, 00h, 0fh
	defb	00h, 00h, 0aah, 00h, 0ffh, 00h, 0abh, 00h
	defb	0abh, 00h, 0ffh, 00h, 0aah, 00h, 0ah, 00h
	defb	05h, 0fh, 05h, 05h, 04h, 05h, 00h, 41h
	defb	41h, 82h, 04h, 82h, 00h, 00h, 00h, 00h
	defb	0bh, 08h, 0bh, 08h, 0ah, 00h, 82h, 00h
	defb	41h, 00h, 41h, 00h, 00h, 82h, 00h, 08h
	defb	00h, 00h, 00h, 55h, 00h, 0ffh, 00h, 0abh
	defb	00h, 0abh, 00h, 0ffh, 00h, 55h, 00h, 05h
	defb	00h, 00h, 0aah, 00h, 0ffh, 00h, 0abh, 00h
	defb	0abh, 00h, 0ffh, 00h, 0aah, 00h, 02h, 00h
	defb	00h, 05h, 00h, 05h, 00h, 01h, 00h, 00h
	defb	00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h
	defb	02h, 00h, 0ah, 00h, 0ah, 00h, 08h, 00h
	defb	02h, 00h, 82h, 00h, 82h, 00h, 08h, 00h
	defb	00h, 00h, 00h, 55h, 00h, 0ffh, 00h, 0abh
	defb	00h, 0abh, 00h, 0ffh, 00h, 55h, 00h, 05h
	defb	00h, 00h, 0aah, 00h, 0ffh, 00h, 0abh, 00h
	defb	0abh, 00h, 0ffh, 00h, 0aah, 00h, 0ah, 00h
	defb	00h, 01h, 05h, 07h, 04h, 07h, 00h, 41h
	defb	41h, 0c3h, 04h, 82h, 00h, 00h, 00h, 00h
	defb	0fh, 08h, 07h, 08h, 0ah, 00h, 82h, 00h
	defb	43h, 00h, 41h, 00h, 41h, 00h, 04h, 00h
	defb	00h, 00h, 00h, 55h, 00h, 0ffh, 00h, 0ffh
	defb	00h, 0ffh, 00h, 0ffh, 00h, 55h, 04h, 05h
	defb	00h, 00h, 0aah, 00h, 0ffh, 00h, 0ffh, 00h
	defb	0ffh, 08h, 0ffh, 08h, 0aah, 0ah, 0fh, 00h
	defb	04h, 0fh, 00h, 0fh, 00h, 05h, 00h, 41h
	defb	00h, 82h, 00h, 82h, 00h, 08h, 00h, 00h
	defb	0fh, 00h, 0ah, 00h, 0ah, 00h, 82h, 00h
	defb	0c3h, 00h, 41h, 00h, 41h, 00h, 04h, 00h
	defb	00h, 00h, 00h, 55h, 00h, 0ffh, 00h, 0ffh
	defb	04h, 0ffh, 04h, 0ffh, 05h, 55h, 00h, 0fh
	defb	00h, 00h, 0aah, 00h, 0ffh, 00h, 0ffh, 00h
	defb	0ffh, 00h, 0ffh, 00h, 0aah, 00h, 0ah, 08h
	defb	00h, 0fh, 00h, 05h, 00h, 05h, 00h, 41h
	defb	00h, 0c3h, 00h, 82h, 00h, 82h, 00h, 08h
	defb	0fh, 08h, 0fh, 00h, 0ah, 00h, 82h, 00h
	defb	41h, 00h, 41h, 00h, 04h, 00h, 00h, 00h
	defb	00h, 0f3h, 00h, 0f3h, 51h, 0f3h, 51h, 0f3h
	defb	0f3h, 0f3h, 0a3h, 0a3h, 0a3h, 0a3h, 0a3h, 0a3h
	defb	0a2h, 00h, 0f3h, 00h, 0f3h, 00h, 0f3h, 0a2h
	defb	0f3h, 0a2h, 0f3h, 0f3h, 0f3h, 0f3h, 0f3h, 0f3h
	defb	0f3h, 0f3h, 51h, 0f3h, 01h, 03h, 50h, 50h
	defb	50h, 50h, 50h, 50h, 00h, 0a0h, 00h, 00h
	defb	0f3h, 0a2h, 0f3h, 00h, 03h, 00h, 50h, 00h
	defb	50h, 00h, 50h, 00h, 0a0h, 0a0h, 00h, 00h
	defb	00h, 00h, 00h, 0f3h, 00h, 0f3h, 51h, 0f3h
	defb	51h, 0f3h, 0f3h, 0f3h, 0a3h, 0a3h, 0a3h, 0a3h
	defb	00h, 00h, 0a2h, 00h, 0f3h, 00h, 0f3h, 00h
	defb	0f3h, 0a2h, 0f3h, 0a2h, 0f3h, 0f3h, 0f3h, 0f3h
	defb	0a3h, 0a3h, 0f3h, 0f3h, 01h, 03h, 50h, 50h
	defb	50h, 50h, 50h, 50h, 00h, 0a0h, 00h, 00h
	defb	0f3h, 0f3h, 0f3h, 0a2h, 03h, 00h, 50h, 00h
	defb	50h, 00h, 50h, 00h, 0a0h, 0a0h, 00h, 00h
	defb	00h, 51h, 00h, 0f3h, 00h, 0f3h, 51h, 0f3h
	defb	51h, 0f3h, 0f3h, 0f3h, 0f3h, 0f3h, 0f3h, 0f3h
	defb	0f3h, 00h, 0f3h, 00h, 0f3h, 0a2h, 0f3h, 0a2h
	defb	0f3h, 0f3h, 53h, 53h, 53h, 53h, 53h, 53h
	defb	51h, 0f3h, 00h, 0f3h, 00h, 03h, 00h, 0a0h
	defb	00h, 0a0h, 00h, 0a0h, 50h, 50h, 00h, 00h
	defb	0f3h, 0f3h, 0f3h, 0a2h, 03h, 02h, 0a0h, 0a0h
	defb	0a0h, 0a0h, 0a0h, 0a0h, 50h, 00h, 00h, 00h
	defb	00h, 00h, 00h, 51h, 00h, 0f3h, 00h, 0f3h
	defb	51h, 0f3h, 51h, 0f3h, 0f3h, 0f3h, 0f3h, 0f3h
	defb	00h, 00h, 0f3h, 00h, 0f3h, 00h, 0f3h, 0a2h
	defb	0f3h, 0a2h, 0f3h, 0f3h, 53h, 53h, 53h, 53h
	defb	0f3h, 0f3h, 51h, 0f3h, 00h, 03h, 00h, 0a0h
	defb	00h, 0a0h, 00h, 0a0h, 50h, 50h, 00h, 00h
	defb	53h, 53h, 0f3h, 0f3h, 03h, 02h, 0a0h, 0a0h
	defb	0a0h, 0a0h, 0a0h, 0a0h, 50h, 00h, 00h, 00h
	defb	00h, 00h, 00h, 0a0h, 50h, 50h, 50h, 50h
	defb	50h, 50h, 01h, 03h, 51h, 0f3h, 0f3h, 0f3h
	defb	00h, 00h, 0a0h, 0a0h, 50h, 00h, 50h, 00h
	defb	50h, 00h, 03h, 02h, 0f3h, 0a2h, 0f3h, 0f3h
	defb	0a3h, 0f3h, 0f3h, 53h, 0a3h, 0f3h, 0f3h, 0f3h
	defb	51h, 0f3h, 51h, 0f3h, 00h, 0f3h, 00h, 51h
	defb	0f3h, 53h, 0a3h, 0f3h, 0f3h, 53h, 0f3h, 0f3h
	defb	0f3h, 0a2h, 0f3h, 0a2h, 0f3h, 00h, 0a2h, 00h
	defb	00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h
	defb	00h, 00h, 00h, 00h, 00h, 05h, 00h, 0fh
	defb	00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h
	defb	00h, 00h, 0fh, 00h, 0ah, 00h, 0ah, 00h
	defb	00h, 0eh, 05h, 0ch, 05h, 1dh, 05h, 0ch
	defb	00h, 0fh, 00h, 0fh, 00h, 00h, 00h, 00h
	defb	0ah, 00h, 0ah, 00h, 0dh, 00h, 0ah, 00h
	defb	0ah, 00h, 00h, 00h, 00h, 00h, 00h, 00h
	defb	00h, 00h, 14h, 3ch, 14h, 3ch, 78h, 78h
	defb	78h, 78h, 78h, 78h, 78h, 78h, 78h, 78h
	defb	00h, 00h, 3ch, 28h, 3ch, 28h, 3ch, 3ch
	defb	3ch, 3ch, 0c3h, 96h, 0c3h, 96h, 96h, 96h
	defb	78h, 78h, 78h, 0f0h, 78h, 0f0h, 3ch, 3ch
	defb	3ch, 3ch, 14h, 3ch, 14h, 3ch, 00h, 00h
	defb	96h, 96h, 0c3h, 96h, 0c3h, 96h, 96h, 3ch
	defb	96h, 3ch, 3ch, 28h, 3ch, 28h, 00h, 00h
