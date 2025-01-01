cseg

Ascii_: public Ascii_
    defb	000h, 000h, 000h, 000h, 070h, 000h, 010h, 000h
	defb	003h, 003h, 000h, 000h, 07ah, 00ah, 001h, 001h
	defb	0f6h, 00dh, 011h, 000h, 049h, 002h, 000h, 001h
	defb	0b7h, 006h, 001h, 001h, 030h, 000h, 000h, 000h
	defb	01eh, 000h, 010h, 000h, 010h, 00eh, 010h, 000h
	defb	0feh, 00eh, 010h, 000h, 0e4h, 004h, 000h, 000h
	defb	080h, 000h, 001h, 000h, 044h, 004h, 000h, 000h
	defb	000h, 000h, 010h, 000h, 048h, 002h, 000h, 000h
	defb	01fh, 00fh, 011h, 001h, 000h, 00fh, 000h, 001h
	defb	05dh, 007h, 011h, 001h, 055h, 00fh, 011h, 001h
	defb	047h, 00fh, 000h, 001h, 057h, 00dh, 011h, 001h
	defb	05fh, 00dh, 011h, 001h, 011h, 00fh, 000h, 001h
	defb	05fh, 00fh, 011h, 001h, 057h, 00fh, 011h, 001h
	defb	0a0h, 000h, 000h, 000h, 0a0h, 000h, 001h, 000h
	defb	0a4h, 001h, 000h, 001h, 0aah, 00ah, 000h, 000h
	defb	010h, 04ah, 010h, 000h, 051h, 002h, 010h, 000h
	defb	01eh, 006h, 010h, 000h, 09fh, 00fh, 001h, 001h
	defb	05fh, 00ah, 011h, 000h, 01fh, 001h, 011h, 001h
	defb	01fh, 00eh, 011h, 000h, 05fh, 001h, 011h, 001h
	defb	05fh, 001h, 001h, 000h, 01eh, 00dh, 010h, 001h
	defb	04fh, 00fh, 001h, 001h, 0f1h, 001h, 011h, 001h
	defb	018h, 00fh, 010h, 001h, 0afh, 001h, 001h, 001h
	defb	00fh, 000h, 011h, 001h, 06fh, 00fh, 001h, 001h
	defb	01fh, 00eh, 001h, 001h, 01fh, 00fh, 011h, 001h
	defb	05fh, 007h, 001h, 000h, 09fh, 007h, 010h, 001h
	defb	05fh, 00bh, 001h, 001h, 056h, 00dh, 011h, 000h
	defb	0f1h, 001h, 010h, 000h, 00fh, 00fh, 011h, 001h
	defb	00fh, 00fh, 010h, 000h, 0cfh, 00fh, 001h, 001h
	defb	04bh, 00bh, 001h, 001h, 0c3h, 003h, 010h, 000h
	defb	059h, 003h, 011h, 001h, 0f0h, 001h, 010h, 001h
	defb	042h, 008h, 000h, 000h, 0f1h, 000h, 011h, 000h
	defb	012h, 002h, 000h, 000h, 000h, 000h, 011h, 001h
    
Chars_: public Chars_
;	logo
	defb	00h, 0f8h, 00h, 0f8h, 33h, 0b8h, 00h, 0b8h
	defb	0cch, 0b8h, 00h, 0b8h, 0ffh, 0b8h, 00h, 0b8h
	defb	00h, 0b8h, 33h, 0b8h, 33h, 0b8h, 33h, 0b8h
	defb	0cch, 0b8h, 33h, 0b8h, 0ffh, 0b8h, 33h, 0b8h
	defb	00h, 0b8h, 0cch, 0b8h, 33h, 0b8h, 0cch, 0b8h
	defb	0cch, 0b8h, 0cch, 0b8h, 0ffh, 0b8h, 0cch, 0b8h
	defb	00h, 0b8h, 0ffh, 0b8h, 33h, 0b8h, 0ffh, 0b8h
	defb	0cch, 0b8h, 0ffh, 0b8h, 0ffh, 0b8h, 0ffh, 0b8h
;	wall
	defb	00h, 0d8h, 00h, 0d8h, 0fh, 38h, 00h, 38h
	defb	00h, 38h, 0f0h, 38h, 0fh, 38h, 0f0h, 38h
	defb	11h, 38h, 11h, 38h, 1eh, 38h, 11h, 38h
	defb	11h, 38h, 0e1h, 38h, 1eh, 38h, 0e1h, 38h
	defb	88h, 38h, 88h, 38h, 87h, 38h, 88h, 38h
	defb	88h, 38h, 78h, 38h, 87h, 38h, 78h, 38h
	defb	99h, 38h, 99h, 38h, 96h, 38h, 99h, 38h
	defb	99h, 38h, 69h, 38h, 96h, 38h, 69h, 38h
