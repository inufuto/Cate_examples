cseg

CharPattern: public CharPattern
; ascii 28
	; " 0123456789ABCEFGHIMNOPRSTUV"
	defb 00h,00h,00h,00h,00h,00h,00h,00h
	defb 36h,0e3h,66h,7bh,76h,33h,30h,0e0h
	defb 17h,88h,11h,88h,11h,88h,70h,0e0h
	defb 36h,0e3h,01h,7eh,37h,0c0h,70h,0f0h
	defb 36h,0e3h,01h,3eh,06h,33h,30h,0e0h
	defb 00h,6eh,13h,0e6h,67h,6fh,00h,60h
	defb 76h,0f0h,70h,0e3h,06h,33h,30h,0e0h
	defb 13h,0e0h,67h,0eh,66h,33h,30h,0e0h
	defb 76h,0f3h,00h,6ch,11h,88h,10h,80h
	defb 36h,0e3h,63h,3eh,66h,33h,30h,0e0h
	defb 36h,0e3h,63h,3fh,06h,33h,30h,0e0h
	defb 13h,0c6h,66h,33h,76h,0f3h,60h,30h
	defb 76h,0e3h,67h,3eh,66h,33h,70h,0e0h
	defb 13h,0e3h,66h,00h,63h,03h,10h,0e0h
	defb 76h,0e0h,67h,0eh,66h,00h,70h,0e0h
	defb 76h,0e0h,67h,0eh,66h,00h,60h,00h
	defb 13h,0e3h,66h,0fh,63h,33h,10h,0f0h
	defb 66h,33h,67h,3fh,66h,33h,60h,30h
	defb 71h,0e8h,11h,88h,11h,88h,70h,0e0h
	defb 76h,0ebh,66h,0bbh,66h,0bbh,60h,0b0h
	defb 67h,33h,77h,0bfh,66h,0f7h,60h,30h
	defb 36h,0e3h,66h,33h,66h,33h,30h,0e0h
	defb 76h,0e3h,66h,33h,76h,0e0h,60h,00h
	defb 76h,0e3h,66h,37h,76h,0ceh,60h,70h
	defb 36h,0e3h,63h,0eh,06h,33h,30h,0e0h
	defb 71h,0e8h,11h,88h,11h,88h,10h,80h
	defb 66h,33h,66h,33h,66h,33h,30h,0e0h
	defb 66h,33h,63h,36h,31h,6ch,10h,0c0h

