name=neuras

all: $(name).bas MkBin.bas

cseg=0000
dseg=2800

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
Solver.asm: Solver.c Solver.h ScanKeys.h Chars.h Sprite.h Stage.h \
	Card.h Stage.h Sound.h Vram.h Monster.h Stage.h 
Sprite.asm: Sprite.c Sprite.h Vram.h VVram.h 
Stage.asm: Stage.c Stage.h Stages.h MapToBackgnd.h Vram.h Solver.h \
	Card.h Stage.h Monster.h Stage.h Sprite.h 
Stages.asm: Stages.c Stage.h Stages.h 
Status.asm: Status.c Status.h Vram.h Stage.h Main.h Sprite.h \
	Card.h Stage.h Chars.h Print.h 
Vram.asm: Vram.c Vram.h Chars.h Sprite.h CopyMemory.h 
VVram.asm: VVram.c VVram.h Chars.h 
Chars.obj: Chars.asm 
Print.obj: Print.asm 
ScanKeys.obj: ScanKeys.asm 
Sound.obj: Sound.asm 
Startup.obj: Startup.asm 
VramA.obj: VramA.asm Vram.inc VVram.inc Chars.inc 
VVramA.obj: VVramA.asm VVram.inc 

objects = Startup.obj \
	Card.obj Main.obj MapToBackgnd.obj Monster.obj Solver.obj Sprite.obj \
	Stage.obj Stages.obj Status.obj Vram.obj VVram.obj Chars.obj \
	Print.obj ScanKeys.obj Sound.obj VramA.obj VVramA.obj \
	..\..\cate\cate86.lib

$(name).bin: $(objects) makefile
	LinkLE.exe $(name).bin $(cseg) $(dseg) $(objects)

$(name).bas MkBin.bas: $(name).bin MakeBas.csx makefile
	dotnet script MakeBas.csx $(name)
