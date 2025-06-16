name=ascend
filename=$(name)

all: $(filename) $(name).wav $(name).rom $(name).d88 $(name).dsk

.c.asm:
	Cate80.exe $*.c

.asm.obj:
	Asm80.exe $*.asm

Actor.asm: Actor.c Movable.h Actor.h Stage.h Block.h Sprite.h \
	Man.h 
Block.asm: Block.c Movable.h Sprite.h Actor.h Block.h Chars.h \
	Stage.h Stages.h Vram.h Man.h 
Fire.asm: Fire.c Movable.h Sprite.h Actor.h Fire.h Chars.h \
	Math.h Main.h Stage.h Man.h Vram.h 
Main.asm: Main.c Main.h Init.h ScanKeys.h Vram.h Sound.h \
	Status.h Movable.h Actor.h Stage.h Sprite.h Man.h \
	Fire.h Monster.h 
Man.asm: Man.c Movable.h Sprite.h Actor.h Man.h Stage.h \
	Chars.h ScanKeys.h Vram.h Block.h Sound.h Main.h \
	Fire.h Status.h 
Monster.asm: Monster.c Movable.h Sprite.h Actor.h Monster.h Chars.h \
	Math.h Main.h Stage.h Man.h Vram.h 
Movable.asm: Movable.c Movable.h 
Stage.asm: Stage.c Vram.h Stage.h Stages.h Main.h Chars.h \
	Status.h Movable.h Actor.h Man.h Sprite.h Stage.h \
	Fire.h Monster.h Block.h Math.h 
Stages.asm: Stages.c Stage.h Stages.h 
Status.asm: Status.c Status.h Vram.h Main.h Print.h Chars.h \
	Movable.h Actor.h Sprite.h 
Vram.asm: Vram.c Vram.h Chars.h 
BackgroundPattern.obj: BackgroundPattern.asm 
Chars.obj: Chars.asm 
chead.obj: chead.asm 
Init.obj: Init.asm BIOS.inc 
Loader.obj: Loader.asm BIOS.inc BinSize.inc 
Math.obj: Math.asm 
Print.obj: Print.asm 
ScanKeys.obj: ScanKeys.asm BIOS.inc 
Sound.obj: Sound.asm BIOS.inc 
Sprite.obj: Sprite.asm BIOS.inc Vram.inc Chars.inc 
VramA.obj: VramA.asm BIOS.inc Vram.inc Chars.inc 

objects = Main.obj \
	Actor.obj Block.obj Fire.obj Man.obj Monster.obj Movable.obj \
	Stage.obj Stages.obj Status.obj Vram.obj BackgroundPattern.obj Chars.obj \
	Init.obj Math.obj Print.obj ScanKeys.obj Sound.obj Sprite.obj \
	VramA.obj \
	..\..\cate\cate80.lib


$(name).rom: chead.obj $(objects) makefile
	LinkLE.exe $(name).rom 4000 e000 chead.obj $(objects)
	copy $(name).symbols.txt $(name).rom.symbols.txt /y

$(name).hex: $(objects) makefile
	LinkLE.exe $(name).hex 8500 8000 $(objects)
	copy $(name).symbols.txt $(name).disk.symbols.txt /y

$(filename): $(name).hex
	ihx2bin $(name).hex $(filename)

$(name).cas: $(objects) makefile
	LinkLE.exe $(name).cas C500 C000 $(objects)
	copy $(name).symbols.txt $(name).tape.symbols.txt /y

$(name).wav: $(name).cas
	cas2wav $(name).cas $(name).wav


BinSize.inc: $(name).bin BinSize.csx
	dotnet script BinSize.csx $(name) 8500

$(name).bin: $(objects) makefile
	LinkLE.exe $(name).bin 8500 8000 $(objects)

Loader.bin: Loader.obj makefile
	LinkLE Loader.bin c000 c100 Loader.obj

$(name).d88 $(name).dsk: $(name).bin Loader.bin Disk.csx
	dotnet script Disk.csx $(name)
