name=neuras

all: $(name).wav

cseg=4000
dseg=8100

.c.asm:
	Cate80.exe $*.c

.asm.obj:
	Asm80.exe $*.asm

Card.asm: Card.c Card.h Stage.h Solver.h Monster.h Stage.h \
	Main.h Chars.h Vram.h Sprite.h Status.h Sound.h 
Main.asm: Main.c Main.h Stage.h ScanKeys.h Solver.h Card.h \
	Stage.h Monster.h Stage.h Status.h Sprite.h Vram.h \
	Sound.h 
MapToBackgnd.asm: MapToBackgnd.c MapToBackgnd.h Vram.h Stage.h Chars.h 
Monster.asm: Monster.c Monster.h Stage.h Sprite.h Chars.h Solver.h 
Solver.asm: Solver.c Solver.h ScanKeys.h Chars.h Sprite.h Stage.h \
	Card.h Stage.h Sound.h Vram.h Monster.h Stage.h 
Stage.asm: Stage.c Stage.h Stages.h MapToBackgnd.h Solver.h Card.h \
	Stage.h Monster.h Stage.h Sprite.h 
Stages.asm: Stages.c Stage.h Stages.h 
Status.asm: Status.c Status.h Vram.h Stage.h Main.h Sprite.h \
	Card.h Stage.h Chars.h Print.h 
Vram.asm: Vram.c Vram.h Chars.h 
Chars.obj: Chars.asm 
FixedCode.obj: FixedCode.asm 
Plus.obj: Plus.asm 
Print.obj: Print.asm 
ScanKeys.obj: ScanKeys.asm 
Sound.obj: Sound.asm 
Sprite.obj: Sprite.asm Vram.inc Chars.inc FixedCode.inc 
Startup.obj: Startup.asm FixedCode.inc 
VramA.obj: VramA.asm Vram.inc Chars.inc 

objects = Startup.obj \
	Card.obj Main.obj MapToBackgnd.obj Monster.obj Solver.obj Stage.obj \
	Stages.obj Status.obj Vram.obj Chars.obj FixedCode.obj Print.obj \
	ScanKeys.obj Sound.obj Sprite.obj VramA.obj \
	..\..\cate\cate80.lib

$(name).bin: $(objects) makefile
	LinkLE.exe $(name).bin $(cseg) $(dseg) $(objects)

FixedCode.bin: Plus.obj makefile
	LinkLE.exe FixedCode.bin 8000 b000 Plus.obj

FixedCode.asm FixedCode.inc: FixedCode.bin BinAsm.csx
	dotnet script BinAsm.csx

$(name).cdt: $(name).bin loader.bas
	2cdt.exe -n -r $(name) loader.bas $(name).cdt
	2cdt.exe -r BIN $(name).bin $(name).cdt

$(name).wav: $(name).cdt
	TZX2WAV $(name).cdt $(name).wav
