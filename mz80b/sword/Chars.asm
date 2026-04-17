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
;	fence
	defb	00h, 00h, 00h, 00h, 00h, 00h, 00h, 0ffh
	defb	0ffh, 00h, 00h, 00h, 00h, 00h, 00h, 00h
;	16dot
	defb	0cfh, 0c7h, 0bbh, 7ch, 7ch, 0bdh, 0dbh, 0e3h
	defb	0e7h, 0e7h, 0dbh, 3ch, 3ch, 0bbh, 97h, 0c7h
	defb	0e3h, 0dbh, 0bdh, 3ch, 3ch, 0bbh, 0c7h, 0cfh
	defb	0c7h, 0c7h, 0bbh, 3ch, 3ch, 0bbh, 0c7h, 0e7h
	defb	00h, 00h, 0c0h, 0e0h, 0f8h, 0f4h, 0eeh, 0dch
	defb	0ch, 1fh, 3fh, 7fh, 7fh, 0bfh, 0efh, 3bh
	defb	0dah, 0b6h, 0aeh, 1eh, 0bch, 0b8h, 0b0h, 0a0h
	defb	0ceh, 0e3h, 0e4h, 0f7h, 7fh, 1fh, 07h, 01h
	defb	0feh, 03h, 01h, 01h, 01h, 01h, 81h, 0c1h
	defb	7fh, 0c0h, 80h, 9ch, 9eh, 9fh, 8fh, 87h
	defb	0e9h, 0d1h, 0b1h, 79h, 9dh, 09h, 03h, 0feh
	defb	83h, 81h, 80h, 80h, 80h, 80h, 0c0h, 7fh
	defb	00h, 0c0h, 0e0h, 00h, 0a0h, 0a0h, 0e0h, 00h
	defb	00h, 03h, 07h, 06h, 07h, 07h, 07h, 00h
	defb	0b0h, 78h, 78h, 78h, 30h, 40h, 38h, 00h
	defb	01h, 01h, 00h, 03h, 06h, 0ch, 0eh, 00h
