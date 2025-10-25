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
;	remain
	defb	44h, 44h, 0d6h, 0eeh, 0d6h, 0feh, 0feh, 54h

SpritePattern: public SpritePattern
;	sprite
	defb	01h, 01h, 01h, 01h, 01h, 01h, 01h, 01h
	defb	00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h
	defb	00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h
	defb	00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h
	defb	00h, 3ch, 7eh, 7eh, 7eh, 7eh, 3ch, 00h
	defb	00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h
	defb	00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h
	defb	00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h
	defb	3ch, 7eh, 0ffh, 0ffh, 0ffh, 0ffh, 7eh, 3ch
	defb	00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h
	defb	00h, 00h, 00h, 0aah, 55h, 00h, 00h, 00h
	defb	00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h
	defb	00h, 00h, 00h, 55h, 0aah, 00h, 00h, 00h
	defb	00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h
	defb	00h, 00h, 00h, 0aah, 55h, 00h, 00h, 00h
	defb	00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h
	defb	00h, 00h, 00h, 55h, 0aah, 00h, 00h, 00h
	defb	00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h
	defb	3ch, 7eh, 0ffh, 0ffh, 0ffh, 0ffh, 7eh, 3ch
	defb	00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h
	defb	01h, 21h, 33h, 3eh, 24h, 0e1h, 77h, 3bh
	defb	1bh, 30h, 0e2h, 6eh, 3eh, 1bh, 11h, 01h
	defb	04h, 9ch, 0f8h, 0f9h, 6fh, 0eh, 9ch, 0b8h
	defb	0dch, 0cfh, 0eh, 48h, 0ech, 0fch, 8ch, 00h
	defb	00h, 00h, 08h, 0eh, 07h, 07h, 06h, 03h
	defb	03h, 1fh, 0f3h, 78h, 3eh, 1fh, 0fh, 06h
	defb	02h, 07h, 07h, 0fh, 9dh, 0fch, 78h, 38h
	defb	12h, 82h, 9fh, 3bh, 79h, 19h, 98h, 30h
	defb	00h, 00h, 01h, 87h, 8fh, 0dfh, 0fdh, 79h
	defb	71h, 25h, 0ch, 9ch, 0f8h, 19h, 11h, 38h
	defb	60h, 0e0h, 0c0h, 0c0h, 0c0h, 80h, 8eh, 0bch
	defb	0f8h, 0f8h, 30h, 0e0h, 0c0h, 0c0h, 0e0h, 0f0h
	defb	04h, 09h, 39h, 73h, 0e0h, 7fh, 3fh, 0eh
	defb	06h, 02h, 03h, 03h, 02h, 00h, 00h, 00h
	defb	64h, 0ceh, 9eh, 0ffh, 7dh, 21h, 6dh, 1ch
	defb	7eh, 0eeh, 0ceh, 07h, 07h, 03h, 02h, 02h
	defb	7fh, 60h, 0f0h, 0f3h, 9bh, 09h, 21h, 38h
	defb	7ch, 0ffh, 0e3h, 0c1h, 80h, 00h, 00h, 00h
	defb	38h, 0ch, 0feh, 0ffh, 0f0h, 80h, 80h, 0c0h
	defb	0c0h, 0c0h, 0e0h, 0e0h, 60h, 00h, 00h, 00h
	defb	00h, 00h, 00h, 3fh, 7fh, 0dbh, 9bh, 0dbh
	defb	0dbh, 0dbh, 8ch, 7fh, 3fh, 00h, 00h, 00h
	defb	00h, 00h, 00h, 0f8h, 0fch, 46h, 5ah, 5ah
	defb	46h, 5eh, 0deh, 0fch, 0f8h, 00h, 00h, 00h
