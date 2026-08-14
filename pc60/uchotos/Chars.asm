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
;	logo
	defb	5ah, 5ah, 5ah, 5ah, 0aah, 0aah, 0aah, 0aah
	defb	0aah, 0aah, 0aah, 0aah, 5ah, 5ah, 5ah, 5ah
	defb	5ah, 5ah, 5ah, 5ah, 5ah, 5ah, 5ah, 5ah
	defb	0a5h, 0a5h, 0a5h, 0a5h, 0aah, 0aah, 0aah, 0aah
	defb	55h, 55h, 55h, 55h, 0aah, 0aah, 0aah, 0aah
	defb	0a5h, 0a5h, 0a5h, 0a5h, 5ah, 5ah, 5ah, 5ah
	defb	55h, 55h, 55h, 55h, 5ah, 5ah, 5ah, 5ah
	defb	0aah, 0aah, 0aah, 0aah, 0a5h, 0a5h, 0a5h, 0a5h
	defb	5ah, 5ah, 5ah, 5ah, 0a5h, 0a5h, 0a5h, 0a5h
	defb	0aah, 0aah, 0aah, 0aah, 55h, 55h, 55h, 55h
	defb	5ah, 5ah, 5ah, 5ah, 55h, 55h, 55h, 55h
	defb	0a5h, 0a5h, 0a5h, 0a5h, 0a5h, 0a5h, 0a5h, 0a5h
	defb	55h, 55h, 55h, 55h, 0a5h, 0a5h, 0a5h, 0a5h
	defb	0a5h, 0a5h, 0a5h, 0a5h, 55h, 55h, 55h, 55h
	defb	55h, 55h, 55h, 55h, 55h, 55h, 55h, 55h
;	8dot
	defb	8ah, 80h, 80h, 8ah, 8ah, 80h, 80h, 8ah
	defb	0a2h, 02h, 02h, 0a2h, 0a2h, 02h, 02h, 0a2h
	defb	55h, 55h, 55h, 55h, 55h, 55h, 55h, 0aah
;	16dot
	defb	0a9h, 0a9h, 0a9h, 0a9h, 55h, 55h, 95h, 95h
	defb	0aah, 0aah, 0aah, 0aah, 56h, 56h, 5ah, 5ah
	defb	0a5h, 0a5h, 96h, 96h, 9ah, 9ah, 0aah, 0aah
	defb	6ah, 6ah, 5ah, 5ah, 9ah, 9ah, 0aah, 0aah
