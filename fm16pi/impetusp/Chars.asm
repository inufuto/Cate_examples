cseg
CharPattern: public CharPattern
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
;	remain
	defb	44h, 44h, 0d6h, 0eeh, 0d6h, 0feh, 0feh, 54h
;	terrain
	defb	00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h
	defb	00h, 00h, 00h, 00h, 01h, 01h, 01h, 01h
	defb	00h, 00h, 00h, 00h, 80h, 80h, 80h, 80h
	defb	00h, 40h, 00h, 04h, 00h, 40h, 00h, 04h
	defb	01h, 01h, 01h, 01h, 00h, 00h, 00h, 00h
	defb	80h, 80h, 80h, 80h, 00h, 00h, 00h, 00h
	defb	0a0h, 40h, 80h, 04h, 00h, 40h, 00h, 04h
	defb	01h, 01h, 01h, 01h, 01h, 01h, 01h, 01h
	defb	80h, 80h, 80h, 80h, 80h, 80h, 80h, 80h
	defb	00h, 40h, 00h, 04h, 00h, 00h, 0a0h, 74h
	defb	00h, 00h, 00h, 00h, 00h, 00h, 00h, 0ffh
	defb	0ffh, 00h, 00h, 00h, 00h, 00h, 00h, 00h
	defb	00h, 40h, 00h, 04h, 00h, 41h, 03h, 05h
	defb	00h, 40h, 00h, 04h, 00h, 41h, 07h, 09h
	defb	00h, 40h, 00h, 04h, 0ffh, 00h, 00h, 00h
	defb	00h, 00h, 00h, 0ffh, 00h, 40h, 00h, 04h
	defb	0ah, 45h, 03h, 02h, 00h, 40h, 00h, 04h
	defb	90h, 0e0h, 0c0h, 04h, 00h, 40h, 00h, 04h
	defb	00h, 40h, 00h, 04h, 00h, 0c0h, 0e0h, 0f4h
	defb	00h, 40h, 00h, 04h, 0ffh, 80h, 80h, 80h
	defb	00h, 40h, 00h, 04h, 0ffh, 01h, 01h, 01h
	defb	01h, 01h, 01h, 0ffh, 00h, 40h, 00h, 04h
	defb	80h, 80h, 80h, 0ffh, 00h, 40h, 00h, 04h
	defb	0fh, 47h, 03h, 04h, 00h, 40h, 00h, 04h
	defb	01h, 01h, 01h, 01h, 01h, 01h, 01h, 0ffh
	defb	0ffh, 80h, 80h, 80h, 80h, 80h, 80h, 80h
	defb	0ffh, 01h, 01h, 01h, 01h, 01h, 01h, 01h
	defb	80h, 80h, 80h, 80h, 80h, 80h, 80h, 0ffh
	defb	00h, 00h, 0a0h, 74h, 0a8h, 5ch, 0a8h, 74h
	defb	0aah, 5ch, 0a8h, 74h, 0a0h, 40h, 80h, 04h
	defb	00h, 40h, 00h, 04h, 0aah, 5dh, 0abh, 75h
	defb	0aah, 5dh, 0abh, 75h, 00h, 40h, 00h, 04h
	defb	00h, 41h, 03h, 05h, 0ah, 5dh, 2bh, 75h
	defb	2ah, 5dh, 2bh, 15h, 0ah, 45h, 03h, 02h
	defb	00h, 41h, 07h, 09h, 1fh, 5fh, 3fh, 79h
	defb	00h, 40h, 00h, 04h, 0ffh, 9fh, 0ffh, 0f9h
	defb	00h, 0c0h, 0e0h, 0f4h, 0f8h, 9ch, 0fch, 0f8h
	defb	0ffh, 9fh, 0ffh, 0f9h, 00h, 40h, 00h, 04h
	defb	0feh, 9ch, 0fch, 0fch, 90h, 0e0h, 0c0h, 04h
	defb	0a8h, 5ch, 0a8h, 74h, 0aah, 5dh, 0abh, 75h
	defb	7fh, 5fh, 3fh, 19h, 0fh, 47h, 03h, 04h
	defb	0aah, 5dh, 0abh, 75h, 2ah, 5dh, 2bh, 15h
	defb	0aah, 5dh, 0abh, 75h, 0aah, 5ch, 0a8h, 74h
	defb	0ah, 5dh, 2bh, 75h, 0aah, 5dh, 0abh, 75h
	defb	0aah, 5dh, 0abh, 75h, 0aah, 5dh, 0abh, 75h
	defb	80h, 80h, 80h, 0ffh, 0ffh, 9fh, 0ffh, 0f9h
	defb	01h, 01h, 01h, 0ffh, 0ffh, 9fh, 0ffh, 0f9h
	defb	0ffh, 9fh, 0ffh, 0f9h, 0ffh, 80h, 80h, 80h
	defb	0ffh, 9fh, 0ffh, 0f9h, 0ffh, 01h, 01h, 01h
	defb	0f8h, 9ch, 0fch, 0f8h, 0ffh, 9fh, 0ffh, 0f9h
	defb	1fh, 5fh, 3fh, 79h, 0ffh, 9fh, 0ffh, 0f9h
	defb	0ffh, 9fh, 0ffh, 0f9h, 7fh, 5fh, 3fh, 19h
	defb	0ffh, 9fh, 0ffh, 0f9h, 0feh, 9ch, 0fch, 0fch
	defb	0ffh, 9fh, 0ffh, 0f9h, 0ffh, 9fh, 0ffh, 0f9h
