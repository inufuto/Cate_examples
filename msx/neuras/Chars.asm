CharPatterns:
    public CharPatterns
;	wall
	defb	000h, 000h, 000h, 000h, 000h, 000h, 000h, 000h
	defb	0c0h, 0c0h, 0c0h, 0c0h, 0c0h, 0c0h, 0c0h, 0c0h
	defb	003h, 003h, 003h, 003h, 003h, 003h, 003h, 003h
	defb	0c3h, 0c3h, 0c3h, 0c3h, 0c3h, 0c3h, 0c3h, 0c3h
	defb	0ffh, 0ffh, 000h, 000h, 000h, 000h, 000h, 000h
	defb	07fh, 0ffh, 0c0h, 0c0h, 0c0h, 0c0h, 0c0h, 0c0h
	defb	0feh, 0ffh, 003h, 003h, 003h, 003h, 003h, 003h
	defb	07eh, 0ffh, 0c3h, 0c3h, 0c3h, 0c3h, 0c3h, 0c3h
	defb	000h, 000h, 000h, 000h, 000h, 000h, 0ffh, 0ffh
	defb	0c0h, 0c0h, 0c0h, 0c0h, 0c0h, 0c0h, 0ffh, 07fh
	defb	003h, 003h, 003h, 003h, 003h, 003h, 0ffh, 0feh
	defb	0c3h, 0c3h, 0c3h, 0c3h, 0c3h, 0c3h, 0ffh, 07eh
	defb	0ffh, 0ffh, 000h, 000h, 000h, 000h, 0ffh, 0ffh
	defb	07fh, 0ffh, 0c0h, 0c0h, 0c0h, 0c0h, 0ffh, 07fh
	defb	0feh, 0ffh, 003h, 003h, 003h, 003h, 0ffh, 0feh
	defb	07eh, 0ffh, 0c3h, 0c3h, 0c3h, 0c3h, 0ffh, 07eh
