name=neuras

all:$(name).dsk

cseg=4000
zseg=00e0-00ff,0000
dseg=1000

.c.asm:
	Cate65.exe $*.c

.asm.obj:
	Asm65.exe $*.asm

Card.asm: Card.c Card.h Stage.h Solver.h Monster.h Stage.h \
	Main.h Chars.h Vram.h Sprite.h Status.h Sound.h \
	VVram.h 
Main.asm: Main.c Stage.h ScanKeys.h Solver.h Card.h Stage.h \
	Monster.h Stage.h Status.h Sprite.h Vram.h Sound.h \
	VVram.h 
Monster.asm: Monster.c Monster.h Stage.h Sprite.h Chars.h Solver.h \
	Sound.h 
Solver.asm: Solver.c Solver.h ScanKeys.h Chars.h Sprite.h Stage.h \
	Card.h Stage.h Sound.h VVram.h Monster.h Stage.h 
Sprite.asm: Sprite.c Sprite.h Vram.h Stage.h Chars.h VVram.h 
Stage.asm: Stage.c Stage.h Stages.h VVram.h Vram.h Solver.h \
	Card.h Stage.h Monster.h Stage.h Sprite.h 
Stages.asm: Stages.c Stage.h Stages.h 
Status.asm: Status.c Status.h Vram.h Stage.h Main.h Sprite.h \
	Card.h Stage.h Chars.h Print.h 
Vram.asm: Vram.c Vram.h Chars.h 
VVram.asm: VVram.c VVram.h Vram.h Sprite.h Chars.h Stage.h \
	Sound.h 
Chars.obj: Chars.asm 
CopyMemory.obj: CopyMemory.asm ZeroPage.inc 
Loader.obj: Loader.asm BinSize.inc
Print.obj: Print.asm 
ScanKeys.obj: ScanKeys.asm Apple2.inc ZeroPage.inc 
Sound.obj: Sound.asm Apple2.inc ZeroPage.inc 
Startup.obj: Startup.asm Apple2.inc 
VramA.obj: VramA.asm Zeropage.inc Vram.inc VVram.inc Chars.inc 
VVramA.obj: VVramA.asm ZeroPage.inc VVram.inc 
ZeroPage.obj: ZeroPage.asm 

objects = Startup.obj \
	Card.obj Main.obj Monster.obj Solver.obj Sprite.obj Stage.obj \
	Stages.obj Status.obj Vram.obj VVram.obj Chars.obj CopyMemory.obj \
	Print.obj ScanKeys.obj Sound.obj VramA.obj VVramA.obj ZeroPage.obj \
	..\..\cate\cate65.lib

$(name).bin: $(objects) makefile
	LinkLE.exe $(name).bin $(cseg) $(dseg) $(zseg) $(objects)

BinSize.inc: $(name).bin BinSize.csx
	dotnet script BinSize.csx $(name) $(cseg)

Loader.bin: Loader.obj BinSize.inc makefile 
	LinkLE.exe Loader.bin 0800 08f0 00e0 Loader.obj

$(name).dsk: $(name).bin Loader.bin Disk.csx
	dotnet script Disk.csx $(name)
