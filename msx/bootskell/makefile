name=bootskell
filename=bootskel

all: $(filename) $(name).wav $(name).rom $(name).d88 $(name).dsk

.c.asm:
	Cate80.exe $*.c

.asm.obj:
	Asm80.exe $*.asm

Block.asm: Block.c Movable.h Block.h Sprite.h Movable.h Stage.h \
	Vram.h Chars.h Man.h Monster.h Point.h Movable.h \
	Math.h Sound.h 
Main.asm: Main.c Main.h ScanKeys.h Sprite.h Movable.h Vram.h \
	Sound.h Status.h Stage.h Man.h Block.h Monster.h \
	Math.h Point.h Movable.h 
Man.asm: Man.c Movable.h Man.h Sprite.h Movable.h Stage.h \
	ScanKeys.h Block.h Sound.h Main.h 
Math.asm: Math.c Math.h 
Monster.asm: Monster.c Movable.h Monster.h Sprite.h Movable.h Stage.h \
	Block.h Math.h Man.h Main.h 
Movable.asm: Movable.c Movable.h Stage.h Man.h Block.h Monster.h 
Point.asm: Point.c Point.h Movable.h Sprite.h Movable.h Main.h 
Stage.asm: Stage.c Stage.h Stages.h Main.h Vram.h Sprite.h \
	Movable.h Chars.h CopyMemory.h Status.h Movable.h Man.h \
	Block.h Monster.h Point.h Movable.h 
Stages.asm: Stages.c Stage.h Stages.h 
Status.asm: Status.c Status.h Vram.h Main.h Sprite.h Movable.h \
	Print.h Chars.h 
Vram.asm: Vram.c Vram.h 
Chars.obj: Chars.asm 
chead.obj: chead.asm 
CopyMemory.obj: CopyMemory.asm 
Init.obj: Init.asm BIOS.inc 
Loader.obj: Loader.asm BIOS.inc BinSize.inc
PrintA.obj: PrintA.asm 
ScanKeys.obj: ScanKeys.asm BIOS.inc 
Sound.obj: Sound.asm BIOS.inc 
SpriteA.obj: SpriteA.asm BIOS.inc Vram.inc 
VramA.obj: VramA.asm BIOS.inc Vram.inc 

objects = Main.obj \
	Block.obj Man.obj Math.obj Monster.obj Movable.obj Point.obj \
	Stage.obj Stages.obj Status.obj Vram.obj Chars.obj CopyMemory.obj \
	Init.obj PrintA.obj ScanKeys.obj Sound.obj SpriteA.obj VramA.obj \
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
	dotnet script BinSize.csx $(name) 

$(name).bin: $(objects) makefile
	LinkLE.exe $(name).bin 8200 8000 $(objects)

Loader.bin: Loader.obj
	LinkLE Loader.bin c000 c100 Loader.obj

$(name).d88 $(name).dsk: $(name).bin Loader.bin Disk.csx
	dotnet script Disk.csx $(name)
