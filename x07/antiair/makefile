name=antiair

all: loader.wav $(name).wav

cseg_l=2000
cseg=2100
dseg=3600

.c.asm:
	Cate80.exe $*.c

.asm.obj:
	Asm80.exe $*.asm

Bang.asm: Bang.c Bang.h Movable.h VVram.h Sprite.h Movable.h \
	Stage.h 
Block.asm: Block.c Block.h Movable.h Sprite.h Movable.h VVram.h \
	CopyMemory.h Bang.h Movable.h Sound.h Cannon.h Movable.h \
	Status.h 
Bullet.asm: Bullet.c Bullet.h Sprite.h Movable.h VVram.h Sound.h \
	Cannon.h Movable.h Ufo.h Stage.h Block.h Movable.h 
Cannon.asm: Cannon.c Cannon.h Movable.h VVram.h Sprite.h Movable.h \
	ScanKeys.h Bullet.h Block.h Movable.h Bang.h Movable.h \
	Sound.h 
Main.asm: Main.c Status.h ScanKeys.h Sound.h Stage.h Cannon.h \
	Movable.h Sprite.h Movable.h Bullet.h Vram.h VVram.h \
	Ufo.h Stage.h Bang.h Movable.h Block.h Movable.h 
Sprite.asm: Sprite.c Vram.h VVram.h Sprite.h Movable.h 
Stage.asm: Stage.c Stages.h Stage.h Vram.h VVram.h Math.h \
	Status.h Sprite.h Movable.h Cannon.h Movable.h Bullet.h \
	Ufo.h Stage.h Bang.h Movable.h Block.h Movable.h 
Stages.asm: Stages.c Stages.h Stage.h 
Status.asm: Status.c Status.h Vram.h Sprite.h Movable.h Print.h \
	VVram.h 
Ufo.asm: Ufo.c Ufo.h Stage.h VVram.h Movable.h CopyMemory.h \
	Bang.h Movable.h Sound.h Block.h Movable.h Math.h \
	Status.h 
VVram.asm: VVram.c VVram.h Sprite.h Movable.h Vram.h Ufo.h \
	Stage.h Sound.h 
CopyMemory.obj: CopyMemory.asm 
Loader.obj: Loader.asm 
Math.obj: Math.asm 
Print.obj: Print.asm 
ScanKeys.obj: ScanKeys.asm 
Sound.obj: Sound.asm 
Startup.obj: Startup.asm 
SubSys.obj: SubSys.asm 
VramA.obj: VramA.asm Vram.inc VVram.inc 
VVramA.obj: VVramA.asm VVram.inc 

objects = Startup.obj \
	Bang.obj Block.obj Bullet.obj Cannon.obj Main.obj Sprite.obj \
	Stage.obj Stages.obj Status.obj Ufo.obj VVram.obj CopyMemory.obj \
	Math.obj Print.obj ScanKeys.obj Sound.obj SubSys.obj VramA.obj \
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
