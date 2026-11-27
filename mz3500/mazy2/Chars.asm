cseg

MonoPattern: public MonoPattern
; ascii 30
	; " -0123456789ACEFGHIKMNOPRSTUVY"
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
	defb 1ch,36h,63h,63h,7fh,63h,63h,00h
	defb 1eh,33h,60h,60h,60h,33h,1eh,00h
	defb 7eh,60h,60h,7eh,60h,60h,7eh,00h
	defb 7eh,60h,60h,7eh,60h,60h,60h,00h
	defb 1eh,33h,60h,6fh,63h,33h,1fh,00h
	defb 63h,63h,63h,7fh,63h,63h,63h,00h
	defb 7eh,18h,18h,18h,18h,18h,7eh,00h
	defb 63h,66h,6ch,78h,6ch,66h,63h,00h
	defb 7eh,6bh,6bh,6bh,6bh,6bh,6bh,00h
	defb 63h,73h,7bh,7fh,6fh,67h,63h,00h
	defb 3eh,63h,63h,63h,63h,63h,3eh,00h
	defb 7eh,63h,63h,63h,7eh,60h,60h,00h
	defb 7eh,63h,63h,67h,7ch,6eh,67h,00h
	defb 3eh,63h,60h,3eh,03h,63h,3eh,00h
	defb 7eh,18h,18h,18h,18h,18h,18h,00h
	defb 63h,63h,63h,63h,63h,63h,3eh,00h
	defb 63h,63h,63h,36h,36h,1ch,1ch,00h
	defb 66h,66h,66h,3ch,18h,18h,18h,00h
;	logo
	defb 00h,00h,00h,00h,00h,00h,00h,00h
	defb	0f0h, 0f0h, 0f0h, 0f0h, 00h, 00h, 00h, 00h
	defb	00h, 00h, 00h, 00h, 0f0h, 0f0h, 0f0h, 0f0h
	defb	0f0h, 0f0h, 0f0h, 0f0h, 0f0h, 0f0h, 0f0h, 0f0h
	defb	0fh, 0fh, 0fh, 0fh, 00h, 00h, 00h, 00h
	defb	0ffh, 0ffh, 0ffh, 0ffh, 00h, 00h, 00h, 00h
	defb	0fh, 0fh, 0fh, 0fh, 0f0h, 0f0h, 0f0h, 0f0h
	defb	0ffh, 0ffh, 0ffh, 0ffh, 0f0h, 0f0h, 0f0h, 0f0h
	defb	00h, 00h, 00h, 00h, 0fh, 0fh, 0fh, 0fh
	defb	0f0h, 0f0h, 0f0h, 0f0h, 0fh, 0fh, 0fh, 0fh
	defb	00h, 00h, 00h, 00h, 0ffh, 0ffh, 0ffh, 0ffh
	defb	0f0h, 0f0h, 0f0h, 0f0h, 0ffh, 0ffh, 0ffh, 0ffh
	defb	0fh, 0fh, 0fh, 0fh, 0fh, 0fh, 0fh, 0fh
	defb	0ffh, 0ffh, 0ffh, 0ffh, 0fh, 0fh, 0fh, 0fh
	defb	0fh, 0fh, 0fh, 0fh, 0ffh, 0ffh, 0ffh, 0ffh
	defb	0ffh, 0ffh, 0ffh, 0ffh, 0ffh, 0ffh, 0ffh, 0ffh
