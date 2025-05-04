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
	defb	00h, 0b8h, 00h, 0b8h, 33h, 0b8h, 00h, 0b8h
	defb	0cch, 0b8h, 00h, 0b8h, 0ffh, 0b8h, 00h, 0b8h
	defb	00h, 0b8h, 33h, 0b8h, 33h, 0b8h, 33h, 0b8h
	defb	0cch, 0b8h, 33h, 0b8h, 0ffh, 0b8h, 33h, 0b8h
	defb	00h, 0b8h, 0cch, 0b8h, 33h, 0b8h, 0cch, 0b8h
	defb	0cch, 0b8h, 0cch, 0b8h, 0ffh, 0b8h, 0cch, 0b8h
	defb	00h, 0b8h, 0ffh, 0b8h, 33h, 0b8h, 0ffh, 0b8h
	defb	0cch, 0b8h, 0ffh, 0b8h, 0ffh, 0b8h, 0ffh, 0b8h
;	4dot
	defb	44h, 0f8h, 4eh, 0f8h, 0e4h, 0f8h, 44h, 0f8h
	defb	40h, 0f8h, 4fh, 0f8h, 0f2h, 0f8h, 02h, 0f8h
	defb	00h, 0f8h, 00h, 0f8h
;	point
	defb	00h, 0f8h, 0eh, 0f8h, 00h, 0f8h, 03h, 0f8h
	defb	0aah, 0f8h, 0eh, 0f8h, 23h, 0f8h, 02h, 0f8h
	defb	8eh, 0f8h, 0eh, 0f8h, 00h, 0f8h, 03h, 0f8h
	defb	0aeh, 0f8h, 0eh, 0f8h, 23h, 0f8h, 03h, 0f8h
	defb	2eh, 0f8h, 0eh, 0f8h, 23h, 0f8h, 03h, 0f8h
;	8dot
	defb	80h, 0f8h, 0f3h, 0f8h, 84h, 0f8h, 00h, 0f8h
	defb	00h, 0f8h, 1eh, 0f8h, 0ch, 0f8h, 00h, 0f8h
	defb	80h, 0f8h, 0f3h, 0f8h, 84h, 0f8h, 00h, 0f8h
	defb	01h, 0f8h, 1eh, 0f8h, 44h, 0f8h, 00h, 0f8h
	defb	00h, 0f8h, 0f3h, 0f8h, 00h, 0f8h, 00h, 0f8h
	defb	00h, 0f8h, 61h, 0f8h, 08h, 0f8h, 00h, 0f8h
	defb	00h, 0f8h, 0fbh, 0f8h, 80h, 0f8h, 00h, 0f8h
	defb	10h, 0f8h, 1ch, 0f8h, 42h, 0f8h, 04h, 0f8h
	defb	00h, 0f8h, 48h, 0f8h, 3fh, 0f8h, 08h, 0f8h
	defb	00h, 0f8h, 0c0h, 0f8h, 0e1h, 0f8h, 00h, 0f8h
	defb	00h, 0f8h, 48h, 0f8h, 3fh, 0f8h, 08h, 0f8h
	defb	00h, 0f8h, 44h, 0f8h, 0e1h, 0f8h, 10h, 0f8h
	defb	00h, 0f8h, 00h, 0f8h, 3fh, 0f8h, 00h, 0f8h
	defb	00h, 0f8h, 80h, 0f8h, 16h, 0f8h, 00h, 0f8h
	defb	00h, 0f8h, 08h, 0f8h, 0bfh, 0f8h, 00h, 0f8h
	defb	40h, 0f8h, 24h, 0f8h, 0c1h, 0f8h, 01h, 0f8h
	defb	0cch, 0f8h, 0a8h, 0f8h, 48h, 0f8h, 44h, 0f8h
	defb	00h, 0f8h, 21h, 0f8h, 00h, 0f8h, 11h, 0f8h
	defb	0cch, 0f8h, 0a8h, 0f8h, 49h, 0f8h, 44h, 0f8h
	defb	00h, 0f8h, 21h, 0f8h, 00h, 0f8h, 03h, 0f8h
	defb	0cch, 0f8h, 88h, 0f8h, 84h, 0f8h, 08h, 0f8h
	defb	00h, 0f8h, 00h, 0f8h, 00h, 0f8h, 10h, 0f8h
	defb	0cch, 0f8h, 0c8h, 0f8h, 0ah, 0f8h, 44h, 0f8h
	defb	00h, 0f8h, 20h, 0f8h, 10h, 0f8h, 06h, 0f8h
	defb	00h, 0f8h, 48h, 0f8h, 00h, 0f8h, 88h, 0f8h
	defb	33h, 0f8h, 51h, 0f8h, 21h, 0f8h, 22h, 0f8h
	defb	00h, 0f8h, 48h, 0f8h, 00h, 0f8h, 0ch, 0f8h
	defb	33h, 0f8h, 51h, 0f8h, 29h, 0f8h, 22h, 0f8h
	defb	00h, 0f8h, 00h, 0f8h, 00h, 0f8h, 80h, 0f8h
	defb	33h, 0f8h, 11h, 0f8h, 12h, 0f8h, 01h, 0f8h
	defb	00h, 0f8h, 40h, 0f8h, 80h, 0f8h, 06h, 0f8h
	defb	33h, 0f8h, 31h, 0f8h, 05h, 0f8h, 22h, 0f8h
	defb	00h, 0f8h, 30h, 0f8h, 78h, 0f8h, 00h, 0f8h
	defb	00h, 0f8h, 21h, 0f8h, 0cfh, 0f8h, 01h, 0f8h
	defb	44h, 0f8h, 84h, 0f8h, 8ah, 0f8h, 0cch, 0f8h
	defb	11h, 0f8h, 00h, 0f8h, 12h, 0f8h, 00h, 0f8h
	defb	60h, 78h, 69h, 78h, 68h, 78h, 69h, 78h
	defb	0c0h, 78h, 36h, 78h, 3fh, 78h, 0c6h, 78h
	defb	0c0h, 58h, 3eh, 58h, 3fh, 58h, 0ceh, 58h
	defb	0c0h, 58h, 37h, 58h, 3fh, 58h, 0c7h, 58h
	defb	1fh, 0f8h, 11h, 0f8h, 99h, 0f8h, 0f1h, 0f8h
	defb	8fh, 0f8h, 8bh, 0f8h, 0bbh, 0f8h, 0f8h, 0f8h
	defb	88h, 0f8h, 0c0h, 0f8h, 0ch, 0f8h, 0eeh, 0f8h
	defb	0bbh, 0f8h, 0d8h, 0f8h, 0cdh, 0f8h, 0eeh, 0f8h
	defb	0f0h, 0d8h, 0ffh, 0d8h, 7fh, 0d8h, 0fh, 0d8h
	defb	0f0h, 0d8h, 0ffh, 0d8h, 0efh, 0d8h, 0fh, 0d8h
