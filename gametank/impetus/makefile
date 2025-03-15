name=impetus

all: $(name).gtr

cseg=fffa-ffff,8000
dseg=0200
zseg=0000

.c.asm:
	Cate65.exe -65c02 -v2 $*.c

.asm.obj:
	Asm65.exe -65c02 $*.asm

Bang.asm: Bang.c Bang.h Sprite.h Vram.h VVram.h Stage.h \
	Chars.h Vram.h VVram.h 
Barrier.asm: Barrier.c Barrier.h Sprite.h Vram.h VVram.h Vram.h \
	VVram.h Math.h Main.h Chars.h Stage.h Bang.h \
	Fighter.h Sound.h 
EnemyBullet.asm: EnemyBullet.c EnemyBullet.h Sprite.h Vram.h VVram.h Stage.h \
	Fighter.h Math.h Chars.h Vram.h VVram.h 
Fighter.asm: Fighter.c Fighter.h Sprite.h Vram.h VVram.h ScanKeys.h \
	FighterBullet.h Bang.h Barrier.h Sound.h Status.h Main.h \
	Chars.h Vram.h VVram.h 
FighterBullet.asm: FighterBullet.c FighterBullet.h Stage.h Sprite.h Vram.h VVram.h \
	Fighter.h Vram.h VVram.h SkyEnemy.h GroundEnemy.h Barrier.h \
	Fort.h Sound.h Chars.h 
Fort.asm: Fort.c Fort.h Sprite.h Vram.h VVram.h Vram.h \
	VVram.h Chars.h Stage.h Bang.h Main.h EnemyBullet.h \
	Math.h Sound.h 
GroundEnemy.asm: GroundEnemy.c Stage.h GroundEnemy.h Sprite.h Vram.h VVram.h \
	Math.h Main.h EnemyBullet.h Bang.h Main.h Sound.h \
	Chars.h Vram.h VVram.h 
Item.asm: Item.c Item.h Sprite.h Vram.h VVram.h Vram.h \
	VVram.h Fighter.h Status.h Main.h Sound.h Chars.h 
Main.asm: Main.c Main.h Stage.h ScanKeys.h Sprite.h Vram.h \
	VVram.h Fighter.h FighterBullet.h SkyEnemy.h EnemyBullet.h Status.h \
	Bang.h Barrier.h GroundEnemy.h Fort.h Sound.h Item.h \
	Vram.h VVram.h 
Math.asm: Math.c Math.h 
SkyEnemy.asm: SkyEnemy.c SkyEnemy.h Sprite.h Vram.h VVram.h Math.h \
	Main.h Fighter.h EnemyBullet.h Stage.h Bang.h Main.h \
	Barrier.h Sound.h Item.h Chars.h Vram.h VVram.h 
Sprite.asm: Sprite.c Sprite.h Vram.h VVram.h Vram.h VVram.h \
	Stage.h 
Stage.asm: Stage.c Stage.h Stages.h Main.h Vram.h VVram.h \
	Chars.h CopyMemory.h Fighter.h FighterBullet.h SkyEnemy.h EnemyBullet.h \
	Bang.h Math.h Status.h Barrier.h GroundEnemy.h Fort.h \
	Sprite.h Vram.h VVram.h Item.h 
Stages.asm: Stages.c Stage.h Stages.h Chars.h 
Status.asm: Status.c Status.h Vram.h VVram.h Main.h Sprite.h \
	Vram.h VVram.h Print.h Chars.h 
Vram.asm: Vram.c Vram.h VVram.h Chars.h Sprite.h Vram.h \
	VVram.h Status.h Stage.h Barrier.h 
Chars.obj: Chars.asm 
CopyMemory.obj: CopyMemory.asm ZeroPage.inc 
Print.obj: Print.asm 
ScanKeys.obj: ScanKeys.asm gametank.inc 
Sound.obj: Sound.asm ZeroPage.inc gametank.inc SubBin.inc 
Startup.obj: Startup.asm ZeroPage.inc gametank.inc 
SubBin.obj: SubBin.asm 
SubMain.obj: SubMain.asm 
Vectors.obj: Vectors.asm 
VramA.obj: VramA.asm ZeroPage.inc gametank.inc Vram.inc VVram.inc VVram.inc \
	Chars.inc 
VVramA.obj: VVramA.asm ZeroPage.inc VVram.inc 
ZeroPage.obj: ZeroPage.asm 

objects = Vectors.obj Startup.obj \
	Bang.obj Barrier.obj EnemyBullet.obj Fighter.obj FighterBullet.obj Fort.obj \
	GroundEnemy.obj Item.obj Main.obj Math.obj SkyEnemy.obj Sprite.obj \
	Stage.obj Stages.obj Status.obj Vram.obj Chars.obj CopyMemory.obj \
	Print.obj ScanKeys.obj Sound.obj SubBin.obj VramA.obj VVramA.obj \
	ZeroPage.obj \
	..\..\cate\cate65.lib

$(name).bin: $(objects) makefile
	LinkLE.exe $(name).bin $(cseg) $(dseg) $(zseg) $(objects)

SubBin.bin: SubMain.obj makefile
	LinkLE.exe SubBin.bin 0200 3f00 0010 SubMain.obj

SubBin.asm SubBin.inc: SubBin.bin BinAsm.csx
	dotnet script BinAsm.csx

$(name).gtr: $(name).bin MakeRom.csx
	dotnet script MakeRom.csx $(name)
