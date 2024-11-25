name=yewdow

all: loader.wav $(name).wav

cseg_l=2000
cseg=2100
dseg=3b00

.c.asm:
	Cate80.exe $*.c

.asm.obj:
	Asm80.exe $*.asm

Actor.asm: Actor.c Movable.h Actor.h Movable.h Stage.h 
Car.asm: Car.c Car.h Actor.h Movable.h Sprite.h Movable.h \
	Stage.h Stages.h Vram.h Item.h Man.h Actor.h \
	Movable.h Main.h Monster.h Actor.h Movable.h Sound.h 
Item.asm: Item.c Item.h Stage.h VVram.h Movable.h Point.h \
	Sound.h Main.h 
Main.asm: Main.c Main.h Status.h Movable.h ScanKeys.h Stage.h \
	Sound.h Man.h Actor.h Movable.h Sprite.h Movable.h \
	Item.h Car.h Actor.h Movable.h Monster.h Actor.h \
	Movable.h Point.h Vram.h 
Man.asm: Man.c Man.h Actor.h Movable.h ScanKeys.h Sprite.h \
	Movable.h Stage.h Actor.h Movable.h Sound.h Vram.h \
	Monster.h Actor.h Movable.h 
Monster.asm: Monster.c Monster.h Actor.h Movable.h Stage.h Stages.h \
	Math.h Man.h Actor.h Movable.h Sprite.h Movable.h \
	Point.h Sound.h 
Movable.asm: Movable.c Movable.h 
Point.asm: Point.c Point.h Main.h VVram.h Movable.h 
Sprite.asm: Sprite.c Sprite.h Movable.h VVram.h Vram.h 
Stage.asm: Stage.c Stage.h Stages.h Main.h Sprite.h Movable.h \
	Vram.h Status.h Man.h Actor.h Movable.h Car.h \
	Actor.h Movable.h Monster.h Actor.h Movable.h Item.h \
	Point.h 
Stages.asm: Stages.c Stage.h Stages.h 
Status.asm: Status.c Status.h Vram.h Main.h Sprite.h Movable.h \
	Print.h VVram.h 
Vram.asm: Vram.c Vram.h VVram.h Item.h Sprite.h Movable.h \
	Sound.h Point.h 
VVram.asm: VVram.c VVram.h Sprite.h Movable.h Vram.h 
Loader.obj: Loader.asm 
Math.obj: Math.asm 
Print.obj: Print.asm 
ScanKeys.obj: ScanKeys.asm 
Sound.obj: Sound.asm 
StageA.obj: StageA.asm 
Startup.obj: Startup.asm 
SubSys.obj: SubSys.asm 
VramA.obj: VramA.asm Vram.inc VVram.inc 
VVramA.obj: VVramA.asm VVram.inc 

objects = Startup.obj \
	Actor.obj Car.obj Item.obj Main.obj Man.obj Monster.obj \
	Movable.obj Point.obj Sprite.obj Stage.obj Stages.obj Status.obj \
	Vram.obj VVram.obj Math.obj Print.obj ScanKeys.obj Sound.obj \
	StageA.obj SubSys.obj VramA.obj VVramA.obj \
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
