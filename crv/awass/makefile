name=awass

all: $(name).rom

cseg=bfe8-bfff,8000
dseg=0200-3ff,0040
zseg=0000

.c.asm:
	Cate65.exe -v2 $*.c

.asm.obj:
	Asm65.exe -v2 $*.asm

Bang.asm: Bang.c Bang.h Movable.h Vram.h Sprite.h Movable.h \
	Stage.h Chars.h 
Flag.asm: Flag.c Flag.h Stage.h Man.h Movable.h Main.h \
	Sound.h Vram.h Point.h Movable.h Chars.h 
Main.asm: Main.c Main.h Status.h ScanKeys.h Stage.h Sound.h \
	Sprite.h Movable.h Flag.h Man.h Movable.h Monster.h \
	Movable.h Point.h Movable.h Bang.h Movable.h 
Man.asm: Man.c Man.h Movable.h Sprite.h Movable.h Chars.h \
	Stage.h ScanKeys.h Sound.h Flag.h 
Monster.asm: Monster.c Monster.h Movable.h Stage.h Stages.h Stage.h \
	Sprite.h Movable.h Chars.h Math.h Man.h Movable.h \
	Main.h Sound.h Point.h Movable.h 
Movable.asm: Movable.c Movable.h Stage.h 
Point.asm: Point.c Point.h Movable.h Sprite.h Movable.h Chars.h \
	Main.h 
Stage.asm: Stage.c Stage.h Stages.h Stage.h Main.h Flag.h \
	Math.h Vram.h Status.h Man.h Movable.h Monster.h \
	Movable.h Point.h Movable.h Bang.h Movable.h 
Stages.asm: Stages.c Stage.h Stages.h Stage.h 
Status.asm: Status.c Status.h Vram.h Main.h Print.h Chars.h \
	Sprite.h Movable.h 
Vram.asm: Vram.c Vram.h Chars.h 
Chars.obj: Chars.asm 
Math.obj: Math.asm 
Print.obj: Print.asm 
RomTail.obj: RomTail.asm Vram.inc 
ScanKeys.obj: ScanKeys.asm ZeroPage.inc Port.inc 
Sound.obj: Sound.asm ZeroPage.inc Port.inc 
Sprite.obj: Sprite.asm ZeroPage.inc Port.inc Vram.inc Chars.inc Sprite.inc 
StageA.obj: StageA.asm ZeroPage.inc Port.inc Vram.inc Chars.inc 
Startup.obj: Startup.asm Port.inc Vram.inc 
VramA.obj: VramA.asm ZeroPage.inc Port.inc Vram.inc Chars.inc 
ZeroPage.obj: ZeroPage.asm 

objects = RomTail.obj Startup.obj \
	Bang.obj Flag.obj Main.obj Man.obj Monster.obj Movable.obj \
	Point.obj Stage.obj Stages.obj Status.obj Vram.obj Chars.obj \
	Math.obj Print.obj ScanKeys.obj Sound.obj Sprite.obj StageA.obj \
	VramA.obj ZeroPage.obj \
	..\..\cate\cate65.lib

$(name).rom: $(objects) makefile
	LinkLE.exe $(name).rom $(cseg) $(dseg) $(zseg) $(objects)
