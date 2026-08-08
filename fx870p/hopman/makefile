name=hopman

all: $(name).pbf Clear.bas loader.bas $(name).bas

cseg=1cd0 # MODE110(7376)
dseg=3800

.c.asm:
	Cate61h.exe $*.c

.asm.obj:
	Asm61h.exe $*.asm

Goal.asm: Goal.c Goal.h Movable.h Stage.h Movable.h Vram.h \
	Sprite.h Movable.h VVram.h 
Lift.asm: Lift.c Lift.h Movable.h Stages.h Stage.h Movable.h \
	Sprite.h Movable.h Vram.h Man.h Movable.h 
Main.asm: Main.c Main.h ScanKeys.h Vram.h Sound.h Sprite.h \
	Movable.h Status.h Stage.h Movable.h Man.h Movable.h \
	Lift.h Movable.h Monster.h Movable.h VVram.h 
Man.asm: Man.c Man.h Movable.h Stage.h Movable.h Sprite.h \
	Movable.h ScanKeys.h Goal.h Movable.h Stage.h Movable.h \
	Vram.h Vram.h Main.h Lift.h Movable.h VVram.h \
	Sound.h 
Monster.asm: Monster.c Monster.h Movable.h Stages.h Stage.h Movable.h \
	Sprite.h Movable.h Vram.h Man.h Movable.h 
Movable.asm: Movable.c Movable.h Stage.h Movable.h Lift.h Movable.h 
Stage.asm: Stage.c Stage.h Movable.h Stages.h Stage.h Movable.h \
	Main.h Vram.h Sprite.h Movable.h Status.h CopyMemory.h \
	Man.h Movable.h Goal.h Movable.h Stage.h Movable.h \
	Vram.h Lift.h Movable.h Monster.h Movable.h VVram.h 
Stages.asm: Stages.c Stage.h Movable.h Stages.h Stage.h Movable.h 
Status.asm: Status.c Status.h Vram.h Main.h Sprite.h Movable.h \
	Print.h Man.h Movable.h 
Vram.asm: Vram.c Vram.h 
VVram.asm: VVram.c VVram.h Sprite.h Movable.h Vram.h Goal.h \
	Movable.h Stage.h Movable.h Vram.h Sound.h 
CopyMemory.obj: CopyMemory.asm 
Loader.obj: Loader.asm 
Print.obj: Print.asm 
ScanKeys.obj: ScanKeys.asm 
Sound.obj: Sound.asm 
Sprite.obj: Sprite.asm Vram.inc VVram.inc 
StageA.obj: StageA.asm 
Startup.obj: Startup.asm 
VramA.obj: VramA.asm Vram.inc VVram.inc 
VVramA.obj: VVramA.asm VVram.inc Vram.inc 

objects = Startup.obj \
	Goal.obj Lift.obj Main.obj Man.obj Monster.obj Movable.obj \
	Stage.obj Stages.obj Status.obj Vram.obj VVram.obj CopyMemory.obj \
	Print.obj ScanKeys.obj Sound.obj Sprite.obj StageA.obj VramA.obj \
	VVramA.obj \
	..\..\cate\cate61h.lib

$(name).bin: $(objects) makefile
	LinkLE.exe $(name).bin $(cseg) $(dseg) $(objects)

$(name).pbf: $(objects) makefile
	LinkLE.exe $(name).pbf $(cseg) $(dseg) $(objects)

loader.bin: loader.obj makefile
	LinkLE.exe loader.bin $(dseg) $(dseg) loader.obj

$(name).bas: $(name).bin BinBas.csx loader.bin makefile
	dotnet script BinBas.csx $(name) $(cseg) $(dseg)

Clear.bas: $(name).bin Clear.csx makefile
	dotnet script Clear.csx $(name)

loader.bas: Makeloader.csx $(name).bin loader.bin makefile
	dotnet script Makeloader.csx $(name) $(cseg) $(dseg)
