name=cacorm

all: $(name).gtr

cseg=fffa-ffff,c000
dseg=0200
zseg=0000

.c.asm:
	Cate65.exe -65c02 -v2 $*.c

.asm.obj:
	Asm65.exe -65c02 $*.asm

Actor.asm: Actor.c Movable.h Actor.h 
Increaser.asm: Increaser.c Movable.h Increaser.h Sprite.h Chars.h 
Item.asm: Item.c Item.h Stage.h Stages.h Vram.h VVram.h \
	Chars.h Line.h Sound.h Movable.h Point.h Sprite.h \
	Main.h Increaser.h Math.h VVram.h 
Line.asm: Line.c Line.h Chars.h Stage.h Vram.h VVram.h \
	Movable.h Actor.h Sound.h Sprite.h Item.h Monster.h \
	VVram.h 
Main.asm: Main.c Main.h ScanKeys.h Vram.h VVram.h Sound.h \
	Status.h Movable.h Actor.h Stage.h Sprite.h Man.h \
	Monster.h Item.h Point.h 
Man.asm: Man.c Movable.h Actor.h Man.h Sprite.h Stage.h \
	ScanKeys.h Main.h Sound.h Chars.h Line.h Item.h \
	Vram.h VVram.h Status.h Increaser.h 
Monster.asm: Monster.c Movable.h Actor.h Monster.h Sprite.h Stage.h \
	Chars.h Math.h Man.h Line.h 
Movable.asm: Movable.c Movable.h Stage.h 
Point.asm: Point.c Movable.h Point.h Sprite.h Main.h Chars.h 
Sprite.asm: Sprite.c Movable.h Sprite.h Vram.h VVram.h VVram.h 
Stage.asm: Stage.c Stage.h Stages.h Main.h Vram.h VVram.h \
	Movable.h Actor.h Sprite.h Chars.h Status.h Man.h \
	Item.h Monster.h Point.h Increaser.h VVram.h 
Stages.asm: Stages.c Stage.h Stages.h 
Status.asm: Status.c Status.h Vram.h VVram.h Main.h Print.h \
	Chars.h Movable.h Sprite.h 
Vram.asm: Vram.c Vram.h VVram.h Chars.h Movable.h Sprite.h \
	Sound.h 
VVram.asm: VVram.c VVram.h Chars.h 
Chars.obj: Chars.asm 
Math.obj: Math.asm 
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
	Actor.obj Increaser.obj Item.obj Line.obj Main.obj Man.obj \
	Monster.obj Movable.obj Point.obj Sprite.obj Stage.obj Stages.obj \
	Status.obj Vram.obj VVram.obj Chars.obj Math.obj Print.obj \
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