;	BG
	defb	000h, 00fh, 01fh, 03fh, 02bh, 02bh, 03fh, 000h
	defb	000h, 0c0h, 0e0h, 0f0h, 0f0h, 0f0h, 0f0h, 000h
	defb	03fh, 03fh, 03fh, 03fh, 03fh, 000h, 070h, 0e0h
	defb	0f0h, 0d8h, 0b0h, 0b0h, 0c0h, 000h, 038h, 01ch
	defb	004h, 006h, 00fh, 01ah, 01ah, 01fh, 015h, 050h
	defb	080h, 0c0h, 0e0h, 0f0h, 0f0h, 0f0h, 070h, 076h
	defb	06fh, 03fh, 01fh, 00fh, 007h, 003h, 001h, 000h
	defb	0eeh, 0fch, 0f8h, 0f0h, 0e0h, 0e0h, 0f0h, 078h
	defb	000h, 00fh, 01ah, 035h, 02ah, 035h, 02ah, 035h
	defb	000h, 0e0h, 0b0h, 058h, 0a8h, 058h, 0a8h, 058h
	defb	02ah, 035h, 02ah, 035h, 02ah, 035h, 01ah, 00fh
	defb	0a8h, 058h, 0a8h, 058h, 0a8h, 058h, 0b0h, 0e0h
	defb	000h, 00fh, 01fh, 03fh, 03fh, 03ch, 039h, 033h
	defb	000h, 0e0h, 0f0h, 0f8h, 0f8h, 078h, 038h, 098h
	defb	033h, 030h, 033h, 033h, 03fh, 03fh, 01fh, 00fh
	defb	098h, 018h, 098h, 098h, 0f8h, 0f8h, 0f0h, 0e0h
	defb	000h, 00fh, 01fh, 03fh, 03fh, 038h, 033h, 03fh
	defb	000h, 0e0h, 0f0h, 0f8h, 0f8h, 038h, 098h, 018h
	defb	03ch, 038h, 031h, 030h, 03fh, 03fh, 01fh, 00fh
	defb	038h, 078h, 0f8h, 018h, 0f8h, 0f8h, 0f0h, 0e0h
	defb	000h, 00fh, 01fh, 03fh, 03fh, 038h, 033h, 03fh
	defb	000h, 0e0h, 0f0h, 0f8h, 0f8h, 038h, 098h, 098h
	defb	03ch, 03fh, 033h, 038h, 03fh, 03fh, 01fh, 00fh
	defb	038h, 098h, 098h, 038h, 0f8h, 0f8h, 0f0h, 0e0h
	defb	000h, 00fh, 01fh, 03fh, 03fh, 03fh, 03eh, 03ch
	defb	000h, 0e0h, 0f0h, 0f8h, 0f8h, 038h, 038h, 038h
	defb	039h, 033h, 030h, 03fh, 03fh, 03fh, 01fh, 00fh
	defb	038h, 038h, 018h, 038h, 0f8h, 0f8h, 0f0h, 0e0h
	defb	000h, 00fh, 01fh, 03fh, 03fh, 030h, 033h, 030h
	defb	000h, 0e0h, 0f0h, 0f8h, 0f8h, 018h, 0f8h, 038h
	defb	03fh, 03fh, 033h, 038h, 03fh, 03fh, 01fh, 00fh
	defb	098h, 098h, 098h, 038h, 0f8h, 0f8h, 0f0h, 0e0h
	defb	000h, 00fh, 01fh, 03fh, 03fh, 03ch, 039h, 033h
	defb	000h, 0e0h, 0f0h, 0f8h, 0f8h, 038h, 0f8h, 0f8h
	defb	030h, 033h, 033h, 038h, 03fh, 03fh, 01fh, 00fh
	defb	038h, 098h, 098h, 038h, 0f8h, 0f8h, 0f0h, 0e0h
	defb	000h, 00fh, 01fh, 03fh, 03fh, 030h, 033h, 03fh
	defb	000h, 0e0h, 0f0h, 0f8h, 0f8h, 018h, 098h, 038h
	defb	03eh, 03ch, 03ch, 03ch, 03fh, 03fh, 01fh, 00fh
	defb	078h, 0f8h, 0f8h, 0f8h, 0f8h, 0f8h, 0f0h, 0e0h
	defb	000h, 00fh, 01fh, 03fh, 03fh, 038h, 033h, 033h
	defb	000h, 0e0h, 0f0h, 0f8h, 0f8h, 038h, 098h, 098h
	defb	038h, 033h, 033h, 038h, 03fh, 03fh, 01fh, 00fh
	defb	038h, 098h, 098h, 038h, 0f8h, 0f8h, 0f0h, 0e0h
	defb	000h, 00fh, 01fh, 03fh, 03fh, 038h, 033h, 033h
	defb	000h, 0e0h, 0f0h, 0f8h, 0f8h, 038h, 098h, 098h
	defb	038h, 03fh, 033h, 038h, 03fh, 03fh, 01fh, 00fh
	defb	018h, 098h, 098h, 038h, 0f8h, 0f8h, 0f0h, 0e0h
	defb	000h, 00fh, 01fh, 03fh, 03fh, 033h, 022h, 032h
	defb	000h, 0e0h, 0f0h, 0f8h, 0f8h, 018h, 048h, 048h
	defb	032h, 032h, 032h, 033h, 03fh, 03fh, 01fh, 00fh
	defb	048h, 048h, 048h, 018h, 0f8h, 0f8h, 0f0h, 0e0h
	defb	000h, 00fh, 01fh, 03fh, 03fh, 03fh, 03fh, 03fh
	defb	000h, 0e0h, 0f0h, 0f8h, 0f8h, 098h, 098h, 098h
	defb	03fh, 03fh, 033h, 038h, 03fh, 03fh, 01fh, 00fh
	defb	098h, 098h, 098h, 038h, 0f8h, 0f8h, 0f0h, 0e0h
	defb	000h, 00fh, 01fh, 03fh, 03fh, 038h, 033h, 033h
	defb	000h, 0e0h, 0f0h, 0f8h, 0f8h, 038h, 098h, 098h
	defb	033h, 032h, 033h, 038h, 03fh, 03fh, 01fh, 00fh
	defb	098h, 098h, 038h, 098h, 0f8h, 0f8h, 0f0h, 0e0h
	defb	000h, 00fh, 01fh, 03fh, 03fh, 033h, 033h, 032h
	defb	000h, 0e0h, 0f0h, 0f8h, 0f8h, 098h, 038h, 078h
	defb	030h, 032h, 033h, 033h, 03fh, 03fh, 01fh, 00fh
	defb	0f8h, 078h, 038h, 098h, 0f8h, 0f8h, 0f0h, 0e0h
