name=cavit

all: $(name).d88

cseg=4000
zseg=7400 
dseg=7500

.c.asm:
	Cate09.exe $*.c

.asm.obj:
	Asm09.exe $*.asm

Box.asm: Box.c Box.h Fixed.h Stage.h Stages.h Chars.h \
	Sprite.h Point.h Movable.h Man.h Movable.h Sound.h 
Chaser.asm: Chaser.c Chaser.h Monster.h Movable.h Sprite.h Stage.h \
	Man.h Movable.h Direction.h Chars.h 
Direction.asm: Direction.c Direction.h 
Fixed.asm: Fixed.c Fixed.h 
Ghost.asm: Ghost.c Ghost.h Monster.h Movable.h Sprite.h Stage.h \
	Man.h Movable.h Direction.h Main.h Chars.h 
Main.asm: Main.c Main.h ScanKeys.h Sprite.h Vram.h Sound.h \
	Status.h Stage.h Man.h Movable.h Chaser.h Monster.h \
	Movable.h Ghost.h Monster.h Movable.h Rock.h Fixed.h \
	Movable.h Point.h Movable.h Box.h Fixed.h 
Man.asm: Man.c Man.h Movable.h Movable.h Sprite.h Stage.h \
	ScanKeys.h Direction.h Chars.h Vram.h Rock.h Fixed.h \
	Movable.h Sound.h 
Monster.asm: Monster.c Monster.h Movable.h Stage.h Rock.h Fixed.h \
	Movable.h Sprite.h Chaser.h Monster.h Movable.h Ghost.h \
	Monster.h Movable.h Man.h Movable.h 
Movable.asm: Movable.c Movable.h Sprite.h Stage.h Direction.h 
Point.asm: Point.c Point.h Movable.h Sprite.h Main.h Chars.h 
Rock.asm: Rock.c Rock.h Fixed.h Movable.h Stage.h Stages.h \
	Vram.h Chars.h Sprite.h Direction.h Man.h Movable.h \
	Point.h Movable.h Chaser.h Monster.h Movable.h Ghost.h \
	Monster.h Movable.h Sound.h 
Sprite.asm: Sprite.c Sprite.h Vram.h VVram.h 
Stage.asm: Stage.c Stage.h Stages.h Main.h Status.h VVram.h \
	Sprite.h Chars.h Man.h Movable.h Box.h Fixed.h \
	Rock.h Fixed.h Movable.h Chaser.h Monster.h Movable.h \
	Ghost.h Monster.h Movable.h Direction.h Point.h Movable.h \
	Vram.h 
Stages.asm: Stages.c Stages.h 
Status.asm: Status.c Status.h Vram.h Stage.h Main.h Sprite.h \
	Print.h Chars.h 
Vram.asm: Vram.c Vram.h Chars.h Sprite.h Sound.h 
VVram.asm: VVram.c VVram.h Chars.h 
Chars.obj: Chars.asm 
Loader1.obj: Loader1.asm Loader.inc 
Loader2.obj: Loader2.asm Loader.inc BinSize.inc 
LoaderSub.obj: LoaderSub.asm 
Print.obj: Print.asm 
ScanKeys.obj: ScanKeys.asm 
Sound.obj: Sound.asm 
Startup.obj: Startup.asm 
VramA.obj: VramA.asm Vram.inc VVram.inc Chars.inc 
VVramA.obj: VVramA.asm VVram.inc 
Loader.obj: Loader.asm S1.inc BinSize.inc

objects = Startup.obj \
	Box.obj Chaser.obj Direction.obj Fixed.obj Ghost.obj Main.obj \
	Man.obj Monster.obj Movable.obj Point.obj Rock.obj Sprite.obj \
	Stage.obj Stages.obj Status.obj Vram.obj VVram.obj Chars.obj \
	Print.obj ScanKeys.obj Sound.obj VramA.obj VVramA.obj \
	..\..\cate\cate09.lib

$(name).bin: $(objects) makefile
	LinkBE.exe $(name).bin $(cseg) $(dseg) $(zseg) $(objects)

BinSize.inc: $(name).bin BinSize.csx
	dotnet script BinSize.csx $(name) $(cseg)

Loader.bin: Loader.obj makefile BinSize.inc
	LinkBE.exe Loader.bin 2000 2300 2200 Loader.obj

$(name).d88: Loader.bin $(name).bin disk.csx
	dotnet script disk.csx $(name)
