cseg

MonoPattern: public MonoPattern
; ascii 31
	; " -0123456789ABCEFGHIKMNOPRSTUVY"
	defb 00h,00h,00h,00h,00h,00h,00h,00h
	defb 00h,00h,00h,7eh,00h,00h,00h,00h
	defb 7ch,0c6h,0e6h,0d6h,0ceh,0c6h,7ch,00h
	defb 18h,1eh,18h,18h,18h,18h,7eh,00h
	defb 7ch,0c6h,0e0h,78h,3ch,0eh,0feh,00h
	defb 7ch,0c6h,0c0h,78h,0c0h,0c6h,7ch,00h
	defb 60h,70h,78h,6ch,66h,0feh,60h,00h
	defb 0feh,06h,7eh,0c0h,0c0h,0c6h,7ch,00h
	defb 78h,0ch,06h,7eh,0c6h,0c6h,7ch,00h
	defb 0feh,0c6h,60h,30h,18h,18h,18h,00h
	defb 7ch,0c6h,0c6h,7ch,0c6h,0c6h,7ch,00h
	defb 7ch,0c6h,0c6h,0fch,0c0h,0c6h,7ch,00h
	defb 38h,6ch,0c6h,0c6h,0feh,0c6h,0c6h,00h
	defb 7eh,0c6h,0c6h,7eh,0c6h,0c6h,7eh,00h
	defb 78h,0cch,06h,06h,06h,0cch,78h,00h
	defb 7eh,06h,06h,7eh,06h,06h,7eh,00h
	defb 7eh,06h,06h,7eh,06h,06h,06h,00h
	defb 78h,0cch,06h,0f6h,0c6h,0cch,0f8h,00h
	defb 0c6h,0c6h,0c6h,0feh,0c6h,0c6h,0c6h,00h
	defb 7eh,18h,18h,18h,18h,18h,7eh,00h
	defb 0c6h,66h,36h,1eh,36h,66h,0c6h,00h
	defb 7eh,0d6h,0d6h,0d6h,0d6h,0d6h,0d6h,00h
	defb 0c6h,0ceh,0deh,0feh,0f6h,0e6h,0c6h,00h
	defb 7ch,0c6h,0c6h,0c6h,0c6h,0c6h,7ch,00h
	defb 7eh,0c6h,0c6h,0c6h,7eh,06h,06h,00h
	defb 7eh,0c6h,0c6h,0e6h,3eh,76h,0e6h,00h
	defb 7ch,0c6h,06h,7ch,0c0h,0c6h,7ch,00h
	defb 7eh,18h,18h,18h,18h,18h,18h,00h
	defb 0c6h,0c6h,0c6h,0c6h,0c6h,0c6h,7ch,00h
	defb 0c6h,0c6h,0c6h,6ch,6ch,38h,38h,00h
	defb 66h,66h,66h,3ch,18h,18h,18h,00h
;	logo
	defb	0fh, 0fh, 0fh, 0fh, 00h, 00h, 00h, 00h
	defb	00h, 00h, 00h, 00h, 0fh, 0fh, 0fh, 0fh
	defb	0fh, 0fh, 0fh, 0fh, 0fh, 0fh, 0fh, 0fh
	defb	0f0h, 0f0h, 0f0h, 0f0h, 00h, 00h, 00h, 00h
	defb	0ffh, 0ffh, 0ffh, 0ffh, 00h, 00h, 00h, 00h
	defb	0f0h, 0f0h, 0f0h, 0f0h, 0fh, 0fh, 0fh, 0fh
	defb	0ffh, 0ffh, 0ffh, 0ffh, 0fh, 0fh, 0fh, 0fh
	defb	00h, 00h, 00h, 00h, 0f0h, 0f0h, 0f0h, 0f0h
	defb	0fh, 0fh, 0fh, 0fh, 0f0h, 0f0h, 0f0h, 0f0h
	defb	00h, 00h, 00h, 00h, 0ffh, 0ffh, 0ffh, 0ffh
	defb	0fh, 0fh, 0fh, 0fh, 0ffh, 0ffh, 0ffh, 0ffh
	defb	0f0h, 0f0h, 0f0h, 0f0h, 0f0h, 0f0h, 0f0h, 0f0h
	defb	0ffh, 0ffh, 0ffh, 0ffh, 0f0h, 0f0h, 0f0h, 0f0h
	defb	0f0h, 0f0h, 0f0h, 0f0h, 0ffh, 0ffh, 0ffh, 0ffh
	defb	0ffh, 0ffh, 0ffh, 0ffh, 0ffh, 0ffh, 0ffh, 0ffh
