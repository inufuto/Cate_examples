name=cacorm

all: $(name).d88

cseg=4000
zseg=6900 
dseg=6a00

.c.asm:
	Cate09.exe $*.c

.asm.obj:
	Asm09.exe $*.asm

Actor.asm: Actor.c Movable.h Actor.h 
Increaser.asm: Increaser.c Movable.h Increaser.h Sprite.h Chars.h 
Item.asm: Item.c Item.h Stage.h Stages.h Vram.h Chars.h \
	Line.h Sound.h Movable.h Point.h Sprite.h Main.h \
	Increaser.h Math.h VVram.h 
Line.asm: Line.c Line.h Chars.h Stage.h Vram.h Movable.h \
	Actor.h Sound.h Sprite.h Item.h Monster.h VVram.h 
Main.asm: Main.c Main.h ScanKeys.h Vram.h Sound.h Status.h \
	Movable.h Actor.h Stage.h Sprite.h Man.h Monster.h \
	Item.h Point.h 
Man.asm: Man.c Movable.h Actor.h Man.h Sprite.h Stage.h \
	ScanKeys.h Main.h Sound.h Chars.h Line.h Item.h \
	Vram.h Status.h Increaser.h 
Monster.asm: Monster.c Movable.h Actor.h Monster.h Sprite.h Stage.h \
	Chars.h Math.h Man.h Line.h 
Movable.asm: Movable.c Movable.h Stage.h 
Point.asm: Point.c Movable.h Point.h Sprite.h Main.h Chars.h 
Sprite.asm: Sprite.c Movable.h Sprite.h Vram.h VVram.h 
Stage.asm: Stage.c Stage.h Stages.h Main.h Vram.h Movable.h \
	Actor.h Sprite.h Chars.h Status.h Man.h Item.h \
	Monster.h Point.h Increaser.h VVram.h 
Stages.asm: Stages.c Stage.h Stages.h 
Status.asm: Status.c Status.h Vram.h Stage.h Main.h Movable.h \
	Actor.h Sprite.h Print.h Chars.h 
Vram.asm: Vram.c Vram.h Chars.h Movable.h Sprite.h 
VVram.asm: VVram.c VVram.h Chars.h 
Chars.obj: Chars.asm 
Loader.obj: Loader.asm S1.inc BinSize.inc 
Math.obj: Math.asm 
Print.obj: Print.asm 
ScanKeys.obj: ScanKeys.asm S1.inc 
Sound.obj: Sound.asm 
Startup.obj: Startup.asm S1.inc 
VramA.obj: VramA.asm S1.inc Vram.inc VVram.inc Chars.inc 
VVramA.obj: VVramA.asm VVram.inc 

objects = Startup.obj \
	Actor.obj Increaser.obj Item.obj Line.obj Main.obj Man.obj \
	Monster.obj Movable.obj Point.obj Sprite.obj Stage.obj Stages.obj \
	Status.obj Vram.obj VVram.obj Chars.obj Math.obj Print.obj \
	ScanKeys.obj Sound.obj VramA.obj VVramA.obj \
	..\..\cate\cate09.lib

$(name).bin: $(objects) makefile
	LinkBE.exe $(name).bin $(cseg) $(dseg) $(zseg) $(objects)

BinSize.inc: $(name).bin BinSize.csx
	dotnet script BinSize.csx $(name) $(cseg)

Loader.bin: Loader.obj makefile BinSize.inc
	LinkBE.exe Loader.bin 2000 2300 2200 Loader.obj

$(name).d88: Loader.bin $(name).bin disk.csx
	dotnet script disk.csx $(name)
