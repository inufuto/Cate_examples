name=neuras

all: $(name).rom debug.bin

cseg=9000
dseg=b800

.c.asm:
	Cate80.exe $*.c

.asm.obj:
	Asm80.exe $*.asm

Card.asm: Card.c Card.h Stage.h Solver.h Monster.h Stage.h \
	Main.h Chars.h Vram.h Sprite.h Status.h VVram.h 
Main.asm: Main.c Main.h Stage.h ScanKeys.h Solver.h Card.h \
	Stage.h Monster.h Stage.h Status.h Sprite.h Vram.h \
	VVram.h 
MapToVVram.asm: MapToVVram.c MapToVVram.h Vram.h Stage.h Chars.h VVram.h 
Monster.asm: Monster.c Monster.h Stage.h Sprite.h Chars.h Solver.h \
	Main.h 
Solver.asm: Solver.c Solver.h ScanKeys.h Chars.h Sprite.h Stage.h \
	Card.h Stage.h Vram.h Monster.h Stage.h VVram.h \
	Main.h 
Sprite.asm: Sprite.c Sprite.h Vram.h Stage.h Chars.h VVram.h 
Stage.asm: Stage.c Stage.h Stages.h MapToVVram.h Vram.h Solver.h \
	Card.h Stage.h Monster.h Stage.h Sprite.h VVram.h 
Stages.asm: Stages.c Stage.h Stages.h 
Status.asm: Status.c Status.h Vram.h Stage.h Main.h Sprite.h \
	Print.h Chars.h Card.h Stage.h 
Vram.asm: Vram.c Vram.h Chars.h 
VVram.asm: VVram.c Vram.h VVram.h Chars.h Sprite.h 
Chars.obj: Chars.asm 
Loader.obj: Loader.asm BinSize.inc 
Print.obj: Print.asm 
ScanKeys.obj: ScanKeys.asm 
Startup.obj: Startup.asm Vram.inc 
VramA.obj: VramA.asm Vram.inc VVram.inc 
VVramA.obj: VVramA.asm Vram.inc VVram.inc 

objects = Startup.obj \
	Card.obj Main.obj MapToVVram.obj Monster.obj Solver.obj Sprite.obj \
	Stage.obj Stages.obj Status.obj Vram.obj VVram.obj Chars.obj \
	Print.obj ScanKeys.obj VramA.obj VVramA.obj \
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
