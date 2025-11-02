cseg

MonoPattern: public MonoPattern
; ascii 30
	; " -0123456789ACEFGHIKMNOPRSTUVY"
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

ColorPattern: public ColorPattern
;	terrain
	defb	55h, 0aah, 0aah, 55h, 55h, 0aah, 0aah, 55h
	defb	55h, 0aah, 0aah, 55h, 55h, 0aah, 0aah, 55h
	defb	55h, 55h, 0aah, 0aah, 55h, 55h, 0aah, 0aah
	defb	55h, 55h, 0aah, 0aah, 55h, 55h, 0aah, 0aah
	defb	00h, 01h, 04h, 05h, 00h, 03h, 60h, 67h
	defb	00h, 0fh, 00h, 1dh, 00h, 3fh, 00h, 0dfh
	defb	00h, 80h, 06h, 0c6h, 00h, 0c0h, 00h, 0c0h
	defb	06h, 0f6h, 00h, 0f8h, 00h, 0fch, 00h, 0dfh
	defb	00h, 0ffh, 00h, 0fch, 00h, 0f8h, 00h, 0d0h
	defb	00h, 0e0h, 06h, 0c6h, 00h, 0c0h, 60h, 0e0h
	defb	00h, 0ffh, 00h, 7dh, 00h, 1fh, 60h, 6fh
	defb	00h, 07h, 04h, 05h, 00h, 03h, 60h, 61h
	defb	00h, 0abh, 00h, 45h, 00h, 2bh, 00h, 57h
	defb	00h, 0afh, 00h, 5dh, 00h, 3fh, 00h, 0bfh
	defb	00h, 0aah, 00h, 45h, 00h, 2ah, 00h, 51h
	defb	00h, 0aah, 00h, 45h, 00h, 2ah, 00h, 51h
	defb	00h, 0ffh, 00h, 7dh, 00h, 3fh, 00h, 5fh
	defb	00h, 0afh, 00h, 45h, 00h, 2bh, 00h, 51h
	defb	00h, 00h, 06h, 06h, 00h, 00h, 60h, 60h
	defb	00h, 00h, 06h, 06h, 00h, 00h, 60h, 60h
	defb	00h, 0ffh, 00h, 0fdh, 00h, 0ffh, 00h, 0dfh
	defb	00h, 0ffh, 00h, 0fdh, 00h, 0ffh, 00h, 0dfh
	defb	00h, 0aah, 00h, 0c5h, 00h, 0eah, 00h, 0d1h
	defb	00h, 0fah, 00h, 0fdh, 00h, 0feh, 00h, 0dfh
	defb	00h, 0ffh, 00h, 0ffh, 00h, 0fah, 00h, 0d1h
	defb	00h, 0eah, 00h, 0c5h, 00h, 0eah, 00h, 0d1h
