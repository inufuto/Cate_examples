cseg
CharPattern: public CharPattern
; ascii 31
	; " -0123456789ACDEFGHIKMNOPRSTUVY"
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
	defb 7ch,66h,63h,63h,63h,66h,7ch,00h
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
	defb	00h, 60h, 00h, 06h, 00h, 60h, 00h, 06h
	defb	00h, 60h, 00h, 06h, 01h, 63h, 03h, 03h
	defb	00h, 60h, 00h, 06h, 80h, 0a0h, 0c0h, 0e6h
	defb	0e0h, 0a0h, 0c0h, 86h, 00h, 60h, 00h, 06h
	defb	07h, 63h, 03h, 07h, 00h, 60h, 00h, 06h
	defb	00h, 60h, 00h, 06h, 00h, 0feh, 0feh, 0feh
	defb	00h, 60h, 00h, 06h, 00h, 7fh, 7fh, 7fh
	defb	0feh, 0feh, 0feh, 00h, 00h, 60h, 00h, 06h
	defb	7fh, 7fh, 7fh, 00h, 00h, 60h, 00h, 06h
	defb	55h, 0a2h, 54h, 8ah, 55h, 0a2h, 54h, 8ah
	defb	0f5h, 0a2h, 0d4h, 8ah, 55h, 0a2h, 54h, 8ah
	defb	55h, 0a2h, 54h, 8ah, 55h, 0a3h, 57h, 8bh
	defb	55h, 0a2h, 54h, 8ah, 0d5h, 0a2h, 0d4h, 0eah
	defb	80h, 0a0h, 0c0h, 0e6h, 0f0h, 0b8h, 0fch, 0fbh
	defb	57h, 0a3h, 57h, 8bh, 55h, 0a2h, 54h, 8ah
	defb	01h, 63h, 03h, 03h, 6fh, 1fh, 3fh, 0fbh
	defb	00h, 60h, 00h, 06h, 0ffh, 0bfh, 0ffh, 0fbh
	defb	0ffh, 3fh, 1fh, 0bh, 07h, 63h, 03h, 07h
	defb	0ffh, 0bfh, 0ffh, 0fbh, 00h, 60h, 00h, 06h
	defb	0ffh, 0beh, 0f8h, 0f6h, 0e0h, 0a0h, 0c0h, 86h
	defb	0d5h, 0a2h, 0d4h, 0eah, 0f5h, 0bah, 0fch, 0fdh
	defb	0ffh, 0beh, 0fch, 0fah, 0f5h, 0a2h, 0d4h, 8ah
	defb	55h, 0a2h, 54h, 8ah, 0ffh, 0bfh, 0ffh, 0fbh
	defb	0ffh, 0bfh, 0ffh, 0fbh, 55h, 0a2h, 54h, 8ah
	defb	55h, 0a3h, 57h, 8bh, 5fh, 0bfh, 7fh, 0fbh
	defb	0ffh, 0ffh, 5fh, 8bh, 57h, 0a3h, 57h, 8bh
	defb	00h, 0feh, 0feh, 0feh, 0feh, 0feh, 0feh, 0feh
	defb	00h, 7fh, 7fh, 7fh, 7fh, 7fh, 7fh, 7fh
	defb	0feh, 0feh, 0feh, 0feh, 0feh, 0feh, 0feh, 00h
	defb	7fh, 7fh, 7fh, 7fh, 7fh, 7fh, 7fh, 00h
	defb	0f0h, 0b8h, 0fch, 0fbh, 0ffh, 0bfh, 0ffh, 0fbh
	defb	7fh, 7fh, 7fh, 00h, 0ffh, 0bfh, 0ffh, 0fbh
	defb	0feh, 0feh, 0feh, 00h, 0ffh, 0bfh, 0ffh, 0fbh
	defb	0ffh, 0bfh, 0ffh, 0fbh, 00h, 7fh, 7fh, 7fh
	defb	0ffh, 0bfh, 0ffh, 0fbh, 00h, 0feh, 0feh, 0feh
	defb	0ffh, 0bfh, 0ffh, 0fbh, 0ffh, 3fh, 1fh, 0bh
	defb	6fh, 1fh, 3fh, 0fbh, 0ffh, 0bfh, 0ffh, 0fbh
	defb	0f5h, 0bah, 0fch, 0fdh, 0ffh, 0bfh, 0ffh, 0fbh
	defb	0ffh, 0ffh, 0ffh, 00h, 0ffh, 0bfh, 0ffh, 0fbh
	defb	0ffh, 0bfh, 0ffh, 0fbh, 00h, 0ffh, 0ffh, 0ffh
	defb	0ffh, 0bfh, 0ffh, 0fbh, 0ffh, 0beh, 0f8h, 0f6h
	defb	0ffh, 0bfh, 0ffh, 0fbh, 0ffh, 0beh, 0fch, 0fah
	defb	7fh, 7fh, 7fh, 7fh, 7fh, 7fh, 7fh, 7fh
	defb	0feh, 0feh, 0feh, 0feh, 0feh, 0feh, 0feh, 0feh
	defb	0ffh, 0ffh, 0ffh, 0ffh, 0ffh, 0ffh, 0ffh, 00h
	defb	00h, 0ffh, 0ffh, 0ffh, 0ffh, 0ffh, 0ffh, 0ffh
	defb	0ffh, 0bfh, 0ffh, 0fbh, 0ffh, 0ffh, 5fh, 8bh
	defb	5fh, 0bfh, 7fh, 0fbh, 0ffh, 0bfh, 0ffh, 0fbh
	defb	0ffh, 0bfh, 0ffh, 0fbh, 0ffh, 0bfh, 0ffh, 0fbh
	defb	7fh, 7fh, 7fh, 7fh, 0ffh, 0ffh, 0ffh, 0ffh
	defb	0feh, 0feh, 0feh, 0feh, 0ffh, 0ffh, 0ffh, 0ffh
	defb	0ffh, 0ffh, 0ffh, 0ffh, 0feh, 0feh, 0feh, 0feh
	defb	0ffh, 0ffh, 0ffh, 0ffh, 7fh, 7fh, 7fh, 7fh
	defb	0ffh, 0ffh, 0ffh, 0ffh, 0ffh, 0ffh, 0ffh, 0ffh
