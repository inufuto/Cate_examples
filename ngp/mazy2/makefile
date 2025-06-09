name=mazy2

all: $(name).ngp

cseg=200000
dseg=006000

.c.asm:
	Cate900 $*.c

.asm.obj:
	Asm900 $*.asm

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
Vram.asm: Vram.c Vram.h 
ColorChars.obj: ColorChars.asm 
Math.obj: Math.asm 
MonoChars.obj: MonoChars.asm 
Print.obj: Print.asm 
ScanKeys.obj: ScanKeys.asm ngp.inc 
Sound.obj: Sound.asm ngp.inc SubBin.inc Sound.inc 
Sprite.obj: Sprite.asm ngp.inc Vram.inc 
StageA.obj: StageA.asm 
Startup.obj: Startup.asm ngp.inc 
SubBin.obj: SubBin.asm 
SubMain.obj: SubMain.asm Sound.inc 
VramA.obj: VramA.asm ngp.inc Vram.inc Chars.inc 

objects = Startup.obj \
	Knife.obj Main.obj Man.obj Monster.obj Movable.obj Point.obj \
	Stage.obj Stages.obj Status.obj Vram.obj ColorChars.obj Math.obj \
	MonoChars.obj Print.obj ScanKeys.obj Sound.obj Sprite.obj StageA.obj \
	SubBin.obj VramA.obj \
	..\..\cate\cate900.lib

$(name).bin: $(objects) makefile 
	LinkLE -dseg $(name).bin $(cseg) $(dseg) $(objects)

SubMain.obj:
	Asm80 SubMain.asm

SubBin.bin: SubMain.obj makefile
	LinkLE.exe SubBin.bin 0000 0f00 SubMain.obj

SubBin.asm SubBin.inc: SubBin.bin BinAsm.csx
	dotnet script BinAsm.csx

BinSize.inc: $(name).bin BinSize.csx makefile
	dotnet script BinSize.csx $(name)

$(name).ngp: $(name).bin MakeRom.csx
	dotnet script MakeRom.csx $(name)
