name=bootskell

all: $(name).rom

cseg=0400
dseg=3000

.c.asm:
	Cate86.exe $*.c

.asm.obj:
	Asm86.exe $*.asm

Block.asm: Block.c Movable.h Block.h Sprite.h Movable.h Stage.h \
	VVram.h Chars.h Man.h Monster.h Point.h Movable.h \
	Math.h Sound.h Vram.h 
Main.asm: Main.c Main.h ScanKeys.h Sprite.h Movable.h Vram.h \
	Sound.h Status.h Stage.h Man.h Block.h Monster.h \
	Math.h Point.h Movable.h 
Man.asm: Man.c Movable.h Man.h Sprite.h Movable.h Stage.h \
	ScanKeys.h Block.h Sound.h Main.h Chars.h Vram.h 
Math.asm: Math.c Math.h 
Monster.asm: Monster.c Movable.h Monster.h Sprite.h Movable.h Stage.h \
	Block.h Math.h Man.h Main.h Chars.h 
Movable.asm: Movable.c Movable.h Stage.h Man.h Block.h Monster.h 
Point.asm: Point.c Point.h Movable.h Sprite.h Movable.h Main.h \
	Chars.h 
Sprite.asm: Sprite.c Movable.h Sprite.h Movable.h Vram.h 
Stage.asm: Stage.c Stage.h Stages.h Main.h Vram.h Sprite.h \
	Movable.h Chars.h CopyMemory.h Status.h Movable.h Man.h \
	Block.h Monster.h Point.h Movable.h VVram.h 
Stages.asm: Stages.c Stage.h Stages.h 
Status.asm: Status.c Status.h Vram.h Stage.h Main.h Sprite.h \
	Movable.h Print.h Chars.h 
Vram.asm: Vram.c Vram.h Chars.h Movable.h Sprite.h Movable.h \
	Sound.h 
VVram.asm: VVram.c VVram.h Chars.h 
Chars.obj: Chars.asm 
CopyMemory.obj: CopyMemory.asm 
Loader.obj: Loader.asm Pasogo.inc BinSize.inc
Print.obj: Print.asm 
Reset.obj: Reset.asm 
ScanKeys.obj: ScanKeys.asm Pasogo.inc 
Sound.obj: Sound.asm Pasogo.inc 
Startup.obj: Startup.asm Pasogo.inc 
VramA.obj: VramA.asm Pasogo.inc Vram.inc VVram.inc Chars.inc 
VVramA.obj: VVramA.asm VVram.inc 

objects = Startup.obj \
	Block.obj Main.obj Man.obj Math.obj Monster.obj Movable.obj \
	Point.obj Sprite.obj Stage.obj Stages.obj Status.obj Vram.obj \
	VVram.obj Chars.obj CopyMemory.obj Print.obj ScanKeys.obj Sound.obj \
	VramA.obj VVramA.obj \
	..\..\cate\cate86.lib

$(name).bin: $(objects) makefile
	LinkLE.exe $(name).bin $(cseg) $(dseg) $(objects)

BinSize.inc: $(name).bin BinSize.csx makefile
	dotnet script BinSize.csx $(name)

Reset.bin: Reset.obj makefile
	LinkLE.exe Reset.bin fff0 0000 Reset.obj

Loader.bin: Loader.obj makefile
	LinkLE.exe Loader.bin 0000 0000 Loader.obj

$(name).rom: $(name).bin  Loader.bin Reset.bin MakeRom.csx
	dotnet script MakeRom.csx $(name)
