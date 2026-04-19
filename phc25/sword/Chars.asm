cseg

CharPattern: public CharPattern
; ascii 30
	; " -0123456789ACEFGHIKMNOPRSTUVY"
	defb 0aah,0aah,0aah,0aah,0aah,0aah,0aah,0aah
	defb 0aah,0aah,0aah,56h,0aah,0aah,0aah,0aah
	defb 9ah,66h,66h,66h,66h,66h,9ah,0aah
	defb 0a6h,0a6h,0a6h,0a6h,0a6h,0a6h,0a6h,0aah
	defb 9ah,66h,0a6h,0a6h,9ah,6ah,56h,0aah
	defb 9ah,66h,0a6h,9ah,0a6h,66h,9ah,0aah
	defb 0a6h,66h,66h,56h,0a6h,0a6h,0a6h,0aah
	defb 56h,6ah,6ah,5ah,0a6h,0a6h,5ah,0aah
	defb 9ah,66h,6ah,5ah,66h,66h,9ah,0aah
	defb 56h,66h,0a6h,9ah,9ah,9ah,9ah,0aah
	defb 9ah,66h,66h,9ah,66h,66h,9ah,0aah
	defb 9ah,66h,66h,96h,0a6h,66h,9ah,0aah
	defb 9ah,66h,66h,66h,56h,66h,66h,0aah
	defb 9ah,66h,6ah,6ah,6ah,66h,9ah,0aah
	defb 56h,6ah,6ah,5ah,6ah,6ah,56h,0aah
	defb 56h,6ah,6ah,5ah,6ah,6ah,6ah,0aah
	defb 96h,6ah,6ah,66h,66h,66h,9ah,0aah
	defb 66h,66h,66h,56h,66h,66h,66h,0aah
	defb 56h,9ah,9ah,9ah,9ah,9ah,56h,0aah
	defb 66h,56h,5ah,6ah,5ah,56h,66h,0aah
	defb 66h,56h,56h,56h,66h,66h,66h,0aah
	defb 5ah,66h,66h,66h,66h,66h,66h,0aah
	defb 9ah,66h,66h,66h,66h,66h,9ah,0aah
	defb 5ah,66h,66h,66h,5ah,6ah,6ah,0aah
	defb 5ah,66h,66h,66h,5ah,66h,66h,0aah
	defb 9ah,66h,6ah,9ah,0a6h,66h,9ah,0aah
	defb 56h,9ah,9ah,9ah,9ah,9ah,9ah,0aah
	defb 66h,66h,66h,66h,66h,66h,56h,0aah
	defb 66h,66h,66h,66h,66h,9ah,9ah,0aah
	defb 66h,66h,66h,9ah,9ah,9ah,9ah,0aah
	; logo
	defb 0ah,0ah,0ah,0ah,0aah,0aah,0aah,0aah
	defb 0aah,0aah,0aah,0aah,0ah,0ah,0ah,0ah
	defb 0ah,0ah,0ah,0ah,0ah,0ah,0ah,0ah
	defb 0a0h,0a0h,0a0h,0a0h,0aah,0aah,0aah,0aah
	defb 00h,00h,00h,00h,0aah,0aah,0aah,0aah
	defb 0a0h,0a0h,0a0h,0a0h,0ah,0ah,0ah,0ah
	defb 00h,00h,00h,00h,0ah,0ah,0ah,0ah
	defb 0aah,0aah,0aah,0aah,0a0h,0a0h,0a0h,0a0h
	defb 0ah,0ah,0ah,0ah,0a0h,0a0h,0a0h,0a0h
	defb 0aah,0aah,0aah,0aah,00h,00h,00h,00h
	defb 0ah,0ah,0ah,0ah,00h,00h,00h,00h
	defb 0a0h,0a0h,0a0h,0a0h,0a0h,0a0h,0a0h,0a0h
	defb 00h,00h,00h,00h,0a0h,0a0h,0a0h,0a0h
	defb 0a0h,0a0h,0a0h,0a0h,00h,00h,00h,00h
	defb 00h,00h,00h,00h,00h,00h,00h,00h
