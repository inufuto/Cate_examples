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
;	color16
	defb	00h, 00h, 00h, 54h, 00h, 0fch, 00h, 56h
	defb	00h, 56h, 00h, 0fch, 00h, 54h, 00h, 0cfh
	defb	00h, 00h, 0a8h, 00h, 0fch, 00h, 56h, 00h
	defb	56h, 00h, 0fch, 00h, 0a8h, 00h, 0cfh, 00h
	defb	45h, 0cfh, 45h, 45h, 15h, 45h, 00h, 51h
	defb	00h, 0a2h, 00h, 0a2h, 00h, 0a2h, 00h, 2ah
	defb	0cfh, 8ah, 8ah, 8ah, 8ah, 2ah, 0a2h, 00h
	defb	51h, 00h, 51h, 00h, 51h, 00h, 15h, 00h
	defb	00h, 00h, 00h, 80h, 40h, 40h, 40h, 40h
	defb	40h, 40h, 01h, 03h, 50h, 0f0h, 0f0h, 0f0h
	defb	00h, 00h, 80h, 80h, 40h, 00h, 40h, 00h
	defb	40h, 00h, 03h, 02h, 0f0h, 0a0h, 0f0h, 0f0h
	defb	0a1h, 0f0h, 0f0h, 52h, 0a1h, 0f0h, 0f0h, 0f0h
	defb	50h, 0f0h, 50h, 0f0h, 00h, 0f0h, 00h, 50h
	defb	0f0h, 52h, 0a1h, 0f0h, 0f0h, 52h, 0f0h, 0f0h
	defb	0f0h, 0a0h, 0f0h, 0a0h, 0f0h, 00h, 0a0h, 00h

