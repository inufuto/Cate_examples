cseg

LogoPattern_: public LogoPattern_
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
BarrierPattern_: public BarrierPattern_
	defb	00h, 00h, 00h, 00h, 0ffh, 00h, 00h, 00h
	defb	08h, 08h, 08h, 08h, 08h, 08h, 08h, 08h
MapPattern_: public MapPattern_
	defb	0ffh, 0ffh, 0ffh, 0ffh, 0ffh, 0ffh, 0ffh, 0ffh
	defb	03h, 03h, 03h, 03h, 03h, 03h, 0ffh, 0ffh
FighterBulletPattern_: public FighterBulletPattern_
	defb	01h, 01h, 01h, 01h, 01h, 01h, 01h, 01h
	defb	00h, 02h, 04h, 08h, 10h, 20h, 40h, 00h
	defb	00h, 00h, 00h, 00h, 00h, 00h, 00h, 0ffh
	defb	00h, 40h, 20h, 10h, 08h, 04h, 02h, 00h
EnemyBulletPattern_: public EnemyBulletPattern_
	defb	00h, 00h, 18h, 3ch, 3ch, 18h, 00h, 00h

FortPattern_: public FortPattern_

	; fort
	defb 0h, 0h, 0h, 0h, 0h, 0h, 0h, 7h, 0h, 3h, 1h, 0h, 1h, 1ah, 1h, 29h
	defb 0h, 0h, 0h, 0h, 0h, 0h, 0eh, 0fh, 0eh, 0h, 0h, 0fh, 0h, 0h, 33h, 70h
	defb 0h, 0c0h, 10h, 0e0h, 30h, 0f0h, 38h, 0f0h, 10h, 0e0h, 0ah, 0c0h, 0h, 11h, 0f0h, 0d1h
	defb 30h, 0h, 70h, 80h, 0f0h, 0c0h, 0f0h, 0c1h, 70h, 80h, 30h, 5h, 88h, 0h, 0b8h, 0f0h
	defb 0h, 0h, 0h, 0h, 0h, 0h, 0fh, 7h, 0h, 7h, 0fh, 0h, 0h, 0h, 0e0h, 0cch
	defb 0h, 0h, 0h, 0h, 0h, 0h, 0eh, 0h, 0ch, 0h, 0h, 8h, 49h, 8h, 85h, 8h
	defb 1h, 8h, 1h, 9h, 0h, 0h, 0h, 0ffh, 0h, 0h, 10h, 80h, 30h, 0c0h, 30h, 0c0h
	defb 77h, 88h, 77h, 89h, 33h, 5h, 4h, 0h, 0h, 0eeh, 0h, 0eeh, 0h, 0eeh, 0h, 0eeh
	defb 0h, 11h, 9h, 19h, 0bh, 0ch, 7h, 0eh, 0fh, 0fh, 0fh, 0fh, 7h, 0eh, 0bh, 0ch
	defb 88h, 0h, 89h, 9h, 3h, 0dh, 7h, 0eh, 0fh, 0fh, 0fh, 0fh, 7h, 0eh, 3h, 0dh
	defb 11h, 0eeh, 19h, 0eeh, 0ah, 0cch, 0h, 2h, 77h, 0h, 77h, 0h, 77h, 0h, 77h, 0h
	defb 1h, 8h, 9h, 8h, 0h, 0h, 0ffh, 0h, 0h, 0h, 10h, 80h, 30h, 0c0h, 30h, 0c0h
	defb 10h, 80h, 0h, 10h, 0fh, 1ch, 0fh, 1ch, 0h, 0h, 3bh, 5h, 3bh, 5h, 3bh, 5h
	defb 0h, 0h, 0c1h, 0h, 0c0h, 0h, 0c0h, 0h, 0h, 0h, 77h, 7h, 77h, 7h, 77h, 7h
	defb 1h, 19h, 0h, 0h, 0h, 0h, 0h, 0h, 0h, 0h, 0bh, 1dh, 0bh, 1dh, 0bh, 1dh
	defb 89h, 8h, 0h, 0h, 0h, 0h, 0h, 0h, 0h, 0h, 8bh, 0dh, 8bh, 0dh, 8bh, 0dh
	defb 0h, 0h, 0h, 38h, 0h, 30h, 0h, 30h, 0h, 0h, 0eh, 0eeh, 0eh, 0eeh, 0eh, 0eeh
	defb 10h, 80h, 80h, 0h, 83h, 0fh, 83h, 0fh, 0h, 0h, 0ah, 0cdh, 0ah, 0cdh, 0ah, 0cdh
	defb 3bh, 5h, 3bh, 5h, 3bh, 5h, 0h, 0h, 0fh, 1ch, 0fh, 1ch, 0h, 10h, 10h, 80h
	defb 77h, 7h, 77h, 7h, 77h, 7h, 0h, 0h, 0c0h, 0h, 0c0h, 0h, 0c1h, 0h, 0h, 0h
	defb 0bh, 1dh, 0bh, 1dh, 0bh, 1dh, 0h, 0h, 0h, 0h, 0h, 0h, 0h, 0h, 1h, 19h
	defb 8bh, 0dh, 8bh, 0dh, 8bh, 0dh, 0h, 0h, 0h, 0h, 0h, 0h, 0h, 0h, 89h, 8h
	defb 0eh, 0eeh, 0eh, 0eeh, 0eh, 0eeh, 0h, 0h, 0h, 30h, 0h, 30h, 0h, 38h, 0h, 0h
	defb 0ah, 0cdh, 0ah, 0cdh, 0ah, 0cdh, 0h, 0h, 83h, 0fh, 83h, 0fh, 80h, 0h, 10h, 80h
	defb 30h, 0c0h, 30h, 0c0h, 10h, 80h, 0h, 0h, 0h, 0ffh, 0h, 0h, 1h, 9h, 1h, 8h
	defb 0h, 0eeh, 0h, 0eeh, 0h, 0eeh, 0h, 0eeh, 4h, 0h, 33h, 5h, 77h, 89h, 77h, 88h
	defb 0bh, 0ch, 7h, 0eh, 0fh, 0fh, 0fh, 0fh, 7h, 0eh, 0bh, 0ch, 9h, 19h, 0h, 11h
	defb 3h, 0dh, 7h, 0eh, 0fh, 0fh, 0fh, 0fh, 7h, 0eh, 3h, 0dh, 89h, 9h, 88h, 0h
	defb 77h, 0h, 77h, 0h, 77h, 0h, 77h, 0h, 0h, 2h, 0ah, 0cch, 19h, 0eeh, 11h, 0eeh
	defb 30h, 0c0h, 30h, 0c0h, 10h, 80h, 0h, 0h, 0ffh, 0h, 0h, 0h, 9h, 8h, 1h, 8h
	defb 1h, 1ah, 1h, 29h, 1h, 0h, 0h, 3h, 0h, 7h, 0h, 0h, 0h, 0h, 0h, 0h
	defb 33h, 70h, 0h, 0h, 0h, 0fh, 0eh, 0h, 0eh, 0fh, 0h, 0h, 0h, 0h, 0h, 0h
	defb 0f0h, 0d1h, 0h, 11h, 0ah, 0c0h, 10h, 0e0h, 38h, 0f0h, 30h, 0f0h, 10h, 0e0h, 0h, 0c0h
	defb 0b8h, 0f0h, 88h, 0h, 30h, 5h, 70h, 80h, 0f0h, 0c1h, 0f0h, 0c0h, 70h, 80h, 30h, 0h
	defb 0e0h, 0cch, 0h, 0h, 0fh, 0h, 0h, 7h, 0fh, 7h, 0h, 0h, 0h, 0h, 0h, 0h
	defb 49h, 8h, 85h, 8h, 0h, 8h, 0ch, 0h, 0eh, 0h, 0h, 0h, 0h, 0h, 0h, 0h