;	sprite2
	defb	10h, 28h, 28h, 49h, 4ah, 8dh, 8ah, 88h
	defb	88h, 88h, 88h, 94h, 53h, 30h, 00h, 00h
	defb	10h, 28h, 28h, 24h, 0a4h, 62h, 0a2h, 22h
	defb	22h, 22h, 22h, 52h, 94h, 18h, 00h, 00h
	defb	00h, 10h, 10h, 30h, 31h, 72h, 75h, 77h
	defb	77h, 77h, 77h, 63h, 20h, 00h, 00h, 00h
	defb	00h, 10h, 10h, 18h, 18h, 9ch, 5ch, 0dch
	defb	0dch, 0dch, 0dch, 8ch, 08h, 00h, 00h, 00h
	defb	01h, 02h, 04h, 04h, 0bh, 48h, 0a8h, 97h
	defb	80h, 40h, 24h, 13h, 08h, 04h, 03h, 00h
	defb	00h, 80h, 40h, 40h, 0a0h, 24h, 2ah, 0d2h
	defb	02h, 04h, 48h, 90h, 20h, 40h, 80h, 00h
	defb	00h, 01h, 03h, 03h, 04h, 07h, 47h, 68h
	defb	7fh, 3fh, 1bh, 0ch, 07h, 03h, 00h, 00h
	defb	00h, 00h, 80h, 80h, 40h, 0c0h, 0c4h, 2ch
	defb	0fch, 0f8h, 0b0h, 60h, 0c0h, 80h, 00h, 00h
	defb	00h, 03h, 04h, 0bh, 0ch, 38h, 48h, 48h
	defb	88h, 99h, 6bh, 05h, 01h, 01h, 01h, 00h
	defb	00h, 80h, 40h, 0a0h, 60h, 38h, 24h, 24h
	defb	22h, 32h, 0ach, 40h, 00h, 00h, 00h, 00h
	defb	00h, 00h, 03h, 04h, 03h, 07h, 37h, 37h
	defb	77h, 66h, 04h, 00h, 00h, 00h, 00h, 00h
	defb	00h, 00h, 80h, 40h, 80h, 0c0h, 0d8h, 0d8h
	defb	0dch, 0cch, 40h, 00h, 00h, 00h, 00h, 00h
	defb	00h, 00h, 3fh, 42h, 82h, 74h, 08h, 10h
	defb	1eh, 06h, 0ah, 13h, 00h, 00h, 00h, 00h
	defb	00h, 0f0h, 08h, 0e4h, 34h, 14h, 14h, 08h
	defb	38h, 48h, 88h, 48h, 48h, 50h, 20h, 00h
	defb	00h, 00h, 00h, 3dh, 7dh, 0bh, 07h, 0fh
	defb	01h, 01h, 01h, 00h, 00h, 00h, 00h, 00h
	defb	00h, 00h, 0f0h, 18h, 0c8h, 0e8h, 0e8h, 0f0h
	defb	0c0h, 0b0h, 70h, 30h, 30h, 20h, 00h, 00h
	defb	06h, 09h, 08h, 04h, 0fh, 10h, 08h, 0fch
	defb	08h, 10h, 0fh, 04h, 08h, 09h, 06h, 00h
	defb	00h, 80h, 40h, 40h, 0f0h, 28h, 14h, 14h
	defb	14h, 28h, 0f0h, 40h, 40h, 80h, 00h, 00h
	defb	00h, 06h, 07h, 03h, 00h, 0fh, 07h, 03h
	defb	07h, 0fh, 00h, 03h, 07h, 06h, 00h, 00h
	defb	00h, 00h, 80h, 80h, 00h, 0d0h, 0e8h, 0e8h
	defb	0e8h, 0d0h, 00h, 80h, 80h, 00h, 00h, 00h
	defb	00h, 00h, 00h, 13h, 0ah, 06h, 1eh, 10h
	defb	08h, 74h, 82h, 42h, 3fh, 00h, 00h, 00h
	defb	20h, 50h, 48h, 48h, 88h, 48h, 38h, 08h
	defb	14h, 14h, 34h, 0e4h, 08h, 0f0h, 00h, 00h
	defb	00h, 00h, 00h, 00h, 01h, 01h, 01h, 0fh
	defb	07h, 0bh, 7dh, 3dh, 00h, 00h, 00h, 00h
	defb	00h, 20h, 30h, 30h, 70h, 0b0h, 0c0h, 0f0h
	defb	0e8h, 0e8h, 0c8h, 18h, 0f0h, 00h, 00h, 00h
	defb	01h, 01h, 01h, 05h, 6bh, 99h, 88h, 48h
	defb	48h, 38h, 0ch, 0bh, 04h, 03h, 00h, 00h
	defb	00h, 00h, 00h, 40h, 0ach, 32h, 22h, 24h
	defb	24h, 38h, 60h, 0a0h, 40h, 80h, 00h, 00h
	defb	00h, 00h, 00h, 00h, 04h, 66h, 77h, 37h
	defb	37h, 07h, 03h, 04h, 03h, 00h, 00h, 00h
	defb	00h, 00h, 00h, 00h, 40h, 0cch, 0dch, 0d8h
	defb	0d8h, 0c0h, 80h, 40h, 80h, 00h, 00h, 00h
	defb	08h, 14h, 24h, 25h, 22h, 24h, 38h, 20h
	defb	50h, 50h, 58h, 4eh, 21h, 1eh, 00h, 00h
	defb	00h, 00h, 00h, 90h, 0a0h, 0c0h, 0f0h, 10h
	defb	20h, 5ch, 82h, 84h, 0f8h, 00h, 00h, 00h
	defb	00h, 08h, 18h, 18h, 1dh, 1bh, 07h, 1fh
	defb	2fh, 2fh, 27h, 31h, 1eh, 00h, 00h, 00h
	defb	00h, 00h, 00h, 00h, 00h, 00h, 00h, 0e0h
	defb	0c0h, 0a0h, 7ch, 78h, 00h, 00h, 00h, 00h
	defb	00h, 03h, 04h, 04h, 1fh, 28h, 50h, 50h
	defb	50h, 28h, 1fh, 04h, 04h, 03h, 00h, 00h
	defb	0c0h, 20h, 20h, 40h, 0e0h, 10h, 20h, 7eh
	defb	20h, 10h, 0e0h, 40h, 20h, 20h, 0c0h, 00h
	defb	00h, 00h, 03h, 03h, 00h, 17h, 2fh, 2fh
	defb	2fh, 17h, 00h, 03h, 03h, 00h, 00h, 00h
	defb	00h, 0c0h, 0c0h, 80h, 00h, 0e0h, 0c0h, 80h
	defb	0c0h, 0e0h, 00h, 80h, 0c0h, 0c0h, 00h, 00h
	defb	00h, 1eh, 21h, 4eh, 58h, 50h, 50h, 20h
	defb	38h, 24h, 22h, 25h, 24h, 14h, 08h, 00h
	defb	00h, 00h, 0f8h, 84h, 82h, 5ch, 20h, 10h
	defb	0f0h, 0c0h, 0a0h, 90h, 00h, 00h, 00h, 00h
	defb	00h, 00h, 1eh, 31h, 27h, 2fh, 2fh, 1fh
	defb	07h, 1bh, 1dh, 18h, 18h, 08h, 00h, 00h
	defb	00h, 00h, 00h, 78h, 7ch, 0a0h, 0c0h, 0e0h
	defb	00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h
	defb	40h, 0a3h, 94h, 88h, 93h, 54h, 30h, 10h
	defb	30h, 54h, 93h, 88h, 94h, 0a3h, 40h, 00h
	defb	04h, 8ah, 52h, 22h, 92h, 54h, 18h, 10h
	defb	18h, 54h, 92h, 22h, 52h, 8ah, 04h, 00h
	defb	00h, 40h, 63h, 77h, 6ch, 2bh, 0fh, 0fh
	defb	0fh, 2bh, 6ch, 77h, 63h, 40h, 00h, 00h
	defb	00h, 04h, 8ch, 0dch, 6ch, 0a8h, 0e0h, 0e0h
	defb	0e0h, 0a8h, 6ch, 0dch, 8ch, 04h, 00h, 00h
	defb	7fh, 0c0h, 0a0h, 9fh, 93h, 95h, 98h, 9ch
	defb	98h, 95h, 93h, 9fh, 0aah, 0d5h, 7fh, 00h
	defb	0fch, 06h, 0ah, 0f6h, 9ah, 56h, 3ah, 76h
	defb	3ah, 56h, 9ah, 0f6h, 0aah, 56h, 0fch, 00h
	defb	00h, 3fh, 5fh, 60h, 6ch, 6ah, 67h, 63h
	defb	67h, 6ah, 6ch, 60h, 55h, 2ah, 00h, 00h
	defb	00h, 0f8h, 0f4h, 08h, 64h, 0a8h, 0c4h, 88h
	defb	0c4h, 0a8h, 64h, 08h, 54h, 0a8h, 00h, 00h
	defb	70h, 8fh, 90h, 0a0h, 43h, 45h, 48h, 4ch
	defb	48h, 45h, 43h, 0a0h, 95h, 8fh, 70h, 00h
	defb	1ch, 0e2h, 12h, 0ah, 84h, 4ch, 24h, 6ch
	defb	24h, 4ch, 94h, 2ah, 52h, 0e2h, 1ch, 00h
	defb	00h, 70h, 6fh, 5fh, 3ch, 3ah, 37h, 33h
	defb	37h, 3ah, 3ch, 5fh, 6ah, 70h, 00h, 00h
	defb	00h, 1ch, 0ech, 0f4h, 78h, 0b0h, 0d8h, 90h
	defb	0d8h, 0b0h, 68h, 0d4h, 0ach, 1ch, 00h, 00h

