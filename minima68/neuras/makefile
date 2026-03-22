name=neuras

filename=$(name).bin

all: $(filename)

cseg=0100
dseg=2800
zseg=0000

.c.asm:
	Cate68.exe $*.c

.asm.obj:
	Asm68.exe -v2 $*.asm

Card.asm: Card.c Card.h Stage.h Vram.h Solver.h Monster.h \
	Stage.h Vram.h Main.h Chars.h Vram.h Sprite.h \
	Status.h Sound.h 
Main.asm: Main.c Main.h Stage.h Vram.h ScanKeys.h Solver.h \
	Card.h Stage.h Vram.h Monster.h Stage.h Vram.h \
	Status.h Sprite.h Vram.h Sound.h 
MapToBackgnd.asm: MapToBackgnd.c MapToBackgnd.h Vram.h Stage.h Vram.h Chars.h 
Monster.asm: Monster.c Monster.h Stage.h Vram.h Sprite.h Chars.h \
	Solver.h 
Solver.asm: Solver.c Solver.h ScanKeys.h Chars.h Sprite.h Stage.h \
	Vram.h Card.h Stage.h Vram.h Sound.h Vram.h \
	Monster.h Stage.h Vram.h 
Stage.asm: Stage.c Stage.h Vram.h Stages.h MapToBackgnd.h Vram.h \
	Solver.h Card.h Stage.h Vram.h Monster.h Stage.h \
	Vram.h Sprite.h 
Stages.asm: Stages.c Stage.h Vram.h Stages.h 
Status.asm: Status.c Status.h Vram.h Stage.h Vram.h Main.h \
	Sprite.h Card.h Stage.h Vram.h Chars.h Print.h 
Vram.asm: Vram.c Vram.h Chars.h 
Chars.obj: Chars.asm 
Print.obj: Print.asm 
ScanKeys.obj: ScanKeys.asm 
Sound.obj: Sound.asm 
Sprite.obj: Sprite.asm Direct.inc  Vram.inc 
Startup.obj: Startup.asm Vram.inc 
VramA.obj: VramA.asm Direct.inc  Vram.inc Chars.inc 

objects = Startup.obj \
	Card.obj Main.obj MapToBackgnd.obj Monster.obj Solver.obj Stage.obj \
	Stages.obj Status.obj Vram.obj Chars.obj Print.obj ScanKeys.obj \
	Sound.obj Sprite.obj VramA.obj \
	..\..\cate\cate68.lib

$(filename): $(objects) makefile
	LinkBE.exe $(filename) $(cseg) $(dseg) $(zseg) $(objects)
