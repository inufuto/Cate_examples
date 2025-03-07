name=bootskell

all:$(name).dsk

cseg=4000
zseg=00E0 
dseg=1000

.c.asm:
	cate65.exe $*.c

.asm.obj:
	Asm65.exe $*.asm

Block.asm: Block.c Movable.h Block.h Sprite.h Movable.h Stage.h \
	Vram.h Chars.h Man.h Monster.h Point.h Movable.h \
	Math.h Sound.h VVram.h 
Main.asm: Main.c Main.h ScanKeys.h Sprite.h Movable.h Vram.h \
	Sound.h Status.h Stage.h Man.h Block.h Monster.h \
	Math.h Point.h Movable.h VVram.h 
Man.asm: Man.c Movable.h Man.h Sprite.h Movable.h Stage.h \
	ScanKeys.h Block.h Sound.h Main.h Chars.h VVram.h 
Math.asm: Math.c Math.h 
Monster.asm: Monster.c Movable.h Monster.h Sprite.h Movable.h Stage.h \
	Block.h Math.h Man.h Main.h Chars.h 
Movable.asm: Movable.c Movable.h Stage.h Man.h Block.h Monster.h 
Point.asm: Point.c Point.h Movable.h Sprite.h Movable.h Main.h \
	Chars.h 
Print.asm: Print.c Print.h Vram.h 
Sprite.asm: Sprite.c Sprite.h Movable.h Chars.h VVram.h Vram.h 
Stage.asm: Stage.c Stage.h Stages.h Main.h Vram.h Sprite.h \
	Movable.h Chars.h CopyMemory.h Status.h Movable.h Man.h \
	Block.h Monster.h Point.h Movable.h VVram.h 
Stages.asm: Stages.c Stage.h Stages.h 
Status.asm: Status.c Status.h Vram.h Stage.h Main.h Sprite.h \
	Movable.h Print.h Chars.h 
Vram.asm: Vram.c Vram.h VVram.h CopyMemory.h Chars.h 
VVram.asm: VVram.c VVram.h Chars.h Sprite.h Movable.h Vram.h 
Chars.obj: Chars.asm 
CopyMemory.obj: CopyMemory.asm ZeroPage.inc 
Init.obj: Init.asm Apple2.inc 
Loader.obj: Loader.asm BinSize.inc
ScanKeys.obj: ScanKeys.asm apple2.inc ZeroPage.inc 
Sound.obj: Sound.asm Apple2.inc ZeroPage.inc 
VramA.obj: VramA.asm ZeroPage.inc Vram.inc 
VVramA.obj: VVramA.asm ZeroPage.inc 
ZeroPage.obj: ZeroPage.asm 

objects = Main.obj \
	Block.obj Man.obj Math.obj Monster.obj Movable.obj Point.obj \
	Print.obj Sprite.obj Stage.obj Stages.obj Status.obj Vram.obj \
	VVram.obj Chars.obj CopyMemory.obj Init.obj ScanKeys.obj Sound.obj \
	VramA.obj VVramA.obj ZeroPage.obj \
	..\..\cate\cate65.lib

$(name).bin: $(objects)
	LinkLE.exe $(name).bin $(cseg) $(dseg) $(zseg) $(objects)

BinSize.inc: $(name).bin BinSize.csx
	dotnet script BinSize.csx $(name) $(cseg)

Loader.bin: Loader.obj BinSize.inc makefile 
	LinkLE.exe Loader.bin 0800 08f0 00e0 Loader.obj

$(name).dsk: $(name).bin Loader.bin Disk.csx
	dotnet script Disk.csx $(name)
