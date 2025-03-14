name=cavit

all: $(name).gtr

cseg=fffa-ffff,c000
dseg=0200
zseg=0000

.c.asm:
	Cate65.exe -65c02 -v2 $*.c

.asm.obj:
	Asm65.exe -65c02 $*.asm

Box.asm: Box.c Box.h Fixed.h Stage.h Stages.h Chars.h \
	Sprite.h Point.h Movable.h Man.h Movable.h Sound.h 
Chaser.asm: Chaser.c Chaser.h Monster.h Movable.h Sprite.h Stage.h \
	Man.h Movable.h Direction.h Chars.h 
Direction.asm: Direction.c Direction.h 
Fixed.asm: Fixed.c Fixed.h 
Ghost.asm: Ghost.c Ghost.h Monster.h Movable.h Sprite.h Stage.h \
	Man.h Movable.h Direction.h Main.h Chars.h 
Main.asm: Main.c Main.h ScanKeys.h Sprite.h Vram.h VVram.h \
	Sound.h Status.h Stage.h Man.h Movable.h Chaser.h \
	Monster.h Movable.h Ghost.h Monster.h Movable.h Rock.h \
	Fixed.h Movable.h Point.h Movable.h Box.h Fixed.h 
Man.asm: Man.c Man.h Movable.h Movable.h Sprite.h Stage.h \
	ScanKeys.h Direction.h Chars.h Vram.h VVram.h Rock.h \
	Fixed.h Movable.h Sound.h 
Monster.asm: Monster.c Monster.h Movable.h Stage.h Rock.h Fixed.h \
	Movable.h Sprite.h Chaser.h Monster.h Movable.h Ghost.h \
	Monster.h Movable.h Man.h Movable.h 
Movable.asm: Movable.c Movable.h Sprite.h Stage.h Direction.h 
Point.asm: Point.c Point.h Movable.h Sprite.h Main.h Chars.h 
Rock.asm: Rock.c Rock.h Fixed.h Movable.h Stage.h Stages.h \
	Vram.h VVram.h Chars.h Sprite.h Direction.h Man.h \
	Movable.h Point.h Movable.h Chaser.h Monster.h Movable.h \
	Ghost.h Monster.h Movable.h Sound.h 
Sprite.asm: Sprite.c Sprite.h Vram.h VVram.h 
Stage.asm: Stage.c Stage.h Stages.h Main.h Status.h VVram.h \
	Sprite.h Chars.h Man.h Movable.h Box.h Fixed.h \
	Rock.h Fixed.h Movable.h Chaser.h Monster.h Movable.h \
	Ghost.h Monster.h Movable.h Direction.h Point.h Movable.h \
	Vram.h VVram.h 
Stages.asm: Stages.c Stages.h 
Status.asm: Status.c Status.h Vram.h VVram.h Main.h Sprite.h \
	Print.h Chars.h 
Vram.asm: Vram.c Vram.h VVram.h Sprite.h 
VVram.asm: VVram.c VVram.h Chars.h 
Chars.obj: Chars.asm 
Print.obj: Print.asm 
ScanKeys.obj: ScanKeys.asm gametank.inc 
Sound.obj: Sound.asm ZeroPage.inc gametank.inc SubBin.inc 
Startup.obj: Startup.asm ZeroPage.inc gametank.inc 
SubBin.obj: SubBin.asm 
SubMain.obj: SubMain.asm 
Vectors.obj: Vectors.asm 
VramA.obj: VramA.asm ZeroPage.inc gametank.inc Vram.inc VVram.inc Chars.inc 
VVramA.obj: VVramA.asm ZeroPage.inc VVram.inc 
ZeroPage.obj: ZeroPage.asm 

objects = Vectors.obj Startup.obj \
	Box.obj Chaser.obj Direction.obj Fixed.obj Ghost.obj Main.obj \
	Man.obj Monster.obj Movable.obj Point.obj Rock.obj Sprite.obj \
	Stage.obj Stages.obj Status.obj Vram.obj VVram.obj Chars.obj \
	Print.obj ScanKeys.obj Sound.obj SubBin.obj VramA.obj VVramA.obj \
	ZeroPage.obj \
	..\..\cate\cate65.lib

$(name).bin: $(objects) makefile
	LinkLE.exe $(name).bin $(cseg) $(dseg) $(zseg) $(objects)

SubBin.bin: SubMain.obj makefile
	LinkLE.exe SubBin.bin 0200 3f00 0010 SubMain.obj

SubBin.asm SubBin.inc: SubBin.bin BinAsm.csx
	dotnet script BinAsm.csx

$(name).gtr: $(name).bin MakeRom.csx
	dotnet script MakeRom.csx $(name)
