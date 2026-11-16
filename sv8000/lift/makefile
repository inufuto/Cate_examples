name=lift

all: $(name).bin

cseg=0000-1fff,4000
dseg=8000

.c.asm:
	Cate80.exe $*.c

.asm.obj:
	Asm80.exe -v2 $*.asm

Actor.asm: Actor.c Movable.h Actor.h Stage.h Vram.h Lift.h \
	Actor.h 
Item.asm: Item.c Item.h Stage.h Vram.h Stages.h Vram.h \
	Chars.h Main.h Movable.h Actor.h Man.h Point.h \
	Movable.h Sound.h Sprite.h Movable.h 
Lift.asm: Lift.c Movable.h Actor.h Lift.h Actor.h Stage.h \
	Vram.h Stages.h Vram.h Chars.h Sprite.h Movable.h \
	Man.h Monster.h 
Main.asm: Main.c Main.h ScanKeys.h Movable.h Sprite.h Movable.h \
	Vram.h Sound.h Status.h Stage.h Vram.h Actor.h \
	Monster.h Lift.h Actor.h Man.h Item.h Point.h \
	Movable.h 
Man.asm: Man.c Movable.h Actor.h Man.h Stage.h Vram.h \
	Sprite.h Movable.h Chars.h ScanKeys.h Item.h Sound.h \
	Vram.h 
Math.asm: Math.c Math.h 
Monster.asm: Monster.c Movable.h Actor.h Monster.h Stages.h Stage.h \
	Vram.h Sprite.h Movable.h Chars.h Man.h Lift.h \
	Actor.h 
Movable.asm: Movable.c Movable.h Stage.h Vram.h Actor.h Lift.h \
	Actor.h 
Point.asm: Point.c Point.h Movable.h Sprite.h Movable.h Main.h \
	Chars.h 
Sprite.asm: Sprite.c Sprite.h Movable.h Chars.h Vram.h Stage.h \
	Vram.h 
Stage.asm: Stage.c Stage.h Vram.h Stages.h Main.h Vram.h \
	Movable.h Sprite.h Movable.h Chars.h Status.h Item.h \
	Actor.h Man.h Lift.h Actor.h Monster.h Point.h \
	Movable.h 
Stages.asm: Stages.c Stage.h Vram.h Stages.h 
Status.asm: Status.c Status.h Vram.h Main.h Sprite.h Movable.h \
	Print.h Chars.h 
Vram.asm: Vram.c Vram.h Stage.h Vram.h Sprite.h Movable.h \
	Lift.h Actor.h 
Chars.obj: Chars.asm 
Print.obj: Print.asm 
ScanKeys.obj: ScanKeys.asm sv8000.inc 
Sound.obj: Sound.asm sv8000.inc 
StageA.obj: StageA.asm Vram.inc Chars.inc 
Startup.obj: Startup.asm sv8000.inc 
VramA.obj: VramA.asm sv8000.inc Vram.inc 

objects = Startup.obj \
	Actor.obj Item.obj Lift.obj Main.obj Man.obj Math.obj \
	Monster.obj Movable.obj Point.obj Sprite.obj Stage.obj Stages.obj \
	Status.obj Vram.obj Chars.obj Print.obj ScanKeys.obj Sound.obj \
	StageA.obj VramA.obj \
	..\..\cate\cate80.lib

_.bin: $(objects) makefile
	LinkLE.exe _.bin $(cseg) $(dseg) $(objects)
	copy _.symbols.txt $(name).symbols.txt /y

$(name).bin: _.bin Divide.csx
	dotnet script Divide.csx $(name)
