name=lift

all: $(name).rom

cseg=bfe8-bfff,8000
dseg=0200
zseg=0000

.c.asm:
	Cate65.exe -v2 $*.c

.asm.obj:
	Asm65.exe -v2 $*.asm

Actor.asm: Actor.c Movable.h Actor.h Stage.h Lift.h 
Item.asm: Item.c Item.h Stage.h Stages.h Vram.h Chars.h \
	Main.h Movable.h Actor.h Man.h Point.h Movable.h \
	Sound.h Sprite.h 
Lift.asm: Lift.c Movable.h Actor.h Lift.h Stage.h Stages.h \
	Vram.h Chars.h Sprite.h Man.h Monster.h 
Main.asm: Main.c Main.h ScanKeys.h Movable.h Sprite.h Vram.h \
	Sound.h Status.h Stage.h Actor.h Monster.h Lift.h \
	Man.h Item.h Point.h Movable.h 
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
RomTail.obj: RomTail.asm Vram.inc 
ScanKeys.obj: ScanKeys.asm ZeroPage.inc Port.inc 
Sound.obj: Sound.asm ZeroPage.inc Port.inc 
Sprite.obj: Sprite.asm ZeroPage.inc Port.inc Vram.inc Chars.inc 
Startup.obj: Startup.asm Port.inc Vram.inc 
VramA.obj: VramA.asm ZeroPage.inc Port.inc Vram.inc Chars.inc 
ZeroPage.obj: ZeroPage.asm 

objects = RomTail.obj Startup.obj \
	Actor.obj Item.obj Lift.obj Main.obj Man.obj Math.obj \
	Monster.obj Movable.obj Point.obj Stage.obj Stages.obj Status.obj \
	Vram.obj Chars.obj Print.obj ScanKeys.obj Sound.obj Sprite.obj \
	VramA.obj ZeroPage.obj \
	..\..\cate\cate65.lib

$(name).rom: $(objects) makefile
	LinkLE.exe $(name).rom $(cseg) $(dseg) $(zseg) $(objects)
