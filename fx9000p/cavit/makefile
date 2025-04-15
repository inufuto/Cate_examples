name=cavit

all: $(name).rom debug.bin

cseg=9000
dseg=b800

.c.asm:
	Cate80.exe $*.c

.asm.obj:
	Asm80.exe $*.asm

Box.asm: Box.c Box.h Fixed.h Stage.h Stages.h VVram.h \
	Vram.h Chars.h Sprite.h Movable.h Point.h Movable.h \
	Man.h Movable.h 
Chaser.asm: Chaser.c Chaser.h Monster.h Movable.h Sprite.h Movable.h \
	Stage.h Man.h Movable.h Direction.h Chars.h 
Direction.asm: Direction.c Direction.h 
Fixed.asm: Fixed.c Fixed.h 
Ghost.asm: Ghost.c Ghost.h Monster.h Movable.h Sprite.h Movable.h \
	Stage.h Man.h Movable.h Direction.h Main.h Chars.h 
Main.asm: Main.c Main.h ScanKeys.h Sprite.h Movable.h Vram.h \
	Status.h Stage.h Man.h Movable.h Chaser.h Monster.h \
	Movable.h Ghost.h Monster.h Movable.h Rock.h Fixed.h \
	Movable.h Point.h Movable.h Box.h Fixed.h VVram.h \
	Vram.h 
Man.asm: Man.c Man.h Movable.h Movable.h Sprite.h Movable.h \
	Stage.h ScanKeys.h Direction.h Chars.h VVram.h Vram.h \
	Rock.h Fixed.h Movable.h Main.h 
Monster.asm: Monster.c Monster.h Movable.h Stage.h Rock.h Fixed.h \
	Movable.h Sprite.h Movable.h Chaser.h Monster.h Movable.h \
	Ghost.h Monster.h Movable.h Man.h Movable.h 
Movable.asm: Movable.c Movable.h Sprite.h Movable.h Stage.h Direction.h 
Point.asm: Point.c Point.h Movable.h Sprite.h Movable.h Main.h \
	Chars.h 
Rock.asm: Rock.c Rock.h Fixed.h Movable.h Stage.h Stages.h \
	VVram.h Vram.h Chars.h Sprite.h Movable.h Direction.h \
	Man.h Movable.h Point.h Movable.h Chaser.h Monster.h \
	Movable.h Ghost.h Monster.h Movable.h Main.h 
Sprite.asm: Sprite.c Sprite.h Movable.h Chars.h VVram.h Vram.h \
	Vram.h 
Stage.asm: Stage.c Stage.h Stages.h Main.h Status.h Vram.h \
	Sprite.h Movable.h Chars.h Man.h Movable.h Box.h \
	Fixed.h Rock.h Fixed.h Movable.h Chaser.h Monster.h \
	Movable.h Ghost.h Monster.h Movable.h Direction.h Point.h \
	Movable.h VVram.h Vram.h 
Stages.asm: Stages.c Stages.h 
Status.asm: Status.c Status.h Vram.h Stage.h Main.h Sprite.h \
	Movable.h Print.h Chars.h 
Vram.asm: Vram.c Vram.h Chars.h 
VVram.asm: VVram.c VVram.h Vram.h Chars.h Sprite.h Movable.h \
	Vram.h 
Chars.obj: Chars.asm 
Loader.obj: Loader.asm BinSize.inc
Print.obj: Print.asm 
ScanKeys.obj: ScanKeys.asm 
Startup.obj: Startup.asm Vram.inc 
VramA.obj: VramA.asm Vram.inc VVram.inc 
VVramA.obj: VVramA.asm Vram.inc VVram.inc 

objects = Startup.obj \
	Box.obj Chaser.obj Direction.obj Fixed.obj Ghost.obj Main.obj \
	Man.obj Monster.obj Movable.obj Point.obj Rock.obj Sprite.obj \
	Stage.obj Stages.obj Status.obj Vram.obj VVram.obj Chars.obj \
	Print.obj ScanKeys.obj VramA.obj VVramA.obj \
	..\..\cate\cate80.lib

$(name).bin: $(objects) makefile
	LinkLE.exe $(name).bin $(cseg) $(dseg) $(objects)

BinSize.inc: $(name).bin BinSize.csx
	dotnet script BinSize.csx $(name) $(cseg)

Loader.bin: Loader.obj makefile
	LinkLE.exe Loader.bin 4000 $(dseg) Loader.obj

$(name).rom: $(name).bin Loader.bin MakeRom.csx
	dotnet script MakeRom.csx $(name)

debug.bin: $(name).bin
	copy $(name).bin debug.bin /y
