cseg

MonoChars_: public MonoChars_
;	logo
	defb	00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h
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
;	8dot
	defb	0ffh, 0ffh, 0dfh, 0fbh, 0ffh, 0dfh, 0f6h, 0ffh
	defb	0ffh, 0f7h, 0ffh, 0ddh, 0ffh, 0fbh, 0ffh, 0fdh
	defb	0bbh, 0ddh, 0eeh, 77h, 0bbh, 0ddh, 0eeh, 77h
	defb	00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h
	defb	0c0h, 80h, 80h, 80h, 0c0h, 0c0h, 80h, 80h
	defb	01h, 01h, 03h, 03h, 01h, 01h, 01h, 03h
	defb	0ffh, 31h, 00h, 00h, 00h, 00h, 00h, 00h
	defb	00h, 00h, 00h, 00h, 00h, 00h, 8ch, 0ffh
	defb	0ffh, 0e0h, 0c0h, 80h, 80h, 80h, 0c0h, 0c0h
	defb	0ffh, 0c7h, 03h, 01h, 01h, 01h, 01h, 01h
	defb	80h, 80h, 80h, 80h, 80h, 0c0h, 0e3h, 0ffh
	defb	03h, 03h, 01h, 01h, 01h, 03h, 07h, 0ffh

ColorChars_: public ColorChars_
	; 16dot
	defb 0h, 0h, 0h, 33h, 0h, 77h, 0h, 66h, 0h, 66h, 0h, 77h, 0h, 33h, 0h, 0h
	defb 0h, 0h, 0cch, 0h, 0eeh, 0h, 0aah, 0h, 0aah, 0h, 0eeh, 0h, 0cch, 0h, 0h, 0h
	defb 0h, 11h, 0h, 11h, 0h, 0h, 0h, 33h, 0h, 66h, 0h, 0cch, 0h, 0cch, 0h, 0eeh
	defb 88h, 0h, 0eeh, 0h, 0eeh, 0h, 0h, 0h, 66h, 0h, 66h, 0h, 33h, 0h, 33h, 88h
	defb 0h, 0h, 0h, 33h, 0h, 77h, 0h, 66h, 0h, 66h, 0h, 77h, 0h, 33h, 0h, 0h
	defb 0h, 0h, 0cch, 0h, 0eeh, 0h, 0aah, 0h, 0aah, 0h, 0eeh, 0h, 0cch, 0h, 0h, 0h
	defb 0h, 0ffh, 11h, 0ffh, 11h, 0bbh, 0h, 33h, 0h, 33h, 0h, 11h, 0h, 11h, 0h, 11h
	defb 0cch, 0h, 0ddh, 88h, 0ddh, 88h, 0cch, 0h, 0h, 0h, 88h, 0h, 88h, 0h, 0cch, 0h
	defb 0h, 0h, 0h, 33h, 0h, 77h, 0h, 55h, 0h, 55h, 0h, 77h, 0h, 33h, 0h, 0h
	defb 0h, 0h, 0cch, 0h, 0eeh, 0h, 66h, 0h, 66h, 0h, 0eeh, 0h, 0cch, 0h, 0h, 0h
	defb 0h, 11h, 0h, 77h, 0h, 77h, 0h, 0h, 0h, 66h, 0h, 66h, 0h, 0cch, 11h, 0cch
	defb 88h, 0h, 88h, 0h, 0h, 0h, 0cch, 0h, 66h, 0h, 33h, 0h, 33h, 0h, 77h, 0h
	defb 0h, 0h, 0h, 33h, 0h, 77h, 0h, 55h, 0h, 55h, 0h, 77h, 0h, 33h, 0h, 0h
	defb 0h, 0h, 0cch, 0h, 0eeh, 0h, 66h, 0h, 66h, 0h, 0eeh, 0h, 0cch, 0h, 0h, 0h
	defb 0h, 33h, 11h, 0bbh, 11h, 0bbh, 0h, 33h, 0h, 0h, 0h, 11h, 0h, 11h, 0h, 33h
	defb 0ffh, 0h, 0ffh, 88h, 0ddh, 88h, 0cch, 0h, 0cch, 0h, 88h, 0h, 88h, 0h, 88h, 0h
	defb 0h, 0h, 0h, 0h, 0h, 0h, 0h, 0h, 0h, 0h, 33h, 0cch, 77h, 0eeh, 66h, 66h
	defb 0h, 0h, 0h, 0h, 0h, 0h, 0h, 0h, 0h, 77h, 0h, 0ffh, 11h, 99h, 0ddh, 0h
	defb 77h, 0eeh, 66h, 66h, 33h, 0cch, 0h, 0h, 0h, 0h, 0h, 0h, 0h, 0h, 0h, 0h
	defb 0eeh, 0h, 66h, 0cch, 66h, 0ffh, 0h, 33h, 0h, 11h, 0h, 0h, 0h, 0h, 0h, 0h
	defb 0h, 0h, 0h, 0h, 0h, 0h, 0h, 0h, 0h, 0h, 33h, 0cch, 77h, 0eeh, 66h, 66h
	defb 0h, 0h, 0h, 0h, 0h, 0h, 66h, 0h, 0eeh, 0h, 0cch, 0h, 0ffh, 88h, 0ffh, 0ffh
	defb 77h, 0eeh, 66h, 66h, 33h, 0cch, 0h, 0h, 0h, 0h, 0h, 0h, 0h, 0h, 0h, 0h
	defb 0ffh, 77h, 0ffh, 11h, 0h, 0h, 66h, 0h, 66h, 0h, 0h, 0h, 0h, 0h, 0h, 0h
	defb 0h, 0h, 0h, 0h, 0h, 0h, 0h, 0h, 0h, 0h, 33h, 0cch, 66h, 66h, 77h, 0eeh
	defb 0h, 0h, 0h, 0h, 0h, 0h, 0h, 11h, 0h, 33h, 66h, 0ffh, 66h, 0cch, 0eeh, 0h
	defb 66h, 66h, 77h, 0eeh, 33h, 0cch, 0h, 0h, 0h, 0h, 0h, 0h, 0h, 0h, 0h, 0h
	defb 0ddh, 0h, 11h, 99h, 0h, 0ffh, 0h, 77h, 0h, 0h, 0h, 0h, 0h, 0h, 0h, 0h
	defb 0h, 0h, 0h, 0h, 0h, 0h, 0h, 0h, 0h, 0h, 33h, 0cch, 66h, 66h, 77h, 0eeh
	defb 0h, 0h, 0h, 0h, 0h, 0h, 66h, 0h, 66h, 0h, 0h, 0h, 0ffh, 11h, 0ffh, 77h
	defb 66h, 66h, 77h, 0eeh, 33h, 0cch, 0h, 0h, 0h, 0h, 0h, 0h, 0h, 0h, 0h, 0h
	defb 0ffh, 0ffh, 0ffh, 88h, 0cch, 0h, 0eeh, 0h, 66h, 0h, 0h, 0h, 0h, 0h, 0h, 0h
	defb 0h, 0h, 0h, 0ffh, 11h, 0ffh, 11h, 0aah, 11h, 0aah, 11h, 0ffh, 0h, 0ffh, 0h, 0h
	defb 11h, 0eeh, 22h, 88h, 88h, 88h, 88h, 88h, 88h, 88h, 88h, 88h, 22h, 0h, 77h, 0h
	defb 0h, 0ddh, 0h, 0ddh, 0h, 0eeh, 0h, 0ffh, 11h, 99h, 33h, 11h, 33h, 0h, 33h, 88h
	defb 0eeh, 0h, 0cch, 0h, 0h, 0h, 0h, 0h, 88h, 0h, 88h, 0h, 0cch, 0h, 0eeh, 0h
	defb 0h, 0h, 0h, 0ffh, 11h, 0ffh, 11h, 0aah, 11h, 0aah, 11h, 0ffh, 0h, 0ffh, 0h, 0h
	defb 0h, 0h, 0h, 0h, 88h, 0h, 88h, 0h, 88h, 0h, 88h, 0h, 0h, 0h, 0h, 0h
	defb 0h, 0ddh, 0h, 0ddh, 0h, 0ddh, 0h, 44h, 0h, 44h, 0h, 66h, 0h, 66h, 0h, 77h
	defb 88h, 0h, 88h, 0h, 0cch, 22h, 0eeh, 11h, 55h, 0ffh, 0h, 11h, 0h, 11h, 0h, 0h
	defb 77h, 88h, 11h, 44h, 11h, 11h, 11h, 11h, 11h, 11h, 11h, 11h, 0h, 44h, 0h, 0eeh
	defb 0h, 0h, 0ffh, 0h, 0ffh, 88h, 55h, 88h, 55h, 88h, 0ffh, 88h, 0ffh, 0h, 0h, 0h
	defb 0h, 77h, 0h, 33h, 0h, 0h, 0h, 0h, 0h, 11h, 0h, 11h, 0h, 33h, 0h, 77h
	defb 0bbh, 0h, 0bbh, 0h, 77h, 0h, 0ffh, 0h, 99h, 88h, 88h, 0cch, 0h, 0cch, 11h, 0cch
	defb 0h, 0h, 0h, 0h, 0h, 11h, 0h, 11h, 0h, 11h, 0h, 11h, 0h, 0h, 0h, 0h
	defb 0h, 0h, 0ffh, 0h, 0ffh, 88h, 55h, 88h, 55h, 88h, 0ffh, 88h, 0ffh, 0h, 0h, 0h
	defb 0h, 11h, 0h, 11h, 44h, 33h, 88h, 77h, 0ffh, 0aah, 88h, 0h, 88h, 0h, 0h, 0h
	defb 0bbh, 0h, 0bbh, 0h, 0bbh, 0h, 22h, 0h, 22h, 0h, 66h, 0h, 66h, 0h, 0eeh, 0h
	defb 0h, 0h, 0h, 0h, 0h, 0h, 33h, 0cch, 77h, 0eeh, 66h, 66h, 77h, 0eeh, 66h, 66h
	defb 0h, 0h, 0h, 0h, 0h, 77h, 0h, 0ffh, 0ffh, 99h, 0ffh, 0h, 33h, 0h, 0ddh, 0cch
	defb 33h, 0cch, 0h, 11h, 44h, 33h, 88h, 11h, 0ffh, 0cch, 88h, 0h, 88h, 0h, 0h, 0h
	defb 0cch, 0ffh, 0cch, 33h, 88h, 11h, 0h, 0h, 0h, 0h, 0h, 0h, 0h, 0h, 0h, 0h
	defb 0h, 0h, 0h, 0h, 0h, 0h, 33h, 0cch, 77h, 0eeh, 66h, 66h, 77h, 0eeh, 66h, 66h
	defb 0h, 0h, 0h, 0h, 0h, 0h, 0h, 0h, 0eeh, 0h, 0ffh, 0ffh, 0h, 77h, 0eeh, 11h
	defb 33h, 0cch, 0h, 0h, 0h, 0h, 0h, 0h, 0h, 0h, 0h, 0h, 0h, 0h, 0h, 0h
	defb 0ffh, 0h, 33h, 88h, 11h, 0h, 0h, 88h, 0h, 88h, 0h, 88h, 22h, 88h, 11h, 0eeh
	defb 0h, 0h, 88h, 0h, 88h, 0h, 0ffh, 0cch, 88h, 11h, 44h, 33h, 0h, 11h, 33h, 0cch
	defb 0h, 0h, 0h, 0h, 0h, 0h, 0h, 0h, 0h, 0h, 88h, 11h, 0cch, 33h, 0cch, 0ffh
	defb 66h, 66h, 77h, 0eeh, 66h, 66h, 77h, 0eeh, 33h, 0cch, 0h, 0h, 0h, 0h, 0h, 0h
	defb 0ddh, 0cch, 33h, 0h, 0ffh, 0h, 0ffh, 99h, 0h, 0ffh, 0h, 77h, 0h, 0h, 0h, 0h
	defb 0h, 0h, 0h, 0h, 0h, 0h, 0h, 0h, 0h, 0h, 0h, 0h, 0h, 0h, 33h, 0cch
	defb 11h, 0eeh, 22h, 88h, 0h, 88h, 0h, 88h, 0h, 88h, 11h, 0h, 33h, 88h, 0ffh, 0h
	defb 66h, 66h, 77h, 0eeh, 66h, 66h, 77h, 0eeh, 33h, 0cch, 0h, 0h, 0h, 0h, 0h, 0h
	defb 0eeh, 11h, 0h, 77h, 0ffh, 0ffh, 0eeh, 0h, 0h, 0h, 0h, 0h, 0h, 0h, 0h, 0h
	defb 0h, 10h, 0h, 30h, 0h, 70h, 0h, 0f0h, 0h, 0f0h, 0h, 0f0h, 0h, 0e0h, 60h, 0e0h
	defb 20h, 0h, 60h, 0h, 0f0h, 0h, 50h, 80h, 50h, 80h, 0f0h, 80h, 0a0h, 80h, 0h, 0a0h
	defb 70h, 70h, 30h, 0f0h, 10h, 0f0h, 0h, 0f0h, 0h, 70h, 0h, 70h, 0h, 0f0h, 10h, 0e0h
	defb 0f0h, 60h, 0f0h, 0c0h, 0f0h, 80h, 0f0h, 0h, 0e0h, 0h, 0c0h, 0h, 80h, 0h, 0h, 0h
	defb 0h, 0h, 0h, 10h, 0h, 30h, 0h, 70h, 0h, 0f0h, 0h, 0f0h, 0h, 0f0h, 0h, 0e0h
	defb 0h, 0h, 20h, 0h, 60h, 0h, 0f0h, 0h, 50h, 80h, 50h, 80h, 0f0h, 80h, 0a0h, 80h
	defb 0h, 0e0h, 10h, 0f0h, 30h, 0f0h, 60h, 0f0h, 0h, 0f0h, 0h, 70h, 60h, 0f0h, 30h, 0f0h
	defb 0h, 80h, 0f0h, 0c0h, 0f0h, 0e0h, 0f0h, 0b0h, 0f0h, 0h, 0e0h, 0h, 0c0h, 0h, 80h, 0h
	defb 0h, 40h, 0h, 60h, 0h, 0f0h, 10h, 0a0h, 10h, 0a0h, 10h, 0f0h, 10h, 50h, 50h, 0h
	defb 80h, 0h, 0c0h, 0h, 0e0h, 0h, 0f0h, 0h, 0f0h, 0h, 0f0h, 0h, 70h, 0h, 70h, 60h
	defb 60h, 0f0h, 30h, 0f0h, 10h, 0f0h, 0h, 0f0h, 0h, 70h, 0h, 30h, 0h, 10h, 0h, 0h
	defb 0e0h, 0e0h, 0f0h, 0c0h, 0f0h, 80h, 0f0h, 0h, 0e0h, 0h, 0e0h, 0h, 0f0h, 0h, 70h, 80h
	defb 0h, 0h, 0h, 40h, 0h, 60h, 0h, 0f0h, 10h, 0a0h, 10h, 0a0h, 10h, 0f0h, 10h, 50h
	defb 0h, 0h, 80h, 0h, 0c0h, 0h, 0e0h, 0h, 0f0h, 0h, 0f0h, 0h, 0f0h, 0h, 70h, 0h
	defb 10h, 0h, 30h, 0f0h, 70h, 0f0h, 0d0h, 0f0h, 0h, 0f0h, 0h, 70h, 0h, 30h, 0h, 10h
	defb 70h, 0h, 0f0h, 80h, 0f0h, 0c0h, 0f0h, 60h, 0f0h, 0h, 0e0h, 0h, 0f0h, 60h, 0f0h, 0c0h
	defb 0h, 20h, 0h, 60h, 0h, 0f0h, 10h, 0d0h, 10h, 0d0h, 10h, 0f0h, 10h, 0a0h, 50h, 80h
	defb 40h, 0h, 60h, 0h, 0f0h, 0h, 0b0h, 80h, 0b0h, 80h, 0f0h, 80h, 50h, 80h, 10h, 0a0h
	defb 60h, 0f0h, 30h, 0f0h, 10h, 0f0h, 0h, 0f0h, 0h, 0f0h, 0h, 70h, 0h, 30h, 0h, 10h
	defb 0f0h, 60h, 0f0h, 0c0h, 0f0h, 80h, 0f0h, 0h, 0f0h, 0h, 0e0h, 0h, 0c0h, 0h, 80h, 0h
	defb 0h, 0h, 0h, 20h, 0h, 60h, 0h, 0f0h, 10h, 0d0h, 10h, 0d0h, 10h, 0f0h, 10h, 0a0h
	defb 0h, 0h, 40h, 0h, 60h, 0h, 0f0h, 0h, 0b0h, 80h, 0b0h, 80h, 0f0h, 80h, 50h, 80h
	defb 10h, 80h, 0h, 0f0h, 30h, 0f0h, 60h, 0f0h, 0h, 0f0h, 0h, 0f0h, 0h, 70h, 0h, 30h
	defb 10h, 80h, 0f0h, 0h, 0f0h, 0c0h, 0f0h, 60h, 0f0h, 0h, 0f0h, 0h, 0e0h, 0h, 0c0h, 0h
	defb 0h, 20h, 0h, 60h, 0h, 0f0h, 10h, 0f0h, 10h, 0f0h, 10h, 0f0h, 10h, 0f0h, 50h, 0f0h
	defb 40h, 0h, 60h, 0h, 0f0h, 0h, 0f0h, 80h, 0f0h, 80h, 0f0h, 80h, 0f0h, 80h, 0f0h, 0a0h
	defb 60h, 0f0h, 30h, 0f0h, 10h, 0f0h, 0h, 0f0h, 0h, 0f0h, 0h, 70h, 0h, 30h, 0h, 10h
	defb 0f0h, 60h, 0f0h, 0c0h, 0f0h, 80h, 0f0h, 0h, 0f0h, 0h, 0e0h, 0h, 0c0h, 0h, 80h, 0h
	defb 0h, 0h, 0h, 20h, 0h, 60h, 0h, 0f0h, 10h, 0f0h, 10h, 0f0h, 10h, 0f0h, 10h, 0f0h
	defb 0h, 0h, 40h, 0h, 60h, 0h, 0f0h, 0h, 0f0h, 80h, 0f0h, 80h, 0f0h, 80h, 0f0h, 80h
	defb 10h, 0f0h, 0h, 0f0h, 30h, 0f0h, 60h, 0f0h, 0h, 0f0h, 0h, 0f0h, 0h, 70h, 0h, 30h
	defb 0f0h, 80h, 0f0h, 0h, 0f0h, 0c0h, 0f0h, 60h, 0f0h, 0h, 0f0h, 0h, 0e0h, 0h, 0c0h, 0h
	defb 0fh, 0eh, 0fh, 0ch, 0fh, 8h, 0fh, 0h, 0fh, 0h, 0fh, 0h, 0fh, 1h, 9h, 1h
	defb 0dh, 0fh, 9h, 0fh, 0h, 0fh, 0ah, 7h, 0ah, 7h, 0h, 7h, 5h, 7h, 0fh, 5h
	defb 8h, 8h, 0ch, 0h, 0eh, 0h, 0fh, 0h, 0fh, 8h, 0fh, 8h, 0fh, 0h, 0eh, 1h
	defb 0h, 9h, 0h, 3h, 0h, 7h, 0h, 0fh, 1h, 0fh, 3h, 0fh, 7h, 0fh, 0fh, 0fh
	defb 0fh, 0fh, 0fh, 0eh, 0fh, 0ch, 0fh, 8h, 0fh, 0h, 0fh, 0h, 0fh, 0h, 0fh, 1h
	defb 0fh, 0fh, 0dh, 0fh, 9h, 0fh, 0h, 0fh, 0ah, 7h, 0ah, 7h, 0h, 7h, 5h, 7h
	defb 0fh, 1h, 0eh, 0h, 0ch, 0h, 9h, 0h, 0fh, 0h, 0fh, 8h, 9h, 0h, 0ch, 0h
	defb 0fh, 7h, 0h, 3h, 0h, 1h, 0h, 4h, 0h, 0fh, 1h, 0fh, 3h, 0fh, 7h, 0fh
	defb 0fh, 0bh, 0fh, 9h, 0fh, 0h, 0eh, 5h, 0eh, 5h, 0eh, 0h, 0eh, 0ah, 0ah, 0fh
	defb 7h, 0fh, 3h, 0fh, 1h, 0fh, 0h, 0fh, 0h, 0fh, 0h, 0fh, 8h, 0fh, 8h, 9h
	defb 9h, 0h, 0ch, 0h, 0eh, 0h, 0fh, 0h, 0fh, 8h, 0fh, 0ch, 0fh, 0eh, 0fh, 0fh
	defb 1h, 1h, 0h, 3h, 0h, 7h, 0h, 0fh, 1h, 0fh, 1h, 0fh, 0h, 0fh, 8h, 7h
	defb 0fh, 0fh, 0fh, 0bh, 0fh, 9h, 0fh, 0h, 0eh, 5h, 0eh, 5h, 0eh, 0h, 0eh, 0ah
	defb 0fh, 0fh, 7h, 0fh, 3h, 0fh, 1h, 0fh, 0h, 0fh, 0h, 0fh, 0h, 0fh, 8h, 0fh
	defb 0eh, 0fh, 0ch, 0h, 8h, 0h, 2h, 0h, 0fh, 0h, 0fh, 8h, 0fh, 0ch, 0fh, 0eh
	defb 8h, 0fh, 0h, 7h, 0h, 3h, 0h, 9h, 0h, 0fh, 1h, 0fh, 0h, 9h, 0h, 3h
	defb 0fh, 0dh, 0fh, 9h, 0fh, 0h, 0eh, 2h, 0eh, 2h, 0eh, 0h, 0eh, 5h, 0ah, 7h
	defb 0bh, 0fh, 9h, 0fh, 0h, 0fh, 4h, 7h, 4h, 7h, 0h, 7h, 0ah, 7h, 0eh, 5h
	defb 9h, 0h, 0ch, 0h, 0eh, 0h, 0fh, 0h, 0fh, 0h, 0fh, 8h, 0fh, 0ch, 0fh, 0eh
	defb 0h, 9h, 0h, 3h, 0h, 7h, 0h, 0fh, 0h, 0fh, 1h, 0fh, 3h, 0fh, 7h, 0fh
	defb 0fh, 0fh, 0fh, 0dh, 0fh, 9h, 0fh, 0h, 0eh, 2h, 0eh, 2h, 0eh, 0h, 0eh, 5h
	defb 0fh, 0fh, 0bh, 0fh, 9h, 0fh, 0h, 0fh, 4h, 7h, 4h, 7h, 0h, 7h, 0ah, 7h
	defb 0eh, 7h, 0fh, 0h, 0ch, 0h, 9h, 0h, 0fh, 0h, 0fh, 0h, 0fh, 8h, 0fh, 0ch
	defb 0eh, 7h, 0h, 0fh, 0h, 3h, 0h, 9h, 0h, 0fh, 0h, 0fh, 1h, 0fh, 3h, 0fh
	defb 0fh, 0dh, 0fh, 9h, 0fh, 0h, 0eh, 0h, 0eh, 0h, 0eh, 0h, 0eh, 0h, 0ah, 0h
	defb 0bh, 0fh, 9h, 0fh, 0h, 0fh, 0h, 7h, 0h, 7h, 0h, 7h, 0h, 7h, 0h, 5h
	defb 9h, 0h, 0ch, 0h, 0eh, 0h, 0fh, 0h, 0fh, 0h, 0fh, 8h, 0fh, 0ch, 0fh, 0eh
	defb 0h, 9h, 0h, 3h, 0h, 7h, 0h, 0fh, 0h, 0fh, 1h, 0fh, 3h, 0fh, 7h, 0fh
	defb 0fh, 0fh, 0fh, 0dh, 0fh, 9h, 0fh, 0h, 0eh, 0h, 0eh, 0h, 0eh, 0h, 0eh, 0h
	defb 0fh, 0fh, 0bh, 0fh, 9h, 0fh, 0h, 0fh, 0h, 7h, 0h, 7h, 0h, 7h, 0h, 7h
	defb 0eh, 0h, 0fh, 0h, 0ch, 0h, 9h, 0h, 0fh, 0h, 0fh, 0h, 0fh, 8h, 0fh, 0ch
	defb 0h, 7h, 0h, 0fh, 0h, 3h, 0h, 9h, 0h, 0fh, 0h, 0fh, 1h, 0fh, 3h, 0fh
	defb 0h, 0h, 11h, 88h, 33h, 0cch, 66h, 66h, 66h, 66h, 66h, 66h, 33h, 0cch, 11h, 0cch
	defb 0h, 0h, 11h, 88h, 33h, 0cch, 66h, 66h, 66h, 66h, 66h, 66h, 33h, 0cch, 33h, 88h
	defb 0h, 0b8h, 0h, 70h, 10h, 0f0h, 30h, 90h, 30h, 60h, 70h, 0f0h, 70h, 30h, 60h, 10h
	defb 0d1h, 0h, 0e0h, 0h, 0f0h, 80h, 90h, 0c0h, 60h, 0c0h, 0f0h, 0e0h, 0c0h, 0e0h, 80h, 60h
	defb 0h, 33h, 0h, 77h, 0h, 0eeh, 11h, 0ffh, 0h, 0ddh, 33h, 77h, 55h, 0bbh, 77h, 77h
	defb 88h, 0h, 66h, 0h, 0ffh, 88h, 0bbh, 44h, 0ffh, 0eeh, 0bbh, 0aah, 0eeh, 0eeh, 77h, 0bbh
	defb 0aah, 0aah, 0ffh, 0ffh, 0ffh, 0ffh, 0bbh, 77h, 0ddh, 0eeh, 0aah, 0bbh, 77h, 66h, 11h, 0bbh
	defb 0aah, 0ffh, 77h, 0ffh, 0eeh, 0ddh, 0ffh, 0eeh, 0ffh, 0ddh, 66h, 0aah, 0ddh, 44h, 0aah, 88h
	defb 0h, 0h, 0h, 0h, 0h, 0h, 0h, 0h, 11h, 11h, 33h, 22h, 11h, 22h, 11h, 22h
	defb 0h, 0h, 0h, 0h, 0h, 0h, 0h, 0h, 88h, 0cch, 55h, 22h, 55h, 22h, 55h, 22h
	defb 11h, 22h, 11h, 22h, 33h, 99h, 0h, 0h, 0h, 0h, 0h, 0h, 0h, 0h, 0h, 0h
	defb 55h, 22h, 55h, 22h, 88h, 0cch, 0h, 0h, 0h, 0h, 0h, 0h, 0h, 0h, 0h, 0h
	defb 0h, 0h, 0h, 0h, 0h, 0h, 0h, 0h, 33h, 11h, 44h, 0aah, 0h, 0aah, 11h, 22h
	defb 0h, 0h, 0h, 0h, 0h, 0h, 0h, 0h, 88h, 0cch, 55h, 22h, 55h, 22h, 55h, 22h
	defb 22h, 22h, 44h, 22h, 77h, 99h, 0h, 0h, 0h, 0h, 0h, 0h, 0h, 0h, 0h, 0h
	defb 55h, 22h, 55h, 22h, 88h, 0cch, 0h, 0h, 0h, 0h, 0h, 0h, 0h, 0h, 0h, 0h
	defb 0h, 0h, 0h, 0h, 0h, 0h, 0h, 0h, 33h, 11h, 55h, 22h, 55h, 22h, 55h, 22h
	defb 0h, 0h, 0h, 0h, 0h, 0h, 0h, 0h, 88h, 0cch, 55h, 22h, 55h, 22h, 55h, 22h
	defb 77h, 0aah, 11h, 22h, 11h, 11h, 0h, 0h, 0h, 0h, 0h, 0h, 0h, 0h, 0h, 0h
	defb 55h, 22h, 55h, 22h, 88h, 0cch, 0h, 0h, 0h, 0h, 0h, 0h, 0h, 0h, 0h, 0h
	defb 0h, 0h, 0h, 0h, 0h, 0h, 0h, 0h, 33h, 11h, 44h, 0aah, 44h, 0aah, 33h, 22h
	defb 0h, 0h, 0h, 0h, 0h, 0h, 0h, 0h, 88h, 0cch, 55h, 22h, 55h, 22h, 55h, 22h
	defb 44h, 0aah, 44h, 0aah, 33h, 11h, 0h, 0h, 0h, 0h, 0h, 0h, 0h, 0h, 0h, 0h
	defb 55h, 22h, 55h, 22h, 88h, 0cch, 0h, 0h, 0h, 0h, 0h, 0h, 0h, 0h, 0h, 0h
	defb 11h, 0cch, 0h, 0cch, 0h, 66h, 0h, 66h, 0h, 0h, 0h, 77h, 0h, 77h, 0h, 11h
	defb 77h, 0h, 33h, 0h, 33h, 0h, 66h, 0h, 0cch, 0h, 0h, 0h, 88h, 0h, 88h, 0h
	defb 0h, 0h, 0h, 33h, 0h, 77h, 0h, 55h, 0h, 55h, 0h, 77h, 0h, 33h, 0h, 0h
	defb 0h, 0h, 0cch, 0h, 0eeh, 0h, 66h, 0h, 66h, 0h, 0eeh, 0h, 0cch, 0h, 0h, 0h
	defb 0h, 0h, 0h, 0h, 0h, 0h, 0h, 0h, 0eeh, 0h, 0ffh, 0h, 99h, 88h, 0h, 0bbh
	defb 0h, 0h, 0h, 0h, 0h, 0h, 0h, 0h, 0h, 0h, 33h, 0cch, 77h, 0eeh, 66h, 66h
	defb 0h, 77h, 33h, 66h, 0ffh, 66h, 0cch, 0h, 88h, 0h, 0h, 0h, 0h, 0h, 0h, 0h
	defb 77h, 0eeh, 66h, 66h, 33h, 0cch, 0h, 0h, 0h, 0h, 0h, 0h, 0h, 0h, 0h, 0h
	defb 0fh, 0fh, 0fh, 0fh, 0fh, 3ch, 0fh, 78h, 1eh, 0f0h, 0eh, 0f0h, 3ch, 70h, 3ch, 0b0h
	defb 3ch, 0fh, 0f0h, 87h, 0f0h, 0c3h, 0f0h, 0e1h, 0f0h, 0e1h, 0f0h, 0d0h, 0f0h, 70h, 0d0h, 0c0h
	defb 58h, 0b0h, 68h, 0d0h, 78h, 50h, 78h, 80h, 3ch, 0d0h, 1eh, 0d0h, 0fh, 0d0h, 0fh, 58h
	defb 70h, 30h, 0c0h, 70h, 20h, 70h, 0e0h, 0f0h, 0f0h, 0e1h, 0f0h, 87h, 0e1h, 0fh, 87h, 0fh

