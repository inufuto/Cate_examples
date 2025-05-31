name=mazy2

all: $(name).p

cseg=4082
dseg=6000

.c.asm:
	Cate80i.exe $*.c

.asm.obj:
	Asm80i.exe $*.asm

Knife.asm: Knife.c Knife.h Movable.h Stages.h Stage.h Sprite.h \
	Movable.h Man.h Movable.h Main.h Status.h Math.h \
	Monster.h Movable.h Point.h Movable.h 
Main.asm: Main.c Main.h Vram.h Status.h ScanKeys.h Stage.h \
	Sprite.h Movable.h Man.h Movable.h Monster.h Movable.h \
	Knife.h Movable.h Point.h Movable.h 
Man.asm: Man.c Man.h Movable.h Sprite.h Movable.h Stage.h \
	ScanKeys.h Knife.h Movable.h Vram.h 
Monster.asm: Monster.c Monster.h Movable.h Stages.h Stage.h Sprite.h \
	Movable.h Math.h Man.h Movable.h Knife.h Movable.h \
	Point.h Movable.h 
Movable.asm: Movable.c Movable.h Stage.h 
Point.asm: Point.c Point.h Movable.h Sprite.h Movable.h Main.h \
	Vram.h 
Sprite.asm: Sprite.c Sprite.h Movable.h Vram.h 
Stage.asm: Stage.c Stage.h Stages.h Stage.h Main.h Sprite.h \
	Movable.h Vram.h Status.h Man.h Movable.h Monster.h \
	Movable.h Knife.h Movable.h Point.h Movable.h 
Stages.asm: Stages.c Stage.h Stages.h Stage.h 
Status.asm: Status.c Status.h Vram.h Main.h Print.h Man.h \
	Movable.h Sprite.h Movable.h 
Vram.asm: Vram.c Vram.h Sprite.h Movable.h Point.h Movable.h 
DrawBackground.obj: DrawBackground.asm 
Math.obj: Math.asm 
Print.obj: Print.asm 
ScanKeys.obj: ScanKeys.asm 
StageA.obj: StageA.asm Vram.inc 
Startup.obj: Startup.asm 
VramA.obj: VramA.asm Vram.inc 

objects = Startup.obj \
	Knife.obj Main.obj Man.obj Monster.obj Movable.obj Point.obj \
	Sprite.obj Stage.obj Stages.obj Status.obj Vram.obj DrawBackground.obj \
	Math.obj Print.obj ScanKeys.obj StageA.obj VramA.obj \
	..\..\cate\cate80i.lib

$(name).bin: $(objects) makefile
	LinkLE.exe $(name).bin $(cseg) $(dseg) $(objects)

$(name).p: $(name).bin
	bin2p $(name).bin $(name).p
