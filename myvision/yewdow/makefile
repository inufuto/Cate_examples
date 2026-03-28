name=yewdow

all: $(name).rom

cseg=0000
dseg=a000

.c.asm:
	Cate80.exe $*.c

.asm.obj:
	Asm80.exe $*.asm

Actor.asm: Actor.c Movable.h Actor.h Movable.h Stage.h 
Car.asm: Car.c Car.h Actor.h Movable.h Chars.h Sprite.h \
	Movable.h Stage.h Stages.h Vram.h Item.h Man.h \
	Actor.h Movable.h Main.h Monster.h Actor.h Movable.h \
	Sound.h 
Item.asm: Item.c Item.h Stage.h Vram.h Chars.h Movable.h \
	Point.h Sound.h Main.h 
Main.asm: Main.c Main.h Status.h Movable.h ScanKeys.h Stage.h \
	Sound.h Man.h Actor.h Movable.h Sprite.h Movable.h \
	Item.h Car.h Actor.h Movable.h Monster.h Actor.h \
	Movable.h Point.h 
Man.asm: Man.c Man.h Actor.h Movable.h ScanKeys.h Chars.h \
	Sprite.h Movable.h Stage.h Actor.h Movable.h Sound.h \
	Vram.h Monster.h Actor.h Movable.h 
Monster.asm: Monster.c Monster.h Actor.h Movable.h Stage.h Stages.h \
	Math.h Man.h Actor.h Movable.h Chars.h Sprite.h \
	Movable.h Point.h Sound.h 
Movable.asm: Movable.c Movable.h 
Point.asm: Point.c Movable.h Point.h Sprite.h Movable.h Main.h \
	Chars.h 
Stage.asm: Stage.c Stage.h Stages.h Main.h Sprite.h Movable.h \
	Vram.h Status.h Man.h Actor.h Movable.h Chars.h \
	Car.h Actor.h Movable.h Monster.h Actor.h Movable.h \
	Item.h Point.h 
Stages.asm: Stages.c Stage.h Stages.h 
Status.asm: Status.c Status.h Vram.h Main.h Print.h Chars.h \
	Sprite.h Movable.h 
Vram.asm: Vram.c Vram.h Chars.h 
Chars.obj: Chars.asm 
Math.obj: Math.asm 
Print.obj: Print.asm 
ScanKeys.obj: ScanKeys.asm kh1000.inc 
Sound.obj: Sound.asm kh1000.inc 
Sprite.obj: Sprite.asm kh1000.inc Vram.inc Chars.inc 
StageA.obj: StageA.asm 
Startup.obj: Startup.asm kh1000.inc 
Vdp.obj: Vdp.asm kh1000.inc Vram.inc 
VramA.obj: VramA.asm kh1000.inc Vram.inc Chars.inc 

objects = Startup.obj \
	Actor.obj Car.obj Item.obj Main.obj Man.obj Monster.obj \
	Movable.obj Point.obj Stage.obj Stages.obj Status.obj Vram.obj \
	Chars.obj Math.obj Print.obj ScanKeys.obj Sound.obj Sprite.obj \
	StageA.obj Vdp.obj VramA.obj \
	..\..\cate\cate80.lib

$(name).rom: $(objects) makefile
    linkle.exe $(name).rom $(cseg) $(dseg) $(objects)
