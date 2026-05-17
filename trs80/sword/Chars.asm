cseg

AsciiPattern: public AsciiPattern
	; ascii 29
	; " 0123456789ACEFGHIKMNOPRSTUVY"
	defb 80h,80h,80h,80h,80h,80h
	defb 0beh,0abh,94h,8bh,8eh,81h
	defb 8ch,0bfh,80h,8ch,8fh,84h
	defb 0a3h,0bbh,84h,8fh,8ch,84h
	defb 0a3h,0bbh,84h,8ch,8eh,81h
	defb 0bfh,0bah,95h,80h,8ah,85h
	defb 0bfh,0b3h,81h,8ch,8eh,81h
	defb 0beh,0b3h,80h,8bh,8eh,81h
	defb 83h,0bbh,85h,8ah,85h,80h
	defb 0aeh,0bbh,84h,8bh,8eh,81h
	defb 0aeh,0bbh,94h,88h,8eh,81h
	defb 0beh,0abh,94h,8fh,8bh,85h
	defb 0beh,8bh,84h,8bh,8eh,81h
	defb 0bfh,0b3h,81h,8fh,8ch,84h
	defb 0bfh,0b3h,81h,8fh,80h,80h
	defb 0beh,0a3h,91h,8bh,8eh,81h
	defb 0bfh,0bah,95h,8fh,8ah,85h
	defb 0abh,97h,80h,8eh,8dh,80h
	defb 0bfh,9eh,81h,8fh,8bh,84h
	defb 0bdh,0b8h,95h,8fh,8ah,85h
	defb 0bfh,0abh,94h,8fh,8ah,85h
	defb 0beh,0abh,94h,8bh,8eh,81h
	defb 0bfh,0bbh,84h,8fh,80h,80h
	defb 0bfh,0bbh,84h,8fh,8ah,85h
	defb 0aeh,0b3h,81h,8ch,8eh,81h
	defb 0abh,97h,80h,8ah,85h,80h
	defb 0bfh,0aah,95h,8bh,8eh,85h
	defb 0bfh,0aah,95h,82h,87h,80h
	defb 0afh,0bah,85h,88h,87h,80h

CharPattern: public CharPattern
;	logo
	defb	80h, 80h, 80h, 8fh, 8fh, 80h, 0bch, 0bch
	defb	80h, 0bfh, 0bfh, 80h, 80h, 8fh, 8fh, 8fh
	defb	8fh, 8fh, 0bch, 0bfh, 8fh, 0bfh, 0bfh, 8fh
	defb	80h, 0bch, 0bch, 8fh, 0bfh, 0bch, 0bch, 0bch
	defb	0bch, 0bfh, 0bfh, 0bch, 80h, 0bfh, 0bfh, 8fh
	defb	0bfh, 0bfh, 0bch, 0bfh, 0bfh, 0bfh, 0bfh, 0bfh
;	6dot
	defb	97h, 83h, 83h, 83h, 83h, 0abh, 0b5h, 0b0h
	defb	0b0h, 0b0h, 0b0h, 0bah, 0a0h, 0bch, 0bch, 0bch
	defb	0bch, 90h, 0a8h, 0bch, 0b0h, 0b0h, 0bch, 94h
	defb	80h, 80h, 0a8h, 0bfh, 80h, 80h, 80h, 88h
	defb	0aeh, 0bfh, 8ch, 80h
