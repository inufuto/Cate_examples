name=cavit

filename=$(name)

all: $(filename) $(name).wav $(name).rom $(name).d88 $(name).dsk

.c.asm:
	Cate80.exe $*.c

.asm.obj:
	Asm80.exe $*.asm

Box.asm: Box.c Box.h Fixed.h Stage.h Stages.h Vram.h \
	Chars.h Sprite.h Movable.h Point.h Movable.h Man.h \
	Movable.h Sound.h 
Chaser.asm: Chaser.c Chaser.h Monster.h Movable.h Sprite.h Movable.h \
	Stage.h Man.h Movable.h Direction.h 
Direction.asm: Direction.c Direction.h 
Fixed.asm: Fixed.c Fixed.h 
Ghost.asm: Ghost.c Ghost.h Monster.h Movable.h Sprite.h Movable.h \
	Stage.h Man.h Movable.h Direction.h Main.h 
Main.asm: Main.c Main.h ScanKeys.h Sprite.h Movable.h Vram.h \
	Sound.h Status.h Stage.h Man.h Movable.h Chaser.h \
	Monster.h Movable.h Ghost.h Monster.h Movable.h Rock.h \
	Fixed.h Movable.h Point.h Movable.h Box.h Fixed.h 
Man.asm: Man.c Man.h Movable.h Movable.h Sprite.h Movable.h \
	Stage.h ScanKeys.h Direction.h Chars.h Vram.h Rock.h \
	Fixed.h Movable.h Sound.h 
Monster.asm: Monster.c Monster.h Movable.h Stage.h Rock.h Fixed.h \
	Movable.h Sprite.h Movable.h Chaser.h Monster.h Movable.h \
	Ghost.h Monster.h Movable.h Man.h Movable.h 
Movable.asm: Movable.c Movable.h Sprite.h Movable.h Stage.h Direction.h 
Point.asm: Point.c Point.h Movable.h Sprite.h Movable.h Main.h 
Rock.asm: Rock.c Rock.h Fixed.h Movable.h Stage.h Stages.h \
	Vram.h Chars.h Sprite.h Movable.h Direction.h Man.h \
	Movable.h Point.h Movable.h Chaser.h Monster.h Movable.h \
	Ghost.h Monster.h Movable.h Sound.h 
Stage.asm: Stage.c Stage.h Stages.h Main.h Status.h Vram.h \
	Sprite.h Movable.h Chars.h Man.h Movable.h Box.h \
	Fixed.h Rock.h Fixed.h Movable.h Chaser.h Monster.h \
	Movable.h Ghost.h Monster.h Movable.h Direction.h Point.h \
	Movable.h 
Stages.asm: Stages.c Stages.h 
Status.asm: Status.c Status.h Vram.h Main.h Sprite.h Movable.h \
	Print.h Chars.h 
Vram.asm: Vram.c Vram.h 
Chars.obj: Chars.asm 
chead.obj: chead.asm 
Init.obj: Init.asm BIOS.inc 
Loader.obj: Loader.asm BIOS.inc BinSize.inc
PrintA.obj: PrintA.asm 
ScanKeys.obj: ScanKeys.asm BIOS.inc 
Sound.obj: Sound.asm BIOS.inc 
SpriteA.obj: SpriteA.asm BIOS.inc Vram.inc 
VramA.obj: VramA.asm BIOS.inc Vram.inc 

objects = Main.obj \
	Box.obj Chaser.obj Direction.obj Fixed.obj Ghost.obj Man.obj \
	Monster.obj Movable.obj Point.obj Rock.obj Stage.obj Stages.obj \
	Status.obj Vram.obj Chars.obj Init.obj PrintA.obj ScanKeys.obj \
	Sound.obj SpriteA.obj VramA.obj \
	..\..\cate\cate80.lib

$(name).rom: chead.obj $(objects) makefile
	LinkLE.exe $(name).rom 4000 e000 chead.obj $(objects)
	copy $(name).symbols.txt $(name).rom.symbols.txt /y

$(name).hex: $(objects) makefile
	LinkLE.exe $(name).hex 8200 8000 $(objects)
	copy $(name).symbols.txt $(name).disk.symbols.txt /y

$(filename): $(name).hex
	ihx2bin $(name).hex $(filename)

$(name).cas: $(objects) makefile
	LinkLE.exe $(name).cas C200 C000 $(objects)
	copy $(name).symbols.txt $(name).tape.symbols.txt /y

$(name).wav: $(name).cas
	cas2wav $(name).cas $(name).wav


BinSize.inc: $(name).bin BinSize.csx
	dotnet script BinSize.csx $(name) 8200

$(name).bin: $(objects) makefile
	LinkLE.exe $(name).bin 8200 8000 $(objects)

Loader.bin: Loader.obj makefile
	LinkLE Loader.bin c000 c100 Loader.obj

$(name).d88 $(name).dsk: $(name).bin Loader.bin Disk.csx
	dotnet script Disk.csx $(name)
