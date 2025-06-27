name=cracky

all: $(name).d88

cseg=4000
zseg=6300 
dseg=6400

.c.asm:
	Cate09.exe $*.c

.asm.obj:
	Asm09.exe $*.asm

Destruction.asm: Destruction.c Destruction.h Stage.h Movable.h VVram.h Chars.h 
Main.asm: Main.c Main.h ScanKeys.h Vram.h VVram.h Sound.h \
	Sprite.h Movable.h Status.h Stage.h Movable.h Man.h \
	Movable.h Destruction.h Monster.h Movable.h 
Man.asm: Man.c Man.h Movable.h ScanKeys.h Chars.h Sprite.h \
	Movable.h Stage.h Movable.h VVram.h Destruction.h Main.h \
	Sound.h 
Monster.asm: Monster.c Monster.h Movable.h Stages.h Stage.h Movable.h \
	Sprite.h Movable.h Chars.h Math.h Man.h Movable.h 
Movable.asm: Movable.c Movable.h Stage.h Movable.h 
Sprite.asm: Sprite.c Movable.h Sprite.h Movable.h Vram.h VVram.h 
Stage.asm: Stage.c Stage.h Movable.h Stages.h Stage.h Movable.h \
	Main.h Vram.h VVram.h Sprite.h Movable.h Chars.h \
	Status.h CopyMemory.h Man.h Movable.h Monster.h Movable.h \
	Destruction.h 
Stages.asm: Stages.c Stage.h Movable.h Stages.h Stage.h Movable.h 
Status.asm: Status.c Status.h Vram.h Stage.h Movable.h Main.h \
	Sprite.h Movable.h Print.h Chars.h 
Vram.asm: Vram.c Vram.h Chars.h 
VVram.asm: VVram.c Vram.h VVram.h Chars.h Sprite.h Movable.h \
	Sound.h 
Chars.obj: Chars.asm 
CopyMemory.obj: CopyMemory.asm 
Loader.obj: Loader.asm S1.inc BinSize.inc
Math.obj: Math.asm 
Print.obj: Print.asm 
ScanKeys.obj: ScanKeys.asm S1.inc 
Sound.obj: Sound.asm 
StageA.obj: StageA.asm 
Startup.obj: Startup.asm S1.inc 
VramA.obj: VramA.asm S1.inc Vram.inc VVram.inc Chars.inc 
VVramA.obj: VVramA.asm VVram.inc 

objects = Startup.obj \
	Destruction.obj Main.obj Man.obj Monster.obj Movable.obj Sprite.obj \
	Stage.obj Stages.obj Status.obj Vram.obj VVram.obj Chars.obj \
	CopyMemory.obj Math.obj Print.obj ScanKeys.obj Sound.obj StageA.obj \
	VramA.obj VVramA.obj \
	..\..\cate\cate09.lib

$(name).bin: $(objects) makefile
	LinkBE.exe $(name).bin $(cseg) $(dseg) $(zseg) $(objects)

BinSize.inc: $(name).bin BinSize.csx
	dotnet script BinSize.csx $(name) $(cseg)

Loader.bin: Loader.obj makefile BinSize.inc
	LinkBE.exe Loader.bin 2000 2300 2200 Loader.obj

$(name).d88: Loader.bin $(name).bin disk.csx
	dotnet script disk.csx $(name)
