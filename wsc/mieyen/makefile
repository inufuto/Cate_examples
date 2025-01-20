name=mieyen

all: $(name).wsc

cseg=0000
dseg=0000

.c.asm:
	Cate86.exe -dseg $*.c

.asm.obj:
	Asm86.exe -dseg $*.asm

Fire.asm: Fire.c Fire.h Movable.h Sprite.h Movable.h Sound.h \
	Chars.h Man.h Movable.h Monster.h Movable.h Point.h \
	Movable.h 
Main.asm: Main.c Main.h Status.h ScanKeys.h Stage.h Sprite.h \
	Movable.h Sound.h Man.h Movable.h Monster.h Movable.h \
	Fire.h Movable.h Point.h Movable.h 
Man.asm: Man.c Man.h Movable.h Sprite.h Movable.h Chars.h \
	Stage.h ScanKeys.h Sound.h Fire.h Movable.h Main.h 
Monster.asm: Monster.c Monster.h Movable.h Stage.h Stages.h Stage.h \
	Sprite.h Movable.h Chars.h Math.h Status.h Main.h \
	Sound.h Man.h Movable.h 
Movable.asm: Movable.c Movable.h Stage.h Sprite.h Movable.h 
Point.asm: Point.c Point.h Movable.h Sprite.h Movable.h Main.h \
	Chars.h 
Stage.asm: Stage.c Stage.h Stages.h Stage.h Main.h Math.h \
	Sprite.h Movable.h Status.h Chars.h Vram.h CopyMemory.h \
	Man.h Movable.h Monster.h Movable.h Fire.h Movable.h \
	Point.h Movable.h 
Stages.asm: Stages.c Stage.h Stages.h Stage.h 
Status.asm: Status.c Status.h Vram.h Main.h Sprite.h Movable.h \
	Print.h Chars.h 
Vram.asm: Vram.c Vram.h Chars.h 
Chars.obj: Chars.asm 
CopyMemory.obj: CopyMemory.asm 
Math.obj: Math.asm 
Metadata.obj: Metadata.asm 
Print.obj: Print.asm 
ScanKeys.obj: ScanKeys.asm wsc.inc 
Sound.obj: Sound.asm wsc.inc 
Sprite.obj: Sprite.asm wsc.inc Vram.inc 
StageA.obj: StageA.asm 
Startup.obj: Startup.asm wsc.inc Vram.inc 
Vectors.obj: Vectors.asm 
VramA.obj: VramA.asm wsc.inc Vram.inc Chars.inc 

objects = Vectors.obj Startup.obj \
	Fire.obj Main.obj Man.obj Monster.obj Movable.obj Point.obj \
	Stage.obj Stages.obj Status.obj Vram.obj Chars.obj CopyMemory.obj \
	Math.obj Print.obj ScanKeys.obj Sound.obj Sprite.obj StageA.obj \
	VramA.obj \
	..\..\cate\cate86.lib

$(name).bin: $(objects) makefile
	LinkLE.exe -dseg $(name).bin $(cseg) $(dseg) $(objects)

Metadata.bin: Metadata.obj makefile
	LinkLE.exe Metadata.bin fff0 0000 Metadata.obj

$(name).wsc: $(name).bin  Metadata.bin wsc.csx
	dotnet script wsc.csx $(name)
