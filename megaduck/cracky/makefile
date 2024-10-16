name=cracky

all: $(name).bin

cseg=0000
dseg=c0a0

.c.asm:
	Cate83.exe $*.c

.asm.obj:
	Asm83.exe $*.asm

Destruction.asm: Destruction.c Destruction.h Stage.h Movable.h Vram.h Chars.h 
Main.asm: Main.c Main.h ScanKeys.h Vram.h Sound.h Sprite.h \
	Movable.h Status.h Stage.h Movable.h Man.h Movable.h \
	Destruction.h Monster.h Movable.h 
Man.asm: Man.c Man.h Movable.h ScanKeys.h Chars.h Sprite.h \
	Movable.h Stage.h Movable.h Vram.h Destruction.h Main.h \
	Sound.h 
Monster.asm: Monster.c Monster.h Movable.h Stages.h Stage.h Movable.h \
	Sprite.h Movable.h Chars.h Math.h Man.h Movable.h 
Movable.asm: Movable.c Movable.h Stage.h Movable.h 
Stage.asm: Stage.c Stage.h Movable.h Stages.h Stage.h Movable.h \
	Main.h Vram.h Sprite.h Movable.h Chars.h Status.h \
	CopyMemory.h Man.h Movable.h Monster.h Movable.h Destruction.h 
Stages.asm: Stages.c Stage.h Movable.h Stages.h Stage.h Movable.h 
Status.asm: Status.c Status.h Vram.h Main.h Sprite.h Movable.h \
	Print.h Chars.h 
Vram.asm: Vram.c Vram.h 
Chars.obj: Chars.asm 
CopyMemory.obj: CopyMemory.asm 
Math.obj: Math.asm 
Print.obj: Print.asm 
ScanKeys.obj: ScanKeys.asm MegaDuck.inc 
Sound.obj: Sound.asm MegaDuck.inc 
Sprite.obj: Sprite.asm MegaDuck.inc Vram.inc 
StageA.obj: StageA.asm 
Startup.obj: Startup.asm MegaDuck.inc Vram.inc 
VramA.obj: VramA.asm MegaDuck.inc Vram.inc Chars.inc 

objects = Startup.obj \
	Destruction.obj Main.obj Man.obj Monster.obj Movable.obj Stage.obj \
	Stages.obj Status.obj Vram.obj Chars.obj CopyMemory.obj Math.obj \
	Print.obj ScanKeys.obj Sound.obj Sprite.obj StageA.obj VramA.obj \
	..\..\cate\cate83.lib

$(name).bin: $(objects) makefile
	LinkLE.exe $(name).bin $(cseg) $(dseg) $(objects)
