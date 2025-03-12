name=ascend

all: $(name).gtr

cseg=fffa-ffff,c000
dseg=0200
zseg=0000

.c.asm:
	Cate65.exe -65c02 -v2 $*.c

.asm.obj:
	Asm65.exe -65c02 $*.asm

Actor.asm: Actor.c Movable.h Actor.h Stage.h Block.h Sprite.h \
	Vram.h Movable.h Man.h 
Block.asm: Block.c Movable.h Sprite.h Vram.h Movable.h Actor.h \
	Block.h Chars.h Stage.h Stages.h Vram.h Man.h \
	VVram.h 
Fire.asm: Fire.c Movable.h Sprite.h Vram.h Movable.h Actor.h \
	Fire.h Chars.h Math.h Main.h Stage.h Man.h \
	Vram.h 
Main.asm: Main.c Main.h ScanKeys.h Vram.h Sound.h Status.h \
	Movable.h Actor.h Stage.h Sprite.h Vram.h Movable.h \
	Man.h Fire.h Monster.h 
Man.asm: Man.c Movable.h Sprite.h Vram.h Movable.h Actor.h \
	Man.h Stage.h Chars.h ScanKeys.h Vram.h Block.h \
	Sound.h Main.h Fire.h Status.h Print.h 
Monster.asm: Monster.c Movable.h Sprite.h Vram.h Movable.h Actor.h \
	Monster.h Chars.h Math.h Main.h Stage.h Man.h \
	Vram.h 
Movable.asm: Movable.c Movable.h 
Sprite.asm: Sprite.c Movable.h Sprite.h Vram.h Movable.h Vram.h \
	Stage.h 
Stage.asm: Stage.c Vram.h Stage.h Stages.h Main.h Chars.h \
	Status.h Movable.h Actor.h Man.h Sprite.h Vram.h \
	Movable.h Stage.h Fire.h Monster.h Block.h Math.h \
	VVram.h 
Stages.asm: Stages.c Stage.h Stages.h 
Status.asm: Status.c Status.h Vram.h Main.h Print.h Chars.h \
	Movable.h Actor.h Sprite.h Vram.h Movable.h 
Vram.asm: Vram.c Vram.h vVram.h Sprite.h Vram.h Movable.h 
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
VramA.obj: VramA.asm ZeroPage.inc gametank.inc Vram.inc Chars.inc 
VVramA.obj: VVramA.asm ZeroPage.inc VVram.inc Chars.inc 
ZeroPage.obj: ZeroPage.asm 

objects = Vectors.obj Startup.obj \
	Actor.obj Block.obj Fire.obj Main.obj Man.obj Monster.obj \
	Movable.obj Sprite.obj Stage.obj Stages.obj Status.obj Vram.obj \
	VVram.obj Chars.obj Math.obj Print.obj ScanKeys.obj Sound.obj \
	SubBin.obj VramA.obj VVramA.obj ZeroPage.obj \
	..\..\cate\cate65.lib

$(name).bin: $(objects) makefile
	LinkLE.exe $(name).bin $(cseg) $(dseg) $(zseg) $(objects)

SubBin.bin: SubMain.obj makefile
	LinkLE.exe SubBin.bin 0200 3f00 0010 SubMain.obj

SubBin.asm SubBin.inc: SubBin.bin BinAsm.csx
	dotnet script BinAsm.csx

$(name).gtr: $(name).bin MakeRom.csx
	dotnet script MakeRom.csx $(name)
