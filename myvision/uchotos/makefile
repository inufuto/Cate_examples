name=uchotos

all: $(name).rom

cseg=0000
dseg=a000

.c.asm:
	Cate80.exe $*.c

.asm.obj:
	Asm80.exe -v2 $*.asm

Debri.asm: Debri.c Debri.h Movable.h Sprite.h Movable.h Chars.h \
	Stage.h Movable.h 
Fire.asm: Fire.c Fire.h Movable.h Sprite.h Movable.h Man.h \
	Movable.h Chars.h Monster.h Movable.h Stage.h Movable.h \
	Main.h Sound.h ScanKeys.h 
Main.asm: Main.c Main.h Status.h ScanKeys.h Stage.h Movable.h \
	Man.h Movable.h Monster.h Movable.h Fire.h Movable.h \
	Debri.h Movable.h Sound.h 
Man.asm: Man.c Man.h Movable.h ScanKeys.h Chars.h Sprite.h \
	Movable.h Stage.h Movable.h Fire.h Movable.h Sound.h \
	Main.h Status.h OneUp.h Movable.h 
Monster.asm: Monster.c Monster.h Movable.h Sprite.h Movable.h Stage.h \
	Movable.h Chars.h Math.h Man.h Movable.h Debri.h \
	Movable.h OneUp.h Movable.h 
Movable.asm: Movable.c Movable.h Stage.h Movable.h 
OneUp.asm: OneUp.c OneUp.h Movable.h Sprite.h Movable.h Chars.h \
	Math.h Main.h Stage.h Movable.h Sound.h Status.h 
Stage.asm: Stage.c Stage.h Movable.h Stages.h Stage.h Movable.h \
	Main.h Math.h Chars.h Vram.h Status.h Man.h \
	Movable.h Monster.h Movable.h Fire.h Movable.h Debri.h \
	Movable.h Sprite.h Movable.h OneUp.h Movable.h 
Stages.asm: Stages.c Stage.h Movable.h Stages.h Stage.h Movable.h 
Status.asm: Status.c Status.h Vram.h Main.h Print.h Chars.h \
	Sprite.h Movable.h 
Vram.asm: Vram.c Vram.h Chars.h 
Chars.obj: Chars.asm 
Math.obj: Math.asm 
Print.obj: Print.asm 
ScanKeys.obj: ScanKeys.asm kh1000.inc 
Sound.obj: Sound.asm kh1000.inc 
Sprite.obj: Sprite.asm kh1000.inc Vram.inc Chars.inc Sprite.inc 
StageA.obj: StageA.asm Vram.inc 
Startup.obj: Startup.asm kh1000.inc 
Vdp.obj: Vdp.asm kh1000.inc Vram.inc 
VramA.obj: VramA.asm kh1000.inc Vram.inc Chars.inc 

objects = Startup.obj \
	Debri.obj Fire.obj Main.obj Man.obj Monster.obj Movable.obj \
	OneUp.obj Stage.obj Stages.obj Status.obj Vram.obj Chars.obj \
	Math.obj Print.obj ScanKeys.obj Sound.obj Sprite.obj StageA.obj \
	Vdp.obj VramA.obj \
	..\..\cate\cate80.lib

$(name).rom: $(objects) makefile
	LinkLE.exe $(name).rom $(cseg) $(dseg) $(objects)
