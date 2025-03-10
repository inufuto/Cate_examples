name=antiair

all: $(name).gtr

cseg=fffa-ffff,c000
dseg=0200
zseg=0000

.c.asm:
	Cate65.exe -65c02 -v2 $*.c

.asm.obj:
	Asm65.exe -65c02 $*.asm

Bang.asm: Bang.c Bang.h Movable.h VVram.h Sprite.h Movable.h \
	Stage.h Chars.h 
Block.asm: Block.c Block.h Movable.h Sprite.h Movable.h Chars.h \
	VVram.h CopyMemory.h Chars.h Bang.h Movable.h Sound.h \
	Cannon.h Movable.h Status.h 
Bullet.asm: Bullet.c Bullet.h Sprite.h Movable.h Chars.h VVram.h \
	Sound.h Cannon.h Movable.h Ufo.h Stage.h Block.h \
	Movable.h 
Cannon.asm: Cannon.c Cannon.h Movable.h VVram.h Sprite.h Movable.h \
	Chars.h ScanKeys.h Bullet.h Block.h Movable.h Bang.h \
	Movable.h Sound.h 
Main.asm: Main.c Status.h ScanKeys.h Sound.h Stage.h Cannon.h \
	Movable.h Sprite.h Movable.h Bullet.h Vram.h VVram.h \
	VVram.h Ufo.h Stage.h Bang.h Movable.h Block.h \
	Movable.h Status.h 
Sprite.asm: Sprite.c Movable.h Sprite.h Movable.h Vram.h VVram.h 
Stage.asm: Stage.c Stages.h Stage.h Vram.h VVram.h VVram.h \
	Math.h Status.h Sprite.h Movable.h Cannon.h Movable.h \
	Bullet.h Ufo.h Stage.h Bang.h Movable.h Block.h \
	Movable.h 
Stages.asm: Stages.c Stages.h Stage.h 
Status.asm: Status.c Status.h Vram.h VVram.h Print.h Chars.h \
	Sprite.h Movable.h 
Ufo.asm: Ufo.c Ufo.h Stage.h VVram.h Movable.h CopyMemory.h \
	Chars.h Bang.h Movable.h Sound.h Block.h Movable.h \
	Math.h Status.h 
Vram.asm: Vram.c Vram.h VVram.h VVram.h Chars.h Ufo.h \
	Stage.h Block.h Movable.h Sprite.h Movable.h 
VVram.asm: VVram.c Vram.h VVram.h VVram.h Chars.h Sprite.h \
	Movable.h Sound.h Stage.h 
Chars.obj: Chars.asm 
CopyMemory.obj: CopyMemory.asm ZeroPage.inc 
Math.obj: Math.asm 
Print.obj: Print.asm 
ScanKeys.obj: ScanKeys.asm gametank.inc 
Sound.obj: Sound.asm ZeroPage.inc gametank.inc SubBin.inc 
Startup.obj: Startup.asm ZeroPage.inc gametank.inc 
SubBin.obj: SubBin.asm 
SubMain.obj: SubMain.asm 
Vectors.obj: Vectors.asm 
VramA.obj: VramA.asm ZeroPage.inc gametank.inc Vram.inc VVram.inc Chars.inc 
VVramA.obj: VVramA.asm ZeroPage.inc VVram.inc Chars.inc 
ZeroPage.obj: ZeroPage.asm 

objects = Vectors.obj Startup.obj \
	Bang.obj Block.obj Bullet.obj Cannon.obj Main.obj Sprite.obj \
	Stage.obj Stages.obj Status.obj Ufo.obj Vram.obj VVram.obj \
	Chars.obj CopyMemory.obj Math.obj Print.obj ScanKeys.obj Sound.obj \
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