Ascii_: public Ascii_
	defb 000H,000H,000H,000H,000H,000H,000H,000H
	defb 018H,018H,018H,018H,018H,000H,018H,000H
	defb 036H,036H,036H,000H,000H,000H,000H,000H
	defb 006H,037H,03eH,077H,03eH,076H,030H,000H
	defb 008H,03fH,048H,03eH,009H,07eH,008H,000H
	defb 000H,032H,054H,068H,016H,02aH,04cH,000H
	defb 038H,06cH,06cH,038H,06bH,066H,03bH,000H
	defb 00cH,018H,030H,000H,000H,000H,000H,000H
	defb 00cH,018H,030H,030H,030H,018H,00cH,000H
	defb 030H,018H,00cH,00cH,00cH,018H,030H,000H
	defb 008H,02aH,01cH,07fH,01cH,02aH,008H,000H
	defb 000H,018H,018H,07eH,018H,018H,000H,000H
	defb 000H,000H,000H,000H,018H,018H,030H,000H
	defb 000H,000H,000H,07eH,000H,000H,000H,000H
	defb 000H,000H,000H,000H,000H,018H,018H,000H
	defb 000H,003H,006H,00cH,018H,030H,060H,000H
	defb 03eH,063H,067H,06bH,073H,063H,03eH,000H
	defb 018H,078H,018H,018H,018H,018H,07eH,000H
	defb 03eH,063H,007H,01eH,03cH,070H,07fH,000H
	defb 03eH,063H,003H,01eH,003H,063H,03eH,000H
	defb 006H,00eH,01eH,036H,066H,07fH,006H,000H
	defb 07fH,060H,07eH,003H,003H,063H,03eH,000H
	defb 01eH,030H,060H,07eH,063H,063H,03eH,000H
	defb 07fH,063H,006H,00cH,018H,018H,018H,000H
	defb 03eH,063H,063H,03eH,063H,063H,03eH,000H
	defb 03eH,063H,063H,03fH,003H,063H,03eH,000H
	defb 000H,000H,018H,000H,000H,018H,000H,000H
	defb 000H,000H,018H,000H,000H,018H,030H,000H
	defb 00cH,018H,030H,060H,030H,018H,00cH,000H
	defb 000H,000H,07eH,000H,07eH,000H,000H,000H
	defb 030H,018H,00cH,006H,00cH,018H,030H,000H
	defb 03eH,063H,003H,00eH,018H,000H,018H,000H
	defb 01eH,021H,04dH,055H,04eH,020H,01eH,000H
	defb 01cH,036H,063H,063H,07fH,063H,063H,000H
	defb 07eH,063H,063H,07eH,063H,063H,07eH,000H
	defb 01eH,033H,060H,060H,060H,033H,01eH,000H
	defb 07cH,066H,063H,063H,063H,066H,07cH,000H
	defb 07eH,060H,060H,07eH,060H,060H,07eH,000H
	defb 07eH,060H,060H,07eH,060H,060H,060H,000H
	defb 01eH,033H,060H,06fH,063H,033H,01fH,000H
	defb 063H,063H,063H,07fH,063H,063H,063H,000H
	defb 07eH,018H,018H,018H,018H,018H,07eH,000H
	defb 006H,006H,006H,006H,006H,066H,03cH,000H
	defb 063H,066H,06cH,078H,06cH,066H,063H,000H
	defb 060H,060H,060H,060H,060H,060H,07eH,000H
	defb 07eH,06bH,06bH,06bH,06bH,06bH,06bH,000H
	defb 063H,073H,07bH,07fH,06fH,067H,063H,000H
	defb 03eH,063H,063H,063H,063H,063H,03eH,000H
	defb 07eH,063H,063H,063H,07eH,060H,060H,000H
	defb 03eH,063H,063H,063H,06bH,066H,03bH,000H
	defb 07eH,063H,063H,067H,07cH,06eH,067H,000H
	defb 03eH,063H,060H,03eH,003H,063H,03eH,000H
	defb 07eH,018H,018H,018H,018H,018H,018H,000H
	defb 063H,063H,063H,063H,063H,063H,03eH,000H
	defb 063H,063H,063H,036H,036H,01cH,01cH,000H
	defb 063H,06bH,06bH,06bH,06bH,06bH,07eH,000H
	defb 063H,063H,036H,01cH,036H,063H,063H,000H
	defb 066H,066H,066H,03cH,018H,018H,018H,000H
	defb 07fH,006H,00cH,018H,030H,060H,07fH,000H
	defb 03cH,020H,020H,020H,020H,020H,03cH,000H
	defb 022H,022H,014H,03eH,008H,03eH,008H,000H
	defb 03cH,004H,004H,004H,004H,004H,03cH,000H
	defb 008H,014H,022H,000H,000H,000H,000H,000H
	defb 000H,000H,000H,000H,000H,000H,07eH,000H
