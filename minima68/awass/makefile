name=awass

filename=$(name).bin

all: $(filename)

cseg=0100
dseg=3000
zseg=0000

.c.asm:
	Cate68.exe $*.c

.asm.obj:
	Asm68.exe -v2 $*.asm

Bang.asm: Bang.c Bang.h Movable.h Vram.h Sprite.h Movable.h \
	Stage.h Chars.h 
Flag.asm: Flag.c Flag.h Stage.h Man.h Movable.h Main.h \
	Sound.h Vram.h Point.h Movable.h Chars.h 
Main.asm: Main.c Main.h Status.h ScanKeys.h Stage.h Sound.h \
	Vram.h Flag.h Man.h Movable.h Monster.h Movable.h \
	Point.h Movable.h Bang.h Movable.h 
Man.asm: Man.c Man.h Movable.h Sprite.h Movable.h Chars.h \
	Stage.h ScanKeys.h Sound.h Flag.h Vram.h 
Monster.asm: Monster.c Monster.h Movable.h Stage.h Stages.h Stage.h \
	Sprite.h Movable.h Chars.h Math.h Man.h Movable.h \
	Main.h Sound.h Point.h Movable.h 
Movable.asm: Movable.c Movable.h Stage.h 
Point.asm: Point.c Point.h Movable.h Sprite.h Movable.h Chars.h \
	Main.h 
Stage.asm: Stage.c Stage.h Stages.h Stage.h Main.h Flag.h \
	Math.h Vram.h Status.h Man.h Movable.h Monster.h \
	Movable.h Point.h Movable.h Bang.h Movable.h Sprite.h \
	Movable.h 
Stages.asm: Stages.c Stage.h Stages.h Stage.h 
Status.asm: Status.c Status.h Vram.h Main.h Print.h Chars.h \
	Sprite.h Movable.h 
Vram.asm: Vram.c Vram.h Chars.h 
Chars.obj: Chars.asm 
Math.obj: Math.asm Direct.inc 
Print.obj: Print.asm 
ScanKeys.obj: ScanKeys.asm 
Sound.obj: Sound.asm 
Sprite.obj: Sprite.asm Direct.inc  Vram.inc 
StageA.obj: StageA.asm Direct.inc  Vram.inc Chars.inc 
Startup.obj: Startup.asm Vram.inc 
VramA.obj: VramA.asm Direct.inc  Vram.inc Chars.inc 

objects = Startup.obj \
	Bang.obj Flag.obj Main.obj Man.obj Monster.obj Movable.obj \
	Point.obj Stage.obj Stages.obj Status.obj Vram.obj Chars.obj \
	Math.obj Print.obj ScanKeys.obj Sound.obj Sprite.obj StageA.obj \
	VramA.obj \
	..\..\cate\cate68.lib

$(filename): $(objects) makefile
	LinkBE.exe $(filename) $(cseg) $(dseg) $(zseg) $(objects)
