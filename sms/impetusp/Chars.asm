cseg

MonoPattern: public MonoPattern
; ascii 29
	; " -0123456789ABCEFGHIMNOPRSTUV"
	defb 00h,00h,00h,00h,00h,00h,00h,00h
	defb 00h,00h,00h,7eh,00h,00h,00h,00h
	defb 3eh,63h,67h,6bh,73h,63h,3eh,00h
	defb 18h,78h,18h,18h,18h,18h,7eh,00h
	defb 3eh,63h,07h,1eh,3ch,70h,7fh,00h
	defb 3eh,63h,03h,1eh,03h,63h,3eh,00h
	defb 06h,0eh,1eh,36h,66h,7fh,06h,00h
	defb 7fh,60h,7eh,03h,03h,63h,3eh,00h
	defb 1eh,30h,60h,7eh,63h,63h,3eh,00h
	defb 7fh,63h,06h,0ch,18h,18h,18h,00h
	defb 3eh,63h,63h,3eh,63h,63h,3eh,00h
	defb 3eh,63h,63h,3fh,03h,63h,3eh,00h
	defb 1ch,36h,63h,63h,7fh,63h,63h,00h
	defb 7eh,63h,63h,7eh,63h,63h,7eh,00h
	defb 1eh,33h,60h,60h,60h,33h,1eh,00h
	defb 7eh,60h,60h,7eh,60h,60h,7eh,00h
	defb 7eh,60h,60h,7eh,60h,60h,60h,00h
	defb 1eh,33h,60h,6fh,63h,33h,1fh,00h
	defb 63h,63h,63h,7fh,63h,63h,63h,00h
	defb 7eh,18h,18h,18h,18h,18h,7eh,00h
	defb 7eh,6bh,6bh,6bh,6bh,6bh,6bh,00h
	defb 63h,73h,7bh,7fh,6fh,67h,63h,00h
	defb 3eh,63h,63h,63h,63h,63h,3eh,00h
	defb 7eh,63h,63h,63h,7eh,60h,60h,00h
	defb 7eh,63h,63h,67h,7ch,6eh,67h,00h
	defb 3eh,63h,60h,3eh,03h,63h,3eh,00h
	defb 7eh,18h,18h,18h,18h,18h,18h,00h
	defb 63h,63h,63h,63h,63h,63h,3eh,00h
	defb 63h,63h,63h,36h,36h,1ch,1ch,00h
; logo
	defb 0f0h,0f0h,0f0h,0f0h,00h,00h,00h,00h
	defb 00h,00h,00h,00h,0f0h,0f0h,0f0h,0f0h
	defb 0f0h,0f0h,0f0h,0f0h,0f0h,0f0h,0f0h,0f0h
	defb 0fh,0fh,0fh,0fh,00h,00h,00h,00h
	defb 0ffh,0ffh,0ffh,0ffh,00h,00h,00h,00h
	defb 0fh,0fh,0fh,0fh,0f0h,0f0h,0f0h,0f0h
	defb 0ffh,0ffh,0ffh,0ffh,0f0h,0f0h,0f0h,0f0h
	defb 00h,00h,00h,00h,0fh,0fh,0fh,0fh
	defb 0f0h,0f0h,0f0h,0f0h,0fh,0fh,0fh,0fh
	defb 00h,00h,00h,00h,0ffh,0ffh,0ffh,0ffh
	defb 0f0h,0f0h,0f0h,0f0h,0ffh,0ffh,0ffh,0ffh
	defb 0fh,0fh,0fh,0fh,0fh,0fh,0fh,0fh
	defb 0ffh,0ffh,0ffh,0ffh,0fh,0fh,0fh,0fh
	defb 0fh,0fh,0fh,0fh,0ffh,0ffh,0ffh,0ffh
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh
;	remain
	defb	44h, 44h, 0d6h, 0eeh, 0d6h, 0feh, 0feh, 54h

