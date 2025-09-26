name=lift

all: $(name).l3

cseg=4000
zseg=6800 
dseg=6900

.c.asm:
	Cate09.exe $*.c

.asm.obj:
	Asm09.exe -v2 $*.asm

Actor.asm: Actor.c Movable.h Actor.h Stage.h Lift.h 
Item.asm: Item.c Item.h Stage.h Stages.h Vram.h Chars.h \
	Main.h Movable.h Actor.h Man.h Point.h Movable.h \
	Sound.h Sprite.h Movable.h 
Lift.asm: Lift.c Movable.h Actor.h Lift.h Stage.h Stages.h \
	Vram.h Chars.h Sprite.h Movable.h Man.h Monster.h 
Main.asm: Main.c Main.h ScanKeys.h Movable.h Sprite.h Movable.h \
	Vram.h Sound.h Status.h Stage.h Actor.h Monster.h \
	Lift.h Man.h Item.h Point.h Movable.h 
Man.asm: Man.c Movable.h Actor.h Man.h Stage.h Sprite.h \
	Movable.h Chars.h ScanKeys.h Item.h Sound.h Vram.h 
Math.asm: Math.c Math.h 
Monster.asm: Monster.c Movable.h Actor.h Monster.h Stages.h Stage.h \
	Sprite.h Movable.h Chars.h Man.h Lift.h 
Movable.asm: Movable.c Movable.h Stage.h Actor.h Lift.h 
Point.asm: Point.c Point.h Movable.h Sprite.h Movable.h Main.h \
	Chars.h 
Sprite.asm: Sprite.c Movable.h Sprite.h Movable.h Vram.h 
Stage.asm: Stage.c Stage.h Stages.h Main.h Vram.h Movable.h \
	Sprite.h Movable.h Chars.h Status.h Item.h Actor.h \
	Man.h Lift.h Monster.h Point.h Movable.h 
Stages.asm: Stages.c Stage.h Stages.h 
Status.asm: Status.c Status.h Vram.h Stage.h Main.h Movable.h \
	Sprite.h Movable.h Print.h Chars.h 
Vram.asm: Vram.c Vram.h Chars.h Sprite.h Movable.h 
Chars.obj: Chars.asm 
CopyMemory.obj: CopyMemory.asm 
Loader.obj: Loader.asm S1.inc BinSize.inc 
Print.obj: Print.asm 
ScanKeys.obj: ScanKeys.asm S1.inc 
Sound.obj: Sound.asm 
Startup.obj: Startup.asm S1.inc 
VramA.obj: VramA.asm S1.inc Vram.inc Chars.inc 

objects = Startup.obj \
	Actor.obj Item.obj Lift.obj Main.obj Man.obj Math.obj \
	Monster.obj Movable.obj Point.obj Sprite.obj Stage.obj Stages.obj \
	Status.obj Vram.obj Chars.obj CopyMemory.obj Print.obj ScanKeys.obj \
	Sound.obj VramA.obj \
	..\..\cate\cate09.lib

$(name).bin: $(objects) makefile
	LinkBE.exe $(name).bin $(cseg) $(dseg) $(zseg) $(objects)

BinSize.inc: $(name).bin BinSize.csx
	dotnet script BinSize.csx $(name)

$(name)_01.l3: Loader.obj makefile
	LinkBE.exe Loader.l3 d000 d200 d100 Loader.obj
	copy Loader.l3 $(name)_01.l3 /y

$(name)_02.l3: $(name).bin BinL3.csx
	dotnet script BinL3.csx $(name) $(cseg)

$(name).l3: $(name)_01.l3 $(name)_02.l3
	copy /b $(name)_01.l3+$(name)_02.l3 $(name).l3