SpritePattern: public SpritePattern
;	sprite
	defb	00h, 00h, 00h, 00h, 00h, 07h, 70h, 00h
	defb	00h, 77h, 77h, 00h, 00h, 87h, 87h, 00h
	defb	00h, 87h, 87h, 00h, 00h, 77h, 77h, 00h
	defb	00h, 07h, 70h, 00h, 00h, 0bbh, 0bbh, 00h
	defb	0bh, 0bbh, 0bbh, 0b0h, 0bh, 0bh, 0b0h, 0b0h
	defb	0eh, 0bh, 0b0h, 0e0h, 00h, 0dh, 0d0h, 00h
	defb	00h, 0d0h, 0dh, 00h, 00h, 0d0h, 0dh, 00h
	defb	00h, 0d0h, 0dh, 00h, 00h, 0e0h, 0eh, 00h
	defb	00h, 00h, 00h, 00h, 00h, 07h, 70h, 00h
	defb	00h, 77h, 77h, 00h, 00h, 87h, 87h, 00h
	defb	00h, 87h, 87h, 00h, 00h, 77h, 77h, 00h
	defb	00h, 07h, 70h, 00h, 00h, 0bh, 0bbh, 00h
	defb	0eh, 8bh, 0bbh, 0b0h, 0eh, 8bh, 0b0h, 0b0h
	defb	00h, 0bh, 0b0h, 0e0h, 00h, 0dh, 0d0h, 00h
	defb	00h, 0d0h, 0dh, 0d0h, 00h, 0d0h, 0dh, 0e0h
	defb	0dh, 00h, 00h, 00h, 0eh, 00h, 00h, 00h
	defb	00h, 00h, 00h, 00h, 00h, 07h, 70h, 00h
	defb	00h, 77h, 77h, 00h, 00h, 87h, 87h, 00h
	defb	00h, 87h, 87h, 00h, 00h, 77h, 77h, 00h
	defb	00h, 07h, 70h, 00h, 00h, 08h, 0b0h, 00h
	defb	00h, 08h, 0b0h, 00h, 00h, 0bh, 0b0h, 00h
	defb	00h, 0bh, 80h, 00h, 00h, 0eh, 00h, 00h
	defb	00h, 08h, 00h, 00h, 00h, 0dh, 00h, 00h
	defb	00h, 0dh, 00h, 00h, 00h, 0eh, 00h, 00h
	defb	00h, 00h, 00h, 00h, 00h, 07h, 70h, 00h
	defb	00h, 77h, 77h, 00h, 00h, 87h, 87h, 00h
	defb	00h, 87h, 87h, 00h, 00h, 77h, 77h, 00h
	defb	00h, 07h, 70h, 00h, 00h, 0bh, 0b0h, 00h
	defb	0eh, 0bbh, 80h, 00h, 0eh, 0b8h, 0b8h, 0b0h
	defb	00h, 0bh, 0b8h, 0e0h, 00h, 0dh, 0d0h, 00h
	defb	00h, 0d8h, 0ddh, 0d0h, 00h, 0d0h, 0dh, 0e0h
	defb	00h, 0d0h, 00h, 00h, 00h, 0e0h, 00h, 00h
	defb	00h, 00h, 00h, 00h, 00h, 07h, 70h, 00h
	defb	00h, 77h, 77h, 00h, 00h, 78h, 78h, 00h
	defb	00h, 78h, 78h, 00h, 00h, 77h, 77h, 00h
	defb	00h, 07h, 70h, 00h, 00h, 0bbh, 0bbh, 00h
	defb	0bh, 0bbh, 0bbh, 0b0h, 0bh, 0bh, 0b0h, 0b0h
	defb	0eh, 0bh, 0b0h, 0e0h, 00h, 0dh, 0d0h, 00h
	defb	00h, 0d0h, 0dh, 00h, 00h, 0d0h, 0dh, 00h
	defb	00h, 0d0h, 0dh, 00h, 00h, 0e0h, 0eh, 00h
	defb	00h, 00h, 00h, 00h, 00h, 07h, 70h, 00h
	defb	00h, 77h, 77h, 00h, 00h, 78h, 78h, 00h
	defb	00h, 78h, 78h, 00h, 00h, 77h, 77h, 00h
	defb	00h, 07h, 70h, 00h, 00h, 0bbh, 0b0h, 00h
	defb	0bh, 0bbh, 0b8h, 0e0h, 0bh, 0bh, 0b8h, 0e0h
	defb	0eh, 0bh, 0b0h, 00h, 00h, 0dh, 0d0h, 00h
	defb	0dh, 0d0h, 0dh, 00h, 0eh, 0d0h, 0dh, 00h
	defb	00h, 00h, 00h, 0d0h, 00h, 00h, 00h, 0e0h
	defb	00h, 00h, 00h, 00h, 00h, 07h, 70h, 00h
	defb	00h, 77h, 77h, 00h, 00h, 78h, 78h, 00h
	defb	00h, 78h, 78h, 00h, 00h, 77h, 77h, 00h
	defb	00h, 07h, 70h, 00h, 00h, 0bh, 80h, 00h
	defb	00h, 0bh, 80h, 00h, 00h, 0bh, 0b0h, 00h
	defb	00h, 08h, 0b0h, 00h, 00h, 00h, 0e0h, 00h
	defb	00h, 00h, 80h, 00h, 00h, 00h, 0d0h, 00h
	defb	00h, 00h, 0d0h, 00h, 00h, 00h, 0e0h, 00h
	defb	00h, 00h, 00h, 00h, 00h, 07h, 70h, 00h
	defb	00h, 77h, 77h, 00h, 00h, 78h, 78h, 00h
	defb	00h, 78h, 78h, 00h, 00h, 77h, 77h, 00h
	defb	00h, 07h, 70h, 00h, 00h, 0bh, 0b0h, 00h
	defb	00h, 08h, 0bbh, 0e0h, 0bh, 8bh, 8bh, 0e0h
	defb	0eh, 8bh, 0b0h, 00h, 00h, 0dh, 0d0h, 00h
	defb	0dh, 0ddh, 8dh, 00h, 0eh, 0d0h, 0dh, 00h
	defb	00h, 00h, 0dh, 00h, 00h, 00h, 0eh, 00h
	defb	00h, 00h, 00h, 00h, 00h, 07h, 70h, 00h
	defb	00h, 77h, 77h, 00h, 00h, 77h, 77h, 00h
	defb	00h, 77h, 77h, 0e0h, 00h, 77h, 77h, 0e0h
	defb	00h, 07h, 70h, 90h, 0eh, 09h, 99h, 90h
	defb	0eh, 99h, 99h, 00h, 00h, 99h, 90h, 00h
	defb	00h, 09h, 90h, 00h, 00h, 0dh, 0d0h, 00h
	defb	00h, 0d0h, 0ddh, 00h, 00h, 0d0h, 0dh, 00h
	defb	00h, 0e0h, 0dh, 00h, 00h, 00h, 0eh, 00h
	defb	00h, 00h, 00h, 00h, 00h, 07h, 70h, 00h
	defb	00h, 77h, 77h, 00h, 00h, 77h, 77h, 00h
	defb	0eh, 77h, 77h, 00h, 0eh, 77h, 77h, 00h
	defb	09h, 07h, 70h, 00h, 09h, 99h, 90h, 0e0h
	defb	00h, 99h, 99h, 0e0h, 00h, 09h, 99h, 00h
	defb	00h, 09h, 90h, 00h, 00h, 0dh, 0d0h, 00h
	defb	00h, 0ddh, 0dh, 00h, 00h, 0d0h, 0dh, 00h
	defb	00h, 0d0h, 0eh, 00h, 00h, 0e0h, 00h, 00h
	defb	00h, 55h, 50h, 00h, 00h, 55h, 55h, 00h
	defb	05h, 55h, 55h, 00h, 05h, 55h, 55h, 50h
	defb	55h, 55h, 55h, 50h, 58h, 58h, 55h, 55h
	defb	58h, 58h, 55h, 55h, 58h, 58h, 55h, 55h
	defb	55h, 55h, 55h, 50h, 05h, 55h, 55h, 00h
	defb	08h, 88h, 88h, 00h, 01h, 01h, 01h, 00h
	defb	01h, 01h, 01h, 00h, 01h, 01h, 01h, 00h
	defb	00h, 10h, 10h, 10h, 00h, 00h, 00h, 00h
	defb	00h, 00h, 00h, 00h, 00h, 55h, 50h, 00h
	defb	00h, 55h, 55h, 00h, 05h, 55h, 55h, 00h
	defb	05h, 55h, 55h, 50h, 55h, 55h, 55h, 50h
	defb	58h, 58h, 55h, 55h, 58h, 58h, 55h, 55h
	defb	58h, 58h, 55h, 55h, 55h, 55h, 55h, 50h
	defb	08h, 88h, 88h, 00h, 01h, 01h, 01h, 00h
	defb	01h, 01h, 01h, 00h, 01h, 01h, 01h, 00h
	defb	00h, 10h, 10h, 10h, 00h, 00h, 00h, 00h
	defb	00h, 05h, 55h, 00h, 00h, 55h, 55h, 00h
	defb	00h, 55h, 55h, 50h, 05h, 55h, 55h, 50h
	defb	05h, 55h, 55h, 55h, 55h, 55h, 85h, 85h
	defb	55h, 55h, 85h, 85h, 55h, 55h, 85h, 85h
	defb	05h, 55h, 55h, 55h, 00h, 55h, 55h, 50h
	defb	00h, 88h, 88h, 80h, 00h, 10h, 10h, 10h
	defb	00h, 10h, 10h, 10h, 00h, 10h, 10h, 10h
	defb	01h, 01h, 01h, 00h, 00h, 00h, 00h, 00h
	defb	00h, 00h, 00h, 00h, 00h, 05h, 55h, 00h
	defb	00h, 55h, 55h, 00h, 00h, 55h, 55h, 50h
	defb	05h, 55h, 55h, 50h, 05h, 55h, 55h, 55h
	defb	55h, 55h, 85h, 85h, 55h, 55h, 85h, 85h
	defb	55h, 55h, 85h, 85h, 05h, 55h, 55h, 55h
	defb	00h, 88h, 88h, 80h, 00h, 10h, 10h, 10h
	defb	00h, 10h, 10h, 10h, 00h, 10h, 10h, 10h
	defb	01h, 01h, 01h, 00h, 00h, 00h, 00h, 00h
	defb	00h, 00h, 00h, 00h, 00h, 10h, 10h, 10h
	defb	01h, 01h, 01h, 00h, 01h, 01h, 01h, 00h
	defb	01h, 01h, 01h, 00h, 08h, 88h, 88h, 80h
	defb	05h, 55h, 55h, 50h, 55h, 55h, 55h, 55h
	defb	58h, 55h, 55h, 85h, 55h, 85h, 58h, 55h
	defb	58h, 55h, 55h, 85h, 55h, 55h, 55h, 55h
	defb	05h, 55h, 55h, 50h, 05h, 55h, 55h, 50h
	defb	00h, 55h, 55h, 00h, 00h, 05h, 50h, 00h
	defb	00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h
	defb	00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h
	defb	00h, 00h, 00h, 00h, 00h, 00h, 22h, 00h
	defb	00h, 02h, 20h, 00h, 00h, 22h, 20h, 00h
	defb	00h, 23h, 20h, 00h, 02h, 33h, 20h, 00h
	defb	02h, 36h, 32h, 00h, 02h, 33h, 20h, 00h
	defb	00h, 22h, 20h, 00h, 00h, 22h, 00h, 00h
	defb	00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h
	defb	00h, 00h, 00h, 00h, 04h, 44h, 44h, 40h
	defb	04h, 44h, 44h, 40h, 41h, 41h, 44h, 44h
	defb	41h, 41h, 44h, 44h, 41h, 41h, 0ddh, 0d4h
	defb	41h, 41h, 0ddh, 0d4h, 41h, 41h, 0d4h, 0d4h
	defb	41h, 41h, 0d4h, 0d4h, 41h, 11h, 0ddh, 0d4h
	defb	41h, 11h, 0ddh, 0d4h, 44h, 44h, 0d4h, 44h
	defb	44h, 44h, 0d4h, 44h, 04h, 44h, 44h, 40h
	defb	04h, 44h, 44h, 40h, 00h, 00h, 00h, 00h
