name=lift

all: $(name).bin

cseg=0000
dseg=c0a0

.c.asm:
	Cate83.exe $*.c

.asm.obj:
	Asm83.exe $*.asm

Actor.asm: Actor.c Movable.h Actor.h Stage.h Lift.h 
Item.asm: Item.c Item.h Stage.h Stages.h Vram.h Chars.h \
	Main.h Movable.h Actor.h Man.h Point.h Movable.h \
	Sound.h Sprite.h Movable.h 
Lift.asm: Lift.c Movable.h Actor.h Lift.h Stage.h Stages.h \
	Vram.h Chars.h Sprite.h Movable.h Man.h Monster.h 
Main.asm: Main.c Main.h  ScanKeys.h Movable.h Sprite.h \
	Movable.h Vram.h Sound.h Status.h Stage.h Actor.h \
	Monster.h Lift.h Man.h Item.h Point.h Movable.h 
Man.asm: Man.c Movable.h Actor.h Man.h Stage.h Sprite.h \
	Movable.h Chars.h ScanKeys.h Item.h Sound.h Vram.h 
Math.asm: Math.c Math.h 
Monster.asm: Monster.c Movable.h Actor.h Monster.h Stages.h Stage.h \
	Sprite.h Movable.h Chars.h Man.h Lift.h 
Movable.asm: Movable.c Movable.h Stage.h Actor.h Lift.h 
Point.asm: Point.c Point.h Movable.h Sprite.h Movable.h Main.h \
	Chars.h 
Stage.asm: Stage.c Stage.h Stages.h Main.h Vram.h Movable.h \
	Sprite.h Movable.h Chars.h Status.h Item.h Actor.h \
	Man.h Lift.h Monster.h Point.h Movable.h 
Stages.asm: Stages.c Stage.h Stages.h 
Status.asm: Status.c Status.h Vram.h Main.h Sprite.h Movable.h \
	Print.h Chars.h 
Vram.asm: Vram.c Vram.h Chars.h 
Chars.obj: Chars.asm 
Print.obj: Print.asm 
ScanKeys.obj: ScanKeys.asm MegaDuck.inc 
Sound.obj: Sound.asm MegaDuck.inc 
Sprite.obj: Sprite.asm MegaDuck.inc Vram.inc 
StageA.obj: StageA.asm 
Startup.obj: Startup.asm MegaDuck.inc Vram.inc 
VramA.obj: VramA.asm MegaDuck.inc Vram.inc Chars.inc 

objects = Startup.obj \
	Actor.obj Item.obj Lift.obj Main.obj Man.obj Math.obj \
	Monster.obj Movable.obj Point.obj Stage.obj Stages.obj Status.obj \
	Vram.obj Chars.obj Print.obj ScanKeys.obj Sound.obj Sprite.obj \
	StageA.obj VramA.obj \
	..\..\cate\cate83.lib

$(name).bin: $(objects) makefile
	LinkLE.exe $(name).bin $(cseg) $(dseg) $(objects)