;	16dot
	defb	08h, 28h, 22h, 80h, 80h, 82h, 28h, 08h
	defb	08h, 08h, 22h, 82h, 82h, 28h, 08h, 20h
	defb	08h, 28h, 82h, 80h, 80h, 22h, 22h, 08h
	defb	20h, 20h, 88h, 82h, 82h, 22h, 08h, 08h
	defb	0aah, 0abh, 0afh, 0bfh, 0dfh, 0d7h, 77h, 77h
	defb	0fah, 0fah, 0feh, 0feh, 0ffh, 0ffh, 0ffh, 0ffh
	defb	0ddh, 0ddh, 0f5h, 0f5h, 0bdh, 0bdh, 0adh, 0adh
	defb	0fdh, 0f5h, 0d7h, 5fh, 7fh, 0feh, 0fah, 0eah
	defb	0ffh, 0eah, 0eah, 0eah, 0eah, 0eah, 0eah, 0eah
	defb	0ffh, 0abh, 0a7h, 0a7h, 97h, 9bh, 5bh, 5bh
	defb	0e9h, 0d9h, 0d5h, 0e5h, 0d5h, 0d6h, 0eah, 0ffh
	defb	6bh, 6bh, 0abh, 0abh, 6bh, 6bh, 0abh, 0ffh