;	mono16
	defb	0ffh, 80h, 80h, 80h, 80h, 80h, 80h, 80h
	defb	0ffh, 01h, 01h, 01h, 01h, 1dh, 1dh, 1dh
	defb	81h, 81h, 81h, 9dh, 9dh, 9dh, 80h, 0ffh
	defb	0ddh, 0ddh, 0ddh, 0ddh, 0ddh, 0ddh, 01h, 0ffh
	defb	00h, 00h, 00h, 00h, 00h, 0eh, 0eh, 6eh
	defb	00h, 0eh, 0eh, 0eeh, 0eeh, 0eeh, 0eeh, 0e0h
	defb	6eh, 6eh, 6eh, 60h, 6fh, 0fh, 7fh, 00h
	defb	0eeh, 0eh, 0feh, 0feh, 0feh, 0feh, 0feh, 00h
	defb	00h, 3fh, 3fh, 3fh, 3fh, 3fh, 3fh, 3fh
	defb	00h, 0fch, 0fch, 0fch, 0fch, 0fch, 0ech, 0d4h
	defb	3fh, 3fh, 3fh, 3fh, 3fh, 3fh, 3fh, 00h
	defb	0d4h, 0ech, 0fch, 0fch, 0fch, 0fch, 0fch, 00h
	defb	00h, 00h, 00h, 00h, 11h, 32h, 12h, 12h
	defb	00h, 00h, 00h, 00h, 8ch, 52h, 52h, 52h
	defb	12h, 12h, 39h, 00h, 00h, 00h, 00h, 00h
	defb	52h, 52h, 8ch, 00h, 00h, 00h, 00h, 00h
	defb	00h, 00h, 00h, 00h, 31h, 4ah, 0ah, 12h
	defb	00h, 00h, 00h, 00h, 8ch, 52h, 52h, 52h
	defb	22h, 42h, 79h, 00h, 00h, 00h, 00h, 00h
	defb	52h, 52h, 8ch, 00h, 00h, 00h, 00h, 00h
	defb	00h, 00h, 00h, 00h, 31h, 52h, 52h, 52h
	defb	00h, 00h, 00h, 00h, 8ch, 52h, 52h, 52h
	defb	7ah, 12h, 11h, 00h, 00h, 00h, 00h, 00h
	defb	52h, 52h, 8ch, 00h, 00h, 00h, 00h, 00h
	defb	00h, 00h, 00h, 00h, 31h, 4ah, 4ah, 32h
	defb	00h, 00h, 00h, 00h, 8ch, 52h, 52h, 52h
	defb	4ah, 4ah, 31h, 00h, 00h, 00h, 00h, 00h
	defb	52h, 52h, 8ch, 00h, 00h, 00h, 00h, 00h

ColorPattern: public ColorPattern
;	knife
	defb	00h, 00h, 04h, 7fh, 3fh, 04h, 00h, 00h
	defb	00h, 00h, 04h, 07h, 07h, 04h, 00h, 00h
	defb	00h, 00h, 04h, 7fh, 3fh, 04h, 00h, 00h
	defb	00h, 00h, 20h, 0feh, 0fch, 20h, 00h, 00h
	defb	00h, 00h, 20h, 0e0h, 0e0h, 20h, 00h, 00h
	defb	00h, 00h, 20h, 0feh, 0fch, 20h, 00h, 00h
	defb	00h, 08h, 18h, 18h, 18h, 3ch, 18h, 18h
	defb	00h, 00h, 00h, 00h, 00h, 3ch, 18h, 18h
	defb	00h, 08h, 18h, 18h, 18h, 3ch, 18h, 18h
	defb	18h, 18h, 3ch, 18h, 18h, 18h, 10h, 00h
	defb	18h, 18h, 3ch, 00h, 00h, 00h, 00h, 00h
	defb	18h, 18h, 3ch, 18h, 18h, 18h, 10h, 00h
