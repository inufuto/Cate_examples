name=mazy2

tap=$(name).tap

all: $(tap)

cseg=0500 # sys 1280
dseg=3700
zseg=0010

.c.asm:
	Cate65.exe -v2 $*.c

.asm.obj:
	Asm65.exe $*.asm

Knife.asm: Knife.c Knife.h Movable.h Stages.h Stage.h Sprite.h \
	Movable.h Man.h Movable.h Main.h Status.h Sound.h \
	Math.h Monster.h Movable.h Point.h Movable.h 
Main.asm: Main.c Main.h Vram.h Status.h ScanKeys.h Stage.h \
	Sound.h Sprite.h Movable.h Man.h Movable.h Monster.h \
	Movable.h Knife.h Movable.h Point.h Movable.h VVram.h 
Man.asm: Man.c Man.h Movable.h Sprite.h Movable.h Stage.h \
	ScanKeys.h Knife.h Movable.h Sound.h VVram.h 
Monster.asm: Monster.c Monster.h Movable.h Stages.h Stage.h Sprite.h \
	Movable.h Math.h Man.h Movable.h Knife.h Movable.h \
	Sound.h Point.h Movable.h 
Movable.asm: Movable.c Movable.h Stage.h 
Point.asm: Point.c Point.h Movable.h Sprite.h Movable.h Main.h \
	VVram.h 
Sprite.asm: Sprite.c Sprite.h Movable.h VVram.h Vram.h 
Stage.asm: Stage.c Stage.h Stages.h Stage.h Main.h Sprite.h \
	Movable.h VVram.h Status.h Man.h Movable.h Monster.h \
	Movable.h Knife.h Movable.h Point.h Movable.h Vram.h 
Stages.asm: Stages.c Stage.h Stages.h Stage.h 
Status.asm: Status.c Status.h Vram.h Stage.h Main.h Sprite.h \
	Movable.h Print.h Man.h Movable.h 
Vram.asm: Vram.c Vram.h 
VVram.asm: VVram.c VVram.h Sprite.h Movable.h Vram.h Point.h \
	Movable.h 
Math.obj: Math.asm 
Print.obj: Print.asm 
ScanKeys.obj: ScanKeys.asm 
Sound.obj: Sound.asm 
StageA.obj: StageA.asm ZeroPage.inc 
Startup.obj: Startup.asm 
VramA.obj: VramA.asm Zeropage.inc Vram.inc VVram.inc 
VVramA.obj: VVramA.asm ZeroPage.inc VVram.inc 
ZeroPage.obj: ZeroPage.asm 

objects = Startup.obj \
	Knife.obj Main.obj Man.obj Monster.obj Movable.obj Point.obj \
	Sprite.obj Stage.obj Stages.obj Status.obj Vram.obj VVram.obj \
	Math.obj Print.obj ScanKeys.obj Sound.obj StageA.obj VramA.obj \
	VVramA.obj ZeroPage.obj \
	..\..\cate\cate65.lib

$(name).t64: $(objects) makefile
	linkLE.exe $(name).t64 $(cseg) $(dseg) $(zseg) $(objects)

$(tap): $(name).t64
	prg2wav -s -m c64ntsc -0  $(tap) $(name).t64
