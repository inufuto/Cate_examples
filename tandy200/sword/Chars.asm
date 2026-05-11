cseg
CharPattern: public CharPattern
; ascii 29
	; " 0123456789ACEFGHIKMNOPRSTUVY"
	defb 00h,00h,00h,00h,00h,00h,00h,00h
	defb 7ch,0c6h,0e6h,0d6h,0ceh,0c6h,7ch,00h
	defb 18h,1eh,18h,18h,18h,18h,7eh,00h
	defb 7ch,0c6h,0e0h,78h,3ch,0eh,0feh,00h
	defb 7ch,0c6h,0c0h,78h,0c0h,0c6h,7ch,00h
	defb 60h,70h,78h,6ch,66h,0feh,60h,00h
	defb 0feh,06h,7eh,0c0h,0c0h,0c6h,7ch,00h
	defb 78h,0ch,06h,7eh,0c6h,0c6h,7ch,00h
	defb 0feh,0c6h,60h,30h,18h,18h,18h,00h
	defb 7ch,0c6h,0c6h,7ch,0c6h,0c6h,7ch,00h
	defb 7ch,0c6h,0c6h,0fch,0c0h,0c6h,7ch,00h
	defb 38h,6ch,0c6h,0c6h,0feh,0c6h,0c6h,00h
	defb 78h,0cch,06h,06h,06h,0cch,78h,00h
	defb 7eh,06h,06h,7eh,06h,06h,7eh,00h
	defb 7eh,06h,06h,7eh,06h,06h,06h,00h
	defb 78h,0cch,06h,0f6h,0c6h,0cch,0f8h,00h
	defb 0c6h,0c6h,0c6h,0feh,0c6h,0c6h,0c6h,00h
	defb 7eh,18h,18h,18h,18h,18h,7eh,00h
	defb 0c6h,66h,36h,1eh,36h,66h,0c6h,00h
	defb 7eh,0d6h,0d6h,0d6h,0d6h,0d6h,0d6h,00h
	defb 0c6h,0ceh,0deh,0feh,0f6h,0e6h,0c6h,00h
	defb 7ch,0c6h,0c6h,0c6h,0c6h,0c6h,7ch,00h
	defb 7eh,0c6h,0c6h,0c6h,7eh,06h,06h,00h
	defb 7eh,0c6h,0c6h,0e6h,3eh,76h,0e6h,00h
	defb 7ch,0c6h,06h,7ch,0c0h,0c6h,7ch,00h
	defb 7eh,18h,18h,18h,18h,18h,18h,00h
	defb 0c6h,0c6h,0c6h,0c6h,0c6h,0c6h,7ch,00h
	defb 0c6h,0c6h,0c6h,6ch,6ch,38h,38h,00h
	defb 66h,66h,66h,3ch,18h,18h,18h,00h
;	logo
	defb	0fh, 0fh, 0fh, 0fh, 00h, 00h, 00h, 00h
	defb	00h, 00h, 00h, 00h, 0fh, 0fh, 0fh, 0fh
	defb	0fh, 0fh, 0fh, 0fh, 0fh, 0fh, 0fh, 0fh
	defb	0f0h, 0f0h, 0f0h, 0f0h, 00h, 00h, 00h, 00h
	defb	0ffh, 0ffh, 0ffh, 0ffh, 00h, 00h, 00h, 00h
	defb	0f0h, 0f0h, 0f0h, 0f0h, 0fh, 0fh, 0fh, 0fh
	defb	0ffh, 0ffh, 0ffh, 0ffh, 0fh, 0fh, 0fh, 0fh
	defb	00h, 00h, 00h, 00h, 0f0h, 0f0h, 0f0h, 0f0h
	defb	0fh, 0fh, 0fh, 0fh, 0f0h, 0f0h, 0f0h, 0f0h
	defb	00h, 00h, 00h, 00h, 0ffh, 0ffh, 0ffh, 0ffh
	defb	0fh, 0fh, 0fh, 0fh, 0ffh, 0ffh, 0ffh, 0ffh
	defb	0f0h, 0f0h, 0f0h, 0f0h, 0f0h, 0f0h, 0f0h, 0f0h
	defb	0ffh, 0ffh, 0ffh, 0ffh, 0f0h, 0f0h, 0f0h, 0f0h
	defb	0f0h, 0f0h, 0f0h, 0f0h, 0ffh, 0ffh, 0ffh, 0ffh
	defb	0ffh, 0ffh, 0ffh, 0ffh, 0ffh, 0ffh, 0ffh, 0ffh
