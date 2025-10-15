name=neuras

all: $(name).wav loader.txt

cseg=8800
dseg=aa00
loader=8000

.c.asm:
	Cate80.exe $*.c

.asm.obj:
	Asm80.exe $*.asm

Main.asm: Main.c Stage.h Solver.h Card.h Monster.h  ScanKeys.h Vram.h Status.h \
	Sprite.h Sound.h Init.h
Stages.asm: Stages.c Stage.h Stages.h
Stage.asm: Stage.c Stage.h Stages.h Solver.h Card.h Monster.h Main.h \
	 Vram.h MapToBackgnd.h Sprite.h
Solver.asm: Solver.c Solver.h Stage.h Card.h Monster.h  Sound.h Chars.h Sprite.h Vram.h
Card.asm: Card.c Card.h Solver.h Monster.h Main.h \
	 Chars.h Backgnd.h Vram.h Sprite.h Status.h Sound.h
Card.h: Stage.h
Monster.asm: Monster.c Monster.h Solver.h  Sprite.h Chars.h Sound.h
Monster.h: Stage.h

MapToBackgnd.asm: MapToBackgnd.c MapToBackgnd.h Vram.h
Sprite.asm: Sprite.c Sprite.h Vram.h
Backgnd.asm: Backgnd.c Backgnd.h Vram.h Sprite.h
Status.asm: Status.c Status.h Stage.h Card.h Chars.h  Vram.h Sprite.h Backgnd.h
Init.obj: Init.asm
Vram.obj: Vram.asm
Chars.obj: Chars.asm
ScanKeys.obj: ScanKeys.asm
Sound.obj: Sound.asm

objects= \
	Main.obj Stage.obj Stages.obj Chars.obj Solver.obj Card.obj Monster.obj \
	Init.obj Vram.obj Backgnd.obj MapToBackgnd.obj Sprite.obj ScanKeys.obj Status.obj \
	Sound.obj \
	..\..\cate\cate80.lib

$(name).cmt: $(objects) makefile
	LinkLE.exe $(name).cmt $(cseg) $(dseg) $(objects)

$(name).wav: $(name).cmt CmtWav.csx 
	dotnet script CmtWav.csx $(name)

loader.obj: loader.asm

loader.bin: loader.obj makefile
	linkLE loader.bin $(loader) $(dseg) loader.obj

loader.txt: loader.bin loader.csx
	dotnet script loader.csx $(loader)
