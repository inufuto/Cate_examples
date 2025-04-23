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
	defb	00h, 0aah, 44h, 0aah, 00h, 0aah, 11h, 0aah
	defb	00h, 0eeh, 0eeh, 0eeh, 00h, 0bbh, 0bbh, 0bbh
	defb	00h, 0feh, 0feh, 0feh, 0feh, 0feh, 0feh, 0feh
	defb	00h, 0eeh, 0eeh, 0eeh, 0eeh, 0eeh, 0eeh, 00h
	defb	00h, 0e0h, 0e0h, 0e0h, 0e0h, 0e0h, 0e0h, 00h
	defb	00h, 00h, 00h, 00h, 00h, 00h, 00h, 7eh
	defb	00h, 01h, 01h, 01h, 01h, 01h, 01h, 00h
	defb	00h, 00h, 00h, 00h, 00h, 00h, 00h, 0ffh
	defb	0ffh, 00h, 00h, 00h, 00h, 00h, 00h, 00h

ColorChars_: public ColorChars_
	; fort
	defb 0h, 0h, 0h, 0h, 0h, 0h, 0h, 0h, 0h, 0h, 0h, 0h, 0h, 0h, 0h, 0h
	defb 0h, 0h, 0h, 0h, 0h, 0h, 0h, 0h, 0h, 0h, 0h, 0h, 0h, 0h, 33h, 0eeh
	defb 0h, 22h, 0h, 66h, 11h, 0ffh, 33h, 0aah, 33h, 0ffh, 77h, 0aah, 77h, 0ffh, 0h, 0h
	defb 0h, 0h, 0h, 0h, 88h, 0h, 0h, 0h, 88h, 0h, 0h, 0h, 88h, 0h, 0h, 0h
	defb 0h, 0h, 0h, 0h, 0h, 11h, 0h, 55h, 0h, 55h, 0h, 55h, 0h, 11h, 11h, 0eeh
	defb 0h, 0h, 0eeh, 0cch, 66h, 11h, 66h, 0ddh, 0cch, 11h, 11h, 0cch, 33h, 0eeh, 33h, 0eeh
	defb 0cch, 0ddh, 0h, 0cch, 0bbh, 11h, 0bbh, 66h, 0bbh, 66h, 0h, 10h, 0bbh, 10h, 0bbh, 66h
	defb 88h, 0h, 22h, 0h, 0bbh, 0h, 11h, 88h, 0d1h, 88h, 0e0h, 88h, 0e0h, 0h, 0c0h, 88h
	defb 22h, 55h, 33h, 0ddh, 33h, 0cch, 0h, 0h, 77h, 0ffh, 66h, 66h, 0ffh, 0ffh, 0eeh, 77h
	defb 0ddh, 0cch, 0cch, 0h, 11h, 0eeh, 0h, 0h, 0ffh, 0ffh, 0h, 11h, 0ffh, 0ffh, 99h, 0eeh
	defb 88h, 0eeh, 77h, 0h, 0ffh, 99h, 0h, 0h, 0ffh, 0ffh, 0cch, 0h, 0ffh, 0ffh, 77h, 99h
	defb 11h, 88h, 0h, 0h, 0ffh, 0cch, 0h, 0h, 0ffh, 0eeh, 11h, 0eeh, 0ffh, 0ffh, 0eeh, 77h
	defb 0h, 0h, 0h, 0h, 0h, 0h, 0h, 0h, 0h, 0h, 0h, 0h, 0h, 0h, 0h, 0h
	defb 0h, 0ch, 1h, 0ch, 7h, 0fh, 1h, 0fh, 0fh, 0fh, 0h, 0h, 3h, 0eh, 7h, 0eh
	defb 0h, 0h, 0h, 0h, 0h, 0h, 8h, 0h, 8h, 0h, 0h, 0h, 0h, 0h, 0h, 0h
	defb 0h, 0h, 0h, 0h, 0h, 0h, 0h, 0h, 0h, 0h, 0h, 0h, 0h, 0h, 0h, 0h
	defb 0h, 0h, 1h, 0fh, 1h, 1h, 3h, 0fh, 3h, 0c3h, 3h, 0c3h, 7h, 0fh, 4h, 0h
	defb 0h, 0h, 0fh, 0fh, 0fh, 0bh, 0ah, 0bh, 0ah, 0bh, 0ah, 0ah, 0fh, 0bh, 4h, 0h
	defb 0h, 33h, 0fh, 77h, 0h, 77h, 0fh, 77h, 1h, 33h, 0fh, 0ch, 0h, 0fh, 0fh, 6h
	defb 88h, 0h, 0cdh, 8h, 0cch, 0h, 0cdh, 0ch, 89h, 0ch, 5h, 0ch, 0dh, 0eh, 7h, 2h
	defb 4h, 0eh, 0h, 0h, 0fh, 0fh, 8h, 0h, 30h, 0f0h, 40h, 10h, 50h, 80h, 30h, 0f0h
	defb 7h, 0fh, 0h, 0h, 0fh, 0fh, 0h, 1h, 0f0h, 0c0h, 80h, 20h, 10h, 0a0h, 0f0h, 0c0h
	defb 0fh, 0fh, 0h, 0h, 0fh, 0fh, 8h, 0h, 30h, 0f0h, 40h, 10h, 50h, 80h, 30h, 0f0h
	defb 0fh, 0eh, 0h, 0h, 0fh, 0fh, 0h, 1h, 0f0h, 0c0h, 80h, 20h, 10h, 0a0h, 0f0h, 0c0h
	; 16dot
	defb 0h, 0ffh, 11h, 0ffh, 11h, 0efh, 11h, 0ffh, 0h, 0ffh, 0h, 11h, 33h, 0f8h, 11h, 0f8h
	defb 0cch, 0h, 0eeh, 0h, 0eh, 0h, 0eh, 0h, 0eeh, 0h, 0cch, 0h, 0f1h, 0h, 0e0h, 0h
	defb 0h, 71h, 11h, 0bbh, 0h, 0bbh, 0h, 0h, 0h, 0eeh, 11h, 88h, 33h, 0h, 33h, 88h
	defb 0eeh, 0h, 0c8h, 0h, 0h, 0h, 0h, 0h, 66h, 0h, 77h, 0h, 33h, 0h, 33h, 88h
	defb 0h, 0ffh, 11h, 0ffh, 11h, 0efh, 11h, 0ffh, 0h, 0ffh, 0h, 11h, 11h, 0fch, 0h, 0fch
	defb 0cch, 0h, 0eeh, 0h, 0eh, 0h, 0eh, 0h, 0eeh, 0h, 0cch, 0h, 0e0h, 0h, 0e0h, 0h
	defb 0h, 30h, 0h, 0ddh, 0h, 55h, 0h, 0h, 0h, 0ddh, 0h, 55h, 0h, 33h, 0h, 33h
	defb 0ffh, 0h, 0cch, 0h, 88h, 0h, 0h, 0h, 88h, 0h, 88h, 0h, 0h, 0h, 88h, 0h
	defb 0h, 33h, 0h, 77h, 0h, 7h, 0h, 7h, 0h, 77h, 0h, 33h, 0h, 0f8h, 0h, 70h
	defb 0ffh, 0h, 0ffh, 88h, 7fh, 88h, 0ffh, 88h, 0ffh, 0h, 88h, 0h, 0f1h, 0cch, 0f1h, 88h
	defb 33h, 0b8h, 0h, 0b8h, 0h, 0h, 0h, 11h, 0h, 66h, 0h, 0eeh, 0h, 0cch, 11h, 0cch
	defb 0c0h, 0h, 0c0h, 0cch, 0h, 0cch, 88h, 0cch, 77h, 0h, 11h, 88h, 0h, 0cch, 11h, 0cch
	defb 0h, 33h, 0h, 77h, 0h, 7h, 0h, 7h, 0h, 77h, 0h, 33h, 0h, 30h, 0h, 30h
	defb 0ffh, 0h, 0ffh, 88h, 7fh, 88h, 0ffh, 88h, 0ffh, 0h, 88h, 0h, 0f3h, 88h, 0f3h, 0h
	defb 11h, 0b8h, 0h, 30h, 0h, 0h, 0h, 0h, 0h, 11h, 0h, 11h, 0h, 0h, 0h, 11h
	defb 80h, 0h, 0eeh, 0h, 0cch, 0h, 0h, 0h, 0bbh, 0h, 0aah, 0h, 0cch, 0h, 0cch, 0h
	defb 0h, 33h, 0h, 77h, 0h, 0ffh, 0h, 0ffh, 0eeh, 8fh, 66h, 0cfh, 0h, 77h, 33h, 0f0h
	defb 0cch, 0h, 0eeh, 0h, 0ffh, 0h, 0ffh, 0h, 1fh, 0h, 3fh, 77h, 0eeh, 66h, 0f0h, 0h
	defb 33h, 70h, 33h, 70h, 11h, 11h, 11h, 44h, 0h, 0cch, 11h, 22h, 11h, 0eeh, 0h, 0cch
	defb 0e0h, 66h, 0e0h, 66h, 88h, 0h, 44h, 88h, 77h, 88h, 33h, 0h, 0h, 0h, 0h, 0h
	defb 0h, 33h, 0h, 77h, 0h, 0ffh, 0h, 0ffh, 0h, 8fh, 0eeh, 0cfh, 66h, 77h, 0h, 0f0h
	defb 0cch, 0h, 0eeh, 0h, 0ffh, 0h, 0ffh, 0h, 1fh, 77h, 3fh, 66h, 0eeh, 0h, 0f0h, 66h
	defb 33h, 70h, 33h, 70h, 33h, 11h, 11h, 22h, 11h, 0eeh, 0h, 0cch, 0h, 0h, 0h, 0h
	defb 0e0h, 66h, 0e0h, 0h, 88h, 0h, 22h, 0h, 33h, 0h, 44h, 88h, 77h, 88h, 33h, 0h
	defb 0h, 33h, 0h, 77h, 0h, 0ffh, 0h, 0ffh, 0h, 0ffh, 0eeh, 0ffh, 66h, 77h, 0h, 0f0h
	defb 0cch, 0h, 0eeh, 0h, 0ffh, 0h, 0ffh, 0h, 0ffh, 77h, 0ffh, 66h, 0eeh, 0h, 0f0h, 66h
	defb 66h, 0f0h, 66h, 70h, 0h, 70h, 0h, 0h, 11h, 22h, 11h, 0eeh, 0h, 0h, 0h, 0h
	defb 0f0h, 66h, 0e0h, 0h, 0e0h, 0h, 0h, 0h, 33h, 0h, 33h, 0h, 44h, 88h, 77h, 88h
	defb 0h, 33h, 0h, 77h, 0h, 0ffh, 0h, 0ffh, 0eeh, 0ffh, 66h, 0ffh, 0h, 77h, 66h, 0f0h
	defb 0cch, 0h, 0eeh, 0h, 0ffh, 0h, 0ffh, 0h, 0ffh, 0h, 0ffh, 77h, 0eeh, 66h, 0f0h, 0h
	defb 66h, 0f0h, 0h, 70h, 0h, 70h, 0h, 0h, 0h, 0cch, 0h, 0cch, 11h, 22h, 11h, 0eeh
	defb 0f0h, 66h, 0e0h, 66h, 0e0h, 0h, 0h, 0h, 44h, 88h, 77h, 88h, 0h, 0h, 0h, 0h
	defb 0h, 7h, 0h, 0fh, 1h, 0fh, 1h, 0fh, 1h, 0fh, 0h, 0h, 1h, 0bh, 1h, 8h
	defb 8h, 0h, 0ch, 0h, 0c2h, 0h, 0c2h, 0h, 0eh, 0h, 0h, 0h, 0ch, 0h, 0h, 0h
	defb 0h, 11h, 1h, 0bh, 0h, 0bh, 0h, 0h, 0h, 0eh, 1h, 8h, 3h, 0h, 3h, 8h
	defb 0eeh, 0h, 8h, 0h, 0h, 0h, 0h, 0h, 6h, 0h, 7h, 0h, 3h, 0h, 3h, 8h
	defb 0h, 7h, 0h, 0fh, 1h, 0fh, 1h, 0fh, 1h, 0fh, 0h, 0h, 0h, 0dh, 0h, 0ch
	defb 8h, 0h, 0ch, 0h, 0c2h, 0h, 0c2h, 0h, 0eh, 0h, 0h, 0h, 0ch, 0h, 0h, 0h
	defb 0h, 0h, 0h, 0dh, 0h, 5h, 0h, 0h, 0h, 0dh, 0h, 5h, 0h, 3h, 0h, 3h
	defb 0ffh, 0h, 0ch, 0h, 8h, 0h, 0h, 0h, 8h, 0h, 8h, 0h, 0h, 0h, 8h, 0h
	defb 0h, 1h, 0h, 3h, 0h, 34h, 0h, 34h, 0h, 7h, 0h, 0h, 0h, 3h, 0h, 3h
	defb 0eh, 0h, 0fh, 0h, 0fh, 8h, 0fh, 8h, 0fh, 8h, 0h, 0h, 0dh, 8h, 0dh, 8h
	defb 33h, 8bh, 0h, 8bh, 0h, 0h, 0h, 1h, 0h, 6h, 0h, 0eh, 0h, 0ch, 1h, 0ch
	defb 0ch, 0h, 0ch, 0ch, 0h, 0ch, 8h, 0ch, 7h, 0h, 1h, 8h, 0h, 0ch, 1h, 0ch
	defb 0h, 1h, 0h, 3h, 0h, 34h, 0h, 34h, 0h, 7h, 0h, 0h, 0h, 3h, 0h, 3h
	defb 0eh, 0h, 0fh, 0h, 0fh, 8h, 0fh, 8h, 0fh, 8h, 0h, 0h, 0bh, 0h, 0bh, 0h
	defb 11h, 8bh, 0h, 2h, 0h, 0h, 0h, 0h, 0h, 1h, 0h, 1h, 0h, 0h, 0h, 1h
	defb 0h, 0h, 0eh, 0h, 0ch, 0h, 0h, 0h, 0bh, 0h, 0ah, 0h, 0ch, 0h, 0ch, 0h
	defb 0h, 3h, 0h, 7h, 0h, 0fh, 0h, 1eh, 6h, 1eh, 6h, 0fh, 0h, 0h, 3h, 7h
	defb 0ch, 0h, 0eh, 0h, 0fh, 0h, 87h, 0h, 87h, 0h, 0fh, 6h, 0h, 6h, 0fh, 0h
	defb 3h, 7h, 13h, 7h, 11h, 1h, 11h, 4h, 0h, 0ch, 1h, 2h, 1h, 0eh, 0h, 0ch
	defb 0fh, 6h, 0eh, 6h, 8h, 0h, 4h, 8h, 7h, 8h, 3h, 0h, 0h, 0h, 0h, 0h
	defb 0h, 3h, 0h, 7h, 0h, 0fh, 0h, 1eh, 0h, 1eh, 6h, 0fh, 6h, 0h, 0h, 0fh
	defb 0ch, 0h, 0eh, 0h, 0fh, 0h, 87h, 0h, 87h, 6h, 0fh, 6h, 0h, 0h, 0fh, 6h
	defb 3h, 7h, 3h, 7h, 13h, 1h, 11h, 2h, 11h, 6h, 0h, 0ch, 0h, 0h, 0h, 0h
	defb 0fh, 6h, 0eh, 0h, 8h, 0h, 2h, 0h, 3h, 0h, 4h, 8h, 7h, 8h, 3h, 0h
	defb 0h, 3h, 0h, 7h, 0h, 0fh, 0h, 0fh, 0h, 0fh, 6h, 0fh, 6h, 0h, 0h, 0fh
	defb 0ch, 0h, 0eh, 0h, 0fh, 0h, 0fh, 0h, 0fh, 6h, 0fh, 6h, 0h, 0h, 0fh, 6h
	defb 6h, 0fh, 6h, 0h, 0h, 7h, 0h, 0h, 1h, 2h, 1h, 0eh, 0h, 0h, 0h, 0h
	defb 0fh, 6h, 0h, 0h, 0eh, 0h, 0h, 0h, 3h, 0h, 3h, 0h, 4h, 8h, 7h, 8h
	defb 0h, 3h, 0h, 7h, 0h, 0fh, 0h, 0fh, 6h, 0fh, 6h, 0fh, 0h, 0h, 6h, 0fh
	defb 0ch, 0h, 0eh, 0h, 0fh, 0h, 0fh, 0h, 0fh, 0h, 0fh, 6h, 0h, 6h, 0fh, 0h
	defb 6h, 0fh, 0h, 0h, 0h, 7h, 0h, 0h, 0h, 0ch, 0h, 0ch, 1h, 2h, 1h, 0eh
	defb 0fh, 6h, 0h, 6h, 0eh, 0h, 0h, 0h, 4h, 8h, 7h, 8h, 0h, 0h, 0h, 0h
	defb 0h, 10h, 20h, 10h, 30h, 30h, 30h, 0e0h, 20h, 40h, 0e0h, 11h, 70h, 77h, 30h, 0b3h
	defb 0h, 40h, 90h, 0c0h, 0f0h, 80h, 0f0h, 90h, 60h, 0f0h, 0h, 0e0h, 98h, 0c0h, 0b8h, 80h
	defb 10h, 0b3h, 30h, 0h, 0e0h, 20h, 60h, 0e0h, 30h, 0e0h, 10h, 0b0h, 10h, 10h, 0h, 10h
	defb 0dch, 0c0h, 0cch, 0f0h, 0h, 0e0h, 40h, 80h, 0e0h, 0c0h, 0f0h, 0c0h, 80h, 0c0h, 0h, 0h
	defb 0h, 0h, 0h, 0h, 0h, 80h, 0h, 0e0h, 0h, 70h, 0h, 70h, 0h, 60h, 0h, 30h
	defb 0h, 20h, 0h, 70h, 0h, 70h, 0h, 0f0h, 90h, 0d0h, 0f0h, 0c0h, 70h, 80h, 30h, 80h
	defb 0h, 30h, 10h, 0f0h, 0f0h, 30h, 70h, 80h, 30h, 0e0h, 10h, 0f0h, 0h, 0f0h, 0h, 60h
	defb 10h, 22h, 80h, 22h, 91h, 0ffh, 33h, 0bbh, 77h, 99h, 11h, 99h, 91h, 88h, 33h, 0h
	defb 0h, 0h, 0h, 0h, 0h, 10h, 80h, 70h, 80h, 0f0h, 0d0h, 0f0h, 0f0h, 0d0h, 70h, 90h
	defb 60h, 0h, 0e0h, 0h, 0c0h, 0h, 0c0h, 0h, 0c0h, 0h, 80h, 0h, 80h, 0e0h, 0b0h, 0c0h
	defb 70h, 10h, 20h, 54h, 0h, 0cch, 99h, 0cch, 0ffh, 88h, 11h, 98h, 11h, 10h, 33h, 88h
	defb 0f0h, 80h, 0f0h, 80h, 30h, 0h, 0e0h, 0h, 0c0h, 0h, 0c0h, 0h, 0e0h, 0h, 0f0h, 0h
	defb 0h, 40h, 0h, 91h, 30h, 91h, 70h, 33h, 0e0h, 0h, 70h, 0f0h, 30h, 0f0h, 0h, 0e0h
	defb 66h, 44h, 0cch, 0eeh, 99h, 0eeh, 0ffh, 0ffh, 77h, 0ddh, 22h, 11h, 66h, 11h, 10h, 0c0h
	defb 0h, 60h, 0h, 20h, 0h, 30h, 0h, 30h, 0h, 20h, 0h, 0h, 0h, 0h, 0h, 0h
	defb 70h, 0c0h, 0e0h, 0e0h, 0c0h, 0e0h, 0h, 60h, 0h, 70h, 0h, 30h, 0h, 30h, 0h, 20h
	defb 77h, 0ffh, 66h, 0h, 0ffh, 0h, 0ffh, 30h, 99h, 0b8h, 0h, 98h, 20h, 10h, 30h, 80h
	defb 30h, 80h, 0h, 0c0h, 0f0h, 0e0h, 0f0h, 0f0h, 0f0h, 0h, 80h, 0h, 80h, 0h, 0c0h, 0h
	defb 70h, 0c0h, 0f0h, 0f0h, 0e0h, 30h, 0c0h, 10h, 80h, 0h, 0h, 0h, 0h, 0h, 0h, 0h
	defb 0c0h, 0h, 0c0h, 0h, 0e0h, 0h, 0e0h, 0h, 60h, 0h, 0h, 0h, 0h, 0h, 0h, 0h

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
