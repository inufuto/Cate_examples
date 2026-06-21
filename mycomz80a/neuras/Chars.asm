cseg

AsciiPattern: public AsciiPattern
	; ascii 33
	; " -0123456789ABCDEGHIKLMNOPRSTUVWY"
	defb 00h,00h,00h,00h,44h,04h,00h,00h
	defb 1fh,0fh,11h,01h,00h,0fh,00h,01h
	defb 5dh,07h,11h,01h,55h,0fh,11h,01h
	defb 47h,0fh,00h,01h,57h,0dh,11h,01h
	defb 5fh,0dh,11h,01h,0d1h,03h,10h,00h
	defb 5fh,0fh,11h,01h,57h,0fh,11h,01h
	defb 9eh,0eh,01h,01h,5fh,0ah,11h,00h
	defb 1eh,0ah,10h,00h,1fh,0eh,11h,00h
	defb 5fh,01h,11h,01h,1eh,0dh,10h,00h
	defb 4fh,0fh,01h,01h,0f1h,01h,11h,01h
	defb 4fh,0bh,01h,01h,0fh,00h,11h,01h
	defb 6fh,0fh,01h,01h,1fh,0eh,01h,01h
	defb 1eh,0eh,10h,00h,5fh,07h,01h,00h
	defb 5fh,0ah,01h,01h,56h,0dh,11h,00h
	defb 0f1h,01h,10h,00h,0fh,0fh,11h,01h
	defb 0fh,0fh,10h,00h,0cfh,0fh,01h,01h
	defb 0c3h,03h,10h,00h

CharPattern: public CharPattern
;	wall
	defb	00h, 00h, 0fh, 00h, 00h, 0f0h, 0fh, 0f0h
	defb	11h, 11h, 1eh, 11h, 11h, 0e1h, 1eh, 0e1h
	defb	88h, 88h, 87h, 88h, 88h, 78h, 87h, 78h
	defb	99h, 99h, 96h, 99h, 99h, 69h, 96h, 69h
;	8dot
	defb	0a0h, 0bfh, 0efh, 00h, 0f8h, 37h, 0f7h, 0bh
	defb	0a0h, 0bfh, 0efh, 00h, 32h, 0b7h, 7fh, 21h
	defb	00h, 0feh, 0fbh, 0ah, 0b0h, 7fh, 73h, 8fh
	defb	00h, 0feh, 0fbh, 0ah, 12h, 0f7h, 7bh, 23h
	defb	0e0h, 0ffh, 0efh, 00h, 0f1h, 3fh, 77h, 03h
	defb	0e0h, 0ffh, 0efh, 00h, 73h, 37h, 0ffh, 01h
	defb	00h, 0beh, 0bfh, 0eh, 30h, 77h, 0f3h, 1fh
	defb	00h, 0beh, 0bfh, 0eh, 10h, 0ffh, 73h, 37h
	defb	0a8h, 0afh, 0efh, 08h, 10h, 73h, 0bfh, 00h
	defb	40h, 4eh, 0ceh, 00h, 32h, 0f7h, 0ffh, 02h
	defb	80h, 0feh, 0fah, 8ah, 00h, 0fbh, 37h, 01h
	defb	00h, 0ech, 0e4h, 04h, 20h, 0ffh, 7fh, 23h
	defb	0e8h, 0efh, 0efh, 08h, 30h, 0f7h, 37h, 00h
	defb	0c0h, 0ceh, 0ceh, 00h, 71h, 0ffh, 7fh, 01h
	defb	80h, 0beh, 0beh, 8eh, 00h, 73h, 7fh, 03h
	defb	00h, 6ch, 6ch, 0ch, 10h, 0f7h, 0ffh, 17h
	defb	0beh, 0b5h, 0b5h, 0eh, 0a7h, 0adh, 0adh, 07h
	defb	7eh, 0dbh, 7bh, 0eh, 0c7h, 0eeh, 0ceh, 07h
	defb	0beh, 5dh, 0b5h, 0eh, 0d7h, 0dch, 0ddh, 07h
	defb	0feh, 5dh, 0b5h, 0eh, 0f7h, 0ddh, 0edh, 07h
	defb	7eh, 0dbh, 0f1h, 0eh, 0e7h, 0eeh, 0ech, 07h
	defb	1eh, 55h, 0f5h, 0eh, 0d7h, 0ddh, 0edh, 07h
	defb	3eh, 55h, 0f5h, 0eh, 0e7h, 0ddh, 0edh, 07h
	defb	9eh, 0ddh, 95h, 0eh, 0f7h, 0cfh, 0ffh, 07h
	defb	0beh, 55h, 0b5h, 0eh, 0e7h, 0ddh, 0edh, 07h
	defb	0beh, 55h, 35h, 0eh, 0f7h, 0ddh, 0edh, 07h
	defb	1eh, 1fh, 1dh, 0eh, 0c7h, 0cfh, 0cdh, 07h
	defb	0feh, 0ddh, 0d1h, 0eh, 0e7h, 0ddh, 0feh, 07h
	defb	3eh, 5dh, 3dh, 0eh, 0e7h, 0ddh, 0deh, 07h
	defb	0feh, 71h, 0dbh, 0eh, 0f7h, 0fch, 0deh, 07h
;	title
	defb	0f0h, 0efh, 8ch, 0ffh, 70h, 07h, 31h, 77h
	defb	0f0h, 9fh, 99h, 99h, 70h, 47h, 44h, 44h
	defb	0f0h, 0fh, 00h, 0ffh, 30h, 47h, 44h, 37h
	defb	0f0h, 1fh, 91h, 0efh, 70h, 17h, 31h, 46h
	defb	0c0h, 3eh, 31h, 0ceh, 70h, 17h, 11h, 77h
	defb	60h, 9fh, 99h, 2bh, 20h, 46h, 44h, 37h
