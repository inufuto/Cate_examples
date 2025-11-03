cseg

CharPattern: public CharPattern
; ascii 31
	; " -0123456789ABCEFGHIKMNOPRSTUVY"
	defb 00h,00h,00h,00h,00h,00h,00h,00h
	defb 00h,00h,00h,7eh,00h,00h,00h,00h
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
	defb 7eh,0c6h,0c6h,7eh,0c6h,0c6h,7eh,00h
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
;	remain
	defb	44h, 44h, 0d6h, 0eeh, 0d6h, 0feh, 0feh, 54h
;	terrain
	defb	0ffh, 0ffh, 0ffh, 0ffh, 0ffh, 0ffh, 0ffh, 0ffh
	defb	80h, 0c6h, 0c0h, 0c0h, 0f6h, 0f8h, 0fch, 0dfh
	defb	0ffh, 0fch, 0f8h, 0d0h, 0e0h, 0c6h, 0c0h, 0e0h
	defb	0ffh, 7dh, 1fh, 6fh, 07h, 05h, 03h, 61h
	defb	00h, 06h, 00h, 60h, 00h, 06h, 00h, 60h
	defb	0abh, 45h, 2bh, 57h, 0afh, 5dh, 3fh, 0bfh
	defb	0ffh, 7dh, 3fh, 5fh, 0afh, 45h, 2bh, 51h
	defb	0aah, 0c5h, 0eah, 0d1h, 0fah, 0fdh, 0feh, 0dfh
	defb	0ffh, 0ffh, 0fah, 0d1h, 0eah, 0c5h, 0eah, 0d1h
	defb	00h, 7fh, 7fh, 7fh, 7fh, 7fh, 7fh, 7fh
	defb	00h, 0feh, 0feh, 0feh, 0feh, 0feh, 0feh, 0feh
	defb	7fh, 7fh, 7fh, 7fh, 7fh, 7fh, 7fh, 00h
	defb	0feh, 0feh, 0feh, 0feh, 0feh, 0feh, 0feh, 00h
	defb	0feh, 0feh, 0feh, 0feh, 0feh, 0feh, 0feh, 0feh
	defb	7fh, 7fh, 7fh, 7fh, 7fh, 7fh, 7fh, 7fh
	defb	00h, 0ffh, 0ffh, 0ffh, 0ffh, 0ffh, 0ffh, 0ffh
	defb	0ffh, 0ffh, 0ffh, 0ffh, 0ffh, 0ffh, 0ffh, 00h
	defb	0aah, 45h, 2ah, 51h, 0aah, 45h, 2ah, 51h
	defb	0ffh, 0fdh, 0ffh, 0dfh, 0ffh, 0fdh, 0ffh, 0dfh
	defb	01h, 05h, 03h, 67h, 0fh, 1dh, 3fh, 0dfh
;	fort
	defb	0ffh, 0fdh, 1fh, 0efh, 0c7h, 09h, 0dbh, 0dbh
	defb	0ffh, 0fdh, 00h, 0f7h, 07h, 0f0h, 00h, 0ech
	defb	0cfh, 0b5h, 78h, 7bh, 78h, 35h, 80h, 0bfh
	defb	0f3h, 0adh, 1eh, 0deh, 1eh, 0ach, 01h, 0fdh
	defb	0ffh, 0bfh, 00h, 0efh, 0e0h, 0fh, 00h, 37h
	defb	0ffh, 0bfh, 0f0h, 0f7h, 0e3h, 90h, 0dbh, 0dbh
	defb	1bh, 99h, 07h, 0f7h, 07h, 9bh, 0bdh, 0bdh
	defb	1eh, 9eh, 0ach, 02h, 70h, 73h, 73h, 73h
	defb	80h, 99h, 3dh, 7eh, 0ffh, 0ffh, 7eh, 3dh
	defb	01h, 99h, 0bch, 7eh, 0ffh, 0ffh, 7eh, 0bch
	defb	78h, 79h, 35h, 40h, 0eh, 0ceh, 0ceh, 0ceh
	defb	0d8h, 99h, 0e0h, 0efh, 0e0h, 0d9h, 0bdh, 0bdh
	defb	1bh, 81h, 0beh, 0beh, 00h, 0b6h, 0b6h, 0b6h
	defb	00h, 0bh, 0c3h, 0c3h, 00h, 0eeh, 0eeh, 0eeh
	defb	98h, 00h, 7fh, 7fh, 00h, 0bdh, 0bdh, 0bdh
	defb	19h, 00h, 0feh, 0feh, 00h, 0bdh, 0bdh, 0bdh
	defb	00h, 0d0h, 0c3h, 0c3h, 00h, 77h, 77h, 77h
	defb	0d8h, 81h, 7dh, 7dh, 00h, 6dh, 6dh, 6dh
	defb	0b6h, 0b6h, 0b6h, 00h, 0beh, 0beh, 81h, 1bh
	defb	0eeh, 0eeh, 0eeh, 00h, 0c3h, 0c3h, 0bh, 00h
	defb	0bdh, 0bdh, 0bdh, 00h, 7fh, 7fh, 00h, 98h
	defb	0bdh, 0bdh, 0bdh, 00h, 0feh, 0feh, 00h, 19h
	defb	77h, 77h, 77h, 00h, 0c3h, 0c3h, 0d0h, 00h
	defb	6dh, 6dh, 6dh, 00h, 7dh, 7dh, 81h, 0d8h
	defb	0bdh, 0bdh, 9bh, 07h, 0f7h, 07h, 99h, 1bh
	defb	73h, 73h, 73h, 70h, 02h, 0ach, 9eh, 1eh
	defb	3dh, 7eh, 0ffh, 0ffh, 7eh, 3dh, 99h, 80h
	defb	0bch, 7eh, 0ffh, 0ffh, 7eh, 0bch, 99h, 01h
	defb	0ceh, 0ceh, 0ceh, 0eh, 40h, 35h, 79h, 78h
	defb	0bdh, 0bdh, 0d9h, 0e0h, 0efh, 0e0h, 99h, 0d8h
	defb	0dbh, 0dbh, 09h, 0c7h, 0efh, 1fh, 0fdh, 0ffh
	defb	0ech, 00h, 0f0h, 07h, 0f7h, 00h, 0fdh, 0ffh
	defb	0bfh, 80h, 35h, 78h, 7bh, 78h, 0b5h, 0cfh
	defb	0fdh, 01h, 0ach, 1eh, 0deh, 1eh, 0adh, 0f3h
	defb	37h, 00h, 0fh, 0e0h, 0efh, 00h, 0bfh, 0ffh
	defb	0dbh, 0dbh, 90h, 0e3h, 0f7h, 0f8h, 0bfh, 0ffh
