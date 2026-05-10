name=sword

all: $(name).ws

cseg=0000
dseg=0000

.c.asm:
	Cate86.exe -dseg $*.c

.asm.obj:
	Asm86.exe -v2 -dseg $*.asm

Ball.asm: Ball.c Ball.h Movable.h Stage.h Movable.h Stages.h \
	Stage.h Movable.h Sprite.h Movable.h Chars.h Enemy.h \
	Movable.h Man.h Movable.h 
Enemy.asm: Enemy.c Enemy.h Movable.h Stage.h Movable.h Monster.h \
	Movable.h Ball.h Movable.h 
Main.asm: Main.c Main.h Status.h ScanKeys.h Stage.h Movable.h \
	Sound.h Man.h Movable.h Monster.h Movable.h Ball.h \
	Movable.h Point.h Movable.h 
Man.asm: Man.c Man.h Movable.h Stage.h Movable.h Sprite.h \
	Movable.h Chars.h ScanKeys.h Sound.h Monster.h Movable.h \
	Status.h Main.h Point.h Movable.h OneUp.h Movable.h 
Monster.asm: Monster.c Monster.h Movable.h Stage.h Movable.h Stages.h \
	Stage.h Movable.h Sprite.h Movable.h Chars.h Math.h \
	Man.h Movable.h Enemy.h Movable.h Sound.h Point.h \
	Movable.h OneUp.h Movable.h 
Movable.asm: Movable.c Movable.h Stage.h Movable.h 
OneUp.asm: OneUp.c OneUp.h Movable.h Sprite.h Movable.h Chars.h \
	Math.h Main.h Stage.h Movable.h Sound.h Status.h 
Point.asm: Point.c Point.h Movable.h Sprite.h Movable.h Chars.h \
	Main.h 
Stage.asm: Stage.c Stage.h Movable.h Stages.h Stage.h Movable.h \
	Main.h Vram.h Chars.h Man.h Movable.h Monster.h \
	Movable.h Ball.h Movable.h Status.h Point.h Movable.h \
	Math.h OneUp.h Movable.h 
Stages.asm: Stages.c Stage.h Movable.h Stages.h Stage.h Movable.h 
Status.asm: Status.c Status.h Vram.h Main.h Sprite.h Movable.h \
	Print.h Chars.h 
Vram.asm: Vram.c Vram.h Chars.h 
Chars.obj: Chars.asm 
Math.obj: Math.asm 
Metadata.obj: Metadata.asm 
Print.obj: Print.asm 
ScanKeys.obj: ScanKeys.asm ws.inc 
Sound.obj: Sound.asm ws.inc 
Sprite.obj: Sprite.asm ws.inc Vram.inc Chars.inc Sprite.inc 
StageA.obj: StageA.asm Vram.inc Chars.inc 
Startup.obj: Startup.asm ws.inc Vram.inc 
Vectors.obj: Vectors.asm 
VramA.obj: VramA.asm ws.inc Vram.inc Chars.inc 

objects = Vectors.obj Startup.obj \
	Ball.obj Enemy.obj Main.obj Man.obj Monster.obj Movable.obj \
	OneUp.obj Point.obj Stage.obj Stages.obj Status.obj Vram.obj \
	Chars.obj Math.obj Print.obj ScanKeys.obj Sound.obj Sprite.obj \
	StageA.obj VramA.obj \
	..\..\cate\cate86.lib

$(name).bin: $(objects) makefile
	LinkLE.exe -dseg $(name).bin $(cseg) $(dseg) $(objects)

Metadata.bin: Metadata.obj makefile
	LinkLE.exe Metadata.bin fff0 0000 Metadata.obj

$(name).ws: $(name).bin  Metadata.bin ws.csx
	dotnet script ws.csx $(name)
