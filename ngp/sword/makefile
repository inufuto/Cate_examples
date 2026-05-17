name=sword

all: $(name).ngp

cseg=200000
dseg=006000

.c.asm:
	Cate900 $*.c

.asm.obj:
	Asm900 -v2 $*.asm

Ball.asm: Ball.c Ball.h Movable.h Stage.h Movable.h Stages.h \
	Stage.h Movable.h Sprite.h Movable.h Chars.h Enemy.h \
	Movable.h Man.h Movable.h 
Enemy.asm: Enemy.c Enemy.h Movable.h Stage.h Movable.h Monster.h \
	Movable.h Ball.h Movable.h 
Main.asm: Main.c Main.h Status.h ScanKeys.h Stage.h Movable.h \
	Sound.h Man.h Movable.h Monster.h Movable.h Ball.h \
	Movable.h Point.h Movable.h 
Man.asm: Man.c Man.h Movable.h Stage.h Movable.h Sprite.h \
	Movable.h Chars.h ScanKeys.h Sound.h Monster.h Movable.h \
	Status.h Main.h Point.h Movable.h OneUp.h Movable.h 
Monster.asm: Monster.c Monster.h Movable.h Stage.h Movable.h Stages.h \
	Stage.h Movable.h Sprite.h Movable.h Chars.h Math.h \
	Man.h Movable.h Enemy.h Movable.h Sound.h Point.h \
	Movable.h OneUp.h Movable.h 
Movable.asm: Movable.c Movable.h Stage.h Movable.h 
OneUp.asm: OneUp.c OneUp.h Movable.h Sprite.h Movable.h Chars.h \
	Math.h Main.h Stage.h Movable.h Sound.h Status.h 
Point.asm: Point.c Point.h Movable.h Sprite.h Movable.h Chars.h \
	Main.h 
Stage.asm: Stage.c Stage.h Movable.h Stages.h Stage.h Movable.h \
	Main.h Vram.h Chars.h Man.h Movable.h Monster.h \
	Movable.h Ball.h Movable.h Status.h Point.h Movable.h \
	Math.h OneUp.h Movable.h 
Stages.asm: Stages.c Stage.h Movable.h Stages.h Stage.h Movable.h 
Status.asm: Status.c Status.h Vram.h Main.h Sprite.h Movable.h \
	Print.h Chars.h 
Vram.asm: Vram.c Vram.h Chars.h 
ColorChars.obj: ColorChars.asm 
Math.obj: Math.asm 
MonoChars.obj: MonoChars.asm 
Print.obj: Print.asm 
ScanKeys.obj: ScanKeys.asm ngp.inc 
Sound.obj: Sound.asm ngp.inc SubBin.inc Sound.inc 
Sprite.obj: Sprite.asm ngp.inc Vram.inc Sprite.inc Chars.inc 
StageA.obj: StageA.asm 
Startup.obj: Startup.asm ngp.inc 
SubBin.obj: SubBin.asm 
SubMain.obj: SubMain.asm Sound.inc 
VramA.obj: VramA.asm ngp.inc Vram.inc Chars.inc 

objects = Startup.obj \
	Ball.obj Enemy.obj Main.obj Man.obj Monster.obj Movable.obj \
	OneUp.obj Point.obj Stage.obj Stages.obj Status.obj Vram.obj \
	ColorChars.obj Math.obj MonoChars.obj Print.obj ScanKeys.obj Sound.obj \
	Sprite.obj StageA.obj SubBin.obj VramA.obj \
	..\..\cate\cate900.lib

$(name).bin: $(objects) makefile 
	LinkLE -dseg $(name).bin $(cseg) $(dseg) $(objects)

SubMain.obj:
	Asm80 -v2 SubMain.asm

SubBin.bin: SubMain.obj makefile
	LinkLE.exe SubBin.bin 0000 0f00 SubMain.obj

SubBin.asm SubBin.inc: SubBin.bin BinAsm.csx
	dotnet script BinAsm.csx

BinSize.inc: $(name).bin BinSize.csx makefile
	dotnet script BinSize.csx $(name)

$(name).ngp: $(name).bin MakeRom.csx
	dotnet script MakeRom.csx $(name)
