name=svellas

all: $(name).rom

cseg=bfe8-bfff,8000
dseg=0200-3ff,0040
zseg=0000

.c.asm:
	Cate65.exe -v2 $*.c

.asm.obj:
	Asm65.exe -v2 $*.asm

Main.asm: Main.c Main.h Status.h ScanKeys.h Stage.h Man.h \
	Movable.h Sound.h Sprite.h Movable.h Monster.h Movable.h 
Man.asm: Man.c Man.h Movable.h Sprite.h Movable.h Chars.h \
	ScanKeys.h Stage.h Vram.h Sound.h Main.h 
Monster.asm: Monster.c Monster.h Movable.h Stages.h Stage.h Sprite.h \
	Movable.h Chars.h Math.h Man.h Movable.h Stage.h \
	Math.h Main.h 
Movable.asm: Movable.c Movable.h Stage.h 
Stage.asm: Stage.c Stage.h Stages.h Stage.h Main.h Vram.h \
	Sprite.h Movable.h Status.h Chars.h CopyMemory.h Man.h \
	Movable.h Monster.h Movable.h Math.h Sound.h 
Stages.asm: Stages.c Stage.h Stages.h Stage.h 
Status.asm: Status.c Status.h Vram.h Main.h Print.h Chars.h \
	Sprite.h Movable.h 
Vram.asm: Vram.c Vram.h Chars.h 
Chars.obj: Chars.asm 
CopyMemory.obj: CopyMemory.asm 
Math.obj: Math.asm 
Print.obj: Print.asm 
ScanKeys.obj: ScanKeys.asm 
Sound.obj: Sound.asm 
Sprite.obj: Sprite.asm  Vram.inc Chars.inc 
StageA.obj: StageA.asm 
Startup.obj: Startup.asm  
Vdp.obj: Vdp.asm  Vram.inc 
VramA.obj: VramA.asm  Vram.inc Chars.inc 

objects = RomTail.obj Startup.obj \
	Main.obj Man.obj Monster.obj Movable.obj Stage.obj Stages.obj \
	Status.obj Vram.obj Chars.obj CopyMemory.obj Math.obj Print.obj \
	ScanKeys.obj Sound.obj Sprite.obj StageA.obj  VramA.obj \
	ZeroPage.obj \
	..\..\cate\cate65.lib

$(name).rom: $(objects) makefile
	LinkLE.exe $(name).rom $(cseg) $(dseg) $(zseg) $(objects)