;	sprite
	defb	0aah, 0a9h, 0a5h, 0a9h, 0a9h, 0a5h, 0a9h, 0aah
	defb	0aah, 6ah, 5ah, 9ah, 9ah, 5ah, 6ah, 0aah
	defb	0a5h, 95h, 99h, 0a9h, 0a6h, 0a6h, 0a6h, 0a6h
	defb	5ah, 56h, 66h, 6ah, 9ah, 9ah, 9ah, 9ah
	defb	0aah, 0a9h, 0a5h, 0a9h, 0a9h, 0a5h, 0a9h, 0aah
	defb	0aah, 6ah, 5ah, 9ah, 9ah, 5ah, 6ah, 0aah
	defb	0a9h, 99h, 99h, 0a9h, 0a6h, 0a6h, 9ah, 9ah
	defb	5ah, 56h, 66h, 6ah, 96h, 96h, 0aah, 0aah
	defb	0aah, 0a9h, 0a5h, 0a9h, 0a9h, 0a5h, 0a9h, 0aah
	defb	0aah, 6ah, 5ah, 9ah, 9ah, 5ah, 6ah, 0aah
	defb	0aah, 0aah, 0a9h, 0a9h, 0aah, 0a9h, 0a9h, 0a9h
	defb	6ah, 6ah, 6ah, 0aah, 0aah, 0aah, 0aah, 0aah
	defb	0aah, 0a9h, 0a5h, 0a9h, 0a9h, 0a5h, 0a9h, 0aah
	defb	0aah, 6ah, 5ah, 9ah, 9ah, 5ah, 6ah, 0aah
	defb	0a9h, 95h, 96h, 0a9h, 0aah, 0a6h, 0a6h, 0a6h
	defb	6ah, 66h, 66h, 6ah, 56h, 96h, 0aah, 0aah
	defb	0aah, 0a9h, 0a5h, 0a6h, 0a6h, 0a5h, 0a9h, 0aah
	defb	0aah, 6ah, 5ah, 6ah, 6ah, 5ah, 6ah, 0aah
	defb	0a5h, 95h, 99h, 0a9h, 0a6h, 0a6h, 0a6h, 0a6h
	defb	5ah, 56h, 66h, 6ah, 9ah, 9ah, 9ah, 9ah
	defb	0aah, 0a9h, 0a5h, 0a6h, 0a6h, 0a5h, 0a9h, 0aah
	defb	0aah, 6ah, 5ah, 6ah, 6ah, 5ah, 6ah, 0aah
	defb	0a5h, 95h, 99h, 0a9h, 96h, 96h, 0aah, 0aah
	defb	6ah, 66h, 66h, 6ah, 9ah, 9ah, 0a6h, 0a6h
	defb	0aah, 0a9h, 0a5h, 0a6h, 0a6h, 0a5h, 0a9h, 0aah
	defb	0aah, 6ah, 5ah, 6ah, 6ah, 5ah, 6ah, 0aah
	defb	0a9h, 0a9h, 0a9h, 0aah, 0aah, 0aah, 0aah, 0aah
	defb	0aah, 0aah, 6ah, 6ah, 0aah, 6ah, 6ah, 6ah
	defb	0aah, 0a9h, 0a5h, 0a6h, 0a6h, 0a5h, 0a9h, 0aah
	defb	0aah, 6ah, 5ah, 6ah, 6ah, 5ah, 6ah, 0aah
	defb	0a9h, 99h, 99h, 0a9h, 95h, 96h, 0aah, 0aah
	defb	6ah, 56h, 96h, 6ah, 0aah, 9ah, 9ah, 9ah
	defb	0aah, 0a9h, 0a5h, 0a5h, 0a5h, 0a5h, 0a9h, 0aah
	defb	0aah, 6ah, 5ah, 5ah, 5ah, 5ah, 66h, 0a6h
	defb	99h, 95h, 0a5h, 0a9h, 0a6h, 0a6h, 0aah, 0aah
	defb	56h, 5ah, 6ah, 6ah, 5ah, 9ah, 9ah, 9ah
	defb	0aah, 0a9h, 0a5h, 0a5h, 0a5h, 0a5h, 99h, 9ah
	defb	0aah, 6ah, 5ah, 5ah, 5ah, 5ah, 6ah, 0aah
	defb	95h, 0a5h, 0a9h, 0a9h, 0a5h, 0a6h, 0a6h, 0a6h
	defb	66h, 56h, 5ah, 6ah, 9ah, 9ah, 0aah, 0aah
	defb	0a0h, 0a0h, 80h, 80h, 00h, 22h, 22h, 22h
	defb	2ah, 0ah, 0ah, 02h, 02h, 00h, 00h, 00h
	defb	00h, 80h, 0aah, 88h, 88h, 88h, 0a2h, 0aah
	defb	02h, 0ah, 0aah, 8ah, 8ah, 8ah, 22h, 0aah
	defb	0aah, 0a0h, 0a0h, 80h, 80h, 00h, 22h, 22h
	defb	0aah, 2ah, 0ah, 0ah, 02h, 02h, 00h, 00h
	defb	22h, 00h, 0aah, 88h, 88h, 88h, 0a2h, 0aah
	defb	00h, 02h, 0aah, 8ah, 8ah, 8ah, 22h, 0aah
	defb	0a8h, 0a0h, 0a0h, 80h, 80h, 00h, 00h, 00h
	defb	0ah, 0ah, 02h, 02h, 00h, 88h, 88h, 88h
	defb	80h, 0a0h, 0aah, 0a2h, 0a2h, 0a2h, 88h, 0aah
	defb	00h, 02h, 0aah, 22h, 22h, 22h, 8ah, 0aah
	defb	0aah, 0a8h, 0a0h, 0a0h, 80h, 80h, 00h, 00h
	defb	0aah, 0ah, 0ah, 02h, 02h, 00h, 88h, 88h
	defb	00h, 80h, 0aah, 0a2h, 0a2h, 0a2h, 88h, 0aah
	defb	88h, 00h, 0aah, 22h, 22h, 22h, 8ah, 0aah
	defb	0aah, 0a2h, 88h, 88h, 88h, 0aah, 80h, 00h
	defb	0aah, 22h, 8ah, 8ah, 8ah, 0aah, 02h, 00h
	defb	20h, 08h, 20h, 00h, 80h, 80h, 0a0h, 0a8h
	defb	08h, 20h, 08h, 00h, 02h, 02h, 0ah, 2ah
	defb	0aah, 0aah, 0aah, 0aah, 0aah, 0aah, 0abh, 0afh
	defb	0aah, 0aah, 0aah, 0aah, 0aah, 0fah, 0eah, 0eah
	defb	0adh, 0b5h, 0b7h, 0b5h, 0afh, 0afh, 0aah, 0aah
	defb	0eah, 0eah, 7ah, 0eah, 0eah, 0aah, 0aah, 0aah
	defb	0aah, 80h, 80h, 11h, 11h, 11h, 11h, 11h
	defb	0aah, 02h, 02h, 00h, 00h, 0fch, 0fch, 0cch
	defb	11h, 15h, 15h, 00h, 00h, 80h, 80h, 0aah
	defb	0cch, 0fch, 0fch, 0c0h, 0c0h, 02h, 02h, 0aah
