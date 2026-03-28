name=lift

all: $(name).rom

cseg=0000
dseg=a000

.c.asm:
	Cate80.exe $*.c

.asm.obj:
	Asm80.exe $*.asm

Actor.asm: Actor.c Movable.h Actor.h Stage.h Lift.h 
Item.asm: Item.c Item.h Stage.h Stages.h Vram.h Chars.h \
	Main.h Movable.h Actor.h Man.h Point.h Movable.h \
	Sound.h Sprite.h 
Lift.asm: Lift.c Movable.h Actor.h Lift.h Stage.h Stages.h \
	Vram.h Chars.h Sprite.h Man.h Monster.h 
Main.asm: Main.c Main.h Init.h ScanKeys.h Movable.h Sprite.h \
	Vram.h Sound.h Status.h Stage.h Actor.h Monster.h \
	Lift.h Man.h Item.h Point.h Movable.h 
Man.asm: Man.c Movable.h Actor.h Man.h Stage.h Sprite.h \
	Chars.h ScanKeys.h Item.h Sound.h 
Math.asm: Math.c Math.h 
Monster.asm: Monster.c Movable.h Actor.h Monster.h Stages.h Stage.h \
	Sprite.h Chars.h Man.h Lift.h 
Movable.asm: Movable.c Movable.h Stage.h Actor.h Lift.h 
Point.asm: Point.c Point.h Movable.h Sprite.h Main.h Chars.h 
Stage.asm: Stage.c Stage.h Stages.h Main.h Vram.h Movable.h \
	Sprite.h Chars.h Status.h Item.h Actor.h Man.h \
	Lift.h Monster.h Point.h Movable.h 
Stages.asm: Stages.c Stage.h Stages.h 
Status.asm: Status.c Status.h Vram.h Main.h Movable.h Sprite.h \
	Print.h Chars.h 
Vram.asm: Vram.c Vram.h Chars.h 
Chars.obj: Chars.asm 
Print.obj: Print.asm 
ScanKeys.obj: ScanKeys.asm kh1000.inc 
Sound.obj: Sound.asm kh1000.inc 
Sprite.obj: Sprite.asm Vram.inc 
Startup.obj: Startup.asm kh1000.inc 
Vdp.obj: Vdp.asm kh1000.inc Vram.inc 
VramA.obj: VramA.asm Vram.inc Chars.inc 

objects = startup.obj \
	Actor.obj Item.obj Lift.obj Main.obj Man.obj Math.obj \
	Monster.obj Movable.obj Point.obj Stage.obj Stages.obj Status.obj \
	Vram.obj Chars.obj Print.obj ScanKeys.obj Sound.obj Sprite.obj \
	Vdp.obj VramA.obj \
	..\..\cate\cate80.lib


$(name).rom: $(objects) makefile
    linkle.exe $(name).rom $(cseg) $(dseg) $(objects)
