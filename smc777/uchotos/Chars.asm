cseg

MonoPattern: public MonoPattern
; ascii 31
	; " -0123456789ABCEFGHIKMNOPRSTUVY"
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
;	mono8
	defb	60h, 7fh, 7fh, 60h, 60h, 7fh, 7fh, 60h
	defb	06h, 0feh, 0feh, 06h, 06h, 0feh, 0feh, 06h
;	mono16
	defb	00h, 00h, 00h, 01h, 01h, 01h, 7fh, 3fh
	defb	00h, 80h, 80h, 0c0h, 0c0h, 0c0h, 0ffh, 0feh
	defb	0fh, 07h, 07h, 07h, 0fh, 0ch, 08h, 00h
	defb	0f8h, 0f0h, 0f0h, 0f0h, 78h, 18h, 08h, 00h

ColorPattern: public ColorPattern
;	floot
	defb	44h, 4fh, 44h, 44h, 0aah, 0afh, 0aah, 0aah
	defb	0aah, 0afh, 0aah, 0aah, 0ffh, 0ffh, 0ffh, 0ffh
	defb	44h, 44h, 44h, 4fh, 0aah, 0aah, 0aah, 0afh
	defb	0aah, 0aah, 0aah, 0afh, 0ffh, 0ffh, 0ffh, 0ffh

