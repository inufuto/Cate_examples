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
	defb	00h, 00h, 0ffh, 00h, 07h, 3ch, 0ffh, 84h
	defb	71h, 0ffh, 0fh, 40h, 00h, 3ch, 0ffh, 88h
	defb	00h, 0fah, 1eh, 0c0h, 00h, 0aah, 0eeh, 00h
	defb	00h, 77h, 0cch, 00h, 00h, 07h, 0dh, 00h
	defb	00h, 77h, 0dbh, 00h, 00h, 70h, 77h, 00h
	defb	00h, 6ch, 61h, 00h, 01h, 0cch, 37h, 00h
	defb	00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h
	defb	00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h
	defb	00h, 00h, 0ffh, 00h, 07h, 3ch, 0ffh, 84h
	defb	71h, 0ffh, 0fh, 40h, 00h, 3ch, 0ffh, 88h
	defb	00h, 0fah, 1eh, 0c0h, 00h, 0aah, 0eeh, 00h
	defb	00h, 77h, 0cch, 00h, 00h, 07h, 1eh, 8ch
	defb	03h, 77h, 0eeh, 0c6h, 33h, 70h, 0e0h, 66h
	defb	00h, 20h, 4ch, 00h, 00h, 13h, 0c8h, 00h
	defb	00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h
	defb	00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h
	defb	00h, 0ffh, 00h, 00h, 12h, 0ffh, 0c3h, 0eh
	defb	20h, 0fh, 0ffh, 0e8h, 11h, 0ffh, 0c3h, 00h
	defb	30h, 87h, 0f5h, 00h, 00h, 77h, 55h, 00h
	defb	00h, 33h, 0eeh, 00h, 00h, 0bh, 0eh, 00h
	defb	00h, 0bdh, 0eeh, 00h, 00h, 0eeh, 0e0h, 00h
	defb	00h, 68h, 63h, 00h, 00h, 0ceh, 33h, 08h
	defb	00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h
	defb	00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h
	defb	00h, 0ffh, 00h, 00h, 12h, 0ffh, 0c3h, 0eh
	defb	20h, 0fh, 0ffh, 0e8h, 11h, 0ffh, 0c3h, 00h
	defb	30h, 87h, 0f5h, 00h, 00h, 77h, 55h, 00h
	defb	00h, 33h, 0eeh, 00h, 13h, 87h, 0eh, 00h
	defb	36h, 77h, 0eeh, 0ch, 66h, 70h, 0e0h, 0cch
	defb	00h, 23h, 40h, 00h, 00h, 31h, 8ch, 00h
	defb	00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h
	defb	00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h
	defb	00h, 0ffh, 88h, 00h, 10h, 77h, 0ceh, 00h
	defb	00h, 7fh, 0eeh, 00h, 33h, 77h, 0ddh, 88h
	defb	73h, 9eh, 3fh, 0c8h, 31h, 0ffh, 0ffh, 80h
	defb	00h, 77h, 0cch, 00h, 00h, 0fh, 0fh, 00h
	defb	02h, 0ffh, 0ffh, 00h, 22h, 0f0h, 0e0h, 00h
	defb	00h, 0eeh, 0eeh, 00h, 00h, 0eeh, 0e0h, 00h
	defb	00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h
	defb	00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h
	defb	00h, 0ffh, 88h, 00h, 10h, 77h, 0ceh, 00h
	defb	00h, 7fh, 0eeh, 00h, 33h, 77h, 0ddh, 88h
	defb	73h, 9eh, 3fh, 0c8h, 31h, 0ffh, 0ffh, 80h
	defb	00h, 77h, 0cch, 00h, 01h, 0fh, 0eh, 00h
	defb	11h, 0ffh, 0eeh, 08h, 00h, 0f0h, 0e0h, 88h
	defb	00h, 0eeh, 0eeh, 00h, 00h, 0e0h, 0eeh, 00h
	defb	00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h
	defb	00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h
	defb	00h, 13h, 0eeh, 00h, 00h, 77h, 0dch, 00h
	defb	01h, 0fh, 0fh, 00h, 33h, 87h, 3dh, 88h
	defb	62h, 0fdh, 0e6h, 0c8h, 20h, 0ddh, 66h, 80h
	defb	00h, 77h, 0cch, 00h, 00h, 0fh, 0dh, 00h
	defb	02h, 0ffh, 0dbh, 00h, 22h, 0f0h, 66h, 00h
	defb	00h, 0eeh, 0ch, 00h, 00h, 0eeh, 0c0h, 00h
	defb	00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h
	defb	00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h
	defb	00h, 33h, 0eeh, 00h, 00h, 77h, 0dch, 00h
	defb	01h, 0fh, 0fh, 00h, 33h, 87h, 3dh, 88h
	defb	62h, 0fdh, 0e6h, 0c8h, 20h, 0ddh, 66h, 80h
	defb	00h, 77h, 0cch, 00h, 01h, 07h, 0eh, 00h
	defb	11h, 7bh, 0eeh, 08h, 00h, 0dch, 0e0h, 88h
	defb	00h, 06h, 0eeh, 00h, 00h, 60h, 0eeh, 00h
	defb	00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h
	defb	00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h
	defb	00h, 44h, 88h, 00h, 00h, 6fh, 0ceh, 00h
	defb	01h, 0fah, 0efh, 00h, 11h, 0aah, 0ffh, 00h
	defb	11h, 0f5h, 0f7h, 00h, 15h, 50h, 77h, 06h
	defb	66h, 0ffh, 0eeh, 0eeh, 31h, 0ffh, 0ffh, 0c8h
	defb	10h, 0ffh, 0ffh, 80h, 00h, 77h, 0eeh, 00h
	defb	00h, 31h, 0efh, 00h, 00h, 10h, 0f7h, 08h
	defb	00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h
	defb	00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h
	defb	00h, 00h, 00h, 00h, 00h, 46h, 8ch, 00h
	defb	00h, 6fh, 0ceh, 00h, 11h, 0aah, 0ffh, 00h
	defb	11h, 0afh, 0ffh, 00h, 11h, 0f5h, 0f7h, 00h
	defb	11h, 00h, 77h, 00h, 37h, 0ffh, 0ffh, 8ch
	defb	7dh, 0ffh, 0ffh, 0c6h, 00h, 0ffh, 0ffh, 00h
	defb	00h, 73h, 0efh, 06h, 00h, 31h, 0ffh, 6ch
	defb	00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h
	defb	00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h
	defb	00h, 11h, 22h, 00h, 00h, 37h, 6fh, 00h
	defb	00h, 7fh, 0f5h, 08h, 00h, 0ffh, 55h, 88h
	defb	00h, 0feh, 0fah, 88h, 06h, 0eeh, 0a0h, 8ah
	defb	77h, 77h, 0ffh, 66h, 31h, 0ffh, 0ffh, 0c8h
	defb	10h, 0ffh, 0ffh, 80h, 00h, 77h, 0eeh, 00h
	defb	00h, 7fh, 0c8h, 00h, 01h, 0feh, 80h, 00h
	defb	00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h
	defb	00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h
	defb	00h, 00h, 00h, 00h, 00h, 13h, 26h, 00h
	defb	00h, 37h, 6fh, 00h, 00h, 0ffh, 55h, 88h
	defb	00h, 0ffh, 5fh, 88h, 00h, 0feh, 0fah, 88h
	defb	00h, 0eeh, 00h, 88h, 13h, 0ffh, 0ffh, 0ceh
	defb	36h, 0ffh, 0ffh, 0ebh, 00h, 0ffh, 0ffh, 00h
	defb	06h, 7fh, 0ech, 00h, 63h, 0ffh, 0c8h, 00h
	defb	00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h
	defb	00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h
	defb	00h, 22h, 44h, 00h, 00h, 6fh, 6fh, 00h
	defb	01h, 0ffh, 0ffh, 08h, 11h, 0ffh, 0ffh, 88h
	defb	11h, 0ffh, 0ffh, 88h, 15h, 0ffh, 0ffh, 8ah
	defb	66h, 0ffh, 0ffh, 66h, 31h, 0ffh, 0ffh, 0c8h
	defb	10h, 0ffh, 0ffh, 80h, 00h, 0ffh, 0ffh, 00h
	defb	00h, 73h, 0ech, 00h, 00h, 31h, 0c8h, 00h
	defb	00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h
	defb	00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h
	defb	00h, 00h, 00h, 00h, 00h, 26h, 46h, 00h
	defb	00h, 6fh, 6fh, 00h, 11h, 0ffh, 0ffh, 88h
	defb	11h, 0ffh, 0ffh, 88h, 11h, 0ffh, 0ffh, 88h
	defb	11h, 0ffh, 0ffh, 88h, 03h, 0ffh, 0ffh, 0ch
	defb	36h, 0ffh, 0ffh, 0c6h, 00h, 0ffh, 0ffh, 00h
	defb	00h, 0f7h, 0feh, 00h, 00h, 73h, 0ech, 00h
	defb	00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h
	defb	00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h
	defb	00h, 22h, 44h, 00h, 00h, 6fh, 6fh, 00h
	defb	01h, 0fdh, 0fbh, 08h, 11h, 0ddh, 0bbh, 88h
	defb	11h, 0fah, 0f5h, 88h, 15h, 0a8h, 51h, 8ah
	defb	66h, 0ffh, 0ffh, 66h, 31h, 0ffh, 0ffh, 0c8h
	defb	10h, 0ffh, 0ffh, 80h, 00h, 0ffh, 0ffh, 00h
	defb	00h, 73h, 0ech, 00h, 00h, 31h, 0c8h, 00h
	defb	00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h
	defb	00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h
	defb	00h, 00h, 00h, 00h, 00h, 26h, 46h, 00h
	defb	00h, 6fh, 6fh, 00h, 11h, 0ddh, 0bbh, 88h
	defb	11h, 0dfh, 0bfh, 88h, 11h, 0fah, 0f5h, 88h
	defb	11h, 88h, 11h, 88h, 03h, 0ffh, 0ffh, 0ch
	defb	36h, 0ffh, 0ffh, 0c6h, 00h, 0ffh, 0ffh, 00h
	defb	00h, 0f7h, 0feh, 00h, 00h, 73h, 0ech, 00h
	defb	00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h
	defb	00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h
	defb	00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h
	defb	00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h
	defb	00h, 03h, 0fah, 00h, 00h, 3eh, 0a4h, 00h
	defb	00h, 88h, 22h, 88h, 11h, 0a3h, 72h, 00h
	defb	11h, 38h, 26h, 00h, 00h, 0ffh, 0cch, 00h
	defb	00h, 70h, 00h, 00h, 00h, 00h, 00h, 00h
	defb	00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h
	defb	00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h
	defb	00h, 00h, 00h, 00h, 00h, 01h, 00h, 00h
	defb	00h, 11h, 00h, 00h, 00h, 33h, 88h, 00h
	defb	11h, 6ch, 0d7h, 00h, 11h, 0c4h, 75h, 00h
	defb	33h, 11h, 11h, 88h, 22h, 37h, 8ch, 88h
	defb	23h, 77h, 0cdh, 88h, 11h, 33h, 99h, 00h
	defb	10h, 87h, 3ch, 00h, 00h, 70h, 0c0h, 00h
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
	defb	00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h
	defb	00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h
	defb	00h, 00h, 00h, 00h, 00h, 13h, 8ch, 00h
	defb	00h, 33h, 0cch, 00h, 00h, 10h, 80h, 00h
	defb	00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h
	defb	00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h
	defb	00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h
	defb	00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h
	defb	00h, 00h, 00h, 00h, 01h, 7fh, 0efh, 08h
	defb	13h, 0fdh, 0fdh, 8ch, 77h, 0f7h, 0f7h, 0e6h
	defb	30h, 0f0h, 0f0h, 0c0h, 12h, 5ah, 5ah, 48h
	defb	12h, 5ah, 5ah, 48h, 03h, 0fh, 0fh, 0ch
	defb	33h, 0ffh, 0ffh, 0cch, 30h, 0f0h, 0f0h, 0c0h
	defb	77h, 0ffh, 0ffh, 0eeh, 30h, 0f0h, 0f0h, 0c0h
	defb	00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h
	defb	00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h
