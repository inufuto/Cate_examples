name=mieyen

all: $(name).d88

cseg=4000
zseg=6800 
dseg=6900

.c.asm:
	Cate09.exe $*.c

.asm.obj:
	Asm09.exe $*.asm

Fire.asm: Fire.c Fire.h Movable.h Sprite.h Movable.h Sound.h \
	Chars.h Man.h Movable.h Monster.h Movable.h Point.h \
	Movable.h 
Main.asm: Main.c Main.h Status.h ScanKeys.h Stage.h Sprite.h \
	Movable.h Sound.h Man.h Movable.h Monster.h Movable.h \
	Fire.h Movable.h Point.h Movable.h VVram.h 
Man.asm: Man.c Man.h Movable.h Sprite.h Movable.h Chars.h \
	Stage.h ScanKeys.h Sound.h Fire.h Movable.h Main.h \
	VVram.h 
Monster.asm: Monster.c Monster.h Movable.h Stage.h Stages.h Stage.h \
	Sprite.h Movable.h Chars.h Math.h Status.h Main.h \
	Sound.h Man.h Movable.h 
Movable.asm: Movable.c Movable.h Stage.h Sprite.h Movable.h 
Point.asm: Point.c Point.h Movable.h Sprite.h Movable.h Main.h \
	Chars.h 
Sprite.asm: Sprite.c Movable.h Sprite.h Movable.h Vram.h 
Stage.asm: Stage.c Stage.h Stages.h Stage.h Main.h Math.h \
	Sprite.h Movable.h Status.h Chars.h VVram.h CopyMemory.h \
	Man.h Movable.h Monster.h Movable.h Fire.h Movable.h \
	Point.h Movable.h Vram.h 
Stages.asm: Stages.c Stage.h Stages.h Stage.h 
Status.asm: Status.c Status.h Vram.h Stage.h Main.h Sprite.h \
	Movable.h Print.h Chars.h 
Vram.asm: Vram.c Vram.h Chars.h 
VVram.asm: VVram.c VVram.h Sprite.h Movable.h Vram.h Chars.h 
Chars.obj: Chars.asm 
CopyMemory.obj: CopyMemory.asm 
Loader.obj: Loader.asm S1.inc BinSize.inc
Math.obj: Math.asm 
Print.obj: Print.asm 
ScanKeys.obj: ScanKeys.asm S1.inc 
Sound.obj: Sound.asm 
StageA.obj: StageA.asm 
Startup.obj: Startup.asm S1.inc 
VramA.obj: VramA.asm S1.inc Vram.inc VVram.inc Chars.inc 
VVramA.obj: VVramA.asm VVram.inc 

objects = Startup.obj \
	Fire.obj Main.obj Man.obj Monster.obj Movable.obj Point.obj \
	Sprite.obj Stage.obj Stages.obj Status.obj Vram.obj VVram.obj \
	Chars.obj CopyMemory.obj Math.obj Print.obj ScanKeys.obj Sound.obj \
	StageA.obj VramA.obj VVramA.obj \
	..\..\cate\cate09.lib

$(name).bin: $(objects) makefile
	LinkBE.exe $(name).bin $(cseg) $(dseg) $(zseg) $(objects)

BinSize.inc: $(name).bin BinSize.csx
	dotnet script BinSize.csx $(name) $(cseg)

Loader.bin: Loader.obj makefile BinSize.inc
	LinkBE.exe Loader.bin 2000 2300 2200 Loader.obj

$(name).d88: Loader.bin $(name).bin disk.csx
	dotnet script disk.csx $(name)