;	color16
	defb	00h, 07h, 0fh, 0ah, 0ah, 0fh, 07h, 00h
	defb	00h, 07h, 0fh, 0ah, 0ah, 0fh, 07h, 0fh
	defb	00h, 07h, 0fh, 0ah, 0ah, 0fh, 07h, 00h
	defb	00h, 80h, 0c0h, 0c0h, 0c0h, 0c0h, 80h, 00h
	defb	00h, 80h, 0c0h, 0c0h, 0c0h, 0c0h, 80h, 0c0h
	defb	00h, 80h, 0c0h, 0c0h, 0c0h, 0c0h, 80h, 00h
	defb	00h, 00h, 07h, 04h, 0ch, 0ch, 0ch, 00h
	defb	17h, 37h, 30h, 00h, 00h, 00h, 00h, 0ch
	defb	00h, 00h, 30h, 00h, 00h, 00h, 00h, 0ch
	defb	00h, 00h, 80h, 80h, 0c0h, 0c0h, 0c0h, 00h
	defb	0a0h, 0b0h, 30h, 00h, 00h, 00h, 00h, 0c0h
	defb	00h, 00h, 30h, 00h, 00h, 00h, 00h, 0c0h
	defb	00h, 07h, 0fh, 0ah, 0ah, 0fh, 07h, 00h
	defb	00h, 07h, 0fh, 0ah, 0ah, 0fh, 07h, 03h
	defb	00h, 07h, 0fh, 0ah, 0ah, 0fh, 07h, 00h
	defb	00h, 80h, 0c0h, 0c0h, 0c0h, 0c0h, 80h, 00h
	defb	00h, 80h, 0c0h, 0c0h, 0c0h, 0c0h, 80h, 80h
	defb	00h, 80h, 0c0h, 0c0h, 0c0h, 0c0h, 80h, 00h
	defb	00h, 00h, 07h, 07h, 0eh, 1ch, 18h, 00h
	defb	37h, 37h, 00h, 00h, 00h, 00h, 20h, 10h
	defb	20h, 20h, 00h, 00h, 00h, 00h, 20h, 10h
	defb	00h, 00h, 80h, 00h, 0c0h, 0c0h, 00h, 00h
	defb	0e0h, 0b0h, 30h, 00h, 20h, 20h, 00h, 00h
	defb	00h, 00h, 30h, 00h, 20h, 20h, 00h, 00h
	defb	00h, 07h, 0fh, 0ah, 0ah, 0fh, 07h, 00h
	defb	00h, 07h, 0fh, 0ah, 0ah, 0fh, 07h, 03h
	defb	00h, 07h, 0fh, 0ah, 0ah, 0fh, 07h, 00h
	defb	00h, 80h, 0c0h, 0c0h, 0c0h, 0c0h, 80h, 00h
	defb	00h, 80h, 0c0h, 0c0h, 0c0h, 0c0h, 80h, 80h
	defb	00h, 80h, 0c0h, 0c0h, 0c0h, 0c0h, 80h, 00h
	defb	00h, 00h, 00h, 00h, 00h, 06h, 06h, 00h
	defb	03h, 03h, 07h, 06h, 00h, 00h, 00h, 06h
	defb	00h, 00h, 00h, 06h, 00h, 00h, 00h, 06h
	defb	00h, 00h, 00h, 00h, 80h, 80h, 00h, 00h
	defb	00h, 00h, 00h, 00h, 00h, 00h, 80h, 00h
	defb	00h, 00h, 00h, 00h, 00h, 00h, 80h, 00h
	defb	00h, 07h, 0fh, 0ah, 0ah, 0fh, 07h, 00h
	defb	00h, 07h, 0fh, 0ah, 0ah, 0fh, 07h, 03h
	defb	00h, 07h, 0fh, 0ah, 0ah, 0fh, 07h, 00h
	defb	00h, 80h, 0c0h, 0c0h, 0c0h, 0c0h, 80h, 00h
	defb	00h, 80h, 0c0h, 0c0h, 0c0h, 0c0h, 80h, 80h
	defb	00h, 80h, 0c0h, 0c0h, 0c0h, 0c0h, 80h, 00h
	defb	00h, 00h, 01h, 03h, 05h, 0eh, 0ch, 00h
	defb	07h, 1eh, 1ch, 00h, 00h, 00h, 10h, 08h
	defb	00h, 10h, 10h, 00h, 00h, 00h, 10h, 08h
	defb	00h, 00h, 80h, 80h, 0c0h, 0c0h, 00h, 00h
	defb	0a0h, 0b0h, 30h, 00h, 20h, 20h, 00h, 00h
	defb	00h, 00h, 30h, 00h, 20h, 20h, 00h, 00h
	defb	00h, 01h, 03h, 03h, 03h, 03h, 01h, 00h
	defb	00h, 01h, 03h, 03h, 03h, 03h, 01h, 03h
	defb	00h, 01h, 03h, 03h, 03h, 03h, 01h, 00h
	defb	00h, 0e0h, 0f0h, 50h, 50h, 0f0h, 0e0h, 00h
	defb	00h, 0e0h, 0f0h, 50h, 50h, 0f0h, 0e0h, 0f0h
	defb	00h, 0e0h, 0f0h, 50h, 50h, 0f0h, 0e0h, 00h
	defb	00h, 00h, 01h, 01h, 03h, 03h, 03h, 00h
	defb	05h, 0dh, 0ch, 00h, 00h, 00h, 00h, 03h
	defb	00h, 00h, 0ch, 00h, 00h, 00h, 00h, 03h
	defb	00h, 00h, 0e0h, 20h, 30h, 30h, 30h, 00h
	defb	0e8h, 0ech, 0ch, 00h, 00h, 00h, 00h, 30h
	defb	00h, 00h, 0ch, 00h, 00h, 00h, 00h, 30h
	defb	00h, 01h, 03h, 03h, 03h, 03h, 01h, 00h
	defb	00h, 01h, 03h, 03h, 03h, 03h, 01h, 01h
	defb	00h, 01h, 03h, 03h, 03h, 03h, 01h, 00h
	defb	00h, 0e0h, 0f0h, 50h, 50h, 0f0h, 0e0h, 00h
	defb	00h, 0e0h, 0f0h, 50h, 50h, 0f0h, 0e0h, 0c0h
	defb	00h, 0e0h, 0f0h, 50h, 50h, 0f0h, 0e0h, 00h
	defb	00h, 00h, 01h, 00h, 03h, 03h, 00h, 00h
	defb	07h, 0dh, 0ch, 00h, 04h, 04h, 00h, 00h
	defb	00h, 00h, 0ch, 00h, 04h, 04h, 00h, 00h
	defb	00h, 00h, 0e0h, 0e0h, 70h, 38h, 18h, 00h
	defb	0ech, 0ech, 00h, 00h, 00h, 00h, 04h, 08h
	defb	04h, 04h, 00h, 00h, 00h, 00h, 04h, 08h
	defb	00h, 01h, 03h, 03h, 03h, 03h, 01h, 00h
	defb	00h, 01h, 03h, 03h, 03h, 03h, 01h, 01h
	defb	00h, 01h, 03h, 03h, 03h, 03h, 01h, 00h
	defb	00h, 0e0h, 0f0h, 50h, 50h, 0f0h, 0e0h, 00h
	defb	00h, 0e0h, 0f0h, 50h, 50h, 0f0h, 0e0h, 0c0h
	defb	00h, 0e0h, 0f0h, 50h, 50h, 0f0h, 0e0h, 00h
	defb	00h, 00h, 00h, 00h, 01h, 01h, 00h, 00h
	defb	00h, 00h, 00h, 00h, 00h, 00h, 01h, 00h
	defb	00h, 00h, 00h, 00h, 00h, 00h, 01h, 00h
	defb	00h, 00h, 00h, 00h, 00h, 60h, 60h, 00h
	defb	0c0h, 0c0h, 0e0h, 60h, 00h, 00h, 00h, 60h
	defb	00h, 00h, 00h, 60h, 00h, 00h, 00h, 60h
	defb	00h, 01h, 03h, 03h, 03h, 03h, 01h, 00h
	defb	00h, 01h, 03h, 03h, 03h, 03h, 01h, 01h
	defb	00h, 01h, 03h, 03h, 03h, 03h, 01h, 00h
	defb	00h, 0e0h, 0f0h, 50h, 50h, 0f0h, 0e0h, 00h
	defb	00h, 0e0h, 0f0h, 50h, 50h, 0f0h, 0e0h, 0c0h
	defb	00h, 0e0h, 0f0h, 50h, 50h, 0f0h, 0e0h, 00h
	defb	00h, 00h, 01h, 01h, 03h, 03h, 00h, 00h
	defb	05h, 0dh, 0ch, 00h, 04h, 04h, 00h, 00h
	defb	00h, 00h, 0ch, 00h, 04h, 04h, 00h, 00h
	defb	00h, 00h, 80h, 0c0h, 0a0h, 70h, 30h, 00h
	defb	0e0h, 78h, 38h, 00h, 00h, 00h, 08h, 10h
	defb	00h, 08h, 08h, 00h, 00h, 00h, 08h, 10h
	defb	00h, 00h, 00h, 00h, 3ch, 66h, 7eh, 66h
	defb	00h, 00h, 00h, 00h, 3dh, 67h, 7fh, 67h
	defb	00h, 00h, 00h, 00h, 3ch, 66h, 7eh, 66h
	defb	00h, 00h, 00h, 00h, 0eh, 3eh, 20h, 20h
	defb	00h, 00h, 60h, 0e0h, 01h, 0c1h, 0c0h, 0c0h
	defb	00h, 00h, 20h, 20h, 01h, 01h, 00h, 00h
	defb	7eh, 3ch, 00h, 00h, 00h, 00h, 00h, 00h
	defb	7fh, 3dh, 00h, 00h, 00h, 00h, 00h, 00h
	defb	7eh, 3ch, 00h, 00h, 00h, 00h, 00h, 00h
	defb	3eh, 0eh, 00h, 00h, 00h, 00h, 00h, 00h
	defb	0c1h, 01h, 0e0h, 60h, 00h, 00h, 00h, 00h
	defb	01h, 01h, 20h, 20h, 00h, 00h, 00h, 00h
	defb	00h, 00h, 00h, 00h, 3ch, 66h, 7eh, 66h
	defb	00h, 00h, 00h, 00h, 3ch, 66h, 7fh, 67h
	defb	00h, 00h, 00h, 00h, 3ch, 66h, 7eh, 66h
	defb	00h, 00h, 00h, 06h, 0eh, 3ch, 38h, 30h
	defb	00h, 00h, 0c2h, 0c1h, 00h, 0c0h, 0c0h, 0c0h
	defb	00h, 00h, 0c2h, 01h, 00h, 00h, 00h, 00h
	defb	7eh, 3ch, 00h, 00h, 00h, 00h, 00h, 00h
	defb	7fh, 3ch, 00h, 00h, 00h, 00h, 00h, 00h
	defb	7eh, 3ch, 00h, 00h, 00h, 00h, 00h, 00h
	defb	2ch, 0ch, 00h, 00h, 00h, 00h, 00h, 00h
	defb	0c0h, 80h, 0ech, 60h, 00h, 00h, 00h, 00h
	defb	00h, 00h, 2ch, 20h, 00h, 00h, 00h, 00h
	defb	00h, 00h, 00h, 00h, 3ch, 66h, 7eh, 66h
	defb	00h, 00h, 00h, 00h, 3ch, 66h, 7fh, 67h
	defb	00h, 00h, 00h, 00h, 3ch, 66h, 7eh, 66h
	defb	00h, 00h, 00h, 00h, 00h, 06h, 06h, 00h
	defb	00h, 00h, 00h, 00h, 00h, 31h, 0f1h, 0e0h
	defb	00h, 00h, 00h, 00h, 00h, 11h, 11h, 00h
	defb	7eh, 3ch, 00h, 00h, 00h, 00h, 00h, 00h
	defb	7fh, 3ch, 00h, 00h, 00h, 00h, 00h, 00h
	defb	7eh, 3ch, 00h, 00h, 00h, 00h, 00h, 00h
	defb	0ch, 00h, 00h, 00h, 00h, 00h, 00h, 00h
	defb	02h, 00h, 00h, 00h, 00h, 00h, 00h, 00h
	defb	02h, 00h, 00h, 00h, 00h, 00h, 00h, 00h
	defb	00h, 00h, 00h, 00h, 3ch, 66h, 7eh, 66h
	defb	00h, 00h, 00h, 00h, 3ch, 66h, 7fh, 67h
	defb	00h, 00h, 00h, 00h, 3ch, 66h, 7eh, 66h
	defb	00h, 00h, 00h, 00h, 06h, 0eh, 14h, 38h
	defb	00h, 00h, 00h, 62h, 61h, 0e0h, 0c0h, 80h
	defb	00h, 00h, 00h, 62h, 01h, 00h, 00h, 00h
	defb	7eh, 3ch, 00h, 00h, 00h, 00h, 00h, 00h
	defb	7fh, 3ch, 00h, 00h, 00h, 00h, 00h, 00h
	defb	7eh, 3ch, 00h, 00h, 00h, 00h, 00h, 00h
	defb	3ch, 0ch, 00h, 00h, 00h, 00h, 00h, 00h
	defb	0c0h, 00h, 0ech, 60h, 00h, 00h, 00h, 00h
	defb	00h, 00h, 2ch, 20h, 00h, 00h, 00h, 00h
	defb	00h, 00h, 00h, 00h, 00h, 00h, 3ch, 7eh
	defb	00h, 00h, 00h, 00h, 00h, 00h, 3dh, 7fh
	defb	00h, 00h, 00h, 00h, 00h, 00h, 3ch, 7eh
	defb	00h, 00h, 00h, 00h, 00h, 00h, 0eh, 3eh
	defb	00h, 00h, 00h, 00h, 60h, 0e0h, 01h, 0c1h
	defb	00h, 00h, 00h, 00h, 20h, 20h, 01h, 01h
	defb	66h, 7eh, 66h, 3ch, 00h, 00h, 00h, 00h
	defb	67h, 7fh, 67h, 3dh, 00h, 00h, 00h, 00h
	defb	66h, 7eh, 66h, 3ch, 00h, 00h, 00h, 00h
	defb	20h, 20h, 3eh, 0eh, 00h, 00h, 00h, 00h
	defb	0c0h, 0c0h, 0c1h, 01h, 0e0h, 60h, 00h, 00h
	defb	00h, 00h, 01h, 01h, 20h, 20h, 00h, 00h
	defb	00h, 00h, 00h, 00h, 00h, 00h, 3ch, 7eh
	defb	00h, 00h, 00h, 00h, 00h, 00h, 3ch, 7fh
	defb	00h, 00h, 00h, 00h, 00h, 00h, 3ch, 7eh
	defb	00h, 00h, 00h, 00h, 00h, 00h, 0ch, 2ch
	defb	00h, 00h, 00h, 00h, 60h, 0ech, 80h, 0c0h
	defb	00h, 00h, 00h, 00h, 20h, 2ch, 00h, 00h
	defb	66h, 7eh, 66h, 3ch, 00h, 00h, 00h, 00h
	defb	67h, 7fh, 66h, 3ch, 00h, 00h, 00h, 00h
	defb	66h, 7eh, 66h, 3ch, 00h, 00h, 00h, 00h
	defb	30h, 38h, 3ch, 0eh, 06h, 00h, 00h, 00h
	defb	0c0h, 0c0h, 0c0h, 00h, 0c1h, 0c2h, 00h, 00h
	defb	00h, 00h, 00h, 00h, 01h, 0c2h, 00h, 00h
	defb	00h, 00h, 00h, 00h, 00h, 00h, 3ch, 7eh
	defb	00h, 00h, 00h, 00h, 00h, 00h, 3ch, 7fh
	defb	00h, 00h, 00h, 00h, 00h, 00h, 3ch, 7eh
	defb	00h, 00h, 00h, 00h, 00h, 00h, 00h, 0ch
	defb	00h, 00h, 00h, 00h, 00h, 00h, 00h, 02h
	defb	00h, 00h, 00h, 00h, 00h, 00h, 00h, 02h
	defb	66h, 7eh, 66h, 3ch, 00h, 00h, 00h, 00h
	defb	67h, 7fh, 66h, 3ch, 00h, 00h, 00h, 00h
	defb	66h, 7eh, 66h, 3ch, 00h, 00h, 00h, 00h
	defb	00h, 06h, 06h, 00h, 00h, 00h, 00h, 00h
	defb	0e0h, 0f1h, 31h, 00h, 00h, 00h, 00h, 00h
	defb	00h, 11h, 11h, 00h, 00h, 00h, 00h, 00h
	defb	00h, 00h, 00h, 00h, 00h, 00h, 3ch, 7eh
	defb	00h, 00h, 00h, 00h, 00h, 00h, 3ch, 7fh
	defb	00h, 00h, 00h, 00h, 00h, 00h, 3ch, 7eh
	defb	00h, 00h, 00h, 00h, 00h, 00h, 0ch, 3ch
	defb	00h, 00h, 00h, 00h, 60h, 0ech, 00h, 0c0h
	defb	00h, 00h, 00h, 00h, 20h, 2ch, 00h, 00h
	defb	66h, 7eh, 66h, 3ch, 00h, 00h, 00h, 00h
	defb	67h, 7fh, 66h, 3ch, 00h, 00h, 00h, 00h
	defb	66h, 7eh, 66h, 3ch, 00h, 00h, 00h, 00h
	defb	38h, 14h, 0eh, 06h, 00h, 00h, 00h, 00h
	defb	80h, 0c0h, 0e0h, 61h, 62h, 00h, 00h, 00h
	defb	00h, 00h, 00h, 01h, 62h, 00h, 00h, 00h
	defb	00h, 03h, 03h, 03h, 01h, 01h, 00h, 00h
	defb	03h, 00h, 00h, 00h, 00h, 0ch, 0dh, 05h
	defb	03h, 00h, 00h, 00h, 00h, 0ch, 00h, 00h
	defb	00h, 30h, 30h, 30h, 20h, 0e0h, 00h, 00h
	defb	30h, 00h, 00h, 00h, 00h, 0ch, 0ech, 0e8h
	defb	30h, 00h, 00h, 00h, 00h, 0ch, 00h, 00h
	defb	00h, 01h, 03h, 03h, 03h, 03h, 01h, 00h
	defb	03h, 01h, 03h, 03h, 03h, 03h, 01h, 00h
	defb	00h, 01h, 03h, 03h, 03h, 03h, 01h, 00h
	defb	00h, 0e0h, 0f0h, 50h, 50h, 0f0h, 0e0h, 00h
	defb	0f0h, 0e0h, 0f0h, 50h, 50h, 0f0h, 0e0h, 00h
	defb	00h, 0e0h, 0f0h, 50h, 50h, 0f0h, 0e0h, 00h
	defb	00h, 00h, 00h, 00h, 70h, 7ch, 04h, 04h
	defb	00h, 00h, 06h, 07h, 80h, 83h, 03h, 03h
	defb	00h, 00h, 04h, 04h, 80h, 80h, 00h, 00h
	defb	00h, 00h, 00h, 00h, 3ch, 66h, 7eh, 66h
	defb	00h, 00h, 00h, 00h, 0bch, 0e6h, 0feh, 0e6h
	defb	00h, 00h, 00h, 00h, 3ch, 66h, 7eh, 66h
	defb	7ch, 70h, 00h, 00h, 00h, 00h, 00h, 00h
	defb	83h, 80h, 07h, 06h, 00h, 00h, 00h, 00h
	defb	80h, 80h, 04h, 04h, 00h, 00h, 00h, 00h
	defb	7eh, 3ch, 00h, 00h, 00h, 00h, 00h, 00h
	defb	0feh, 0bch, 00h, 00h, 00h, 00h, 00h, 00h
	defb	7eh, 3ch, 00h, 00h, 00h, 00h, 00h, 00h
	defb	00h, 18h, 3ch, 66h, 66h, 66h, 3ch, 1ch
	defb	00h, 18h, 3ch, 66h, 66h, 66h, 3ch, 1ch
	defb	00h, 18h, 3ch, 66h, 66h, 66h, 3ch, 1ch
	defb	00h, 18h, 3ch, 66h, 66h, 66h, 3ch, 38h
	defb	00h, 18h, 3ch, 66h, 66h, 66h, 3ch, 38h
	defb	00h, 18h, 3ch, 66h, 66h, 66h, 3ch, 38h
	defb	0bh, 07h, 1fh, 39h, 36h, 7fh, 73h, 61h
	defb	0bh, 07h, 1fh, 39h, 36h, 7fh, 73h, 61h
	defb	08h, 00h, 00h, 00h, 00h, 00h, 00h, 00h
	defb	0d0h, 0e0h, 0f8h, 9ch, 6ch, 0feh, 0ceh, 86h
	defb	0d0h, 0e0h, 0f8h, 9ch, 6ch, 0feh, 0ceh, 86h
	defb	10h, 00h, 00h, 00h, 00h, 00h, 00h, 00h
	defb	00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h
	defb	00h, 03h, 0fh, 1fh, 1fh, 31h, 31h, 39h
	defb	00h, 00h, 00h, 00h, 00h, 0eh, 0eh, 06h
	defb	00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h
	defb	00h, 0c0h, 0f0h, 0f8h, 0f8h, 8ch, 8ch, 9ch
	defb	00h, 00h, 00h, 00h, 00h, 70h, 70h, 60h
	defb	00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h
	defb	3fh, 3ah, 18h, 1ch, 1fh, 3fh, 7bh, 71h
	defb	00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h
	defb	00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h
	defb	0fch, 5ch, 18h, 38h, 0f8h, 0fch, 0deh, 8eh
	defb	00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h
