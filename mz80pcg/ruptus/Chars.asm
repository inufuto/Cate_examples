cseg
CharPattern: public CharPattern
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
	defb	00h, 02h, 04h, 08h, 10h, 20h, 40h, 00h
	defb	00h, 40h, 20h, 10h, 08h, 04h, 02h, 00h
	defb	3ch, 7eh, 0e7h, 0dbh, 0dbh, 0e7h, 7eh, 3ch
	defb	00h, 00h, 00h, 10h, 00h, 00h, 00h, 00h
;	16dot
	defb	10h, 10h, 30h, 31h, 73h, 76h, 75h, 0f7h
	defb	10h, 10h, 18h, 18h, 9ch, 0dch, 5ch, 0deh
	defb	0f7h, 0f7h, 0f7h, 77h, 33h, 10h, 00h, 00h
	defb	0deh, 0deh, 0deh, 0dch, 98h, 10h, 00h, 00h
	defb	03h, 0fh, 3fh, 7eh, 0fdh, 0fah, 0f7h, 0efh
	defb	0c0h, 80h, 00h, 00h, 0e0h, 22h, 0a6h, 0aeh
	defb	0dfh, 1fh, 0fh, 06h, 01h, 03h, 03h, 00h
	defb	0deh, 0bch, 7ch, 0f8h, 0f8h, 0f0h, 0e0h, 00h
	defb	0fh, 1fh, 3fh, 7fh, 00h, 1fh, 3fh, 3fh
	defb	00h, 0e0h, 0f8h, 0feh, 00h, 0c0h, 60h, 0b0h
	defb	3fh, 1fh, 00h, 7fh, 3fh, 1fh, 0fh, 00h
	defb	60h, 0c0h, 00h, 0feh, 0f8h, 0e0h, 00h, 00h
	defb	03h, 03h, 01h, 06h, 0fh, 1fh, 0dfh, 0efh
	defb	0e0h, 0f0h, 0f8h, 0f8h, 7ch, 0bch, 0deh, 0aeh
	defb	0f7h, 0fah, 0fdh, 7eh, 3fh, 0fh, 03h, 00h
	defb	0a6h, 22h, 0e0h, 00h, 00h, 80h, 0c0h, 00h
	defb	00h, 10h, 33h, 77h, 0f7h, 0f7h, 0f7h, 0f7h
	defb	00h, 10h, 98h, 0dch, 0deh, 0deh, 0deh, 0deh
	defb	75h, 76h, 73h, 31h, 30h, 10h, 10h, 00h
	defb	5ch, 0dch, 9ch, 18h, 18h, 10h, 10h, 00h
	defb	0fh, 1fh, 3fh, 3eh, 7dh, 7bh, 0f7h, 0ebh
	defb	80h, 80h, 00h, 0c0h, 0e0h, 0f0h, 0f6h, 0eeh
	defb	0cbh, 88h, 0fh, 00h, 01h, 03h, 07h, 00h
	defb	0deh, 0beh, 7eh, 0fch, 0f8h, 0e0h, 80h, 00h
	defb	01h, 0fh, 3fh, 0ffh, 00h, 07h, 0dh, 1bh
	defb	0e0h, 0f0h, 0f8h, 0fch, 00h, 0f0h, 0f8h, 0f8h
	defb	0dh, 07h, 00h, 0ffh, 3fh, 0fh, 01h, 00h
	defb	0f8h, 0f0h, 00h, 0fch, 0f8h, 0f0h, 0e0h, 00h
	defb	07h, 03h, 01h, 00h, 0fh, 88h, 0cbh, 0ebh
	defb	80h, 0e0h, 0f8h, 0fch, 7eh, 0beh, 0deh, 0eeh
	defb	0f7h, 7bh, 7dh, 3eh, 3fh, 1fh, 0fh, 00h
	defb	0f6h, 0f0h, 0e0h, 0c0h, 00h, 80h, 80h, 00h
	defb	00h, 03h, 07h, 0ch, 0bh, 2fh, 6fh, 0efh
	defb	00h, 80h, 0c0h, 60h, 0a0h, 0e8h, 0ech, 0eeh
	defb	0efh, 0cfh, 8eh, 05h, 01h, 01h, 01h, 00h
	defb	0eeh, 0e6h, 0e2h, 40h, 00h, 00h, 00h, 00h
	defb	00h, 00h, 3ch, 79h, 0f3h, 07h, 0fh, 1fh
	defb	00h, 00h, 0f0h, 18h, 0c8h, 0e8h, 0e8h, 0f0h
	defb	1fh, 03h, 0bh, 13h, 00h, 00h, 00h, 00h
	defb	0e0h, 0c8h, 98h, 38h, 38h, 30h, 20h, 00h
	defb	0fh, 07h, 03h, 00h, 0fh, 1fh, 0fh, 0f7h
	defb	00h, 80h, 0c0h, 00h, 0f0h, 0d8h, 0ech, 0ech
	defb	0fh, 1fh, 0fh, 00h, 03h, 07h, 0fh, 00h
	defb	0ech, 0d8h, 0f0h, 00h, 0c0h, 80h, 00h, 00h
	defb	00h, 00h, 00h, 13h, 0bh, 03h, 1fh, 1fh
	defb	20h, 30h, 38h, 38h, 98h, 0c8h, 0e0h, 0f0h
	defb	0fh, 07h, 0f3h, 79h, 3ch, 00h, 00h, 00h
	defb	0e8h, 0e8h, 0c8h, 18h, 0f0h, 00h, 00h, 00h
	defb	01h, 01h, 01h, 05h, 8eh, 0cfh, 0efh, 0efh
	defb	00h, 00h, 00h, 40h, 0e2h, 0e6h, 0eeh, 0eeh
	defb	6fh, 2fh, 0bh, 0ch, 07h, 03h, 00h, 00h
	defb	0ech, 0e8h, 0a0h, 60h, 0c0h, 80h, 00h, 00h
	defb	08h, 18h, 38h, 39h, 33h, 27h, 0fh, 1fh
	defb	00h, 00h, 00h, 90h, 0a0h, 80h, 0f0h, 0f0h
	defb	2fh, 2fh, 27h, 31h, 1eh, 00h, 00h, 00h
	defb	0e0h, 0c0h, 9eh, 3ch, 78h, 00h, 00h, 00h
	defb	01h, 03h, 07h, 00h, 1fh, 37h, 6fh, 6fh
	defb	0e0h, 0c0h, 80h, 00h, 0e0h, 0f0h, 0e0h, 0deh
	defb	6fh, 37h, 1fh, 00h, 07h, 03h, 01h, 00h
	defb	0e0h, 0f0h, 0e0h, 00h, 80h, 0c0h, 0e0h, 00h
	defb	00h, 00h, 1eh, 31h, 27h, 2fh, 2fh, 1fh
	defb	00h, 00h, 78h, 3ch, 9eh, 0c0h, 0e0h, 0f0h
	defb	0fh, 27h, 33h, 39h, 38h, 18h, 08h, 00h
	defb	0f0h, 80h, 0a0h, 90h, 00h, 00h, 00h, 00h
	defb	01h, 21h, 33h, 3eh, 24h, 0e1h, 77h, 3bh
	defb	04h, 9ch, 0f8h, 0f9h, 6fh, 0eh, 9ch, 0b8h
	defb	1bh, 30h, 0e2h, 6eh, 3eh, 1bh, 11h, 01h
	defb	0dch, 0cfh, 0eh, 48h, 0ech, 0fch, 8ch, 00h
	defb	00h, 00h, 00h, 3fh, 7fh, 0dbh, 9bh, 0dbh
	defb	00h, 00h, 00h, 0f8h, 0fch, 46h, 5ah, 5ah
	defb	0dbh, 0dbh, 8ch, 7fh, 3fh, 00h, 00h, 00h
	defb	46h, 5eh, 0deh, 0fch, 0f8h, 00h, 00h, 00h
