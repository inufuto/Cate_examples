cseg

MonoPattern: public MonoPattern
; ascii 30
	; " -0123456789ACEFGHIKMNOPRSTUVY"
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
	defb 1eh,33h,60h,60h,60h,33h,1eh,00h
	defb 7eh,60h,60h,7eh,60h,60h,7eh,00h
	defb 7eh,60h,60h,7eh,60h,60h,60h,00h
	defb 1eh,33h,60h,6fh,63h,33h,1fh,00h
	defb 63h,63h,63h,7fh,63h,63h,63h,00h
	defb 7eh,18h,18h,18h,18h,18h,7eh,00h
	defb 63h,66h,6ch,78h,6ch,66h,63h,00h
	defb 7eh,6bh,6bh,6bh,6bh,6bh,6bh,00h
	defb 63h,73h,7bh,7fh,6fh,67h,63h,00h
	defb 3eh,63h,63h,63h,63h,63h,3eh,00h
	defb 7eh,63h,63h,63h,7eh,60h,60h,00h
	defb 7eh,63h,63h,67h,7ch,6eh,67h,00h
	defb 3eh,63h,60h,3eh,03h,63h,3eh,00h
	defb 7eh,18h,18h,18h,18h,18h,18h,00h
	defb 63h,63h,63h,63h,63h,63h,3eh,00h
	defb 63h,63h,63h,36h,36h,1ch,1ch,00h
	defb 66h,66h,66h,3ch,18h,18h,18h,00h
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
;	fence
	defb	00h, 00h, 00h, 00h, 00h, 00h, 00h, 0ffh
	defb	0ffh, 00h, 00h, 00h, 00h, 00h, 00h, 00h
;	mono16
	defb	0ffh, 0ffh, 0ffh, 0ffh, 0ffh, 0ffh, 0ffh, 0ffh
	defb	0feh, 0feh, 0feh, 0feh, 0feh, 0feh, 0feh, 0feh
	defb	0ffh, 0ffh, 0ffh, 0ffh, 0ffh, 0ffh, 0ffh, 00h
	defb	0feh, 0feh, 0feh, 0feh, 0feh, 0feh, 0feh, 00h
	defb	00h, 00h, 00h, 01h, 01h, 01h, 7fh, 3fh
	defb	00h, 80h, 80h, 0c0h, 0c0h, 0c0h, 0ffh, 0feh
	defb	0fh, 07h, 07h, 07h, 0fh, 0ch, 08h, 00h
	defb	0f8h, 0f0h, 0f0h, 0f0h, 78h, 18h, 08h, 00h
;	line
	defb	01h, 01h, 01h, 01h, 01h, 01h, 01h, 0ffh
	defb	80h, 80h, 80h, 80h, 80h, 80h, 80h, 0ffh
	defb	0ffh, 01h, 01h, 01h, 01h, 01h, 01h, 01h
	defb	0ffh, 80h, 80h, 80h, 80h, 80h, 80h, 80h
	defb	80h, 80h, 80h, 80h, 80h, 80h, 80h, 80h
	defb	01h, 01h, 01h, 01h, 01h, 01h, 01h, 01h
	defb	0ffh, 00h, 00h, 00h, 00h, 00h, 00h, 00h
	defb	00h, 00h, 00h, 00h, 00h, 00h, 00h, 0ffh