;	Title
	defb	03ch, 03ch, 03eh, 03fh, 03fh, 03fh, 03fh, 03dh
	defb	00fh, 00fh, 00fh, 00fh, 08fh, 0cfh, 0efh, 0ffh
	defb	03ch, 03ch, 03ch, 03ch, 03ch, 03ch, 000h, 000h
	defb	0ffh, 07fh, 03fh, 01fh, 00fh, 00fh, 000h, 000h
	defb	03fh, 03fh, 03ch, 03ch, 03ch, 03ch, 03fh, 03fh
	defb	0ffh, 0ffh, 000h, 000h, 000h, 000h, 0ffh, 0ffh
	defb	03ch, 03ch, 03ch, 03ch, 03fh, 03fh, 000h, 000h
	defb	000h, 000h, 000h, 000h, 0ffh, 0ffh, 000h, 000h
	defb	03ch, 03ch, 03ch, 03ch, 03ch, 03ch, 03ch, 03ch
	defb	00fh, 00fh, 00fh, 00fh, 00fh, 00fh, 00fh, 00fh
	defb	03ch, 03ch, 03ch, 03eh, 01fh, 00fh, 000h, 000h
	defb	00fh, 00fh, 00fh, 01fh, 0feh, 0fch, 000h, 000h
	defb	03fh, 03fh, 03ch, 03ch, 03ch, 03ch, 03ch, 03ch
	defb	0f8h, 0fch, 01eh, 00fh, 00fh, 01eh, 03ch, 078h
	defb	03fh, 03fh, 03ch, 03ch, 03ch, 03ch, 000h, 000h
	defb	0f0h, 0f8h, 03ch, 01eh, 00fh, 007h, 000h, 000h
	defb	003h, 007h, 00fh, 01eh, 03ch, 03ch, 03ch, 03ch
	defb	0f0h, 0f8h, 03ch, 01eh, 00fh, 00fh, 00fh, 00fh
	defb	03fh, 03fh, 03ch, 03ch, 03ch, 03ch, 000h, 000h
	defb	0ffh, 0ffh, 00fh, 00fh, 00fh, 00fh, 000h, 000h
	defb	00fh, 01fh, 03ch, 038h, 038h, 03ch, 01fh, 00fh
	defb	0fch, 0feh, 00fh, 007h, 000h, 000h, 0fch, 0feh
	defb	000h, 000h, 038h, 03ch, 01fh, 00fh, 000h, 000h
	defb	00fh, 007h, 007h, 00fh, 0feh, 0fch, 000h, 000h

BGColors:
	public BGColors
	defb	070h, 0d0h, 0f0h, 0f0h, 0f0h, 0f0h, 0f0h, 0f0h
	defb	0f0h, 0f0h, 0f0h, 0f0h, 0f0h, 0f0h, 0f0h, 0f0h
	defb	0f0h, 70h, 0a0h, 0d0h, 70h, 0a0h