;	fence
	defb	00h, 00h, 00h, 00h, 00h, 00h, 00h, 0ffh
	defb	0ffh, 00h, 00h, 00h, 00h, 00h, 00h, 00h
;	16dot
	defb	0cfh, 0c7h, 0bbh, 7ch, 7ch, 0bdh, 0dbh, 0e3h
	defb	0e7h, 0e7h, 0dbh, 3ch, 3ch, 0bbh, 97h, 0c7h
	defb	0e3h, 0dbh, 0bdh, 3ch, 3ch, 0bbh, 0c7h, 0cfh
	defb	0c7h, 0c7h, 0bbh, 3ch, 3ch, 0bbh, 0c7h, 0e7h
	defb	00h, 00h, 0c0h, 30h, 08h, 0ch, 12h, 22h
	defb	0ch, 13h, 20h, 40h, 40h, 0c0h, 90h, 0c4h
	defb	26h, 4ah, 52h, 0e2h, 44h, 48h, 50h, 0e0h
	defb	0b1h, 9ch, 9bh, 88h, 60h, 18h, 06h, 01h
	defb	0feh, 03h, 01h, 01h, 01h, 81h, 41h, 29h
	defb	7fh, 0c0h, 0bch, 0a2h, 0a1h, 0a0h, 90h, 88h
	defb	15h, 29h, 49h, 85h, 63h, 95h, 0bh, 0feh
	defb	84h, 82h, 81h, 80h, 81h, 80h, 0c0h, 7fh