SpritePattern_: public SpritePattern_
	; 8dot
	defb 3h, 0ch, 7h, 0eh, 0eh, 7h, 1ch, 83h, 1ch, 83h, 0eh, 7h, 7h, 0eh, 3h, 0ch
	; 16dot
	defb 11h, 0h, 11h, 0h, 33h, 0h, 33h, 11h, 77h, 33h, 77h, 66h, 77h, 55h, 0ffh, 77h
	defb 11h, 0h, 11h, 0h, 11h, 88h, 11h, 88h, 99h, 0cch, 0ddh, 0cch, 55h, 0cch, 0ddh, 0eeh
	defb 0ffh, 77h, 0ffh, 77h, 0ffh, 77h, 77h, 77h, 31h, 33h, 11h, 0h, 0h, 0h, 0h, 0h
	defb 0ddh, 0eeh, 0ddh, 0eeh, 0ddh, 0eeh, 0ddh, 0cch, 99h, 80h, 11h, 0h, 0h, 0h, 0h, 0h
	defb 0h, 33h, 0h, 0ffh, 33h, 0ffh, 77h, 0eeh, 0ffh, 0ddh, 0ffh, 0aah, 0ffh, 77h, 0e6h, 0ffh
	defb 0cch, 0h, 88h, 0h, 0h, 0h, 0h, 0h, 0eeh, 0h, 22h, 22h, 0aah, 66h, 0aah, 0eeh
	defb 0ddh, 0ffh, 11h, 0ffh, 0h, 0ffh, 0h, 66h, 0h, 11h, 0h, 33h, 0h, 32h, 0h, 0h
	defb 0ddh, 0eeh, 0bbh, 0cch, 77h, 0cch, 0ffh, 88h, 0ffh, 88h, 0ffh, 0h, 0eeh, 0h, 0h, 0h
	defb 0h, 0ffh, 11h, 0ffh, 31h, 0ffh, 77h, 0ffh, 0h, 0h, 11h, 0ffh, 33h, 0ffh, 33h, 0ffh
	defb 0h, 0h, 0eeh, 0h, 0ffh, 88h, 0ffh, 0eeh, 0h, 0h, 0cch, 0h, 66h, 0h, 0bbh, 0h
	defb 33h, 0ffh, 11h, 0ffh, 0h, 0h, 77h, 0ffh, 31h, 0ffh, 11h, 0ffh, 0h, 0ffh, 0h, 0h
	defb 66h, 0h, 0cch, 0h, 0h, 0h, 0ffh, 0eeh, 0ffh, 88h, 0eeh, 0h, 0h, 0h, 0h, 0h
	defb 0h, 32h, 0h, 33h, 0h, 11h, 0h, 66h, 0h, 0ffh, 11h, 0ffh, 0ddh, 0ffh, 0e6h, 0ffh
	defb 0eeh, 0h, 0ffh, 0h, 0ffh, 88h, 0ffh, 88h, 77h, 0cch, 0bbh, 0cch, 0ddh, 0eeh, 0aah, 0eeh
	defb 0ffh, 77h, 0ffh, 0aah, 0ffh, 0ddh, 77h, 0eeh, 33h, 0ffh, 0h, 0ffh, 0h, 33h, 0h, 0h
	defb 0aah, 66h, 22h, 22h, 0eeh, 0h, 0h, 0h, 0h, 0h, 88h, 0h, 0cch, 0h, 0h, 0h
	defb 0h, 0h, 11h, 0h, 31h, 33h, 77h, 77h, 0ffh, 77h, 0ffh, 77h, 0ffh, 77h, 0ffh, 77h
	defb 0h, 0h, 11h, 0h, 99h, 80h, 0ddh, 0cch, 0ddh, 0eeh, 0ddh, 0eeh, 0ddh, 0eeh, 0ddh, 0eeh
	defb 77h, 55h, 77h, 66h, 77h, 33h, 33h, 11h, 33h, 0h, 11h, 0h, 11h, 0h, 0h, 0h
	defb 55h, 0cch, 0ddh, 0cch, 99h, 0cch, 11h, 88h, 11h, 88h, 11h, 0h, 11h, 0h, 0h, 0h
	defb 0h, 0feh, 11h, 0ffh, 33h, 0ffh, 33h, 0eeh, 77h, 0ddh, 77h, 0bbh, 0ffh, 77h, 0eeh, 0bbh
	defb 88h, 0h, 88h, 0h, 0h, 0h, 0cch, 0h, 0eeh, 0h, 0ffh, 0h, 0ffh, 66h, 0eeh, 0ech
	defb 0cch, 0bbh, 88h, 88h, 0h, 0ffh, 0h, 0h, 0h, 11h, 0h, 33h, 0h, 77h, 0h, 0h
	defb 0ddh, 0eeh, 0bbh, 0eeh, 77h, 0eeh, 0ffh, 0cch, 0ffh, 88h, 0eeh, 0h, 88h, 0h, 0h, 0h
	defb 0h, 11h, 0h, 0ffh, 33h, 0ffh, 0ffh, 0ffh, 0h, 0h, 0h, 77h, 0h, 0ddh, 11h, 0bbh
	defb 0eeh, 0h, 0ffh, 0h, 0ffh, 80h, 0ffh, 0cch, 0h, 0h, 0ffh, 0h, 0ffh, 88h, 0ffh, 88h
	defb 0h, 0ddh, 0h, 77h, 0h, 0h, 0ffh, 0ffh, 33h, 0ffh, 0h, 0ffh, 0h, 11h, 0h, 0h
	defb 0ffh, 88h, 0ffh, 0h, 0h, 0h, 0ffh, 0cch, 0ffh, 80h, 0ffh, 0h, 0eeh, 0h, 0h, 0h
	defb 0h, 77h, 0h, 33h, 0h, 11h, 0h, 0h, 0h, 0ffh, 88h, 88h, 0cch, 0bbh, 0eeh, 0bbh
	defb 88h, 0h, 0eeh, 0h, 0ffh, 88h, 0ffh, 0cch, 77h, 0eeh, 0bbh, 0eeh, 0ddh, 0eeh, 0eeh, 0ech
	defb 0ffh, 77h, 77h, 0bbh, 77h, 0ddh, 33h, 0eeh, 33h, 0ffh, 11h, 0ffh, 0h, 0feh, 0h, 0h
	defb 0ffh, 66h, 0ffh, 0h, 0eeh, 0h, 0cch, 0h, 0h, 0h, 88h, 0h, 88h, 0h, 0h, 0h
	defb 0h, 0h, 0h, 30h, 0h, 70h, 0h, 0c3h, 0h, 0b4h, 30h, 0f0h, 70h, 0f0h, 0f0h, 0f0h
	defb 0h, 0h, 80h, 0h, 0c0h, 0h, 68h, 0h, 0a4h, 0h, 0f0h, 80h, 0f0h, 0c0h, 0f0h, 0e0h
	defb 0e0h, 0f0h, 0c0h, 0f0h, 80h, 0f0h, 0h, 50h, 0h, 10h, 0h, 10h, 0h, 10h, 0h, 0h
	defb 0e0h, 0e0h, 0e0h, 60h, 0e0h, 20h, 40h, 0h, 0h, 0h, 0h, 0h, 0h, 0h, 0h, 0h
	defb 0h, 0h, 0h, 0h, 30h, 0e0h, 70h, 0f0h, 0f0h, 0f0h, 0h, 70h, 0h, 0f0h, 10h, 0f0h
	defb 0h, 0h, 0h, 0h, 0f0h, 0h, 1eh, 80h, 0c3h, 80h, 0e1h, 80h, 0e1h, 80h, 0f0h, 0h
	defb 10h, 0f0h, 0h, 70h, 0h, 0b0h, 10h, 30h, 0h, 0h, 0h, 0h, 0h, 0h, 0h, 0h
	defb 0f0h, 80h, 0f0h, 80h, 0b0h, 80h, 30h, 80h, 30h, 80h, 30h, 0h, 20h, 0h, 0h, 0h
	defb 0h, 0f0h, 0h, 70h, 0h, 30h, 0h, 10h, 0h, 0f0h, 10h, 0f0h, 0h, 0f0h, 0f0h, 0f0h
	defb 0h, 0h, 80h, 0h, 0c0h, 0h, 0c0h, 0h, 0f0h, 0h, 0d2h, 80h, 0e1h, 0c0h, 0e1h, 0c0h
	defb 0h, 0f0h, 10h, 0f0h, 0h, 0f0h, 0h, 10h, 0h, 30h, 0h, 70h, 0h, 0f0h, 0h, 0h
	defb 0e1h, 0c0h, 0d2h, 80h, 0f0h, 0h, 0c0h, 0h, 0c0h, 0h, 80h, 0h, 0h, 0h, 0h, 0h
	defb 0h, 0h, 0h, 0h, 0h, 0h, 10h, 30h, 0h, 0b0h, 0h, 70h, 10h, 0f0h, 10h, 0f0h
	defb 20h, 0h, 30h, 0h, 30h, 80h, 30h, 80h, 0b0h, 80h, 0f0h, 80h, 0f0h, 80h, 0f0h, 0h
	defb 0h, 0f0h, 0h, 70h, 0f0h, 0f0h, 70h, 0f0h, 30h, 0e0h, 0h, 0h, 0h, 0h, 0h, 0h
	defb 0e1h, 80h, 0e1h, 80h, 0c3h, 80h, 1eh, 80h, 0f0h, 0h, 0h, 0h, 0h, 0h, 0h, 0h
	defb 0h, 10h, 0h, 10h, 0h, 10h, 0h, 50h, 80h, 0f0h, 0c0h, 0f0h, 0e0h, 0f0h, 0f0h, 0f0h
	defb 0h, 0h, 0h, 0h, 0h, 0h, 40h, 0h, 0e0h, 20h, 0e0h, 60h, 0e0h, 0e0h, 0f0h, 0e0h
	defb 70h, 0f0h, 30h, 0f0h, 0h, 0b4h, 0h, 0c3h, 0h, 70h, 0h, 30h, 0h, 0h, 0h, 0h
	defb 0f0h, 0c0h, 0f0h, 80h, 0a4h, 0h, 68h, 0h, 0c0h, 0h, 80h, 0h, 0h, 0h, 0h, 0h
	defb 0h, 80h, 10h, 80h, 30h, 80h, 30h, 90h, 30h, 0b0h, 30h, 0f0h, 30h, 0f0h, 10h, 0f0h
	defb 0h, 0h, 0h, 0h, 0h, 0h, 90h, 0h, 0a0h, 0h, 0c0h, 0h, 0f0h, 0h, 0f0h, 0h
	defb 21h, 0f0h, 21h, 0f0h, 21h, 78h, 30h, 1eh, 10h, 0e0h, 0h, 0h, 0h, 0h, 0h, 0h
	defb 0e0h, 0h, 0c0h, 0h, 0f0h, 0e0h, 0f0h, 0c0h, 0f0h, 80h, 0h, 0h, 0h, 0h, 0h, 0h
	defb 0h, 10h, 0h, 30h, 0h, 70h, 0h, 70h, 10h, 0f0h, 30h, 78h, 61h, 0f0h, 61h, 0f0h
	defb 0e0h, 0h, 0c0h, 0h, 80h, 0h, 0h, 0h, 0e0h, 0h, 0f0h, 0h, 0e0h, 0h, 0f0h, 0e0h
	defb 61h, 0f0h, 30h, 78h, 10h, 0f0h, 0h, 70h, 0h, 70h, 0h, 30h, 0h, 10h, 0h, 0h
	defb 0e0h, 0h, 0f0h, 0h, 0e0h, 0h, 0h, 0h, 80h, 0h, 0c0h, 0h, 0e0h, 0h, 0h, 0h
	defb 0h, 0h, 0h, 0h, 10h, 0e0h, 30h, 1eh, 21h, 78h, 21h, 0f0h, 21h, 0f0h, 10h, 0f0h
	defb 0h, 0h, 0h, 0h, 0f0h, 80h, 0f0h, 0c0h, 0f0h, 0e0h, 0c0h, 0h, 0e0h, 0h, 0f0h, 0h
	defb 30h, 0f0h, 30h, 0f0h, 30h, 0b0h, 30h, 90h, 30h, 80h, 10h, 80h, 0h, 80h, 0h, 0h
	defb 0f0h, 0h, 0c0h, 0h, 0a0h, 0h, 90h, 0h, 0h, 0h, 0h, 0h, 0h, 0h, 0h, 0h
	defb 0h, 0h, 0h, 0h, 0h, 0h, 3h, 0fh, 7h, 0fh, 0dh, 0bh, 9h, 0bh, 0dh, 0bh
	defb 0h, 0h, 0h, 0h, 0h, 0h, 0fh, 8h, 0fh, 0ch, 4h, 6h, 5h, 0ah, 5h, 0ah
	defb 0dh, 0bh, 0dh, 0bh, 8h, 0ch, 7h, 0fh, 3h, 0fh, 0h, 0h, 0h, 0h, 0h, 0h
	defb 4h, 6h, 5h, 0eh, 0dh, 0eh, 0fh, 0ch, 0fh, 8h, 0h, 0h, 0h, 0h, 0h, 0h
	defb 0h, 10h, 20h, 10h, 30h, 30h, 30h, 0e0h, 20h, 40h, 0e0h, 1h, 70h, 52h, 30h, 0a1h
	defb 0h, 40h, 90h, 0c0h, 0f0h, 80h, 0f0h, 90h, 60h, 0f0h, 0h, 0e0h, 18h, 0c0h, 0b0h, 80h
	defb 10h, 92h, 30h, 0h, 0e0h, 20h, 60h, 0e0h, 30h, 0e0h, 10h, 0b0h, 10h, 10h, 0h, 10h
	defb 58h, 0c0h, 84h, 0f0h, 0h, 0e0h, 40h, 80h, 0e0h, 0c0h, 0f0h, 0c0h, 80h, 0c0h, 0h, 0h
	defb 0h, 0h, 0h, 0h, 0h, 80h, 0h, 0e0h, 0h, 70h, 0h, 70h, 0h, 60h, 0h, 30h
	defb 0h, 20h, 0h, 70h, 0h, 70h, 0h, 0f0h, 90h, 0d0h, 0f0h, 0c0h, 70h, 80h, 30h, 80h
	defb 0h, 30h, 10h, 0f0h, 0f0h, 30h, 70h, 80h, 30h, 0e0h, 10h, 0f0h, 0h, 0f0h, 0h, 60h
	defb 10h, 2h, 80h, 20h, 90h, 5ah, 21h, 0a1h, 52h, 18h, 1h, 81h, 90h, 8h, 21h, 0h
	defb 0h, 0h, 0h, 0h, 0h, 10h, 80h, 70h, 80h, 0f0h, 0d0h, 0f0h, 0f0h, 0d0h, 70h, 90h
	defb 60h, 0h, 0e0h, 0h, 0c0h, 0h, 0c0h, 0h, 0c0h, 0h, 80h, 0h, 80h, 0e0h, 0b0h, 0c0h
	defb 70h, 10h, 20h, 14h, 0h, 48h, 81h, 84h, 5ah, 8h, 1h, 90h, 10h, 10h, 21h, 80h
	defb 0f0h, 80h, 0f0h, 80h, 30h, 0h, 0e0h, 0h, 0c0h, 0h, 0c0h, 0h, 0e0h, 0h, 0f0h, 0h
	defb 0h, 40h, 0h, 81h, 30h, 90h, 70h, 21h, 0e0h, 0h, 70h, 0f0h, 30h, 0f0h, 0h, 0e0h
	defb 42h, 40h, 84h, 0a4h, 18h, 4ah, 0a5h, 0a5h, 52h, 58h, 20h, 1h, 42h, 10h, 10h, 0c0h
	defb 0h, 60h, 0h, 20h, 0h, 30h, 0h, 30h, 0h, 20h, 0h, 0h, 0h, 0h, 0h, 0h
	defb 70h, 0c0h, 0e0h, 0e0h, 0c0h, 0e0h, 0h, 60h, 0h, 70h, 0h, 30h, 0h, 30h, 0h, 20h
	defb 52h, 5ah, 24h, 0h, 5ah, 0h, 0a5h, 30h, 18h, 38h, 0h, 90h, 20h, 10h, 30h, 80h
	defb 30h, 80h, 0h, 0c0h, 0f0h, 0e0h, 0f0h, 0f0h, 0f0h, 0h, 80h, 0h, 80h, 0h, 0c0h, 0h
	defb 70h, 0c0h, 0f0h, 0f0h, 0e0h, 30h, 0c0h, 10h, 80h, 0h, 0h, 0h, 0h, 0h, 0h, 0h
	defb 0c0h, 0h, 0c0h, 0h, 0e0h, 0h, 0e0h, 0h, 60h, 0h, 0h, 0h, 0h, 0h, 0h, 0h

AsciiPattern_: public AsciiPattern_
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