AsciiPatterns:
	public AsciiPatterns
	defb 000H,000H,000H,000H,000H,000H,000H,000H
	defb 018H,018H,018H,018H,018H,000H,018H,000H
	defb 036H,036H,036H,000H,000H,000H,000H,000H
	defb 006H,037H,03eH,077H,03eH,076H,030H,000H
	defb 008H,03fH,048H,03eH,009H,07eH,008H,000H
	defb 000H,032H,054H,068H,016H,02aH,04cH,000H
	defb 038H,06cH,06cH,038H,06bH,066H,03bH,000H
	defb 00cH,018H,030H,000H,000H,000H,000H,000H
	defb 00cH,018H,030H,030H,030H,018H,00cH,000H
	defb 030H,018H,00cH,00cH,00cH,018H,030H,000H
	defb 008H,02aH,01cH,07fH,01cH,02aH,008H,000H
	defb 000H,018H,018H,07eH,018H,018H,000H,000H
	defb 000H,000H,000H,000H,018H,018H,030H,000H
	defb 000H,000H,000H,07eH,000H,000H,000H,000H
	defb 000H,000H,000H,000H,000H,018H,018H,000H
	defb 000H,003H,006H,00cH,018H,030H,060H,000H
	defb 03eH,063H,067H,06bH,073H,063H,03eH,000H
	defb 018H,078H,018H,018H,018H,018H,07eH,000H
	defb 03eH,063H,007H,01eH,03cH,070H,07fH,000H
	defb 03eH,063H,003H,01eH,003H,063H,03eH,000H
	defb 006H,00eH,01eH,036H,066H,07fH,006H,000H
	defb 07fH,060H,07eH,003H,003H,063H,03eH,000H
	defb 01eH,030H,060H,07eH,063H,063H,03eH,000H
	defb 07fH,063H,006H,00cH,018H,018H,018H,000H
	defb 03eH,063H,063H,03eH,063H,063H,03eH,000H
	defb 03eH,063H,063H,03fH,003H,063H,03eH,000H
	defb 000H,000H,018H,000H,000H,018H,000H,000H
	defb 000H,000H,018H,000H,000H,018H,030H,000H
	defb 00cH,018H,030H,060H,030H,018H,00cH,000H
	defb 000H,000H,07eH,000H,07eH,000H,000H,000H
	defb 030H,018H,00cH,006H,00cH,018H,030H,000H
	defb 03eH,063H,003H,00eH,018H,000H,018H,000H
	defb 01eH,021H,04dH,055H,04eH,020H,01eH,000H
	defb 01cH,036H,063H,063H,07fH,063H,063H,000H
	defb 07eH,063H,063H,07eH,063H,063H,07eH,000H
	defb 01eH,033H,060H,060H,060H,033H,01eH,000H
	defb 07cH,066H,063H,063H,063H,066H,07cH,000H
	defb 07eH,060H,060H,07eH,060H,060H,07eH,000H
	defb 07eH,060H,060H,07eH,060H,060H,060H,000H
	defb 01eH,033H,060H,06fH,063H,033H,01fH,000H
	defb 063H,063H,063H,07fH,063H,063H,063H,000H
	defb 07eH,018H,018H,018H,018H,018H,07eH,000H
	defb 006H,006H,006H,006H,006H,066H,03cH,000H
	defb 063H,066H,06cH,078H,06cH,066H,063H,000H
	defb 060H,060H,060H,060H,060H,060H,07eH,000H
	defb 07eH,06bH,06bH,06bH,06bH,06bH,06bH,000H
	defb 063H,073H,07bH,07fH,06fH,067H,063H,000H
	defb 03eH,063H,063H,063H,063H,063H,03eH,000H
	defb 07eH,063H,063H,063H,07eH,060H,060H,000H
	defb 03eH,063H,063H,063H,06bH,066H,03bH,000H
	defb 07eH,063H,063H,067H,07cH,06eH,067H,000H
	defb 03eH,063H,060H,03eH,003H,063H,03eH,000H
	defb 07eH,018H,018H,018H,018H,018H,018H,000H
	defb 063H,063H,063H,063H,063H,063H,03eH,000H
	defb 063H,063H,063H,036H,036H,01cH,01cH,000H
	defb 063H,06bH,06bH,06bH,06bH,06bH,07eH,000H
	defb 063H,063H,036H,01cH,036H,063H,063H,000H
	defb 066H,066H,066H,03cH,018H,018H,018H,000H
	defb 07fH,006H,00cH,018H,030H,060H,07fH,000H
	defb 03cH,020H,020H,020H,020H,020H,03cH,000H
	defb 022H,022H,014H,03eH,008H,03eH,008H,000H
	defb 03cH,004H,004H,004H,004H,004H,03cH,000H
	defb 008H,014H,022H,000H,000H,000H,000H,000H
	defb 000H,000H,000H,000H,000H,000H,07eH,000H


