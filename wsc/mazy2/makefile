name=mazy2

all: $(name).wsc

cseg=0000
dseg=0000

.c.asm:
	Cate86.exe -dseg $*.c

.asm.obj:
	Asm86.exe -dseg $*.asm

Knife.asm: Knife.c Knife.h Movable.h Stages.h Stage.h Sprite.h \
	Movable.h Chars.h Man.h Movable.h Main.h Status.h \
	Sound.h Math.h Monster.h Movable.h Point.h Movable.h 
Main.asm: Main.c Main.h Vram.h Chars.h Status.h ScanKeys.h \
	Stage.h Sound.h Sprite.h Movable.h Man.h Movable.h \
	Monster.h Movable.h Knife.h Movable.h Point.h Movable.h 
Man.asm: Man.c Man.h Movable.h Sprite.h Movable.h Stage.h \
	Chars.h ScanKeys.h Knife.h Movable.h Sound.h 
Monster.asm: Monster.c Monster.h Movable.h Stages.h Stage.h Sprite.h \
	Movable.h Chars.h Math.h Man.h Movable.h Knife.h \
	Movable.h Sound.h Point.h Movable.h 
Movable.asm: Movable.c Movable.h Stage.h 
Point.asm: Point.c Point.h Movable.h Sprite.h Movable.h Main.h \
	Chars.h 
Stage.asm: Stage.c Stage.h Stages.h Stage.h Main.h Sprite.h \
	Movable.h Vram.h Status.h Man.h Movable.h Chars.h \
	Monster.h Movable.h Knife.h Movable.h Point.h Movable.h 
Stages.asm: Stages.c Stage.h Stages.h Stage.h 
Status.asm: Status.c Status.h Vram.h Main.h Print.h Chars.h \
	Sprite.h Movable.h 
Vram.asm: Vram.c Vram.h 
Chars.obj: Chars.asm 
Math.obj: Math.asm 
Metadata.obj: Metadata.asm 
Print.obj: Print.asm 
ScanKeys.obj: ScanKeys.asm wsc.inc 
Sound.obj: Sound.asm wsc.inc 
Sprite.obj: Sprite.asm wsc.inc Vram.inc Chars.inc 
StageA.obj: StageA.asm 
Startup.obj: Startup.asm wsc.inc Vram.inc 
Vectors.obj: Vectors.asm 
VramA.obj: VramA.asm wsc.inc Vram.inc Chars.inc 

objects = Vectors.obj Startup.obj \
	Knife.obj Main.obj Man.obj Monster.obj Movable.obj Point.obj \
	Stage.obj Stages.obj Status.obj Vram.obj Chars.obj Math.obj \
	Print.obj ScanKeys.obj Sound.obj Sprite.obj StageA.obj VramA.obj \
	..\..\cate\cate86.lib

$(name).bin: $(objects) makefile
	LinkLE.exe -dseg $(name).bin $(cseg) $(dseg) $(objects)

Metadata.bin: Metadata.obj makefile
	LinkLE.exe Metadata.bin fff0 0000 Metadata.obj

$(name).wsc: $(name).bin  Metadata.bin wsc.csx
	dotnet script wsc.csx $(name)