;	sprite
	defb	0aah, 0a8h, 0a0h, 0aah, 0a2h, 0a2h, 0a0h, 0aah
	defb	0aah, 2ah, 0ah, 8ah, 0ah, 0ah, 0ah, 0aah
	defb	0aeh, 0aeh, 0aeh, 0aeh, 0aeh, 0aah, 0a2h, 82h
	defb	2ah, 2ah, 0aah, 2ah, 8ah, 8ah, 0a2h, 82h
	defb	0aah, 0a8h, 0a0h, 0aah, 0a2h, 0a2h, 0a0h, 0aah
	defb	0aah, 2ah, 0ah, 8ah, 0ah, 0ah, 0ah, 0aah
	defb	0abh, 9bh, 0abh, 0abh, 0abh, 0aah, 0aah, 0a8h
	defb	0eah, 0eah, 0eah, 0eah, 0eah, 0aah, 2ah, 2ah
	defb	0aah, 0a0h, 80h, 0aah, 88h, 88h, 80h, 0aah
	defb	0aah, 0aah, 2ah, 2ah, 2ah, 2ah, 2ah, 0aah
	defb	0a3h, 23h, 23h, 0a3h, 0abh, 0a2h, 0a2h, 82h
	defb	0eah, 0eah, 0eah, 0eah, 0eah, 0ah, 8ah, 8ah
	defb	0aah, 0aah, 0aah, 0aah, 0aah, 0aah, 0aah, 0aah
	defb	0aah, 0aah, 0aah, 0aah, 0aah, 0aah, 0aah, 0aah
	defb	0aah, 0a5h, 0a9h, 0aah, 0aah, 0aah, 0aah, 0aah
	defb	0a9h, 55h, 55h, 0a9h, 0aah, 0aah, 0aah, 0aah
	defb	0aah, 0a8h, 0a0h, 0a2h, 0a0h, 0a0h, 0a0h, 0aah
	defb	0aah, 2ah, 0ah, 0aah, 8ah, 8ah, 0ah, 0aah
	defb	0a8h, 0a8h, 0aah, 0aah, 0a2h, 0a2h, 8ah, 82h
	defb	0a6h, 05h, 05h, 0a6h, 0aah, 0aah, 8ah, 82h
	defb	0aah, 0a8h, 0a0h, 0a2h, 0a0h, 0a0h, 0a0h, 0aah
	defb	0aah, 2ah, 0ah, 0aah, 8ah, 8ah, 0ah, 0aah
	defb	0a0h, 84h, 85h, 85h, 0a6h, 0a8h, 0a8h, 0a8h
	defb	2eh, 2eh, 6eh, 2eh, 0aeh, 0aah, 0aah, 2ah
	defb	0aah, 0aah, 0a8h, 0a8h, 0a8h, 0a8h, 0a8h, 0aah
	defb	0aah, 0ah, 02h, 0aah, 22h, 22h, 02h, 0aah
	defb	0a8h, 0a8h, 0a8h, 0aah, 0a8h, 0a0h, 0a2h, 0a2h
	defb	8ah, 80h, 20h, 0aah, 0aah, 8ah, 8ah, 82h
	defb	0aah, 0aah, 0aah, 0aah, 0aah, 0aah, 0aah, 0aah
	defb	0aah, 0aah, 0aah, 0aah, 0aah, 0aah, 0aah, 0aah
	defb	6ah, 55h, 55h, 6ah, 0aah, 0aah, 0aah, 0aah
	defb	0aah, 5ah, 6ah, 0aah, 0aah, 0aah, 0aah, 0aah
	defb	0aah, 0a0h, 80h, 80h, 80h, 80h, 80h, 0aah
	defb	0aah, 2ah, 0ah, 0ah, 0ah, 0ah, 0ah, 0aah
	defb	0a0h, 0c0h, 0c0h, 0eah, 0e2h, 0e2h, 0a2h, 0a2h
	defb	2ah, 0ah, 0ah, 8ah, 16h, 1ah, 1ah, 9ah
	defb	0aah, 0a0h, 80h, 80h, 80h, 80h, 80h, 0aah
	defb	0aah, 2ah, 0ah, 0ah, 0ah, 0ah, 0ah, 0aah
	defb	0a0h, 80h, 0c0h, 0cah, 0f2h, 0b2h, 0a2h, 0aah
	defb	0ah, 02h, 21h, 0a6h, 2ah, 2ah, 2ah, 2ah
	defb	0aah, 0aah, 0aah, 0a0h, 80h, 80h, 80h, 80h
	defb	8ah, 8ah, 8ah, 2ah, 0ah, 0ah, 0ah, 0ah
	defb	80h, 0aah, 0a0h, 80h, 0cah, 0c2h, 0f2h, 0b2h
	defb	0ah, 0aah, 2ah, 2ah, 0aah, 2ah, 2ah, 2ah
	defb	0aah, 0aah, 0aah, 0aah, 0aah, 0aah, 0aah, 0aah
	defb	0aah, 0aah, 0aah, 0aah, 9ah, 9ah, 9ah, 9ah
	defb	0aah, 0aah, 0aah, 0aah, 0aah, 0aah, 0aah, 0aah
	defb	9ah, 9ah, 9ah, 9ah, 9ah, 9ah, 56h, 8ah
	defb	0aah, 0a0h, 80h, 8ah, 82h, 82h, 80h, 0aah
	defb	0aah, 2ah, 0ah, 8ah, 0ah, 0ah, 0ah, 0aah
	defb	0a0h, 80h, 80h, 5ah, 92h, 92h, 92h, 0a2h
	defb	3eh, 3eh, 3eh, 0beh, 3eh, 2ah, 0aah, 0aah
	defb	0aah, 0a0h, 80h, 8ah, 82h, 82h, 80h, 0aah
	defb	0aah, 2ah, 0ah, 8ah, 0ah, 0ah, 0ah, 0aah
	defb	0a0h, 80h, 50h, 9ah, 0a2h, 0a2h, 0aah, 0aah
	defb	2eh, 0eh, 0eh, 0aeh, 2eh, 2ah, 2ah, 2ah
	defb	0aah, 0aah, 0aah, 0aah, 0a0h, 80h, 80h, 8ah
	defb	0aah, 0aah, 0aah, 0aah, 2ah, 0ah, 0ah, 8ah
	defb	82h, 82h, 0aah, 0a8h, 8ah, 8ah, 82h, 0a2h
	defb	3eh, 3eh, 0beh, 3eh, 0beh, 2ah, 0ah, 0aah
	defb	0a2h, 95h, 0a6h, 0a6h, 0a6h, 0a6h, 0a6h, 0a6h
	defb	0aah, 0aah, 0aah, 0aah, 0aah, 0aah, 0aah, 0aah
	defb	0a6h, 0a6h, 0a6h, 0a6h, 0aah, 0aah, 0aah, 0aah
	defb	0aah, 0aah, 0aah, 0aah, 0aah, 0aah, 0aah, 0aah
	defb	0aah, 0a9h, 0a5h, 0a9h, 0a9h, 0a5h, 0a6h, 0aah
	defb	0aah, 6ah, 5ah, 9ah, 9ah, 5ah, 6ah, 0aah
	defb	0aah, 0a9h, 0a9h, 0aah, 0aah, 0aah, 0a9h, 0a5h
	defb	6ah, 6ah, 0aah, 0aah, 9ah, 96h, 0a6h, 0a6h
	defb	0aah, 0a9h, 0a5h, 0a9h, 0a9h, 0a5h, 0a6h, 0aah
	defb	0aah, 6ah, 5ah, 9ah, 9ah, 5ah, 6ah, 0aah
	defb	0a9h, 9ah, 99h, 0aah, 0aah, 0aah, 0aah, 0a9h
	defb	9ah, 0a6h, 66h, 0aah, 6ah, 6ah, 6ah, 6ah
	defb	0aah, 0a9h, 0a5h, 0a6h, 0a6h, 0a5h, 0a9h, 0aah
	defb	0aah, 6ah, 5ah, 6ah, 6ah, 5ah, 9ah, 0aah
	defb	0a9h, 0a9h, 0aah, 0aah, 0a6h, 96h, 9ah, 9ah
	defb	0aah, 6ah, 6ah, 0aah, 0aah, 0aah, 6ah, 5ah
	defb	0aah, 0a9h, 0a5h, 0a6h, 0a6h, 0a5h, 0a9h, 0aah
	defb	0aah, 6ah, 5ah, 6ah, 6ah, 5ah, 9ah, 0aah
	defb	0a6h, 9ah, 99h, 0aah, 0a9h, 0a9h, 0a9h, 0a9h
	defb	6ah, 0a6h, 66h, 0aah, 0aah, 0aah, 0aah, 6ah
	defb	0aah, 0a5h, 95h, 95h, 95h, 95h, 0a5h, 0aah
	defb	0aah, 6ah, 5ah, 5ah, 5ah, 5ah, 6ah, 0aah
	defb	99h, 99h, 0a9h, 0aah, 0a6h, 0a6h, 0a6h, 0a6h
	defb	9ah, 96h, 0a6h, 0aah, 6ah, 6ah, 6ah, 0aah
	defb	0aah, 0a5h, 95h, 95h, 95h, 95h, 0a5h, 0aah
	defb	0aah, 6ah, 5ah, 5ah, 5ah, 5ah, 6ah, 0aah
	defb	99h, 59h, 69h, 0aah, 0a6h, 0a6h, 0a6h, 0aah
	defb	9ah, 9ah, 0aah, 0aah, 6ah, 6ah, 6ah, 6ah
	defb	0aah, 0a5h, 95h, 99h, 99h, 95h, 0a6h, 0aah
	defb	0aah, 6ah, 5ah, 9ah, 9ah, 5ah, 6ah, 0aah
	defb	9ah, 9ah, 9ah, 0aah, 0a6h, 0a6h, 0a6h, 0a6h
	defb	9ah, 5ah, 6ah, 0aah, 6ah, 6ah, 6ah, 0aah
	defb	0aah, 0a5h, 95h, 99h, 99h, 95h, 0a5h, 0aah
	defb	0aah, 6ah, 5ah, 9ah, 9ah, 5ah, 6ah, 0aah
	defb	9ah, 96h, 0a6h, 0aah, 0a6h, 0a6h, 0a6h, 0aah
	defb	9ah, 9ah, 9ah, 0aah, 6ah, 6ah, 6ah, 6ah
	defb	99h, 55h, 59h, 95h, 55h, 56h, 65h, 55h
	defb	66h, 95h, 59h, 55h, 55h, 56h, 65h, 55h
	defb	95h, 59h, 55h, 56h, 65h, 55h, 55h, 99h
	defb	55h, 96h, 55h, 59h, 95h, 56h, 59h, 66h
	defb	0aah, 0aah, 0aah, 88h, 88h, 08h, 08h, 8ah
	defb	0aah, 0aah, 2ah, 8ah, 8ah, 8ah, 8ah, 2ah
	defb	8ah, 8ah, 8ah, 8ah, 02h, 0aah, 0aah, 0aah
	defb	0a2h, 88h, 88h, 88h, 88h, 0a2h, 0aah, 0aah
	defb	0aah, 0aah, 0aah, 88h, 00h, 20h, 0a0h, 0a2h
	defb	0aah, 0aah, 2ah, 8ah, 8ah, 8ah, 8ah, 2ah
	defb	82h, 8ah, 0ah, 2ah, 02h, 0aah, 0aah, 0aah
	defb	0a2h, 88h, 88h, 88h, 88h, 0a2h, 0aah, 0aah
	defb	0aah, 0aah, 0aah, 0a0h, 0a0h, 0a0h, 20h, 22h
	defb	0aah, 0aah, 2ah, 8ah, 8ah, 8ah, 8ah, 2ah
	defb	22h, 02h, 02h, 0a2h, 0a2h, 0aah, 0aah, 0aah
	defb	0a2h, 88h, 88h, 88h, 88h, 0a2h, 0aah, 0aah
	defb	0aah, 0aah, 0aah, 88h, 00h, 20h, 20h, 8ah
	defb	0aah, 0aah, 2ah, 8ah, 8ah, 8ah, 8ah, 2ah
	defb	8ah, 22h, 22h, 22h, 8ah, 0aah, 0aah, 0aah
	defb	0a2h, 88h, 88h, 88h, 88h, 0a2h, 0aah, 0aah
	defb	0aah, 80h, 80h, 11h, 11h, 11h, 11h, 11h
	defb	0aah, 02h, 02h, 00h, 00h, 0fch, 0fch, 0cch
	defb	11h, 15h, 15h, 00h, 00h, 80h, 80h, 0aah
	defb	0cch, 0fch, 0fch, 0c0h, 0c0h, 02h, 02h, 0aah
