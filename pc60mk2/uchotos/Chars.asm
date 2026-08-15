cseg

MonoPattern: public MonoPattern
; ascii 30
	; " -0123456789ACEFGHIKMNOPRSTUVY"
	defb 00h,00h,00h,00h,00h,0eh,00h,00h
	defb 4ah,0aah,0aah,40h,22h,22h,22h,20h
	defb 4ah,22h,48h,0e0h,4ah,24h,2ah,40h
	defb 2ah,0aeh,22h,20h,0e8h,8ch,22h,0c0h
	defb 4ah,8ch,0aah,40h,0eah,24h,44h,40h
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
;	sprite
	defb	00h, 00h, 03h, 03h, 0fh, 0fh, 03h, 0bh
	defb	03h, 0bh, 0fh, 0fh, 03h, 03h, 0ah, 0ah
	defb	00h, 00h, 0c0h, 0c0h, 0f0h, 0f0h, 30h, 0b0h
	defb	30h, 0b0h, 0f0h, 0f0h, 0c0h, 0c0h, 0a0h, 0a0h
	defb	2ah, 2ah, 22h, 22h, 22h, 02h, 01h, 02h
	defb	04h, 08h, 04h, 08h, 04h, 08h, 08h, 00h
	defb	0a8h, 0a8h, 88h, 88h, 88h, 80h, 40h, 80h
	defb	10h, 20h, 10h, 20h, 10h, 20h, 20h, 00h
	defb	00h, 00h, 03h, 03h, 0fh, 0fh, 03h, 0bh
	defb	03h, 0bh, 0fh, 0fh, 03h, 03h, 02h, 02h
	defb	00h, 00h, 0c0h, 0c0h, 0f0h, 0f0h, 30h, 0b0h
	defb	30h, 0b0h, 0f0h, 0f0h, 0c0h, 0c0h, 0a0h, 0a0h
	defb	22h, 0ah, 22h, 0ah, 02h, 02h, 01h, 02h
	defb	04h, 08h, 04h, 08h, 10h, 20h, 20h, 00h
	defb	0a8h, 0a8h, 88h, 88h, 88h, 80h, 40h, 80h
	defb	14h, 28h, 18h, 20h, 00h, 00h, 00h, 00h
	defb	00h, 00h, 03h, 03h, 0fh, 0fh, 03h, 0bh
	defb	03h, 0bh, 0fh, 0fh, 03h, 03h, 00h, 02h
	defb	00h, 00h, 0c0h, 0c0h, 0f0h, 0f0h, 30h, 0b0h
	defb	30h, 0b0h, 0f0h, 0f0h, 0c0h, 0c0h, 80h, 80h
	defb	00h, 02h, 02h, 02h, 02h, 02h, 02h, 00h
	defb	00h, 02h, 01h, 02h, 01h, 02h, 02h, 00h
	defb	80h, 80h, 80h, 80h, 00h, 80h, 00h, 00h
	defb	00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h
	defb	00h, 00h, 03h, 03h, 0fh, 0fh, 03h, 0bh
	defb	03h, 0bh, 0fh, 0fh, 03h, 03h, 02h, 02h
	defb	00h, 00h, 0c0h, 0c0h, 0f0h, 0f0h, 30h, 0b0h
	defb	30h, 0b0h, 0f0h, 0f0h, 0c0h, 0c0h, 80h, 80h
	defb	2ah, 0ah, 28h, 0ah, 02h, 02h, 01h, 02h
	defb	04h, 0ah, 04h, 08h, 04h, 08h, 08h, 00h
	defb	00h, 80h, 88h, 0a8h, 88h, 0a0h, 40h, 80h
	defb	54h, 0a8h, 18h, 20h, 00h, 00h, 00h, 00h
	defb	00h, 00h, 03h, 03h, 0fh, 0fh, 0ch, 0eh
	defb	0ch, 0eh, 0fh, 0fh, 03h, 03h, 0ah, 0ah
	defb	00h, 00h, 0c0h, 0c0h, 0f0h, 0f0h, 0c0h, 0e0h
	defb	0c0h, 0e0h, 0f0h, 0f0h, 0c0h, 0c0h, 0a0h, 0a0h
	defb	2ah, 2ah, 22h, 22h, 22h, 02h, 01h, 02h
	defb	04h, 08h, 04h, 08h, 04h, 08h, 08h, 00h
	defb	0a8h, 0a8h, 88h, 88h, 88h, 80h, 40h, 80h
	defb	10h, 20h, 10h, 20h, 10h, 20h, 20h, 00h
	defb	00h, 00h, 03h, 03h, 0fh, 0fh, 0ch, 0eh
	defb	0ch, 0eh, 0fh, 0fh, 03h, 03h, 0ah, 0ah
	defb	00h, 00h, 0c0h, 0c0h, 0f0h, 0f0h, 0c0h, 0e0h
	defb	0c0h, 0e0h, 0f0h, 0f0h, 0c0h, 0c0h, 80h, 80h
	defb	2ah, 2ah, 22h, 22h, 22h, 02h, 01h, 02h
	defb	14h, 28h, 24h, 08h, 00h, 00h, 00h, 00h
	defb	88h, 0a0h, 88h, 0a0h, 80h, 80h, 40h, 80h
	defb	10h, 20h, 10h, 20h, 04h, 08h, 08h, 00h
	defb	00h, 00h, 03h, 03h, 0fh, 0fh, 0ch, 0eh
	defb	0ch, 0eh, 0fh, 0fh, 03h, 03h, 02h, 02h
	defb	00h, 00h, 0c0h, 0c0h, 0f0h, 0f0h, 0c0h, 0e0h
	defb	0c0h, 0e0h, 0f0h, 0f0h, 0c0h, 0c0h, 00h, 80h
	defb	02h, 02h, 02h, 02h, 00h, 02h, 00h, 00h
	defb	00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h
	defb	00h, 80h, 80h, 80h, 80h, 80h, 80h, 00h
	defb	00h, 80h, 40h, 80h, 40h, 80h, 80h, 00h
	defb	00h, 00h, 03h, 03h, 0fh, 0fh, 0ch, 0eh
	defb	0ch, 0eh, 0fh, 0fh, 03h, 03h, 02h, 02h
	defb	00h, 00h, 0c0h, 0c0h, 0f0h, 0f0h, 0c0h, 0e0h
	defb	0c0h, 0e0h, 0f0h, 0f0h, 0c0h, 0c0h, 80h, 80h
	defb	00h, 02h, 22h, 2ah, 22h, 0ah, 01h, 02h
	defb	15h, 2ah, 24h, 08h, 00h, 00h, 00h, 00h
	defb	0a8h, 0a0h, 28h, 0a0h, 80h, 80h, 40h, 80h
	defb	10h, 0a0h, 10h, 20h, 10h, 20h, 20h, 00h
	defb	00h, 00h, 03h, 03h, 0fh, 0fh, 0fh, 0fh
	defb	0fh, 0fh, 0fh, 0fh, 03h, 03h, 22h, 02h
	defb	00h, 00h, 0c0h, 0c0h, 0f0h, 0f0h, 0f0h, 0f0h
	defb	0f8h, 0f0h, 0f8h, 0f0h, 0c8h, 0c8h, 0a0h, 0a0h
	defb	2ah, 0ah, 0ah, 0ah, 02h, 02h, 01h, 02h
	defb	04h, 08h, 04h, 08h, 08h, 00h, 00h, 00h
	defb	0a0h, 0a0h, 80h, 80h, 80h, 80h, 40h, 80h
	defb	50h, 0a0h, 10h, 20h, 10h, 20h, 20h, 00h
	defb	00h, 00h, 03h, 03h, 0fh, 0fh, 0fh, 0fh
	defb	2fh, 0fh, 2fh, 0fh, 23h, 23h, 0ah, 0ah
	defb	00h, 00h, 0c0h, 0c0h, 0f0h, 0f0h, 0f0h, 0f0h
	defb	0f0h, 0f0h, 0f0h, 0f0h, 0c0h, 0c0h, 88h, 80h
	defb	0ah, 0ah, 02h, 02h, 02h, 02h, 01h, 02h
	defb	05h, 0ah, 04h, 08h, 04h, 08h, 08h, 00h
	defb	0a8h, 0a0h, 0a0h, 0a0h, 80h, 80h, 40h, 80h
	defb	10h, 20h, 10h, 20h, 20h, 00h, 00h, 00h
	defb	05h, 0fh, 05h, 0fh, 15h, 3fh, 15h, 3fh
	defb	55h, 0ffh, 44h, 0eeh, 44h, 0eeh, 44h, 0eeh
	defb	40h, 0c0h, 50h, 0f0h, 50h, 0f0h, 54h, 0fch
	defb	54h, 0fch, 55h, 0ffh, 55h, 0ffh, 55h, 0ffh
	defb	55h, 0ffh, 15h, 3fh, 00h, 2ah, 11h, 11h
	defb	11h, 11h, 11h, 11h, 04h, 04h, 00h, 00h
	defb	54h, 0fch, 50h, 0f0h, 00h, 0a0h, 10h, 10h
	defb	10h, 10h, 10h, 10h, 44h, 44h, 00h, 00h
	defb	00h, 00h, 05h, 0fh, 05h, 0fh, 15h, 3fh
	defb	15h, 3fh, 55h, 0ffh, 44h, 0eeh, 44h, 0eeh
	defb	00h, 00h, 40h, 0c0h, 50h, 0f0h, 50h, 0f0h
	defb	54h, 0fch, 54h, 0fch, 55h, 0ffh, 55h, 0ffh
	defb	44h, 0eeh, 55h, 0ffh, 00h, 2ah, 11h, 11h
	defb	11h, 11h, 11h, 11h, 04h, 04h, 00h, 00h
	defb	55h, 0ffh, 54h, 0fch, 00h, 0a0h, 10h, 10h
	defb	10h, 10h, 10h, 10h, 44h, 44h, 00h, 00h
	defb	01h, 03h, 05h, 0fh, 05h, 0fh, 15h, 3fh
	defb	15h, 3fh, 55h, 0ffh, 55h, 0ffh, 55h, 0ffh
	defb	50h, 0f0h, 50h, 0f0h, 54h, 0fch, 54h, 0fch
	defb	55h, 0ffh, 11h, 0bbh, 11h, 0bbh, 11h, 0bbh
	defb	15h, 3fh, 05h, 0fh, 00h, 0ah, 04h, 04h
	defb	04h, 04h, 04h, 04h, 11h, 11h, 00h, 00h
	defb	55h, 0ffh, 54h, 0fch, 00h, 0a8h, 44h, 44h
	defb	44h, 44h, 44h, 44h, 10h, 10h, 00h, 00h
	defb	00h, 00h, 01h, 03h, 05h, 0fh, 05h, 0fh
	defb	15h, 3fh, 15h, 3fh, 55h, 0ffh, 55h, 0ffh
	defb	00h, 00h, 50h, 0f0h, 50h, 0f0h, 54h, 0fch
	defb	54h, 0fch, 55h, 0ffh, 11h, 0bbh, 11h, 0bbh
	defb	55h, 0ffh, 15h, 3fh, 00h, 0ah, 04h, 04h
	defb	04h, 04h, 04h, 04h, 11h, 11h, 00h, 00h
	defb	11h, 0bbh, 55h, 0ffh, 00h, 0a8h, 44h, 44h
	defb	44h, 44h, 44h, 44h, 10h, 10h, 00h, 00h
	defb	00h, 00h, 04h, 04h, 11h, 11h, 11h, 11h
	defb	11h, 11h, 00h, 2ah, 15h, 3fh, 55h, 0ffh
	defb	00h, 00h, 44h, 44h, 10h, 10h, 10h, 10h
	defb	10h, 10h, 00h, 0a8h, 54h, 0fch, 55h, 0ffh
	defb	45h, 0efh, 51h, 0fbh, 45h, 0efh, 55h, 0ffh
	defb	15h, 3fh, 15h, 3fh, 05h, 0fh, 01h, 03h
	defb	51h, 0fbh, 45h, 0efh, 51h, 0fbh, 55h, 0ffh
	defb	54h, 0fch, 54h, 0fch, 50h, 0f0h, 40h, 0c0h
	defb	00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h
	defb	00h, 00h, 00h, 00h, 02h, 02h, 0ah, 0ah
	defb	00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h
	defb	00h, 00h, 0a0h, 0a0h, 80h, 80h, 80h, 80h
	defb	0ah, 08h, 2ah, 20h, 2ah, 23h, 2ah, 20h
	defb	0ah, 0ah, 0ah, 0ah, 00h, 00h, 00h, 00h
	defb	80h, 80h, 80h, 80h, 0a0h, 20h, 80h, 80h
	defb	80h, 80h, 00h, 00h, 00h, 00h, 00h, 00h
	defb	00h, 00h, 2ah, 15h, 2ah, 15h, 99h, 55h
	defb	99h, 55h, 99h, 55h, 99h, 55h, 99h, 55h
	defb	00h, 00h, 0a8h, 54h, 0a8h, 54h, 0aah, 55h
	defb	0aah, 55h, 56h, 0a9h, 56h, 0a9h, 66h, 99h
	defb	99h, 55h, 95h, 55h, 95h, 55h, 0aah, 55h
	defb	0aah, 55h, 2ah, 15h, 2ah, 15h, 00h, 00h
	defb	66h, 99h, 56h, 0a9h, 56h, 0a9h, 6ah, 95h
	defb	6ah, 95h, 0a8h, 54h, 0a8h, 54h, 00h, 00h
