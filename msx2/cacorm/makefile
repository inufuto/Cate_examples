name=cacorm
filename=$(name)

all: $(filename) $(name).d88 $(name).dsk

cseg=8400
dseg=8000

.c.asm:
	Cate80.exe $*.c

.asm.obj:
	Asm80.exe $*.asm

Actor.asm: Actor.c Movable.h Actor.h 
Increaser.asm: Increaser.c Movable.h Increaser.h Sprite.h Movable.h Chars.h 
Item.asm: Item.c Item.h Stage.h Stages.h Vram.h Chars.h \
	Line.h Sound.h Movable.h Point.h Sprite.h Movable.h \
	Main.h Increaser.h Math.h 
Line.asm: Line.c Line.h Chars.h Stage.h Vram.h Movable.h \
	Actor.h Sound.h Sprite.h Movable.h Item.h Monster.h 
Main.asm: Main.c Main.h Init.h ScanKeys.h Vram.h Sound.h \
	Status.h Movable.h Actor.h Stage.h Sprite.h Movable.h \
	Man.h Monster.h Item.h Point.h 
Man.asm: Man.c Movable.h Actor.h Man.h Sprite.h Movable.h \
	Stage.h ScanKeys.h Main.h Sound.h Chars.h Line.h \
	Item.h Vram.h Status.h Increaser.h 
Monster.asm: Monster.c Movable.h Actor.h Monster.h Sprite.h Movable.h \
	Stage.h Chars.h Math.h Man.h Line.h 
Movable.asm: Movable.c Movable.h Stage.h 
Point.asm: Point.c Movable.h Point.h Sprite.h Movable.h Main.h \
	Chars.h 
Stage.asm: Stage.c Stage.h Stages.h Main.h Vram.h Movable.h \
	Actor.h Sprite.h Movable.h Chars.h CopyMemory.h Status.h \
	Man.h Item.h Monster.h Point.h Increaser.h 
Stages.asm: Stages.c Stage.h Stages.h 
Status.asm: Status.c Status.h Vram.h Main.h Print.h Chars.h \
	Movable.h Sprite.h Movable.h 
Vram.asm: Vram.c Vram.h Chars.h 
Chars.obj: Chars.asm 
Loader.obj: Loader.asm BIOS.inc BinSize.inc
Math.obj: Math.asm 
Print.obj: Print.asm 
ScanKeys.obj: ScanKeys.asm BIOS.inc 
Sound.obj: Sound.asm 
SoundOpll.obj: SoundOpll.asm BIOS.inc 
SoundPsg.obj: SoundPsg.asm BIOS.inc 
Sprite.obj: Sprite.asm BIOS.inc Vram.inc Chars.inc 
Startup.obj: Startup.asm BIOS.inc 
VramA.obj: VramA.asm BIOS.inc Vram.inc Chars.inc 

objects = Startup.obj \
	Actor.obj Increaser.obj Item.obj Line.obj Main.obj Man.obj \
	Monster.obj Movable.obj Point.obj Stage.obj Stages.obj Status.obj \
	Vram.obj Chars.obj Math.obj Print.obj ScanKeys.obj Sound.obj \
	SoundOpll.obj SoundPsg.obj Sprite.obj VramA.obj \
	..\..\cate\cate80.lib

$(name).hex: $(objects) makefile
	LinkLE.exe $(name).hex $(cseg) $(dseg) $(objects)

$(filename): $(name).hex
	ihx2bin $(name).hex $(filename)


BinSize.inc: $(name).bin BinSize.csx
	dotnet script BinSize.csx $(name) $(cseg)

$(name).bin: $(objects) makefile
	LinkLE.exe $(name).bin $(cseg) $(dseg) $(objects)

Loader.bin: Loader.obj
	LinkLE Loader.bin c000 c100 Loader.obj

$(name).d88 $(name).dsk: $(name).bin Loader.bin Disk.csx
	dotnet script Disk.csx $(name)
