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
	defb	80h, 0a0h, 0c0h, 0e6h, 0f0h, 0b8h, 0fch, 0fbh
	defb	01h, 63h, 03h, 03h, 6fh, 1fh, 3fh, 0fbh
	defb	0d5h, 0a2h, 0d4h, 0eah, 0f5h, 0bah, 0fch, 0fdh
	defb	0ffh, 3fh, 1fh, 0bh, 07h, 63h, 03h, 07h
	defb	55h, 0a2h, 54h, 8ah, 55h, 0a2h, 54h, 8ah
	defb	0ffh, 0beh, 0fch, 0fah, 0f5h, 0a2h, 0d4h, 8ah
	defb	0ffh, 0beh, 0f8h, 0f6h, 0e0h, 0a0h, 0c0h, 86h
	defb	0ffh, 0bfh, 0ffh, 0fbh, 0ffh, 0bfh, 0ffh, 0fbh
	defb	55h, 0a3h, 57h, 8bh, 5fh, 0bfh, 7fh, 0fbh
	defb	0ffh, 0ffh, 5fh, 8bh, 57h, 0a3h, 57h, 8bh
	defb	00h, 60h, 00h, 06h, 00h, 60h, 00h, 06h
	defb	0ffh, 0ffh, 0ffh, 0ffh, 0ffh, 0ffh, 0ffh, 0ffh
	defb	0aah, 55h, 0aah, 55h, 0aah, 55h, 0aah, 55h
;	fort
	defb	0ffh, 0bfh, 0f8h, 0f7h, 0e3h, 90h, 0dbh, 0dbh
	defb	0ffh, 0bfh, 00h, 0efh, 0e0h, 0fh, 00h, 37h
	defb	0f3h, 0adh, 1eh, 0deh, 1eh, 0ach, 01h, 0fdh
	defb	0cfh, 0b5h, 78h, 7bh, 78h, 35h, 80h, 0bfh
	defb	0ffh, 0fdh, 00h, 0f7h, 07h, 0f0h, 00h, 0ech
	defb	0ffh, 0fdh, 0fh, 0efh, 0c7h, 09h, 0dbh, 0dbh
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
	defb	0bdh, 0bdh, 0d9h, 0e0h, 0efh, 0e0h, 99h, 0d8h
	defb	0ceh, 0ceh, 0ceh, 0eh, 40h, 35h, 79h, 78h
	defb	0bch, 7eh, 0ffh, 0ffh, 7eh, 0bch, 99h, 01h
	defb	3dh, 7eh, 0ffh, 0ffh, 7eh, 3dh, 99h, 80h
	defb	73h, 73h, 73h, 70h, 02h, 0ach, 9eh, 1eh
	defb	0bdh, 0bdh, 9bh, 07h, 0f7h, 07h, 99h, 1bh
	defb	0dbh, 0dbh, 90h, 0e3h, 0f7h, 0f8h, 0bfh, 0ffh
	defb	37h, 00h, 0fh, 0e0h, 0efh, 00h, 0bfh, 0ffh
	defb	0fdh, 01h, 0ach, 1eh, 0deh, 1eh, 0adh, 0f3h
	defb	0bfh, 80h, 35h, 78h, 7bh, 78h, 0b5h, 0cfh
	defb	0ech, 00h, 0f0h, 07h, 0f7h, 00h, 0fdh, 0ffh
	defb	0dbh, 0dbh, 09h, 0c7h, 0efh, 1fh, 0fdh, 0ffh
