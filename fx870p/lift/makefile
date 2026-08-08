name=lift

all: $(name).pbf Clear.bas loader.bas $(name)1.bas

cseg=1cd0 # MODE110(7376)
dseg=3910

.c.asm:
	Cate61h.exe $*.c

.asm.obj:
	Asm61h.exe $*.asm

Actor.asm: Actor.c Movable.h Actor.h Stage.h Lift.h 
Item.asm: Item.c Item.h Stage.h Stages.h Vram.h Main.h \
	Movable.h Actor.h Man.h Actor.h Point.h Sound.h \
	Sprite.h Movable.h VVram.h 
Lift.asm: Lift.c Movable.h Actor.h Lift.h Stage.h Stages.h \
	Vram.h Sprite.h Movable.h Man.h Actor.h Monster.h 
Main.asm: Main.c Main.h ScanKeys.h Movable.h Sprite.h Movable.h \
	Vram.h Sound.h Status.h Stage.h Actor.h Monster.h \
	Lift.h Man.h Actor.h Item.h Point.h 
Man.asm: Man.c Movable.h Actor.h Man.h Actor.h Stage.h \
	Sprite.h Movable.h ScanKeys.h Item.h Sound.h VVram.h 
Monster.asm: Monster.c Movable.h Actor.h Monster.h Stages.h Stage.h \
	Sprite.h Movable.h Man.h Actor.h Lift.h 
Movable.asm: Movable.c Movable.h Stage.h Actor.h Lift.h 
Point.asm: Point.c Point.h Main.h Vram.h VVram.h Sprite.h \
	Movable.h 
Stage.asm: Stage.c Stage.h Stages.h Main.h Vram.h Movable.h \
	Sprite.h Movable.h Status.h Item.h Actor.h Man.h \
	Actor.h Lift.h Monster.h Point.h VVram.h 
Stages.asm: Stages.c Stage.h Stages.h 
Status.asm: Status.c Status.h Vram.h Main.h Sprite.h Movable.h \
	Print.h Man.h Actor.h 
Vram.asm: Vram.c Vram.h 
VVram.asm: VVram.c VVram.h Sound.h Sprite.h Movable.h Vram.h \
	Point.h 
Loader.obj: Loader.asm 
Print.obj: Print.asm 
ScanKeys.obj: ScanKeys.asm 
Sound.obj: Sound.asm 
Sprite.obj: Sprite.asm Vram.inc VVram.inc 
StageA.obj: StageA.asm VVram.inc 
Startup.obj: Startup.asm 
VramA.obj: VramA.asm Vram.inc VVram.inc 
VVramA.obj: VVramA.asm VVram.inc 

objects = Startup.obj \
	Actor.obj Item.obj Lift.obj Main.obj Man.obj Monster.obj \
	Movable.obj Point.obj Stage.obj Stages.obj Status.obj Vram.obj \
	VVram.obj Print.obj ScanKeys.obj Sound.obj Sprite.obj StageA.obj \
	VramA.obj VVramA.obj \
	..\..\cate\cate61h.lib

$(name).bin: $(objects) makefile
	LinkLE.exe $(name).bin $(cseg) $(dseg) $(objects)

$(name).pbf: $(objects) makefile
	LinkLE.exe $(name).pbf $(cseg) $(dseg) $(objects)

loader.bin: loader.obj makefile
	LinkLE.exe loader.bin $(dseg) $(dseg) loader.obj

$(name)1.bas: $(name).bin BinBas.csx loader.bin makefile
	dotnet script BinBas.csx $(name) $(cseg) $(dseg)

Clear.bas: $(name).bin Clear.csx makefile
	dotnet script Clear.csx $(name)

loader.bas: Makeloader.csx $(name).bin loader.bin makefile
	dotnet script Makeloader.csx $(name) $(cseg) $(dseg)
