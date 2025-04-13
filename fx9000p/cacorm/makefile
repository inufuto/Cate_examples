name=cacorm

all: $(name).rom debug.bin

cseg=9000
dseg=b800

.c.asm:
	Cate80.exe $*.c

.asm.obj:
	Asm80.exe $*.asm

Actor.asm: Actor.c Movable.h Actor.h 
Increaser.asm: Increaser.c Movable.h Increaser.h Sprite.h Movable.h Chars.h 
Item.asm: Item.c Item.h Stage.h VVram.h Stages.h Vram.h \
	Chars.h Line.h Movable.h Point.h Sprite.h Movable.h \
	Main.h Increaser.h Math.h VVram.h 
Line.asm: Line.c Line.h Chars.h Stage.h VVram.h Vram.h \
	Movable.h Actor.h Sprite.h Movable.h Item.h Monster.h \
	VVram.h 
Main.asm: Main.c Main.h ScanKeys.h Vram.h Status.h Movable.h \
	Actor.h Stage.h VVram.h Sprite.h Movable.h Man.h \
	Monster.h Item.h Point.h VVram.h 
Man.asm: Man.c Movable.h Actor.h Man.h Sprite.h Movable.h \
	Stage.h VVram.h ScanKeys.h Main.h Chars.h Line.h \
	Item.h Vram.h Status.h Increaser.h VVram.h 
Monster.asm: Monster.c Movable.h Actor.h Monster.h Sprite.h Movable.h \
	Stage.h VVram.h Chars.h Math.h Man.h Line.h 
Movable.asm: Movable.c Movable.h Stage.h VVram.h 
Point.asm: Point.c Movable.h Point.h Sprite.h Movable.h Main.h \
	Chars.h 
Sprite.asm: Sprite.c Sprite.h Movable.h Chars.h VVram.h Vram.h 
Stage.asm: Stage.c Stage.h VVram.h Stages.h Main.h Vram.h \
	Movable.h Actor.h Sprite.h Movable.h Chars.h Status.h \
	Man.h Item.h Monster.h Point.h Increaser.h VVram.h \
	Line.h 
Stages.asm: Stages.c Stage.h VVram.h Stages.h 
Status.asm: Status.c Status.h Vram.h Stage.h VVram.h Main.h \
	Sprite.h Movable.h Print.h Chars.h 
Vram.asm: Vram.c Vram.h Chars.h 
VVram.asm: VVram.c VVram.h Chars.h Sprite.h Movable.h Vram.h 
Chars.obj: Chars.asm 
Loader.obj: Loader.asm BinSize.inc
Math.obj: Math.asm 
Print.obj: Print.asm 
ScanKeys.obj: ScanKeys.asm 
Startup.obj: Startup.asm Vram.inc 
VramA.obj: VramA.asm Vram.inc VVram.inc 
VVramA.obj: VVramA.asm VVram.inc Chars.inc 

objects = Startup.obj \
	Actor.obj Increaser.obj Item.obj Line.obj Main.obj Man.obj \
	Monster.obj Movable.obj Point.obj Sprite.obj Stage.obj Stages.obj \
	Status.obj Vram.obj VVram.obj Chars.obj Math.obj Print.obj \
	ScanKeys.obj VramA.obj VVramA.obj \
	..\..\cate\cate80.lib

$(name).bin: $(objects) makefile
	LinkLE.exe $(name).bin $(cseg) $(dseg) $(objects)

BinSize.inc: $(name).bin BinSize.csx
	dotnet script BinSize.csx $(name) $(cseg)

Loader.bin: Loader.obj makefile
	LinkLE.exe Loader.bin 4000 $(dseg) Loader.obj

$(name).rom: $(name).bin Loader.bin MakeRom.csx
	dotnet script MakeRom.csx $(name)

debug.bin: $(name).bin
	copy $(name).bin debug.bin /y
