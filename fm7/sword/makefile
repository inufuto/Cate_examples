name=sword

all: $(name).wav $(name).d88

cseg=1000
zseg=4000
dseg=4100

subcseg=c000
subdseg=c0e9

.c.asm:
	Cate09.exe $*.c

.asm.obj:
	Asm09.exe -v2 $*.asm

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
Sprite.asm: Sprite.c Movable.h Sprite.h Movable.h Vram.h VVram.h \
	Chars.h 
Stage.asm: Stage.c Stage.h Movable.h Stages.h Stage.h Movable.h \
	Main.h VVram.h Chars.h Man.h Movable.h Monster.h \
	Movable.h Ball.h Movable.h Status.h Point.h Movable.h \
	Math.h OneUp.h Movable.h Vram.h 
Stages.asm: Stages.c Stage.h Movable.h Stages.h Stage.h Movable.h 
Status.asm: Status.c Status.h Vram.h Stage.h Movable.h Main.h \
	Sprite.h Movable.h Print.h Chars.h VVram.h 
Vram.asm: Vram.c Vram.h VVram.h Chars.h Sprite.h Movable.h 
VVram.asm: VVram.c VVram.h Sprite.h Movable.h Vram.h Chars.h 
Chars.obj: Chars.asm 
Loader.obj: Loader.asm BinSize.inc 
LoaderInt.obj: LoaderInt.asm 
Math.obj: Math.asm 
Print.obj: Print.asm 
ScanKeys.obj: ScanKeys.asm 
SendSubsys.obj: SendSubsys.asm BIOS.inc SubBin.inc Vram.inc 
Sound.obj: Sound.asm 
StageA.obj: StageA.asm ZeroPage.inc VVram.inc Chars.inc 
Startup.obj: Startup.asm bios.inc 
subbin.obj: subbin.asm 
SubMain.obj: SubMain.asm Vram.inc Share.inc Chars.inc 
VramA.obj: VramA.asm BIOS.inc Vram.inc VVram.inc Chars.inc SubBin.inc \
	Share.inc 
VVramA.obj: VVramA.asm ZeroPage.inc VVram.inc 

objects = Startup.obj \
	Ball.obj Enemy.obj Main.obj Man.obj Monster.obj Movable.obj \
	OneUp.obj Point.obj Sprite.obj Stage.obj Stages.obj Status.obj \
	Vram.obj VVram.obj Chars.obj Math.obj Print.obj ScanKeys.obj \
	SendSubsys.obj Sound.obj StageA.obj subbin.obj VramA.obj VVramA.obj \
	..\..\cate\cate09.lib

$(name).bin: $(objects) makefile
	LinkBE.exe $(name).bin $(cseg) $(dseg) $(zseg) $(objects)

$(name).t77: $(name).bin 
	t77save.exe $(name).t77 -new -savem $(name).bin $(name) 0x$(cseg) 0x$(cseg)

BinSize.inc: $(name).bin BinSize.csx
	dotnet script BinSize.csx $(name)

Loader.bin: Loader.obj LoaderInt.obj makefile
	LinkBE.exe Loader.bin 01d1-01ff,0100 0200 LoaderInt.obj Loader.obj

SubMain.obj: SubMain.asm Vram.inc share.inc share.inc

SubBin.bin: SubMain.obj makefile
	LinkBE.exe SubBin.bin $(subcseg) $(subdseg) SubMain.obj

SubBin.asm SubBin.inc: SubBin.bin
	dotnet script BinAsm.csx

$(name).d88: $(name).bin Loader.bin disk.csx
	dotnet script disk.csx $(name)

$(name).wav: $(name).t77
	-T772WAV $(name).t77 $(name).wav