ColorPattern: public ColorPattern
;	color16
	defb	0fh, 1fh, 3fh, 3fh, 2bh, 2bh, 3fh, 00h
	defb	0fh, 1fh, 3fh, 3fh, 2bh, 2bh, 3fh, 00h
	defb	0fh, 1fh, 3fh, 3fh, 2bh, 2bh, 3fh, 00h
	defb	0c0h, 0e0h, 0f0h, 0f0h, 0f0h, 0f0h, 0f0h, 00h
	defb	0c0h, 0e0h, 0f0h, 0f0h, 0f0h, 0f0h, 0f0h, 00h
	defb	0c0h, 0e0h, 0f0h, 0f0h, 0f0h, 0f0h, 0f0h, 00h
	defb	3fh, 3fh, 3fh, 3fh, 3fh, 1ch, 38h, 70h
	defb	00h, 00h, 00h, 00h, 00h, 1ch, 38h, 70h
	defb	3fh, 23h, 23h, 3fh, 3fh, 1ch, 38h, 70h
	defb	0f0h, 0f8h, 0f0h, 0f0h, 0c0h, 0e0h, 70h, 38h
	defb	10h, 18h, 30h, 30h, 00h, 0e0h, 70h, 38h
	defb	0f0h, 0f8h, 0f0h, 0f0h, 0c0h, 0e0h, 70h, 38h
	defb	0fh, 1fh, 3fh, 3fh, 2bh, 2bh, 3fh, 00h
	defb	0fh, 1fh, 3fh, 3fh, 2bh, 2bh, 3fh, 00h
	defb	0fh, 1fh, 3fh, 3fh, 2bh, 2bh, 3fh, 00h
	defb	0c0h, 0e0h, 0f0h, 0f0h, 0f0h, 0f0h, 0f0h, 00h
	defb	0c0h, 0e0h, 0f0h, 0f0h, 0f0h, 0f0h, 0f0h, 00h
	defb	0c0h, 0e0h, 0f0h, 0f0h, 0f0h, 0f0h, 0f0h, 00h
	defb	3fh, 7fh, 0ffh, 0ffh, 3fh, 18h, 0dh, 03h
	defb	00h, 40h, 0c0h, 0c0h, 00h, 18h, 0dh, 03h
	defb	3fh, 63h, 0e3h, 0ffh, 3fh, 18h, 0dh, 03h
	defb	0f0h, 0f8h, 0ech, 0ech, 0e0h, 0e0h, 0c0h, 80h
	defb	10h, 18h, 0ch, 0ch, 00h, 0e0h, 0c0h, 80h
	defb	0f0h, 0f8h, 0ech, 0ech, 0e0h, 0e0h, 0c0h, 80h
	defb	03h, 07h, 0fh, 0fh, 0fh, 0fh, 0fh, 00h
	defb	03h, 07h, 0fh, 0fh, 0fh, 0fh, 0fh, 00h
	defb	03h, 07h, 0fh, 0fh, 0fh, 0fh, 0fh, 00h
	defb	0f0h, 0f8h, 0fch, 0fch, 0d4h, 0d4h, 0fch, 00h
	defb	0f0h, 0f8h, 0fch, 0fch, 0d4h, 0d4h, 0fch, 00h
	defb	0f0h, 0f8h, 0fch, 0fch, 0d4h, 0d4h, 0fch, 00h
	defb	0fh, 1fh, 0fh, 0fh, 03h, 07h, 0eh, 1ch
	defb	08h, 18h, 0ch, 0ch, 00h, 07h, 0eh, 1ch
	defb	0fh, 1fh, 0fh, 0fh, 03h, 07h, 0eh, 1ch
	defb	0fch, 0fch, 0fch, 0fch, 0fch, 38h, 1ch, 0eh
	defb	00h, 00h, 00h, 00h, 00h, 38h, 1ch, 0eh
	defb	0fch, 0c4h, 0c4h, 0fch, 0fch, 38h, 1ch, 0eh
	defb	03h, 07h, 0fh, 0fh, 0fh, 0fh, 0fh, 00h
	defb	03h, 07h, 0fh, 0fh, 0fh, 0fh, 0fh, 00h
	defb	03h, 07h, 0fh, 0fh, 0fh, 0fh, 0fh, 00h
	defb	0f0h, 0f8h, 0fch, 0fch, 0d4h, 0d4h, 0fch, 00h
	defb	0f0h, 0f8h, 0fch, 0fch, 0d4h, 0d4h, 0fch, 00h
	defb	0f0h, 0f8h, 0fch, 0fch, 0d4h, 0d4h, 0fch, 00h
	defb	0fh, 1fh, 37h, 37h, 07h, 07h, 03h, 01h
	defb	08h, 18h, 30h, 30h, 00h, 07h, 03h, 01h
	defb	0fh, 1fh, 37h, 37h, 07h, 07h, 03h, 01h
	defb	0fch, 0feh, 0ffh, 0ffh, 0fch, 18h, 0b0h, 0c0h
	defb	00h, 02h, 03h, 03h, 00h, 18h, 0b0h, 0c0h
	defb	0fch, 0c6h, 0c7h, 0ffh, 0fch, 18h, 0b0h, 0c0h
	defb	07h, 0fh, 1fh, 1fh, 1fh, 1fh, 1fh, 00h
	defb	07h, 0fh, 1fh, 1fh, 1fh, 1fh, 1fh, 00h
	defb	07h, 0fh, 1fh, 1fh, 1fh, 1fh, 1fh, 00h
	defb	0e0h, 0f0h, 0f8h, 0f8h, 0f8h, 0f8h, 0f8h, 00h
	defb	0e0h, 0f0h, 0f8h, 0f8h, 0f8h, 0f8h, 0f8h, 00h
	defb	0e0h, 0f0h, 0f8h, 0f8h, 0f8h, 0f8h, 0f8h, 00h
	defb	3fh, 7fh, 7fh, 7fh, 1fh, 1eh, 00h, 00h
	defb	20h, 60h, 60h, 60h, 00h, 1eh, 00h, 00h
	defb	3fh, 7fh, 7fh, 7fh, 1fh, 1eh, 00h, 00h
	defb	0f8h, 0fah, 0fah, 0f8h, 0f8h, 78h, 78h, 78h
	defb	00h, 02h, 02h, 00h, 00h, 78h, 78h, 78h
	defb	0f8h, 0fah, 0fah, 0f8h, 0f8h, 78h, 78h, 78h
	defb	07h, 0fh, 1fh, 1fh, 1fh, 1fh, 1fh, 00h
	defb	07h, 0fh, 1fh, 1fh, 1fh, 1fh, 1fh, 00h
	defb	07h, 0fh, 1fh, 1fh, 1fh, 1fh, 1fh, 00h
	defb	0e0h, 0f0h, 0f8h, 0f8h, 0f8h, 0f8h, 0f8h, 00h
	defb	0e0h, 0f0h, 0f8h, 0f8h, 0f8h, 0f8h, 0f8h, 00h
	defb	0e0h, 0f0h, 0f8h, 0f8h, 0f8h, 0f8h, 0f8h, 00h
	defb	1fh, 5fh, 5fh, 1fh, 1fh, 1eh, 1eh, 1eh
	defb	00h, 40h, 40h, 00h, 00h, 1eh, 1eh, 1eh
	defb	1fh, 5fh, 5fh, 1fh, 1fh, 1eh, 1eh, 1eh
	defb	0fch, 0feh, 0feh, 0feh, 0f8h, 78h, 00h, 00h
	defb	04h, 06h, 06h, 06h, 00h, 78h, 00h, 00h
	defb	0fch, 0feh, 0feh, 0feh, 0f8h, 78h, 00h, 00h
	defb	07h, 0fh, 1fh, 1fh, 1dh, 1dh, 1fh, 00h
	defb	07h, 0fh, 1fh, 1fh, 1dh, 1dh, 1fh, 00h
	defb	07h, 0fh, 1fh, 1fh, 1dh, 1dh, 1fh, 00h
	defb	0e0h, 0f0h, 0f8h, 0f8h, 0b8h, 0b8h, 0f8h, 00h
	defb	0e0h, 0f0h, 0f8h, 0f8h, 0b8h, 0b8h, 0f8h, 00h
	defb	0e0h, 0f0h, 0f8h, 0f8h, 0b8h, 0b8h, 0f8h, 00h
	defb	1fh, 5fh, 5fh, 1fh, 1fh, 1eh, 1eh, 1eh
	defb	00h, 40h, 40h, 00h, 00h, 1eh, 1eh, 1eh
	defb	1fh, 5ch, 5ch, 1fh, 1fh, 1eh, 1eh, 1eh
	defb	0fch, 0feh, 0feh, 0feh, 0f8h, 78h, 00h, 00h
	defb	04h, 06h, 06h, 06h, 00h, 78h, 00h, 00h
	defb	0fch, 3eh, 3eh, 0feh, 0f8h, 78h, 00h, 00h
	defb	07h, 0fh, 1fh, 1fh, 1dh, 1dh, 1fh, 00h
	defb	07h, 0fh, 1fh, 1fh, 1dh, 1dh, 1fh, 00h
	defb	07h, 0fh, 1fh, 1fh, 1dh, 1dh, 1fh, 00h
	defb	0e0h, 0f0h, 0f8h, 0f8h, 0b8h, 0b8h, 0f8h, 00h
	defb	0e0h, 0f0h, 0f8h, 0f8h, 0b8h, 0b8h, 0f8h, 00h
	defb	0e0h, 0f0h, 0f8h, 0f8h, 0b8h, 0b8h, 0f8h, 00h
	defb	3fh, 7fh, 7fh, 7fh, 1fh, 1eh, 00h, 00h
	defb	20h, 60h, 60h, 60h, 00h, 1eh, 00h, 00h
	defb	3fh, 7ch, 7ch, 7fh, 1fh, 1eh, 00h, 00h
	defb	0f8h, 0fah, 0fah, 0f8h, 0f8h, 78h, 78h, 78h
	defb	00h, 02h, 02h, 00h, 00h, 78h, 78h, 78h
	defb	0f8h, 3ah, 3ah, 0f8h, 0f8h, 78h, 78h, 78h
	defb	04h, 06h, 0fh, 1ah, 1ah, 1fh, 15h, 50h
	defb	04h, 06h, 0fh, 1ah, 1ah, 1fh, 15h, 50h
	defb	00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h
	defb	80h, 0c0h, 0e0h, 0f0h, 0f0h, 0f0h, 70h, 76h
	defb	80h, 0c0h, 0e0h, 0f0h, 0f0h, 0f0h, 70h, 76h
	defb	00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h
	defb	6fh, 3fh, 1fh, 0fh, 07h, 03h, 01h, 00h
	defb	6fh, 3fh, 1fh, 0fh, 07h, 03h, 01h, 00h
	defb	00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h
	defb	0eeh, 0fch, 0f8h, 0f0h, 0e0h, 0e0h, 0f0h, 78h
	defb	0eeh, 0fch, 0f8h, 0f0h, 0e0h, 0e0h, 0f0h, 78h
	defb	00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h
	defb	00h, 04h, 06h, 0fh, 1ah, 1ah, 1fh, 15h
	defb	00h, 04h, 06h, 0fh, 1ah, 1ah, 1fh, 15h
	defb	00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h
	defb	00h, 80h, 0c0h, 0e0h, 0f0h, 0f0h, 0f0h, 70h
	defb	00h, 80h, 0c0h, 0e0h, 0f0h, 0f0h, 0f0h, 70h
	defb	00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h
	defb	10h, 3fh, 7fh, 0dfh, 0fh, 07h, 03h, 01h
	defb	10h, 3fh, 7fh, 0dfh, 0fh, 07h, 03h, 01h
	defb	00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h
	defb	70h, 0f8h, 0fch, 0f6h, 0f0h, 0e0h, 0f6h, 0fch
	defb	70h, 0f8h, 0fch, 0f6h, 0f0h, 0e0h, 0f6h, 0fch
	defb	00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h
	defb	01h, 03h, 07h, 0fh, 0fh, 0fh, 0eh, 6eh
	defb	01h, 03h, 07h, 0fh, 0fh, 0fh, 0eh, 6eh
	defb	00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h
	defb	20h, 60h, 0f0h, 58h, 58h, 0f8h, 0a8h, 0ah
	defb	20h, 60h, 0f0h, 58h, 58h, 0f8h, 0a8h, 0ah
	defb	00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h
	defb	77h, 3fh, 1fh, 0fh, 07h, 07h, 0fh, 1eh
	defb	77h, 3fh, 1fh, 0fh, 07h, 07h, 0fh, 1eh
	defb	00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h
	defb	0f6h, 0fch, 0f8h, 0f0h, 0e0h, 0c0h, 80h, 00h
	defb	0f6h, 0fch, 0f8h, 0f0h, 0e0h, 0c0h, 80h, 00h
	defb	00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h
	defb	00h, 01h, 03h, 07h, 0fh, 0fh, 0fh, 0eh
	defb	00h, 01h, 03h, 07h, 0fh, 0fh, 0fh, 0eh
	defb	00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h
	defb	00h, 20h, 60h, 0f0h, 58h, 58h, 0f8h, 0a8h
	defb	00h, 20h, 60h, 0f0h, 58h, 58h, 0f8h, 0a8h
	defb	00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h
	defb	0eh, 1fh, 3fh, 6fh, 0fh, 07h, 6fh, 3fh
	defb	0eh, 1fh, 3fh, 6fh, 0fh, 07h, 6fh, 3fh
	defb	00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h
	defb	08h, 0fch, 0feh, 0fbh, 0f0h, 0e0h, 0c0h, 80h
	defb	08h, 0fch, 0feh, 0fbh, 0f0h, 0e0h, 0c0h, 80h
	defb	00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h
	defb	02h, 06h, 0fh, 1fh, 1fh, 1fh, 1fh, 5fh
	defb	02h, 06h, 0fh, 1fh, 1fh, 1fh, 1fh, 5fh
	defb	00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h
	defb	40h, 60h, 0f0h, 0f8h, 0f8h, 0f8h, 0f8h, 0fah
	defb	40h, 60h, 0f0h, 0f8h, 0f8h, 0f8h, 0f8h, 0fah
	defb	00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h
	defb	6fh, 3fh, 1fh, 0fh, 0fh, 07h, 03h, 01h
	defb	6fh, 3fh, 1fh, 0fh, 0fh, 07h, 03h, 01h
	defb	00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h
	defb	0f6h, 0fch, 0f8h, 0f0h, 0f0h, 0e0h, 0c0h, 80h
	defb	0f6h, 0fch, 0f8h, 0f0h, 0f0h, 0e0h, 0c0h, 80h
	defb	00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h
	defb	00h, 02h, 06h, 0fh, 1fh, 1fh, 1fh, 1fh
	defb	00h, 02h, 06h, 0fh, 1fh, 1fh, 1fh, 1fh
	defb	00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h
	defb	00h, 40h, 60h, 0f0h, 0f8h, 0f8h, 0f8h, 0f8h
	defb	00h, 40h, 60h, 0f0h, 0f8h, 0f8h, 0f8h, 0f8h
	defb	00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h
	defb	1fh, 0fh, 3fh, 6fh, 0fh, 0fh, 07h, 03h
	defb	1fh, 0fh, 3fh, 6fh, 0fh, 0fh, 07h, 03h
	defb	00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h
	defb	0f8h, 0f0h, 0fch, 0f6h, 0f0h, 0f0h, 0e0h, 0c0h
	defb	0f8h, 0f0h, 0fch, 0f6h, 0f0h, 0f0h, 0e0h, 0c0h
	defb	00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h
	defb	02h, 06h, 0fh, 1dh, 1dh, 1fh, 1ah, 58h
	defb	02h, 06h, 0fh, 1dh, 1dh, 1fh, 1ah, 58h
	defb	00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h
	defb	40h, 60h, 0f0h, 0b8h, 0b8h, 0f8h, 58h, 1ah
	defb	40h, 60h, 0f0h, 0b8h, 0b8h, 0f8h, 58h, 1ah
	defb	00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h
	defb	6fh, 3fh, 1fh, 0fh, 0fh, 07h, 03h, 01h
	defb	6fh, 3fh, 1fh, 0fh, 0fh, 07h, 03h, 01h
	defb	00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h
	defb	0f6h, 0fch, 0f8h, 0f0h, 0f0h, 0e0h, 0c0h, 80h
	defb	0f6h, 0fch, 0f8h, 0f0h, 0f0h, 0e0h, 0c0h, 80h
	defb	00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h
	defb	00h, 02h, 06h, 0fh, 1dh, 1dh, 1fh, 1ah
	defb	00h, 02h, 06h, 0fh, 1dh, 1dh, 1fh, 1ah
	defb	00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h
	defb	00h, 40h, 60h, 0f0h, 0b8h, 0b8h, 0f8h, 58h
	defb	00h, 40h, 60h, 0f0h, 0b8h, 0b8h, 0f8h, 58h
	defb	00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h
	defb	18h, 0fh, 3fh, 6fh, 0fh, 0fh, 07h, 03h
	defb	18h, 0fh, 3fh, 6fh, 0fh, 0fh, 07h, 03h
	defb	00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h
	defb	18h, 0f0h, 0fch, 0f6h, 0f0h, 0f0h, 0e0h, 0c0h
	defb	18h, 0f0h, 0fch, 0f6h, 0f0h, 0f0h, 0e0h, 0c0h
	defb	00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h
	defb	00h, 00h, 00h, 00h, 11h, 32h, 12h, 12h
	defb	00h, 00h, 00h, 00h, 11h, 32h, 12h, 12h
	defb	00h, 00h, 00h, 00h, 11h, 32h, 12h, 12h
	defb	00h, 00h, 00h, 00h, 8ch, 52h, 52h, 52h
	defb	00h, 00h, 00h, 00h, 8ch, 52h, 52h, 52h
	defb	00h, 00h, 00h, 00h, 8ch, 52h, 52h, 52h
	defb	12h, 12h, 39h, 00h, 00h, 00h, 00h, 00h
	defb	12h, 12h, 39h, 00h, 00h, 00h, 00h, 00h
	defb	12h, 12h, 39h, 00h, 00h, 00h, 00h, 00h
	defb	52h, 52h, 8ch, 00h, 00h, 00h, 00h, 00h
	defb	52h, 52h, 8ch, 00h, 00h, 00h, 00h, 00h
	defb	52h, 52h, 8ch, 00h, 00h, 00h, 00h, 00h
	defb	00h, 00h, 00h, 00h, 31h, 4ah, 0ah, 12h
	defb	00h, 00h, 00h, 00h, 31h, 4ah, 0ah, 12h
	defb	00h, 00h, 00h, 00h, 31h, 4ah, 0ah, 12h
	defb	00h, 00h, 00h, 00h, 8ch, 52h, 52h, 52h
	defb	00h, 00h, 00h, 00h, 8ch, 52h, 52h, 52h
	defb	00h, 00h, 00h, 00h, 8ch, 52h, 52h, 52h
	defb	22h, 42h, 79h, 00h, 00h, 00h, 00h, 00h
	defb	22h, 42h, 79h, 00h, 00h, 00h, 00h, 00h
	defb	22h, 42h, 79h, 00h, 00h, 00h, 00h, 00h
	defb	52h, 52h, 8ch, 00h, 00h, 00h, 00h, 00h
	defb	52h, 52h, 8ch, 00h, 00h, 00h, 00h, 00h
	defb	52h, 52h, 8ch, 00h, 00h, 00h, 00h, 00h
	defb	00h, 00h, 00h, 00h, 31h, 52h, 52h, 52h
	defb	00h, 00h, 00h, 00h, 31h, 52h, 52h, 52h
	defb	00h, 00h, 00h, 00h, 31h, 52h, 52h, 52h
	defb	00h, 00h, 00h, 00h, 8ch, 52h, 52h, 52h
	defb	00h, 00h, 00h, 00h, 8ch, 52h, 52h, 52h
	defb	00h, 00h, 00h, 00h, 8ch, 52h, 52h, 52h
	defb	7ah, 12h, 11h, 00h, 00h, 00h, 00h, 00h
	defb	7ah, 12h, 11h, 00h, 00h, 00h, 00h, 00h
	defb	7ah, 12h, 11h, 00h, 00h, 00h, 00h, 00h
	defb	52h, 52h, 8ch, 00h, 00h, 00h, 00h, 00h
	defb	52h, 52h, 8ch, 00h, 00h, 00h, 00h, 00h
	defb	52h, 52h, 8ch, 00h, 00h, 00h, 00h, 00h
	defb	00h, 00h, 00h, 00h, 31h, 4ah, 4ah, 32h
	defb	00h, 00h, 00h, 00h, 31h, 4ah, 4ah, 32h
	defb	00h, 00h, 00h, 00h, 31h, 4ah, 4ah, 32h
	defb	00h, 00h, 00h, 00h, 8ch, 52h, 52h, 52h
	defb	00h, 00h, 00h, 00h, 8ch, 52h, 52h, 52h
	defb	00h, 00h, 00h, 00h, 8ch, 52h, 52h, 52h
	defb	4ah, 4ah, 31h, 00h, 00h, 00h, 00h, 00h
	defb	4ah, 4ah, 31h, 00h, 00h, 00h, 00h, 00h
	defb	4ah, 4ah, 31h, 00h, 00h, 00h, 00h, 00h
	defb	52h, 52h, 8ch, 00h, 00h, 00h, 00h, 00h
	defb	52h, 52h, 8ch, 00h, 00h, 00h, 00h, 00h
	defb	52h, 52h, 8ch, 00h, 00h, 00h, 00h, 00h
	defb	00h, 00h, 00h, 00h, 00h, 24h, 64h, 24h
	defb	00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h
	defb	00h, 00h, 00h, 3fh, 7fh, 0dbh, 9bh, 0dbh
	defb	00h, 00h, 00h, 00h, 00h, 0b8h, 0a4h, 0a4h
	defb	00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h
	defb	00h, 00h, 00h, 0f8h, 0fch, 46h, 5ah, 5ah
	defb	24h, 24h, 73h, 00h, 00h, 00h, 00h, 00h
	defb	00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h
	defb	0dbh, 0dbh, 8ch, 7fh, 3fh, 00h, 00h, 00h
	defb	0b8h, 0a0h, 20h, 00h, 00h, 00h, 00h, 00h
	defb	00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h
	defb	46h, 5eh, 0deh, 0fch, 0f8h, 00h, 00h, 00h
