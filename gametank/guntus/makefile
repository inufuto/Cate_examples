name=guntus

all: $(name).gtr

cseg=fffa-ffff,8000
dseg=0200
zseg=0000

.c.asm:
	Cate65.exe -65c02 -v2 $*.c

.asm.obj:
	Asm65.exe -65c02 $*.asm

Bang.asm: Bang.c Bang.h Vram.h VVram.h Sprite.h Stage.h \
	Chars.h Coord.h 
Direction.asm: Direction.c Direction.h Vram.h VVram.h 
Enemy.asm: Enemy.c Enemy.h Coord.h 
EnemyBullet.asm: EnemyBullet.c EnemyBullet.h Sprite.h Stage.h Fighter.h Vram.h \
	VVram.h Coord.h Chars.h Math.h 
EnemyRow.asm: EnemyRow.c EnemyRow.h Coord.h Vram.h VVram.h Stage.h \
	Chars.h MovingEnemy.h Sound.h Bang.h Enemy.h Math.h \
	Status.h Team.h Stage.h MovingEnemy.h Direction.h Sprite.h \
	Fighter.h CopyMemory.h VVram.h 
Fighter.asm: Fighter.c Fighter.h Vram.h VVram.h Sprite.h ScanKeys.h \
	FighterBullet.h Bang.h Sound.h Status.h Coord.h Chars.h 
FighterBullet.asm: FighterBullet.c FighterBullet.h Stage.h Sprite.h Fighter.h Vram.h \
	VVram.h Sound.h Coord.h Chars.h MovingEnemy.h EnemyRow.h 
Item.asm: Item.c Item.h Sprite.h Vram.h VVram.h Fighter.h \
	Status.h Status.h Sound.h Coord.h Chars.h 
Main.asm: Main.c Stage.h ScanKeys.h Sprite.h Fighter.h FighterBullet.h \
	EnemyBullet.h Status.h Bang.h Sound.h Team.h Stage.h \
	MovingEnemy.h Direction.h Sprite.h EnemyRow.h Vram.h VVram.h \
	Star.h Enemy.h Item.h Coord.h 
MovingEnemy.asm: MovingEnemy.c MovingEnemy.h Sprite.h Chars.h Direction.h Math.h \
	Coord.h EnemyRow.h Status.h EnemyBullet.h Sound.h Bang.h \
	Team.h Stage.h MovingEnemy.h Direction.h Sprite.h Enemy.h \
	Fighter.h Vram.h VVram.h Item.h 
Sprite.asm: Sprite.c Sprite.h Vram.h VVram.h Coord.h 
Stage.asm: Stage.c Stage.h Stages.h Math.h Fighter.h FighterBullet.h \
	EnemyRow.h MovingEnemy.h Status.h Sprite.h Vram.h VVram.h \
	Team.h Stage.h MovingEnemy.h Direction.h Sprite.h EnemyBullet.h \
	Star.h Bang.h Item.h 
Stages.asm: Stages.c Stage.h Stages.h 
Star.asm: Star.c Star.h Vram.h VVram.h Chars.h Coord.h \
	VVram.h 
Status.asm: Status.c Status.h Vram.h VVram.h Print.h Chars.h \
	Sprite.h 
Team.asm: Team.c Team.h Stage.h MovingEnemy.h Direction.h Sprite.h \
	Coord.h Enemy.h 
Vram.asm: Vram.c Vram.h VVram.h Chars.h Sprite.h CopyMemory.h \
	VVram.h Star.h EnemyRow.h 
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
	Bang.obj Direction.obj Enemy.obj EnemyBullet.obj EnemyRow.obj Fighter.obj \
	FighterBullet.obj Item.obj Main.obj MovingEnemy.obj Sprite.obj Stage.obj \
	Stages.obj Star.obj Status.obj Team.obj Vram.obj VVram.obj \
	Chars.obj Math.obj Print.obj ScanKeys.obj Sound.obj SubBin.obj \
	VramA.obj VVramA.obj ZeroPage.obj \
	..\..\cate\cate65.lib

$(name).bin: $(objects) makefile
	LinkLE.exe $(name).bin $(cseg) $(dseg) $(zseg) $(objects)

SubBin.bin: SubMain.obj makefile
	LinkLE.exe SubBin.bin 0200 3f00 0010 SubMain.obj

SubBin.asm SubBin.inc: SubBin.bin BinAsm.csx
	dotnet script BinAsm.csx

$(name).gtr: $(name).bin MakeRom.csx
	dotnet script MakeRom.csx $(name)
