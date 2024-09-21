name=osotos

all: $(name).mzt

cseg=0000
dseg=2300

.c.asm:
	Cate80.exe $*.c

.asm.obj:
	Asm80.exe $*.asm

Block.asm: Block.c Block.h Movable.h Stage.h Movable.h Stages.h \
	Stage.h Movable.h VVram.h Chars.h Sprite.h Movable.h \
	Man.h Movable.h Monster.h Movable.h Point.h Movable.h \
	Sound.h 
Main.asm: Main.c Main.h ScanKeys.h Vram.h Sound.h Sprite.h \
	Movable.h Status.h Stage.h Movable.h Man.h Movable.h \
	Monster.h Movable.h Block.h Movable.h Point.h Movable.h \
	VVram.h 
Man.asm: Man.c Man.h Movable.h Sprite.h Movable.h Chars.h \
	Stage.h Movable.h ScanKeys.h Block.h Movable.h Sound.h \
	Main.h VVram.h 
Monster.asm: Monster.c Monster.h Movable.h Stage.h Movable.h Stages.h \
	Stage.h Movable.h Sprite.h Movable.h Chars.h Math.h \
	Man.h Movable.h Main.h 
Movable.asm: Movable.c Movable.h Stage.h Movable.h 
Point.asm: Point.c Point.h Movable.h Sprite.h Movable.h Main.h \
	Chars.h 
Sprite.asm: Sprite.c Sprite.h Movable.h Chars.h VVram.h Vram.h 
Stage.asm: Stage.c Stage.h Movable.h Stages.h Stage.h Movable.h \
	Main.h VVram.h Sprite.h Movable.h Chars.h Status.h \
	Block.h Movable.h Man.h Movable.h Monster.h Movable.h \
	CopyMemory.h Point.h Movable.h Math.h Vram.h 
Stages.asm: Stages.c Stage.h Movable.h Stages.h Stage.h Movable.h 
Status.asm: Status.c Status.h Vram.h Stage.h Movable.h Main.h \
	Sprite.h Movable.h Print.h Chars.h 
Vram.asm: Vram.c Vram.h Chars.h 
VVram.asm: VVram.c VVram.h Block.h Movable.h Sprite.h Movable.h \
	Vram.h Sound.h 
Chars.obj: Chars.asm 
CopyMemory.obj: CopyMemory.asm 
Math.obj: Math.asm 
Print.obj: Print.asm 
ScanKeys.obj: ScanKeys.asm mz80b.inc 
Sound.obj: Sound.asm mz80b.inc 
StageA.obj: StageA.asm 
Startup.obj: Startup.asm mz80b.inc 
VramA.obj: VramA.asm Vram.inc VVram.inc 
VVramA.obj: VVramA.asm VVram.inc Chars.inc 

objects = Startup.obj \
	Block.obj Main.obj Man.obj Monster.obj Movable.obj Point.obj \
	Sprite.obj Stage.obj Stages.obj Status.obj Vram.obj VVram.obj \
	Chars.obj CopyMemory.obj Math.obj Print.obj ScanKeys.obj Sound.obj \
	StageA.obj VramA.obj VVramA.obj \
	..\..\cate\cate80.lib

$(name).mzt: $(objects) makefile
	LinkLE.exe $(name).mzt $(cseg) $(dseg) $(objects)