SpritePatterns:
    public SpritePatterns
;	Sprite
	defb	0fh, 1fh, 3fh, 3fh, 2bh, 2bh, 3fh, 00h
	defb	3fh, 3fh, 3fh, 3fh, 3fh, 1ch, 38h, 70h
	defb	0c0h, 0e0h, 0f0h, 0f0h, 0f0h, 0f0h, 0f0h, 00h
	defb	0f0h, 0d8h, 0b0h, 0b0h, 0c0h, 0e0h, 70h, 38h
	defb	0fh, 1fh, 3fh, 3fh, 2bh, 2bh, 3fh, 00h
	defb	3fh, 3fh, 0bfh, 0bfh, 3fh, 19h, 0dh, 03h
	defb	0c0h, 0e0h, 0f0h, 0f0h, 0f0h, 0f0h, 0f0h, 00h
	defb	0f0h, 0f8h, 0ech, 0ech, 0e0h, 0e0h, 0c0h, 80h
	defb	03h, 07h, 0fh, 0fh, 0fh, 0fh, 0fh, 00h
	defb	0fh, 1bh, 0dh, 0dh, 03h, 07h, 0eh, 1ch
	defb	0f0h, 0f8h, 0fch, 0fch, 0d4h, 0d4h, 0fch, 00h
	defb	0fch, 0fch, 0fch, 0fch, 0fch, 38h, 1ch, 0eh
	defb	03h, 07h, 0fh, 0fh, 0fh, 0fh, 0fh, 00h
	defb	0fh, 1fh, 37h, 37h, 07h, 07h, 03h, 01h
	defb	0f0h, 0f8h, 0fch, 0fch, 0d4h, 0d4h, 0fch, 00h
	defb	0fch, 0fch, 0fdh, 0fdh, 0fch, 98h, 0b0h, 0c0h
	defb	07h, 0fh, 1fh, 1fh, 1fh, 1fh, 1fh, 00h
	defb	1fh, 5fh, 5fh, 1fh, 1eh, 1eh, 1eh, 1eh
	defb	0e0h, 0f0h, 0f8h, 0f8h, 0f8h, 0f8h, 0f8h, 00h
	defb	0fch, 0f6h, 0f6h, 0f6h, 78h, 78h, 00h, 00h
	defb	07h, 0fh, 1fh, 1fh, 1fh, 1fh, 1fh, 00h
	defb	3fh, 6fh, 6fh, 6fh, 1eh, 1eh, 00h, 00h
	defb	0e0h, 0f0h, 0f8h, 0f8h, 0f8h, 0f8h, 0f8h, 00h
	defb	0f8h, 0fah, 0fah, 0f8h, 78h, 78h, 78h, 78h
	defb	07h, 0fh, 1fh, 1fh, 1dh, 1dh, 1fh, 00h
	defb	1fh, 5fh, 5fh, 1fh, 1eh, 1eh, 1eh, 1eh
	defb	0e0h, 0f0h, 0f8h, 0f8h, 0b8h, 0b8h, 0f8h, 00h
	defb	0fch, 0f6h, 0f6h, 0f6h, 78h, 78h, 00h, 00h
	defb	07h, 0fh, 1fh, 1fh, 1dh, 1dh, 1fh, 00h
	defb	3fh, 6fh, 6fh, 6fh, 1eh, 1eh, 00h, 00h
	defb	0e0h, 0f0h, 0f8h, 0f8h, 0b8h, 0b8h, 0f8h, 00h
	defb	0f8h, 0fah, 0fah, 0f8h, 78h, 78h, 78h, 78h
	defb	04h, 06h, 0fh, 1ah, 1ah, 1fh, 15h, 50h
	defb	6fh, 3fh, 1fh, 0fh, 07h, 03h, 01h, 00h
	defb	80h, 0c0h, 0e0h, 0f0h, 0f0h, 0f0h, 70h, 76h
	defb	0eeh, 0fch, 0f8h, 0f0h, 0e0h, 0e0h, 0f0h, 78h
	defb	00h, 04h, 06h, 0fh, 1ah, 1ah, 1fh, 15h
	defb	10h, 3fh, 7fh, 0dfh, 0fh, 07h, 03h, 01h
	defb	00h, 80h, 0c0h, 0e0h, 0f0h, 0f0h, 0f0h, 70h
	defb	70h, 0f8h, 0fch, 0f6h, 0f0h, 0e0h, 0f6h, 0fch
	defb	01h, 03h, 07h, 0fh, 0fh, 0fh, 0eh, 6eh
	defb	77h, 3fh, 1fh, 0fh, 07h, 07h, 0fh, 1eh
	defb	20h, 60h, 0f0h, 58h, 58h, 0f8h, 0a8h, 0ah
	defb	0f6h, 0fch, 0f8h, 0f0h, 0e0h, 0c0h, 80h, 00h
	defb	00h, 01h, 03h, 07h, 0fh, 0fh, 0fh, 0eh
	defb	0eh, 1fh, 3fh, 6fh, 0fh, 07h, 6fh, 3fh
	defb	00h, 20h, 60h, 0f0h, 58h, 58h, 0f8h, 0a8h
	defb	08h, 0fch, 0feh, 0fbh, 0f0h, 0e0h, 0c0h, 80h
	defb	02h, 06h, 0fh, 1fh, 1fh, 1fh, 1fh, 5fh
	defb	6fh, 3fh, 1fh, 0fh, 0fh, 07h, 03h, 01h
	defb	40h, 60h, 0f0h, 0f8h, 0f8h, 0f8h, 0f8h, 0fah
	defb	0f6h, 0fch, 0f8h, 0f0h, 0f0h, 0e0h, 0c0h, 80h
	defb	00h, 02h, 06h, 0fh, 1fh, 1fh, 1fh, 1fh
	defb	1fh, 0fh, 3fh, 6fh, 0fh, 0fh, 07h, 03h
	defb	00h, 40h, 60h, 0f0h, 0f8h, 0f8h, 0f8h, 0f8h
	defb	0f8h, 0f0h, 0fch, 0f6h, 0f0h, 0f0h, 0e0h, 0c0h
	defb	02h, 06h, 0fh, 1dh, 1dh, 1fh, 1ah, 58h
	defb	6fh, 3fh, 1fh, 0fh, 0fh, 07h, 03h, 01h
	defb	40h, 60h, 0f0h, 0b8h, 0b8h, 0f8h, 58h, 1ah
	defb	0f6h, 0fch, 0f8h, 0f0h, 0f0h, 0e0h, 0c0h, 80h
	defb	00h, 02h, 06h, 0fh, 1dh, 1dh, 1fh, 1ah
	defb	18h, 0fh, 3fh, 6fh, 0fh, 0fh, 07h, 03h
	defb	00h, 40h, 60h, 0f0h, 0b8h, 0b8h, 0f8h, 58h
	defb	18h, 0f0h, 0fch, 0f6h, 0f0h, 0f0h, 0e0h, 0c0h
	defb	00h, 0fh, 1ah, 35h, 2ah, 35h, 2ah, 35h
	defb	2ah, 35h, 2ah, 35h, 2ah, 35h, 1ah, 0fh
	defb	00h, 0e0h, 0b0h, 58h, 0a8h, 58h, 0a8h, 58h
	defb	0a8h, 58h, 0a8h, 58h, 0a8h, 58h, 0b0h, 0e0h

SpriteColors:
	public SpriteColors
	defb	07h, 07h, 07h, 07h, 07h, 07h, 07h, 07h
	defb	0dh, 0dh, 0dh, 0dh, 0dh, 0dh, 0dh, 0dh
	defb	0fh
