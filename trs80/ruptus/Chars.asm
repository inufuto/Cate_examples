cseg

CharPattern: public CharPattern
;	logo
	defb	80h, 80h, 80h, 8fh, 8fh, 80h, 0bch, 0bch
	defb	80h, 0bfh, 0bfh, 80h, 80h, 8fh, 8fh, 8fh
	defb	8fh, 8fh, 0bch, 0bfh, 8fh, 0bfh, 0bfh, 8fh
	defb	80h, 0bch, 0bch, 8fh, 0bfh, 0bch, 0bch, 0bch
	defb	0bch, 0bfh, 0bfh, 0bch, 80h, 0bfh, 0bfh, 8fh
	defb	0bfh, 0bfh, 0bch, 0bfh, 0bfh, 0bfh, 0bfh, 0bfh
;	3dot
	defb	80h, 80h, 0bfh, 0b0h, 8ch, 83h, 0b0h, 0b0h
	defb	0b0h, 83h, 8ch, 0b0h, 0bfh, 0bfh, 0bfh, 8ch
	defb	8ch, 8ch, 80h, 0bfh, 80h, 0bfh, 0b3h, 0bfh
	defb	80h, 2eh, 20h
;	6dot
	defb	0b0h, 0bch, 0bfh, 0bch, 0b0h, 80h, 83h, 83h
	defb	8fh, 83h, 83h, 80h, 0bch, 0bch, 0bch, 0bfh
	defb	8fh, 80h, 80h, 83h, 8fh, 8fh, 80h, 80h
	defb	0b0h, 0bfh, 0bfh, 0bch, 0b0h, 80h, 80h, 8fh
	defb	8fh, 83h, 80h, 80h, 0b0h, 0bch, 0bfh, 0bfh
	defb	80h, 80h, 83h, 83h, 83h, 8fh, 8fh, 80h
	defb	0bch, 0bch, 0bfh, 0bch, 0bch, 80h, 80h, 83h
	defb	8fh, 83h, 80h, 80h, 80h, 0bfh, 0bfh, 0bch
	defb	0b0h, 80h, 8fh, 8fh, 83h, 83h, 83h, 80h
	defb	0b0h, 0bch, 0bfh, 0bfh, 0b0h, 80h, 80h, 83h
	defb	8fh, 8fh, 80h, 80h, 8fh, 0bfh, 0bch, 0bch
	defb	0bch, 80h, 80h, 8fh, 8fh, 83h, 80h, 80h
	defb	0b0h, 8ch, 0bfh, 8ch, 0b0h, 80h, 83h, 8fh
	defb	8fh, 8fh, 83h, 80h, 0bch, 0bfh, 0b3h, 8fh
	defb	0bfh, 80h, 80h, 83h, 8fh, 8fh, 83h, 80h
	defb	0bch, 0bfh, 0b3h, 0bch, 0b0h, 80h, 83h, 8fh
	defb	8ch, 83h, 80h, 80h, 0b0h, 0bch, 0bfh, 8fh
	defb	0bch, 80h, 83h, 8fh, 8ch, 8fh, 8fh, 80h
	defb	0bch, 8fh, 0bfh, 8fh, 0bch, 80h, 80h, 83h
	defb	8fh, 83h, 80h, 80h, 0bch, 8fh, 0bfh, 0bch
	defb	0b0h, 80h, 8fh, 8fh, 8ch, 8fh, 83h, 80h
	defb	0b0h, 0bch, 0b3h, 0bfh, 0bch, 80h, 80h, 83h
	defb	8ch, 8fh, 83h, 80h, 0bfh, 8fh, 0b3h, 0bfh
	defb	0bch, 80h, 83h, 8fh, 8fh, 83h, 80h, 80h
	defb	0b0h, 9eh, 0a3h, 99h, 0a6h, 98h, 88h, 0a5h
	defb	8ch, 0b3h, 0aeh, 87h, 80h, 88h, 0ach, 0b0h
	defb	0b0h, 0beh, 8bh, 0bch, 0b7h, 81h, 0a8h, 0b2h
	defb	0b4h, 0a0h, 0b8h, 9eh, 81h, 80h, 0a2h, 0b1h
	defb	94h, 0b3h, 97h, 80h, 0ach, 0beh, 0b1h, 88h
	defb	8fh, 87h, 80h, 80h, 8bh, 87h, 83h, 0abh
	defb	8bh, 85h, 0b0h, 9ch, 87h, 89h, 87h, 83h
	defb	81h, 8bh, 84h, 80h, 0bch, 0a8h, 94h, 0b0h
	defb	0b0h, 80h, 8bh, 8eh, 85h, 0bfh, 8eh, 81h
;	fort
	defb	0b0h, 0bch, 0bfh, 0bch, 0b0h, 80h, 0b0h, 0b0h
	defb	0bch, 0bch, 0b0h, 0b0h, 80h, 0b0h, 0bch, 0bfh
	defb	0bch, 0b0h, 80h, 0b3h, 0b3h, 0bch, 0bch, 0bch
	defb	0bch, 8ch, 0b3h, 0b3h, 8ch, 0bch, 0bch, 0bch
	defb	0bch, 0b3h, 0b3h, 80h, 80h, 0b3h, 83h, 0b3h
	defb	83h, 0b0h, 0bch, 8fh, 0b3h, 0b3h, 8fh, 0bch
	defb	0b0h, 83h, 0b3h, 83h, 0b3h, 80h, 80h, 0b3h
	defb	0b0h, 0b3h, 0b0h, 83h, 8fh, 0bch, 0b3h, 0b3h
	defb	0bch, 8fh, 83h, 0b0h, 0b3h, 0b0h, 0b3h, 80h
	defb	80h, 0b3h, 0b3h, 8fh, 8fh, 8fh, 8fh, 8ch
	defb	0b3h, 0b3h, 8ch, 8fh, 8fh, 8fh, 8fh, 0b3h
	defb	0b3h, 80h, 83h, 8fh, 0bfh, 8fh, 83h, 80h
	defb	83h, 83h, 8fh, 8fh, 83h, 83h, 80h, 83h
	defb	8fh, 0bfh, 8fh, 83h
