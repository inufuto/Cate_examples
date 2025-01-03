name=mieyen

all: $(name).1dd $(name)_t.bin loader.txt

cseg_d=0100
dseg_d=3000
cseg_t=0200 # l 0200
dseg_t=3000

.c.asm:
	Cate80.exe $*.c

.asm.obj:
	Asm80.exe $*.asm

Fire.asm: Fire.c Fire.h Movable.h Sprite.h Movable.h Sound.h \
	Chars.h Man.h Movable.h Monster.h Movable.h Point.h \
	Movable.h 
Main.asm: Main.c Main.h Status.h ScanKeys.h Stage.h Sprite.h \
	Movable.h Sound.h Man.h Movable.h Monster.h Movable.h \
	Fire.h Movable.h Point.h Movable.h VVram.h 
Man.asm: Man.c Man.h Movable.h Sprite.h Movable.h Chars.h \
	Stage.h ScanKeys.h Sound.h Fire.h Movable.h Main.h \
	VVram.h 
Monster.asm: Monster.c Monster.h Movable.h Stage.h Stages.h Stage.h \
	Sprite.h Movable.h Chars.h Math.h Status.h Main.h \
	Sound.h Man.h Movable.h 
Movable.asm: Movable.c Movable.h Stage.h Sprite.h Movable.h 
Point.asm: Point.c Point.h Movable.h Sprite.h Movable.h Main.h \
	Chars.h VVram.h 
Sprite.asm: Sprite.c Sprite.h Movable.h Chars.h VVram.h Vram.h 
Stage.asm: Stage.c Stage.h Stages.h Stage.h Main.h Math.h \
	Sprite.h Movable.h Status.h Chars.h VVram.h CopyMemory.h \
	Man.h Movable.h Monster.h Movable.h Fire.h Movable.h \
	Point.h Movable.h Vram.h 
Stages.asm: Stages.c Stage.h Stages.h Stage.h 
Status.asm: Status.c Status.h Vram.h Stage.h Main.h Sprite.h \
	Movable.h Print.h Chars.h 
Vram.asm: Vram.c Vram.h 
VVram.asm: VVram.c VVram.h Sprite.h Movable.h Vram.h Chars.h \
	Point.h Movable.h Sound.h 
Chars.obj: Chars.asm 
CopyMemory.obj: CopyMemory.asm 
Loader.obj: Loader.asm BinSize.inc 
Math.obj: Math.asm 
Print.obj: Print.asm 
ScanKeys.obj: ScanKeys.asm 
Sound.obj: Sound.asm 
Sound70.obj: Sound70.asm 
Sound777.obj: Sound777.asm 
StageA.obj: StageA.asm 
Startup.obj: Startup.asm 
VramA.obj: VramA.asm Vram.inc VVram.inc Chars.inc 
VVramA.obj: VVramA.asm VVram.inc 

objects = Startup.obj \
	Fire.obj Main.obj Man.obj Monster.obj Movable.obj Point.obj \
	Sprite.obj Stage.obj Stages.obj Status.obj Vram.obj VVram.obj \
	Chars.obj CopyMemory.obj Math.obj Print.obj ScanKeys.obj Sound.obj \
	Sound70.obj Sound777.obj StageA.obj VramA.obj VVramA.obj \
	..\..\cate\cate80.lib

$(filename).exe: $(objects) makefile
	LinkLE.exe $(name)_d.bin $(cseg_d) $(dseg_d) $(objects)
	copy $(name)_d.bin $(filename).exe /y

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
