name=antiair

all: $(name).pbf Clear.bas Loader.bas $(name)_1.bas

cseg=1cd0 # MODE110(7376)
dseg=3700

.c.asm:
	Cate61h.exe $*.c

.asm.obj:
	Asm61h.exe $*.asm

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
Status.asm: Status.c Status.h Vram.h VVram.h Print.h Sprite.h \
	Movable.h Cannon.h Movable.h 
Ufo.asm: Ufo.c Ufo.h Stage.h VVram.h Movable.h CopyMemory.h \
	Bang.h Movable.h Sound.h Block.h Movable.h Math.h \
	Status.h 
Vram.asm: Vram.c Vram.h 
VVram.asm: VVram.c VVram.h Sprite.h Movable.h Vram.h Ufo.h \
	Stage.h Sound.h 
CopyMemory.obj: CopyMemory.asm 
Loader.obj: Loader.asm 
Math.obj: Math.asm 
Print.obj: Print.asm 
ScanKeys.obj: ScanKeys.asm 
Sound.obj: Sound.asm 
Startup.obj: Startup.asm 
VramA.obj: VramA.asm Vram.inc VVram.inc 
VVramA.obj: VVramA.asm VVram.inc 

objects = Startup.obj \
	Bang.obj Block.obj Bullet.obj Cannon.obj Main.obj Sprite.obj \
	Stage.obj Stages.obj Status.obj Ufo.obj Vram.obj VVram.obj \
	CopyMemory.obj Math.obj Print.obj ScanKeys.obj Sound.obj VramA.obj \
	VVramA.obj \
	..\..\cate\cate61h.lib

$(name).bin: $(objects) makefile
	LinkLE.exe $(name).bin $(cseg) $(dseg) $(objects)

$(name).pbf: $(objects) makefile
	LinkLE.exe $(name).pbf $(cseg) $(dseg) $(objects)

Loader.bin: Loader.obj makefile
	LinkLE.exe Loader.bin $(dseg) $(dseg) Loader.obj

$(name)_1.bas: $(name).bin BinBas.csx Loader.bin makefile
	dotnet script BinBas.csx $(name) $(cseg) $(dseg)

Clear.bas: $(name).bin Clear.csx makefile
	dotnet script Clear.csx $(name)

Loader.bas: MakeLoader.csx $(name).bin Loader.bin makefile
	dotnet script MakeLoader.csx $(name) $(cseg) $(dseg)