;	fort
	defb	00h, 0ffh, 00h, 0fdh, 00h, 0ffh, 0e0h, 0ffh
	defb	0c0h, 0cfh, 08h, 0dh, 0d8h, 1fh, 0d8h, 1fh
	defb	00h, 0ffh, 00h, 0fdh, 00h, 0ffh, 0f7h, 0f7h
	defb	07h, 07h, 00h, 0f0h, 00h, 00h, 0ech, 0ch
	defb	30h, 0cfh, 78h, 85h, 0fch, 03h, 0fdh, 01h
	defb	78h, 00h, 30h, 05h, 80h, 80h, 0bfh, 80h
	defb	0ch, 0f3h, 1eh, 0a1h, 3fh, 0c0h, 0bfh, 80h
	defb	1eh, 00h, 0ch, 0a0h, 01h, 01h, 0fdh, 01h
	defb	00h, 0ffh, 00h, 0bfh, 00h, 0ffh, 0efh, 0efh
	defb	0e0h, 0e0h, 00h, 0fh, 00h, 00h, 37h, 30h
	defb	00h, 0ffh, 00h, 0bfh, 00h, 0ffh, 07h, 0ffh
	defb	03h, 0f3h, 10h, 0b0h, 1bh, 0f8h, 1bh, 0f8h
	defb	18h, 1fh, 18h, 9dh, 00h, 07h, 0f0h, 0f7h
	defb	00h, 07h, 98h, 05h, 0bch, 03h, 0bch, 03h
	defb	1eh, 1eh, 1eh, 9eh, 0ch, 0ach, 00h, 02h
	defb	70h, 70h, 73h, 70h, 73h, 70h, 73h, 70h
	defb	80h, 80h, 80h, 99h, 00h, 3dh, 00h, 7eh
	defb	00h, 0ffh, 00h, 0ffh, 00h, 7eh, 00h, 3dh
	defb	01h, 01h, 01h, 99h, 00h, 0bch, 00h, 7eh
	defb	00h, 0ffh, 00h, 0ffh, 00h, 7eh, 00h, 0bch
	defb	78h, 78h, 78h, 79h, 30h, 35h, 00h, 40h
	defb	0eh, 0eh, 0ceh, 0eh, 0ceh, 0eh, 0ceh, 0eh
	defb	18h, 0f8h, 18h, 0b9h, 00h, 0e0h, 0fh, 0efh
	defb	00h, 0e0h, 19h, 0a0h, 3dh, 0c0h, 3dh, 0c0h
	defb	18h, 07h, 80h, 05h, 0bfh, 3fh, 0bfh, 3fh
	defb	00h, 00h, 0dh, 0adh, 0dh, 0adh, 0dh, 0adh
	defb	00h, 00h, 03h, 08h, 0c3h, 00h, 0c3h, 00h
	defb	00h, 00h, 0eh, 0eeh, 0eh, 0eeh, 0eh, 0eeh
	defb	80h, 98h, 00h, 00h, 7fh, 00h, 7fh, 00h
	defb	00h, 00h, 80h, 0bdh, 80h, 0bdh, 80h, 0bdh
	defb	01h, 19h, 00h, 00h, 0feh, 00h, 0feh, 00h
	defb	00h, 00h, 01h, 0bdh, 01h, 0bdh, 01h, 0bdh
	defb	00h, 00h, 0c0h, 10h, 0c3h, 00h, 0c3h, 00h
	defb	00h, 00h, 70h, 77h, 70h, 77h, 70h, 77h
	defb	18h, 0e0h, 01h, 0a0h, 0fdh, 0fch, 0fdh, 0fch
	defb	00h, 00h, 0b0h, 0b5h, 0b0h, 0b5h, 0b0h, 0b5h
	defb	0dh, 0adh, 0dh, 0adh, 0dh, 0adh, 00h, 00h
	defb	0bfh, 3fh, 0bfh, 3fh, 80h, 05h, 18h, 07h
	defb	0eh, 0eeh, 0eh, 0eeh, 0eh, 0eeh, 00h, 00h
	defb	0c3h, 00h, 0c3h, 00h, 03h, 08h, 00h, 00h
	defb	80h, 0bdh, 80h, 0bdh, 80h, 0bdh, 00h, 00h
	defb	7fh, 00h, 7fh, 00h, 00h, 00h, 80h, 98h
	defb	01h, 0bdh, 01h, 0bdh, 01h, 0bdh, 00h, 00h
	defb	0feh, 00h, 0feh, 00h, 00h, 00h, 01h, 19h
	defb	70h, 77h, 70h, 77h, 70h, 77h, 00h, 00h
	defb	0c3h, 00h, 0c3h, 00h, 0c0h, 10h, 00h, 00h
	defb	0b0h, 0b5h, 0b0h, 0b5h, 0b0h, 0b5h, 00h, 00h
	defb	0fdh, 0fch, 0fdh, 0fch, 01h, 0a0h, 18h, 0e0h
	defb	0bch, 03h, 0bch, 03h, 98h, 05h, 00h, 07h
	defb	0f0h, 0f7h, 00h, 07h, 18h, 9dh, 18h, 1fh
	defb	73h, 70h, 73h, 70h, 73h, 70h, 70h, 70h
	defb	00h, 02h, 0ch, 0ach, 1eh, 9eh, 1eh, 1eh
	defb	00h, 3dh, 00h, 7eh, 00h, 0ffh, 00h, 0ffh
	defb	00h, 7eh, 00h, 3dh, 80h, 99h, 80h, 80h
	defb	00h, 0bch, 00h, 7eh, 00h, 0ffh, 00h, 0ffh
	defb	00h, 7eh, 00h, 0bch, 01h, 99h, 01h, 01h
	defb	0ceh, 0eh, 0ceh, 0eh, 0ceh, 0eh, 0eh, 0eh
	defb	00h, 40h, 30h, 35h, 78h, 79h, 78h, 78h
	defb	3dh, 0c0h, 3dh, 0c0h, 19h, 0a0h, 00h, 0e0h
	defb	0fh, 0efh, 00h, 0e0h, 18h, 0b9h, 18h, 0f8h
	defb	0d8h, 1fh, 0d8h, 1fh, 08h, 0dh, 0c0h, 0cfh
	defb	0e0h, 0ffh, 00h, 0ffh, 00h, 0fdh, 00h, 0ffh
	defb	0ech, 0ch, 00h, 00h, 00h, 0f0h, 07h, 07h
	defb	0f7h, 0f7h, 00h, 0ffh, 00h, 0fdh, 00h, 0ffh
	defb	0bfh, 80h, 80h, 80h, 30h, 05h, 78h, 00h
	defb	0fdh, 01h, 0fch, 03h, 78h, 85h, 30h, 0cfh
	defb	0fdh, 01h, 01h, 01h, 0ch, 0a0h, 1eh, 00h
	defb	0bfh, 80h, 3fh, 0c0h, 1eh, 0a1h, 0ch, 0f3h
	defb	37h, 30h, 00h, 00h, 00h, 0fh, 0e0h, 0e0h
	defb	0efh, 0efh, 00h, 0ffh, 00h, 0bfh, 00h, 0ffh
	defb	1bh, 0f8h, 1bh, 0f8h, 10h, 0b0h, 03h, 0f3h
	defb	07h, 0ffh, 00h, 0ffh, 00h, 0bfh, 00h, 0ffh
