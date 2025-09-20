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
;	3dot
	defb	0bch, 0bfh, 0bfh, 0bfh, 0bfh, 0bch, 8fh, 0bfh
	defb	0bfh, 0bfh, 0bfh, 8fh, 0bfh, 0bfh, 0bfh
;	6dot
	defb	80h, 0b3h, 0bfh, 0b3h, 0bch, 80h, 0a0h, 0bfh
	defb	8fh, 8fh, 0bfh, 91h, 80h, 0b3h, 0bfh, 0b3h
	defb	0bch, 80h, 86h, 0afh, 9fh, 0afh, 9fh, 89h
	defb	80h, 0bch, 0b3h, 0bfh, 0b3h, 80h, 0a2h, 0bfh
	defb	8fh, 8fh, 0bfh, 90h, 80h, 0bch, 0b3h, 0bfh
	defb	0b3h, 80h, 86h, 0afh, 9fh, 0afh, 9fh, 89h
	defb	80h, 0beh, 0bfh, 0bfh, 0bdh, 90h, 80h, 0bfh
	defb	9fh, 8fh, 8fh, 82h, 0a0h, 0beh, 0bfh, 0bfh
	defb	0bdh, 80h, 81h, 8fh, 8fh, 0afh, 0bfh, 80h
	defb	0a0h, 0b6h, 0bbh, 0b7h, 0b9h, 80h, 81h, 8fh
	defb	8fh, 0afh, 0bfh, 80h, 80h, 0b6h, 0bbh, 0b7h
	defb	0b9h, 90h, 80h, 0bfh, 9fh, 8fh, 8fh, 82h
	defb	80h, 8eh, 0bfh, 8fh, 0bdh, 80h, 80h, 83h
	defb	8fh, 0bfh, 9fh, 80h, 80h, 0b8h, 0bch, 0bch
	defb	0b4h, 80h, 88h, 8ch, 0bfh, 0bch, 0bfh, 84h
	defb	80h, 0beh, 8fh, 0bfh, 8dh, 80h, 80h, 0afh
	defb	0bfh, 8fh, 83h, 80h, 80h, 0b8h, 0bch, 0bch
	defb	0b4h, 80h, 88h, 0bfh, 0bch, 0bfh, 8ch, 84h
	defb	80h, 0beh, 0bfh, 0bfh, 0bdh, 80h, 80h, 8bh
	defb	0bfh, 0bfh, 87h, 80h, 80h, 0b8h, 0bch, 0bch
	defb	0b4h, 80h, 82h, 0afh, 0bfh, 0bfh, 9fh, 81h
	defb	80h, 9eh, 0afh, 9fh, 0adh, 80h, 80h, 8bh
	defb	0bfh, 0bfh, 87h, 80h, 80h, 0b8h, 0bch, 0bch
	defb	0b4h, 80h, 82h, 0adh, 0beh, 0bdh, 9eh, 81h
	defb	0bch, 0b3h, 83h, 0b3h, 0a9h, 94h, 8bh, 0a4h
	defb	0b0h, 0b0h, 0beh, 91h, 0a8h, 96h, 0b3h, 83h
	defb	0b3h, 0bch, 0a2h, 0bdh, 0b0h, 0b0h, 98h, 87h
	defb	0a8h, 96h, 83h, 83h, 0a9h, 94h, 82h, 89h
	defb	0a4h, 98h, 86h, 81h, 0a8h, 0b6h, 93h, 0a3h
	defb	0b9h, 94h, 82h, 89h, 0a4h, 98h, 86h, 81h
	defb	0a0h, 0b0h, 0beh, 0bdh, 0b0h, 90h, 80h, 0bbh
	defb	9fh, 0afh, 0b7h, 80h, 0b0h, 0bch, 0b3h, 0b3h
	defb	0bch, 0b0h, 80h, 83h, 8ch, 8ch, 83h, 80h
	defb	0a0h, 98h, 0aeh, 9dh, 0a4h, 90h, 82h, 89h
	defb	0aeh, 9dh, 86h, 81h