SpritePattern: public SpritePattern
;	sprite
	defb	00h, 00h, 00h, 01h, 01h, 01h, 01h, 02h
	defb	01h, 01h, 01h, 02h, 01h, 01h, 01h, 02h
	defb	01h, 01h, 01h, 02h, 01h, 01h, 01h, 02h
	defb	01h, 01h, 01h, 02h, 00h, 00h, 00h, 01h
	defb	00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h
	defb	00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h
	defb	00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h
	defb	00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h
	defb	00h, 00h, 00h, 00h, 00h, 00h, 00h, 80h
	defb	00h, 00h, 00h, 80h, 00h, 00h, 00h, 80h
	defb	00h, 00h, 00h, 80h, 00h, 00h, 00h, 80h
	defb	00h, 00h, 00h, 80h, 00h, 00h, 00h, 00h
	defb	00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h
	defb	00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h
	defb	00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h
	defb	00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h
	defb	00h, 00h, 00h, 00h, 00h, 3ch, 00h, 00h
	defb	00h, 7eh, 18h, 00h, 00h, 7eh, 3ch, 00h
	defb	00h, 7eh, 3ch, 00h, 00h, 7eh, 18h, 00h
	defb	00h, 3ch, 00h, 00h, 00h, 00h, 00h, 00h
	defb	00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h
	defb	00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h
	defb	00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h
	defb	00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h
	defb	00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h
	defb	00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h
	defb	00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h
	defb	00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h
	defb	00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h
	defb	00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h
	defb	00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h
	defb	00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h
	defb	00h, 00h, 00h, 3ch, 3ch, 00h, 3ch, 42h
	defb	7eh, 00h, 66h, 81h, 66h, 18h, 42h, 81h
	defb	66h, 18h, 42h, 81h, 7eh, 00h, 66h, 81h
	defb	3ch, 00h, 3ch, 42h, 00h, 00h, 00h, 3ch
	defb	00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h
	defb	00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h
	defb	00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h
	defb	00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h
	defb	00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h
	defb	00h, 00h, 00h, 00h, 00h, 0aah, 00h, 00h
	defb	00h, 55h, 00h, 00h, 00h, 00h, 00h, 00h
	defb	00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h
	defb	00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h
	defb	00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h
	defb	00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h
	defb	00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h
	defb	00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h
	defb	00h, 00h, 00h, 00h, 00h, 0aah, 00h, 00h
	defb	00h, 55h, 00h, 00h, 00h, 00h, 00h, 00h
	defb	00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h
	defb	00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h
	defb	00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h
	defb	00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h
	defb	00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h
	defb	00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h
	defb	00h, 00h, 00h, 00h, 00h, 0aah, 00h, 00h
	defb	00h, 55h, 00h, 00h, 00h, 00h, 00h, 00h
	defb	00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h
	defb	00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h
	defb	00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h
	defb	00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h
	defb	00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h
	defb	00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h
	defb	00h, 00h, 00h, 00h, 00h, 0aah, 00h, 00h
	defb	00h, 55h, 00h, 00h, 00h, 00h, 00h, 00h
	defb	00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h
	defb	00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h
	defb	00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h
	defb	00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h
	defb	00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h
	defb	00h, 00h, 00h, 3ch, 3ch, 00h, 3ch, 42h
	defb	7eh, 00h, 66h, 81h, 66h, 18h, 42h, 81h
	defb	66h, 18h, 42h, 81h, 7eh, 00h, 66h, 81h
	defb	3ch, 00h, 3ch, 42h, 00h, 00h, 00h, 3ch
	defb	00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h
	defb	00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h
	defb	00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h
	defb	00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h
	defb	00h, 01h, 00h, 00h, 00h, 21h, 00h, 00h
	defb	00h, 33h, 00h, 00h, 00h, 3fh, 01h, 01h
	defb	00h, 3fh, 1bh, 1bh, 00h, 0ffh, 1fh, 1eh
	defb	00h, 7fh, 0fh, 08h, 00h, 3fh, 07h, 04h
	defb	00h, 1fh, 07h, 04h, 00h, 3fh, 0fh, 0fh
	defb	00h, 0ffh, 1dh, 1dh, 00h, 7fh, 11h, 11h
	defb	00h, 3fh, 01h, 01h, 00h, 1bh, 00h, 00h
	defb	00h, 11h, 00h, 00h, 00h, 01h, 00h, 00h
	defb	00h, 04h, 00h, 00h, 00h, 9ch, 00h, 00h
	defb	00h, 0f8h, 00h, 00h, 00h, 0f9h, 00h, 00h
	defb	00h, 0ffh, 90h, 90h, 00h, 0feh, 0f0h, 0f0h
	defb	00h, 0fch, 0e0h, 60h, 00h, 0f8h, 0c0h, 40h
	defb	00h, 0fch, 0e0h, 20h, 00h, 0ffh, 0f0h, 30h
	defb	00h, 0feh, 0f0h, 0f0h, 00h, 0f8h, 0b0h, 0b0h
	defb	00h, 0fch, 10h, 10h, 00h, 0fch, 00h, 00h
	defb	00h, 8ch, 00h, 00h, 00h, 00h, 00h, 00h
	defb	00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h
	defb	00h, 08h, 00h, 00h, 00h, 0eh, 00h, 00h
	defb	00h, 07h, 00h, 00h, 00h, 07h, 00h, 00h
	defb	00h, 07h, 01h, 01h, 00h, 03h, 00h, 00h
	defb	00h, 03h, 00h, 00h, 00h, 1fh, 00h, 00h
	defb	00h, 0ffh, 0ch, 0ch, 00h, 7fh, 07h, 07h
	defb	00h, 3fh, 01h, 01h, 00h, 1fh, 00h, 00h
	defb	00h, 0fh, 00h, 00h, 00h, 07h, 01h, 01h
	defb	00h, 02h, 00h, 00h, 00h, 07h, 00h, 00h
	defb	00h, 07h, 00h, 00h, 00h, 0fh, 00h, 00h
	defb	00h, 9fh, 02h, 02h, 00h, 0ffh, 03h, 03h
	defb	00h, 0ffh, 87h, 87h, 00h, 0ffh, 0c7h, 0c7h
	defb	00h, 0ffh, 0efh, 0edh, 00h, 0ffh, 7fh, 7dh
	defb	00h, 0ffh, 7fh, 60h, 04h, 0ffh, 0ffh, 0c0h
	defb	06h, 0ffh, 0ffh, 80h, 06h, 0ffh, 0ffh, 0e0h
	defb	07h, 0ffh, 7fh, 60h, 0fh, 0ffh, 0ffh, 0c0h
	defb	00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h
	defb	00h, 01h, 00h, 00h, 00h, 87h, 00h, 00h
	defb	00h, 8fh, 00h, 00h, 00h, 0dfh, 00h, 00h
	defb	00h, 0ffh, 02h, 02h, 00h, 0ffh, 86h, 86h
	defb	00h, 0ffh, 8eh, 8eh, 00h, 0ffh, 0deh, 0dah
	defb	00h, 0ffh, 0ffh, 0f3h, 00h, 0ffh, 0ffh, 63h
	defb	00h, 0ffh, 0ffh, 07h, 0e0h, 0ffh, 0feh, 06h
	defb	0e0h, 0ffh, 0feh, 0eh, 0c0h, 0ffh, 0ffh, 07h
	defb	00h, 60h, 00h, 00h, 00h, 0e0h, 00h, 00h
	defb	00h, 0c0h, 00h, 00h, 00h, 0c0h, 00h, 00h
	defb	00h, 0c0h, 00h, 00h, 00h, 80h, 00h, 00h
	defb	00h, 8eh, 00h, 00h, 00h, 0bch, 00h, 00h
	defb	00h, 0f8h, 00h, 00h, 00h, 0f8h, 00h, 00h
	defb	00h, 0f0h, 0c0h, 0c0h, 00h, 0e0h, 00h, 00h
	defb	00h, 0c0h, 00h, 00h, 00h, 0c0h, 00h, 00h
	defb	00h, 0e0h, 00h, 00h, 00h, 0f0h, 00h, 00h
	defb	00h, 07h, 03h, 03h, 00h, 0fh, 07h, 06h
	defb	00h, 3fh, 07h, 06h, 00h, 7fh, 0fh, 0ch
	defb	00h, 0ffh, 1fh, 1fh, 00h, 7fh, 00h, 00h
	defb	00h, 3fh, 00h, 00h, 00h, 0fh, 01h, 01h
	defb	00h, 07h, 01h, 01h, 00h, 03h, 01h, 01h
	defb	00h, 03h, 00h, 00h, 00h, 03h, 00h, 00h
	defb	00h, 02h, 00h, 00h, 00h, 00h, 00h, 00h
	defb	00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h
	defb	1bh, 0ffh, 0ffh, 80h, 31h, 0ffh, 0ffh, 00h
	defb	61h, 0ffh, 0ffh, 00h, 00h, 0ffh, 0ffh, 00h
	defb	00h, 0ffh, 0ffh, 82h, 00h, 0ffh, 0ffh, 0deh
	defb	00h, 0ffh, 0ffh, 9eh, 00h, 0ffh, 0e3h, 0e3h
	defb	00h, 0ffh, 83h, 83h, 00h, 0efh, 01h, 01h
	defb	00h, 0cfh, 01h, 01h, 00h, 07h, 01h, 01h
	defb	00h, 07h, 00h, 00h, 00h, 03h, 00h, 00h
	defb	00h, 03h, 00h, 00h, 00h, 02h, 00h, 00h
	defb	80h, 0ffh, 0ffh, 00h, 80h, 0ffh, 0ffh, 1fh
	defb	00h, 0ffh, 0ffh, 0fh, 00h, 0ffh, 0fch, 0ch
	defb	00h, 0ffh, 0fch, 64h, 00h, 0ffh, 0feh, 0f6h
	defb	00h, 0ffh, 0deh, 0deh, 00h, 0ffh, 0c7h, 0c7h
	defb	00h, 0ffh, 83h, 83h, 00h, 0ffh, 00h, 00h
	defb	00h, 0e3h, 00h, 00h, 00h, 0c1h, 00h, 00h
	defb	00h, 80h, 00h, 00h, 00h, 00h, 00h, 00h
	defb	00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h
	defb	00h, 0f8h, 0c0h, 0c0h, 00h, 0fch, 0f0h, 0f0h
	defb	00h, 0feh, 00h, 00h, 00h, 0ffh, 00h, 00h
	defb	00h, 0f0h, 00h, 00h, 00h, 80h, 00h, 00h
	defb	00h, 80h, 00h, 00h, 00h, 0c0h, 00h, 00h
	defb	00h, 0c0h, 00h, 00h, 00h, 0c0h, 00h, 00h
	defb	00h, 0e0h, 00h, 00h, 00h, 0e0h, 00h, 00h
	defb	00h, 60h, 00h, 00h, 00h, 00h, 00h, 00h
	defb	00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h
	defb	00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h
	defb	00h, 00h, 00h, 00h, 00h, 00h, 3fh, 3fh
	defb	00h, 00h, 7fh, 7fh, 24h, 00h, 0dbh, 0dbh
	defb	64h, 00h, 9bh, 9bh, 24h, 00h, 0dbh, 0dbh
	defb	24h, 00h, 0dbh, 0dbh, 24h, 00h, 0dbh, 0dbh
	defb	73h, 00h, 8ch, 8ch, 00h, 00h, 7fh, 7fh
	defb	00h, 00h, 3fh, 3fh, 00h, 00h, 00h, 00h
	defb	00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h
	defb	00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h
	defb	00h, 00h, 00h, 00h, 00h, 00h, 0f8h, 0f8h
	defb	00h, 00h, 0fch, 0fch, 0b8h, 00h, 46h, 46h
	defb	0a4h, 00h, 5ah, 5ah, 0a4h, 00h, 5ah, 5ah
	defb	0b8h, 00h, 46h, 46h, 0a0h, 00h, 5eh, 5eh
	defb	20h, 00h, 0deh, 0deh, 00h, 00h, 0fch, 0fch
	defb	00h, 00h, 0f8h, 0f8h, 00h, 00h, 00h, 00h
	defb	00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h
	defb	00h, 00h, 00h, 10h, 10h, 10h, 10h, 28h
	defb	10h, 10h, 10h, 28h, 30h, 30h, 30h, 49h
	defb	31h, 31h, 31h, 4ah, 73h, 72h, 73h, 8ch
	defb	77h, 74h, 77h, 88h, 77h, 77h, 77h, 88h
	defb	77h, 77h, 77h, 88h, 77h, 77h, 77h, 88h
	defb	77h, 77h, 77h, 88h, 23h, 63h, 23h, 94h
	defb	20h, 20h, 20h, 53h, 00h, 00h, 00h, 30h
	defb	00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h
	defb	00h, 00h, 00h, 10h, 10h, 10h, 10h, 28h
	defb	10h, 10h, 10h, 28h, 18h, 18h, 18h, 24h
	defb	18h, 18h, 18h, 0a4h, 9ch, 9ch, 9ch, 62h
	defb	0dch, 5ch, 0dch, 22h, 0dch, 0dch, 0dch, 22h
	defb	0dch, 0dch, 0dch, 22h, 0dch, 0dch, 0dch, 22h
	defb	0dch, 0dch, 0dch, 22h, 88h, 8ch, 88h, 52h
	defb	08h, 08h, 08h, 94h, 00h, 00h, 00h, 18h
	defb	00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h
	defb	00h, 00h, 00h, 01h, 00h, 01h, 00h, 02h
	defb	00h, 03h, 00h, 04h, 00h, 03h, 00h, 04h
	defb	00h, 07h, 00h, 0bh, 00h, 07h, 00h, 48h
	defb	00h, 47h, 00h, 0a8h, 00h, 6fh, 00h, 97h
	defb	00h, 7fh, 00h, 80h, 00h, 3fh, 00h, 40h
	defb	04h, 1bh, 04h, 20h, 03h, 0ch, 03h, 10h
	defb	00h, 07h, 00h, 08h, 00h, 03h, 00h, 04h
	defb	00h, 00h, 00h, 03h, 00h, 00h, 00h, 00h
	defb	00h, 00h, 00h, 00h, 00h, 00h, 00h, 80h
	defb	00h, 80h, 00h, 40h, 00h, 80h, 00h, 40h
	defb	00h, 0c0h, 00h, 0a0h, 00h, 0c0h, 00h, 24h
	defb	00h, 0c4h, 00h, 2ah, 00h, 0ech, 00h, 0d2h
	defb	00h, 0fch, 00h, 02h, 00h, 0f8h, 00h, 04h
	defb	40h, 0b0h, 40h, 08h, 80h, 60h, 80h, 10h
	defb	00h, 0c0h, 00h, 20h, 00h, 80h, 00h, 40h
	defb	00h, 00h, 00h, 80h, 00h, 00h, 00h, 00h
	defb	00h, 00h, 00h, 00h, 00h, 00h, 00h, 03h
	defb	00h, 03h, 00h, 04h, 03h, 04h, 03h, 08h
	defb	04h, 03h, 04h, 08h, 00h, 07h, 00h, 38h
	defb	30h, 37h, 00h, 48h, 30h, 37h, 00h, 48h
	defb	70h, 77h, 00h, 88h, 61h, 67h, 00h, 98h
	defb	01h, 05h, 00h, 6ah, 01h, 01h, 00h, 04h
	defb	01h, 01h, 00h, 00h, 01h, 01h, 00h, 00h
	defb	01h, 01h, 00h, 00h, 00h, 00h, 00h, 00h
	defb	00h, 00h, 00h, 00h, 00h, 00h, 00h, 80h
	defb	00h, 80h, 00h, 40h, 80h, 40h, 80h, 20h
	defb	40h, 80h, 40h, 20h, 00h, 0c0h, 00h, 38h
	defb	18h, 0d8h, 00h, 24h, 18h, 0d8h, 00h, 24h
	defb	1ch, 0dch, 00h, 22h, 0ch, 0cch, 00h, 32h
	defb	00h, 40h, 00h, 0ach, 00h, 00h, 00h, 40h
	defb	00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h
	defb	00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h
	defb	00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h
	defb	00h, 00h, 00h, 3fh, 3ch, 3dh, 00h, 42h
	defb	7ch, 7dh, 00h, 82h, 08h, 0bh, 00h, 74h
	defb	00h, 07h, 00h, 08h, 00h, 0fh, 00h, 10h
	defb	02h, 03h, 00h, 1ch, 04h, 05h, 00h, 02h
	defb	08h, 09h, 00h, 02h, 10h, 10h, 00h, 03h
	defb	00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h
	defb	00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h
	defb	00h, 00h, 00h, 00h, 00h, 00h, 00h, 0f0h
	defb	00h, 0f0h, 00h, 08h, 0e0h, 18h, 0e0h, 04h
	defb	30h, 0c8h, 30h, 04h, 10h, 0e8h, 10h, 04h
	defb	10h, 0e8h, 10h, 04h, 00h, 0f0h, 00h, 08h
	defb	00h, 0c0h, 00h, 38h, 30h, 0b0h, 00h, 48h
	defb	70h, 70h, 00h, 88h, 30h, 30h, 00h, 48h
	defb	30h, 30h, 00h, 48h, 20h, 20h, 00h, 50h
	defb	00h, 00h, 00h, 20h, 00h, 00h, 00h, 00h
	defb	00h, 00h, 00h, 06h, 06h, 06h, 00h, 09h
	defb	07h, 07h, 00h, 08h, 03h, 03h, 00h, 04h
	defb	00h, 00h, 00h, 0fh, 00h, 0fh, 00h, 10h
	defb	00h, 07h, 00h, 08h, 0fch, 0ffh, 00h, 00h
	defb	00h, 07h, 00h, 08h, 00h, 0fh, 00h, 10h
	defb	00h, 00h, 00h, 0fh, 03h, 03h, 00h, 04h
	defb	07h, 07h, 00h, 08h, 06h, 06h, 00h, 09h
	defb	00h, 00h, 00h, 06h, 00h, 00h, 00h, 00h
	defb	00h, 00h, 00h, 00h, 00h, 00h, 00h, 80h
	defb	80h, 80h, 00h, 40h, 80h, 80h, 00h, 40h
	defb	00h, 00h, 00h, 0f0h, 20h, 0d0h, 20h, 08h
	defb	10h, 0e8h, 10h, 04h, 10h, 0e8h, 10h, 04h
	defb	10h, 0e8h, 10h, 04h, 20h, 0d0h, 20h, 08h
	defb	00h, 00h, 00h, 0f0h, 80h, 80h, 00h, 40h
	defb	80h, 80h, 00h, 40h, 00h, 00h, 00h, 80h
	defb	00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h
	defb	00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h
	defb	00h, 00h, 00h, 00h, 10h, 10h, 00h, 03h
	defb	08h, 09h, 00h, 02h, 04h, 05h, 00h, 02h
	defb	02h, 03h, 00h, 1ch, 00h, 0fh, 00h, 10h
	defb	00h, 07h, 00h, 08h, 08h, 0bh, 00h, 74h
	defb	7ch, 7dh, 00h, 82h, 3ch, 3dh, 00h, 42h
	defb	00h, 00h, 00h, 3fh, 00h, 00h, 00h, 00h
	defb	00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h
	defb	00h, 00h, 00h, 20h, 20h, 20h, 00h, 50h
	defb	30h, 30h, 00h, 48h, 30h, 30h, 00h, 48h
	defb	70h, 70h, 00h, 88h, 30h, 0b0h, 00h, 48h
	defb	00h, 0c0h, 00h, 38h, 00h, 0f0h, 00h, 08h
	defb	10h, 0e8h, 10h, 04h, 10h, 0e8h, 10h, 04h
	defb	30h, 0c8h, 30h, 04h, 0e0h, 18h, 0e0h, 04h
	defb	00h, 0f0h, 00h, 08h, 00h, 00h, 00h, 0f0h
	defb	00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h
	defb	01h, 01h, 00h, 00h, 01h, 01h, 00h, 00h
	defb	01h, 01h, 00h, 00h, 01h, 01h, 00h, 04h
	defb	01h, 05h, 00h, 6ah, 61h, 67h, 00h, 98h
	defb	70h, 77h, 00h, 88h, 30h, 37h, 00h, 48h
	defb	30h, 37h, 00h, 48h, 00h, 07h, 00h, 38h
	defb	04h, 03h, 04h, 08h, 03h, 04h, 03h, 08h
	defb	00h, 03h, 00h, 04h, 00h, 00h, 00h, 03h
	defb	00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h
	defb	00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h
	defb	00h, 00h, 00h, 00h, 00h, 00h, 00h, 40h
	defb	00h, 40h, 00h, 0ach, 0ch, 0cch, 00h, 32h
	defb	1ch, 0dch, 00h, 22h, 18h, 0d8h, 00h, 24h
	defb	18h, 0d8h, 00h, 24h, 00h, 0c0h, 00h, 38h
	defb	40h, 80h, 40h, 20h, 80h, 40h, 80h, 20h
	defb	00h, 80h, 00h, 40h, 00h, 00h, 00h, 80h
	defb	00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h
	defb	00h, 00h, 00h, 08h, 08h, 08h, 00h, 14h
	defb	18h, 18h, 00h, 24h, 18h, 18h, 00h, 25h
	defb	1ch, 1dh, 00h, 22h, 18h, 1bh, 00h, 24h
	defb	00h, 07h, 00h, 38h, 00h, 1fh, 00h, 20h
	defb	10h, 2fh, 10h, 40h, 10h, 2fh, 10h, 40h
	defb	18h, 27h, 18h, 40h, 0eh, 31h, 0eh, 40h
	defb	00h, 1eh, 00h, 21h, 00h, 00h, 00h, 1eh
	defb	00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h
	defb	00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h
	defb	00h, 00h, 00h, 00h, 10h, 10h, 00h, 80h
	defb	20h, 20h, 00h, 80h, 40h, 40h, 00h, 80h
	defb	80h, 80h, 00h, 70h, 00h, 0e0h, 00h, 10h
	defb	00h, 0c0h, 00h, 20h, 20h, 0a0h, 00h, 5ch
	defb	7ch, 7ch, 00h, 82h, 78h, 78h, 00h, 84h
	defb	00h, 00h, 00h, 0f8h, 00h, 00h, 00h, 00h
	defb	00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h
	defb	00h, 00h, 00h, 00h, 00h, 00h, 00h, 03h
	defb	03h, 03h, 00h, 04h, 03h, 03h, 00h, 04h
	defb	00h, 00h, 00h, 1fh, 08h, 17h, 08h, 20h
	defb	10h, 2fh, 10h, 40h, 10h, 2fh, 10h, 40h
	defb	10h, 2fh, 10h, 40h, 08h, 17h, 08h, 20h
	defb	00h, 00h, 00h, 1fh, 03h, 03h, 00h, 04h
	defb	03h, 03h, 00h, 04h, 00h, 00h, 00h, 03h
	defb	00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h
	defb	00h, 00h, 00h, 0c0h, 0c0h, 0c0h, 00h, 20h
	defb	0c0h, 0c0h, 00h, 20h, 80h, 80h, 00h, 40h
	defb	00h, 00h, 00h, 0e0h, 00h, 0e0h, 00h, 10h
	defb	00h, 0c0h, 00h, 20h, 7eh, 0feh, 00h, 00h
	defb	00h, 0c0h, 00h, 20h, 00h, 0e0h, 00h, 10h
	defb	00h, 00h, 00h, 0e0h, 80h, 80h, 00h, 40h
	defb	0c0h, 0c0h, 00h, 20h, 0c0h, 0c0h, 00h, 20h
	defb	00h, 00h, 00h, 0c0h, 00h, 00h, 00h, 00h
	defb	00h, 00h, 00h, 00h, 00h, 00h, 00h, 1eh
	defb	00h, 1eh, 00h, 21h, 0eh, 31h, 0eh, 40h
	defb	18h, 27h, 18h, 40h, 10h, 2fh, 10h, 40h
	defb	10h, 2fh, 10h, 40h, 00h, 1fh, 00h, 20h
	defb	00h, 07h, 00h, 38h, 18h, 1bh, 00h, 24h
	defb	1ch, 1dh, 00h, 22h, 18h, 18h, 00h, 25h
	defb	18h, 18h, 00h, 24h, 08h, 08h, 00h, 14h
	defb	00h, 00h, 00h, 08h, 00h, 00h, 00h, 00h
	defb	00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h
	defb	00h, 00h, 00h, 0f8h, 78h, 78h, 00h, 84h
	defb	7ch, 7ch, 00h, 82h, 20h, 0a0h, 00h, 5ch
	defb	00h, 0c0h, 00h, 20h, 00h, 0e0h, 00h, 10h
	defb	80h, 80h, 00h, 70h, 40h, 40h, 00h, 80h
	defb	20h, 20h, 00h, 80h, 10h, 10h, 00h, 80h
	defb	00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h
	defb	00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h
	defb	00h, 00h, 00h, 40h, 00h, 40h, 40h, 0e3h
	defb	00h, 63h, 60h, 0f4h, 00h, 77h, 70h, 0f8h
	defb	03h, 6ch, 63h, 0f0h, 04h, 2bh, 24h, 70h
	defb	00h, 0fh, 00h, 30h, 00h, 0fh, 00h, 10h
	defb	00h, 0fh, 00h, 30h, 04h, 2bh, 24h, 70h
	defb	03h, 6ch, 63h, 0f0h, 00h, 77h, 70h, 0f8h
	defb	00h, 63h, 60h, 0f4h, 00h, 40h, 40h, 0e3h
	defb	00h, 00h, 00h, 40h, 00h, 00h, 00h, 00h
	defb	00h, 00h, 00h, 04h, 00h, 04h, 04h, 8eh
	defb	00h, 8ch, 0ch, 5eh, 00h, 0dch, 1ch, 3eh
	defb	80h, 6ch, 8ch, 1eh, 40h, 0a8h, 48h, 1ch
	defb	00h, 0e0h, 00h, 18h, 00h, 0e0h, 00h, 10h
	defb	00h, 0e0h, 00h, 18h, 40h, 0a8h, 48h, 1ch
	defb	80h, 6ch, 8ch, 1eh, 00h, 0dch, 1ch, 3eh
	defb	00h, 8ch, 0ch, 5eh, 00h, 04h, 04h, 8eh
	defb	00h, 00h, 00h, 04h, 00h, 00h, 00h, 00h
	defb	00h, 00h, 00h, 7fh, 3fh, 3fh, 3fh, 0c0h
	defb	5fh, 5fh, 5fh, 0a0h, 60h, 60h, 60h, 9fh
	defb	6ch, 6ch, 6ch, 93h, 6ah, 6bh, 6ah, 94h
	defb	67h, 67h, 67h, 98h, 63h, 67h, 63h, 98h
	defb	67h, 67h, 67h, 98h, 6ah, 6bh, 6ah, 94h
	defb	6ch, 6ch, 6ch, 93h, 60h, 60h, 60h, 9fh
	defb	5fh, 5fh, 5fh, 0bfh, 3fh, 3fh, 3fh, 0ffh
	defb	00h, 00h, 00h, 7fh, 00h, 00h, 00h, 00h
	defb	00h, 00h, 00h, 0fch, 0f8h, 0f8h, 0f8h, 06h
	defb	0f4h, 0f4h, 0f4h, 0eh, 0ch, 0ch, 0ch, 0feh
	defb	6ch, 6ch, 6ch, 9eh, 0ach, 0ach, 0ach, 5eh
	defb	0cch, 0cch, 0cch, 3eh, 8ch, 0cch, 8ch, 3eh
	defb	0cch, 0cch, 0cch, 3eh, 0ach, 0ach, 0ach, 5eh
	defb	6ch, 6ch, 6ch, 9eh, 0ch, 0ch, 0ch, 0feh
	defb	0f4h, 0f4h, 0f4h, 0feh, 0f8h, 0f8h, 0f8h, 0feh
	defb	00h, 00h, 00h, 0fch, 00h, 00h, 00h, 00h
	defb	00h, 00h, 00h, 70h, 70h, 70h, 70h, 8fh
	defb	6fh, 6fh, 6fh, 90h, 5fh, 5fh, 5fh, 0a0h
	defb	3ch, 3ch, 3ch, 43h, 3ah, 3bh, 3ah, 44h
	defb	37h, 37h, 37h, 48h, 33h, 37h, 33h, 48h
	defb	37h, 37h, 37h, 48h, 3ah, 3bh, 3ah, 44h
	defb	3ch, 3ch, 3ch, 43h, 5fh, 5fh, 5fh, 0a0h
	defb	6fh, 6fh, 6fh, 9fh, 70h, 70h, 70h, 8fh
	defb	00h, 00h, 00h, 70h, 00h, 00h, 00h, 00h
	defb	00h, 00h, 00h, 1ch, 1ch, 1ch, 1ch, 0e2h
	defb	0ech, 0ech, 0ech, 12h, 0f4h, 0f4h, 0f4h, 0ah
	defb	78h, 78h, 78h, 8ch, 0b8h, 0b8h, 0b8h, 4ch
	defb	0d8h, 0d8h, 0d8h, 2ch, 98h, 0d8h, 98h, 2ch
	defb	0d8h, 0d8h, 0d8h, 2ch, 0b8h, 0b8h, 0b8h, 4ch
	defb	78h, 78h, 78h, 9ch, 0f4h, 0f4h, 0f4h, 3ah
	defb	0ech, 0ech, 0ech, 0f2h, 1ch, 1ch, 1ch, 0e2h
	defb	00h, 00h, 00h, 1ch, 00h, 00h, 00h, 00h
