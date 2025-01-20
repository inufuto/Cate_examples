name=mieyen

all: $(name).p

cseg=4082
dseg=5900

.c.asm:
	Cate80i.exe $*.c

.asm.obj:
	Asm80i.exe $*.asm

Fire.asm: Fire.c Fire.h Movable.h Sprite.h Movable.h Man.h \
	Movable.h Monster.h Movable.h Point.h Movable.h 
Main.asm: Main.c Main.h Status.h ScanKeys.h Stage.h Sprite.h \
	Movable.h Man.h Movable.h Monster.h Movable.h Fire.h \
	Movable.h Point.h Movable.h Vram.h 
Man.asm: Man.c Man.h Movable.h Sprite.h Movable.h Stage.h \
	ScanKeys.h Fire.h Movable.h Main.h Vram.h 
Monster.asm: Monster.c Monster.h Movable.h Stage.h Stages.h Stage.h \
	Sprite.h Movable.h Math.h Status.h Main.h Man.h \
	Movable.h 
Movable.asm: Movable.c Movable.h Stage.h Sprite.h Movable.h 
Point.asm: Point.c Point.h Movable.h Sprite.h Movable.h Main.h \
	Vram.h 
Sprite.asm: Sprite.c Sprite.h Movable.h Vram.h 
Stage.asm: Stage.c Stage.h Stages.h Stage.h Main.h Math.h \
	Sprite.h Movable.h Status.h CopyMemory.h Man.h Movable.h \
	Monster.h Movable.h Fire.h Movable.h Point.h Movable.h \
	Vram.h 
Stages.asm: Stages.c Stage.h Stages.h Stage.h 
Status.asm: Status.c Status.h Vram.h Main.h Print.h Sprite.h \
	Movable.h Man.h Movable.h 
Vram.asm: Vram.c Vram.h Sprite.h Movable.h Point.h Movable.h 
CopyMemory.obj: CopyMemory.asm 
Math.obj: Math.asm 
Print.obj: Print.asm 
ScanKeys.obj: ScanKeys.asm 
StageA.obj: StageA.asm 
Startup.obj: Startup.asm 
VramA.obj: VramA.asm Vram.inc 

objects = Startup.obj \
	Fire.obj Main.obj Man.obj Monster.obj Movable.obj Point.obj \
	Sprite.obj Stage.obj Stages.obj Status.obj Vram.obj CopyMemory.obj \
	Math.obj Print.obj ScanKeys.obj StageA.obj VramA.obj \
	..\..\cate\cate80i.lib

$(name).bin: $(objects) makefile
	LinkLE.exe $(name).bin $(cseg) $(dseg) $(objects)

$(name).p: $(name).bin
	..\bin2p $(name).bin $(name).p
