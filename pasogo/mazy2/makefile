name=mazy2

all: $(name).rom

cseg=0400
dseg=3000

.c.asm:
	Cate86.exe $*.c

.asm.obj:
	Asm86.exe $*.asm

Knife.asm: Knife.c Knife.h Movable.h Stages.h Stage.h Sprite.h \
	Movable.h Chars.h Man.h Movable.h Main.h Status.h \
	Sound.h Math.h Monster.h Movable.h Point.h Movable.h 
Main.asm: Main.c Main.h Vram.h Chars.h Status.h ScanKeys.h \
	Stage.h Sound.h Sprite.h Movable.h Man.h Movable.h \
	Monster.h Movable.h Knife.h Movable.h Point.h Movable.h \
	VVram.h 
Man.asm: Man.c Man.h Movable.h Sprite.h Movable.h Stage.h \
	Chars.h ScanKeys.h Knife.h Movable.h Sound.h VVram.h 
Monster.asm: Monster.c Monster.h Movable.h Stages.h Stage.h Sprite.h \
	Movable.h Chars.h Math.h Man.h Movable.h Knife.h \
	Movable.h Sound.h Point.h Movable.h 
Movable.asm: Movable.c Movable.h Stage.h 
Point.asm: Point.c Point.h Movable.h Sprite.h Movable.h Main.h \
	Chars.h 
Sprite.asm: Sprite.c Movable.h Sprite.h Movable.h Vram.h 
Stage.asm: Stage.c Stage.h Stages.h Stage.h Main.h Sprite.h \
	Movable.h VVram.h Status.h Man.h Movable.h Chars.h \
	Monster.h Movable.h Knife.h Movable.h Point.h Movable.h \
	Vram.h 
Stages.asm: Stages.c Stage.h Stages.h Stage.h 
Status.asm: Status.c Status.h Vram.h Stage.h Main.h Sprite.h \
	Movable.h Print.h Chars.h 
Vram.asm: Vram.c Vram.h 
VVram.asm: VVram.c VVram.h Sprite.h Movable.h Vram.h Sound.h 
Chars.obj: Chars.asm 
Loader.obj: Loader.asm Pasogo.inc BinSize.inc 
Math.obj: Math.asm 
Print.obj: Print.asm 
Reset.obj: Reset.asm 
ScanKeys.obj: ScanKeys.asm Pasogo.inc 
Sound.obj: Sound.asm Pasogo.inc 
StageA.obj: StageA.asm 
Startup.obj: Startup.asm Pasogo.inc 
VramA.obj: VramA.asm Pasogo.inc Vram.inc VVram.inc Chars.inc 
VVramA.obj: VVramA.asm 

objects = Startup.obj \
	Knife.obj Main.obj Man.obj Monster.obj Movable.obj Point.obj \
	Sprite.obj Stage.obj Stages.obj Status.obj Vram.obj VVram.obj \
	Chars.obj Math.obj Print.obj ScanKeys.obj Sound.obj StageA.obj \
	VramA.obj VVramA.obj \
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