SpritePattern: public SpritePattern
;	sprite
	defb	00h, 00h, 08h, 88h, 00h, 00h, 87h, 77h
	defb	00h, 08h, 77h, 77h, 00h, 08h, 78h, 78h
	defb	00h, 08h, 78h, 78h, 00h, 08h, 77h, 77h
	defb	00h, 00h, 87h, 77h, 00h, 08h, 88h, 88h
	defb	80h, 00h, 00h, 00h, 78h, 00h, 00h, 00h
	defb	77h, 80h, 00h, 00h, 77h, 80h, 00h, 00h
	defb	77h, 80h, 00h, 00h, 77h, 80h, 00h, 00h
	defb	78h, 00h, 00h, 00h, 88h, 80h, 00h, 00h
	defb	00h, 8ah, 0aah, 0aah, 08h, 0aah, 8ah, 0aah
	defb	08h, 0bbh, 8ch, 0cch, 00h, 88h, 8ch, 88h
	defb	00h, 08h, 0cch, 88h, 00h, 08h, 0cch, 88h
	defb	00h, 08h, 0bbh, 88h, 00h, 00h, 88h, 00h
	defb	0aah, 0a8h, 00h, 00h, 0a8h, 0aah, 80h, 00h
	defb	0c8h, 0bbh, 80h, 00h, 0c8h, 88h, 00h, 00h
	defb	0cch, 80h, 00h, 00h, 0cch, 80h, 00h, 00h
	defb	0bbh, 80h, 00h, 00h, 88h, 00h, 00h, 00h
	defb	00h, 00h, 08h, 88h, 00h, 00h, 87h, 77h
	defb	00h, 08h, 77h, 77h, 00h, 08h, 78h, 78h
	defb	00h, 08h, 78h, 78h, 00h, 08h, 77h, 77h
	defb	00h, 00h, 87h, 77h, 00h, 88h, 88h, 88h
	defb	80h, 00h, 00h, 00h, 78h, 00h, 00h, 00h
	defb	77h, 80h, 00h, 00h, 77h, 80h, 00h, 00h
	defb	77h, 80h, 00h, 00h, 77h, 80h, 00h, 00h
	defb	78h, 00h, 00h, 00h, 88h, 80h, 00h, 00h
	defb	08h, 0bah, 8ah, 0aah, 08h, 0bah, 8ah, 0aah
	defb	00h, 88h, 8ch, 0cch, 00h, 00h, 8ch, 0cch
	defb	00h, 08h, 0cch, 0cch, 00h, 8ch, 0cch, 88h
	defb	08h, 0bbh, 0b8h, 00h, 00h, 88h, 80h, 00h
	defb	0aah, 0a8h, 00h, 00h, 0a8h, 0aah, 80h, 00h
	defb	0c8h, 0bbh, 80h, 00h, 88h, 88h, 00h, 00h
	defb	0cch, 0b8h, 00h, 00h, 0cch, 0b8h, 00h, 00h
	defb	88h, 80h, 00h, 00h, 00h, 00h, 00h, 00h
	defb	00h, 00h, 08h, 88h, 00h, 00h, 87h, 77h
	defb	00h, 08h, 77h, 77h, 00h, 08h, 78h, 78h
	defb	00h, 08h, 78h, 78h, 00h, 08h, 77h, 77h
	defb	00h, 00h, 87h, 77h, 00h, 00h, 08h, 88h
	defb	80h, 00h, 00h, 00h, 78h, 00h, 00h, 00h
	defb	77h, 80h, 00h, 00h, 77h, 80h, 00h, 00h
	defb	77h, 80h, 00h, 00h, 77h, 80h, 00h, 00h
	defb	78h, 00h, 00h, 00h, 80h, 00h, 00h, 00h
	defb	00h, 00h, 08h, 0aah, 00h, 00h, 08h, 0aah
	defb	00h, 00h, 8ah, 0aah, 00h, 00h, 8bh, 0b8h
	defb	00h, 00h, 08h, 88h, 00h, 00h, 8ch, 0c8h
	defb	00h, 00h, 8bh, 0b8h, 00h, 00h, 08h, 80h
	defb	80h, 00h, 00h, 00h, 80h, 00h, 00h, 00h
	defb	80h, 00h, 00h, 00h, 80h, 00h, 00h, 00h
	defb	0c8h, 00h, 00h, 00h, 0c8h, 00h, 00h, 00h
	defb	0b8h, 00h, 00h, 00h, 80h, 00h, 00h, 00h
	defb	00h, 00h, 08h, 88h, 00h, 00h, 87h, 77h
	defb	00h, 08h, 77h, 77h, 00h, 08h, 78h, 78h
	defb	00h, 08h, 78h, 78h, 00h, 08h, 77h, 77h
	defb	00h, 00h, 87h, 77h, 00h, 00h, 08h, 88h
	defb	80h, 00h, 00h, 00h, 78h, 00h, 00h, 00h
	defb	77h, 80h, 00h, 00h, 77h, 80h, 00h, 00h
	defb	77h, 80h, 00h, 00h, 77h, 80h, 00h, 00h
	defb	78h, 00h, 00h, 00h, 88h, 80h, 00h, 00h
	defb	00h, 08h, 8ah, 0aah, 00h, 8bh, 0aah, 0a8h
	defb	00h, 8bh, 0aah, 8ch, 00h, 08h, 88h, 0cch
	defb	00h, 00h, 8ch, 8ch, 00h, 08h, 0cch, 0c8h
	defb	00h, 8bh, 0bbh, 80h, 00h, 08h, 88h, 00h
	defb	0a8h, 0a8h, 00h, 00h, 0a8h, 0aah, 80h, 00h
	defb	0c8h, 0bbh, 80h, 00h, 0c8h, 88h, 00h, 00h
	defb	0cch, 0b8h, 00h, 00h, 0cch, 0b8h, 00h, 00h
	defb	88h, 80h, 00h, 00h, 00h, 00h, 00h, 00h
	defb	00h, 00h, 00h, 08h, 00h, 00h, 00h, 87h
	defb	00h, 00h, 08h, 77h, 00h, 00h, 08h, 77h
	defb	00h, 00h, 08h, 77h, 00h, 00h, 08h, 77h
	defb	00h, 00h, 00h, 87h, 00h, 00h, 08h, 88h
	defb	88h, 80h, 00h, 00h, 77h, 78h, 00h, 00h
	defb	77h, 77h, 80h, 00h, 87h, 87h, 80h, 00h
	defb	87h, 87h, 80h, 00h, 77h, 77h, 80h, 00h
	defb	77h, 78h, 00h, 00h, 88h, 88h, 80h, 00h
	defb	00h, 00h, 8ah, 0aah, 00h, 08h, 0aah, 8ah
	defb	00h, 08h, 0bbh, 8ch, 00h, 00h, 88h, 8ch
	defb	00h, 00h, 08h, 0cch, 00h, 00h, 08h, 0cch
	defb	00h, 00h, 08h, 0bbh, 00h, 00h, 00h, 88h
	defb	0aah, 0aah, 0a8h, 00h, 0aah, 0a8h, 0aah, 80h
	defb	0cch, 0c8h, 0bbh, 80h, 88h, 0c8h, 88h, 00h
	defb	88h, 0cch, 80h, 00h, 88h, 0cch, 80h, 00h
	defb	88h, 0bbh, 80h, 00h, 00h, 88h, 00h, 00h
	defb	00h, 00h, 00h, 08h, 00h, 00h, 00h, 87h
	defb	00h, 00h, 08h, 77h, 00h, 00h, 08h, 77h
	defb	00h, 00h, 08h, 77h, 00h, 00h, 08h, 77h
	defb	00h, 00h, 00h, 87h, 00h, 00h, 08h, 88h
	defb	88h, 80h, 00h, 00h, 77h, 78h, 00h, 00h
	defb	77h, 77h, 80h, 00h, 87h, 87h, 80h, 00h
	defb	87h, 87h, 80h, 00h, 77h, 77h, 80h, 00h
	defb	77h, 78h, 00h, 00h, 88h, 88h, 88h, 00h
	defb	00h, 00h, 8ah, 0aah, 00h, 08h, 0aah, 8ah
	defb	00h, 08h, 0bbh, 8ch, 00h, 00h, 88h, 88h
	defb	00h, 00h, 8bh, 0cch, 00h, 00h, 8bh, 0cch
	defb	00h, 00h, 08h, 88h, 00h, 00h, 00h, 00h
	defb	0aah, 0a8h, 0abh, 80h, 0aah, 0a8h, 0abh, 80h
	defb	0cch, 0c8h, 88h, 00h, 0cch, 0c8h, 00h, 00h
	defb	0cch, 0cch, 80h, 00h, 88h, 0cch, 0c8h, 00h
	defb	00h, 8bh, 0bbh, 80h, 00h, 08h, 88h, 00h
	defb	00h, 00h, 00h, 08h, 00h, 00h, 00h, 87h
	defb	00h, 00h, 08h, 77h, 00h, 00h, 08h, 77h
	defb	00h, 00h, 08h, 77h, 00h, 00h, 08h, 77h
	defb	00h, 00h, 00h, 87h, 00h, 00h, 00h, 08h
	defb	88h, 80h, 00h, 00h, 77h, 78h, 00h, 00h
	defb	77h, 77h, 80h, 00h, 87h, 87h, 80h, 00h
	defb	87h, 87h, 80h, 00h, 77h, 77h, 80h, 00h
	defb	77h, 78h, 00h, 00h, 88h, 80h, 00h, 00h
	defb	00h, 00h, 00h, 08h, 00h, 00h, 00h, 08h
	defb	00h, 00h, 00h, 08h, 00h, 00h, 00h, 08h
	defb	00h, 00h, 00h, 8ch, 00h, 00h, 00h, 8ch
	defb	00h, 00h, 00h, 8bh, 00h, 00h, 00h, 08h
	defb	0aah, 80h, 00h, 00h, 0aah, 80h, 00h, 00h
	defb	0aah, 0a8h, 00h, 00h, 8bh, 0b8h, 00h, 00h
	defb	88h, 80h, 00h, 00h, 8ch, 0c8h, 00h, 00h
	defb	8bh, 0b8h, 00h, 00h, 08h, 80h, 00h, 00h
	defb	00h, 00h, 00h, 08h, 00h, 00h, 00h, 87h
	defb	00h, 00h, 08h, 77h, 00h, 00h, 08h, 77h
	defb	00h, 00h, 08h, 77h, 00h, 00h, 08h, 77h
	defb	00h, 00h, 00h, 87h, 00h, 00h, 08h, 88h
	defb	88h, 80h, 00h, 00h, 77h, 78h, 00h, 00h
	defb	77h, 77h, 80h, 00h, 87h, 87h, 80h, 00h
	defb	87h, 87h, 80h, 00h, 77h, 77h, 80h, 00h
	defb	77h, 78h, 00h, 00h, 88h, 80h, 00h, 00h
	defb	00h, 00h, 8ah, 8ah, 00h, 08h, 0aah, 8ah
	defb	00h, 08h, 0bbh, 8ch, 00h, 00h, 88h, 8ch
	defb	00h, 00h, 8bh, 0cch, 00h, 00h, 8bh, 0cch
	defb	00h, 00h, 08h, 88h, 00h, 00h, 00h, 00h
	defb	0aah, 0a8h, 80h, 00h, 8ah, 0aah, 0b8h, 00h
	defb	0c8h, 0aah, 0b8h, 00h, 0cch, 88h, 80h, 00h
	defb	0c8h, 0c8h, 00h, 00h, 8ch, 0cch, 80h, 00h
	defb	08h, 0bbh, 0b8h, 00h, 00h, 88h, 80h, 00h
	defb	00h, 00h, 08h, 88h, 00h, 00h, 87h, 77h
	defb	00h, 08h, 77h, 77h, 00h, 08h, 77h, 77h
	defb	00h, 08h, 77h, 77h, 00h, 08h, 77h, 77h
	defb	00h, 88h, 87h, 77h, 08h, 0bbh, 88h, 88h
	defb	80h, 00h, 00h, 00h, 78h, 00h, 00h, 00h
	defb	77h, 80h, 00h, 00h, 77h, 88h, 80h, 00h
	defb	77h, 8bh, 0b8h, 00h, 77h, 8ah, 0a8h, 00h
	defb	78h, 0aah, 0a8h, 00h, 8ah, 0aah, 80h, 00h
	defb	08h, 0aah, 0aah, 0aah, 08h, 0aah, 0aah, 0aah
	defb	00h, 8ah, 8ah, 0aah, 00h, 08h, 8ch, 0cch
	defb	00h, 00h, 8ch, 0c8h, 00h, 00h, 8bh, 0b8h
	defb	00h, 00h, 08h, 88h, 00h, 00h, 00h, 00h
	defb	0aah, 0a8h, 00h, 00h, 0aah, 80h, 00h, 00h
	defb	0aah, 80h, 00h, 00h, 0cch, 80h, 00h, 00h
	defb	0cch, 80h, 00h, 00h, 0cch, 80h, 00h, 00h
	defb	0bbh, 80h, 00h, 00h, 88h, 00h, 00h, 00h
	defb	00h, 00h, 00h, 08h, 00h, 00h, 00h, 87h
	defb	00h, 00h, 08h, 77h, 00h, 08h, 88h, 77h
	defb	00h, 8bh, 0b8h, 77h, 00h, 8ah, 0a8h, 77h
	defb	00h, 8ah, 0aah, 87h, 00h, 08h, 0aah, 0a8h
	defb	88h, 80h, 00h, 00h, 77h, 78h, 00h, 00h
	defb	77h, 77h, 80h, 00h, 77h, 77h, 80h, 00h
	defb	77h, 77h, 80h, 00h, 77h, 77h, 80h, 00h
	defb	77h, 78h, 88h, 00h, 88h, 88h, 0bbh, 80h
	defb	00h, 00h, 8ah, 0aah, 00h, 00h, 08h, 0aah
	defb	00h, 00h, 08h, 0aah, 00h, 00h, 08h, 0cch
	defb	00h, 00h, 08h, 0cch, 00h, 00h, 08h, 0cch
	defb	00h, 00h, 08h, 0bbh, 00h, 00h, 00h, 88h
	defb	0aah, 0aah, 0aah, 80h, 0aah, 0aah, 0aah, 80h
	defb	0aah, 0a8h, 0a8h, 00h, 0cch, 0c8h, 80h, 00h
	defb	8ch, 0c8h, 00h, 00h, 8bh, 0b8h, 00h, 00h
	defb	88h, 80h, 00h, 00h, 00h, 00h, 00h, 00h
	defb	00h, 00h, 88h, 88h, 00h, 08h, 33h, 33h
	defb	00h, 83h, 33h, 33h, 08h, 33h, 33h, 33h
	defb	83h, 33h, 33h, 33h, 83h, 38h, 33h, 83h
	defb	83h, 38h, 33h, 83h, 83h, 38h, 33h, 83h
	defb	88h, 00h, 00h, 00h, 33h, 88h, 00h, 00h
	defb	33h, 33h, 80h, 00h, 33h, 33h, 38h, 00h
	defb	33h, 33h, 33h, 80h, 33h, 33h, 33h, 38h
	defb	33h, 33h, 33h, 38h, 33h, 33h, 33h, 38h
	defb	08h, 33h, 33h, 33h, 00h, 83h, 33h, 33h
	defb	00h, 08h, 88h, 88h, 00h, 8dh, 80h, 8dh
	defb	00h, 8dh, 80h, 8dh, 00h, 8dh, 80h, 8dh
	defb	00h, 08h, 0d8h, 08h, 00h, 00h, 80h, 00h
	defb	33h, 33h, 33h, 80h, 33h, 33h, 88h, 00h
	defb	88h, 88h, 00h, 00h, 80h, 8dh, 80h, 00h
	defb	80h, 8dh, 80h, 00h, 80h, 8dh, 80h, 00h
	defb	0d8h, 08h, 0d8h, 00h, 80h, 00h, 80h, 00h
	defb	00h, 00h, 00h, 00h, 00h, 00h, 88h, 88h
	defb	00h, 08h, 33h, 33h, 00h, 83h, 33h, 33h
	defb	08h, 33h, 33h, 33h, 83h, 33h, 33h, 33h
	defb	83h, 38h, 33h, 83h, 83h, 38h, 33h, 83h
	defb	00h, 00h, 00h, 00h, 88h, 00h, 00h, 00h
	defb	33h, 88h, 00h, 00h, 33h, 33h, 80h, 00h
	defb	33h, 33h, 38h, 00h, 33h, 33h, 33h, 80h
	defb	33h, 33h, 33h, 38h, 33h, 33h, 33h, 38h
	defb	83h, 38h, 33h, 83h, 08h, 33h, 33h, 33h
	defb	00h, 88h, 88h, 88h, 00h, 08h, 0d8h, 08h
	defb	00h, 08h, 0d8h, 08h, 00h, 08h, 0d8h, 08h
	defb	00h, 00h, 8dh, 80h, 00h, 00h, 08h, 00h
	defb	33h, 33h, 33h, 38h, 33h, 33h, 33h, 80h
	defb	88h, 88h, 88h, 00h, 0d8h, 08h, 0d8h, 00h
	defb	0d8h, 08h, 0d8h, 00h, 0d8h, 08h, 0d8h, 00h
	defb	8dh, 80h, 8dh, 80h, 08h, 00h, 08h, 00h
	defb	00h, 00h, 00h, 88h, 00h, 00h, 88h, 33h
	defb	00h, 08h, 33h, 33h, 00h, 83h, 33h, 33h
	defb	08h, 33h, 33h, 33h, 83h, 33h, 33h, 33h
	defb	83h, 33h, 33h, 33h, 83h, 33h, 33h, 33h
	defb	88h, 88h, 00h, 00h, 33h, 33h, 80h, 00h
	defb	33h, 33h, 38h, 00h, 33h, 33h, 33h, 80h
	defb	33h, 33h, 33h, 38h, 38h, 33h, 83h, 38h
	defb	38h, 33h, 83h, 38h, 38h, 33h, 83h, 38h
	defb	08h, 33h, 33h, 33h, 00h, 88h, 33h, 33h
	defb	00h, 00h, 88h, 88h, 00h, 08h, 0d8h, 08h
	defb	00h, 08h, 0d8h, 08h, 00h, 08h, 0d8h, 08h
	defb	00h, 8dh, 80h, 8dh, 00h, 08h, 00h, 08h
	defb	33h, 33h, 33h, 80h, 33h, 33h, 38h, 00h
	defb	88h, 88h, 80h, 00h, 0d8h, 08h, 0d8h, 00h
	defb	0d8h, 08h, 0d8h, 00h, 0d8h, 08h, 0d8h, 00h
	defb	80h, 8dh, 80h, 00h, 00h, 08h, 00h, 00h
	defb	00h, 00h, 00h, 00h, 00h, 00h, 00h, 88h
	defb	00h, 00h, 88h, 33h, 00h, 08h, 33h, 33h
	defb	00h, 83h, 33h, 33h, 08h, 33h, 33h, 33h
	defb	83h, 33h, 33h, 33h, 83h, 33h, 33h, 33h
	defb	00h, 00h, 00h, 00h, 88h, 88h, 00h, 00h
	defb	33h, 33h, 80h, 00h, 33h, 33h, 38h, 00h
	defb	33h, 33h, 33h, 80h, 33h, 33h, 33h, 38h
	defb	38h, 33h, 83h, 38h, 38h, 33h, 83h, 38h
	defb	83h, 33h, 33h, 33h, 08h, 33h, 33h, 33h
	defb	00h, 88h, 88h, 88h, 00h, 8dh, 80h, 8dh
	defb	00h, 8dh, 80h, 8dh, 00h, 8dh, 80h, 8dh
	defb	08h, 0d8h, 08h, 0d8h, 00h, 80h, 00h, 80h
	defb	38h, 33h, 83h, 38h, 33h, 33h, 33h, 80h
	defb	88h, 88h, 88h, 00h, 80h, 8dh, 80h, 00h
	defb	80h, 8dh, 80h, 00h, 80h, 8dh, 80h, 00h
	defb	08h, 0d8h, 00h, 00h, 00h, 80h, 00h, 00h
	defb	00h, 00h, 80h, 00h, 00h, 08h, 0d8h, 08h
	defb	00h, 8dh, 80h, 8dh, 00h, 8dh, 80h, 8dh
	defb	00h, 8dh, 80h, 8dh, 00h, 88h, 88h, 88h
	defb	08h, 33h, 33h, 33h, 83h, 33h, 33h, 33h
	defb	80h, 00h, 80h, 00h, 0d8h, 08h, 0d8h, 00h
	defb	80h, 8dh, 80h, 00h, 80h, 8dh, 80h, 00h
	defb	80h, 8dh, 80h, 00h, 88h, 88h, 80h, 00h
	defb	33h, 33h, 38h, 00h, 33h, 33h, 33h, 80h
	defb	83h, 38h, 38h, 33h, 83h, 33h, 83h, 33h
	defb	83h, 38h, 38h, 33h, 08h, 33h, 33h, 33h
	defb	08h, 33h, 33h, 33h, 00h, 83h, 33h, 33h
	defb	00h, 08h, 83h, 33h, 00h, 00h, 08h, 88h
	defb	38h, 38h, 33h, 80h, 33h, 83h, 33h, 80h
	defb	38h, 38h, 33h, 80h, 33h, 33h, 38h, 00h
	defb	33h, 33h, 38h, 00h, 33h, 33h, 80h, 00h
	defb	33h, 88h, 00h, 00h, 88h, 00h, 00h, 00h
	defb	00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h
	defb	00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h
	defb	00h, 00h, 00h, 00h, 00h, 00h, 00h, 88h
	defb	00h, 00h, 88h, 44h, 00h, 08h, 44h, 4bh
	defb	00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h
	defb	00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h
	defb	88h, 88h, 00h, 00h, 44h, 44h, 80h, 00h
	defb	48h, 48h, 00h, 00h, 0b4h, 80h, 80h, 00h
	defb	00h, 08h, 4bh, 0bbh, 00h, 84h, 4bh, 6bh
	defb	00h, 84h, 0bbh, 66h, 00h, 84h, 4bh, 0bbh
	defb	00h, 08h, 44h, 44h, 00h, 00h, 84h, 44h
	defb	00h, 00h, 08h, 88h, 00h, 00h, 00h, 00h
	defb	0bbh, 48h, 48h, 00h, 0b4h, 44h, 80h, 00h
	defb	0bbh, 48h, 00h, 00h, 0b4h, 48h, 00h, 00h
	defb	44h, 80h, 00h, 00h, 88h, 00h, 00h, 00h
	defb	00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h
	defb	00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h
	defb	00h, 08h, 88h, 88h, 00h, 82h, 22h, 22h
	defb	08h, 22h, 22h, 22h, 82h, 2ch, 2ch, 22h
	defb	82h, 0cch, 2ch, 22h, 82h, 2ch, 2ch, 22h
	defb	00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h
	defb	88h, 88h, 80h, 00h, 22h, 22h, 28h, 00h
	defb	22h, 22h, 22h, 80h, 0c2h, 0cch, 0c2h, 28h
	defb	0c2h, 0c2h, 2ch, 28h, 0c2h, 0c2h, 2ch, 28h
	defb	82h, 2ch, 2ch, 22h, 82h, 2ch, 2ch, 22h
	defb	82h, 0cch, 0c2h, 0cch, 08h, 22h, 22h, 22h
	defb	00h, 82h, 22h, 22h, 00h, 08h, 88h, 88h
	defb	00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h
	defb	0c2h, 0cch, 0c2h, 28h, 0c2h, 0c2h, 22h, 28h
	defb	22h, 0c2h, 22h, 28h, 22h, 22h, 22h, 80h
	defb	22h, 22h, 28h, 00h, 88h, 88h, 80h, 00h
	defb	00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h
