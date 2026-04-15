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
	defb	00h, 00h, 00h, 00h, 00h, 00h, 00h, 03h
	defb	00h, 00h, 07h, 00h, 00h, 1fh, 00h, 00h
	defb	3fh, 10h, 00h, 7fh, 08h, 00h, 7fh, 44h
	defb	00h, 30h, 00h, 00h, 0f8h, 00h, 00h, 0fch
	defb	00h, 00h, 0feh, 00h, 00h, 0feh, 00h, 00h
	defb	0fdh, 00h, 00h, 0f7h, 00h, 00h, 0dfh, 03h
	defb	00h, 7fh, 24h, 00h, 7fh, 12h, 00h, 7fh
	defb	0ah, 00h, 7fh, 07h, 00h, 3fh, 02h, 00h
	defb	1fh, 02h, 00h, 0fh, 02h, 00h, 07h, 02h
	defb	00h, 7fh, 0ch, 00h, 0ffh, 38h, 00h, 0ffh
	defb	0d8h, 00h, 0ffh, 10h, 00h, 0feh, 00h, 00h
	defb	0f8h, 00h, 00h, 0e0h, 00h, 00h, 80h, 00h
	defb	00h, 7fh, 7fh, 00h, 0c0h, 0c0h, 00h, 80h
	defb	80h, 00h, 80h, 80h, 00h, 80h, 80h, 00h
	defb	80h, 80h, 01h, 81h, 81h, 03h, 83h, 83h
	defb	00h, 0feh, 0feh, 00h, 03h, 03h, 00h, 01h
	defb	01h, 38h, 39h, 39h, 78h, 79h, 79h, 0f8h
	defb	0f9h, 0f9h, 0f0h, 0f1h, 0f1h, 0e0h, 0e1h, 0e1h
	defb	17h, 87h, 97h, 0bh, 83h, 8bh, 0dh, 81h
	defb	8dh, 1eh, 80h, 9eh, 39h, 80h, 0b9h, 10h
	defb	80h, 90h, 00h, 0c0h, 0c0h, 00h, 7fh, 7fh
	defb	0c0h, 0c1h, 0c1h, 80h, 81h, 81h, 00h, 01h
	defb	01h, 00h, 01h, 01h, 00h, 01h, 01h, 00h
	defb	01h, 01h, 00h, 03h, 03h, 00h, 0feh, 0feh
