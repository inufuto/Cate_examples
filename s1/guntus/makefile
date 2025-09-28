name=guntus

all: $(name).l3

cseg=4000
zseg=7900 
dseg=7a00

.c.asm:
	Cate09.exe $*.c

.asm.obj:
	Asm09.exe -v2 $*.asm

Bang.asm: Bang.c Bang.h Vram.h Sprite.h Stage.h Chars.h \
	Coord.h 
Direction.asm: Direction.c Direction.h Vram.h 
Enemy.asm: Enemy.c Enemy.h Coord.h 
EnemyBullet.asm: EnemyBullet.c EnemyBullet.h Sprite.h Stage.h Fighter.h Vram.h \
	Coord.h Chars.h Math.h 
EnemyRow.asm: EnemyRow.c EnemyRow.h Coord.h Vram.h Stage.h Chars.h \
	MovingEnemy.h Sound.h Bang.h Enemy.h Math.h Status.h \
	Team.h Stage.h MovingEnemy.h Direction.h Sprite.h Fighter.h \
	CopyMemory.h 
Fighter.asm: Fighter.c Fighter.h Vram.h Sprite.h ScanKeys.h FighterBullet.h \
	Bang.h Sound.h Status.h Coord.h Chars.h 
FighterBullet.asm: FighterBullet.c FighterBullet.h Stage.h Sprite.h Fighter.h Vram.h \
	Sound.h Coord.h Chars.h MovingEnemy.h EnemyRow.h 
Item.asm: Item.c Item.h Sprite.h Vram.h Fighter.h Status.h \
	Status.h Sound.h Coord.h Chars.h 
Main.asm: Main.c Stage.h ScanKeys.h Sprite.h Fighter.h FighterBullet.h \
	EnemyBullet.h Status.h Bang.h Sound.h Team.h Stage.h \
	MovingEnemy.h Direction.h Sprite.h EnemyRow.h Vram.h Star.h \
	Enemy.h Item.h Coord.h 
MovingEnemy.asm: MovingEnemy.c MovingEnemy.h Sprite.h Chars.h Direction.h Math.h \
	Coord.h EnemyRow.h Status.h EnemyBullet.h Sound.h Bang.h \
	Team.h Stage.h MovingEnemy.h Direction.h Sprite.h Enemy.h \
	Fighter.h Vram.h Item.h 
Sprite.asm: Sprite.c Sprite.h Vram.h Coord.h 
Stage.asm: Stage.c Stage.h Stages.h Math.h Fighter.h FighterBullet.h \
	EnemyRow.h MovingEnemy.h Status.h Sprite.h Vram.h Team.h \
	Stage.h MovingEnemy.h Direction.h Sprite.h EnemyBullet.h Star.h \
	Bang.h Item.h 
Stages.asm: Stages.c Stage.h Stages.h 
Star.asm: Star.c Star.h Vram.h Chars.h Coord.h 
Status.asm: Status.c Status.h Vram.h Print.h Chars.h Sprite.h 
Team.asm: Team.c Team.h Stage.h MovingEnemy.h Direction.h Sprite.h \
	Coord.h Enemy.h 
Vram.asm: Vram.c Vram.h Chars.h Sprite.h CopyMemory.h Sound.h \
	Star.h EnemyRow.h 
Chars.obj: Chars.asm 
Loader.obj: Loader.asm S1.inc BinSize.inc
Math.obj: Math.asm 
Print.obj: Print.asm 
ScanKeys.obj: ScanKeys.asm S1.inc 
Sound.obj: Sound.asm 
Startup.obj: Startup.asm S1.inc 
VramA.obj: VramA.asm S1.inc Vram.inc Chars.inc 

objects = Startup.obj \
	Bang.obj Direction.obj Enemy.obj EnemyBullet.obj EnemyRow.obj Fighter.obj \
	FighterBullet.obj Item.obj Main.obj MovingEnemy.obj Sprite.obj Stage.obj \
	Stages.obj Star.obj Status.obj Team.obj Vram.obj Chars.obj \
	Math.obj Print.obj ScanKeys.obj Sound.obj VramA.obj \
	..\..\cate\cate09.lib

$(name).bin: $(objects) makefile
	LinkBE.exe $(name).bin $(cseg) $(dseg) $(zseg) $(objects)

BinSize.inc: $(name).bin BinSize.csx
	dotnet script BinSize.csx $(name)

$(name)_01.l3: Loader.obj makefile
	LinkBE.exe Loader.l3 d000 d200 d100 Loader.obj
	copy Loader.l3 $(name)_01.l3 /y

$(name)_02.l3: $(name).bin BinL3.csx
	dotnet script BinL3.csx $(name) $(cseg)

$(name).l3: $(name)_01.l3 $(name)_02.l3
	copy /b $(name)_01.l3+$(name)_02.l3 $(name).l3
