cseg


AsciiPattern: public AsciiPattern
	; ascii 29
	; " -0123456789:ACDEGHILMNORSTUV"
	defb 00h,00h,00h,00h,0e0h,00h,0eah,0aah
	defb 0e0h,22h,22h,20h,0e2h,0e8h,0e0h,0e2h
	defb 0e2h,0e0h,0aah,0e2h,20h,0e8h,0e2h,0e0h
	defb 0e8h,0eah,0e0h,0e2h,44h,40h,0eah,0eah
	defb 0e0h,0eah,0e2h,0e0h,04h,04h,00h,4ah
	defb 0aeh,0a0h,4ah,8ah,40h,0cah,0aah,0c0h
	defb 0e8h,0c8h,0e0h,68h,0aah,40h,0aah,0eah
	defb 0a0h,0e4h,44h,0e0h,88h,88h,0e0h,0aeh
	defb 0eah,0a0h,0cah,0aah,0a0h,4ah,0aah,40h
	defb 0cah,0cah,0a0h,68h,0e2h,0c0h,0e4h,44h
	defb 40h,0aah,0aah,0e0h,0aah,0aah,40h

CharPattern: public CharPattern
;	4dot
	defb	00h, 00h, 0ffh, 0ffh
;	8dot
	defb	37h, 27h, 8ch, 0cch, 77h, 6ch, 0eeh, 0c6h
	defb	37h, 27h, 8ch, 0cch, 7fh, 21h, 0edh, 0c8h
	defb	13h, 33h, 0ceh, 4eh, 77h, 36h, 0eeh, 63h
	defb	13h, 33h, 0ceh, 4eh, 7bh, 31h, 0efh, 48h
	defb	37h, 77h, 8ch, 0cch, 0f7h, 66h, 0eeh, 0c0h
	defb	37h, 77h, 8ch, 0cch, 0ffh, 60h, 0ech, 0cch
	defb	13h, 23h, 0ceh, 0aeh, 77h, 30h, 0feh, 66h
	defb	13h, 23h, 0ceh, 0aeh, 73h, 33h, 0ffh, 60h
	defb	27h, 2fh, 8ch, 0ceh, 73h, 10h, 0cch, 8ch
	defb	02h, 72h, 08h, 0cch, 7fh, 31h, 0ceh, 0cch
	defb	13h, 37h, 4eh, 4fh, 33h, 13h, 0ech, 80h
	defb	01h, 33h, 04h, 0e4h, 37h, 33h, 0efh, 0c8h
	defb	27h, 7fh, 8ch, 0ceh, 77h, 31h, 0cch, 80h
	defb	02h, 77h, 08h, 0cch, 0f7h, 73h, 0ech, 0c8h
	defb	13h, 27h, 4eh, 0afh, 33h, 10h, 0eeh, 0c8h
	defb	01h, 32h, 04h, 0eah, 73h, 31h, 0feh, 0ech
	defb	7dh, 0adh, 0c6h, 0a6h, 0adh, 0a7h, 0a6h, 0ach
	defb	7eh, 0dbh, 0ceh, 6ah, 8bh, 0f7h, 2ah, 0ech
	defb	7ch, 0beh, 0c6h, 0a6h, 0d8h, 0f7h, 0e2h, 0ech
	defb	7ch, 0feh, 0c6h, 0a6h, 0fch, 0f7h, 0a6h, 0ech
	defb	7eh, 0dbh, 0c6h, 66h, 8fh, 0f7h, 26h, 0ech
	defb	78h, 0b8h, 0c6h, 0e6h, 0f8h, 0f7h, 0a6h, 0ech
	defb	7ch, 0b8h, 0c6h, 0e6h, 0bch, 0f7h, 0a6h, 0ech
	defb	78h, 0bfh, 0c2h, 0a6h, 0eeh, 0f7h, 0eeh, 0ech
	defb	7ch, 0bch, 0c6h, 0a6h, 0bch, 0f7h, 0a6h, 0ech
	defb	7ch, 0bch, 0c6h, 0a2h, 0fch, 0f7h, 0a6h, 0ech
	defb	7ah, 0aah, 0c2h, 0aah, 0aah, 0f7h, 0a2h, 0ech
	defb	7ch, 0ffh, 0c2h, 66h, 0bch, 0f7h, 6eh, 0ech
	defb	7ch, 0bah, 0c6h, 0aah, 0bch, 0f7h, 6ah, 0ech
	defb	7dh, 0dch, 0cah, 6eh, 0ddh, 0f7h, 6ah, 0ech
;	title
	defb	67h, 77h, 33h, 0bfh, 66h, 60h, 0f7h, 30h
	defb	76h, 67h, 0f0h, 0fh, 66h, 70h, 00h, 0f0h
	defb	66h, 66h, 33h, 33h, 66h, 30h, 33h, 0e0h
	defb	76h, 66h, 0e3h, 37h, 76h, 60h, 0c6h, 30h
	defb	13h, 66h, 0c6h, 33h, 76h, 60h, 0f3h, 30h
	defb	36h, 63h, 0e3h, 0eh, 06h, 30h, 33h, 0e0h