;	fort6
	defb	00h, 40h, 07h, 08h, 1ch, 6fh, 24h, 24h
	defb	00h, 40h, 0ffh, 10h, 1fh, 0f0h, 0ffh, 0c8h
	defb	0ch, 52h, 0e1h, 21h, 0e1h, 53h, 0feh, 02h
	defb	30h, 4ah, 87h, 84h, 87h, 0cah, 7fh, 40h
	defb	00h, 02h, 0ffh, 08h, 0f8h, 0fh, 0ffh, 13h
	defb	00h, 02h, 0f0h, 10h, 38h, 0f6h, 24h, 24h
	defb	27h, 66h, 1fh, 10h, 1fh, 26h, 42h, 42h
	defb	87h, 86h, 0cah, 0bfh, 0f1h, 31h, 31h, 31h
	defb	0feh, 66h, 43h, 81h, 00h, 00h, 81h, 43h
	defb	7fh, 66h, 0c2h, 81h, 00h, 00h, 81h, 0c2h
	defb	0e1h, 61h, 53h, 0fdh, 8fh, 8ch, 8ch, 8ch
	defb	0e4h, 66h, 0f8h, 08h, 0f8h, 64h, 42h, 42h
	defb	27h, 7eh, 82h, 82h, 0ffh, 92h, 92h, 92h
	defb	0ffh, 2fh, 3ch, 3ch, 0ffh, 88h, 88h, 88h
	defb	0e6h, 0ffh, 01h, 01h, 0ffh, 42h, 42h, 42h
	defb	67h, 0ffh, 80h, 80h, 0ffh, 42h, 42h, 42h
	defb	0ffh, 0f4h, 3ch, 3ch, 0ffh, 11h, 11h, 11h
	defb	0e4h, 7eh, 41h, 41h, 0ffh, 49h, 49h, 49h
	defb	92h, 92h, 92h, 0ffh, 82h, 82h, 7eh, 27h
	defb	88h, 88h, 88h, 0ffh, 3ch, 3ch, 2fh, 0ffh
	defb	42h, 42h, 42h, 0ffh, 01h, 01h, 0ffh, 0e6h
	defb	42h, 42h, 42h, 0ffh, 80h, 80h, 0ffh, 67h
	defb	11h, 11h, 11h, 0ffh, 3ch, 3ch, 0f4h, 0ffh
	defb	49h, 49h, 49h, 0ffh, 41h, 41h, 7eh, 0e4h
	defb	42h, 42h, 26h, 1fh, 10h, 1fh, 66h, 27h
	defb	31h, 31h, 31h, 0f1h, 0bfh, 0cah, 86h, 87h
	defb	43h, 81h, 00h, 00h, 81h, 43h, 66h, 0feh
	defb	0c2h, 81h, 00h, 00h, 81h, 0c2h, 66h, 7fh
	defb	8ch, 8ch, 8ch, 8fh, 0fdh, 53h, 61h, 0e1h
	defb	42h, 42h, 64h, 0f8h, 08h, 0f8h, 66h, 0e4h
	defb	24h, 24h, 6fh, 1ch, 08h, 07h, 40h, 00h
	defb	0c8h, 0ffh, 0f0h, 1fh, 10h, 0ffh, 40h, 00h
	defb	02h, 0feh, 53h, 0e1h, 21h, 0e1h, 52h, 0ch
	defb	40h, 7fh, 0cah, 87h, 84h, 87h, 4ah, 30h
	defb	13h, 0ffh, 0fh, 0f8h, 08h, 0ffh, 02h, 00h
	defb	24h, 24h, 0f6h, 38h, 10h, 0e0h, 02h, 00h
