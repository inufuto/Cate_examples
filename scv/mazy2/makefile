name=mazy2

all: $(name)_e.rom $(name)_r.rom

cseg=8000
dseg_e=2e00
dseg_r=e000
zseg=ff80

.c.asm:
	Cate87.exe $*.c

.asm.obj:
	Asm87 $*.asm

Knife.asm: Knife.c Knife.h Movable.h Stages.h Stage.h Sprite.h \
	Movable.h Chars.h Man.h Movable.h Main.h Status.h \
	Sound.h Math.h Monster.h Movable.h Point.h Movable.h 
Main.asm: Main.c Main.h Vram.h Chars.h Status.h ScanKeys.h \
	Stage.h Sound.h Sprite.h Movable.h Man.h Movable.h \
	Monster.h Movable.h Knife.h Movable.h Point.h Movable.h 
Man.asm: Man.c Man.h Movable.h Sprite.h Movable.h Stage.h \
	Chars.h ScanKeys.h Knife.h Movable.h Sound.h 
Monster.asm: Monster.c Monster.h Movable.h Stages.h Stage.h Sprite.h \
	Movable.h Chars.h Math.h Man.h Movable.h Knife.h \
	Movable.h Sound.h Point.h Movable.h 
Movable.asm: Movable.c Movable.h Stage.h 
Point.asm: Point.c Point.h Movable.h Sprite.h Movable.h Main.h \
	Chars.h 
Stage.asm: Stage.c Stage.h Stages.h Stage.h Main.h Sprite.h \
	Movable.h Vram.h Status.h Man.h Movable.h Chars.h \
	Monster.h Movable.h Knife.h Movable.h Point.h Movable.h 
Stages.asm: Stages.c Stage.h Stages.h Stage.h 
Status.asm: Status.c Status.h Vram.h Main.h Sprite.h Movable.h \
	Print.h Chars.h 
Vram.asm: Vram.c Vram.h Sprite.h Movable.h 
Chars.obj: Chars.asm 
Math.obj: Math.asm 
Print.obj: Print.asm Vram.inc 
ScanKeys.obj: ScanKeys.asm 
Sound.obj: Sound.asm 
Sprite.obj: Sprite.asm Vram.inc 
StageA.obj: StageA.asm 
Startup.obj: Startup.asm 
VramA.obj: VramA.asm Vram.inc Chars.inc 

objects = Startup.obj \
	Knife.obj Main.obj Man.obj Monster.obj Movable.obj Point.obj \
	Stage.obj Stages.obj Status.obj Vram.obj Chars.obj Math.obj \
	Print.obj ScanKeys.obj Sound.obj Sprite.obj StageA.obj VramA.obj \
	..\..\cate\cate87.lib

$(name)_e.rom: $(objects) makefile
	LinkLE $(name)_e.rom $(cseg) $(dseg_e) $(zseg) $(objects)

$(name)_r.rom: $(objects) makefile
	LinkLE $(name)_r.rom $(cseg) $(dseg_r) $(zseg) $(objects)