;	fort6
	defb	0ffh, 0bfh, 0f8h, 0f7h, 0e3h, 90h, 0dbh, 0dbh
	defb	0ffh, 0bfh, 00h, 0efh, 0e0h, 0fh, 00h, 37h
	defb	0f3h, 0adh, 1eh, 0deh, 1eh, 0ach, 01h, 0fdh
	defb	0cfh, 0b7h, 78h, 7bh, 78h, 35h, 80h, 0bfh
	defb	0ffh, 0bfh, 00h, 0f7h, 07h, 0f0h, 00h, 0ech
	defb	0ffh, 0bfh, 0fh, 0efh, 0c7h, 09h, 0dbh, 0dbh
	defb	0d8h, 99h, 0e0h, 0efh, 0e0h, 0d9h, 0bdh, 0bdh
	defb	78h, 79h, 35h, 40h, 0eh, 0ceh, 0ceh, 0ceh
	defb	01h, 99h, 0bch, 7eh, 0ffh, 0ffh, 7eh, 0bch
	defb	80h, 99h, 3dh, 7eh, 0ffh, 0ffh, 7eh, 3dh
	defb	1eh, 9eh, 0ach, 02h, 70h, 73h, 73h, 73h
	defb	1bh, 99h, 07h, 0f7h, 07h, 9bh, 0bdh, 0bdh
	defb	0d8h, 81h, 7dh, 7dh, 00h, 6dh, 6dh, 6dh
	defb	00h, 0d0h, 0c3h, 0c3h, 00h, 77h, 77h, 77h
	defb	19h, 00h, 0feh, 0feh, 00h, 0bdh, 0bdh, 0bdh
	defb	98h, 00h, 7fh, 7fh, 00h, 0bdh, 0bdh, 0bdh
	defb	00h, 0bh, 0c3h, 0c3h, 00h, 0eeh, 0eeh, 0eeh
	defb	1bh, 81h, 0beh, 0beh, 00h, 0b6h, 0b6h, 0b6h
	defb	6dh, 6dh, 6dh, 00h, 7dh, 7dh, 81h, 0d8h
	defb	77h, 77h, 77h, 00h, 0c3h, 0c3h, 0d0h, 00h
	defb	0bdh, 0bdh, 0bdh, 00h, 0feh, 0feh, 00h, 19h
	defb	0bdh, 0bdh, 0bdh, 00h, 7fh, 7fh, 00h, 98h
	defb	0eeh, 0eeh, 0eeh, 00h, 0c3h, 0c3h, 0bh, 00h
	defb	0b6h, 0b6h, 0b6h, 00h, 0beh, 0beh, 81h, 1bh
	defb	0bdh, 0bdh, 0d9h, 0e0h, 0efh, 0a0h, 0d9h, 0d8h
	defb	0ceh, 0ceh, 0ceh, 0eh, 40h, 35h, 79h, 78h
	defb	0bch, 7eh, 0ffh, 0ffh, 7eh, 0bch, 99h, 01h
	defb	3dh, 7eh, 0ffh, 0ffh, 7eh, 3dh, 99h, 80h
	defb	73h, 73h, 73h, 70h, 02h, 0ach, 9eh, 1eh
	defb	0bdh, 0bdh, 9bh, 07h, 0f7h, 07h, 9bh, 1bh
	defb	0dbh, 9bh, 0d0h, 0e3h, 0f7h, 0b8h, 0ffh, 0fbh
	defb	37h, 00h, 0fh, 0e0h, 0efh, 00h, 0ffh, 0fbh
	defb	0fdh, 01h, 0ach, 1eh, 0deh, 1eh, 0edh, 0f3h
	defb	0bfh, 80h, 35h, 78h, 7bh, 78h, 0b7h, 0cbh
	defb	0ech, 00h, 0f0h, 07h, 0f7h, 00h, 0ffh, 0fbh
	defb	0dbh, 0dbh, 0bh, 0c3h, 0efh, 1fh, 0ffh, 0fbh
