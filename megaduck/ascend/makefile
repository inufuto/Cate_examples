name=ascend

all: $(name).bin

cseg=0000
dseg=c0a0

.c.asm:
	Cate83.exe $*.c

.asm.obj:
	Asm83.exe $*.asm

Actor.asm: Actor.c Movable.h Actor.h Stage.h Block.h Sprite.h \
	Movable.h Man.h 
Block.asm: Block.c Movable.h Sprite.h Movable.h Actor.h Block.h \
	Chars.h Stage.h Stages.h Vram.h Man.h 
Fire.asm: Fire.c Movable.h Sprite.h Movable.h Actor.h Fire.h \
	Chars.h Math.h Main.h Stage.h Man.h Vram.h 
Main.asm: Main.c Main.h ScanKeys.h Vram.h Sound.h Status.h \
	Movable.h Actor.h Stage.h Sprite.h Movable.h Man.h \
	Fire.h Monster.h 
Man.asm: Man.c Movable.h Sprite.h Movable.h Actor.h Man.h \
	Stage.h Chars.h ScanKeys.h Vram.h Block.h Sound.h \
	Main.h Fire.h Status.h 
Monster.asm: Monster.c Movable.h Sprite.h Movable.h Actor.h Monster.h \
	Chars.h Math.h Main.h Stage.h Man.h Vram.h 
Movable.asm: Movable.c Movable.h 
Stage.asm: Stage.c Vram.h Stage.h Stages.h Main.h Chars.h \
	Status.h Movable.h Actor.h Man.h Sprite.h Movable.h \
	Stage.h Fire.h Monster.h Block.h Math.h 
Stages.asm: Stages.c Stage.h Stages.h 
Status.asm: Status.c Status.h Vram.h Main.h Sprite.h Movable.h \
	Print.h Chars.h 
Vram.asm: Vram.c Vram.h Chars.h 
Chars.obj: Chars.asm 
Math.obj: Math.asm 
Print.obj: Print.asm 
ScanKeys.obj: ScanKeys.asm MegaDuck.inc 
Sound.obj: Sound.asm MegaDuck.inc 
Sprite.obj: Sprite.asm MegaDuck.inc Vram.inc 
Startup.obj: Startup.asm MegaDuck.inc Vram.inc 
VramA.obj: VramA.asm MegaDuck.inc Vram.inc Chars.inc 

objects = startup.obj \
	Actor.obj Block.obj Fire.obj Main.obj Man.obj Monster.obj \
	Movable.obj Stage.obj Stages.obj Status.obj Vram.obj Chars.obj \
	Math.obj Print.obj ScanKeys.obj Sound.obj Sprite.obj VramA.obj \
	..\..\cate\cate83.lib

$(name).bin: $(objects) makefile
	LinkLE.exe $(name).bin $(cseg) $(dseg) $(objects)
