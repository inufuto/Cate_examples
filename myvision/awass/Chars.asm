cseg

MonoPattern: public MonoPattern
; ascii 28
	; " -0123456789:ACEFGHIMNORSTUV"
	defb 00h,00h,00h,00h,00h,00h,00h,00h
	defb 00h,00h,00h,7eh,00h,00h,00h,00h
	defb 3eh,63h,67h,6bh,73h,63h,3eh,00h
	defb 18h,78h,18h,18h,18h,18h,7eh,00h
	defb 3eh,63h,07h,1eh,3ch,70h,7fh,00h
	defb 3eh,63h,03h,1eh,03h,63h,3eh,00h
	defb 06h,0eh,1eh,36h,66h,7fh,06h,00h
	defb 7fh,60h,7eh,03h,03h,63h,3eh,00h
	defb 1eh,30h,60h,7eh,63h,63h,3eh,00h
	defb 7fh,63h,06h,0ch,18h,18h,18h,00h
	defb 3eh,63h,63h,3eh,63h,63h,3eh,00h
	defb 3eh,63h,63h,3fh,03h,63h,3eh,00h
	defb 00h,00h,18h,00h,00h,18h,00h,00h
	defb 1ch,36h,63h,63h,7fh,63h,63h,00h
	defb 1eh,33h,60h,60h,60h,33h,1eh,00h
	defb 7eh,60h,60h,7eh,60h,60h,7eh,00h
	defb 7eh,60h,60h,7eh,60h,60h,60h,00h
	defb 1eh,33h,60h,6fh,63h,33h,1fh,00h
	defb 63h,63h,63h,7fh,63h,63h,63h,00h
	defb 7eh,18h,18h,18h,18h,18h,7eh,00h
	defb 7eh,6bh,6bh,6bh,6bh,6bh,6bh,00h
	defb 63h,73h,7bh,7fh,6fh,67h,63h,00h
	defb 3eh,63h,63h,63h,63h,63h,3eh,00h
	defb 7eh,63h,63h,67h,7ch,6eh,67h,00h
	defb 3eh,63h,60h,3eh,03h,63h,3eh,00h
	defb 7eh,18h,18h,18h,18h,18h,18h,00h
	defb 63h,63h,63h,63h,63h,63h,3eh,00h
	defb 63h,63h,63h,36h,36h,1ch,1ch,00h
; logo
	defb 0f0h,0f0h,0f0h,0f0h,00h,00h,00h,00h
	defb 00h,00h,00h,00h,0f0h,0f0h,0f0h,0f0h
	defb 0f0h,0f0h,0f0h,0f0h,0f0h,0f0h,0f0h,0f0h
	defb 0fh,0fh,0fh,0fh,00h,00h,00h,00h
	defb 0ffh,0ffh,0ffh,0ffh,00h,00h,00h,00h
	defb 0fh,0fh,0fh,0fh,0f0h,0f0h,0f0h,0f0h
	defb 0ffh,0ffh,0ffh,0ffh,0f0h,0f0h,0f0h,0f0h
	defb 00h,00h,00h,00h,0fh,0fh,0fh,0fh
	defb 0f0h,0f0h,0f0h,0f0h,0fh,0fh,0fh,0fh
	defb 00h,00h,00h,00h,0ffh,0ffh,0ffh,0ffh
	defb 0f0h,0f0h,0f0h,0f0h,0ffh,0ffh,0ffh,0ffh
	defb 0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh
	defb 0ffh,0ffh,0ffh,0ffh,0fh,0fh,0fh,0fh
	defb 0fh,0fh,0fh,0fh,0ffh,0ffh,0ffh,0ffh
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh
;	8dot
	defb	60h, 7fh, 7fh, 60h, 60h, 7fh, 7fh, 60h
	defb	06h, 0feh, 0feh, 06h, 06h, 0feh, 0feh, 06h
	defb	0ffh, 0ffh, 0ffh, 0ffh, 00h, 00h, 00h, 00h
