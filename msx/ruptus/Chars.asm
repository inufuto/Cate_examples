﻿cseg

FortPattern: public FortPattern
	defb	00h, 00h, 00h, 07h, 03h, 10h, 1bh, 1bh
	defb	00h, 00h, 00h, 0efh, 0e0h, 0fh, 00h, 37h
	defb	0fh, 1fh, 3fh, 0bfh, 1fh, 0afh, 00h, 0ffh
	defb	00h, 80h, 0c0h, 0dfh, 80h, 5fh, 00h, 0feh
	defb	00h, 00h, 00h, 7eh, 7ch, 00h, 0dh, 0cdh
	defb	00h, 00h, 00h, 00h, 00h, 80h, 80h, 80h
	
	defb	18h, 19h, 00h, 0fh, 00h, 19h, 3dh, 3dh
	defb	78h, 79h, 35h, 40h, 0eh, 0ceh, 0ceh, 0ceh
	defb	00h, 99h, 0bfh, 7fh, 0ffh, 0ffh, 7fh, 0bfh
	defb	01h, 99h, 0dah, 0e0h, 0f7h, 0f7h, 0e7h, 0d7h
	defb	0e1h, 0e9h, 0c0h, 2fh, 00h, 39h, 3bh, 3bh
	defb	80h, 80h, 00h, 00h, 00h, 80h, 0c0h, 0c0h
	
	defb	18h, 01h, 0fdh, 0fdh, 00h, 0b5h, 0b5h, 00h
	defb	00h, 0d0h, 0c3h, 0c3h, 00h, 77h, 77h, 00h
	defb	19h, 00h, 0ffh, 0ffh, 00h, 0bfh, 0bfh, 00h
	defb	80h, 00h, 0fch, 0fch, 00h, 0deh, 0deh, 00h
	defb	01h, 0b8h, 3bh, 3bh, 00h, 0eah, 0eah, 00h
	defb	80h, 00h, 0f0h, 0f0h, 00h, 0d0h, 0d0h, 00h
	
	defb	0fdh, 0fdh, 01h, 18h, 3dh, 3dh, 19h, 00h
	defb	0c3h, 0c3h, 0d0h, 00h, 0ceh, 0ceh, 0ceh, 0eh
	defb	0ffh, 0ffh, 00h, 19h, 0bfh, 7fh, 0ffh, 0ffh
	defb	0fch, 0fch, 00h, 80h, 0d7h, 0e7h, 0f7h, 0f7h
	defb	3bh, 3bh, 0b8h, 01h, 3bh, 3bh, 39h, 00h
	defb	0f0h, 0f0h, 00h, 80h, 0c0h, 0c0h, 80h, 00h
	
	defb	0fh, 00h, 19h, 18h, 1bh, 1bh, 10h, 03h
	defb	40h, 35h, 79h, 78h, 37h, 00h, 0fh, 0e0h
	defb	7fh, 0bfh, 99h, 00h, 0ffh, 00h, 0afh, 1fh
	defb	0e0h, 0dah, 99h, 01h, 0feh, 00h, 5fh, 80h
	defb	2fh, 0c0h, 0e9h, 0e1h, 0cdh, 0dh, 00h, 7ch
	defb	00h, 00h, 80h, 80h, 80h, 80h, 80h, 00h
	
	defb	07h, 00h, 00h, 00h, 00h, 00h, 00h, 00h
	defb	0efh, 00h, 00h, 00h, 00h, 00h, 00h, 00h
	defb	0bfh, 3fh, 1fh, 0fh, 00h, 00h, 00h, 00h
	defb	0dfh, 0c0h, 80h, 00h, 00h, 00h, 00h, 00h
	defb	7eh, 00h, 00h, 00h, 00h, 00h, 00h, 00h
	defb	00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h

BarrierPattern: public BarrierPattern
	defb	0ffh, 00h, 00h, 00h, 00h, 00h, 00h, 00h
	defb	00h, 00h, 00h, 00h, 0ffh, 00h, 00h, 00h
	defb	80h, 80h, 80h, 80h, 80h, 80h, 80h, 80h
	defb	08h, 08h, 08h, 08h, 08h, 08h, 08h, 08h

FighterPattern: public FighterPattern
	defb	10h, 10h, 30h, 31h, 73h, 76h, 75h, 0f7h
	defb	10h, 10h, 18h, 18h, 9ch, 0dch, 5ch, 0deh
	defb	0f7h, 0f7h, 0f7h, 77h, 33h, 10h, 00h, 00h
	defb	0deh, 0deh, 0deh, 0dch, 98h, 10h, 00h, 00h

MapPattern: public MapPattern
	defb	00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h
	defb	00h, 00h, 3ch, 3ch, 3ch, 3ch, 00h, 00h

LogoPattern: public LogoPattern
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

AsciiPattern: public AsciiPattern
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

