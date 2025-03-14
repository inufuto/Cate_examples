name=aerial

all: $(name).gtr

cseg=fffa-ffff,c000
dseg=0200
zseg=0000

.c.asm:
	Cate65.exe -65c02 -v2 $*.c

.asm.obj:
	Asm65.exe -65c02 $*.asm

Bang.asm: Bang.c Bang.h Movable.h Vram.h VVram.h Sprite.h \
	Movable.h Stage.h Vram.h VVram.h Chars.h 
Bullet.asm: Bullet.c Bullet.h Movable.h Sprite.h Movable.h Stage.h \
	Vram.h VVram.h 
EnemyBullet.asm: EnemyBullet.c EnemyBullet.h Bullet.h Movable.h Sprite.h Movable.h \
	Chars.h MyFighter.h Fighter.h Movable.h 
EnemyFighter.asm: EnemyFighter.c EnemyFighter.h Fighter.h Movable.h Sprite.h Movable.h \
	Stage.h Vram.h VVram.h Chars.h Math.h Bullet.h \
	Movable.h Sound.h Bang.h Movable.h Main.h EnemyBullet.h \
	Bullet.h Movable.h MyFighter.h Fighter.h Movable.h MyBullet.h \
	Bullet.h Movable.h 
Fighter.asm: Fighter.c Fighter.h Movable.h Sprite.h Movable.h 
Fort.asm: Fort.c Fort.h Chars.h VVram.h Main.h Stage.h \
	Vram.h VVram.h Movable.h Sound.h Bang.h Movable.h \
	Math.h EnemyBullet.h Bullet.h Movable.h MyFighter.h Fighter.h \
	Movable.h 
GroundEnemy.asm: GroundEnemy.c GroundEnemy.h Movable.h Sprite.h Movable.h Chars.h \
	Stage.h Vram.h VVram.h MyBullet.h Bullet.h Movable.h \
	Sound.h Bang.h Movable.h Main.h Math.h MyFighter.h \
	Fighter.h Movable.h EnemyBullet.h Bullet.h Movable.h Item.h \
	Movable.h 
Item.asm: Item.c Item.h Movable.h Sprite.h Movable.h Vram.h \
	VVram.h MyFighter.h Fighter.h Movable.h Status.h Main.h \
	Sound.h Chars.h Stage.h Vram.h VVram.h 
Main.asm: Main.c Main.h Stage.h Vram.h VVram.h ScanKeys.h \
	Sprite.h Movable.h Status.h Sound.h MyFighter.h Fighter.h \
	Movable.h MyBullet.h Bullet.h Movable.h EnemyFighter.h Fighter.h \
	Movable.h EnemyBullet.h Bullet.h Movable.h GroundEnemy.h Movable.h \
	Fort.h Bang.h Movable.h Item.h Movable.h 
Math.asm: Math.c Math.h 
Movable.asm: Movable.c Movable.h 
MyBullet.asm: MyBullet.c MyBullet.h Bullet.h Movable.h Sprite.h Movable.h \
	Chars.h Sound.h MyFighter.h Fighter.h Movable.h EnemyFighter.h \
	Fighter.h Movable.h GroundEnemy.h Movable.h Fort.h 
MyFighter.asm: MyFighter.c MyFighter.h Fighter.h Movable.h Stage.h Vram.h \
	VVram.h Chars.h ScanKeys.h Sprite.h Movable.h MyBullet.h \
	Bullet.h Movable.h Sound.h Bang.h Movable.h Status.h \
	Main.h Fort.h 
Sprite.asm: Sprite.c Sprite.h Movable.h Vram.h VVram.h 
Stage.asm: Stage.c Stage.h Vram.h VVram.h Stages.h Main.h \
	Chars.h CopyMemory.h Math.h Status.h Sprite.h Movable.h \
	MyFighter.h Fighter.h Movable.h MyBullet.h Bullet.h Movable.h \
	EnemyFighter.h Fighter.h Movable.h EnemyBullet.h Bullet.h Movable.h \
	GroundEnemy.h Movable.h Fort.h Bang.h Movable.h Item.h \
	Movable.h 
Stages.asm: Stages.c Vram.h VVram.h Stage.h Vram.h VVram.h \
	Stages.h 
Status.asm: Status.c Status.h Vram.h VVram.h Main.h Sprite.h \
	Movable.h Print.h Chars.h 
Vram.asm: Vram.c Vram.h VVram.h VVram.h Fort.h Sprite.h \
	Movable.h 
VVram.asm: VVram.c VVram.h 
Chars.obj: Chars.asm 
CopyMemory.obj: CopyMemory.asm ZeroPage.inc 
Print.obj: Print.asm 
ScanKeys.obj: ScanKeys.asm gametank.inc 
Sound.obj: Sound.asm ZeroPage.inc gametank.inc SubBin.inc 
StageA.obj: StageA.asm ZeroPage.inc 
Startup.obj: Startup.asm ZeroPage.inc gametank.inc 
SubBin.obj: SubBin.asm 
SubMain.obj: SubMain.asm 
Vectors.obj: Vectors.asm 
VramA.obj: VramA.asm ZeroPage.inc gametank.inc Vram.inc VVram.inc Chars.inc 
VVramA.obj: VVramA.asm ZeroPage.inc VVram.inc Chars.inc 
ZeroPage.obj: ZeroPage.asm 

objects = Vectors.obj Startup.obj \
	Bang.obj Bullet.obj EnemyBullet.obj EnemyFighter.obj Fighter.obj Fort.obj \
	GroundEnemy.obj Item.obj Main.obj Math.obj Movable.obj MyBullet.obj \
	MyFighter.obj Sprite.obj Stage.obj Stages.obj Status.obj Vram.obj \
	VVram.obj Chars.obj CopyMemory.obj Print.obj ScanKeys.obj Sound.obj \
	StageA.obj SubBin.obj VramA.obj VVramA.obj ZeroPage.obj \
	..\..\cate\cate65.lib

$(name).bin: $(objects) makefile
	LinkLE.exe $(name).bin $(cseg) $(dseg) $(zseg) $(objects)

SubBin.bin: SubMain.obj makefile
	LinkLE.exe SubBin.bin 0200 3f00 0010 SubMain.obj

SubBin.asm SubBin.inc: SubBin.bin BinAsm.csx
	dotnet script BinAsm.csx

$(name).gtr: $(name).bin MakeRom.csx
	dotnet script MakeRom.csx $(name)
