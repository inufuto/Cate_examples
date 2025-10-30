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
;	remain
	defb	44h, 44h, 0d6h, 0eeh, 0d6h, 0feh, 0feh, 54h

ColorPattern: public ColorPattern
;	terrain
	defb	66h, 66h, 99h, 99h, 66h, 66h, 99h, 99h
	defb	66h, 66h, 99h, 99h, 66h, 66h, 99h, 99h
	defb	0cch, 0cch, 33h, 33h, 0cch, 0cch, 33h, 33h
	defb	0cch, 0cch, 33h, 33h, 0cch, 0cch, 33h, 33h
	defb	80h, 00h, 8ch, 00h, 0a0h, 00h, 0a8h, 3ch
	defb	0aah, 00h, 8ah, 80h, 0aah, 0a0h, 0aah, 8ah
	defb	00h, 02h, 3ch, 0ah, 00h, 0ah, 00h, 0ah
	defb	3ch, 0aah, 02h, 0aah, 0ah, 0aah, 0aah, 8ah
	defb	0aah, 0aah, 0ah, 0aah, 02h, 0aah, 00h, 8ah
	defb	00h, 2ah, 3ch, 0ah, 00h, 0ah, 00h, 3eh
	defb	0aah, 0aah, 8ah, 0a8h, 0aah, 80h, 0aah, 3ch
	defb	0a8h, 00h, 8ch, 00h, 0a0h, 00h, 80h, 3ch
	defb	0a2h, 22h, 88h, 08h, 0a2h, 20h, 0a8h, 88h
	defb	0aah, 22h, 8ah, 88h, 0aah, 0a0h, 0aah, 0a2h
	defb	22h, 22h, 88h, 08h, 22h, 20h, 80h, 88h
	defb	22h, 22h, 88h, 08h, 22h, 20h, 80h, 88h
	defb	0aah, 0aah, 8ah, 0a8h, 0aah, 0a0h, 0aah, 88h
	defb	0aah, 22h, 88h, 08h, 0a2h, 20h, 80h, 88h
	defb	00h, 00h, 3ch, 00h, 00h, 00h, 00h, 3ch
	defb	00h, 00h, 3ch, 00h, 00h, 00h, 00h, 3ch
	defb	0aah, 0aah, 8ah, 0aah, 0aah, 0aah, 0aah, 8ah
	defb	0aah, 0aah, 8ah, 0aah, 0aah, 0aah, 0aah, 8ah
	defb	22h, 22h, 88h, 0ah, 22h, 2ah, 80h, 8ah
	defb	22h, 0aah, 8ah, 0aah, 2ah, 0aah, 0aah, 8ah
	defb	0aah, 0aah, 0aah, 0aah, 22h, 0aah, 80h, 8ah
	defb	22h, 2ah, 88h, 0ah, 22h, 2ah, 80h, 8ah
