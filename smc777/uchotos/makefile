name=uchotos

all: $(name).1dd $(name)_t.bin loader.txt

cseg_d=0100
dseg_d=2c00
cseg_t=0200 # l 0200
dseg_t=2c00

.c.asm:
	Cate80.exe $*.c

.asm.obj:
	Asm80.exe -v2 $*.asm

Debri.asm: Debri.c Debri.h Movable.h Sprite.h Movable.h Chars.h \
	Stage.h Movable.h 
Fire.asm: Fire.c Fire.h Movable.h Sprite.h Movable.h Man.h \
	Movable.h Chars.h Monster.h Movable.h Stage.h Movable.h \
	Main.h Sound.h ScanKeys.h 
Main.asm: Main.c Main.h Status.h ScanKeys.h Stage.h Movable.h \
	Man.h Movable.h Monster.h Movable.h Fire.h Movable.h \
	Debri.h Movable.h Sound.h VVram.h 
Man.asm: Man.c Man.h Movable.h ScanKeys.h Chars.h Sprite.h \
	Movable.h Stage.h Movable.h Fire.h Movable.h Sound.h \
	Main.h Status.h OneUp.h Movable.h 
Monster.asm: Monster.c Monster.h Movable.h Sprite.h Movable.h Stage.h \
	Movable.h Chars.h Math.h Man.h Movable.h Debri.h \
	Movable.h OneUp.h Movable.h 
Movable.asm: Movable.c Movable.h Stage.h Movable.h 
OneUp.asm: OneUp.c OneUp.h Movable.h Sprite.h Movable.h Chars.h \
	Math.h Main.h Stage.h Movable.h Sound.h Status.h 
Sprite.asm: Sprite.c Movable.h Sprite.h Movable.h Vram.h VVram.h \
	Chars.h 
Stage.asm: Stage.c Stage.h Movable.h Stages.h Stage.h Movable.h \
	Main.h Math.h Chars.h VVram.h Status.h Man.h \
	Movable.h Monster.h Movable.h Fire.h Movable.h Debri.h \
	Movable.h Sprite.h Movable.h OneUp.h Movable.h Vram.h 
Stages.asm: Stages.c Stage.h Movable.h Stages.h Stage.h Movable.h 
Status.asm: Status.c Status.h Vram.h Stage.h Movable.h Main.h \
	Sprite.h Movable.h Print.h Chars.h 
Vram.asm: Vram.c Vram.h Chars.h 
VVram.asm: VVram.c VVram.h Sprite.h Movable.h Vram.h Sound.h 
Chars.obj: Chars.asm 
Loader.obj: Loader.asm BinSize.inc 
Math.obj: Math.asm 
Print.obj: Print.asm 
ScanKeys.obj: ScanKeys.asm 
Sound.obj: Sound.asm 
Sound70.obj: Sound70.asm 
Sound777.obj: Sound777.asm 
StageA.obj: StageA.asm Vram.inc 
Startup.obj: Startup.asm 
VramA.obj: VramA.asm Vram.inc VVram.inc Chars.inc 
VVramA.obj: VVramA.asm VVram.inc 

objects = Startup.obj \
	Debri.obj Fire.obj Main.obj Man.obj Monster.obj Movable.obj \
	OneUp.obj Sprite.obj Stage.obj Stages.obj Status.obj Vram.obj \
	VVram.obj Chars.obj Math.obj Print.obj ScanKeys.obj Sound.obj \
	Sound70.obj Sound777.obj StageA.obj VramA.obj VVramA.obj \
	..\..\cate\cate80.lib

BinSize.inc: $(name)_d.bin BinSize.csx
	dotnet script BinSize.csx $(name)

Loader.bin: Loader.obj makefile
	LinkLE.exe Loader.bin 0000 0200 Loader.obj

$(name)_d.bin: $(objects) makefile
	LinkLE.exe $(name)_d.bin $(cseg_d) $(dseg_d) $(objects)

$(name).1dd: $(name)_d.bin Loader.bin disk.csx
	dotnet script Disk.csx $(name)

$(name)_t.bin: $(objects) makefile
	LinkLE.exe $(name)_t.bin $(cseg_t) $(dseg_t) $(objects)

loader.txt: $(name)_t.bin Basic70.csx
	dotnet script Basic70.csx $(name) $(cseg_t)
