name=ascend

all: $(name).pbf Clear.bas loader.bas $(name)_1.bas

cseg=1cd0 # MODE110(7376)
dseg=3b00

.c.asm:
	Cate61h.exe $*.c

.asm.obj:
	Asm61h.exe $*.asm

Actor.asm: Actor.c Movable.h Actor.h Stage.h Block.h Sprite.h \
	Movable.h Man.h Actor.h 
Block.asm: Block.c Movable.h Sprite.h Movable.h Actor.h Block.h \
	Stage.h Stages.h Vram.h Man.h Actor.h 
Fire.asm: Fire.c Movable.h Sprite.h Movable.h Actor.h Fire.h \
	Math.h Main.h Stage.h Man.h Actor.h Vram.h \
	VVram.h Vram.h 
Main.asm: Main.c Main.h ScanKeys.h Vram.h Sound.h Status.h \
	Movable.h Actor.h Stage.h Sprite.h Movable.h Man.h \
	Actor.h Fire.h Monster.h VVram.h Vram.h 
Man.asm: Man.c Movable.h Sprite.h Movable.h Actor.h Man.h \
	Actor.h Stage.h ScanKeys.h Vram.h Block.h Sound.h \
	Main.h Fire.h Status.h VVram.h Vram.h 
Monster.asm: Monster.c Movable.h Sprite.h Movable.h Actor.h Monster.h \
	Math.h Main.h Stage.h Man.h Actor.h Vram.h 
Movable.asm: Movable.c Movable.h 
Stage.asm: Stage.c Vram.h Stage.h Stages.h Main.h Status.h \
	Movable.h Actor.h Man.h Actor.h Sprite.h Movable.h \
	Stage.h Fire.h Monster.h Block.h Math.h VVram.h \
	Vram.h 
Stages.asm: Stages.c Stage.h Stages.h 
Status.asm: Status.c Status.h Vram.h Main.h Sprite.h Movable.h \
	Print.h Man.h Actor.h 
Vram.asm: Vram.c Vram.h 
VVram.asm: VVram.c VVram.h Vram.h Movable.h Sprite.h Movable.h \
	Vram.h Sound.h 
Loader.obj: Loader.asm 
Math.obj: Math.asm 
Print.obj: Print.asm 
ScanKeys.obj: ScanKeys.asm 
Sound.obj: Sound.asm 
Sprite.obj: Sprite.asm Vram.inc VVram.inc 
Startup.obj: Startup.asm 
VramA.obj: VramA.asm Vram.inc VVram.inc 
VVramA.obj: VVramA.asm VVram.inc 

objects = Startup.obj \
	Actor.obj Block.obj Fire.obj Main.obj Man.obj Monster.obj \
	Movable.obj Stage.obj Stages.obj Status.obj Vram.obj VVram.obj \
	Math.obj Print.obj ScanKeys.obj Sound.obj Sprite.obj VramA.obj \
	VVramA.obj \
	..\..\cate\cate61h.lib

$(name).bin: $(objects) makefile
	LinkLE.exe $(name).bin $(cseg) $(dseg) $(objects)

$(name).pbf: $(objects) makefile
	LinkLE.exe $(name).pbf $(cseg) $(dseg) $(objects)

loader.bin: loader.obj makefile
	LinkLE.exe loader.bin $(dseg) $(dseg) loader.obj

$(name)_1.bas: $(name).bin BinBas.csx loader.bin makefile
	dotnet script BinBas.csx $(name) $(cseg) $(dseg)

Clear.bas: $(name).bin Clear.csx makefile
	dotnet script Clear.csx $(name)

loader.bas: Makeloader.csx $(name).bin loader.bin makefile
	dotnet script Makeloader.csx $(name) $(cseg) $(dseg)