; title 20
	defb 00h,00h,00h,00h,00h,00h,00h,00h
	defb 00h,00h,00h,0ffh,00h,00h,00h,0ffh
	defb 00h,00h,00h,0ffh,00h,00h,00h,0ffh
	defb 00h,00h,00h,0ffh,00h,00h,00h,0ffh
	defb 00h,00h,00h,00h,00h,00h,00h,00h
	defb 0ffh,00h,00h,00h,0ffh,00h,00h,00h
	defb 0ffh,0ffh,00h,0ffh,0ffh,0ffh,00h,0ffh
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh
	defb 00h,00h,00h,00h,00h,00h,00h,00h
	defb 0ffh,0ffh,00h,00h,0ffh,0ffh,00h,00h
	defb 0ffh,0ffh,00h,0ffh,0ffh,0ffh,00h,0ffh
	defb 0ffh,0ffh,00h,00h,0ffh,0ffh,00h,00h
	defb 00h,00h,00h,00h,00h,00h,00h,00h
	defb 00h,00h,00h,00h,00h,00h,00h,00h
	defb 0ffh,00h,00h,00h,0ffh,00h,00h,00h
	defb 00h,00h,00h,0ffh,00h,00h,00h,0ffh
	defb 00h,00h,00h,00h,00h,00h,00h,00h
	defb 00h,00h,00h,00h,00h,00h,00h,00h
	defb 00h,00h,00h,00h,00h,00h,00h,00h
	defb 0ffh,0ffh,00h,00h,0ffh,0ffh,00h,00h
	defb 00h,00h,00h,00h,00h,00h,00h,00h
	defb 00h,00h,00h,00h,00h,00h,00h,00h
	defb 00h,00h,00h,00h,00h,00h,00h,00h
	defb 0ffh,0ffh,00h,0ffh,0ffh,0ffh,00h,0ffh
	defb 00h,00h,00h,00h,00h,00h,00h,00h
	defb 00h,00h,00h,00h,00h,00h,00h,00h
	defb 00h,00h,00h,00h,00h,00h,00h,00h
	defb 0ffh,00h,00h,0ffh,0ffh,00h,00h,0ffh
	defb 00h,00h,00h,00h,00h,00h,00h,00h
	defb 00h,00h,00h,00h,00h,00h,00h,00h
	defb 00h,00h,00h,00h,00h,00h,00h,00h
	defb 0ffh,0ffh,00h,00h,0ffh,0ffh,00h,00h
	defb 00h,00h,00h,00h,00h,00h,00h,00h
	defb 00h,00h,00h,00h,00h,00h,00h,00h
	defb 00h,00h,00h,00h,00h,00h,00h,00h
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh
	defb 00h,00h,00h,00h,00h,00h,00h,00h
	defb 00h,00h,00h,00h,00h,00h,00h,00h
	defb 00h,00h,00h,00h,00h,00h,00h,00h
	defb 00h,00h,00h,00h,00h,00h,00h,00h
	defb 00h,00h,00h,0ffh,00h,00h,00h,0ffh
	defb 00h,00h,00h,0ffh,00h,00h,00h,0ffh
	defb 00h,00h,00h,0ffh,00h,00h,00h,0ffh
	defb 00h,00h,00h,0ffh,00h,00h,00h,0ffh
	defb 0ffh,00h,0ffh,00h,0ffh,00h,0ffh,00h
	defb 0ffh,00h,00h,00h,0ffh,00h,00h,00h
	defb 0ffh,00h,00h,00h,0ffh,00h,00h,00h
	defb 0ffh,00h,00h,00h,0ffh,00h,00h,00h
	defb 0ffh,0ffh,00h,0ffh,0ffh,0ffh,00h,0ffh
	defb 0ffh,0ffh,00h,0ffh,0ffh,0ffh,00h,0ffh
	defb 0ffh,0ffh,00h,0ffh,0ffh,0ffh,00h,0ffh
	defb 0ffh,0ffh,00h,0ffh,0ffh,0ffh,00h,0ffh
	defb 0ffh,00h,0ffh,0ffh,0ffh,00h,0ffh,0ffh
	defb 0ffh,00h,0ffh,0ffh,0ffh,00h,0ffh,0ffh
	defb 0ffh,00h,0ffh,0ffh,0ffh,00h,0ffh,0ffh
	defb 0ffh,00h,00h,0ffh,0ffh,00h,00h,0ffh
	defb 00h,0ffh,0ffh,00h,00h,0ffh,0ffh,00h
	defb 0ffh,0ffh,0ffh,00h,0ffh,0ffh,0ffh,00h
	defb 00h,00h,00h,00h,00h,00h,00h,00h
	defb 0ffh,0ffh,00h,00h,0ffh,0ffh,00h,00h
	defb 0ffh,0ffh,00h,0ffh,0ffh,0ffh,00h,0ffh
	defb 00h,0ffh,0ffh,0ffh,00h,0ffh,0ffh,0ffh
	defb 00h,00h,00h,0ffh,00h,00h,00h,0ffh
	defb 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh
	defb 0ffh,00h,0ffh,0ffh,0ffh,00h,0ffh,0ffh
	defb 0ffh,00h,0ffh,0ffh,0ffh,00h,0ffh,0ffh
	defb 0ffh,00h,0ffh,0ffh,0ffh,00h,0ffh,0ffh
	defb 00h,00h,00h,0ffh,00h,00h,00h,0ffh
	defb 00h,0ffh,0ffh,00h,00h,0ffh,0ffh,00h
	defb 0ffh,0ffh,0ffh,00h,0ffh,0ffh,0ffh,00h
	defb 00h,00h,00h,00h,00h,00h,00h,00h
	defb 0ffh,0ffh,0ffh,00h,0ffh,0ffh,0ffh,00h
	defb 0ffh,0ffh,00h,0ffh,0ffh,0ffh,00h,0ffh
	defb 0ffh,0ffh,00h,0ffh,0ffh,0ffh,00h,0ffh
	defb 0ffh,0ffh,00h,0ffh,0ffh,0ffh,00h,0ffh
	defb 0ffh,0ffh,00h,0ffh,0ffh,0ffh,00h,0ffh
	defb 0ffh,00h,00h,00h,0ffh,00h,00h,00h
	defb 0ffh,00h,00h,00h,0ffh,00h,00h,00h
	defb 0ffh,00h,00h,00h,0ffh,00h,00h,00h
	defb 0ffh,00h,00h,00h,0ffh,00h,00h,00h
