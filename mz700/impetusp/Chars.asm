cseg

CharPattern: public CharPattern
	; logo
	defb	00h, 50h, 0f1h, 50h, 0f4h, 50h, 0f5h, 50h
	defb	0f2h, 50h, 0f3h, 50h, 0f6h, 50h, 0f7h, 50h
	defb	0f8h, 50h, 0f9h, 50h, 0fch, 50h, 0fdh, 50h
	defb	0fah, 50h, 0fbh, 50h, 0feh, 50h, 0ffh, 50h
	; remain
	defb	41h, 70h
	; terrain
	defb 42h,41h,00h,01h,4eh,41h,4dh,41h
	defb 00h,04h,00h,06h,5ah,70h,5ah,04h
	defb 56h,41h
	; fort
	defb	4bh, 50h, 3ah, 50h, 47h, 20h, 47h, 20h
	defb	3ah, 50h, 4ch, 50h, 3bh, 50h, 5ah, 05h
	defb	1bh, 05h, 1bh, 05h, 5ah, 05h, 7bh, 50h
	defb	47h, 20h, 1bh, 05h, 44h, 15h, 44h, 15h
	defb	1bh, 05h, 47h, 20h, 47h, 20h, 1bh, 05h
	defb	44h, 15h, 44h, 15h, 1bh, 05h, 47h, 20h
	defb	3bh, 50h, 5ah, 05h, 1bh, 05h, 1bh, 05h
	defb	5ah, 05h, 7bh, 50h, 6fh, 50h, 7ah, 50h
	defb	47h, 20h, 47h, 20h, 7ah, 50h, 6eh, 50h

SpritePattern: public SpritePattern
	defb	3dh, 70h, 71h, 70h, 00h, 00h, 00h, 00h
	defb	47h, 20h, 00h, 00h, 00h, 00h, 00h, 00h
	defb	4ah, 52h, 78h, 20h, 00h, 00h, 00h, 00h
	defb	78h, 20h, 78h, 20h, 00h, 00h, 00h, 00h
	defb	78h, 20h, 4ah, 52h, 00h, 00h, 00h, 00h
	defb	0feh, 20h, 0fdh, 20h, 0fbh, 20h, 0f6h, 20h
	defb	0f9h, 20h, 0feh, 20h, 0ffh, 20h, 0f7h, 60h
	defb	0f9h, 20h, 0f6h, 20h, 0fdh, 60h, 0f7h, 20h
	defb	0fbh, 20h, 0ffh, 60h, 0f6h, 20h, 0f9h, 20h
	defb	0f6h, 60h, 0ffh, 20h, 0f7h, 20h, 0f9h, 20h
	defb	21h, 14h, 00h, 14h, 15h, 14h, 10h, 14h
	defb	4eh, 70h, 4dh, 70h, 56h, 70h, 42h, 70h
	defb	3bh, 20h, 7bh, 20h, 42h, 20h, 56h, 20h
	defb	4eh, 30h, 4dh, 30h, 43h, 30h, 43h, 30h
	defb	4eh, 30h, 43h, 30h, 42h, 30h, 56h, 30h
	defb	43h, 30h, 4dh, 30h, 43h, 30h, 56h, 30h
	defb	4eh, 30h, 4dh, 30h, 42h, 30h, 43h, 30h
	defb	43h, 30h, 43h, 30h, 42h, 30h, 56h, 30h
	defb	4eh, 30h, 4dh, 30h, 43h, 30h, 56h, 30h
	defb	4eh, 30h, 43h, 30h, 42h, 30h, 43h, 30h
	defb	43h, 30h, 4dh, 30h, 42h, 30h, 56h, 30h
	defb	5bh, 30h, 6ch, 30h, 6ch, 30h, 5bh, 30h
	defb	4bh, 05h, 4ch, 05h, 6fh, 05h, 6eh, 05h
	defb	4eh, 50h, 4dh, 50h, 42h, 50h, 56h, 50h