;	fort
	defb	0aah, 0aah, 8ah, 0aah, 0aah, 0aah, 0aah, 0bfh
	defb	0aah, 0fh, 8bh, 00h, 0abh, 0c5h, 0abh, 0c5h
	defb	0aah, 0aah, 8ah, 0aah, 0aah, 0aah, 0fch, 0ffh
	defb	0fch, 00h, 00h, 0aah, 00h, 00h, 0fh, 15h
	defb	0aah, 5ah, 89h, 56h, 0a5h, 55h, 0c5h, 55h
	defb	01h, 54h, 88h, 50h, 00h, 03h, 55h, 53h
	defb	0a5h, 0aah, 95h, 62h, 55h, 5ah, 55h, 53h
	defb	15h, 40h, 05h, 22h, 0c0h, 00h, 0c5h, 55h
	defb	0aah, 0aah, 0aah, 0a2h, 0aah, 0aah, 0ffh, 3fh
	defb	00h, 3fh, 0aah, 00h, 00h, 00h, 54h, 0f0h
	defb	0aah, 0aah, 0aah, 0a2h, 0aah, 0aah, 0feh, 0aah
	defb	0f0h, 0aah, 00h, 0e2h, 53h, 0eah, 53h, 0eah
	defb	0abh, 0c0h, 8bh, 0c2h, 0a8h, 00h, 0a8h, 0ffh
	defb	0a8h, 00h, 89h, 41h, 0a5h, 51h, 0a5h, 51h
	defb	3fh, 0c0h, 3fh, 0c2h, 0fh, 22h, 20h, 00h
	defb	00h, 0fch, 50h, 0fch, 50h, 0fch, 50h, 0fch
	defb	00h, 03h, 82h, 83h, 8ah, 0a0h, 2ah, 0a8h
	defb	0aah, 0aah, 0aah, 0aah, 2ah, 0a8h, 8ah, 0a0h
	defb	0c0h, 00h, 0c2h, 82h, 0ah, 0a2h, 2ah, 0a8h
	defb	0aah, 0aah, 0aah, 0aah, 2ah, 0a8h, 0ah, 0a2h
	defb	03h, 0fch, 83h, 0fch, 88h, 0f0h, 00h, 08h
	defb	3fh, 00h, 3fh, 05h, 3fh, 05h, 3fh, 05h
	defb	03h, 0eah, 83h, 0e2h, 00h, 2ah, 0ffh, 2ah
	defb	00h, 2ah, 41h, 62h, 45h, 5ah, 45h, 5ah
	defb	0a9h, 40h, 88h, 01h, 0ffh, 0f1h, 0ffh, 0f1h
	defb	00h, 00h, 0cfh, 22h, 0cfh, 22h, 0cfh, 22h
	defb	00h, 00h, 52h, 00h, 50h, 05h, 50h, 05h
	defb	00h, 00h, 3fh, 2ah, 3fh, 2ah, 3fh, 2ah
	defb	02h, 83h, 00h, 00h, 55h, 54h, 55h, 54h
	defb	00h, 00h, 8ah, 0a3h, 8ah, 0a3h, 8ah, 0a3h
	defb	0c2h, 80h, 00h, 00h, 15h, 55h, 15h, 55h
	defb	00h, 00h, 0cah, 0a2h, 0cah, 0a2h, 0cah, 0a2h
	defb	00h, 00h, 00h, 85h, 50h, 05h, 50h, 05h
	defb	00h, 00h, 0a8h, 0fch, 0a8h, 0fch, 0a8h, 0fch
	defb	01h, 6ah, 40h, 22h, 4fh, 0ffh, 4fh, 0ffh
	defb	00h, 00h, 88h, 0f3h, 88h, 0f3h, 88h, 0f3h
	defb	0cfh, 22h, 0cfh, 22h, 0cfh, 22h, 00h, 00h
	defb	0ffh, 0f1h, 0ffh, 0f1h, 88h, 01h, 0a9h, 40h
	defb	3fh, 2ah, 3fh, 2ah, 3fh, 2ah, 00h, 00h
	defb	50h, 05h, 50h, 05h, 52h, 00h, 00h, 00h
	defb	8ah, 0a3h, 8ah, 0a3h, 8ah, 0a3h, 00h, 00h
	defb	55h, 54h, 55h, 54h, 00h, 00h, 02h, 83h
	defb	0cah, 0a2h, 0cah, 0a2h, 0cah, 0a2h, 00h, 00h
	defb	15h, 55h, 15h, 55h, 00h, 00h, 0c2h, 80h
	defb	0a8h, 0fch, 0a8h, 0fch, 0a8h, 0fch, 00h, 00h
	defb	50h, 05h, 50h, 05h, 00h, 85h, 00h, 00h
	defb	88h, 0f3h, 88h, 0f3h, 88h, 0f3h, 00h, 00h
	defb	4fh, 0ffh, 4fh, 0ffh, 40h, 22h, 01h, 6ah
	defb	0a5h, 51h, 0a5h, 51h, 89h, 41h, 0a8h, 00h
	defb	0a8h, 0ffh, 0a8h, 00h, 8bh, 0c2h, 0abh, 0c0h
	defb	50h, 0fch, 50h, 0fch, 50h, 0fch, 00h, 0fch
	defb	20h, 00h, 0fh, 22h, 3fh, 0c2h, 3fh, 0c0h
	defb	8ah, 0a0h, 2ah, 0a8h, 0aah, 0aah, 0aah, 0aah
	defb	2ah, 0a8h, 8ah, 0a0h, 82h, 83h, 00h, 03h
	defb	0ah, 0a2h, 2ah, 0a8h, 0aah, 0aah, 0aah, 0aah
	defb	2ah, 0a8h, 0ah, 0a2h, 0c2h, 82h, 0c0h, 00h
	defb	3fh, 05h, 3fh, 05h, 3fh, 05h, 3fh, 00h
	defb	00h, 08h, 88h, 0f0h, 83h, 0fch, 03h, 0fch
	defb	45h, 5ah, 45h, 5ah, 41h, 62h, 00h, 2ah
	defb	0ffh, 2ah, 00h, 2ah, 83h, 0e2h, 03h, 0eah
	defb	0abh, 0c5h, 0abh, 0c5h, 8bh, 00h, 0aah, 0fh
	defb	0aah, 0bfh, 0aah, 0aah, 8ah, 0aah, 0aah, 0aah
	defb	0fh, 15h, 00h, 00h, 00h, 0aah, 0fch, 00h
	defb	0fch, 0ffh, 0aah, 0aah, 8ah, 0aah, 0aah, 0aah
	defb	55h, 53h, 00h, 03h, 88h, 50h, 01h, 54h
	defb	0c5h, 55h, 0a5h, 55h, 89h, 56h, 0aah, 5ah
	defb	0c5h, 55h, 0c0h, 00h, 05h, 22h, 15h, 40h
	defb	55h, 53h, 55h, 5ah, 95h, 62h, 0a5h, 0aah
	defb	54h, 0f0h, 00h, 00h, 0aah, 00h, 00h, 3fh
	defb	0ffh, 3fh, 0aah, 0aah, 0aah, 0a2h, 0aah, 0aah
	defb	53h, 0eah, 53h, 0eah, 00h, 0e2h, 0f0h, 0aah
	defb	0feh, 0aah, 0aah, 0aah, 0aah, 0a2h, 0aah, 0aah
