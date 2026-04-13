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
	defb	00h, 00h, 00h, 00h, 00h, 05h, 00h, 15h
	defb	01h, 55h, 07h, 55h, 15h, 0d5h, 35h, 75h
	defb	05h, 00h, 55h, 40h, 55h, 50h, 55h, 54h
	defb	55h, 54h, 55h, 51h, 55h, 15h, 51h, 5fh
	defb	1dh, 75h, 17h, 5dh, 15h, 0ddh, 15h, 7fh
	defb	05h, 5dh, 01h, 5dh, 00h, 5dh, 00h, 1dh
	defb	15h, 0f5h, 5fh, 0d5h, 0f7h, 0d5h, 57h, 55h
	defb	55h, 54h, 55h, 40h, 54h, 00h, 40h, 00h
	defb	26h, 66h, 90h, 00h, 40h, 00h, 80h, 00h
	defb	40h, 00h, 80h, 00h, 40h, 03h, 80h, 0fh
	defb	66h, 64h, 00h, 09h, 00h, 02h, 0fh, 0c1h
	defb	3fh, 0c2h, 0ffh, 0c1h, 0ffh, 02h, 0fch, 01h
	defb	43h, 3fh, 80h, 0cfh, 40h, 0b3h, 82h, 0ach
	defb	4ah, 83h, 82h, 00h, 60h, 00h, 19h, 99h
	defb	0f0h, 02h, 0c0h, 01h, 00h, 02h, 00h, 01h
	defb	00h, 02h, 00h, 01h, 00h, 06h, 99h, 98h
	defb	00h, 00h, 00h, 0ah, 00h, 2ah, 00h, 00h
	defb	00h, 22h, 00h, 22h, 00h, 2ah, 00h, 00h
	defb	00h, 00h, 0a0h, 00h, 0a8h, 00h, 28h, 00h
	defb	0a8h, 00h, 0a8h, 00h, 0a8h, 00h, 00h, 00h
	defb	00h, 0a2h, 02h, 58h, 02h, 58h, 02h, 58h
	defb	00h, 0a0h, 00h, 08h, 02h, 0a0h, 00h, 00h
	defb	80h, 00h, 80h, 00h, 00h, 00h, 0a0h, 00h
	defb	28h, 00h, 0ah, 00h, 2ah, 00h, 00h, 00h
