name=lift

all:$(name).dsk

cseg=4000
zseg=00E0 
dseg=1000

.c.asm:
	Cate65.exe $*.c

.asm.obj:
	Asm65.exe $*.asm

Actor.asm: Actor.c Movable.h Actor.h Stage.h Lift.h 
Item.asm: Item.c Item.h Stage.h Stages.h Vram.h Chars.h \
	Main.h Movable.h Actor.h Man.h Point.h Movable.h \
	Sound.h Sprite.h Movable.h VVram.h 
Lift.asm: Lift.c Movable.h Actor.h Lift.h Stage.h Stages.h \
	Vram.h Chars.h Sprite.h Movable.h Man.h Monster.h 
Main.asm: Main.c Main.h ScanKeys.h Movable.h Sprite.h Movable.h \
	Vram.h Sound.h Status.h Stage.h Actor.h Monster.h \
	Lift.h Man.h Item.h Point.h Movable.h 
Man.asm: Man.c Movable.h Actor.h Man.h Stage.h Sprite.h \
	Movable.h Chars.h ScanKeys.h Item.h Sound.h VVram.h 
Math.asm: Math.c Math.h 
Monster.asm: Monster.c Movable.h Actor.h Monster.h Stages.h Stage.h \
	Sprite.h Movable.h Chars.h Man.h Lift.h 
Movable.asm: Movable.c Movable.h Stage.h Actor.h Lift.h 
Point.asm: Point.c Point.h Movable.h Sprite.h Movable.h Main.h \
	Chars.h 
Print.asm: Print.c Print.h Vram.h 
Sprite.asm: Sprite.c Sprite.h Movable.h Chars.h VVram.h Vram.h 
Stage.asm: Stage.c Stage.h Stages.h Main.h Vram.h Movable.h \
	Sprite.h Movable.h Chars.h Status.h Item.h Actor.h \
	Man.h Lift.h Monster.h Point.h Movable.h VVram.h 
Stages.asm: Stages.c Stage.h Stages.h 
Status.asm: Status.c Status.h Vram.h Stage.h Main.h Sprite.h \
	Movable.h Print.h Chars.h 
Vram.asm: Vram.c Vram.h VVram.h CopyMemory.h Chars.h 
VVram.asm: VVram.c VVram.h Chars.h Sprite.h Movable.h Vram.h \
	Sound.h 
Chars.obj: Chars.asm 
CopyMemory.obj: CopyMemory.asm ZeroPage.inc 
Loader.obj: Loader.asm BinSize.inc
ScanKeys.obj: ScanKeys.asm Apple2.inc ZeroPage.inc 
Sound.obj: Sound.asm Apple2.inc ZeroPage.inc 
Startup.obj: Startup.asm Apple2.inc 
VramA.obj: VramA.asm ZeroPage.inc Vram.inc 
VVramA.obj: VVramA.asm ZeroPage.inc VVram.inc CHars.inc 
ZeroPage.obj: ZeroPage.asm 

objects = Startup.obj \
	Actor.obj Item.obj Lift.obj Main.obj Man.obj Math.obj \
	Monster.obj Movable.obj Point.obj Print.obj Sprite.obj Stage.obj \
	Stages.obj Status.obj Vram.obj VVram.obj Chars.obj CopyMemory.obj \
	ScanKeys.obj Sound.obj VramA.obj VVramA.obj ZeroPage.obj \
	..\..\cate\cate65.lib

$(name).bin: $(objects)
	LinkLE.exe $(name).bin $(cseg) $(dseg) $(zseg) $(objects)

BinSize.inc: $(name).bin BinSize.csx
	dotnet script BinSize.csx $(name) $(cseg)

Loader.bin: Loader.obj BinSize.inc makefile 
	LinkLE.exe Loader.bin 0800 08f0 00e0 Loader.obj

$(name).dsk: $(name).bin Loader.bin Disk.csx
	dotnet script Disk.csx $(name)