;	16dot
	defb	7fh, 0c0h, 80h, 81h, 87h, 8fh, 9fh, 0bfh
	defb	0fch, 06h, 0e2h, 12h, 0c2h, 0a2h, 0d2h, 0fah
	defb	0bfh, 0bfh, 0bfh, 9fh, 8fh, 87h, 0c0h, 7fh
	defb	0fah, 0fah, 0fah, 0f2h, 0e2h, 0c2h, 06h, 0fch
	defb	00h, 07h, 07h, 07h, 07h, 07h, 07h, 07h
	defb	00h, 0f8h, 0f8h, 0f8h, 0f8h, 0f8h, 0f8h, 0f8h
	defb	04h, 04h, 04h, 04h, 04h, 04h, 0eh, 1fh
	defb	00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h
	defb	00h, 07h, 07h, 07h, 07h, 07h, 07h, 06h
	defb	00h, 0f8h, 0f0h, 0e0h, 0c0h, 80h, 00h, 00h
	defb	04h, 04h, 04h, 04h, 04h, 04h, 0eh, 1fh
	defb	00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h
	defb	00h, 06h, 07h, 07h, 07h, 07h, 07h, 06h
	defb	00h, 00h, 80h, 0e0h, 0f8h, 0e0h, 80h, 00h
	defb	04h, 04h, 04h, 04h, 04h, 04h, 0eh, 1fh
	defb	00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h
	defb	00h, 06h, 07h, 07h, 07h, 07h, 07h, 07h
	defb	00h, 00h, 00h, 80h, 0c0h, 0e0h, 0f0h, 0f8h
	defb	04h, 04h, 04h, 04h, 04h, 04h, 0eh, 1fh
	defb	00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h
	defb	00h, 07h, 0fh, 0ah, 0ah, 0fh, 07h, 0fh
	defb	00h, 80h, 0c0h, 0c0h, 0c0h, 0c0h, 80h, 0c0h
	defb	1fh, 37h, 37h, 04h, 0ch, 0ch, 0ch, 0ch
	defb	0e0h, 0b0h, 0b0h, 80h, 0c0h, 0c0h, 0c0h, 0c0h