;	sprite
	defb	0c0h, 20h, 10h, 0f0h, 50h, 50h, 10h, 0f0h
	defb	03h, 04h, 08h, 09h, 08h, 08h, 08h, 07h
	defb	48h, 84h, 84h, 84h, 48h, 0b8h, 44h, 38h
	defb	02h, 02h, 03h, 04h, 09h, 12h, 11h, 0eh
	defb	0c0h, 20h, 10h, 0f0h, 50h, 50h, 10h, 0e0h
	defb	03h, 04h, 08h, 09h, 08h, 08h, 08h, 0fh
	defb	0b8h, 64h, 68h, 50h, 0c0h, 20h, 10h, 0e0h
	defb	14h, 28h, 28h, 18h, 04h, 03h, 05h, 02h
	defb	78h, 84h, 02h, 3eh, 0ah, 0ah, 02h, 0fch
	defb	00h, 00h, 01h, 01h, 01h, 01h, 01h, 01h
	defb	27h, 14h, 14h, 1bh, 30h, 0c8h, 24h, 18h
	defb	02h, 04h, 04h, 04h, 02h, 07h, 09h, 06h
	defb	00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h
	defb	00h, 00h, 00h, 00h, 00h, 00h, 00h, 40h
	defb	0f0h, 08h, 10h, 0e0h, 00h, 00h, 00h, 00h
	defb	0bfh, 80h, 80h, 0bfh, 40h, 00h, 00h, 00h
	defb	0c0h, 20h, 10h, 90h, 10h, 10h, 10h, 0e0h
	defb	03h, 04h, 08h, 0fh, 0ah, 0ah, 08h, 0fh
	defb	40h, 40h, 0c0h, 20h, 90h, 48h, 88h, 70h
	defb	76h, 84h, 44h, 37h, 09h, 12h, 22h, 1ch
	defb	0c0h, 20h, 10h, 90h, 10h, 10h, 10h, 0f0h
	defb	03h, 04h, 08h, 0fh, 0ah, 0ah, 08h, 0fh
	defb	48h, 0a4h, 24h, 28h, 0b0h, 40h, 0a0h, 40h
	defb	14h, 27h, 24h, 26h, 17h, 0ch, 08h, 07h
	defb	00h, 00h, 80h, 80h, 80h, 80h, 80h, 00h
	defb	1eh, 21h, 40h, 7ch, 50h, 50h, 40h, 3fh
	defb	00h, 80h, 80h, 0c0h, 20h, 90h, 90h, 60h
	defb	0e5h, 04h, 08h, 0f8h, 15h, 26h, 24h, 18h
	defb	00h, 00h, 00h, 00h, 00h, 00h, 00h, 02h
	defb	00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h
	defb	0fdh, 01h, 01h, 0fdh, 02h, 00h, 00h, 00h
	defb	0fh, 10h, 08h, 07h, 00h, 00h, 00h, 00h
	defb	0e0h, 10h, 08h, 08h, 08h, 08h, 08h, 0f8h
	defb	03h, 04h, 08h, 08h, 08h, 08h, 08h, 0fh
	defb	14h, 12h, 12h, 0f2h, 94h, 98h, 90h, 60h
	defb	14h, 24h, 24h, 27h, 5ch, 27h, 14h, 08h
	defb	0e0h, 10h, 08h, 08h, 08h, 08h, 08h, 0fch
	defb	03h, 04h, 08h, 08h, 08h, 08h, 08h, 0fh
	defb	12h, 11h, 11h, 0f1h, 92h, 0ech, 80h, 00h
	defb	14h, 14h, 1ch, 17h, 14h, 14h, 0ch, 03h
	defb	00h, 00h, 0e0h, 10h, 08h, 08h, 08h, 08h
	defb	12h, 12h, 0bh, 04h, 08h, 08h, 08h, 08h
	defb	0ch, 0f2h, 11h, 11h, 0f1h, 4ah, 4ch, 30h
	defb	08h, 07h, 04h, 04h, 07h, 09h, 09h, 06h
	defb	00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h
	defb	00h, 00h, 00h, 04h, 0ah, 09h, 09h, 09h
	defb	00h, 00h, 00h, 00h, 00h, 00h, 80h, 00h
	defb	09h, 09h, 09h, 09h, 09h, 09h, 10h, 0fh
	defb	0e0h, 10h, 08h, 0e8h, 88h, 88h, 08h, 0f8h
	defb	03h, 04h, 08h, 0bh, 08h, 08h, 08h, 1fh
	defb	14h, 12h, 1ah, 0eah, 9ah, 94h, 90h, 60h
	defb	22h, 41h, 41h, 41h, 22h, 1fh, 00h, 00h
	defb	0e0h, 10h, 08h, 0e8h, 88h, 88h, 08h, 0f0h
	defb	03h, 04h, 08h, 0bh, 08h, 08h, 08h, 37h
	defb	28h, 64h, 44h, 0f8h, 84h, 0c8h, 0a8h, 10h
	defb	4ch, 84h, 84h, 87h, 4ch, 34h, 04h, 03h
	defb	00h, 00h, 00h, 0e0h, 10h, 08h, 08h, 0e8h
	defb	00h, 00h, 00h, 03h, 04h, 08h, 08h, 3bh
	defb	88h, 88h, 0f0h, 68h, 44h, 0c8h, 88h, 90h
	defb	48h, 84h, 87h, 84h, 4fh, 39h, 12h, 0ch
	defb	0f0h, 08h, 90h, 90h, 90h, 90h, 90h, 90h
	defb	00h, 01h, 00h, 00h, 00h, 00h, 00h, 00h
	defb	90h, 90h, 90h, 50h, 20h, 00h, 00h, 00h
	defb	00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h
	defb	0c0h, 20h, 10h, 0b0h, 0b0h, 10h, 50h, 0e0h
	defb	03h, 04h, 08h, 09h, 09h, 08h, 06h, 01h
	defb	90h, 60h, 90h, 0e0h, 0a0h, 58h, 24h, 18h
	defb	02h, 03h, 03h, 04h, 0bh, 14h, 12h, 0ch
	defb	0c0h, 20h, 10h, 0b0h, 0b0h, 10h, 50h, 0e0h
	defb	03h, 04h, 08h, 09h, 09h, 08h, 06h, 07h
	defb	20h, 78h, 24h, 58h, 80h, 60h, 90h, 60h
	defb	0ah, 17h, 2ch, 2bh, 12h, 01h, 02h, 01h
	defb	0c0h, 20h, 10h, 90h, 90h, 10h, 60h, 80h
	defb	03h, 04h, 08h, 0dh, 0dh, 08h, 0ah, 07h
	defb	40h, 0c0h, 0c0h, 20h, 0d0h, 28h, 48h, 30h
	defb	09h, 06h, 09h, 07h, 05h, 1ah, 24h, 18h
	defb	0c0h, 20h, 10h, 90h, 90h, 10h, 60h, 0e0h
	defb	03h, 04h, 08h, 0dh, 0dh, 08h, 0ah, 07h
	defb	50h, 0e8h, 34h, 0d4h, 48h, 80h, 40h, 80h
	defb	04h, 1eh, 24h, 1ah, 01h, 06h, 09h, 06h
	defb	0e0h, 10h, 08h, 08h, 08h, 08h, 10h, 0f8h
	defb	03h, 04h, 08h, 08h, 08h, 08h, 04h, 0fh
	defb	14h, 74h, 18h, 0f0h, 50h, 50h, 48h, 30h
	defb	14h, 2fh, 2ch, 17h, 09h, 06h, 00h, 00h
	defb	0e0h, 10h, 08h, 08h, 08h, 08h, 10h, 0f8h
	defb	03h, 04h, 08h, 08h, 08h, 08h, 04h, 0fh
	defb	14h, 7ah, 1ah, 0f4h, 48h, 30h, 00h, 00h
	defb	14h, 17h, 0ch, 07h, 05h, 05h, 09h, 06h
	defb	0e0h, 10h, 08h, 68h, 68h, 08h, 50h, 0f8h
	defb	03h, 04h, 08h, 0bh, 0bh, 08h, 05h, 0fh
	defb	14h, 72h, 1ah, 0f4h, 50h, 50h, 48h, 30h
	defb	14h, 17h, 0ah, 07h, 09h, 06h, 00h, 00h
	defb	0e0h, 10h, 08h, 68h, 68h, 08h, 50h, 0f8h
	defb	03h, 04h, 08h, 0bh, 0bh, 08h, 05h, 0fh
	defb	14h, 74h, 28h, 0f0h, 48h, 30h, 00h, 00h
	defb	14h, 27h, 2ch, 17h, 05h, 05h, 09h, 06h
	defb	0fch, 12h, 81h, 11h, 03h, 81h, 05h, 11h
	defb	3fh, 42h, 90h, 80h, 80h, 0c8h, 80h, 0a0h
	defb	01h, 43h, 01h, 29h, 41h, 11h, 22h, 0fch
	defb	80h, 0c2h, 80h, 88h, 0c4h, 0a0h, 52h, 3fh
	defb	00h, 00h, 00h, 88h, 54h, 0b2h, 0b4h, 0b4h
	defb	00h, 00h, 00h, 31h, 4ah, 0b5h, 0b5h, 0b5h
	defb	0b4h, 0b4h, 62h, 9ch, 00h, 00h, 00h, 00h
	defb	0b5h, 0b5h, 4ah, 31h, 00h, 00h, 00h, 00h
	defb	00h, 00h, 00h, 8ch, 52h, 0adh, 0aah, 0b4h
	defb	00h, 00h, 00h, 31h, 4ah, 0b5h, 0b5h, 0b5h
	defb	0aah, 0bdh, 41h, 9eh, 00h, 00h, 00h, 00h
	defb	0b5h, 0b5h, 4ah, 31h, 00h, 00h, 00h, 00h
	defb	00h, 00h, 00h, 8ch, 52h, 0b5h, 0b5h, 0b5h
	defb	00h, 00h, 00h, 31h, 4ah, 0b5h, 0b5h, 0b5h
	defb	0a1h, 0b6h, 54h, 88h, 00h, 00h, 00h, 00h
	defb	0b5h, 0b5h, 4ah, 31h, 00h, 00h, 00h, 00h
	defb	00h, 00h, 00h, 8ch, 52h, 0adh, 0adh, 0b2h
	defb	00h, 00h, 00h, 31h, 4ah, 0b5h, 0b5h, 0b5h
	defb	0adh, 0adh, 52h, 8ch, 00h, 00h, 00h, 00h
	defb	0b5h, 0b5h, 4ah, 31h, 00h, 00h, 00h, 00h
	defb	00h, 00h, 0f8h, 04h, 02h, 29h, 2dh, 29h
	defb	00h, 00h, 1fh, 20h, 40h, 9dh, 0a5h, 0a5h
	defb	29h, 29h, 0ddh, 02h, 04h, 0f8h, 00h, 00h
	defb	9dh, 85h, 84h, 40h, 20h, 1fh, 00h, 00h