;	mono8
	defb	06h, 0feh, 0feh, 06h, 06h, 0feh, 0feh, 06h
	defb	60h, 7fh, 7fh, 60h, 60h, 7fh, 7fh, 60h
	defb	0f7h, 0f7h, 0f7h, 00h, 7fh, 7fh, 7fh, 00h
;	mono16
	defb	00h, 00h, 00h, 80h, 80h, 80h, 0feh, 0fch
	defb	00h, 01h, 01h, 03h, 03h, 03h, 0ffh, 7fh
	defb	0f0h, 0e0h, 0e0h, 0e0h, 0f0h, 30h, 10h, 00h
	defb	1fh, 0fh, 0fh, 0fh, 1eh, 18h, 10h, 00h

ColorPattern: public ColorPattern
;	sprite
	defb	00h, 00h, 00h, 0e0h, 0e0h, 0e0h, 0f0h, 0f0h
	defb	0f0h, 50h, 50h, 50h, 50h, 50h, 50h, 0f0h
	defb	0f0h, 0f0h, 0e0h, 0e0h, 0e0h, 00h, 0f0h, 00h
	defb	00h, 00h, 00h, 01h, 01h, 01h, 03h, 03h
	defb	03h, 03h, 03h, 03h, 03h, 03h, 03h, 03h
	defb	03h, 03h, 01h, 01h, 01h, 00h, 03h, 00h
	defb	00h, 0e8h, 00h, 00h, 0ech, 00h, 0e0h, 0ch
	defb	0ch, 20h, 00h, 00h, 30h, 00h, 00h, 30h
	defb	00h, 00h, 30h, 00h, 00h, 00h, 30h, 30h
	defb	00h, 05h, 00h, 00h, 0dh, 00h, 01h, 0ch
	defb	0ch, 01h, 00h, 00h, 03h, 00h, 00h, 03h
	defb	00h, 00h, 03h, 00h, 00h, 00h, 03h, 03h
	defb	00h, 00h, 00h, 0e0h, 0e0h, 0e0h, 0f0h, 0f0h
	defb	0f0h, 50h, 50h, 50h, 50h, 50h, 50h, 0f0h
	defb	0f0h, 0f0h, 0e0h, 0e0h, 0e0h, 00h, 0c0h, 00h
	defb	00h, 00h, 00h, 01h, 01h, 01h, 03h, 03h
	defb	03h, 03h, 03h, 03h, 03h, 03h, 03h, 03h
	defb	03h, 03h, 01h, 01h, 01h, 00h, 01h, 00h
	defb	00h, 0ech, 04h, 00h, 0ech, 04h, 0e0h, 00h
	defb	00h, 0e0h, 00h, 00h, 70h, 00h, 00h, 38h
	defb	00h, 00h, 18h, 04h, 04h, 00h, 08h, 08h
	defb	00h, 07h, 00h, 00h, 0dh, 00h, 01h, 0ch
	defb	0ch, 00h, 00h, 00h, 03h, 04h, 04h, 03h
	defb	04h, 04h, 00h, 00h, 00h, 00h, 00h, 00h
	defb	00h, 00h, 00h, 0e0h, 0e0h, 0e0h, 0f0h, 0f0h
	defb	0f0h, 50h, 50h, 50h, 50h, 50h, 50h, 0f0h
	defb	0f0h, 0f0h, 0e0h, 0e0h, 0e0h, 00h, 0c0h, 00h
	defb	00h, 00h, 00h, 01h, 01h, 01h, 03h, 03h
	defb	03h, 03h, 03h, 03h, 03h, 03h, 03h, 03h
	defb	03h, 03h, 01h, 01h, 01h, 00h, 01h, 00h
	defb	00h, 0c0h, 00h, 00h, 0c0h, 00h, 00h, 0e0h
	defb	00h, 00h, 60h, 60h, 00h, 00h, 00h, 60h
	defb	00h, 00h, 60h, 00h, 00h, 00h, 60h, 60h
	defb	00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h
	defb	00h, 00h, 00h, 00h, 01h, 00h, 00h, 01h
	defb	00h, 00h, 00h, 01h, 01h, 00h, 00h, 00h
	defb	00h, 00h, 00h, 0e0h, 0e0h, 0e0h, 0f0h, 0f0h
	defb	0f0h, 50h, 50h, 50h, 50h, 50h, 50h, 0f0h
	defb	0f0h, 0f0h, 0e0h, 0e0h, 0e0h, 00h, 0c0h, 00h
	defb	00h, 00h, 00h, 01h, 01h, 01h, 03h, 03h
	defb	03h, 03h, 03h, 03h, 03h, 03h, 03h, 03h
	defb	03h, 03h, 01h, 01h, 01h, 00h, 01h, 00h
	defb	00h, 0e0h, 00h, 00h, 78h, 08h, 80h, 38h
	defb	08h, 0c0h, 00h, 00h, 0a0h, 00h, 00h, 70h
	defb	00h, 00h, 30h, 08h, 08h, 00h, 10h, 10h
	defb	00h, 05h, 00h, 00h, 0dh, 00h, 01h, 0ch
	defb	0ch, 01h, 00h, 00h, 03h, 04h, 04h, 03h
	defb	04h, 04h, 00h, 00h, 00h, 00h, 00h, 00h
	defb	00h, 00h, 00h, 80h, 80h, 80h, 0c0h, 0c0h
	defb	0c0h, 0c0h, 0c0h, 0c0h, 0c0h, 0c0h, 0c0h, 0c0h
	defb	0c0h, 0c0h, 80h, 80h, 80h, 00h, 0c0h, 00h
	defb	00h, 00h, 00h, 07h, 07h, 07h, 0fh, 0fh
	defb	0fh, 0ah, 0ah, 0ah, 0ah, 0ah, 0ah, 0fh
	defb	0fh, 0fh, 07h, 07h, 07h, 00h, 0fh, 00h
	defb	00h, 0a0h, 00h, 00h, 0b0h, 00h, 80h, 30h
	defb	30h, 80h, 00h, 00h, 0c0h, 00h, 00h, 0c0h
	defb	00h, 00h, 0c0h, 00h, 00h, 00h, 0c0h, 0c0h
	defb	00h, 17h, 00h, 00h, 37h, 00h, 07h, 30h
	defb	30h, 04h, 00h, 00h, 0ch, 00h, 00h, 0ch
	defb	00h, 00h, 0ch, 00h, 00h, 00h, 0ch, 0ch
	defb	00h, 00h, 00h, 80h, 80h, 80h, 0c0h, 0c0h
	defb	0c0h, 0c0h, 0c0h, 0c0h, 0c0h, 0c0h, 0c0h, 0c0h
	defb	0c0h, 0c0h, 80h, 80h, 80h, 00h, 80h, 00h
	defb	00h, 00h, 00h, 07h, 07h, 07h, 0fh, 0fh
	defb	0fh, 0ah, 0ah, 0ah, 0ah, 0ah, 0ah, 0fh
	defb	0fh, 0fh, 07h, 07h, 07h, 00h, 03h, 00h
	defb	00h, 0e0h, 00h, 00h, 0b0h, 00h, 80h, 30h
	defb	30h, 00h, 00h, 00h, 0c0h, 20h, 20h, 0c0h
	defb	20h, 20h, 00h, 00h, 00h, 00h, 00h, 00h
	defb	00h, 37h, 20h, 00h, 37h, 20h, 07h, 00h
	defb	00h, 07h, 00h, 00h, 0eh, 00h, 00h, 1ch
	defb	00h, 00h, 18h, 20h, 20h, 00h, 10h, 10h
	defb	00h, 00h, 00h, 80h, 80h, 80h, 0c0h, 0c0h
	defb	0c0h, 0c0h, 0c0h, 0c0h, 0c0h, 0c0h, 0c0h, 0c0h
	defb	0c0h, 0c0h, 80h, 80h, 80h, 00h, 80h, 00h
	defb	00h, 00h, 00h, 07h, 07h, 07h, 0fh, 0fh
	defb	0fh, 0ah, 0ah, 0ah, 0ah, 0ah, 0ah, 0fh
	defb	0fh, 0fh, 07h, 07h, 07h, 00h, 03h, 00h
	defb	00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h
	defb	00h, 00h, 00h, 00h, 80h, 00h, 00h, 80h
	defb	00h, 00h, 00h, 80h, 80h, 00h, 00h, 00h
	defb	00h, 03h, 00h, 00h, 03h, 00h, 00h, 07h
	defb	00h, 00h, 06h, 06h, 00h, 00h, 00h, 06h
	defb	00h, 00h, 06h, 00h, 00h, 00h, 06h, 06h
	defb	00h, 00h, 00h, 80h, 80h, 80h, 0c0h, 0c0h
	defb	0c0h, 0c0h, 0c0h, 0c0h, 0c0h, 0c0h, 0c0h, 0c0h
	defb	0c0h, 0c0h, 80h, 80h, 80h, 00h, 80h, 00h
	defb	00h, 00h, 00h, 07h, 07h, 07h, 0fh, 0fh
	defb	0fh, 0ah, 0ah, 0ah, 0ah, 0ah, 0ah, 0fh
	defb	0fh, 0fh, 07h, 07h, 07h, 00h, 03h, 00h
	defb	00h, 0a0h, 00h, 00h, 0b0h, 00h, 80h, 30h
	defb	30h, 80h, 00h, 00h, 0c0h, 20h, 20h, 0c0h
	defb	20h, 20h, 00h, 00h, 00h, 00h, 00h, 00h
	defb	00h, 07h, 00h, 00h, 1eh, 10h, 01h, 1ch
	defb	10h, 03h, 00h, 00h, 05h, 00h, 00h, 0eh
	defb	00h, 00h, 0ch, 10h, 10h, 00h, 08h, 08h
	defb	00h, 00h, 00h, 0e0h, 0e0h, 0e0h, 0f0h, 0f0h
	defb	0f0h, 0f0h, 0f0h, 0f0h, 0f0h, 0f0h, 0f0h, 0f0h
	defb	0f0h, 0f0h, 0e0h, 0e0h, 0e0h, 00h, 0ech, 0ch
	defb	00h, 00h, 00h, 01h, 01h, 01h, 03h, 03h
	defb	03h, 03h, 03h, 03h, 03h, 1bh, 1bh, 03h
	defb	1bh, 03h, 01h, 19h, 01h, 00h, 0fh, 00h
	defb	00h, 0fch, 00h, 00h, 0fch, 00h, 00h, 0e8h
	defb	00h, 0e0h, 00h, 00h, 60h, 00h, 00h, 00h
	defb	60h, 60h, 00h, 00h, 00h, 00h, 00h, 00h
	defb	00h, 07h, 00h, 00h, 03h, 00h, 00h, 03h
	defb	00h, 03h, 00h, 00h, 03h, 00h, 00h, 03h
	defb	00h, 00h, 03h, 00h, 00h, 00h, 03h, 03h
	defb	00h, 00h, 00h, 0c0h, 0c0h, 0c0h, 0e0h, 0e0h
	defb	0e0h, 0e0h, 0e0h, 0e0h, 0e0h, 0ech, 0ech, 0e0h
	defb	0ech, 0e0h, 0c0h, 0cch, 0c0h, 00h, 0f8h, 00h
	defb	00h, 00h, 00h, 03h, 03h, 03h, 07h, 07h
	defb	07h, 07h, 07h, 07h, 07h, 07h, 07h, 07h
	defb	07h, 07h, 03h, 03h, 03h, 00h, 1bh, 18h
	defb	00h, 0f0h, 00h, 00h, 0e0h, 00h, 00h, 0e0h
	defb	00h, 0e0h, 00h, 00h, 60h, 00h, 00h, 60h
	defb	00h, 00h, 60h, 00h, 00h, 00h, 60h, 60h
	defb	00h, 1fh, 00h, 00h, 1fh, 00h, 00h, 0bh
	defb	00h, 03h, 00h, 00h, 03h, 00h, 00h, 00h
	defb	03h, 03h, 00h, 00h, 00h, 00h, 00h, 00h
	defb	0e0h, 00h, 0e0h, 0f8h, 00h, 0f8h, 0fch, 00h
	defb	0fch, 0feh, 00h, 0feh, 0ffh, 00h, 0ffh, 0b7h
	defb	00h, 0b7h, 0b7h, 00h, 0b7h, 0b7h, 00h, 0b7h
	defb	01h, 00h, 01h, 07h, 00h, 07h, 0fh, 00h
	defb	0fh, 1fh, 00h, 1fh, 3fh, 00h, 3fh, 7fh
	defb	00h, 7fh, 7fh, 00h, 7fh, 7fh, 00h, 7fh
	defb	0feh, 00h, 0feh, 0fch, 00h, 0fch, 00h, 00h
	defb	00h, 44h, 00h, 44h, 44h, 00h, 44h, 44h
	defb	00h, 44h, 88h, 00h, 88h, 00h, 00h, 00h
	defb	3fh, 00h, 3fh, 0fh, 00h, 0fh, 00h, 00h
	defb	00h, 04h, 00h, 04h, 04h, 00h, 04h, 04h
	defb	00h, 04h, 08h, 00h, 08h, 00h, 00h, 00h
	defb	00h, 00h, 00h, 0e0h, 00h, 0e0h, 0f8h, 00h
	defb	0f8h, 0fch, 00h, 0fch, 0feh, 00h, 0feh, 0ffh
	defb	00h, 0ffh, 0b7h, 00h, 0b7h, 0b7h, 00h, 0b7h
	defb	00h, 00h, 00h, 01h, 00h, 01h, 07h, 00h
	defb	07h, 0fh, 00h, 0fh, 1fh, 00h, 1fh, 3fh
	defb	00h, 3fh, 7fh, 00h, 7fh, 7fh, 00h, 7fh
	defb	0b7h, 00h, 0b7h, 0feh, 00h, 0feh, 00h, 00h
	defb	00h, 88h, 00h, 88h, 88h, 00h, 88h, 88h
	defb	00h, 88h, 10h, 00h, 10h, 00h, 00h, 00h
	defb	7fh, 00h, 7fh, 1fh, 00h, 1fh, 00h, 00h
	defb	00h, 08h, 00h, 08h, 08h, 00h, 08h, 08h
	defb	00h, 08h, 11h, 00h, 11h, 00h, 00h, 00h
	defb	80h, 00h, 80h, 0e0h, 00h, 0e0h, 0f0h, 00h
	defb	0f0h, 0f8h, 00h, 0f8h, 0fch, 00h, 0fch, 0feh
	defb	00h, 0feh, 0feh, 00h, 0feh, 0feh, 00h, 0feh
	defb	07h, 00h, 07h, 1fh, 00h, 1fh, 3fh, 00h
	defb	3fh, 7fh, 00h, 7fh, 0ffh, 00h, 0ffh, 0edh
	defb	00h, 0edh, 0edh, 00h, 0edh, 0edh, 00h, 0edh
	defb	0fch, 00h, 0fch, 0f0h, 00h, 0f0h, 00h, 00h
	defb	00h, 20h, 00h, 20h, 20h, 00h, 20h, 20h
	defb	00h, 20h, 10h, 00h, 10h, 00h, 00h, 00h
	defb	7fh, 00h, 7fh, 3fh, 00h, 3fh, 00h, 00h
	defb	00h, 22h, 00h, 22h, 22h, 00h, 22h, 22h
	defb	00h, 22h, 11h, 00h, 11h, 00h, 00h, 00h
	defb	00h, 00h, 00h, 80h, 00h, 80h, 0e0h, 00h
	defb	0e0h, 0f0h, 00h, 0f0h, 0f8h, 00h, 0f8h, 0fch
	defb	00h, 0fch, 0feh, 00h, 0feh, 0feh, 00h, 0feh
	defb	00h, 00h, 00h, 07h, 00h, 07h, 1fh, 00h
	defb	1fh, 3fh, 00h, 3fh, 7fh, 00h, 7fh, 0ffh
	defb	00h, 0ffh, 0edh, 00h, 0edh, 0edh, 00h, 0edh
	defb	0feh, 00h, 0feh, 0f8h, 00h, 0f8h, 00h, 00h
	defb	00h, 10h, 00h, 10h, 10h, 00h, 10h, 10h
	defb	00h, 10h, 88h, 00h, 88h, 00h, 00h, 00h
	defb	0edh, 00h, 0edh, 7fh, 00h, 7fh, 00h, 00h
	defb	00h, 11h, 00h, 11h, 11h, 00h, 11h, 11h
	defb	00h, 11h, 08h, 00h, 08h, 00h, 00h, 00h
	defb	00h, 00h, 00h, 10h, 00h, 10h, 88h, 00h
	defb	88h, 88h, 00h, 88h, 88h, 00h, 88h, 00h
	defb	00h, 00h, 0feh, 00h, 0feh, 0ffh, 00h, 0ffh
	defb	00h, 00h, 00h, 11h, 00h, 11h, 08h, 00h
	defb	08h, 08h, 00h, 08h, 08h, 00h, 08h, 00h
	defb	00h, 00h, 3fh, 00h, 3fh, 7fh, 00h, 7fh
	defb	0d7h, 00h, 0d7h, 0efh, 00h, 0efh, 0d7h, 00h
	defb	0d7h, 0feh, 00h, 0feh, 0feh, 00h, 0feh, 0fch
	defb	00h, 0fch, 0f8h, 00h, 0f8h, 0e0h, 00h, 0e0h
	defb	75h, 00h, 75h, 7bh, 00h, 7bh, 75h, 00h
	defb	75h, 3fh, 00h, 3fh, 3fh, 00h, 3fh, 1fh
	defb	00h, 1fh, 0fh, 00h, 0fh, 03h, 00h, 03h
	defb	00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h
	defb	00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h
	defb	00h, 00h, 00h, 0c0h, 00h, 00h, 0f0h, 80h
	defb	00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h
	defb	00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h
	defb	0fh, 00h, 00h, 05h, 00h, 00h, 03h, 01h
	defb	00h, 0f0h, 0e0h, 00h, 0f8h, 0a0h, 00h, 0f8h
	defb	30h, 00h, 0f8h, 0e0h, 00h, 0f0h, 00h, 00h
	defb	0e0h, 00h, 00h, 00h, 00h, 00h, 00h, 00h
	defb	00h, 17h, 03h, 00h, 0fh, 01h, 00h, 07h
	defb	03h, 00h, 07h, 01h, 00h, 03h, 00h, 00h
	defb	00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h
	defb	00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h
	defb	00h, 00h, 00h, 0fch, 00h, 00h, 0feh, 24h
	defb	00h, 0dbh, 26h, 00h, 0d9h, 24h, 00h, 0dbh
	defb	00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h
	defb	00h, 00h, 00h, 1fh, 00h, 00h, 3fh, 1dh
	defb	00h, 62h, 25h, 00h, 5ah, 25h, 00h, 5ah
	defb	24h, 00h, 0dbh, 24h, 00h, 0dbh, 0ceh, 00h
	defb	31h, 00h, 00h, 0feh, 00h, 00h, 0fch, 00h
	defb	00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h
	defb	1dh, 00h, 62h, 05h, 00h, 7ah, 04h, 00h
	defb	7bh, 00h, 00h, 3fh, 00h, 00h, 1fh, 00h
	defb	00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h
