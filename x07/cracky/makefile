name=cracky

all: loader.wav $(name).wav

cseg_l=2000
cseg=2100
dseg=3600

.c.asm:
	Cate80.exe $*.c

.asm.obj:
	Asm80.exe $*.asm

Destruction.asm: Destruction.c Destruction.h Stage.h Movable.h VVram.h 
Main.asm: Main.c Main.h ScanKeys.h Vram.h VVram.h Sound.h \
	Sprite.h Movable.h Status.h Stage.h Movable.h Man.h \
	Movable.h Destruction.h Monster.h Movable.h 
Man.asm: Man.c Man.h Movable.h ScanKeys.h Sprite.h Movable.h \
	Stage.h Movable.h VVram.h Destruction.h Main.h Sound.h 
Monster.asm: Monster.c Monster.h Movable.h Stages.h Stage.h Movable.h \
	Sprite.h Movable.h Math.h Man.h Movable.h 
Movable.asm: Movable.c Movable.h Stage.h Movable.h 
Sprite.asm: Sprite.c Sprite.h Movable.h VVram.h Vram.h CopyMemory.h 
Stage.asm: Stage.c Stage.h Movable.h Stages.h Stage.h Movable.h \
	Main.h Vram.h VVram.h Sprite.h Movable.h Status.h \
	CopyMemory.h Man.h Movable.h Monster.h Movable.h Destruction.h 
Stages.asm: Stages.c Stage.h Movable.h Stages.h Stage.h Movable.h 
Status.asm: Status.c Status.h Vram.h Main.h Sprite.h Movable.h \
	Print.h VVram.h 
VVram.asm: VVram.c VVram.h Destruction.h Sprite.h Movable.h Vram.h \
	Sound.h 
CopyMemory.obj: CopyMemory.asm 
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
	Destruction.obj Main.obj Man.obj Monster.obj Movable.obj Sprite.obj \
	Stage.obj Stages.obj Status.obj VVram.obj CopyMemory.obj Math.obj \
	Print.obj ScanKeys.obj Sound.obj StageA.obj SubSys.obj VramA.obj \
	VVramA.obj \
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
