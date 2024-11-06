name=guntus

all: $(name).bin

cseg=2000-2053,4000-9fff,2054-3fda,3fdc
dseg=0200
zseg=00d0

.c.asm:
	Cate85.exe $*.c

.asm.obj:
	Asm85.exe $*.asm

Bang.asm: Bang.c Bang.h VVram.h Sprite.h Stage.h Chars.h \
	Coord.h 
Direction.asm: Direction.c Direction.h VVram.h 
Enemy.asm: Enemy.c Enemy.h Coord.h 
EnemyBullet.asm: EnemyBullet.c EnemyBullet.h Sprite.h Stage.h Fighter.h VVram.h \
	Coord.h Chars.h Math.h 
EnemyRow.asm: EnemyRow.c EnemyRow.h Coord.h VVram.h Stage.h Chars.h \
	MovingEnemy.h Sound.h Bang.h Enemy.h Math.h Status.h \
	Team.h Stage.h MovingEnemy.h Direction.h Sprite.h Fighter.h 
Fighter.asm: Fighter.c Fighter.h VVram.h Sprite.h ScanKeys.h FighterBullet.h \
	Bang.h Sound.h Status.h Coord.h Chars.h 
FighterBullet.asm: FighterBullet.c FighterBullet.h Stage.h Sprite.h Fighter.h VVram.h \
	Sound.h Coord.h Chars.h MovingEnemy.h EnemyRow.h 
Item.asm: Item.c Item.h Sprite.h VVram.h Fighter.h Status.h \
	Status.h Sound.h Coord.h Chars.h 
Main.asm: Main.c Stage.h ScanKeys.h Sprite.h Fighter.h FighterBullet.h \
	EnemyBullet.h Status.h Bang.h Sound.h Team.h Stage.h \
	MovingEnemy.h Direction.h Sprite.h EnemyRow.h Vram.h Star.h \
	Enemy.h Item.h Coord.h 
MovingEnemy.asm: MovingEnemy.c MovingEnemy.h Sprite.h Chars.h Direction.h Math.h \
	Coord.h EnemyRow.h Status.h EnemyBullet.h Sound.h Bang.h \
	Team.h Stage.h MovingEnemy.h Direction.h Sprite.h Enemy.h \
	Fighter.h VVram.h Item.h 
Stage.asm: Stage.c Stage.h Stages.h Math.h Fighter.h FighterBullet.h \
	EnemyRow.h MovingEnemy.h Status.h Sprite.h Vram.h VVram.h \
	Team.h Stage.h MovingEnemy.h Direction.h Sprite.h EnemyBullet.h \
	Star.h Bang.h Item.h 
Stages.asm: Stages.c Stage.h Stages.h 
Star.asm: Star.c Star.h VVram.h Chars.h Coord.h 
Status.asm: Status.c Status.h Vram.h Sprite.h Print.h Chars.h 
Team.asm: Team.c Team.h Stage.h MovingEnemy.h Direction.h Sprite.h \
	Coord.h Enemy.h 
Vram.asm: Vram.c Vram.h Chars.h EnemyRow.h Star.h VVram.h \
	Sprite.h 
Math.obj: Math.asm 
Print.obj: Print.asm 
RomChars.obj: RomChars.asm 
RomHead.obj: RomHead.asm GameCom.inc 
ScanKeys.obj: ScanKeys.asm GameCom.inc 
Sound.obj: Sound.asm GameCom.inc 
Sprite.obj: Sprite.asm GameCom.inc Vram.inc VVram.inc 
Startup.obj: Startup.asm GameCom.inc Vram.inc 
Vectors.obj: Vectors.asm 
VramA.obj: VramA.asm GameCom.inc Vram.inc VVram.inc Chars.inc 
VVramA.obj: VVramA.asm VVram.inc 

objects = Vectors.obj RomHead.obj RomChars.obj Startup.obj \
	Bang.obj Direction.obj Enemy.obj EnemyBullet.obj EnemyRow.obj Fighter.obj \
	FighterBullet.obj Item.obj Main.obj MovingEnemy.obj Stage.obj Stages.obj \
	Star.obj Status.obj Team.obj Vram.obj Math.obj Print.obj \
	ScanKeys.obj Sound.obj Sprite.obj VramA.obj VVramA.obj \
	..\..\cate\cate85.lib

_.bin: $(objects) makefile
	LinkBE.exe _.bin $(cseg) $(dseg) $(zseg) $(objects)
	copy _.symbols.txt $(name).symbols.txt /y

$(name).bin: _.bin MakeRom.csx
	dotnet script MakeRom.csx $(name)