FortPattern: public FortPattern
;	fort
	defb	0ffh, 0ffh, 0ffh, 07h, 03h, 1fh, 1fh, 1fh
	defb	33h, 33h, 33h, 73h, 73h, 93h, 53h, 93h
	defb	0ffh, 0ffh, 0ffh, 0efh, 0e0h, 0fh, 0ffh, 37h
	defb	33h, 33h, 33h, 71h, 71h, 71h, 11h, 0e1h
	defb	0ch, 1eh, 3fh, 80h, 1eh, 0d3h, 01h, 0fdh
	defb	83h, 83h, 83h, 78h, 81h, 18h, 0e1h, 0d1h
	defb	30h, 78h, 03h, 01h, 78h, 34h, 7fh, 40h
	defb	83h, 83h, 38h, 78h, 81h, 81h, 1eh, 1dh
	defb	0ffh, 0ffh, 0ffh, 08h, 07h, 0fh, 0ffh, 13h
	defb	33h, 33h, 33h, 17h, 71h, 17h, 11h, 1eh
	defb	0ffh, 0ffh, 0ffh, 1fh, 3fh, 07h, 07h, 07h
	defb	33h, 33h, 33h, 37h, 37h, 39h, 35h, 39h
	defb	1fh, 1fh, 1fh, 1fh, 1fh, 1fh, 3fh, 3fh
	defb	53h, 93h, 0e3h, 13h, 0e3h, 83h, 83h, 83h
	defb	78h, 79h, 35h, 40h, 0eh, 31h, 31h, 31h
	defb	0e1h, 0e1h, 0e1h, 71h, 0e1h, 1eh, 1eh, 1eh
	defb	01h, 98h, 0bch, 7eh, 0ffh, 0ffh, 7eh, 0bch
	defb	0e1h, 71h, 71h, 71h, 77h, 77h, 71h, 71h
	defb	7fh, 19h, 3dh, 7eh, 0ffh, 0ffh, 7eh, 3dh
	defb	1eh, 71h, 71h, 71h, 77h, 77h, 71h, 71h
	defb	1eh, 61h, 53h, 02h, 70h, 73h, 73h, 73h
	defb	0e1h, 1eh, 1eh, 71h, 0e1h, 0e1h, 0e1h, 0e1h
	defb	07h, 07h, 07h, 07h, 07h, 07h, 03h, 03h
	defb	35h, 39h, 3eh, 31h, 3eh, 38h, 38h, 38h
	defb	1fh, 1fh, 0fdh, 0fdh, 0ffh, 0b5h, 0b5h, 0b5h
	defb	83h, 0b3h, 71h, 71h, 11h, 71h, 71h, 71h
	defb	0ffh, 0d0h, 0d6h, 0d6h, 0ffh, 77h, 77h, 77h
	defb	11h, 0d1h, 0d1h, 0d1h, 11h, 71h, 71h, 71h
	defb	19h, 0ffh, 0feh, 0feh, 0ffh, 0bdh, 0bdh, 0bdh
	defb	71h, 11h, 41h, 41h, 11h, 71h, 71h, 71h
	defb	67h, 0ffh, 7fh, 7fh, 0ffh, 42h, 42h, 42h
	defb	17h, 11h, 41h, 41h, 11h, 17h, 17h, 17h
	defb	0ffh, 0bh, 6bh, 6bh, 0ffh, 11h, 11h, 11h
	defb	11h, 0d1h, 0d1h, 0d1h, 11h, 17h, 17h, 17h
	defb	07h, 07h, 40h, 40h, 0ffh, 52h, 52h, 52h
	defb	38h, 3bh, 17h, 17h, 11h, 17h, 17h, 17h
	defb	4ah, 4ah, 4ah, 0ffh, 02h, 02h, 1fh, 1fh
	defb	17h, 17h, 17h, 11h, 17h, 17h, 0b3h, 83h
	defb	77h, 77h, 77h, 0ffh, 29h, 29h, 2fh, 0ffh
	defb	71h, 71h, 71h, 11h, 1dh, 1dh, 1dh, 11h
	defb	42h, 42h, 42h, 0ffh, 01h, 01h, 0ffh, 19h
	defb	17h, 17h, 17h, 11h, 14h, 14h, 11h, 71h
	defb	42h, 42h, 42h, 0ffh, 7fh, 7fh, 0ffh, 67h
	defb	17h, 17h, 17h, 11h, 41h, 41h, 11h, 17h
	defb	11h, 11h, 11h, 0ffh, 6bh, 6bh, 0bh, 0ffh
	defb	17h, 17h, 17h, 11h, 0d1h, 0d1h, 0d1h, 11h
	defb	52h, 52h, 52h, 0ffh, 40h, 40h, 07h, 07h
	defb	17h, 17h, 17h, 11h, 17h, 17h, 3bh, 38h
	defb	3fh, 3fh, 1fh, 1fh, 1fh, 1fh, 1fh, 1fh
	defb	83h, 83h, 83h, 0e3h, 13h, 0e3h, 93h, 53h
	defb	31h, 31h, 31h, 0eh, 40h, 35h, 79h, 78h
	defb	1eh, 1eh, 1eh, 0e1h, 71h, 0e1h, 0e1h, 0e1h
	defb	43h, 7eh, 0ffh, 0ffh, 7eh, 43h, 67h, 01h
	defb	17h, 71h, 77h, 77h, 71h, 17h, 17h, 0e1h
	defb	3dh, 7eh, 0ffh, 0ffh, 7eh, 3dh, 19h, 7fh
	defb	71h, 71h, 77h, 77h, 71h, 71h, 71h, 1eh
	defb	73h, 73h, 73h, 70h, 02h, 53h, 61h, 1eh
	defb	0e1h, 0e1h, 0e1h, 0e1h, 71h, 1eh, 1eh, 0e1h
	defb	03h, 03h, 07h, 07h, 07h, 07h, 07h, 07h
	defb	38h, 38h, 38h, 3eh, 31h, 3eh, 39h, 35h
	defb	1fh, 1fh, 1fh, 03h, 07h, 0ffh, 0ffh, 0ffh
	defb	93h, 53h, 93h, 73h, 73h, 33h, 33h, 33h
	defb	37h, 0ffh, 0fh, 1fh, 10h, 0ffh, 0ffh, 0ffh
	defb	0e1h, 11h, 71h, 17h, 17h, 33h, 33h, 33h
	defb	02h, 01h, 2ch, 1eh, 7fh, 3fh, 1eh, 0ch
	defb	1dh, 0e1h, 81h, 81h, 87h, 83h, 83h, 83h
	defb	40h, 7fh, 34h, 78h, 01h, 03h, 78h, 30h
	defb	1dh, 1eh, 81h, 81h, 78h, 38h, 83h, 83h
	defb	13h, 0ffh, 0fh, 07h, 08h, 0ffh, 0ffh, 0ffh
	defb	1eh, 11h, 17h, 71h, 17h, 33h, 33h, 33h
	defb	07h, 07h, 07h, 3fh, 1fh, 0ffh, 0ffh, 0ffh
	defb	39h, 35h, 39h, 37h, 37h, 33h, 33h, 33h
