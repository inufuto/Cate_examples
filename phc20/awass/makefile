name=awass

all: $(name).rom

cseg=0000
dseg=2000

.c.asm:
	Cate80.exe $*.c

.asm.obj:
	Asm80.exe -v2 $*.asm

Bang.asm: Bang.c Bang.h Movable.h Vram.h Sprite.h Movable.h \
	Stage.h Chars.h 
Flag.asm: Flag.c Flag.h Stage.h Man.h Movable.h Main.h \
	Sound.h VVram.h Point.h Movable.h Chars.h 
Main.asm: Main.c Main.h Status.h ScanKeys.h Stage.h Sound.h \
	Sprite.h Movable.h Flag.h Man.h Movable.h Monster.h \
	Movable.h Point.h Movable.h Bang.h Movable.h Vram.h \
	Math.h 
Man.asm: Man.c Man.h Movable.h Sprite.h Movable.h Chars.h \
	Stage.h ScanKeys.h Sound.h Flag.h Vram.h 
Monster.asm: Monster.c Monster.h Movable.h Stage.h Stages.h Stage.h \
	Sprite.h Movable.h Chars.h Math.h Man.h Movable.h \
	Main.h Sound.h Point.h Movable.h 
Movable.asm: Movable.c Movable.h Stage.h 
Point.asm: Point.c Point.h Movable.h Sprite.h Movable.h Chars.h \
	Main.h 
Sprite.asm: Sprite.c Sprite.h Movable.h Chars.h VVram.h 
Stage.asm: Stage.c Stage.h Stages.h Stage.h Main.h Flag.h \
	Math.h VVram.h Status.h Man.h Movable.h Monster.h \
	Movable.h Point.h Movable.h Bang.h Movable.h Vram.h 
Stages.asm: Stages.c Stage.h Stages.h Stage.h 
Status.asm: Status.c Status.h Vram.h Main.h Movable.h Sprite.h \
	Movable.h Print.h Chars.h 
Vram.asm: Vram.c Vram.h VVram.h Chars.h Sprite.h Movable.h \
	Stage.h Sound.h 
VVram.asm: VVram.c VVram.h Sprite.h Movable.h Vram.h Chars.h 
Chars.obj: Chars.asm 
Math.obj: Math.asm 
Print.obj: Print.asm 
ScanKeys.obj: ScanKeys.asm 
Sound.obj: Sound.asm 
StageA.obj: StageA.asm VVram.inc Chars.inc 
Startup.obj: Startup.asm 
VramA.obj: VramA.asm Vram.inc VVram.inc 
VVramA.obj: VVramA.asm VVram.inc 

objects = Startup.obj \
	Bang.obj Flag.obj Main.obj Man.obj Monster.obj Movable.obj \
	Point.obj Sprite.obj Stage.obj Stages.obj Status.obj Vram.obj \
	VVram.obj Chars.obj Math.obj Print.obj ScanKeys.obj Sound.obj \
	StageA.obj VramA.obj VVramA.obj \
	..\..\cate\cate80.lib

$(name).rom: $(objects) makefile
    LinkLE.exe $(name).rom $(cseg) $(dseg) $(objects)
