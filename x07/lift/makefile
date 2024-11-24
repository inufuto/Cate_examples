name=lift

all: loader.wav $(name).wav

cseg_l=2000
cseg=2100
dseg=3900

.c.asm:
	Cate80.exe $*.c

.asm.obj:
	Asm80.exe $*.asm

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
Point.asm: Point.c Point.h Main.h VVram.h Movable.h 
Sprite.asm: Sprite.c Sprite.h Movable.h VVram.h Vram.h 
Stage.asm: Stage.c Stage.h Stages.h Main.h Vram.h Movable.h \
	Sprite.h Movable.h Status.h Item.h Actor.h Man.h \
	Actor.h Lift.h Monster.h Point.h VVram.h 
Stages.asm: Stages.c Stage.h Stages.h 
Status.asm: Status.c Status.h Vram.h Main.h Sprite.h Movable.h \
	Print.h VVram.h 
VVram.asm: VVram.c VVram.h Sound.h Sprite.h Movable.h Vram.h \
	Point.h 
Loader.obj: Loader.asm 
Math.obj: Math.asm 
Print.obj: Print.asm 
ScanKeys.obj: ScanKeys.asm 
Sound.obj: Sound.asm 
StageA.obj: StageA.asm VVram.inc 
Startup.obj: Startup.asm 
SubSys.obj: SubSys.asm 
VramA.obj: VramA.asm Vram.inc VVram.inc 
VVramA.obj: VVramA.asm VVram.inc 

objects = Startup.obj \
	Actor.obj Item.obj Lift.obj Main.obj Man.obj Monster.obj \
	Movable.obj Point.obj Sprite.obj Stage.obj Stages.obj Status.obj \
	VVram.obj Math.obj Print.obj ScanKeys.obj Sound.obj StageA.obj \
	SubSys.obj VramA.obj VVramA.obj \
	..\..\cate\cate80.lib

$(name).cmt: $(objects) makefile
	LinkLE.exe $(name).cmt $(cseg) $(dseg) $(objects)
	LinkLE.exe $(name).bin $(cseg) $(dseg) $(objects)

$(name).wav: $(name).cmt CmtWav.csx makefile
	dotnet script CmtWav.csx $(name)

loader.bin: loader.obj makefile
	LinkLE.exe loader.bin $(cseg_l) $(cseg_l) loader.obj

loader.cmt: loader.bin Makeloader.csx makefile
	dotnet script Makeloader.csx $(name) $(cseg_l) $(cseg)

loader.wav: loader.cmt CmtWav.csx makefile
	dotnet script CmtWav.csx loader
