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

ColorPattern: public ColorPattern
;	terrain
	defb	0ffh, 00h, 00h, 0ffh, 00h, 60h, 0ffh, 00h
	defb	00h, 0ffh, 00h, 06h, 0ffh, 00h, 00h, 0ffh
	defb	00h, 60h, 0ffh, 00h, 00h, 0ffh, 00h, 06h
	defb	00h, 0ffh, 0ffh, 00h, 0ffh, 0ffh, 00h, 0ffh
	defb	0ffh, 00h, 0ffh, 0ffh, 00h, 0ffh, 0ffh, 00h
	defb	0ffh, 0ffh, 00h, 0ffh, 0ffh, 00h, 0ffh, 0ffh
	defb	0aah, 0aah, 0aah, 55h, 55h, 55h, 0aah, 0aah
	defb	0aah, 55h, 55h, 55h, 0aah, 0aah, 0aah, 55h
	defb	55h, 55h, 0aah, 0aah, 0aah, 55h, 55h, 55h
	defb	00h, 00h, 0d5h, 00h, 00h, 0a2h, 00h, 00h
	defb	0d4h, 00h, 00h, 0eah, 00h, 00h, 0f5h, 00h
	defb	00h, 0bah, 00h, 00h, 0fch, 00h, 00h, 0fdh
	defb	0feh, 00h, 01h, 0fch, 00h, 63h, 0fch, 00h
	defb	03h, 0f8h, 00h, 03h, 0f0h, 00h, 6fh, 0e0h
	defb	00h, 1fh, 0c0h, 00h, 3fh, 00h, 00h, 0fbh
	defb	00h, 00h, 55h, 00h, 00h, 0a2h, 00h, 00h
	defb	54h, 00h, 00h, 8ah, 00h, 00h, 55h, 00h
	defb	00h, 0a2h, 00h, 00h, 54h, 00h, 00h, 8ah
	defb	00h, 00h, 0ffh, 00h, 00h, 0beh, 00h, 00h
	defb	0fch, 00h, 00h, 0fah, 00h, 00h, 0f5h, 00h
	defb	00h, 0a2h, 00h, 00h, 0d4h, 00h, 00h, 8ah
	defb	00h, 00h, 0ffh, 80h, 00h, 3fh, 0e0h, 00h
	defb	1fh, 0f0h, 00h, 0bh, 0f8h, 00h, 07h, 0fch
	defb	00h, 63h, 0fch, 00h, 03h, 0feh, 00h, 07h
	defb	00h, 00h, 0ffh, 01h, 00h, 0beh, 07h, 00h
	defb	0f8h, 0fh, 00h, 0f6h, 1fh, 00h, 0e0h, 3fh
	defb	00h, 0a0h, 3fh, 00h, 0c0h, 7fh, 00h, 86h
	defb	00h, 00h, 55h, 00h, 00h, 0a3h, 00h, 00h
	defb	57h, 00h, 00h, 8bh, 00h, 00h, 5fh, 00h
	defb	00h, 0bfh, 00h, 00h, 7fh, 00h, 00h, 0fbh
	defb	00h, 00h, 0ffh, 00h, 00h, 0ffh, 00h, 00h
	defb	5fh, 00h, 00h, 8bh, 00h, 00h, 57h, 00h
	defb	00h, 0a3h, 00h, 00h, 57h, 00h, 00h, 8bh
	defb	00h, 00h, 0ffh, 00h, 00h, 0bfh, 00h, 00h
	defb	0ffh, 00h, 00h, 0fbh, 00h, 00h, 0ffh, 00h
	defb	00h, 0bfh, 00h, 00h, 0ffh, 00h, 00h, 0fbh
	defb	7fh, 00h, 80h, 3fh, 00h, 0a0h, 3fh, 00h
	defb	0c0h, 1fh, 00h, 0e6h, 0fh, 00h, 0f0h, 07h
	defb	00h, 0b8h, 03h, 00h, 0fch, 00h, 00h, 0fbh
