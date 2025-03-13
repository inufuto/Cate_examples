name=bootskell

all: $(name).gtr

cseg=fffa-ffff,c000
dseg=0200
zseg=0000

.c.asm:
	Cate65.exe -65c02 -v2 $*.c

.asm.obj:
	Asm65.exe -65c02 $*.asm

Block.asm: Block.c Movable.h Block.h Sprite.h Movable.h Stage.h \
	VVram.h Chars.h Man.h Monster.h Point.h Movable.h \
	Math.h Sound.h Vram.h VVram.h 
Main.asm: Main.c Main.h ScanKeys.h Sprite.h Movable.h Vram.h \
	VVram.h Sound.h Status.h Stage.h Man.h Block.h \
	Monster.h Math.h Point.h Movable.h 
Man.asm: Man.c Movable.h Man.h Sprite.h Movable.h Stage.h \
	ScanKeys.h Block.h Sound.h Main.h Chars.h Vram.h \
	VVram.h 
Math.asm: Math.c Math.h 
Monster.asm: Monster.c Movable.h Monster.h Sprite.h Movable.h Stage.h \
	Block.h Math.h Man.h Main.h Chars.h 
Movable.asm: Movable.c Movable.h Stage.h Man.h Block.h Monster.h 
Point.asm: Point.c Point.h Movable.h Sprite.h Movable.h Main.h \
	Chars.h 
Sprite.asm: Sprite.c Sprite.h Movable.h Vram.h VVram.h 
Stage.asm: Stage.c Stage.h Stages.h Main.h Vram.h VVram.h \
	Sprite.h Movable.h Chars.h CopyMemory.h Status.h Movable.h \
	Man.h Block.h Monster.h Point.h Movable.h VVram.h 
Stages.asm: Stages.c Stage.h Stages.h 
Status.asm: Status.c Status.h Vram.h VVram.h Main.h Sprite.h \
	Movable.h Print.h Chars.h 
Vram.asm: Vram.c Vram.h VVram.h Sprite.h Movable.h 
VVram.asm: VVram.c VVram.h Chars.h 
Chars.obj: Chars.asm 
CopyMemory.obj: CopyMemory.asm ZeroPage.inc 
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
	Block.obj Main.obj Man.obj Math.obj Monster.obj Movable.obj \
	Point.obj Sprite.obj Stage.obj Stages.obj Status.obj Vram.obj \
	VVram.obj Chars.obj CopyMemory.obj Print.obj ScanKeys.obj Sound.obj \
	SubBin.obj VramA.obj VVramA.obj ZeroPage.obj \
	..\..\cate\cate65.lib

$(name).bin: $(objects) makefile
	LinkLE.exe $(name).bin $(cseg) $(dseg) $(zseg) $(objects)

SubBin.bin: SubMain.obj makefile
	LinkLE.exe SubBin.bin 0200 3f00 0010 SubMain.obj

SubBin.asm SubBin.inc: SubBin.bin BinAsm.csx
	dotnet script BinAsm.csx

$(name).gtr: $(name).bin MakeRom.csx
	dotnet script MakeRom.csx $(name)
