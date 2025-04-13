name=hopman

all: $(name).rom debug.bin

cseg=9000
dseg=b800

.c.asm:
	Cate80.exe $*.c

.asm.obj:
	Asm80.exe $*.asm

Goal.asm: Goal.c Goal.h Movable.h Stage.h Movable.h Sprite.h \
	Movable.h Chars.h VVram.h 
Lift.asm: Lift.c Lift.h Movable.h Stages.h Stage.h Movable.h \
	Chars.h Sprite.h Movable.h Vram.h Man.h Movable.h 
Main.asm: Main.c Main.h ScanKeys.h Vram.h Sprite.h Movable.h \
	Status.h Stage.h Movable.h Man.h Movable.h Lift.h \
	Movable.h Monster.h Movable.h VVram.h 
Man.asm: Man.c Man.h Movable.h Stage.h Movable.h Chars.h \
	Sprite.h Movable.h ScanKeys.h Goal.h Movable.h Stage.h \
	Movable.h Vram.h Main.h Lift.h Movable.h VVram.h 
Monster.asm: Monster.c Monster.h Movable.h Stages.h Stage.h Movable.h \
	Chars.h Sprite.h Movable.h Vram.h Man.h Movable.h 
Movable.asm: Movable.c Movable.h Stage.h Movable.h Lift.h Movable.h 
Stage.asm: Stage.c Stage.h Movable.h Stages.h Stage.h Movable.h \
	Main.h Vram.h Sprite.h Movable.h Status.h CopyMemory.h \
	Man.h Movable.h Goal.h Movable.h Stage.h Movable.h \
	Lift.h Movable.h Monster.h Movable.h VVram.h 
Stages.asm: Stages.c Stage.h Movable.h Stages.h Stage.h Movable.h 
Status.asm: Status.c Status.h Vram.h Stage.h Movable.h Main.h \
	Sprite.h Movable.h Print.h Chars.h 
Vram.asm: Vram.c Vram.h Chars.h 
VVram.asm: VVram.c VVram.h Chars.h Sprite.h Movable.h Vram.h \
	Goal.h Movable.h Stage.h Movable.h 
Chars.obj: Chars.asm 
CopyMemory.obj: CopyMemory.asm 
Loader.obj: Loader.asm BinSize.inc
Print.obj: Print.asm 
ScanKeys.obj: ScanKeys.asm 
Sprite.obj: Sprite.asm Vram.inc VVram.inc 
StageA.obj: StageA.asm 
Startup.obj: Startup.asm Vram.inc 
VramA.obj: VramA.asm Vram.inc VVram.inc 
VVramA.obj: VVramA.asm Vram.inc VVram.inc Chars.inc 

objects = Startup.obj \
	Goal.obj Lift.obj Main.obj Man.obj Monster.obj Movable.obj \
	Stage.obj Stages.obj Status.obj Vram.obj VVram.obj Chars.obj \
	CopyMemory.obj Print.obj ScanKeys.obj Sprite.obj StageA.obj VramA.obj \
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
