name=sword

# SAVEM "CAS0:SWORD",&hA800,&hD066,&hA800

all: $(name).bin

cseg=a800
dseg=d400

.c.asm:
	Cate80.exe $*.c

.asm.obj:
	Asm80.exe -v2 $*.asm

Ball.asm: Ball.c Ball.h Movable.h Stage.h Movable.h Stages.h \
	Stage.h Movable.h Sprite.h Movable.h Chars.h Enemy.h \
	Movable.h Man.h Movable.h 
Enemy.asm: Enemy.c Enemy.h Movable.h Stage.h Movable.h Monster.h \
	Movable.h Ball.h Movable.h 
Main.asm: Main.c Main.h Status.h ScanKeys.h Stage.h Movable.h \
	Sound.h Man.h Movable.h Monster.h Movable.h Ball.h \
	Movable.h Point.h Movable.h Vram.h 
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
Sprite.asm: Sprite.c Sprite.h Movable.h Chars.h VVram.h 
Stage.asm: Stage.c Stage.h Movable.h Stages.h Stage.h Movable.h \
	Main.h VVram.h Chars.h Man.h Movable.h Monster.h \
	Movable.h Ball.h Movable.h Status.h Point.h Movable.h \
	Math.h OneUp.h Movable.h Vram.h 
Stages.asm: Stages.c Stage.h Movable.h Stages.h Stage.h Movable.h 
Status.asm: Status.c Status.h Vram.h Stage.h Movable.h Main.h \
	Sprite.h Movable.h Print.h Chars.h VVram.h 
Vram.asm: Vram.c Vram.h VVram.h Chars.h Sprite.h Movable.h \
	Sound.h 
VVram.asm: VVram.c VVram.h Sprite.h Movable.h Vram.h Chars.h 
Chars.obj: Chars.asm 
Math.obj: Math.asm 
Print.obj: Print.asm 
ScanKeys.obj: ScanKeys.asm SubMainBin.inc 
Sound.obj: Sound.asm SubMainBin.inc 
StageA.obj: StageA.asm Vram.inc Chars.inc 
Startup.obj: Startup.asm 
SubLoader.obj: SubLoader.asm SubMainBin.inc 
SubLoaderBin.obj: SubLoaderBin.asm 
SubMain.obj: SubMain.asm 
SubMainBin.obj: SubMainBin.asm 
SubSys.obj: SubSys.asm SubLoaderBin.inc SubMainBin.inc 
VramA.obj: VramA.asm Vram.inc VVram.inc Chars.inc SubMainBin.inc 
VVramA.obj: VVramA.asm VVram.inc 

objects = Startup.obj \
	Ball.obj Enemy.obj Main.obj Man.obj Monster.obj Movable.obj \
	OneUp.obj Point.obj Sprite.obj Stage.obj Stages.obj Status.obj \
	Vram.obj VVram.obj Chars.obj Math.obj Print.obj ScanKeys.obj \
	Sound.obj StageA.obj SubLoader.obj SubLoaderBin.obj SubMainBin.obj SubSys.obj \
	VramA.obj VVramA.obj \
	..\..\cate\cate80.lib

SubLoader.obj:
	Asm87 -v2 SubLoader.asm

SubLoader.bin: SubLoader.obj makefile
	LinkLE.exe SubLoader.bin 3a60 8000 SubLoader.obj

SubLoaderBin.asm SubLoaderBin.inc: SubLoader.bin BinAsm.csx
	dotnet script BinAsm.csx SubLoader


SubMain.obj:
	Asm87 SubMain.asm

SubMain.bin: SubMain.obj makefile
	LinkLE.exe SubMain.bin ff80 8000 SubMain.obj

SubMainBin.asm SubMainBin.inc: SubMain.bin BinAsm.csx
	dotnet script BinAsm.csx SubMain


$(name).bin: $(objects) makefile
	LinkLE.exe $(name).bin $(cseg) $(dseg) $(objects)