SpritePattern: public SpritePattern
	defb	10h, 10h, 30h, 31h, 73h, 76h, 75h, 0f7h
	defb	0f7h, 0f7h, 0f7h, 77h, 33h, 10h, 00h, 00h
	defb	10h, 10h, 18h, 18h, 9ch, 0dch, 5ch, 0deh
	defb	0deh, 0deh, 0deh, 0dch, 98h, 10h, 00h, 00h
	defb	03h, 0fh, 3fh, 7eh, 0fdh, 0fah, 0f7h, 0efh
	defb	0dfh, 1fh, 0fh, 06h, 01h, 03h, 03h, 00h
	defb	0c0h, 80h, 00h, 00h, 0e0h, 22h, 0a6h, 0aeh
	defb	0deh, 0bch, 7ch, 0f8h, 0f8h, 0f0h, 0e0h, 00h
	defb	0fh, 1fh, 3fh, 7fh, 00h, 1fh, 3fh, 3fh
	defb	3fh, 1fh, 00h, 7fh, 3fh, 1fh, 0fh, 00h
	defb	00h, 0e0h, 0f8h, 0feh, 00h, 0c0h, 60h, 0b0h
	defb	60h, 0c0h, 00h, 0feh, 0f8h, 0e0h, 00h, 00h
	defb	03h, 03h, 01h, 06h, 0fh, 1fh, 0dfh, 0efh
	defb	0f7h, 0fah, 0fdh, 7eh, 3fh, 0fh, 03h, 00h
	defb	0e0h, 0f0h, 0f8h, 0f8h, 7ch, 0bch, 0deh, 0aeh
	defb	0a6h, 22h, 0e0h, 00h, 00h, 80h, 0c0h, 00h
	defb	00h, 10h, 33h, 77h, 0f7h, 0f7h, 0f7h, 0f7h
	defb	75h, 76h, 73h, 31h, 30h, 10h, 10h, 00h
	defb	00h, 10h, 98h, 0dch, 0deh, 0deh, 0deh, 0deh
	defb	5ch, 0dch, 9ch, 18h, 18h, 10h, 10h, 00h
	defb	0fh, 1fh, 3fh, 3eh, 7dh, 7bh, 0f7h, 0ebh
	defb	0cbh, 88h, 0fh, 00h, 01h, 03h, 07h, 00h
	defb	80h, 80h, 00h, 0c0h, 0e0h, 0f0h, 0f6h, 0eeh
	defb	0deh, 0beh, 7eh, 0fch, 0f8h, 0e0h, 80h, 00h
	defb	01h, 0fh, 3fh, 0ffh, 00h, 07h, 0dh, 1bh
	defb	0dh, 07h, 00h, 0ffh, 3fh, 0fh, 01h, 00h
	defb	0e0h, 0f0h, 0f8h, 0fch, 00h, 0f0h, 0f8h, 0f8h
	defb	0f8h, 0f0h, 00h, 0fch, 0f8h, 0f0h, 0e0h, 00h
	defb	07h, 03h, 01h, 00h, 0fh, 88h, 0cbh, 0ebh
	defb	0f7h, 7bh, 7dh, 3eh, 3fh, 1fh, 0fh, 00h
	defb	80h, 0e0h, 0f8h, 0fch, 7eh, 0beh, 0deh, 0eeh
	defb	0f6h, 0f0h, 0e0h, 0c0h, 00h, 80h, 80h, 00h
	defb	00h, 03h, 07h, 0ch, 0bh, 2fh, 6fh, 0efh
	defb	0efh, 0cfh, 8eh, 05h, 01h, 01h, 01h, 00h
	defb	00h, 80h, 0c0h, 60h, 0a0h, 0e8h, 0ech, 0eeh
	defb	0eeh, 0e6h, 0e2h, 40h, 00h, 00h, 00h, 00h
	defb	00h, 00h, 3ch, 79h, 0f3h, 07h, 0fh, 1fh
	defb	1fh, 03h, 0bh, 13h, 00h, 00h, 00h, 00h
	defb	00h, 00h, 0f0h, 18h, 0c8h, 0e8h, 0e8h, 0f0h
	defb	0e0h, 0c8h, 98h, 38h, 38h, 30h, 20h, 00h
	defb	0fh, 07h, 03h, 00h, 0fh, 1fh, 0fh, 0f7h
	defb	0fh, 1fh, 0fh, 00h, 03h, 07h, 0fh, 00h
	defb	00h, 80h, 0c0h, 00h, 0f0h, 0d8h, 0ech, 0ech
	defb	0ech, 0d8h, 0f0h, 00h, 0c0h, 80h, 00h, 00h
	defb	00h, 00h, 00h, 13h, 0bh, 03h, 1fh, 1fh
	defb	0fh, 07h, 0f3h, 79h, 3ch, 00h, 00h, 00h
	defb	20h, 30h, 38h, 38h, 98h, 0c8h, 0e0h, 0f0h
	defb	0e8h, 0e8h, 0c8h, 18h, 0f0h, 00h, 00h, 00h
	defb	01h, 01h, 01h, 05h, 8eh, 0cfh, 0efh, 0efh
	defb	6fh, 2fh, 0bh, 0ch, 07h, 03h, 00h, 00h
	defb	00h, 00h, 00h, 40h, 0e2h, 0e6h, 0eeh, 0eeh
	defb	0ech, 0e8h, 0a0h, 60h, 0c0h, 80h, 00h, 00h
	defb	08h, 18h, 38h, 39h, 33h, 27h, 0fh, 1fh
	defb	2fh, 2fh, 27h, 31h, 1eh, 00h, 00h, 00h
	defb	00h, 00h, 00h, 90h, 0a0h, 80h, 0f0h, 0f0h
	defb	0e0h, 0c0h, 9eh, 3ch, 78h, 00h, 00h, 00h
	defb	01h, 03h, 07h, 00h, 1fh, 37h, 6fh, 6fh
	defb	6fh, 37h, 1fh, 00h, 07h, 03h, 01h, 00h
	defb	0e0h, 0c0h, 80h, 00h, 0e0h, 0f0h, 0e0h, 0deh
	defb	0e0h, 0f0h, 0e0h, 00h, 80h, 0c0h, 0e0h, 00h
	defb	00h, 00h, 1eh, 31h, 27h, 2fh, 2fh, 1fh
	defb	0fh, 27h, 33h, 39h, 38h, 18h, 08h, 00h
	defb	00h, 00h, 78h, 3ch, 9eh, 0c0h, 0e0h, 0f0h
	defb	0f0h, 80h, 0a0h, 90h, 00h, 00h, 00h, 00h
	defb	10h, 10h, 10h, 10h, 10h, 10h, 10h, 10h
	defb	00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h
	defb	00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h
	defb	00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h
	defb	00h, 02h, 04h, 08h, 10h, 20h, 40h, 00h
	defb	00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h
	defb	00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h
	defb	00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h
	defb	00h, 00h, 00h, 0ffh, 00h, 00h, 00h, 00h
	defb	00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h
	defb	00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h
	defb	00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h
	defb	00h, 40h, 20h, 10h, 08h, 04h, 02h, 00h
	defb	00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h
	defb	00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h
	defb	00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h
	defb	00h, 00h, 18h, 3ch, 3ch, 18h, 00h, 00h
	defb	00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h
	defb	00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h
	defb	00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h
	defb	3ch, 7eh, 0e7h, 0dbh, 0dbh, 0e7h, 7eh, 3ch
	defb	00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h
	defb	00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h
	defb	00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h
	defb	01h, 21h, 33h, 3eh, 24h, 0e1h, 77h, 3bh
	defb	1bh, 30h, 0e2h, 6eh, 3eh, 1bh, 11h, 01h
	defb	04h, 9ch, 0f8h, 0f9h, 6fh, 0eh, 9ch, 0b8h
	defb	0dch, 0cfh, 0eh, 48h, 0ech, 0fch, 8ch, 00h
	defb	00h, 00h, 08h, 0eh, 07h, 07h, 06h, 03h
	defb	03h, 1fh, 0f3h, 78h, 3eh, 1fh, 0fh, 06h
	defb	02h, 07h, 07h, 0fh, 9dh, 0fch, 78h, 38h
	defb	12h, 82h, 9fh, 3bh, 79h, 19h, 98h, 30h
	defb	00h, 00h, 01h, 87h, 8fh, 0dfh, 0fdh, 79h
	defb	71h, 25h, 0ch, 9ch, 0f8h, 19h, 11h, 38h
	defb	60h, 0e0h, 0c0h, 0c0h, 0c0h, 80h, 8eh, 0bch
	defb	0f8h, 0f8h, 30h, 0e0h, 0c0h, 0c0h, 0e0h, 0f0h
	defb	04h, 09h, 39h, 73h, 0e0h, 7fh, 3fh, 0eh
	defb	06h, 02h, 03h, 03h, 02h, 00h, 00h, 00h
	defb	64h, 0ceh, 9eh, 0ffh, 7dh, 21h, 6dh, 1ch
	defb	7eh, 0eeh, 0ceh, 07h, 07h, 03h, 02h, 02h
	defb	7fh, 60h, 0f0h, 0f3h, 9bh, 09h, 21h, 38h
	defb	7ch, 0ffh, 0e3h, 0c1h, 80h, 00h, 00h, 00h
	defb	38h, 0ch, 0feh, 0ffh, 0f0h, 80h, 80h, 0c0h
	defb	0c0h, 0c0h, 0e0h, 0e0h, 60h, 00h, 00h, 00h
	defb	0c0h, 0c0h, 00h, 00h, 00h, 00h, 00h, 00h
	defb	00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h
	defb	00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h
	defb	00h, 00h, 00h, 00h, 00h, 00h, 00h, 00h
	defb	00h, 00h, 00h, 3fh, 7fh, 0dbh, 9bh, 0dbh
	defb	0dbh, 0dbh, 8ch, 7fh, 3fh, 00h, 00h, 00h
	defb	00h, 00h, 00h, 0f8h, 0fch, 46h, 5ah, 5ah
	defb	46h, 5eh, 0deh, 0fch, 0f8h, 00h, 00h, 00h