;	fort
	defb	00h, 00h, 0ffh, 00h, 00h, 0bfh, 00h, 00h
	defb	0ffh, 07h, 00h, 0ffh, 03h, 00h, 0f3h, 10h
	defb	00h, 0b0h, 18h, 03h, 0fbh, 18h, 03h, 0fbh
	defb	00h, 00h, 0ffh, 00h, 00h, 0bfh, 00h, 00h
	defb	0ffh, 0efh, 00h, 0efh, 0e0h, 00h, 0e0h, 0fh
	defb	00h, 0fh, 00h, 00h, 00h, 37h, 37h, 30h
	defb	00h, 0ch, 0f3h, 00h, 1eh, 0a1h, 00h, 3fh
	defb	0c0h, 80h, 3fh, 80h, 00h, 1eh, 00h, 0a0h
	defb	0ch, 0a0h, 01h, 01h, 01h, 0fdh, 0fdh, 01h
	defb	00h, 30h, 0cfh, 00h, 78h, 87h, 00h, 0fch
	defb	03h, 01h, 0fch, 01h, 00h, 78h, 00h, 05h
	defb	30h, 05h, 80h, 80h, 80h, 0bfh, 0bfh, 80h
	defb	00h, 00h, 0ffh, 00h, 00h, 7fh, 00h, 00h
	defb	0ffh, 0f7h, 00h, 0f7h, 07h, 00h, 07h, 0f0h
	defb	00h, 0f0h, 00h, 00h, 00h, 0ech, 0ech, 0ch
	defb	00h, 00h, 0ffh, 00h, 00h, 0bfh, 00h, 00h
	defb	0ffh, 0e0h, 00h, 0fbh, 0c0h, 00h, 0cfh, 08h
	defb	00h, 0fh, 18h, 0c0h, 0dfh, 18h, 0c0h, 0dbh
	defb	18h, 00h, 0f8h, 19h, 00h, 0b9h, 00h, 00h
	defb	0e0h, 0fh, 0fh, 0efh, 00h, 00h, 0e0h, 01h
	defb	18h, 0a0h, 01h, 3ch, 0c0h, 01h, 3ch, 0c0h
	defb	78h, 78h, 78h, 79h, 78h, 79h, 35h, 30h
	defb	35h, 40h, 00h, 40h, 0eh, 0eh, 0eh, 0ceh
	defb	0eh, 0eh, 0ceh, 0eh, 0eh, 0ceh, 0eh, 0eh
	defb	01h, 01h, 01h, 99h, 01h, 99h, 0bch, 00h
	defb	0bch, 7eh, 00h, 7eh, 0ffh, 00h, 0ffh, 0ffh
	defb	00h, 0ffh, 7eh, 00h, 7eh, 0bch, 00h, 0bch
	defb	80h, 80h, 80h, 99h, 80h, 99h, 3dh, 00h
	defb	3dh, 7eh, 00h, 7eh, 0ffh, 00h, 0ffh, 0ffh
	defb	00h, 0ffh, 7eh, 00h, 7eh, 3dh, 00h, 3dh
	defb	1eh, 1eh, 1eh, 9eh, 1eh, 9eh, 0ach, 0ch
	defb	0ach, 02h, 00h, 02h, 70h, 70h, 70h, 73h
	defb	70h, 70h, 73h, 70h, 70h, 73h, 70h, 70h
	defb	18h, 00h, 1fh, 98h, 00h, 9fh, 00h, 00h
	defb	07h, 0f0h, 0f0h, 0f3h, 00h, 00h, 07h, 80h
	defb	18h, 07h, 80h, 3ch, 03h, 80h, 3ch, 03h
	defb	00h, 18h, 0e0h, 01h, 01h, 0a0h, 0fdh, 01h
	defb	0fch, 0fdh, 01h, 0fch, 00h, 00h, 00h, 0b5h
	defb	30h, 0b5h, 0b5h, 30h, 0b5h, 0b5h, 30h, 0b5h
	defb	00h, 00h, 00h, 0d0h, 0c0h, 10h, 0c3h, 0c0h
	defb	00h, 0c3h, 0c0h, 00h, 00h, 00h, 00h, 77h
	defb	70h, 77h, 77h, 70h, 77h, 77h, 70h, 77h
	defb	19h, 01h, 19h, 00h, 00h, 00h, 0feh, 00h
	defb	00h, 0feh, 00h, 00h, 00h, 00h, 00h, 0bdh
	defb	01h, 0bdh, 0bdh, 01h, 0bdh, 0bdh, 01h, 0bdh
	defb	98h, 80h, 98h, 00h, 00h, 00h, 7fh, 00h
	defb	00h, 7fh, 00h, 00h, 00h, 00h, 00h, 0bdh
	defb	80h, 0bdh, 0bdh, 80h, 0bdh, 0bdh, 80h, 0bdh
	defb	00h, 00h, 00h, 0bh, 03h, 08h, 0c3h, 03h
	defb	00h, 0c3h, 03h, 00h, 00h, 00h, 00h, 0eeh
	defb	0eh, 0eeh, 0eeh, 0eh, 0eeh, 0eeh, 0eh, 0eeh
	defb	00h, 18h, 07h, 80h, 80h, 07h, 0bfh, 80h
	defb	3fh, 0bfh, 80h, 3fh, 00h, 00h, 00h, 0adh
	defb	0ch, 0adh, 0adh, 0ch, 0adh, 0adh, 0ch, 0adh
	defb	0b5h, 30h, 0b5h, 0b5h, 30h, 0b5h, 0b5h, 30h
	defb	0b5h, 00h, 00h, 00h, 0fdh, 01h, 0fch, 0fdh
	defb	01h, 0fch, 01h, 01h, 0e0h, 00h, 18h, 0e0h
	defb	77h, 70h, 77h, 77h, 70h, 77h, 77h, 70h
	defb	77h, 00h, 00h, 00h, 0c3h, 0c0h, 00h, 0c3h
	defb	0c0h, 00h, 0d0h, 0c0h, 10h, 00h, 00h, 00h
	defb	0bdh, 01h, 0bdh, 0bdh, 01h, 0bdh, 0bdh, 01h
	defb	0bdh, 00h, 00h, 00h, 0feh, 00h, 00h, 0feh
	defb	00h, 00h, 00h, 00h, 00h, 19h, 01h, 19h
	defb	0bdh, 80h, 0bdh, 0bdh, 80h, 0bdh, 0bdh, 80h
	defb	0bdh, 00h, 00h, 00h, 7fh, 00h, 00h, 7fh
	defb	00h, 00h, 00h, 00h, 00h, 98h, 80h, 98h
	defb	0eeh, 0eh, 0eeh, 0eeh, 0eh, 0eeh, 0eeh, 0eh
	defb	0eeh, 00h, 00h, 00h, 0c3h, 03h, 00h, 0c3h
	defb	03h, 00h, 0bh, 03h, 08h, 00h, 00h, 00h
	defb	0adh, 0ch, 0adh, 0adh, 0ch, 0adh, 0adh, 0ch
	defb	0adh, 00h, 00h, 00h, 0bfh, 80h, 3fh, 0bfh
	defb	80h, 3fh, 80h, 80h, 07h, 00h, 18h, 03h
	defb	01h, 3ch, 0c0h, 01h, 3ch, 80h, 01h, 18h
	defb	0e0h, 00h, 00h, 0e0h, 0fh, 0fh, 0efh, 00h
	defb	00h, 0a0h, 19h, 00h, 0f9h, 18h, 00h, 0f8h
	defb	0ceh, 0eh, 0eh, 0ceh, 0eh, 0eh, 0ceh, 0eh
	defb	0eh, 0eh, 0eh, 0eh, 40h, 00h, 40h, 35h
	defb	30h, 35h, 79h, 78h, 79h, 78h, 78h, 78h
	defb	0bch, 00h, 0bch, 7eh, 00h, 7eh, 0ffh, 00h
	defb	0ffh, 0ffh, 00h, 0ffh, 7eh, 00h, 7eh, 0bch
	defb	00h, 0bch, 99h, 01h, 99h, 01h, 01h, 01h
	defb	3dh, 00h, 3dh, 7eh, 00h, 7eh, 0ffh, 00h
	defb	0ffh, 0ffh, 00h, 0ffh, 7eh, 00h, 7eh, 3dh
	defb	00h, 3dh, 99h, 80h, 99h, 80h, 80h, 80h
	defb	73h, 70h, 70h, 73h, 70h, 70h, 73h, 70h
	defb	70h, 70h, 70h, 70h, 02h, 00h, 02h, 0ach
	defb	0ch, 0ach, 9eh, 1eh, 9eh, 1eh, 1eh, 1eh
	defb	80h, 3ch, 03h, 80h, 3ch, 03h, 80h, 18h
	defb	07h, 00h, 00h, 03h, 0f0h, 0f0h, 0f7h, 00h
	defb	00h, 07h, 98h, 00h, 9fh, 18h, 00h, 1bh
	defb	18h, 03h, 0fbh, 18h, 03h, 0bbh, 10h, 00h
	defb	0f0h, 03h, 00h, 0f3h, 07h, 00h, 0ffh, 00h
	defb	00h, 0bfh, 00h, 00h, 0ffh, 00h, 00h, 0fbh
	defb	37h, 37h, 30h, 00h, 00h, 00h, 0fh, 00h
	defb	0fh, 0e0h, 00h, 0e0h, 0efh, 00h, 0efh, 00h
	defb	00h, 0bfh, 00h, 00h, 0ffh, 00h, 00h, 0fbh
	defb	0fdh, 0fdh, 01h, 01h, 01h, 01h, 0a0h, 0ch
	defb	0a0h, 00h, 1eh, 00h, 80h, 3fh, 80h, 00h
	defb	3fh, 80h, 00h, 1eh, 0e1h, 00h, 0ch, 0f3h
	defb	0bfh, 0bfh, 80h, 80h, 80h, 80h, 05h, 30h
	defb	05h, 00h, 78h, 00h, 01h, 0fch, 01h, 00h
	defb	0fch, 03h, 00h, 78h, 87h, 00h, 30h, 0cbh
	defb	0ech, 0ech, 0ch, 00h, 00h, 00h, 0f0h, 00h
	defb	0f0h, 07h, 00h, 07h, 0f7h, 00h, 0f7h, 00h
	defb	00h, 0bfh, 00h, 00h, 0ffh, 00h, 00h, 0fbh
	defb	18h, 0c0h, 0dfh, 18h, 0c0h, 0dfh, 08h, 00h
	defb	0fh, 0c0h, 00h, 0cbh, 0e0h, 00h, 0ffh, 00h
	defb	00h, 0bfh, 00h, 00h, 0ffh, 00h, 00h, 0fbh