;	fort7
	defb	0ffh, 0bfh, 0ffh, 0fbh, 0ffh, 0bfh, 0f8h, 0f7h
	defb	0ffh, 0bfh, 0ffh, 0fbh, 0ffh, 0bfh, 00h, 0efh
	defb	0ffh, 0bfh, 0ffh, 0fbh, 0f3h, 0adh, 1eh, 0deh
	defb	0ffh, 0bfh, 0ffh, 0fbh, 0cfh, 0b7h, 78h, 7bh
	defb	0ffh, 0bfh, 0ffh, 0fbh, 0ffh, 0bfh, 00h, 0f7h
	defb	0ffh, 0bfh, 0ffh, 0fbh, 0ffh, 0bfh, 0fh, 0efh
	defb	0e3h, 90h, 0dbh, 0dbh, 0d8h, 99h, 0e0h, 0efh
	defb	0e0h, 0fh, 00h, 37h, 78h, 79h, 35h, 40h
	defb	1eh, 0ach, 01h, 0fdh, 01h, 99h, 0bch, 7eh
	defb	78h, 35h, 80h, 0bfh, 80h, 99h, 3dh, 7eh
	defb	07h, 0f0h, 00h, 0ech, 1eh, 9eh, 0ach, 02h
	defb	0c7h, 09h, 0dbh, 0dbh, 1bh, 99h, 07h, 0f7h
	defb	0e0h, 0d9h, 0bdh, 0bdh, 0d8h, 81h, 7dh, 7dh
	defb	0eh, 0ceh, 0ceh, 0ceh, 00h, 0d0h, 0c3h, 0c3h
	defb	0ffh, 0ffh, 7eh, 0bch, 19h, 00h, 0feh, 0feh
	defb	0ffh, 0ffh, 7eh, 3dh, 98h, 00h, 7fh, 7fh
	defb	70h, 73h, 73h, 73h, 00h, 0bh, 0c3h, 0c3h
	defb	07h, 9bh, 0bdh, 0bdh, 1bh, 81h, 0beh, 0beh
	defb	00h, 6dh, 6dh, 6dh, 6dh, 6dh, 6dh, 00h
	defb	00h, 77h, 77h, 77h, 77h, 77h, 77h, 00h
	defb	00h, 0bdh, 0bdh, 0bdh, 0bdh, 0bdh, 0bdh, 00h
	defb	00h, 0bdh, 0bdh, 0bdh, 0bdh, 0bdh, 0bdh, 00h
	defb	00h, 0eeh, 0eeh, 0eeh, 0eeh, 0eeh, 0eeh, 00h
	defb	00h, 0b6h, 0b6h, 0b6h, 0b6h, 0b6h, 0b6h, 00h
	defb	7dh, 7dh, 81h, 0d8h, 0bdh, 0bdh, 0d9h, 0e0h
	defb	0c3h, 0c3h, 0d0h, 00h, 0ceh, 0ceh, 0ceh, 0eh
	defb	0feh, 0feh, 00h, 19h, 0bch, 7eh, 0ffh, 0ffh
	defb	7fh, 7fh, 00h, 98h, 3dh, 7eh, 0ffh, 0ffh
	defb	0c3h, 0c3h, 0bh, 00h, 73h, 73h, 73h, 70h
	defb	0beh, 0beh, 81h, 1bh, 0bdh, 0bdh, 9bh, 07h
	defb	0efh, 0a0h, 0d9h, 0d8h, 0dbh, 9bh, 0d0h, 0e3h
	defb	40h, 35h, 79h, 78h, 37h, 00h, 0fh, 0e0h
	defb	7eh, 0bch, 99h, 01h, 0fdh, 01h, 0ach, 1eh
	defb	7eh, 3dh, 99h, 80h, 0bfh, 80h, 35h, 78h
	defb	02h, 0ach, 9eh, 1eh, 0ech, 00h, 0f0h, 07h
	defb	0f7h, 07h, 9bh, 1bh, 0dbh, 0dbh, 0bh, 0c3h
	defb	0f7h, 0b8h, 0ffh, 0fbh, 0ffh, 0bfh, 0ffh, 0fbh
	defb	0efh, 00h, 0ffh, 0fbh, 0ffh, 0bfh, 0ffh, 0fbh
	defb	0deh, 1eh, 0edh, 0f3h, 0ffh, 0bfh, 0ffh, 0fbh
	defb	7bh, 78h, 0b7h, 0cbh, 0ffh, 0bfh, 0ffh, 0fbh
	defb	0f7h, 00h, 0ffh, 0fbh, 0ffh, 0bfh, 0ffh, 0fbh
	defb	0efh, 1fh, 0ffh, 0fbh, 0ffh, 0bfh, 0ffh, 0fbh

