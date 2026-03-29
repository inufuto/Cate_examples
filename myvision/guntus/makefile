name=guntus

all: $(name).rom

cseg=0000
dseg=a000

.c.asm:
	Cate80.exe $*.c

.asm.obj:
	Asm80.exe -v2 $*.asm

Bang.asm: Bang.c Bang.h Vram.h Sprite.h Stage.h Chars.h \
	Coord.h 
Direction.asm: Direction.c Direction.h Vram.h 
Enemy.asm: Enemy.c Enemy.h Coord.h 
EnemyBullet.asm: EnemyBullet.c EnemyBullet.h Sprite.h Stage.h Fighter.h Vram.h \
	Coord.h Chars.h Math.h 
EnemyRow.asm: EnemyRow.c EnemyRow.h Coord.h Vram.h Stage.h Chars.h \
	MovingEnemy.h Sound.h Bang.h Enemy.h Math.h Status.h \
	Team.h Stage.h MovingEnemy.h Direction.h Sprite.h Fighter.h 
Fighter.asm: Fighter.c Fighter.h Vram.h Sprite.h ScanKeys.h FighterBullet.h \
	Bang.h Sound.h Status.h Coord.h Chars.h 
FighterBullet.asm: FighterBullet.c FighterBullet.h Stage.h Sprite.h Fighter.h Vram.h \
	Sound.h Coord.h Chars.h MovingEnemy.h EnemyRow.h 
Main.asm: Main.c  Stage.h ScanKeys.h Sprite.h Fighter.h \
	FighterBullet.h EnemyBullet.h Status.h Bang.h Sound.h Team.h \
	Stage.h MovingEnemy.h Direction.h Sprite.h EnemyRow.h Vram.h \
	Star.h Enemy.h 
MovingEnemy.asm: MovingEnemy.c MovingEnemy.h Sprite.h Chars.h Direction.h Math.h \
	Coord.h EnemyRow.h Status.h EnemyBullet.h Sound.h Bang.h \
	Team.h Stage.h MovingEnemy.h Direction.h Sprite.h Enemy.h \
	Fighter.h Vram.h 
Stage.asm: Stage.c Stage.h Stages.h Math.h Fighter.h FighterBullet.h \
	EnemyRow.h MovingEnemy.h Status.h Sprite.h Vram.h Team.h \
	Stage.h MovingEnemy.h Direction.h Sprite.h EnemyBullet.h Star.h 
Stages.asm: Stages.c Stage.h Stages.h 
Star.asm: Star.c Star.h Vram.h Chars.h Coord.h 
Status.asm: Status.c Status.h Vram.h Print.h Chars.h Sprite.h \
	 EnemyRow.h 
Team.asm: Team.c Team.h Stage.h MovingEnemy.h Direction.h Sprite.h \
	Coord.h Enemy.h 
Vram.asm: Vram.c Vram.h Chars.h EnemyRow.h Star.h 
Chars.obj: Chars.asm 
chead.obj: chead.asm 
Init.obj: Init.asm  
Math.obj: Math.asm 
Print.obj: Print.asm 
ScanKeys.obj: ScanKeys.asm  
Sound.obj: Sound.asm  
Sprite.obj: Sprite.asm  Vram.inc Chars.inc 
VramA.obj: VramA.asm  Vram.inc Chars.inc 
VramB.obj: VramB.asm  Vram.inc Chars.inc 
Item.asm: Item.c

objects = startup.obj \
	Main.obj \
	Bang.obj Direction.obj Enemy.obj EnemyBullet.obj EnemyRow.obj Fighter.obj \
	FighterBullet.obj MovingEnemy.obj Stage.obj Stages.obj Star.obj \
	Status.obj Team.obj Vram.obj Chars.obj \
	Math.obj Print.obj ScanKeys.obj Sound.obj Sprite.obj \
	VramA.obj VramB.obj Item.obj CopyMemory.obj \
	Vdp.obj \
	..\..\cate\cate80.lib

$(name).rom: $(objects) makefile
	LinkLE.exe $(name).rom $(cseg) $(dseg) $(objects)
