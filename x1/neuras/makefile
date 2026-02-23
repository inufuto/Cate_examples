name=neuras

all: $(name).tap $(name).d88

cseg=8100
dseg=ae00 

.c.asm:
	Cate80.exe $*.c

.asm.obj:
	Asm80.exe $*.asm

Main.asm: Main.c Stage.h Solver.h Card.h Monster.h  \
	ScanKeys.h Vram.h Status.h Sprite.h Sound.h Sync.h
Stages.asm: Stages.c Stage.h Stages.h
Stage.asm: Stage.c Stage.h Stages.h Solver.h Card.h Monster.h Main.h \
	 Vram.h MapToBackgnd.h Sprite.h
Solver.asm: Solver.c Solver.h Stage.h Card.h Monster.h  Sound.h Chars.h Sprite.h Vram.h
Card.asm: Card.c Card.h Solver.h Monster.h Main.h \
	 Chars.h Vram.h Sprite.h Status.h Sound.h Backgnd.h 
Card.h: Stage.h
Monster.asm: Monster.c Monster.h Solver.h  Sprite.h Chars.h Sound.h
Monster.h: Stage.h

MapToBackgnd.asm: MapToBackgnd.c MapToBackgnd.h Vram.h Stage.h Chars.h
Sprite.asm: Sprite.c Sprite.h Vram.h Chars.h
Backgnd.asm: Backgnd.c Backgnd.h Vram.h Sprite.h
Status.asm: Status.c Status.h Stage.h Card.h Chars.h  Vram.h Sprite.h Backgnd.h
Init.obj: Init.asm X1.inc
Vram.obj: Vram.asm X1.inc Chars.inc
Chars.obj: Chars.asm
ScanKeys.obj: ScanKeys.asm X1.inc
Sound.obj: Sound.asm
Sync.obj: Sync.asm
InitCG.obj: InitCG.asm X1.inc Chars.inc

objects= \
	Main.obj Stage.obj Stages.obj Chars.obj Solver.obj Card.obj Monster.obj \
	Init.obj Vram.obj Backgnd.obj MapToBackgnd.obj Sprite.obj ScanKeys.obj Status.obj \
	Sound.obj Sync.obj InitCG.obj \
	..\..\cate\cate80.lib

$(name).bin: $(objects) makefile
	LinkLE.exe $(name).bin $(cseg) $(dseg) $(objects)

$(name).wav: $(name).bin
	..\x1tape\x1tape -file2wav -filemode ipl -start 8100 -entry 8100 $(name).bin $(name).wav

$(name).tap: $(name).wav
	..\x1tape\x1tape -wav2tap $(name).wav $(name).tap

$(name).d88: $(name).bin Disk.csx
	dotnet script Disk.csx $(name) $(cseg)
