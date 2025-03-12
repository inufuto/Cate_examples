name=battlot

all: $(name).gtr

cseg=fffa-ffff,c000
dseg=0200
zseg=0000

.c.asm:
	Cate65.exe -65c02 -v2 $*.c

.asm.obj:
	Asm65.exe -65c02 $*.asm

Bang.asm: Bang.c Bang.h Sprite.h Stage.h Chars.h 
Bullet.asm: Bullet.c Bullet.h Sprite.h Stage.h Direction.h Stage.h \
	Robo.h Bullet.h Fort.h Chars.h 
Direction.asm: Direction.c Direction.h 
EnemyRobo.asm: EnemyRobo.c Robo.h Bullet.h Sprite.h Main.h Fort.h \
	Stage.h Direction.h Bullet.h Bang.h Sound.h Chars.h 
Fort.asm: Fort.c Fort.h VVram.h Chars.h Stage.h Robo.h \
	Bullet.h Bang.h Sprite.h Sound.h 
Main.asm: Main.c Main.h Stage.h ScanKeys.h Status.h Sprite.h \
	Vram.h VVram.h Robo.h Bullet.h Bullet.h Bang.h \
	Fort.h Sound.h 
MyRobo.asm: MyRobo.c Robo.h Bullet.h Sprite.h Direction.h Stage.h \
	ScanKeys.h Fort.h Bang.h Main.h Sound.h Chars.h 
Robo.asm: Robo.c Robo.h Bullet.h Direction.h Sprite.h Stage.h \
	Fort.h Bullet.h 
Sprite.asm: Sprite.c Sprite.h Vram.h VVram.h VVram.h 
Stage.asm: Stage.c Stage.h Stages.h Main.h Sprite.h Vram.h \
	VVram.h Chars.h Fort.h Robo.h Bullet.h Bullet.h \
	Bang.h VVram.h 
Stages.asm: Stages.c Stage.h Stages.h 
Status.asm: Status.c Status.h Vram.h VVram.h Stage.h Main.h \
	Sprite.h Print.h Chars.h 
Vram.asm: Vram.c Vram.h VVram.h Chars.h Sprite.h 
VVram.asm: VVram.c VVram.h Chars.h 
Chars.obj: Chars.asm 
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
	Bang.obj Bullet.obj Direction.obj EnemyRobo.obj Fort.obj Main.obj \
	MyRobo.obj Robo.obj Sprite.obj Stage.obj Stages.obj Status.obj \
	Vram.obj VVram.obj Chars.obj Print.obj ScanKeys.obj Sound.obj \
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
