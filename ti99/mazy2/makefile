name=mazy2

target=$(name)8.bin

all: $(target)

cseg=a000
dseg=8300-838f,2000

.c.asm:
	Cate99.exe $*.c

.asm.obj:
	Asm99.exe $*.asm

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
Status.asm: Status.c Status.h Vram.h Main.h Print.h Chars.h \
	Sprite.h Movable.h 
Vram.asm: Vram.c Vram.h Chars.h 
Chars.obj: Chars.asm 
Math.obj: Math.asm 
Print.obj: Print.asm 
ScanKeys.obj: ScanKeys.asm 
Sound.obj: Sound.asm 
Sprite.obj: Sprite.asm Vdp.inc Vram.inc Chars.inc 
StageA.obj: StageA.asm 
Startup.obj: Startup.asm Vdp.inc 
Vdp.obj: Vdp.asm Vdp.inc Vram.inc 
VramA.obj: VramA.asm Vdp.inc Vram.inc Chars.inc 

objects = Startup.obj \
	Knife.obj Main.obj Man.obj Monster.obj Movable.obj Point.obj \
	Stage.obj Stages.obj Status.obj Vram.obj Chars.obj Math.obj \
	Print.obj ScanKeys.obj Sound.obj Sprite.obj StageA.obj Vdp.obj \
	VramA.obj \
	..\..\cate\cate99.lib

$(name).bin: $(objects) makefile
	LinkBE.exe $(name).bin $(cseg) $(dseg) $(objects)

RomHead.bin: RomHead.obj makefile
	LinkBE.exe RomHead.bin 6000 3f00 RomHead.obj

RamHead.bin: RamHead.obj makefile
	LinkBE.exe RamHead.bin fec0 3f00 RamHead.obj

$(target): RomHead.bin RamHead.bin $(name).bin
	copy /b RomHead.bin+RamHead.bin+$(name).bin $(target) /y
