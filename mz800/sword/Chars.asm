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
;	fence
	defb	00h, 00h, 00h, 00h, 00h, 00h, 00h, 0ffh
	defb	0ffh, 00h, 00h, 00h, 00h, 00h, 00h, 00h
;	mono16
	defb	0f3h, 0e3h, 0ddh, 3eh, 3eh, 0bdh, 0dbh, 0c7h
	defb	0e7h, 0e7h, 0dbh, 3ch, 3ch, 0ddh, 0e9h, 0e3h
	defb	0c7h, 0dbh, 0bdh, 3ch, 3ch, 0ddh, 0e3h, 0f3h
	defb	0e3h, 0e3h, 0ddh, 3ch, 3ch, 0ddh, 0e3h, 0e7h

ColorPattern: public ColorPattern
;	color16
	defb	00h, 00h, 00h, 00h, 0c0h, 00h, 0e0h, 00h
	defb	0f8h, 00h, 0fch, 08h, 0feh, 10h, 0feh, 22h
	defb	0ch, 00h, 1fh, 00h, 3fh, 00h, 7fh, 00h
	defb	7fh, 00h, 0bfh, 00h, 0efh, 00h, 0fbh, 0c0h
	defb	0feh, 24h, 0feh, 48h, 0feh, 50h, 0feh, 0e0h
	defb	0fch, 40h, 0f8h, 40h, 0f0h, 40h, 0e0h, 40h
	defb	0feh, 30h, 0ffh, 1ch, 0ffh, 1bh, 0ffh, 08h
	defb	7fh, 00h, 1fh, 00h, 07h, 00h, 01h, 00h
	defb	54h, 0aah, 02h, 01h, 01h, 00h, 00h, 01h
	defb	01h, 00h, 00h, 01h, 81h, 80h, 0c0h, 0c1h
	defb	55h, 2ah, 80h, 40h, 00h, 80h, 9ch, 1ch
	defb	1eh, 9eh, 9fh, 1fh, 0fh, 8fh, 87h, 07h
	defb	0e9h, 0e8h, 0d0h, 0d1h, 0a1h, 0b0h, 40h, 79h
	defb	81h, 9ch, 00h, 09h, 01h, 02h, 0aah, 54h
	defb	03h, 83h, 81h, 01h, 00h, 80h, 80h, 00h
	defb	00h, 80h, 80h, 00h, 40h, 80h, 2ah, 55h
	defb	00h, 00h, 00h, 0c0h, 00h, 0e0h, 00h, 00h
	defb	00h, 0a0h, 00h, 0a0h, 00h, 0e0h, 00h, 00h
	defb	00h, 00h, 00h, 03h, 00h, 07h, 00h, 06h
	defb	00h, 07h, 00h, 07h, 00h, 07h, 00h, 00h
	defb	00h, 0b0h, 30h, 48h, 30h, 48h, 30h, 48h
	defb	00h, 30h, 00h, 40h, 00h, 38h, 00h, 00h
	defb	00h, 01h, 00h, 01h, 00h, 00h, 00h, 03h
	defb	00h, 06h, 00h, 0ch, 00h, 0eh, 00h, 00h