SpritePattern: public SpritePattern
;	sprite
	defb	00h, 07h, 0fh, 0ah, 0ah, 0fh, 07h, 00h
	defb	1fh, 37h, 37h, 04h, 0ch, 0ch, 0ch, 0ch
	defb	00h, 80h, 0c0h, 0c0h, 0c0h, 0c0h, 80h, 00h
	defb	0e0h, 0b0h, 0b0h, 80h, 0c0h, 0c0h, 0c0h, 0c0h
	defb	00h, 07h, 0fh, 0ah, 0ah, 0fh, 07h, 03h
	defb	07h, 37h, 37h, 07h, 0eh, 1ch, 38h, 10h
	defb	00h, 80h, 0c0h, 0c0h, 0c0h, 0c0h, 80h, 80h
	defb	0e0h, 0f0h, 0b0h, 00h, 0e0h, 0e0h, 00h, 00h
	defb	00h, 07h, 0fh, 0ah, 0ah, 0fh, 07h, 03h
	defb	03h, 03h, 07h, 06h, 00h, 06h, 06h, 06h
	defb	00h, 80h, 0c0h, 0c0h, 0c0h, 0c0h, 80h, 80h
	defb	00h, 00h, 00h, 00h, 80h, 80h, 80h, 00h
	defb	00h, 07h, 0fh, 0ah, 0ah, 0fh, 07h, 03h
	defb	07h, 1eh, 1dh, 03h, 05h, 0eh, 1ch, 08h
	defb	00h, 80h, 0c0h, 0c0h, 0c0h, 0c0h, 80h, 80h
	defb	0a0h, 0b0h, 0b0h, 80h, 0f0h, 70h, 00h, 00h
	defb	00h, 01h, 03h, 03h, 03h, 03h, 01h, 00h
	defb	07h, 0dh, 0dh, 01h, 03h, 03h, 03h, 03h
	defb	00h, 0e0h, 0f0h, 50h, 50h, 0f0h, 0e0h, 00h
	defb	0f8h, 0ech, 0ech, 20h, 30h, 30h, 30h, 30h
	defb	00h, 01h, 03h, 03h, 03h, 03h, 01h, 01h
	defb	07h, 0fh, 0dh, 00h, 07h, 07h, 00h, 00h
	defb	00h, 0e0h, 0f0h, 50h, 50h, 0f0h, 0e0h, 0c0h
	defb	0e0h, 0ech, 0ech, 0e0h, 70h, 38h, 1ch, 08h
	defb	00h, 01h, 03h, 03h, 03h, 03h, 01h, 01h
	defb	00h, 00h, 00h, 00h, 01h, 01h, 01h, 00h
	defb	00h, 0e0h, 0f0h, 50h, 50h, 0f0h, 0e0h, 0c0h
	defb	0c0h, 0c0h, 0e0h, 60h, 00h, 60h, 60h, 60h
	defb	00h, 01h, 03h, 03h, 03h, 03h, 01h, 01h
	defb	05h, 0dh, 0dh, 01h, 0fh, 0eh, 00h, 00h
	defb	00h, 0e0h, 0f0h, 50h, 50h, 0f0h, 0e0h, 0c0h
	defb	0e0h, 78h, 0b8h, 0c0h, 0a0h, 70h, 38h, 10h
	defb	00h, 07h, 0fh, 0fh, 0fh, 0fh, 07h, 30h
	defb	3fh, 3fh, 17h, 07h, 06h, 0eh, 00h, 00h
	defb	00h, 80h, 0c0h, 0c0h, 0d8h, 0d8h, 98h, 30h
	defb	0e0h, 0c0h, 0c0h, 0c0h, 0c0h, 0c0h, 0c0h, 0e0h
	defb	00h, 03h, 07h, 07h, 37h, 37h, 33h, 18h
	defb	0fh, 07h, 07h, 07h, 06h, 06h, 06h, 0eh
	defb	00h, 0c0h, 0e0h, 0e0h, 0e0h, 0e0h, 0c0h, 18h
	defb	0f8h, 0f8h, 0d0h, 0c0h, 0c0h, 0e0h, 00h, 00h
	defb	00h, 00h, 00h, 00h, 00h, 00h, 3ch, 7eh
	defb	66h, 7eh, 66h, 3ch, 00h, 00h, 00h, 00h
	defb	00h, 00h, 00h, 00h, 60h, 0e0h, 8fh, 0ffh
	defb	0e0h, 0e0h, 0ffh, 8fh, 0e0h, 60h, 00h, 00h
	defb	03h, 03h, 03h, 03h, 01h, 0dh, 0dh, 07h
	defb	00h, 01h, 03h, 03h, 03h, 03h, 01h, 00h
	defb	30h, 30h, 30h, 30h, 20h, 0ech, 0ech, 0f8h
	defb	00h, 0e0h, 0f0h, 50h, 50h, 0f0h, 0e0h, 00h
	defb	00h, 00h, 06h, 07h, 0f1h, 0ffh, 07h, 07h
	defb	0ffh, 0f1h, 07h, 06h, 00h, 00h, 00h, 00h
	defb	00h, 00h, 00h, 00h, 3ch, 66h, 7eh, 66h
	defb	7eh, 3ch, 00h, 00h, 00h, 00h, 00h, 00h
	defb	04h, 06h, 0fh, 1ah, 1ah, 1fh, 15h, 50h
	defb	6fh, 3fh, 1fh, 0fh, 07h, 03h, 01h, 00h
	defb	80h, 0c0h, 0e0h, 0f0h, 0f0h, 0f0h, 70h, 76h
	defb	0eeh, 0fch, 0f8h, 0f0h, 0e0h, 0e0h, 0f0h, 78h
	defb	00h, 04h, 06h, 0fh, 1ah, 1ah, 1fh, 15h
	defb	10h, 3fh, 7fh, 0dfh, 0fh, 07h, 03h, 01h
	defb	00h, 80h, 0c0h, 0e0h, 0f0h, 0f0h, 0f0h, 70h
	defb	70h, 0f8h, 0fch, 0f6h, 0f0h, 0e0h, 0f6h, 0fch
	defb	01h, 03h, 07h, 0fh, 0fh, 0fh, 0eh, 6eh
	defb	77h, 3fh, 1fh, 0fh, 07h, 07h, 0fh, 1eh
	defb	20h, 60h, 0f0h, 58h, 58h, 0f8h, 0a8h, 0ah
	defb	0f6h, 0fch, 0f8h, 0f0h, 0e0h, 0c0h, 80h, 00h
	defb	00h, 01h, 03h, 07h, 0fh, 0fh, 0fh, 0eh
	defb	0eh, 1fh, 3fh, 6fh, 0fh, 07h, 6fh, 3fh
	defb	00h, 20h, 60h, 0f0h, 58h, 58h, 0f8h, 0a8h
	defb	08h, 0fch, 0feh, 0fbh, 0f0h, 0e0h, 0c0h, 80h
	defb	02h, 06h, 0fh, 1fh, 1fh, 1fh, 1fh, 5fh
	defb	6fh, 3fh, 1fh, 0fh, 0fh, 07h, 03h, 01h
	defb	40h, 60h, 0f0h, 0f8h, 0f8h, 0f8h, 0f8h, 0fah
	defb	0f6h, 0fch, 0f8h, 0f0h, 0f0h, 0e0h, 0c0h, 80h
	defb	00h, 02h, 06h, 0fh, 1fh, 1fh, 1fh, 1fh
	defb	1fh, 0fh, 3fh, 6fh, 0fh, 0fh, 07h, 03h
	defb	00h, 40h, 60h, 0f0h, 0f8h, 0f8h, 0f8h, 0f8h
	defb	0f8h, 0f0h, 0fch, 0f6h, 0f0h, 0f0h, 0e0h, 0c0h
	defb	02h, 06h, 0fh, 1dh, 1dh, 1fh, 1ah, 58h
	defb	6fh, 3fh, 1fh, 0fh, 0fh, 07h, 03h, 01h
	defb	40h, 60h, 0f0h, 0b8h, 0b8h, 0f8h, 58h, 1ah
	defb	0f6h, 0fch, 0f8h, 0f0h, 0f0h, 0e0h, 0c0h, 80h
	defb	00h, 02h, 06h, 0fh, 1dh, 1dh, 1fh, 1ah
	defb	18h, 0fh, 3fh, 6fh, 0fh, 0fh, 07h, 03h
	defb	00h, 40h, 60h, 0f0h, 0b8h, 0b8h, 0f8h, 58h
	defb	18h, 0f0h, 0fch, 0f6h, 0f0h, 0f0h, 0e0h, 0c0h
	defb	00h, 00h, 00h, 00h, 11h, 32h, 12h, 12h
	defb	12h, 12h, 39h, 00h, 00h, 00h, 00h, 00h
	defb	00h, 00h, 00h, 00h, 8ch, 52h, 52h, 52h
	defb	52h, 52h, 8ch, 00h, 00h, 00h, 00h, 00h
	defb	00h, 00h, 00h, 00h, 31h, 4ah, 0ah, 12h
	defb	22h, 42h, 79h, 00h, 00h, 00h, 00h, 00h
	defb	00h, 00h, 00h, 00h, 8ch, 52h, 52h, 52h
	defb	52h, 52h, 8ch, 00h, 00h, 00h, 00h, 00h
	defb	00h, 00h, 00h, 00h, 31h, 52h, 52h, 52h
	defb	7ah, 12h, 11h, 00h, 00h, 00h, 00h, 00h
	defb	00h, 00h, 00h, 00h, 8ch, 52h, 52h, 52h
	defb	52h, 52h, 8ch, 00h, 00h, 00h, 00h, 00h
	defb	00h, 00h, 00h, 00h, 31h, 4ah, 4ah, 32h
	defb	4ah, 4ah, 31h, 00h, 00h, 00h, 00h, 00h
	defb	00h, 00h, 00h, 00h, 8ch, 52h, 52h, 52h
	defb	52h, 52h, 8ch, 00h, 00h, 00h, 00h, 00h
	defb	01h, 21h, 33h, 3eh, 24h, 0e1h, 77h, 3bh
	defb	1bh, 30h, 0e2h, 6eh, 3eh, 1bh, 11h, 01h
	defb	04h, 9ch, 0f8h, 0f9h, 6fh, 0eh, 9ch, 0b8h
	defb	0dch, 0cfh, 0eh, 48h, 0ech, 0fch, 8ch, 00h
