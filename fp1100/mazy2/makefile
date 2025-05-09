name=mazy2

# SAVEM "CAS0:MAZY2",&hA800,&hD368,&hA800

all: $(name).bin

cseg=a800
dseg=d400

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
Sprite.asm: Sprite.c Sprite.h Movable.h Chars.h VVram.h Vram.h 
Stage.asm: Stage.c Stage.h Stages.h Stage.h Main.h Sprite.h \
	Movable.h VVram.h Status.h Man.h Movable.h Chars.h \
	Monster.h Movable.h Knife.h Movable.h Point.h Movable.h \
	Vram.h 
Stages.asm: Stages.c Stage.h Stages.h Stage.h 
Status.asm: Status.c Status.h Vram.h Stage.h Main.h Sprite.h \
	Movable.h Print.h Chars.h 
Vram.asm: Vram.c Vram.h 
VVram.asm: VVram.c VVram.h Sprite.h Movable.h Vram.h Chars.h \
	Sound.h 
Chars.obj: Chars.asm 
Math.obj: Math.asm 
Print.obj: Print.asm 
ScanKeys.obj: ScanKeys.asm SubMainBin.inc 
Sound.obj: Sound.asm SubMainBin.inc 
StageA.obj: StageA.asm 
Startup.obj: Startup.asm 
SubLoader.obj: SubLoader.asm SubMainBin.inc 
SubLoaderBin.obj: SubLoaderBin.asm 
SubMain.obj: SubMain.asm 
SubMainBin.obj: SubMainBin.asm 
SubSys.obj: SubSys.asm SubLoaderBin.inc SubMainBin.inc 
VramA.obj: VramA.asm Vram.inc VVram.inc Chars.inc SubMainBin.inc 
VVramA.obj: VVramA.asm VVram.inc 

objects = Startup.obj \
	Knife.obj Main.obj Man.obj Monster.obj Movable.obj Point.obj \
	Sprite.obj Stage.obj Stages.obj Status.obj Vram.obj VVram.obj \
	Chars.obj Math.obj Print.obj ScanKeys.obj Sound.obj StageA.obj \
	SubLoader.obj SubLoaderBin.obj SubMainBin.obj SubSys.obj VramA.obj VVramA.obj \
	..\..\cate\cate80.lib

$(name).cmt: $(objects) makefile
	LinkLE.exe $(name).cmt $(cseg) $(dseg) $(objects)


SubLoader.obj:
	Asm87 SubLoader.asm

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
