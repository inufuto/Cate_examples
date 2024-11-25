name=osotos

all: loader.wav $(name).wav

cseg_l=1d00
cseg=1e00
dseg=3a00

.c.asm:
	Cate80.exe $*.c

.asm.obj:
	Asm80.exe $*.asm

Block.asm: Block.c Block.h Movable.h Stage.h Movable.h Stages.h \
	Stage.h Movable.h VVram.h Sprite.h Movable.h Man.h \
	Movable.h Monster.h Movable.h Point.h Sound.h Vram.h 
Main.asm: Main.c Main.h ScanKeys.h Vram.h Sound.h Sprite.h \
	Movable.h Status.h Stage.h Movable.h Man.h Movable.h \
	Monster.h Movable.h Block.h Movable.h Point.h VVram.h 
Man.asm: Man.c Man.h Movable.h Sprite.h Movable.h Stage.h \
	Movable.h ScanKeys.h Block.h Movable.h Sound.h Main.h \
	VVram.h 
Monster.asm: Monster.c Monster.h Movable.h Stage.h Movable.h Stages.h \
	Stage.h Movable.h Sprite.h Movable.h Math.h Man.h \
	Movable.h Main.h 
Movable.asm: Movable.c Movable.h Stage.h Movable.h 
Point.asm: Point.c Point.h Main.h Vram.h VVram.h 
Sprite.asm: Sprite.c Sprite.h Movable.h VVram.h Vram.h 
Stage.asm: Stage.c Stage.h Movable.h Stages.h Stage.h Movable.h \
	Main.h VVram.h Sprite.h Movable.h Status.h Block.h \
	Movable.h Man.h Movable.h Monster.h Movable.h CopyMemory.h \
	Point.h Math.h Vram.h 
Stages.asm: Stages.c Stage.h Movable.h Stages.h Stage.h Movable.h 
Status.asm: Status.c Status.h Vram.h Main.h Sprite.h Movable.h \
	Print.h VVram.h 
VVram.asm: VVram.c VVram.h Block.h Movable.h Sprite.h Movable.h \
	Vram.h Sound.h Point.h 
CopyMemory.obj: CopyMemory.asm 
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
	Block.obj Main.obj Man.obj Monster.obj Movable.obj Point.obj \
	Sprite.obj Stage.obj Stages.obj Status.obj VVram.obj CopyMemory.obj \
	Math.obj Print.obj ScanKeys.obj Sound.obj StageA.obj SubSys.obj \
	VramA.obj VVramA.obj \
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
