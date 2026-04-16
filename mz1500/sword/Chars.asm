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
	defb	00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h
	defb	00h, 00h, 03h, 07h, 1fh, 3fh, 7fh, 7fh
	defb	00h, 00h, 00h, 00h, 00h, 10h, 08h, 44h
	defb	00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h
	defb	30h, 0f8h, 0fch, 0feh, 0feh, 0fdh, 0f7h, 0dfh
	defb	00h, 00h, 00h, 00h, 00h, 00h, 00h, 03h
	defb	00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h
	defb	7fh, 7fh, 7fh, 7fh, 3fh, 1fh, 0fh, 07h
	defb	24h, 12h, 0ah, 07h, 02h, 02h, 02h, 02h
	defb	00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h
	defb	7fh, 0ffh, 0ffh, 0ffh, 0feh, 0f8h, 0e0h, 80h
	defb	0ch, 38h, 0d8h, 10h, 00h, 00h, 00h, 00h
	defb	00h, 00h, 00h, 00h, 00h, 00h, 01h, 03h
	defb	7fh, 0c0h, 80h, 80h, 80h, 80h, 81h, 83h
	defb	7fh, 0c0h, 80h, 80h, 80h, 80h, 81h, 83h
	defb	00h, 00h, 00h, 38h, 78h, 0f8h, 0f0h, 0e0h
	defb	0feh, 03h, 01h, 39h, 79h, 0f9h, 0f1h, 0e1h
	defb	0feh, 03h, 01h, 39h, 79h, 0f9h, 0f1h, 0e1h
	defb	17h, 0bh, 0dh, 1eh, 39h, 10h, 00h, 00h
	defb	87h, 83h, 81h, 80h, 80h, 80h, 0c0h, 7fh
	defb	97h, 8bh, 8dh, 9eh, 0b9h, 90h, 0c0h, 7fh
	defb	0c0h, 80h, 00h, 00h, 00h, 00h, 00h, 00h
	defb	0c1h, 81h, 01h, 01h, 01h, 01h, 03h, 0feh
	defb	0c1h, 81h, 01h, 01h, 01h, 01h, 03h, 0feh
	defb	00h, 03h, 07h, 00h, 05h, 05h, 07h, 00h
	defb	00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h
	defb	00h, 03h, 07h, 00h, 05h, 05h, 07h, 00h
	defb	00h, 0c0h, 0e0h, 60h, 0e0h, 0e0h, 0e0h, 00h
	defb	00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h
	defb	00h, 0c0h, 0e0h, 60h, 0e0h, 0e0h, 0e0h, 00h
	defb	0dh, 12h, 12h, 12h, 0ch, 02h, 1ch, 00h
	defb	00h, 0ch, 0ch, 0ch, 00h, 00h, 00h, 00h
	defb	0dh, 12h, 12h, 12h, 0ch, 02h, 1ch, 00h
	defb	80h, 80h, 00h, 0c0h, 60h, 30h, 70h, 00h
	defb	00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h
	defb	80h, 80h, 00h, 0c0h, 60h, 30h, 70h, 00h