;	fort7
	defb	00h, 40h, 00h, 04h, 00h, 40h, 07h, 08h
	defb	00h, 40h, 00h, 04h, 00h, 40h, 0ffh, 10h
	defb	00h, 40h, 00h, 04h, 0ch, 52h, 0e1h, 21h
	defb	00h, 40h, 00h, 04h, 30h, 48h, 87h, 84h
	defb	00h, 40h, 00h, 04h, 00h, 40h, 0ffh, 08h
	defb	00h, 40h, 00h, 04h, 00h, 40h, 0f0h, 14h
	defb	1ch, 6fh, 24h, 24h, 27h, 66h, 1fh, 10h
	defb	1fh, 0f0h, 0ffh, 0c8h, 87h, 86h, 0cah, 0bfh
	defb	0e1h, 53h, 0feh, 02h, 0feh, 66h, 43h, 81h
	defb	87h, 0cah, 7fh, 40h, 7fh, 66h, 0c2h, 81h
	defb	0f8h, 0fh, 0ffh, 13h, 0e1h, 61h, 53h, 0fdh
	defb	38h, 0f4h, 24h, 24h, 0e4h, 64h, 0f8h, 08h
	defb	1fh, 26h, 42h, 42h, 27h, 7eh, 82h, 82h
	defb	0f1h, 31h, 31h, 31h, 0ffh, 2fh, 3ch, 3ch
	defb	00h, 00h, 81h, 43h, 0e6h, 0ffh, 01h, 01h
	defb	00h, 00h, 81h, 0c2h, 67h, 0ffh, 80h, 80h
	defb	8fh, 8ch, 8ch, 8ch, 0ffh, 0f4h, 3ch, 3ch
	defb	0f8h, 64h, 42h, 42h, 0e4h, 7eh, 41h, 41h
	defb	0ffh, 92h, 92h, 92h, 92h, 92h, 92h, 0ffh
	defb	0ffh, 88h, 88h, 88h, 88h, 88h, 88h, 0ffh
	defb	0ffh, 42h, 42h, 42h, 42h, 42h, 42h, 0ffh
	defb	0ffh, 42h, 42h, 42h, 42h, 42h, 42h, 0ffh
	defb	0ffh, 11h, 11h, 11h, 11h, 11h, 11h, 0ffh
	defb	0ffh, 49h, 49h, 49h, 49h, 49h, 49h, 0ffh
	defb	82h, 82h, 7eh, 27h, 42h, 42h, 26h, 1fh
	defb	3ch, 3ch, 2fh, 0ffh, 31h, 31h, 31h, 0f1h
	defb	01h, 01h, 0ffh, 0e6h, 43h, 81h, 00h, 00h
	defb	80h, 80h, 0ffh, 67h, 0c2h, 81h, 00h, 00h
	defb	3ch, 3ch, 0f4h, 0ffh, 8ch, 8ch, 8ch, 8fh
	defb	41h, 41h, 7eh, 0e4h, 42h, 42h, 64h, 0f8h
	defb	10h, 5fh, 26h, 27h, 24h, 64h, 2fh, 1ch
	defb	0bfh, 0cah, 86h, 87h, 0c8h, 0ffh, 0f0h, 1fh
	defb	81h, 43h, 66h, 0feh, 02h, 0feh, 53h, 0e1h
	defb	81h, 0c2h, 66h, 7fh, 40h, 7fh, 0cah, 87h
	defb	0fdh, 53h, 61h, 0e1h, 13h, 0ffh, 0fh, 0f8h
	defb	08h, 0fch, 64h, 0e4h, 24h, 24h, 0f4h, 3ch
	defb	08h, 47h, 00h, 04h, 00h, 40h, 00h, 04h
	defb	10h, 0ffh, 00h, 04h, 00h, 40h, 00h, 04h
	defb	21h, 0e1h, 12h, 0ch, 00h, 40h, 00h, 04h
	defb	84h, 87h, 48h, 34h, 00h, 40h, 00h, 04h
	defb	08h, 0ffh, 00h, 04h, 00h, 40h, 00h, 04h
	defb	10h, 0e0h, 00h, 04h, 00h, 40h, 00h, 04h

