name=neuras

all: $(name).rom

cseg=0400
dseg=3000

.c.asm:
	Cate86.exe $*.c

.asm.obj:
	Asm86.exe $*.asm

Card.asm: Card.c Card.h Stage.h Solver.h Monster.h Stage.h \
	Main.h Chars.h VVram.h Sprite.h Status.h Sound.h \
	Vram.h 
Main.asm: Main.c Main.h Stage.h ScanKeys.h Solver.h Card.h \
	Stage.h Monster.h Stage.h Status.h Sprite.h Vram.h \
	Sound.h 
MapToBackgnd.asm: MapToBackgnd.c MapToBackgnd.h VVram.h Stage.h Chars.h 
Monster.asm: Monster.c Monster.h Stage.h Sprite.h Chars.h Solver.h 
Print.asm: Print.c Print.h Vram.h 
Solver.asm: Solver.c Solver.h ScanKeys.h Chars.h Sprite.h Stage.h \
	Card.h Stage.h Sound.h Vram.h Monster.h Stage.h 
Sprite.asm: Sprite.c Sprite.h Vram.h VVram.h 
Stage.asm: Stage.c Stage.h Stages.h MapToBackgnd.h Vram.h Solver.h \
	Card.h Stage.h Monster.h Stage.h Sprite.h 
Stages.asm: Stages.c Stage.h Stages.h 
Status.asm: Status.c Status.h Vram.h Stage.h Main.h Sprite.h \
	Card.h Stage.h Chars.h Print.h 
Vram.asm: Vram.c Vram.h Chars.h Sprite.h Sound.h 
VVram.asm: VVram.c VVram.h Chars.h 
Chars.obj: Chars.asm 
Loader.obj: Loader.asm Pasogo.inc BinSize.inc 
Reset.obj: Reset.asm 
ScanKeys.obj: ScanKeys.asm Pasogo.inc 
Sound.obj: Sound.asm Pasogo.inc 
Startup.obj: Startup.asm Pasogo.inc 
VramA.obj: VramA.asm Pasogo.inc Vram.inc VVram.inc Chars.inc 
VVramA.obj: VVramA.asm VVram.inc 

objects = Startup.obj \
	Card.obj Main.obj MapToBackgnd.obj Monster.obj Print.obj Solver.obj \
	Sprite.obj Stage.obj Stages.obj Status.obj Vram.obj VVram.obj \
	Chars.obj ScanKeys.obj Sound.obj VramA.obj VVramA.obj \
	..\..\cate\cate86.lib

$(name).bin: $(objects) makefile
	LinkLE.exe $(name).bin $(cseg) $(dseg) $(objects)

BinSize.inc: $(name).bin BinSize.csx makefile
	dotnet script BinSize.csx $(name)

Reset.bin: Reset.obj makefile
	LinkLE.exe Reset.bin fff0 0000 Reset.obj

Loader.bin: Loader.obj makefile
	LinkLE.exe Loader.bin 0000 0000 Loader.obj

$(name).rom: $(name).bin  Loader.bin Reset.bin MakeRom.csx
	dotnet script MakeRom.csx $(name)
