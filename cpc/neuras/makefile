name=neuras

all: $(name).wav

cseg=4000
dseg=9000

.c.asm:
	Cate80.exe $*.c

.asm.obj:
	Asm80.exe $*.asm

Main.asm: Main.c Stage.h Solver.h Card.h Monster.h  ScanKeys.h Vram.h Status.h Sprite.h \
	Init.h Sound.h
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
Sprite.asm: Sprite.c Sprite.h Vram.h Chars.h
Backgnd.asm: Backgnd.c Backgnd.h Vram.h Sprite.h
Status.asm: Status.c Status.h Stage.h Card.h Chars.h  Vram.h Sprite.h Backgnd.h
Init.obj: Init.asm
Vram.asm: Vram.c Vram.h Stage.h Chars.h
VramA.obj: VramA.asm 
Chars.obj: Chars.asm
ScanKeys.obj: ScanKeys.asm
Sound.obj: Sound.asm

objects= Main.obj \
	 Stage.obj Stages.obj Chars.obj Solver.obj Card.obj Monster.obj \
	Init.obj Vram.obj Backgnd.obj MapToBackgnd.obj Sprite.obj ScanKeys.obj Status.obj \
	VramA.obj Sound.obj \
	..\..\cate\cate80.lib

$(name).bin: $(objects)
	LinkLE.exe $(name).bin $(cseg) $(dseg) $(objects)

$(name).cdt: $(name).bin
	2cdt.exe -n -r $(name) loader.bas $(name).cdt
	2cdt.exe -r BIN $(name).bin $(name).cdt

$(name).wav: $(name).cdt
	TZX2WAV $(name).cdt $(name).wav
