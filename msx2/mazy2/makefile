name=mazy2

filename=$(name)

all: $(filename) $(name).d88 $(name).dsk

cseg=8c00
dseg=8000

.c.asm:
	Cate80.exe $*.c

.asm.obj:
	Asm80.exe $*.asm

Knife.asm: Knife.c Knife.h Movable.h Stages.h Stage.h Sprite.h \
	Movable.h Chars.h Man.h Movable.h Main.h Status.h \
	Sound.h Math.h Monster.h Movable.h Point.h Movable.h 
Main.asm: Main.c Main.h Vram.h Chars.h Status.h ScanKeys.h \
	Stage.h Sound.h Sprite.h Movable.h Man.h Movable.h \
	Monster.h Movable.h Knife.h Movable.h Point.h Movable.h \
	VVram.h 
Man.asm: Man.c Man.h Movable.h Sprite.h Movable.h Stage.h \
	Chars.h ScanKeys.h Knife.h Movable.h Sound.h VVram.h 
Monster.asm: Monster.c Monster.h Movable.h Stages.h Stage.h Sprite.h \
	Movable.h Chars.h Math.h Man.h Movable.h Knife.h \
	Movable.h Sound.h Point.h Movable.h 
Movable.asm: Movable.c Movable.h Stage.h 
Point.asm: Point.c Point.h Movable.h Sprite.h Movable.h Main.h \
	Chars.h 
Stage.asm: Stage.c Stage.h Stages.h Stage.h Main.h Sprite.h \
	Movable.h VVram.h Status.h Man.h Movable.h Chars.h \
	Monster.h Movable.h Knife.h Movable.h Point.h Movable.h \
	Vram.h 
Stages.asm: Stages.c Stage.h Stages.h Stage.h 
Status.asm: Status.c Status.h Vram.h Main.h Print.h Chars.h \
	Sprite.h Movable.h 
Vram.asm: Vram.c Vram.h 
VVram.asm: VVram.c VVram.h Sprite.h Movable.h Vram.h Chars.h \
	Point.h Movable.h 
Chars.obj: Chars.asm 
Loader.obj: Loader.asm BIOS.inc BinSize.inc
Math.obj: Math.asm 
Print.obj: Print.asm 
ScanKeys.obj: ScanKeys.asm BIOS.inc 
Sound.obj: Sound.asm 
SoundOpll.obj: SoundOpll.asm BIOS.inc 
SoundPsg.obj: SoundPsg.asm BIOS.inc 
Sprite.obj: Sprite.asm Vram.inc Chars.inc 
StageA.obj: StageA.asm 
Startup.obj: Startup.asm BIOS.inc 
VramA.obj: VramA.asm BIOS.inc Vram.inc VVram.inc Chars.inc 
VVramA.obj: VVramA.asm VVram.inc 

objects = Startup.obj \
	Knife.obj Main.obj Man.obj Monster.obj Movable.obj Point.obj \
	Stage.obj Stages.obj Status.obj Vram.obj VVram.obj Chars.obj \
	Math.obj Print.obj ScanKeys.obj Sound.obj SoundOpll.obj SoundPsg.obj \
	Sprite.obj StageA.obj VramA.obj VVramA.obj \
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