SpritePattern: public SpritePattern
;	sprite
	defb	00h, 00h, 00h, 00h, 00h, 7fh, 8ch, 00h
	defb	00h, 0fah, 0cch, 00h, 00h, 0aah, 0cch, 00h
	defb	00h, 0f7h, 0c8h, 00h, 00h, 7fh, 8ch, 00h
	defb	11h, 0ffh, 0eeh, 00h, 33h, 77h, 0bbh, 00h
	defb	30h, 74h, 0b8h, 00h, 00h, 0cch, 0cch, 00h
	defb	00h, 0cch, 0cch, 00h, 00h, 0cch, 0cch, 00h
	defb	00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h
	defb	00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h
	defb	00h, 00h, 00h, 00h, 00h, 7fh, 8ch, 00h
	defb	00h, 0fah, 0cch, 00h, 00h, 0aah, 0cch, 00h
	defb	00h, 0f7h, 0c8h, 00h, 00h, 73h, 88h, 00h
	defb	00h, 77h, 0eeh, 00h, 33h, 77h, 0fbh, 00h
	defb	30h, 77h, 0b0h, 00h, 00h, 0eeh, 0eeh, 00h
	defb	13h, 0c8h, 0e0h, 00h, 31h, 80h, 00h, 00h
	defb	00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h
	defb	00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h
	defb	00h, 00h, 00h, 00h, 00h, 7fh, 8ch, 00h
	defb	00h, 0fah, 0cch, 00h, 00h, 0aah, 0cch, 00h
	defb	00h, 0f7h, 0c8h, 00h, 00h, 73h, 88h, 00h
	defb	00h, 33h, 00h, 00h, 00h, 37h, 00h, 00h
	defb	00h, 76h, 00h, 00h, 00h, 00h, 88h, 00h
	defb	00h, 66h, 88h, 00h, 00h, 66h, 80h, 00h
	defb	00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h
	defb	00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h
	defb	00h, 00h, 00h, 00h, 00h, 7fh, 8ch, 00h
	defb	00h, 0fah, 0cch, 00h, 00h, 0aah, 0cch, 00h
	defb	00h, 0f7h, 0c8h, 00h, 00h, 73h, 88h, 00h
	defb	00h, 77h, 0aah, 00h, 11h, 0edh, 0bbh, 00h
	defb	10h, 0d3h, 0b8h, 00h, 00h, 55h, 0ffh, 00h
	defb	01h, 0ech, 70h, 00h, 10h, 0c8h, 00h, 00h
	defb	00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h
	defb	00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h
	defb	00h, 00h, 00h, 00h, 00h, 13h, 0efh, 00h
	defb	00h, 33h, 0f5h, 00h, 00h, 33h, 55h, 00h
	defb	00h, 31h, 0feh, 00h, 00h, 13h, 0efh, 00h
	defb	00h, 77h, 0ffh, 88h, 00h, 0ddh, 0eeh, 0cch
	defb	00h, 0d1h, 0e2h, 0c0h, 00h, 33h, 33h, 00h
	defb	00h, 33h, 33h, 00h, 00h, 33h, 33h, 00h
	defb	00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h
	defb	00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h
	defb	00h, 00h, 00h, 00h, 00h, 13h, 0efh, 00h
	defb	00h, 33h, 0f5h, 00h, 00h, 33h, 55h, 00h
	defb	00h, 31h, 0feh, 00h, 00h, 11h, 0ech, 00h
	defb	00h, 77h, 0eeh, 00h, 00h, 0fdh, 0eeh, 0cch
	defb	00h, 0d0h, 0eeh, 0c0h, 00h, 77h, 77h, 00h
	defb	00h, 70h, 31h, 8ch, 00h, 00h, 10h, 0c8h
	defb	00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h
	defb	00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h
	defb	00h, 00h, 00h, 00h, 00h, 13h, 0efh, 00h
	defb	00h, 33h, 0f5h, 00h, 00h, 33h, 55h, 00h
	defb	00h, 31h, 0feh, 00h, 00h, 11h, 0ech, 00h
	defb	00h, 00h, 0cch, 00h, 00h, 00h, 0ceh, 00h
	defb	00h, 00h, 0e6h, 00h, 00h, 11h, 00h, 00h
	defb	00h, 11h, 66h, 00h, 00h, 10h, 66h, 00h
	defb	00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h
	defb	00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h
	defb	00h, 00h, 00h, 00h, 00h, 13h, 0efh, 00h
	defb	00h, 33h, 0f5h, 00h, 00h, 33h, 55h, 00h
	defb	00h, 31h, 0feh, 00h, 00h, 11h, 0ech, 00h
	defb	00h, 55h, 0eeh, 00h, 00h, 0ddh, 7bh, 88h
	defb	00h, 0d1h, 0bch, 80h, 00h, 0ffh, 0aah, 00h
	defb	00h, 0e0h, 73h, 08h, 00h, 00h, 31h, 80h
	defb	00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h
	defb	00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h
	defb	00h, 00h, 00h, 00h, 00h, 00h, 06h, 00h
	defb	00h, 00h, 6eh, 00h, 33h, 0ddh, 88h, 0ffh
	defb	67h, 7fh, 0feh, 0f0h, 76h, 0f7h, 0eeh, 00h
	defb	77h, 0ffh, 0ffh, 0ffh, 30h, 0d0h, 8eh, 0f0h
	defb	00h, 00h, 0e6h, 00h, 00h, 00h, 00h, 00h
	defb	00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h
	defb	00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h
	defb	00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h
	defb	00h, 00h, 00h, 00h, 00h, 00h, 06h, 02h
	defb	00h, 00h, 66h, 27h, 33h, 0cch, 00h, 0eeh
	defb	67h, 6fh, 0ffh, 0c8h, 76h, 0f7h, 0ffh, 80h
	defb	77h, 0ffh, 0eeh, 0cch, 30h, 0c0h, 0ceh, 0cch
	defb	00h, 00h, 0e6h, 0c0h, 00h, 00h, 00h, 00h
	defb	00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h
	defb	00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h
	defb	00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h
	defb	00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h
	defb	00h, 00h, 00h, 00h, 33h, 0cch, 00h, 00h
	defb	67h, 6fh, 3fh, 77h, 76h, 0f7h, 0feh, 70h
	defb	77h, 0ffh, 00h, 0eeh, 30h, 0c0h, 00h, 00h
	defb	00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h
	defb	00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h
	defb	00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h
	defb	00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h
	defb	00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h
	defb	00h, 00h, 06h, 02h, 33h, 0cch, 66h, 77h
	defb	67h, 6fh, 0edh, 0e4h, 76h, 0f7h, 0dbh, 48h
	defb	77h, 0ffh, 0ffh, 88h, 30h, 0c0h, 0eh, 0cch
	defb	00h, 00h, 0e6h, 0cch, 00h, 00h, 00h, 00h
	defb	00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h
	defb	00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h
	defb	00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h
	defb	00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h
	defb	00h, 00h, 00h, 00h, 00h, 00h, 66h, 00h
	defb	03h, 0dh, 0e8h, 0fh, 37h, 0dfh, 8fh, 0ffh
	defb	66h, 77h, 0eeh, 00h, 76h, 0f7h, 0efh, 0fh
	defb	63h, 7dh, 0f8h, 0ffh, 00h, 00h, 0eeh, 00h
	defb	00h, 00h, 60h, 00h, 00h, 00h, 00h, 00h
	defb	00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h
	defb	00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h
	defb	00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h
	defb	00h, 00h, 00h, 00h, 00h, 00h, 66h, 00h
	defb	03h, 0ch, 0ech, 0cch, 37h, 0cfh, 0ceh, 0cch
	defb	66h, 77h, 0ffh, 00h, 76h, 0f6h, 0ffh, 8ch
	defb	63h, 6ch, 0f0h, 0ceh, 00h, 00h, 66h, 77h
	defb	00h, 00h, 60h, 20h, 00h, 00h, 00h, 00h
	defb	00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h
	defb	00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h
	defb	00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h
	defb	00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h
	defb	03h, 0ch, 00h, 00h, 37h, 0cfh, 00h, 0eh
	defb	66h, 77h, 0eeh, 00h, 76h, 0f6h, 0f3h, 77h
	defb	63h, 6ch, 30h, 70h, 00h, 00h, 00h, 00h
	defb	00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h
	defb	00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h
	defb	00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h
	defb	00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h
	defb	00h, 00h, 00h, 00h, 00h, 00h, 66h, 0cch
	defb	03h, 0ch, 0e0h, 0cch, 37h, 0cfh, 0fh, 0c8h
	defb	66h, 77h, 0bbh, 88h, 76h, 0f6h, 0deh, 4eh
	defb	63h, 6ch, 0e6h, 0e7h, 00h, 00h, 66h, 22h
	defb	00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h
	defb	00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h
	defb	00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h
	defb	00h, 33h, 33h, 00h, 00h, 33h, 33h, 00h
	defb	00h, 33h, 33h, 00h, 00h, 11h, 22h, 00h
	defb	00h, 0ddh, 0eeh, 0cch, 00h, 0d7h, 0efh, 0c8h
	defb	00h, 33h, 0ffh, 00h, 00h, 13h, 0efh, 00h
	defb	00h, 33h, 0f5h, 00h, 00h, 33h, 55h, 00h
	defb	00h, 31h, 0feh, 00h, 00h, 10h, 0e0h, 00h
	defb	00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h
	defb	00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h
	defb	00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h
	defb	00h, 00h, 00h, 00h, 00h, 66h, 00h, 00h
	defb	0fh, 71h, 0bh, 0ch, 0ffh, 1fh, 0bfh, 0ceh
	defb	00h, 77h, 0eeh, 66h, 0fh, 7fh, 0feh, 0e6h
	defb	0ffh, 0f1h, 0ebh, 6ch, 00h, 77h, 00h, 00h
	defb	00h, 60h, 00h, 00h, 00h, 00h, 00h, 00h
	defb	00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h
	defb	00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h
	defb	00h, 00h, 00h, 00h, 13h, 8ch, 13h, 8ch
	defb	36h, 0c6h, 36h, 0c6h, 66h, 66h, 66h, 66h
	defb	63h, 6ch, 63h, 6ch, 31h, 0cch, 33h, 0c8h
	defb	00h, 0bbh, 0ddh, 00h, 01h, 7fh, 0efh, 08h
	defb	13h, 0f9h, 0f9h, 8ch, 33h, 66h, 66h, 0cch
	defb	77h, 0f3h, 0fch, 0eeh, 76h, 31h, 0c8h, 0e6h
	defb	00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h
	defb	00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h
	defb	00h, 00h, 00h, 00h, 00h, 3fh, 0cfh, 00h
	defb	01h, 0ffh, 0ffh, 08h, 11h, 0ffh, 0ffh, 88h
	defb	33h, 11h, 88h, 0cch, 33h, 19h, 89h, 0cch
	defb	33h, 0ffh, 0ffh, 0cch, 31h, 0a8h, 51h, 0c8h
	defb	11h, 8ch, 13h, 88h, 11h, 0ffh, 0ffh, 88h
	defb	37h, 0fbh, 0fch, 0ceh, 77h, 0b1h, 0c8h, 0e6h
	defb	00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h
	defb	00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h
	defb	00h, 00h, 00h, 00h, 00h, 04h, 00h, 00h
	defb	07h, 4fh, 00h, 00h, 33h, 0ffh, 00h, 00h
	defb	00h, 40h, 00h, 00h, 00h, 00h, 00h, 00h
	defb	00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h
	defb	00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h
	defb	00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h
	defb	00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h
	defb	00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h
	defb	00h, 00h, 00h, 00h, 02h, 00h, 00h, 00h
	defb	2fh, 0eh, 00h, 00h, 0ffh, 0cch, 00h, 00h
	defb	20h, 00h, 00h, 00h, 00h, 00h, 00h, 00h
	defb	00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h
	defb	00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h
	defb	00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h
	defb	00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h
	defb	00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h
	defb	00h, 00h, 00h, 00h, 01h, 88h, 00h, 00h
	defb	11h, 88h, 00h, 00h, 11h, 88h, 00h, 00h
	defb	31h, 0c8h, 00h, 00h, 11h, 88h, 00h, 00h
	defb	00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h
	defb	00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h
	defb	00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h
	defb	00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h
	defb	00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h
	defb	11h, 88h, 00h, 00h, 13h, 8ch, 00h, 00h
	defb	31h, 0c8h, 00h, 00h, 11h, 88h, 00h, 00h
	defb	11h, 80h, 00h, 00h, 10h, 00h, 00h, 00h
	defb	00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h
	defb	00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h
	defb	00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h
	defb	00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h
	defb	00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h
	defb	00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h
	defb	00h, 00h, 00h, 00h, 11h, 11h, 88h, 0cch
	defb	31h, 22h, 55h, 22h, 11h, 22h, 55h, 22h
	defb	11h, 22h, 55h, 22h, 13h, 29h, 58h, 2ch
	defb	30h, 90h, 80h, 0c0h, 00h, 00h, 00h, 00h
	defb	00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h
	defb	00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h
	defb	00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h
	defb	00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h
	defb	00h, 00h, 00h, 00h, 33h, 11h, 88h, 0cch
	defb	40h, 0aah, 55h, 22h, 01h, 0a2h, 55h, 22h
	defb	22h, 22h, 55h, 22h, 47h, 29h, 58h, 2ch
	defb	70h, 90h, 80h, 0c0h, 00h, 00h, 00h, 00h
	defb	00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h
	defb	00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h
	defb	00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h
	defb	00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h
	defb	00h, 00h, 00h, 00h, 33h, 11h, 88h, 0cch
	defb	55h, 22h, 55h, 22h, 55h, 22h, 55h, 22h
	defb	77h, 0aah, 55h, 22h, 11h, 21h, 58h, 2ch
	defb	10h, 10h, 80h, 0c0h, 00h, 00h, 00h, 00h
	defb	00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h
	defb	00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h
	defb	00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h
	defb	00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h
	defb	00h, 00h, 00h, 00h, 33h, 11h, 88h, 0cch
	defb	44h, 0aah, 55h, 22h, 43h, 0a2h, 55h, 22h
	defb	44h, 0aah, 55h, 22h, 43h, 0a1h, 58h, 2ch
	defb	30h, 10h, 80h, 0c0h, 00h, 00h, 00h, 00h
	defb	00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h
	defb	00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h
	defb	00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h
	defb	0ffh, 0ffh, 0ffh, 0ffh, 88h, 00h, 00h, 11h
	defb	88h, 00h, 00h, 11h, 88h, 00h, 00h, 11h
	defb	88h, 00h, 11h, 0ddh, 88h, 00h, 11h, 0ddh
	defb	88h, 11h, 0ddh, 0ddh, 88h, 11h, 0ddh, 0ddh
	defb	89h, 1dh, 0ddh, 0ddh, 99h, 0ddh, 0ddh, 0ddh
	defb	98h, 0d0h, 0d0h, 0d1h, 0ffh, 0ffh, 0ffh, 0ffh
	defb	00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h
	defb	00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h
	defb	00h, 00h, 00h, 00h, 00h, 00h, 00h, 0eeh
	defb	00h, 00h, 0eh, 0eeh, 00h, 00h, 0eeh, 0eeh
	defb	00h, 0eeh, 0eeh, 0eeh, 06h, 0eeh, 0eeh, 0e0h
	defb	66h, 0eeh, 0eeh, 0eeh, 66h, 0eeh, 0fh, 0eeh
	defb	66h, 0e0h, 0ffh, 0eeh, 66h, 0ffh, 0ffh, 0eeh
	defb	07h, 0ffh, 0ffh, 0eeh, 70h, 0f0h, 0f0h, 0e0h
	defb	00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h
	defb	00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h
	defb	00h, 00h, 00h, 00h, 33h, 0ffh, 0ffh, 0cch
	defb	33h, 0ffh, 0ffh, 0cch, 33h, 0ffh, 0ffh, 0cch
	defb	33h, 0ffh, 0feh, 0cch, 33h, 0ffh, 0edh, 0c4h
	defb	33h, 0ffh, 0ddh, 44h, 33h, 0ffh, 0efh, 0cch
	defb	33h, 0ffh, 0ffh, 0cch, 33h, 0ffh, 0ffh, 0cch
	defb	33h, 0ffh, 0ffh, 0cch, 30h, 0f0h, 0f0h, 0c0h
	defb	00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h
	defb	00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h
	; title 20
	defb 00h,0ffh,0ffh,0ffh,00h,0ffh,0ffh,0ffh
	defb 00h,0ffh,0ffh,00h,00h,0ffh,0ffh,00h
	defb 00h,0ffh,0ffh,00h,00h,0ffh,0ffh,00h
	defb 00h,0ffh,0ffh,00h,00h,0ffh,0ffh,00h
	defb 0ffh,0ffh,0ffh,00h,0ffh,0ffh,0ffh,00h
	defb 0ffh,00h,0ffh,0ffh,0ffh,00h,0ffh,0ffh
	defb 0ffh,00h,0ffh,0ffh,0ffh,00h,0ffh,0ffh
	defb 0ffh,00h,0ffh,0ffh,0ffh,00h,0ffh,0ffh
	defb 00h,00h,00h,0ffh,00h,00h,00h,0ffh
	defb 00h,00h,0ffh,0ffh,00h,00h,0ffh,0ffh
	defb 00h,0ffh,0ffh,00h,00h,0ffh,0ffh,00h
	defb 00h,0ffh,0ffh,00h,00h,0ffh,0ffh,00h
	defb 0ffh,0ffh,00h,00h,0ffh,0ffh,00h,00h
	defb 00h,0ffh,0ffh,00h,00h,0ffh,0ffh,00h
	defb 00h,00h,0ffh,0ffh,00h,00h,0ffh,0ffh
	defb 00h,00h,0ffh,0ffh,00h,00h,0ffh,0ffh
	defb 00h,0ffh,0ffh,0ffh,00h,0ffh,0ffh,0ffh
	defb 00h,00h,00h,00h,00h,00h,00h,00h
	defb 00h,00h,00h,00h,00h,00h,00h,00h
	defb 00h,00h,00h,0ffh,00h,00h,00h,0ffh
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh
	defb 00h,0ffh,0ffh,00h,00h,0ffh,0ffh,00h
	defb 0ffh,0ffh,00h,00h,0ffh,0ffh,00h,00h
	defb 0ffh,00h,00h,00h,0ffh,00h,00h,00h
	defb 00h,0ffh,0ffh,00h,00h,0ffh,0ffh,00h
	defb 00h,0ffh,0ffh,00h,00h,0ffh,0ffh,00h
	defb 00h,0ffh,0ffh,00h,00h,0ffh,0ffh,00h
	defb 00h,00h,0ffh,0ffh,00h,00h,0ffh,0ffh
	defb 00h,0ffh,0ffh,00h,00h,0ffh,0ffh,00h
	defb 00h,0ffh,0ffh,00h,00h,0ffh,0ffh,00h
	defb 00h,0ffh,0ffh,00h,00h,0ffh,0ffh,00h
	defb 0ffh,0ffh,00h,00h,0ffh,0ffh,00h,00h
	defb 00h,00h,0ffh,0ffh,00h,00h,0ffh,0ffh
	defb 00h,0ffh,0ffh,00h,00h,0ffh,0ffh,00h
	defb 00h,00h,00h,00h,00h,00h,00h,00h
	defb 00h,00h,00h,0ffh,00h,00h,00h,0ffh
	defb 0ffh,0ffh,0ffh,00h,0ffh,0ffh,0ffh,00h
	defb 00h,00h,0ffh,0ffh,00h,00h,0ffh,0ffh
	defb 00h,0ffh,0ffh,0ffh,00h,0ffh,0ffh,0ffh
	defb 0ffh,0ffh,0ffh,00h,0ffh,0ffh,0ffh,00h
	defb 00h,0ffh,0ffh,00h,00h,0ffh,0ffh,00h
	defb 00h,0ffh,0ffh,00h,00h,0ffh,0ffh,00h
	defb 00h,0ffh,0ffh,00h,00h,0ffh,0ffh,00h
	defb 00h,00h,00h,00h,00h,00h,00h,00h
	defb 0ffh,00h,0ffh,0ffh,0ffh,00h,0ffh,0ffh
	defb 0ffh,00h,0ffh,0ffh,0ffh,00h,0ffh,0ffh
	defb 0ffh,00h,0ffh,0ffh,0ffh,00h,0ffh,0ffh
	defb 00h,00h,00h,00h,00h,00h,00h,00h
	defb 00h,0ffh,0ffh,0ffh,00h,0ffh,0ffh,0ffh
	defb 00h,0ffh,0ffh,00h,00h,0ffh,0ffh,00h
	defb 00h,0ffh,0ffh,00h,00h,0ffh,0ffh,00h
	defb 00h,00h,00h,00h,00h,00h,00h,00h
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh
	defb 00h,00h,0ffh,0ffh,00h,00h,0ffh,0ffh
	defb 00h,00h,0ffh,0ffh,00h,00h,0ffh,0ffh
	defb 00h,00h,00h,00h,00h,00h,00h,00h
	defb 00h,00h,0ffh,0ffh,00h,00h,0ffh,0ffh
	defb 00h,0ffh,0ffh,00h,00h,0ffh,0ffh,00h
	defb 00h,0ffh,0ffh,0ffh,00h,0ffh,0ffh,0ffh
	defb 00h,00h,00h,00h,00h,00h,00h,00h
	defb 00h,00h,00h,00h,00h,00h,00h,00h
	defb 00h,00h,00h,00h,00h,00h,00h,00h
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh
	defb 00h,00h,00h,00h,00h,00h,00h,00h
	defb 00h,00h,00h,0ffh,00h,00h,00h,0ffh
	defb 00h,00h,00h,0ffh,00h,00h,00h,0ffh
	defb 00h,00h,00h,0ffh,00h,00h,00h,0ffh
	defb 00h,00h,00h,00h,00h,00h,00h,00h
	defb 0ffh,00h,00h,00h,0ffh,00h,00h,00h
	defb 0ffh,00h,00h,00h,0ffh,00h,00h,00h
	defb 0ffh,00h,00h,00h,0ffh,00h,00h,00h
	defb 00h,00h,00h,00h,00h,00h,00h,00h
	defb 00h,00h,0ffh,0ffh,00h,00h,0ffh,0ffh
	defb 00h,0ffh,0ffh,0ffh,00h,0ffh,0ffh,0ffh
	defb 00h,0ffh,0ffh,0ffh,00h,0ffh,0ffh,0ffh
	defb 00h,00h,00h,00h,00h,00h,00h,00h
	defb 0ffh,0ffh,00h,00h,0ffh,0ffh,00h,00h
	defb 00h,00h,00h,00h,00h,00h,00h,00h
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh
	defb 00h,00h,00h,00h,00h,00h,00h,00h
