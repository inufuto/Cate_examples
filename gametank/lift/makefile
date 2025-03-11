name=lift

all: $(name).gtr

cseg=fffa-ffff,c000
dseg=0200
zseg=0000

.c.asm:
	Cate65.exe -65c02 -v2 $*.c

.asm.obj:
	Asm65.exe -65c02 $*.asm

Actor.asm: Actor.c Movable.h Actor.h Stage.h Lift.h 
Item.asm: Item.c Item.h Stage.h Stages.h Vram.h VVram.h \
	Chars.h Main.h Movable.h Actor.h Man.h Point.h \
	Movable.h Sound.h Sprite.h Movable.h VVram.h 
Lift.asm: Lift.c Movable.h Actor.h Lift.h Stage.h Stages.h \
	Vram.h VVram.h Chars.h Sprite.h Movable.h Man.h \
	Monster.h VVram.h 
Main.asm: Main.c Main.h ScanKeys.h Movable.h Sprite.h Movable.h \
	Vram.h VVram.h Sound.h Status.h Stage.h Actor.h \
	Monster.h Lift.h Man.h Item.h Point.h Movable.h 
Man.asm: Man.c Movable.h Actor.h Man.h Stage.h Sprite.h \
	Movable.h Chars.h ScanKeys.h Item.h Sound.h Vram.h \
	VVram.h 
Math.asm: Math.c Math.h 
Monster.asm: Monster.c Movable.h Actor.h Monster.h Stages.h Stage.h \
	Sprite.h Movable.h Chars.h Man.h Lift.h 
Movable.asm: Movable.c Movable.h Stage.h Actor.h Lift.h 
Point.asm: Point.c Point.h Movable.h Sprite.h Movable.h Main.h \
	Chars.h 
Sprite.asm: Sprite.c Sprite.h Movable.h Vram.h VVram.h 
Stage.asm: Stage.c Stage.h Stages.h Main.h VVram.h Movable.h \
	Sprite.h Movable.h Chars.h Status.h Item.h Actor.h \
	Man.h Lift.h Monster.h Point.h Movable.h Vram.h \
	VVram.h CopyMemory.h 
Stages.asm: Stages.c Stage.h Stages.h 
Status.asm: Status.c Status.h Vram.h VVram.h Main.h Movable.h \
	Sprite.h Movable.h Print.h Chars.h 
Vram.asm: Vram.c Vram.h VVram.h Chars.h Sprite.h Movable.h 
VVram.asm: VVram.c VVram.h Chars.h 
Chars.obj: Chars.asm 
CopyMemory.obj: CopyMemory.asm ZeroPage.inc 
Print.obj: Print.asm 
ScanKeys.obj: ScanKeys.asm gametank.inc 
Sound.obj: Sound.asm ZeroPage.inc gametank.inc SubBin.inc 
Startup.obj: Startup.asm ZeroPage.inc gametank.inc 
SubBin.obj: SubBin.asm 
SubMain.obj: SubMain.asm 
Vectors.obj: Vectors.asm 
VramA.obj: VramA.asm ZeroPage.inc gametank.inc Vram.inc VVram.inc Chars.inc 
VVramA.obj: VVramA.asm ZeroPage.inc VVram.inc 
ZeroPage.obj: ZeroPage.asm 

objects = Vectors.obj Startup.obj \
	Actor.obj Item.obj Lift.obj Main.obj Man.obj Math.obj \
	Monster.obj Movable.obj Point.obj Sprite.obj Stage.obj Stages.obj \
	Status.obj Vram.obj VVram.obj Chars.obj CopyMemory.obj Print.obj \
	ScanKeys.obj Sound.obj SubBin.obj VramA.obj VVramA.obj ZeroPage.obj \
	..\..\cate\cate65.lib

$(name).bin: $(objects) makefile
	LinkLE.exe $(name).bin $(cseg) $(dseg) $(zseg) $(objects)

SubBin.bin: SubMain.obj makefile
	LinkLE.exe SubBin.bin 0200 3f00 0010 SubMain.obj

SubBin.asm SubBin.inc: SubBin.bin BinAsm.csx
	dotnet script BinAsm.csx

$(name).gtr: $(name).bin MakeRom.csx
	dotnet script MakeRom.csx $(name)
