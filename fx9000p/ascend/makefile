name=ascend

all: $(name).rom debug.bin

cseg=9000
dseg=b800

.c.asm:
	Cate80.exe $*.c

.asm.obj:
	Asm80.exe $*.asm

Actor.asm: Actor.c Movable.h Actor.h Stage.h Block.h Sprite.h \
	Movable.h Man.h 
Block.asm: Block.c Movable.h Sprite.h Movable.h Actor.h Block.h \
	Chars.h Stage.h Stages.h Vram.h Man.h 
Fire.asm: Fire.c Movable.h Sprite.h Movable.h Actor.h Fire.h \
	Chars.h Math.h Main.h Stage.h Man.h Vram.h \
	VVram.h Vram.h 
Main.asm: Main.c Main.h ScanKeys.h Vram.h Status.h Movable.h \
	Actor.h Stage.h Sprite.h Movable.h Man.h Fire.h \
	Monster.h VVram.h Vram.h 
Man.asm: Man.c Movable.h Sprite.h Movable.h Actor.h Man.h \
	Stage.h Chars.h ScanKeys.h Vram.h Block.h Main.h \
	Fire.h Status.h VVram.h Vram.h 
Monster.asm: Monster.c Movable.h Sprite.h Movable.h Actor.h Monster.h \
	Chars.h Math.h Main.h Stage.h Man.h Vram.h 
Movable.asm: Movable.c Movable.h 
Sprite.asm: Sprite.c Movable.h Sprite.h Movable.h Chars.h VVram.h \
	Vram.h Vram.h Stage.h 
Stage.asm: Stage.c Vram.h Stage.h Stages.h Main.h Chars.h \
	Status.h Movable.h Actor.h Man.h Sprite.h Movable.h \
	Stage.h Fire.h Monster.h Block.h Math.h VVram.h \
	Vram.h 
Stages.asm: Stages.c Stage.h Stages.h 
Status.asm: Status.c Status.h Vram.h Stage.h Main.h Sprite.h \
	Movable.h Print.h Chars.h 
Vram.asm: Vram.c Vram.h Chars.h 
VVram.asm: VVram.c VVram.h Vram.h Chars.h Movable.h Sprite.h \
	Movable.h Vram.h 
Chars.obj: Chars.asm 
Loader.obj: Loader.asm BinSize.inc
Math.obj: Math.asm 
Print.obj: Print.asm 
ScanKeys.obj: ScanKeys.asm 
Startup.obj: Startup.asm Vram.inc 
VramA.obj: VramA.asm Vram.inc VVram.inc 
VVramA.obj: VVramA.asm Vram.inc VVram.inc Chars.inc 

objects = Startup.obj \
	Actor.obj Block.obj Fire.obj Main.obj Man.obj Monster.obj \
	Movable.obj Sprite.obj Stage.obj Stages.obj Status.obj Vram.obj \
	VVram.obj Chars.obj Math.obj Print.obj ScanKeys.obj VramA.obj \
	VVramA.obj \
	..\..\cate\cate80.lib

$(name).bin: $(objects) makefile
	LinkLE.exe $(name).bin $(cseg) $(dseg) $(objects)

BinSize.inc: $(name).bin BinSize.csx
	dotnet script BinSize.csx $(name) $(cseg)

Loader.bin: Loader.obj makefile
	LinkLE.exe Loader.bin 4000 $(dseg) Loader.obj

$(name).rom: $(name).bin Loader.bin MakeRom.csx
	dotnet script MakeRom.csx $(name)

debug.bin: $(name).bin
	copy $(name).bin debug.bin /y
