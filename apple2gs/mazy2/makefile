name=mazy2

all:$(name).dsk

cseg=0900
dseg=6500
zseg=00c0

.c.asm:
	Cate816.exe $*.c

.asm.obj:
	Asm65.exe -65816 $*.asm

Knife.asm: Knife.c Knife.h Movable.h Stages.h Stage.h Sprite.h \
	Movable.h Chars.h Man.h Movable.h Main.h Status.h \
	Sound.h Math.h Monster.h Movable.h Point.h Movable.h 
Main.asm: Main.c Main.h Vram.h Chars.h Status.h ScanKeys.h \
	Stage.h Sound.h Sprite.h Movable.h Man.h Movable.h \
	Monster.h Movable.h Knife.h Movable.h Point.h Movable.h 
Man.asm: Man.c Man.h Movable.h Sprite.h Movable.h Stage.h \
	Chars.h ScanKeys.h Knife.h Movable.h Sound.h VVram.h 
Monster.asm: Monster.c Monster.h Movable.h Stages.h Stage.h Sprite.h \
	Movable.h Chars.h Math.h Man.h Movable.h Knife.h \
	Movable.h Sound.h Point.h Movable.h 
Movable.asm: Movable.c Movable.h Stage.h 
Point.asm: Point.c Point.h Movable.h Sprite.h Movable.h Main.h \
	Chars.h 
Sprite.asm: Sprite.c Movable.h Sprite.h Movable.h Vram.h 
Stage.asm: Stage.c Stage.h Stages.h Stage.h Main.h Sprite.h \
	Movable.h VVram.h Status.h Man.h Movable.h Chars.h \
	Monster.h Movable.h Knife.h Movable.h Point.h Movable.h \
	Vram.h 
Stages.asm: Stages.c Stage.h Stages.h Stage.h 
Status.asm: Status.c Status.h Vram.h Stage.h Main.h Sprite.h \
	Movable.h Print.h Chars.h 
Vram.asm: Vram.c Vram.h 
VVram.asm: VVram.c VVram.h Sprite.h Movable.h Vram.h 
Chars.obj: Chars.asm 
Loader.obj: Loader.asm BinSize.inc 
Math.obj: Math.asm ZeroPage.inc 
Print.obj: Print.asm apple2.inc apple2gs.inc Zeropage.inc Vram.inc 
ScanKeys.obj: ScanKeys.asm Apple2.inc ZeroPage.inc 
Sound.obj: Sound.asm apple2.inc apple2gs.inc Zeropage.inc 
StageA.obj: StageA.asm Zeropage.inc 
Startup.obj: Startup.asm apple2.inc apple2gs.inc 
VramA.obj: VramA.asm apple2.inc apple2gs.inc Zeropage.inc Vram.inc VVram.inc \
	Chars.inc 
VVramA.obj: VVramA.asm ZeroPage.inc 
Wav1.obj: Wav1.asm 
Wav2.obj: Wav2.asm 
ZeroPage.obj: ZeroPage.asm 

objects = Startup.obj \
	Knife.obj Main.obj Man.obj Monster.obj Movable.obj Point.obj \
	Sprite.obj Stage.obj Stages.obj Status.obj Vram.obj VVram.obj \
	Chars.obj Math.obj Print.obj ScanKeys.obj Sound.obj StageA.obj \
	VramA.obj VVramA.obj Wav1.obj Wav2.obj ZeroPage.obj \
	..\..\cate\cate816.lib

$(name).bin: $(objects) makefile
	LinkLE.exe $(name).bin $(cseg) $(dseg) $(zseg) $(objects)

BinSize.inc: $(name).bin BinSize.csx
	dotnet script BinSize.csx $(name) $(cseg)

Loader.bin: Loader.obj BinSize.inc makefile 
	LinkLE.exe Loader.bin 0800 08f0 00e0 Loader.obj

$(name).dsk: $(name).bin Loader.bin Disk.csx
	dotnet script Disk.csx $(name)
