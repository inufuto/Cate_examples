name=neuras

all: $(name).d88

cseg=4000
zseg=6800 
dseg=6900

.c.asm:
	Cate09.exe $*.c

.asm.obj:
	Asm09.exe $*.asm

Card.asm: Card.c Card.h Stage.h Solver.h Monster.h Stage.h \
	Main.h Chars.h VVram.h Sprite.h Status.h Sound.h \
	Vram.h 
Main.asm: Main.c Main.h Stage.h ScanKeys.h Solver.h Card.h \
	Stage.h Monster.h Stage.h Status.h Sprite.h Vram.h \
	Sound.h 
MapToBackgnd.asm: MapToBackgnd.c MapToBackgnd.h VVram.h Stage.h Chars.h 
Monster.asm: Monster.c Monster.h Stage.h Sprite.h Chars.h Solver.h 
Solver.asm: Solver.c Solver.h ScanKeys.h Chars.h Sprite.h Stage.h \
	Card.h Stage.h Sound.h Vram.h Monster.h Stage.h 
Sprite.asm: Sprite.c Sprite.h Vram.h VVram.h 
Stage.asm: Stage.c Stage.h Stages.h MapToBackgnd.h Vram.h Solver.h \
	Card.h Stage.h Monster.h Stage.h Sprite.h 
Stages.asm: Stages.c Stage.h Stages.h 
Status.asm: Status.c Status.h Vram.h Stage.h Main.h Sprite.h \
	Card.h Stage.h Chars.h Print.h 
Vram.asm: Vram.c Vram.h Chars.h Sprite.h 
VVram.asm: VVram.c VVram.h Chars.h 
Chars.obj: Chars.asm 
Loader1.obj: Loader1.asm Loader.inc 
Loader2.obj: Loader2.asm Loader.inc BinSize.inc
LoaderSub.obj: LoaderSub.asm 
Print.obj: Print.asm 
ScanKeys.obj: ScanKeys.asm 
Sound.obj: Sound.asm 
Startup.obj: Startup.asm 
VramA.obj: VramA.asm Vram.inc VVram.inc Chars.inc 
VVramA.obj: VVramA.asm VVram.inc 
Loader.obj: Loader.asm S1.inc BinSize.inc

objects = Startup.obj \
	Card.obj Main.obj MapToBackgnd.obj Monster.obj Solver.obj Sprite.obj \
	Stage.obj Stages.obj Status.obj Vram.obj VVram.obj Chars.obj \
	Print.obj ScanKeys.obj Sound.obj VramA.obj VVramA.obj \
	..\..\cate\cate09.lib

$(name).bin: $(objects) makefile
	LinkBE.exe $(name).bin $(cseg) $(dseg) $(zseg) $(objects)

BinSize.inc: $(name).bin BinSize.csx
	dotnet script BinSize.csx $(name) $(cseg)

Loader.bin: Loader.obj makefile BinSize.inc
	LinkBE.exe Loader.bin 2000 2300 2200 Loader.obj

$(name).d88: Loader.bin $(name).bin disk.csx
	dotnet script disk.csx $(name)
