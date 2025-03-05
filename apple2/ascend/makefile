name=ascend

all:$(name).dsk

cseg=4000
zseg=00E0 
dseg=1000

.c.asm:
	Cate65.exe $*.c

.asm.obj:
	Asm65.exe $*.asm

Actor.asm: Actor.c Movable.h Actor.h Stage.h Block.h Sprite.h \
	Man.h 
Block.asm: Block.c Movable.h Sprite.h Actor.h Block.h Chars.h \
	Stage.h Stages.h Vram.h Man.h 
Fire.asm: Fire.c Movable.h Sprite.h Actor.h Fire.h Chars.h \
	Math.h Main.h Stage.h Man.h Vram.h VVram.h 
Main.asm: Main.c Main.h ScanKeys.h Vram.h Sound.h Status.h \
	Movable.h Actor.h Stage.h Sprite.h Man.h Fire.h \
	Monster.h VVram.h 
Man.asm: Man.c Movable.h Sprite.h Actor.h Man.h Stage.h \
	Chars.h ScanKeys.h Vram.h Block.h Sound.h Main.h \
	Fire.h Status.h VVram.h 
Monster.asm: Monster.c Movable.h Sprite.h Actor.h Monster.h Chars.h \
	Math.h Main.h Stage.h Man.h Vram.h 
Movable.asm: Movable.c Movable.h 
Print.asm: Print.c Print.h Vram.h 
Sprite.asm: Sprite.c Movable.h Sprite.h Chars.h VVram.h Vram.h \
	Stage.h 
Stage.asm: Stage.c Vram.h Stage.h Stages.h Main.h Chars.h \
	Status.h Movable.h Actor.h Man.h Sprite.h Stage.h \
	Fire.h Monster.h Block.h Math.h VVram.h 
Stages.asm: Stages.c Stage.h Stages.h 
Status.asm: Status.c Status.h Vram.h Stage.h Main.h Movable.h \
	Sprite.h Print.h Chars.h 
Vram.asm: Vram.c Vram.h VVram.h CopyMemory.h Chars.h 
VVram.asm: VVram.c VVram.h Chars.h Movable.h Sprite.h Vram.h \
	Sound.h 
Chars.obj: Chars.asm 
CopyMemory.obj: CopyMemory.asm ZeroPage.inc 
Loader.obj: Loader.asm BinSize.inc 
Math.obj: Math.asm 
ScanKeys.obj: ScanKeys.asm Apple2.inc ZeroPage.inc 
Sound.obj: Sound.asm Apple2.inc ZeroPage.inc 
Startup.obj: Startup.asm Apple2.inc 
VramA.obj: VramA.asm ZeroPage.inc Vram.inc VVram.inc 
VVramA.obj: VVramA.asm ZeroPage.inc VVram.inc Chars.inc 
ZeroPage.obj: ZeroPage.asm 

objects = Startup.obj \
	Actor.obj Block.obj Fire.obj Main.obj Man.obj Monster.obj \
	Movable.obj Print.obj Sprite.obj Stage.obj Stages.obj Status.obj \
	Vram.obj VVram.obj Chars.obj CopyMemory.obj Math.obj ScanKeys.obj \
	Sound.obj VramA.obj VVramA.obj ZeroPage.obj \
	..\..\cate\cate65.lib

$(name).bin: $(objects)
	LinkLE.exe $(name).bin $(cseg) $(dseg) $(zseg) $(objects)

BinSize.inc: $(name).bin BinSize.csx
	dotnet script BinSize.csx $(name) $(cseg)

Loader.bin: Loader.obj BinSize.inc makefile 
	LinkLE.exe Loader.bin 0800 08f0 00e0 Loader.obj

$(name).dsk: $(name).bin Loader.bin Disk.csx
	dotnet script Disk.csx $(name)
