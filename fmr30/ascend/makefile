name=ascend

all: $(name).d88

cseg=0000
dseg=2c00

.c.asm:
	Cate86.exe $*.c

.asm.obj:
	Asm86.exe $*.asm

Actor.asm: Actor.c Movable.h Actor.h Stage.h Block.h Sprite.h \
	Man.h 
Block.asm: Block.c Movable.h Sprite.h Actor.h Block.h Chars.h \
	Stage.h Stages.h Vram.h Man.h VVram.h 
Fire.asm: Fire.c Movable.h Sprite.h Actor.h Fire.h Chars.h \
	Math.h Main.h Stage.h Man.h Vram.h VVram.h 
Main.asm: Main.c Main.h ScanKeys.h Vram.h Sound.h Status.h \
	Movable.h Actor.h Stage.h Sprite.h Man.h Fire.h \
	Monster.h 
Man.asm: Man.c Movable.h Sprite.h Actor.h Man.h Stage.h \
	Chars.h ScanKeys.h Vram.h Block.h Sound.h Main.h \
	Fire.h Status.h VVram.h 
Monster.asm: Monster.c Movable.h Sprite.h Actor.h Monster.h Chars.h \
	Math.h Main.h Stage.h Man.h Vram.h 
Movable.asm: Movable.c Movable.h 
Sprite.asm: Sprite.c Movable.h Sprite.h Vram.h VVram.h Stage.h 
Stage.asm: Stage.c Vram.h Stage.h Stages.h Main.h Chars.h \
	Status.h Movable.h Actor.h Man.h Sprite.h Stage.h \
	Fire.h Monster.h Block.h Math.h VVram.h 
Stages.asm: Stages.c Stage.h Stages.h 
Status.asm: Status.c Status.h Vram.h Stage.h Main.h Movable.h \
	Sprite.h Print.h Chars.h 
Vram.asm: Vram.c Vram.h Chars.h Movable.h Sprite.h CopyMemory.h \
	Sound.h 
VVram.asm: VVram.c VVram.h Chars.h 
Chars.obj: Chars.asm 
Loader.obj: Loader.asm 
Math.obj: Math.asm 
Print.obj: Print.asm 
ScanKeys.obj: ScanKeys.asm Vram.inc 
Sound.obj: Sound.asm 
Startup.obj: Startup.asm Vram.inc 
VramA.obj: VramA.asm Vram.inc VVram.inc Chars.inc 
VVramA.obj: VVramA.asm VVram.inc 

objects = Startup.obj \
	Actor.obj Block.obj Fire.obj Main.obj Man.obj Monster.obj \
	Movable.obj Sprite.obj Stage.obj Stages.obj Status.obj Vram.obj \
	VVram.obj Chars.obj Math.obj Print.obj ScanKeys.obj Sound.obj \
	VramA.obj VVramA.obj \
	..\..\cate\cate86.lib

$(name).bin: $(objects) makefile
	LinkLE.exe $(name).bin $(cseg) $(dseg) $(objects)

BinSize.inc: $(name).bin BinSize.csx
	dotnet script BinSize.csx $(name)

Loader.obj: Loader.asm BinSize.inc

Loader.bin: Loader.obj makefile
	LinkLE.exe Loader.bin 0000 0000 Loader.obj

$(name).d88: $(name).bin Loader.bin Disk.csx
	dotnet script Disk.csx $(name)