;	sprite
	defb	80h, 0a2h, 93h, 0b3h, 95h, 80h, 80h, 0b1h
	defb	84h, 88h, 0b4h, 80h, 80h, 0a2h, 93h, 0b3h
	defb	95h, 80h, 80h, 84h, 0a4h, 9ch, 80h, 80h
	defb	0a2h, 93h, 0b3h, 95h, 80h, 80h, 8ch, 0b8h
	defb	84h, 8ch, 0b0h, 80h, 80h, 80h, 80h, 80h
	defb	80h, 80h, 80h, 80h, 83h, 8fh, 8fh, 8fh
	defb	80h, 0aah, 0b3h, 0a3h, 91h, 80h, 80h, 0b8h
	defb	84h, 88h, 0b2h, 80h, 80h, 0aah, 0b3h, 0a3h
	defb	91h, 80h, 80h, 80h, 0ach, 98h, 88h, 80h
	defb	80h, 80h, 0aah, 0b3h, 0a3h, 91h, 80h, 0b0h
	defb	8ch, 88h, 0b4h, 8ch, 80h, 80h, 80h, 80h
	defb	80h, 80h, 8fh, 8fh, 8fh, 83h, 80h, 80h
	defb	80h, 0aah, 0bfh, 0bfh, 95h, 80h, 82h, 0a8h
	defb	94h, 88h, 84h, 80h, 80h, 0aah, 0bfh, 0bfh
	defb	95h, 80h, 80h, 88h, 84h, 0a8h, 94h, 81h
	defb	80h, 0a8h, 0bch, 0bch, 97h, 80h, 80h, 0a2h
	defb	93h, 0a3h, 91h, 80h, 80h, 80h, 80h, 0b0h
	defb	80h, 80h, 80h, 80h, 80h, 0bfh, 0bfh, 80h
	defb	80h, 0a2h, 93h, 0b3h, 95h, 80h, 80h, 0a8h
	defb	94h, 88h, 84h, 81h, 80h, 0aah, 0b3h, 0a3h
	defb	91h, 80h, 82h, 88h, 84h, 0a8h, 94h, 80h
	defb	80h, 88h, 8ch, 8ch, 94h, 80h, 80h, 0b6h
	defb	81h, 0a3h, 91h, 84h, 80h, 0bfh, 0bfh, 80h
	defb	80h, 80h, 80h, 80h, 83h, 80h, 80h, 80h
	defb	80h, 0a2h, 0bbh, 0b3h, 94h, 80h, 80h, 0b0h
	defb	81h, 81h, 0b0h, 80h, 80h, 0a2h, 0bbh, 0b3h
	defb	94h, 80h, 80h, 80h, 0a1h, 91h, 80h, 80h
	defb	80h, 0a8h, 0b3h, 0b7h, 91h, 80h, 80h, 0b0h
	defb	82h, 82h, 0b0h, 80h, 80h, 0a8h, 0b3h, 0b7h
	defb	91h, 80h, 80h, 80h, 0a2h, 92h, 80h, 80h
	defb	80h, 0aah, 0bfh, 0bfh, 94h, 80h, 80h, 0a1h
	defb	93h, 8bh, 84h, 80h, 80h, 0a8h, 0bfh, 0bfh
	defb	95h, 80h, 80h, 88h, 87h, 0a3h, 92h, 80h
	defb	80h, 0a2h, 0bbh, 0b3h, 94h, 80h, 80h, 0a1h
	defb	91h, 89h, 84h, 80h, 80h, 0a8h, 0b3h, 0b7h
	defb	91h, 80h, 80h, 88h, 86h, 0a2h, 92h, 80h
	defb	9eh, 0bbh, 0bbh, 0b7h, 9fh, 0b9h, 0afh, 0bbh
	defb	0bdh, 0bfh, 0bbh, 9fh, 88h, 95h, 0a8h, 0a9h
	defb	0a8h, 0a9h, 88h, 8dh, 82h, 86h, 82h, 86h
	defb	86h, 99h, 0a8h, 0a9h, 0a8h, 0a9h, 8eh, 8ch
	defb	82h, 86h, 82h, 86h, 98h, 0abh, 0a8h, 0a9h
	defb	0a8h, 0a9h, 83h, 8bh, 82h, 86h, 82h, 86h
	defb	0a6h, 99h, 0a8h, 0a9h, 0a8h, 0a9h, 89h, 86h
	defb	82h, 86h, 82h, 86h, 0b6h, 0abh, 0abh, 0abh
	defb	0a3h, 0a9h, 0afh, 0bah, 0b2h, 0bah, 0b8h, 9eh