;	point
	defb	00h, 0f8h, 0fh, 0f8h, 0d9h, 0f8h, 0ah, 0f8h
	defb	47h, 0f8h, 0fh, 0f8h, 0afh, 0f8h, 0fh, 0f8h
	defb	9fh, 0f8h, 0fh, 0f8h
;	8dot
	defb	20h, 0f8h, 0e6h, 0f8h, 0f7h, 0f8h, 45h, 0f8h
	defb	80h, 0f8h, 19h, 0f8h, 0a5h, 0f8h, 00h, 0f8h
	defb	20h, 0f8h, 0e6h, 0f8h, 0f7h, 0f8h, 45h, 0f8h
	defb	20h, 0f8h, 91h, 0f8h, 29h, 0f8h, 04h, 0f8h
	defb	54h, 0f8h, 7fh, 0f8h, 6eh, 0f8h, 02h, 0f8h
	defb	00h, 0f8h, 5ah, 0f8h, 91h, 0f8h, 08h, 0f8h
	defb	54h, 0f8h, 7fh, 0f8h, 6eh, 0f8h, 02h, 0f8h
	defb	40h, 0f8h, 92h, 0f8h, 19h, 0f8h, 02h, 0f8h
	defb	54h, 0f8h, 0ffh, 0f8h, 4eh, 0f8h, 04h, 0f8h
	defb	10h, 0f8h, 0ch, 0f8h, 34h, 0f8h, 00h, 0f8h
	defb	54h, 0f8h, 0ffh, 0f8h, 4eh, 0f8h, 04h, 0f8h
	defb	30h, 0f8h, 04h, 0f8h, 1ch, 0f8h, 00h, 0f8h
	defb	0c4h, 0f8h, 0f6h, 0f8h, 0d7h, 0f8h, 04h, 0f8h
	defb	00h, 0f8h, 1dh, 0f8h, 25h, 0f8h, 00h, 0f8h
	defb	0c4h, 0f8h, 0f6h, 0f8h, 0d7h, 0f8h, 04h, 0f8h
	defb	20h, 0f8h, 15h, 0f8h, 0dh, 0f8h, 00h, 0f8h
	defb	0a8h, 78h, 0afh, 78h, 0efh, 78h, 08h, 78h
	defb	10h, 78h, 73h, 78h, 0bfh, 78h, 00h, 78h
	defb	40h, 78h, 4eh, 78h, 0ceh, 78h, 00h, 78h
	defb	32h, 78h, 0f7h, 78h, 0ffh, 78h, 02h, 78h
	defb	80h, 78h, 0feh, 78h, 0fah, 78h, 8ah, 78h
	defb	00h, 78h, 0fbh, 78h, 37h, 78h, 01h, 78h
	defb	00h, 78h, 0ech, 78h, 0e4h, 78h, 04h, 78h
	defb	20h, 78h, 0ffh, 78h, 7fh, 78h, 23h, 78h
	defb	80h, 78h, 0feh, 78h, 0feh, 78h, 8eh, 78h
	defb	00h, 78h, 73h, 78h, 7fh, 78h, 03h, 78h
	defb	00h, 78h, 0ech, 78h, 0ech, 78h, 0ch, 78h
	defb	20h, 78h, 0f7h, 78h, 0ffh, 78h, 27h, 78h
	defb	0e8h, 78h, 0ebh, 78h, 0ebh, 78h, 08h, 78h
	defb	30h, 78h, 0f7h, 78h, 37h, 78h, 00h, 78h
	defb	0c0h, 78h, 0c6h, 78h, 0c6h, 78h, 00h, 78h
	defb	72h, 78h, 0ffh, 78h, 7fh, 78h, 02h, 78h
	defb	00h, 0f8h, 48h, 58h, 4ch, 58h, 00h, 0f8h
	defb	30h, 58h, 54h, 58h, 12h, 58h, 00h, 58h
	defb	00h, 0f8h, 68h, 58h, 08h, 58h, 00h, 0f8h
	defb	70h, 58h, 0a8h, 58h, 78h, 58h, 00h, 0f8h
	defb	00h, 0d8h, 80h, 0d8h, 08h, 0d8h, 00h, 0d8h
	defb	00h, 0d8h, 10h, 0d8h, 01h, 0d8h, 00h, 0d8h
	defb	64h, 0d8h, 75h, 0d8h, 73h, 0d8h, 46h, 0d8h
	defb	0d4h, 0d8h, 0ddh, 0d8h, 0ddh, 0d8h, 4dh, 0d8h
