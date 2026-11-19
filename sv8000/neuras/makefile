name=neuras

all: $(name).bin

cseg=0000-1fff,4000
dseg=8000

.c.asm:
	Cate80.exe $*.c

.asm.obj:
	Asm80.exe -v2 $*.asm

Card.asm: Card.c Card.h Stage.h Solver.h Monster.h Stage.h \
	Main.h Chars.h Vram.h Sprite.h Status.h Sound.h 
Main.asm: Main.c Stage.h ScanKeys.h Solver.h Card.h Stage.h \
	Monster.h Stage.h Status.h Sprite.h Vram.h Sound.h 
Monster.asm: Monster.c Monster.h Stage.h Sprite.h Chars.h Solver.h \
	Sound.h 
Solver.asm: Solver.c Solver.h ScanKeys.h Chars.h Sprite.h Stage.h \
	Card.h Stage.h Sound.h Vram.h Monster.h Stage.h 
Sprite.asm: Sprite.c Sprite.h Vram.h Stage.h Chars.h 
Stage.asm: Stage.c Stage.h Stages.h Vram.h Solver.h Card.h \
	Stage.h Monster.h Stage.h Sprite.h Chars.h 
Stages.asm: Stages.c Stage.h Stages.h 
Status.asm: Status.c Status.h Vram.h Main.h Print.h Chars.h \
	Stage.h Card.h Stage.h 
Vram.asm: Vram.c Vram.h Chars.h Sprite.h 
Chars.obj: Chars.asm 
CopyMemory.obj: CopyMemory.asm 
Print.obj: Print.asm 
ScanKeys.obj: ScanKeys.asm sv8000.inc 
Sound.obj: Sound.asm sv8000.inc 
Startup.obj: Startup.asm sv8000.inc 
VramA.obj: VramA.asm sv8000.inc Vram.inc 

objects = Startup.obj \
	Card.obj Main.obj Monster.obj Solver.obj Sprite.obj Stage.obj \
	Stages.obj Status.obj Vram.obj Chars.obj CopyMemory.obj Print.obj \
	ScanKeys.obj Sound.obj VramA.obj \
	..\..\cate\cate80.lib

_.bin: $(objects) makefile
	LinkLE.exe _.bin $(cseg) $(dseg) $(objects)
	copy _.symbols.txt $(name).symbols.txt /y

$(name).bin: _.bin Divide.csx
	dotnet script Divide.csx $(name)
