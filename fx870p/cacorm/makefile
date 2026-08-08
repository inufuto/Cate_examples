name=cacorm

all: $(name).pbf Clear.bas loader.bas $(name).bas

cseg=1cd0 # MODE110(7376)
dseg=3b00

.c.asm:
	Cate61h.exe $*.c

.asm.obj:
	Asm61h.exe $*.asm

Actor.asm: Actor.c Movable.h Actor.h 
Increaser.asm: Increaser.c Movable.h Increaser.h Sprite.h Movable.h 
Item.asm: Item.c Item.h Stage.h VVram.h Stages.h Vram.h \
	Line.h Sound.h Movable.h Point.h Sprite.h Movable.h \
	Main.h Increaser.h Math.h VVram.h 
Line.asm: Line.c Line.h Stage.h VVram.h Vram.h Movable.h \
	Actor.h Sound.h Sprite.h Movable.h Item.h Monster.h \
	VVram.h 
Main.asm: Main.c Main.h ScanKeys.h Vram.h Sound.h Status.h \
	Movable.h Actor.h Stage.h VVram.h Sprite.h Movable.h \
	Man.h Actor.h Monster.h Item.h Point.h VVram.h 
Man.asm: Man.c Movable.h Actor.h Man.h Actor.h Sprite.h \
	Movable.h Stage.h VVram.h ScanKeys.h Main.h Sound.h \
	Line.h Item.h Vram.h Status.h Increaser.h VVram.h 
Monster.asm: Monster.c Movable.h Actor.h Monster.h Sprite.h Movable.h \
	Stage.h VVram.h Math.h Man.h Actor.h Line.h 
Movable.asm: Movable.c Movable.h Stage.h VVram.h 
Point.asm: Point.c Point.h Main.h Vram.h VVram.h Sprite.h \
	Movable.h 
Stage.asm: Stage.c Stage.h VVram.h Stages.h Main.h Vram.h \
	Movable.h Actor.h Sprite.h Movable.h Status.h Man.h \
	Actor.h Item.h Monster.h Point.h Increaser.h VVram.h \
	Line.h 
Stages.asm: Stages.c Stage.h VVram.h Stages.h 
Status.asm: Status.c Status.h Vram.h Main.h Sprite.h Movable.h \
	Print.h Man.h Actor.h 
Vram.asm: Vram.c Vram.h 
VVram.asm: VVram.c VVram.h Sprite.h Movable.h Vram.h Sound.h \
	Point.h 
Loader.obj: Loader.asm 
Math.obj: Math.asm 
Print.obj: Print.asm 
ScanKeys.obj: ScanKeys.asm 
Sound.obj: Sound.asm 
Sprite.obj: Sprite.asm Vram.inc VVram.inc 
Startup.obj: Startup.asm 
VramA.obj: VramA.asm Vram.inc VVram.inc 
VVramA.obj: VVramA.asm VVram.inc 

objects = Startup.obj \
	Actor.obj Increaser.obj Item.obj Line.obj Main.obj Man.obj \
	Monster.obj Movable.obj Point.obj Stage.obj Stages.obj Status.obj \
	Vram.obj VVram.obj Math.obj Print.obj ScanKeys.obj Sound.obj \
	Sprite.obj VramA.obj VVramA.obj \
	..\..\cate\cate61h.lib

$(name).bin: $(objects) makefile
	LinkLE.exe $(name).bin $(cseg) $(dseg) $(objects)

$(name).pbf: $(objects) makefile
	LinkLE.exe $(name).pbf $(cseg) $(dseg) $(objects)

loader.bin: loader.obj makefile
	LinkLE.exe loader.bin $(dseg) $(dseg) loader.obj

$(name).bas: $(name).bin BinBas.csx loader.bin makefile
	dotnet script BinBas.csx $(name) $(cseg) $(dseg)

Clear.bas: $(name).bin Clear.csx makefile
	dotnet script Clear.csx $(name)

loader.bas: Makeloader.csx $(name).bin loader.bin makefile
	dotnet script Makeloader.csx $(name) $(cseg) $(dseg)
