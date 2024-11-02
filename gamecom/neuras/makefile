name=neuras

all: $(name).bin

cseg=2000-2053,4000-9fff,2054-3fda,3fdc
dseg=0200
zseg=00d0

.c.asm:
	Cate85.exe $*.c

.asm.obj:
	Asm85.exe $*.asm

Card.asm: Card.c Card.h Stage.h Solver.h Monster.h Stage.h \
	Main.h Chars.h VVram.h Sprite.h Status.h Sound.h \
	Vram.h 
Main.asm: Main.c Main.h Stage.h ScanKeys.h Solver.h Card.h \
	Stage.h Monster.h Stage.h Status.h Sprite.h Vram.h \
	Sound.h 
MapToVVram.asm: MapToVVram.c MapToVVram.h Vram.h Stage.h Chars.h VVram.h 
Monster.asm: Monster.c Monster.h Stage.h Sprite.h Chars.h Solver.h 
Solver.asm: Solver.c Solver.h ScanKeys.h Chars.h Sprite.h Stage.h \
	Card.h Stage.h Sound.h Vram.h Monster.h Stage.h 
Stage.asm: Stage.c Stage.h Stages.h MapToVVram.h Solver.h Card.h \
	Stage.h Monster.h Stage.h Sprite.h Vram.h 
Stages.asm: Stages.c Stage.h Stages.h 
Status.asm: Status.c Status.h Vram.h Main.h Sprite.h Print.h \
	Chars.h Stage.h Card.h Stage.h 
Vram.asm: Vram.c Vram.h Sprite.h Chars.h 
VVram.asm: VVram.c VVram.h Chars.h 
Print.obj: Print.asm 
RomChars.obj: RomChars.asm 
RomHead.obj: RomHead.asm 
ScanKeys.obj: ScanKeys.asm GameCom.inc 
Sound.obj: Sound.asm GameCom.inc 
Sprite.obj: Sprite.asm GameCom.inc Vram.inc VVram.inc 
Startup.obj: Startup.asm GameCom.inc Vram.inc 
Vectors.obj: Vectors.asm 
VramA.obj: VramA.asm GameCom.inc Vram.inc VVram.inc 
VVramA.obj: VVramA.asm VVram.inc 

objects = Vectors.obj RomHead.obj RomChars.obj Startup.obj \
	Card.obj Main.obj MapToVVram.obj Monster.obj Solver.obj Stage.obj \
	Stages.obj Status.obj Vram.obj VVram.obj Print.obj ScanKeys.obj \
	Sound.obj Sprite.obj VramA.obj VVramA.obj \
	..\..\cate\cate85.lib

_.bin: $(objects) makefile
	LinkBE.exe _.bin $(cseg) $(dseg) $(zseg) $(objects)
	copy _.symbols.txt $(name).symbols.txt /y

$(name).bin: _.bin MakeRom.csx
	dotnet script MakeRom.csx $(name)
