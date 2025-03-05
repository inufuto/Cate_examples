name=hopman

all:$(name).dsk

cseg=6000
zseg=00e0-00ff,0000
dseg=1000

.c.asm:
	Cate65.exe $*.c

.asm.obj:
	Asm65.exe $*.asm

Goal.asm: Goal.c Goal.h Movable.h Stage.h Movable.h Sprite.h \
	Movable.h Chars.h VVram.h 
Lift.asm: Lift.c Lift.h Movable.h Stages.h Stage.h Movable.h \
	Chars.h Sprite.h Movable.h Vram.h Man.h Movable.h 
Main.asm: Main.c Main.h ScanKeys.h Vram.h Sound.h Sprite.h \
	Movable.h Status.h Stage.h Movable.h Man.h Movable.h \
	Lift.h Movable.h Monster.h Movable.h VVram.h 
Man.asm: Man.c Man.h Movable.h Stage.h Movable.h Chars.h \
	Sprite.h Movable.h ScanKeys.h Sound.h Goal.h Movable.h \
	Stage.h Movable.h Vram.h Main.h Lift.h Movable.h \
	VVram.h 
Monster.asm: Monster.c Monster.h Movable.h Stages.h Stage.h Movable.h \
	Chars.h Sprite.h Movable.h Vram.h Man.h Movable.h 
Movable.asm: Movable.c Movable.h Stage.h Movable.h Lift.h Movable.h 
Stage.asm: Stage.c Stage.h Movable.h Stages.h Stage.h Movable.h \
	Main.h Vram.h Sprite.h Movable.h Status.h CopyMemory.h \
	Man.h Movable.h Goal.h Movable.h Stage.h Movable.h \
	Lift.h Movable.h Monster.h Movable.h VVram.h 
Stages.asm: Stages.c Stage.h Movable.h Stages.h Stage.h Movable.h 
Status.asm: Status.c Status.h Vram.h Stage.h Movable.h Main.h \
	Movable.h Sprite.h Movable.h Print.h Chars.h 
Vram.asm: Vram.c Vram.h Chars.h 
VVram.asm: VVram.c VVram.h Chars.h Sprite.h Movable.h Vram.h \
	Goal.h Movable.h Stage.h Movable.h Sound.h 
Chars.obj: Chars.asm 
CopyMemory.obj: CopyMemory.asm ZeroPage.inc 
Loader.obj: Loader.asm BinSize.inc
Print.obj: Print.asm 
ScanKeys.obj: ScanKeys.asm Apple2.inc ZeroPage.inc 
Sound.obj: Sound.asm Apple2.inc ZeroPage.inc 
SpriteA.obj: SpriteA.asm Zeropage.inc Vram.inc VVram.inc 
StageA.obj: StageA.asm ZeroPage.inc 
Startup.obj: Startup.asm Apple2.inc 
VramA.obj: VramA.asm Zeropage.inc Vram.inc VVram.inc Chars.inc 
VVramA.obj: VVramA.asm ZeroPage.inc VVram.inc Vram.inc Chars.inc 
ZeroPage.obj: ZeroPage.asm 

objects = Startup.obj \
	Goal.obj Lift.obj Main.obj Man.obj Monster.obj Movable.obj \
	Stage.obj Stages.obj Status.obj Vram.obj VVram.obj Chars.obj \
	CopyMemory.obj Print.obj ScanKeys.obj Sound.obj SpriteA.obj StageA.obj \
	VramA.obj VVramA.obj ZeroPage.obj \
	..\..\cate\cate65.lib

$(name).bin: $(objects) makefile
	LinkLE.exe $(name).bin $(cseg) $(dseg) $(zseg) $(objects)

BinSize.inc: $(name).bin BinSize.csx
	dotnet script BinSize.csx $(name) $(cseg)

Loader.bin: Loader.obj BinSize.inc makefile 
	LinkLE.exe Loader.bin 0800 08f0 00e0 Loader.obj

$(name).dsk: $(name).bin Loader.bin Disk.csx
	dotnet script Disk.csx $(name)