;	fort
	defb	00h, 00h, 00h, 07h, 03h, 10h, 1bh, 1bh
	defb	00h, 00h, 00h, 0efh, 0e0h, 0fh, 00h, 37h
	defb	0ch, 1eh, 3fh, 0bfh, 1eh, 0ach, 01h, 0fdh
	defb	30h, 78h, 0fch, 0fdh, 78h, 35h, 80h, 0bfh
	defb	00h, 00h, 00h, 0f7h, 07h, 0f0h, 00h, 0ech
	defb	00h, 00h, 00h, 0e0h, 0c0h, 08h, 0d8h, 0d8h
	defb	18h, 19h, 00h, 0fh, 00h, 19h, 3dh, 3dh
	defb	78h, 79h, 35h, 40h, 0eh, 0ceh, 0ceh, 0ceh
	defb	01h, 99h, 0bch, 7eh, 0ffh, 0ffh, 7eh, 0bch
	defb	80h, 99h, 3dh, 7eh, 0ffh, 0ffh, 7eh, 3dh
	defb	1eh, 9eh, 0ach, 02h, 70h, 73h, 73h, 73h
	defb	18h, 98h, 00h, 0f0h, 00h, 98h, 0bch, 0bch
	defb	18h, 01h, 0fdh, 0fdh, 00h, 0b5h, 0b5h, 0b5h
	defb	00h, 0d8h, 0dbh, 0dbh, 00h, 77h, 77h, 77h
	defb	19h, 00h, 0feh, 0feh, 00h, 0bdh, 0bdh, 0bdh
	defb	98h, 00h, 7fh, 7fh, 00h, 0bdh, 0bdh, 0bdh
	defb	00h, 1bh, 0dbh, 0dbh, 00h, 0eeh, 0eeh, 0eeh
	defb	18h, 80h, 0bfh, 0bfh, 00h, 0adh, 0adh, 0adh
	defb	0b5h, 0b5h, 0b5h, 00h, 0fdh, 0fdh, 01h, 18h
	defb	77h, 77h, 77h, 00h, 0dbh, 0dbh, 0d8h, 00h
	defb	0bdh, 0bdh, 0bdh, 00h, 0feh, 0feh, 00h, 19h
	defb	0bdh, 0bdh, 0bdh, 00h, 7fh, 7fh, 00h, 98h
	defb	0eeh, 0eeh, 0eeh, 00h, 0dbh, 0dbh, 1bh, 00h
	defb	0adh, 0adh, 0adh, 00h, 0bfh, 0bfh, 80h, 18h
	defb	3dh, 3dh, 19h, 00h, 0fh, 00h, 19h, 18h
	defb	0ceh, 0ceh, 0ceh, 0eh, 40h, 35h, 79h, 78h
	defb	0bch, 7eh, 0ffh, 0ffh, 7eh, 0bch, 99h, 01h
	defb	3dh, 7eh, 0ffh, 0ffh, 7eh, 3dh, 99h, 80h
	defb	73h, 73h, 73h, 70h, 02h, 0ach, 9eh, 1eh
	defb	0bch, 0bch, 98h, 00h, 0f0h, 00h, 98h, 18h
	defb	1bh, 1bh, 10h, 03h, 07h, 00h, 00h, 00h
	defb	37h, 00h, 0fh, 0e0h, 0efh, 00h, 00h, 00h
	defb	0fdh, 01h, 0ach, 1eh, 0bfh, 3fh, 1eh, 0ch
	defb	0bfh, 80h, 35h, 78h, 0fdh, 0fch, 78h, 30h
	defb	0ech, 00h, 0f0h, 07h, 0f7h, 00h, 00h, 00h
	defb	0d8h, 0d8h, 08h, 0c0h, 0e0h, 00h, 00h, 00h
