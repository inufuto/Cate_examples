name=lift

all: $(name).mzt

cseg=0000
dseg=1d00

.c.asm:
	Cate80.exe $*.c

.asm.obj:
	Asm80.exe $*.asm

Main.asm: Main.c Main.h ScanKeys.h Sprite.h Vram.h Sound.h Status.h Stage.h \
	Actor.h Monster.h Lift.h Man.h Item.h Point.h Movable.h VVram.h

Status.asm: Status.c Status.h Main.h Print.h Chars.h Sprite.h Vram.h Movable.h \
	VVram.h
Stage.asm: Stage.c Stage.h Stages.h Main.h Sprite.h Chars.h Vram.h Status.h Man.h Item.h \
	Lift.h Actor.h Monster.h Point.h VVram.h
Stages.asm: Stages.c Stage.h Stages.h
Movable.asm: Movable.c Movable.h Stage.h Actor.h Lift.h
Actor.asm: Actor.c Movable.h Actor.h Stage.h Lift.h
Man.asm: Man.c Movable.h Actor.h Man.h Stage.h Sprite.h Chars.h ScanKeys.h Item.h \
	Sound.h VVram.h
Item.asm: Item.c Item.h Stage.h Stages.h Vram.h Chars.h Main.h Movable.h Actor.h \
	Point.h Sound.h Sprite.h VVram.h
Lift.asm: Lift.c Lift.h Movable.h Stages.h Vram.h Chars.h Sprite.h Actor.h Man.h \
	Monster.h Stage.h
Monster.asm: Monster.c Actor.h Monster.h Sprite.h Stage.h Man.h Main.h \
	Lift.h 
Point.asm: Point.c Movable.h Point.h Sprite.h Main.h Chars.h

Vram.asm: Vram.c Vram.h Chars.h
Sprite.asm: Sprite.c Sprite.h Chars.h Vram.h VVram.h
VVram.asm: VVram.h Chars.h Vram.h Sprite.h Sound.h
VVramA.obj: VVramA.asm VVram.inc Chars.inc

objects = Startup.obj \
	Main.obj Status.obj Stage.obj Movable.obj Actor.obj \
	Stages.obj Chars.obj Man.obj Item.obj Lift.obj Monster.obj Point.obj \
	ScanKeys.obj Vram.obj VramA.obj Print.obj VVram.obj VVramA.obj \
	Sprite.obj Sound.obj \
	..\..\cate\cate80.lib

$(name).mzt: $(objects)
	LinkLE.exe $(name).mzt $(cseg) $(dseg) $(objects)