SpritePattern: public SpritePattern
;	sprite
	defb	10h, 00h, 00h, 00h, 38h, 10h, 00h, 00h
	defb	38h, 10h, 00h, 00h, 38h, 10h, 00h, 00h
	defb	38h, 10h, 00h, 00h, 38h, 10h, 00h, 00h
	defb	38h, 10h, 00h, 00h, 10h, 00h, 00h, 00h
	defb	00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h
	defb	00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h
	defb	00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h
	defb	00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h
	defb	3ch, 00h, 00h, 00h, 7eh, 3ch, 00h, 00h
	defb	0ffh, 66h, 00h, 00h, 0ffh, 42h, 00h, 00h
	defb	0ffh, 42h, 00h, 00h, 0ffh, 66h, 00h, 00h
	defb	7eh, 3ch, 00h, 00h, 3ch, 00h, 00h, 00h
	defb	00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h
	defb	00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h
	defb	00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h
	defb	00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h
	defb	3ch, 00h, 00h, 00h, 7eh, 3ch, 00h, 00h
	defb	0ffh, 66h, 0ffh, 00h, 0ffh, 5ah, 0ffh, 0ffh
	defb	0ffh, 5ah, 0ffh, 0ffh, 0ffh, 66h, 0ffh, 00h
	defb	7eh, 3ch, 00h, 00h, 3ch, 00h, 00h, 00h
	defb	00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h
	defb	00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h
	defb	00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h
	defb	00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h
	defb	00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h
	defb	0ffh, 00h, 0ffh, 00h, 0ffh, 0ffh, 0ffh, 0ffh
	defb	0ffh, 0ffh, 0ffh, 0ffh, 0ffh, 00h, 0ffh, 00h
	defb	00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h
	defb	00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h
	defb	00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h
	defb	00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h
	defb	00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h
	defb	00h, 00h, 3ch, 00h, 00h, 00h, 7eh, 3ch
	defb	0ffh, 00h, 0ffh, 66h, 0ffh, 0ffh, 0ffh, 5ah
	defb	0ffh, 0ffh, 0ffh, 5ah, 0ffh, 00h, 0ffh, 66h
	defb	00h, 00h, 7eh, 3ch, 00h, 00h, 3ch, 00h
	defb	00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h
	defb	00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h
	defb	00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h
	defb	00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h
	defb	01h, 00h, 04h, 00h, 21h, 00h, 9ch, 00h
	defb	33h, 00h, 0f8h, 00h, 3fh, 01h, 0f9h, 00h
	defb	3fh, 1bh, 0ffh, 90h, 0ffh, 1eh, 0feh, 0f0h
	defb	7fh, 08h, 0fch, 60h, 3fh, 04h, 0f8h, 40h
	defb	1fh, 04h, 0fch, 20h, 3fh, 0fh, 0ffh, 30h
	defb	0ffh, 1dh, 0feh, 0f0h, 7fh, 11h, 0f8h, 0b0h
	defb	3fh, 01h, 0fch, 10h, 1bh, 00h, 0fch, 00h
	defb	11h, 00h, 8ch, 00h, 01h, 00h, 00h, 00h
	defb	00h, 00h, 02h, 00h, 00h, 00h, 07h, 00h
	defb	08h, 00h, 07h, 00h, 0eh, 00h, 0fh, 00h
	defb	07h, 00h, 9fh, 02h, 07h, 00h, 0ffh, 03h
	defb	07h, 01h, 0ffh, 87h, 03h, 00h, 0ffh, 0c7h
	defb	03h, 00h, 0ffh, 0edh, 1fh, 00h, 0ffh, 7dh
	defb	0ffh, 0ch, 0ffh, 60h, 7fh, 07h, 0ffh, 0c4h
	defb	3fh, 01h, 0ffh, 86h, 1fh, 00h, 0ffh, 0e6h
	defb	0fh, 00h, 0ffh, 67h, 07h, 01h, 0ffh, 0cfh
	defb	00h, 00h, 60h, 00h, 00h, 00h, 0e0h, 00h
	defb	01h, 00h, 0c0h, 00h, 87h, 00h, 0c0h, 00h
	defb	8fh, 00h, 0c0h, 00h, 0dfh, 00h, 80h, 00h
	defb	0ffh, 02h, 8eh, 00h, 0ffh, 86h, 0bch, 00h
	defb	0ffh, 8eh, 0f8h, 00h, 0ffh, 0dah, 0f8h, 00h
	defb	0ffh, 0f3h, 0f0h, 0c0h, 0ffh, 63h, 0e0h, 00h
	defb	0ffh, 07h, 0c0h, 00h, 0ffh, 0e6h, 0c0h, 00h
	defb	0ffh, 0eeh, 0e0h, 00h, 0ffh, 0c7h, 0f0h, 00h
	defb	07h, 03h, 0ffh, 9bh, 0fh, 06h, 0ffh, 31h
	defb	3fh, 06h, 0ffh, 61h, 7fh, 0ch, 0ffh, 00h
	defb	0ffh, 1fh, 0ffh, 82h, 7fh, 00h, 0ffh, 0deh
	defb	3fh, 00h, 0ffh, 9eh, 0fh, 01h, 0ffh, 0e3h
	defb	07h, 01h, 0ffh, 83h, 03h, 01h, 0efh, 01h
	defb	03h, 00h, 0cfh, 01h, 03h, 00h, 07h, 01h
	defb	02h, 00h, 07h, 00h, 00h, 00h, 03h, 00h
	defb	00h, 00h, 03h, 00h, 00h, 00h, 02h, 00h
	defb	0ffh, 80h, 0f8h, 0c0h, 0ffh, 9fh, 0fch, 0f0h
	defb	0ffh, 0fh, 0feh, 00h, 0ffh, 0ch, 0ffh, 00h
	defb	0ffh, 64h, 0f0h, 00h, 0ffh, 0f6h, 80h, 00h
	defb	0ffh, 0deh, 80h, 00h, 0ffh, 0c7h, 0c0h, 00h
	defb	0ffh, 83h, 0c0h, 00h, 0ffh, 00h, 0c0h, 00h
	defb	0e3h, 00h, 0e0h, 00h, 0c1h, 00h, 0e0h, 00h
	defb	80h, 00h, 60h, 00h, 00h, 00h, 00h, 00h
	defb	00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h
	defb	00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h
	defb	1fh, 00h, 0f8h, 00h, 3fh, 1fh, 0fch, 0f8h
	defb	7fh, 3fh, 0feh, 0fch, 0ffh, 6bh, 0ffh, 46h
	defb	0ffh, 4bh, 0ffh, 5ah, 0ffh, 6bh, 0ffh, 5ah
	defb	0ffh, 6bh, 0ffh, 46h, 0ffh, 6bh, 0ffh, 5eh
	defb	0ffh, 44h, 0ffh, 0deh, 7fh, 3fh, 0feh, 0fch
	defb	3fh, 1fh, 0fch, 0f8h, 1fh, 00h, 0f8h, 00h
	defb	00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h
	defb	10h, 00h, 10h, 00h, 38h, 10h, 38h, 10h
	defb	38h, 10h, 38h, 10h, 79h, 30h, 3ch, 18h
	defb	7bh, 31h, 0bch, 18h, 0ffh, 72h, 0feh, 9ch
	defb	0ffh, 75h, 0feh, 5ch, 0ffh, 77h, 0feh, 0dch
	defb	0ffh, 77h, 0feh, 0dch, 0ffh, 77h, 0feh, 0dch
	defb	0ffh, 77h, 0feh, 0dch, 0ffh, 73h, 0feh, 9ch
	defb	7bh, 30h, 0bch, 18h, 38h, 10h, 38h, 10h
	defb	10h, 00h, 10h, 00h, 00h, 00h, 00h, 00h
	defb	01h, 00h, 00h, 00h, 03h, 01h, 80h, 00h
	defb	07h, 03h, 0c0h, 80h, 07h, 03h, 0c0h, 80h
	defb	0fh, 04h, 0e0h, 40h, 4fh, 07h, 0e4h, 0c0h
	defb	0efh, 47h, 0eeh, 0c4h, 0ffh, 68h, 0feh, 2ch
	defb	0ffh, 7fh, 0feh, 0fch, 7fh, 3fh, 0fch, 0f8h
	defb	3fh, 1bh, 0f8h, 0b0h, 1fh, 0ch, 0f0h, 60h
	defb	0fh, 07h, 0e0h, 0c0h, 07h, 03h, 0c0h, 80h
	defb	03h, 00h, 80h, 00h, 00h, 00h, 00h, 00h
	defb	00h, 00h, 00h, 00h, 03h, 00h, 80h, 00h
	defb	07h, 03h, 0c0h, 80h, 0fh, 04h, 0e0h, 40h
	defb	0fh, 03h, 0e0h, 80h, 3fh, 07h, 0f8h, 0c0h
	defb	7fh, 37h, 0fch, 0d8h, 7fh, 37h, 0fch, 0d8h
	defb	0ffh, 77h, 0feh, 0dch, 0ffh, 66h, 0feh, 0cch
	defb	6fh, 04h, 0ech, 40h, 05h, 00h, 40h, 00h
	defb	01h, 00h, 00h, 00h, 01h, 00h, 00h, 00h
	defb	01h, 00h, 00h, 00h, 00h, 00h, 00h, 00h
	defb	00h, 00h, 00h, 00h, 00h, 00h, 0f0h, 00h
	defb	3fh, 00h, 0f8h, 0f0h, 7fh, 3dh, 0fch, 18h
	defb	0ffh, 7dh, 0fch, 0c8h, 7fh, 0bh, 0fch, 0e8h
	defb	0fh, 07h, 0fch, 0e8h, 1fh, 0fh, 0f8h, 0f0h
	defb	1fh, 01h, 0f8h, 0c0h, 07h, 01h, 0f8h, 0b0h
	defb	0bh, 01h, 0f8h, 70h, 13h, 00h, 78h, 30h
	defb	00h, 00h, 78h, 30h, 00h, 00h, 70h, 20h
	defb	00h, 00h, 20h, 00h, 00h, 00h, 00h, 00h
	defb	03h, 00h, 00h, 00h, 07h, 03h, 0c0h, 00h
	defb	07h, 03h, 0e0h, 0c0h, 03h, 01h, 0e0h, 0c0h
	defb	07h, 00h, 0f8h, 00h, 0fh, 07h, 0fch, 0e8h
	defb	07h, 03h, 0feh, 0f4h, 7fh, 01h, 0feh, 0f4h
	defb	07h, 03h, 0feh, 0f4h, 0fh, 07h, 0fch, 0e8h
	defb	07h, 00h, 0f8h, 00h, 03h, 01h, 0e0h, 0c0h
	defb	07h, 03h, 0e0h, 0c0h, 07h, 03h, 0c0h, 00h
	defb	03h, 00h, 00h, 00h, 00h, 00h, 00h, 00h
	defb	00h, 00h, 20h, 00h, 00h, 00h, 70h, 20h
	defb	00h, 00h, 78h, 30h, 13h, 00h, 78h, 30h
	defb	0bh, 01h, 0f8h, 70h, 07h, 01h, 0f8h, 0b0h
	defb	1fh, 01h, 0f8h, 0c0h, 1fh, 0fh, 0f8h, 0f0h
	defb	0fh, 07h, 0fch, 0e8h, 7fh, 0bh, 0fch, 0e8h
	defb	0ffh, 7dh, 0fch, 0c8h, 7fh, 3dh, 0fch, 18h
	defb	3fh, 00h, 0f8h, 0f0h, 00h, 00h, 0f0h, 00h
	defb	00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h
	defb	01h, 00h, 00h, 00h, 01h, 00h, 00h, 00h
	defb	01h, 00h, 00h, 00h, 05h, 00h, 40h, 00h
	defb	6fh, 04h, 0ech, 40h, 0ffh, 66h, 0feh, 0cch
	defb	0ffh, 77h, 0feh, 0dch, 7fh, 37h, 0fch, 0d8h
	defb	7fh, 37h, 0fch, 0d8h, 3fh, 07h, 0f8h, 0c0h
	defb	0fh, 03h, 0e0h, 80h, 0fh, 04h, 0e0h, 40h
	defb	07h, 03h, 0c0h, 80h, 03h, 00h, 80h, 00h
	defb	00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h
	defb	08h, 00h, 00h, 00h, 1ch, 08h, 00h, 00h
	defb	3ch, 18h, 00h, 00h, 3dh, 18h, 90h, 00h
	defb	3fh, 1dh, 0a0h, 00h, 3fh, 1bh, 0c0h, 00h
	defb	3fh, 07h, 0f0h, 00h, 3fh, 1fh, 0f0h, 0e0h
	defb	7fh, 2fh, 0e0h, 0c0h, 7fh, 2fh, 0fch, 0a0h
	defb	7fh, 27h, 0feh, 7ch, 7fh, 31h, 0fch, 78h
	defb	3fh, 1eh, 0f8h, 00h, 1eh, 00h, 00h, 00h
	defb	00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h
	defb	01h, 00h, 80h, 00h, 07h, 01h, 0c0h, 80h
	defb	0fh, 07h, 0c0h, 80h, 0fh, 07h, 80h, 00h
	defb	3fh, 00h, 0c0h, 00h, 7fh, 2fh, 0e0h, 0c0h
	defb	0ffh, 5fh, 0c0h, 80h, 0ffh, 5fh, 0fch, 00h
	defb	0ffh, 5fh, 0c0h, 80h, 7fh, 2fh, 0e0h, 0c0h
	defb	3fh, 00h, 0c0h, 00h, 0fh, 07h, 80h, 00h
	defb	0fh, 07h, 0c0h, 80h, 07h, 01h, 0c0h, 80h
	defb	01h, 00h, 80h, 00h, 00h, 00h, 00h, 00h
	defb	00h, 00h, 00h, 00h, 1eh, 00h, 00h, 00h
	defb	3fh, 1eh, 0f8h, 00h, 7fh, 31h, 0fch, 78h
	defb	7fh, 27h, 0feh, 7ch, 7fh, 2fh, 0fch, 0a0h
	defb	7fh, 2fh, 0e0h, 0c0h, 3fh, 1fh, 0f0h, 0e0h
	defb	3fh, 07h, 0f0h, 00h, 3fh, 1bh, 0c0h, 00h
	defb	3fh, 1dh, 0a0h, 00h, 3dh, 18h, 90h, 00h
	defb	3ch, 18h, 00h, 00h, 1ch, 08h, 00h, 00h
	defb	08h, 00h, 00h, 00h, 00h, 00h, 00h, 00h
	defb	40h, 00h, 04h, 00h, 0e3h, 40h, 8eh, 04h
	defb	0f7h, 63h, 0deh, 8ch, 0ffh, 77h, 0feh, 0dch
	defb	0ffh, 6ch, 0feh, 6ch, 7fh, 2bh, 0fch, 0a8h
	defb	3fh, 0fh, 0f8h, 0e0h, 1fh, 0fh, 0f0h, 0e0h
	defb	3fh, 0fh, 0f8h, 0e0h, 7fh, 2bh, 0fch, 0a8h
	defb	0ffh, 6ch, 0feh, 6ch, 0ffh, 77h, 0feh, 0dch
	defb	0f7h, 63h, 0deh, 8ch, 0e3h, 40h, 8eh, 04h
	defb	40h, 00h, 04h, 00h, 00h, 00h, 00h, 00h
	defb	7fh, 00h, 0fch, 00h, 0ffh, 3fh, 0feh, 0f8h
	defb	0ffh, 5fh, 0feh, 0f4h, 0ffh, 60h, 0feh, 08h
	defb	0ffh, 6ch, 0feh, 64h, 0ffh, 6ah, 0feh, 0a8h
	defb	0ffh, 67h, 0feh, 0c4h, 0ffh, 63h, 0feh, 88h
	defb	0ffh, 67h, 0feh, 0c4h, 0ffh, 6ah, 0feh, 0a8h
	defb	0ffh, 6ch, 0feh, 64h, 0ffh, 60h, 0feh, 08h
	defb	0ffh, 55h, 0feh, 54h, 0ffh, 2ah, 0feh, 0a8h
	defb	7fh, 00h, 0fch, 00h, 00h, 00h, 00h, 00h
	defb	70h, 00h, 1ch, 00h, 0ffh, 70h, 0feh, 1ch
	defb	0ffh, 6fh, 0feh, 0ech, 0ffh, 5fh, 0feh, 0f4h
	defb	7fh, 3ch, 0fch, 78h, 7fh, 3ah, 0fch, 0b0h
	defb	7fh, 37h, 0fch, 0d8h, 7fh, 33h, 0fch, 90h
	defb	7fh, 37h, 0fch, 0d8h, 7fh, 3ah, 0fch, 0b0h
	defb	7fh, 3ch, 0fch, 68h, 0ffh, 5fh, 0feh, 0d4h
	defb	0ffh, 6ah, 0feh, 0ach, 0ffh, 70h, 0feh, 1ch
	defb	70h, 00h, 1ch, 00h, 00h, 00h, 00h, 00h