SpritePattern: public SpritePattern
;	sprite
	defb	10h, 10h, 00h, 00h, 38h, 28h, 00h, 00h
	defb	38h, 28h, 00h, 00h, 38h, 28h, 00h, 00h
	defb	38h, 28h, 00h, 00h, 38h, 28h, 00h, 00h
	defb	38h, 28h, 00h, 00h, 10h, 10h, 00h, 00h
	defb	00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h
	defb	00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h
	defb	00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h
	defb	00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h
	defb	3ch, 3ch, 00h, 00h, 7eh, 42h, 00h, 00h
	defb	0ffh, 99h, 00h, 00h, 0ffh, 0bdh, 00h, 00h
	defb	0ffh, 0bdh, 00h, 00h, 0ffh, 99h, 00h, 00h
	defb	7eh, 42h, 00h, 00h, 3ch, 3ch, 00h, 00h
	defb	00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h
	defb	00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h
	defb	00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h
	defb	00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h
	defb	3ch, 3ch, 00h, 00h, 7eh, 42h, 00h, 00h
	defb	0ffh, 99h, 0ffh, 0ffh, 0ffh, 0a5h, 0ffh, 00h
	defb	0ffh, 0a5h, 0ffh, 00h, 0ffh, 99h, 0ffh, 0ffh
	defb	7eh, 42h, 00h, 00h, 3ch, 3ch, 00h, 00h
	defb	00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h
	defb	00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h
	defb	00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h
	defb	00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h
	defb	00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h
	defb	0ffh, 0ffh, 0ffh, 0ffh, 0ffh, 00h, 0ffh, 00h
	defb	0ffh, 00h, 0ffh, 00h, 0ffh, 0ffh, 0ffh, 0ffh
	defb	00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h
	defb	00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h
	defb	00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h
	defb	00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h
	defb	00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h
	defb	00h, 00h, 3ch, 3ch, 00h, 00h, 7eh, 42h
	defb	0ffh, 0ffh, 0ffh, 99h, 0ffh, 00h, 0ffh, 0a5h
	defb	0ffh, 00h, 0ffh, 0a5h, 0ffh, 0ffh, 0ffh, 99h
	defb	00h, 00h, 7eh, 42h, 00h, 00h, 3ch, 3ch
	defb	00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h
	defb	00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h
	defb	00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h
	defb	00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h
	defb	01h, 01h, 04h, 04h, 21h, 21h, 9ch, 9ch
	defb	33h, 33h, 0f8h, 0f8h, 3fh, 3eh, 0f9h, 0f9h
	defb	3fh, 24h, 0ffh, 6fh, 0ffh, 0e1h, 0feh, 0eh
	defb	7fh, 77h, 0fch, 9ch, 3fh, 3bh, 0f8h, 0b8h
	defb	1fh, 1bh, 0fch, 0dch, 3fh, 30h, 0ffh, 0cfh
	defb	0ffh, 0e2h, 0feh, 0eh, 7fh, 6eh, 0f8h, 48h
	defb	3fh, 3eh, 0fch, 0ech, 1bh, 1bh, 0fch, 0fch
	defb	11h, 11h, 8ch, 8ch, 01h, 01h, 00h, 00h
	defb	00h, 00h, 02h, 02h, 00h, 00h, 07h, 07h
	defb	08h, 08h, 07h, 07h, 0eh, 0eh, 0fh, 0fh
	defb	07h, 07h, 9fh, 9dh, 07h, 07h, 0ffh, 0fch
	defb	07h, 06h, 0ffh, 78h, 03h, 03h, 0ffh, 38h
	defb	03h, 03h, 0ffh, 12h, 1fh, 1fh, 0ffh, 82h
	defb	0ffh, 0f3h, 0ffh, 9fh, 7fh, 78h, 0ffh, 3bh
	defb	3fh, 3eh, 0ffh, 79h, 1fh, 1fh, 0ffh, 19h
	defb	0fh, 0fh, 0ffh, 98h, 07h, 06h, 0ffh, 30h
	defb	00h, 00h, 60h, 60h, 00h, 00h, 0e0h, 0e0h
	defb	01h, 01h, 0c0h, 0c0h, 87h, 87h, 0c0h, 0c0h
	defb	8fh, 8fh, 0c0h, 0c0h, 0dfh, 0dfh, 80h, 80h
	defb	0ffh, 0fdh, 8eh, 8eh, 0ffh, 79h, 0bch, 0bch
	defb	0ffh, 71h, 0f8h, 0f8h, 0ffh, 25h, 0f8h, 0f8h
	defb	0ffh, 0ch, 0f0h, 30h, 0ffh, 9ch, 0e0h, 0e0h
	defb	0ffh, 0f8h, 0c0h, 0c0h, 0ffh, 19h, 0c0h, 0c0h
	defb	0ffh, 11h, 0e0h, 0e0h, 0ffh, 38h, 0f0h, 0f0h
	defb	07h, 04h, 0ffh, 64h, 0fh, 09h, 0ffh, 0ceh
	defb	3fh, 39h, 0ffh, 9eh, 7fh, 73h, 0ffh, 0ffh
	defb	0ffh, 0e0h, 0ffh, 7dh, 7fh, 7fh, 0ffh, 21h
	defb	3fh, 3fh, 0ffh, 61h, 0fh, 0eh, 0ffh, 1ch
	defb	07h, 06h, 0ffh, 7ch, 03h, 02h, 0efh, 0eeh
	defb	03h, 03h, 0cfh, 0ceh, 03h, 03h, 07h, 06h
	defb	02h, 02h, 07h, 07h, 00h, 00h, 03h, 03h
	defb	00h, 00h, 03h, 03h, 00h, 00h, 02h, 02h
	defb	0ffh, 7fh, 0f8h, 38h, 0ffh, 60h, 0fch, 0ch
	defb	0ffh, 0f0h, 0feh, 0feh, 0ffh, 0f3h, 0ffh, 0ffh
	defb	0ffh, 9bh, 0f0h, 0f0h, 0ffh, 09h, 80h, 80h
	defb	0ffh, 21h, 80h, 80h, 0ffh, 38h, 0c0h, 0c0h
	defb	0ffh, 7ch, 0c0h, 0c0h, 0ffh, 0ffh, 0c0h, 0c0h
	defb	0e3h, 0e3h, 0e0h, 0e0h, 0c1h, 0c1h, 0e0h, 0e0h
	defb	80h, 80h, 60h, 60h, 00h, 00h, 00h, 00h
	defb	00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h
	defb	00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h
	defb	1fh, 1fh, 0f8h, 0f8h, 3fh, 20h, 0fch, 04h
	defb	7fh, 40h, 0feh, 02h, 0ffh, 94h, 0ffh, 0b9h
	defb	0ffh, 0b4h, 0ffh, 0a5h, 0ffh, 94h, 0ffh, 0a5h
	defb	0ffh, 94h, 0ffh, 0b9h, 0ffh, 94h, 0ffh, 0a1h
	defb	0ffh, 0bbh, 0ffh, 21h, 7fh, 40h, 0feh, 02h
	defb	3fh, 20h, 0fch, 04h, 1fh, 1fh, 0f8h, 0f8h
	defb	00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h
	defb	10h, 10h, 10h, 10h, 38h, 28h, 38h, 28h
	defb	38h, 28h, 38h, 28h, 79h, 49h, 3ch, 24h
	defb	7bh, 4ah, 0bch, 0a4h, 0ffh, 8dh, 0feh, 62h
	defb	0ffh, 8ah, 0feh, 0a2h, 0ffh, 88h, 0feh, 22h
	defb	0ffh, 88h, 0feh, 22h, 0ffh, 88h, 0feh, 22h
	defb	0ffh, 88h, 0feh, 22h, 0ffh, 8ch, 0feh, 62h
	defb	7bh, 4bh, 0bch, 0a4h, 38h, 28h, 38h, 28h
	defb	10h, 10h, 10h, 10h, 00h, 00h, 00h, 00h
	defb	01h, 01h, 00h, 00h, 03h, 02h, 80h, 80h
	defb	07h, 04h, 0c0h, 40h, 07h, 04h, 0c0h, 40h
	defb	0fh, 0bh, 0e0h, 0a0h, 4fh, 48h, 0e4h, 24h
	defb	0efh, 0a8h, 0eeh, 2ah, 0ffh, 97h, 0feh, 0d2h
	defb	0ffh, 80h, 0feh, 02h, 7fh, 40h, 0fch, 04h
	defb	3fh, 24h, 0f8h, 48h, 1fh, 13h, 0f0h, 90h
	defb	0fh, 08h, 0e0h, 20h, 07h, 04h, 0c0h, 40h
	defb	03h, 03h, 80h, 80h, 00h, 00h, 00h, 00h
	defb	00h, 00h, 00h, 00h, 03h, 03h, 80h, 80h
	defb	07h, 04h, 0c0h, 40h, 0fh, 0bh, 0e0h, 0a0h
	defb	0fh, 0ch, 0e0h, 60h, 3fh, 38h, 0f8h, 38h
	defb	7fh, 48h, 0fch, 24h, 7fh, 48h, 0fch, 24h
	defb	0ffh, 88h, 0feh, 22h, 0ffh, 99h, 0feh, 32h
	defb	6fh, 6bh, 0ech, 0ach, 05h, 05h, 40h, 40h
	defb	01h, 01h, 00h, 00h, 01h, 01h, 00h, 00h
	defb	01h, 01h, 00h, 00h, 00h, 00h, 00h, 00h
	defb	00h, 00h, 00h, 00h, 00h, 00h, 0f0h, 0f0h
	defb	3fh, 3fh, 0f8h, 08h, 7fh, 42h, 0fch, 0e4h
	defb	0ffh, 82h, 0fch, 34h, 7fh, 74h, 0fch, 14h
	defb	0fh, 08h, 0fch, 14h, 1fh, 10h, 0f8h, 08h
	defb	1fh, 1eh, 0f8h, 38h, 07h, 06h, 0f8h, 48h
	defb	0bh, 0ah, 0f8h, 88h, 13h, 13h, 78h, 48h
	defb	00h, 00h, 78h, 48h, 00h, 00h, 70h, 50h
	defb	00h, 00h, 20h, 20h, 00h, 00h, 00h, 00h
	defb	03h, 03h, 00h, 00h, 07h, 04h, 0c0h, 0c0h
	defb	07h, 04h, 0e0h, 20h, 03h, 02h, 0e0h, 20h
	defb	07h, 07h, 0f8h, 0f8h, 0fh, 08h, 0fch, 14h
	defb	07h, 04h, 0feh, 0ah, 7fh, 7eh, 0feh, 0ah
	defb	07h, 04h, 0feh, 0ah, 0fh, 08h, 0fch, 14h
	defb	07h, 07h, 0f8h, 0f8h, 03h, 02h, 0e0h, 20h
	defb	07h, 04h, 0e0h, 20h, 07h, 04h, 0c0h, 0c0h
	defb	03h, 03h, 00h, 00h, 00h, 00h, 00h, 00h
	defb	00h, 00h, 20h, 20h, 00h, 00h, 70h, 50h
	defb	00h, 00h, 78h, 48h, 13h, 13h, 78h, 48h
	defb	0bh, 0ah, 0f8h, 88h, 07h, 06h, 0f8h, 48h
	defb	1fh, 1eh, 0f8h, 38h, 1fh, 10h, 0f8h, 08h
	defb	0fh, 08h, 0fch, 14h, 7fh, 74h, 0fch, 14h
	defb	0ffh, 82h, 0fch, 34h, 7fh, 42h, 0fch, 0e4h
	defb	3fh, 3fh, 0f8h, 08h, 00h, 00h, 0f0h, 0f0h
	defb	00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h
	defb	01h, 01h, 00h, 00h, 01h, 01h, 00h, 00h
	defb	01h, 01h, 00h, 00h, 05h, 05h, 40h, 40h
	defb	6fh, 6bh, 0ech, 0ach, 0ffh, 99h, 0feh, 32h
	defb	0ffh, 88h, 0feh, 22h, 7fh, 48h, 0fch, 24h
	defb	7fh, 48h, 0fch, 24h, 3fh, 38h, 0f8h, 38h
	defb	0fh, 0ch, 0e0h, 60h, 0fh, 0bh, 0e0h, 0a0h
	defb	07h, 04h, 0c0h, 40h, 03h, 03h, 80h, 80h
	defb	00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h
	defb	08h, 08h, 00h, 00h, 1ch, 14h, 00h, 00h
	defb	3ch, 24h, 00h, 00h, 3dh, 25h, 90h, 90h
	defb	3fh, 22h, 0a0h, 0a0h, 3fh, 24h, 0c0h, 0c0h
	defb	3fh, 38h, 0f0h, 0f0h, 3fh, 20h, 0f0h, 10h
	defb	7fh, 50h, 0e0h, 20h, 7fh, 50h, 0fch, 5ch
	defb	7fh, 58h, 0feh, 82h, 7fh, 4eh, 0fch, 84h
	defb	3fh, 21h, 0f8h, 0f8h, 1eh, 1eh, 00h, 00h
	defb	00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h
	defb	01h, 01h, 80h, 80h, 07h, 06h, 0c0h, 40h
	defb	0fh, 08h, 0c0h, 40h, 0fh, 08h, 80h, 80h
	defb	3fh, 3fh, 0c0h, 0c0h, 7fh, 50h, 0e0h, 20h
	defb	0ffh, 0a0h, 0c0h, 40h, 0ffh, 0a0h, 0fch, 0fch
	defb	0ffh, 0a0h, 0c0h, 40h, 7fh, 50h, 0e0h, 20h
	defb	3fh, 3fh, 0c0h, 0c0h, 0fh, 08h, 80h, 80h
	defb	0fh, 08h, 0c0h, 40h, 07h, 06h, 0c0h, 40h
	defb	01h, 01h, 80h, 80h, 00h, 00h, 00h, 00h
	defb	00h, 00h, 00h, 00h, 1eh, 1eh, 00h, 00h
	defb	3fh, 21h, 0f8h, 0f8h, 7fh, 4eh, 0fch, 84h
	defb	7fh, 58h, 0feh, 82h, 7fh, 50h, 0fch, 5ch
	defb	7fh, 50h, 0e0h, 20h, 3fh, 20h, 0f0h, 10h
	defb	3fh, 38h, 0f0h, 0f0h, 3fh, 24h, 0c0h, 0c0h
	defb	3fh, 22h, 0a0h, 0a0h, 3dh, 25h, 90h, 90h
	defb	3ch, 24h, 00h, 00h, 1ch, 14h, 00h, 00h
	defb	08h, 08h, 00h, 00h, 00h, 00h, 00h, 00h
	defb	40h, 40h, 04h, 04h, 0e3h, 0a3h, 8eh, 8ah
	defb	0f7h, 94h, 0deh, 52h, 0ffh, 88h, 0feh, 22h
	defb	0ffh, 93h, 0feh, 92h, 7fh, 54h, 0fch, 54h
	defb	3fh, 30h, 0f8h, 18h, 1fh, 10h, 0f0h, 10h
	defb	3fh, 30h, 0f8h, 18h, 7fh, 54h, 0fch, 54h
	defb	0ffh, 93h, 0feh, 92h, 0ffh, 88h, 0feh, 22h
	defb	0f7h, 94h, 0deh, 52h, 0e3h, 0a3h, 8eh, 8ah
	defb	40h, 40h, 04h, 04h, 00h, 00h, 00h, 00h
	defb	7fh, 7fh, 0fch, 0fch, 0ffh, 0c0h, 0feh, 06h
	defb	0ffh, 0a0h, 0feh, 0ah, 0ffh, 9fh, 0feh, 0f6h
	defb	0ffh, 93h, 0feh, 9ah, 0ffh, 95h, 0feh, 56h
	defb	0ffh, 98h, 0feh, 3ah, 0ffh, 9ch, 0feh, 76h
	defb	0ffh, 98h, 0feh, 3ah, 0ffh, 95h, 0feh, 56h
	defb	0ffh, 93h, 0feh, 9ah, 0ffh, 9fh, 0feh, 0f6h
	defb	0ffh, 0aah, 0feh, 0aah, 0ffh, 0d5h, 0feh, 56h
	defb	7fh, 7fh, 0fch, 0fch, 00h, 00h, 00h, 00h
	defb	70h, 70h, 1ch, 1ch, 0ffh, 8fh, 0feh, 0e2h
	defb	0ffh, 90h, 0feh, 12h, 0ffh, 0a0h, 0feh, 0ah
	defb	7fh, 43h, 0fch, 84h, 7fh, 45h, 0fch, 4ch
	defb	7fh, 48h, 0fch, 24h, 7fh, 4ch, 0fch, 6ch
	defb	7fh, 48h, 0fch, 24h, 7fh, 45h, 0fch, 4ch
	defb	7fh, 43h, 0fch, 94h, 0ffh, 0a0h, 0feh, 2ah
	defb	0ffh, 95h, 0feh, 52h, 0ffh, 8fh, 0feh, 0e2h
	defb	70h, 70h, 1ch, 1ch, 00h, 00h, 00h, 00h
