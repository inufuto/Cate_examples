name=guntus

filename=$(name)

all: $(filename)

cseg=8000
dseg=ca00

.c.asm:
	Cate80.exe $*.c

.asm.obj:
	Asm80.exe $*.asm

Bang.asm: Bang.c Bang.h Vram.h Sprite.h Stage.h Chars.h \
	Coord.h 
Direction.asm: Direction.c Direction.h Vram.h 
Enemy.asm: Enemy.c Enemy.h Coord.h 
EnemyBullet.asm: EnemyBullet.c EnemyBullet.h Sprite.h Stage.h Fighter.h Vram.h \
	Coord.h Chars.h Math.h 
EnemyRow.asm: EnemyRow.c EnemyRow.h Coord.h Vram.h Stage.h Chars.h \
	MovingEnemy.h Sound.h Bang.h Enemy.h Math.h Status.h \
	Team.h Stage.h MovingEnemy.h Direction.h Sprite.h Fighter.h \
	CopyMemory.h VVram.h 
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
Print.asm: Print.c Print.h Vram.h 
Stage.asm: Stage.c Stage.h Stages.h Math.h Fighter.h FighterBullet.h \
	EnemyRow.h MovingEnemy.h Status.h Sprite.h Vram.h Team.h \
	Stage.h MovingEnemy.h Direction.h Sprite.h EnemyBullet.h Star.h \
	Bang.h Item.h 
Stages.asm: Stages.c Stage.h Stages.h 
Star.asm: Star.c Star.h Vram.h Chars.h Coord.h VVram.h 
Status.asm: Status.c Status.h Vram.h Print.h Chars.h Sprite.h \
	ScanKeys.h 
Team.asm: Team.c Team.h Stage.h MovingEnemy.h Direction.h Sprite.h \
	Coord.h Enemy.h 
Vram.asm: Vram.c Vram.h Chars.h Sprite.h CopyMemory.h Sound.h \
	VVram.h Star.h EnemyRow.h 
VVram.asm: VVram.c VVram.h Chars.h 
Chars.obj: Chars.asm 
Math.obj: Math.asm 
ScanKeys.obj: ScanKeys.asm BIOS.inc 
Sound.obj: Sound.asm 
SoundOpll.obj: SoundOpll.asm BIOS.inc 
SoundPsg.obj: SoundPsg.asm BIOS.inc 
Sprite.obj: Sprite.asm Vram.inc 
Startup.obj: Startup.asm BIOS.inc 
VramA.obj: VramA.asm BIOS.inc Vram.inc Chars.inc 
VVramA.obj: VVramA.asm Vram.inc 

objects = Startup.obj \
	Bang.obj Direction.obj Enemy.obj EnemyBullet.obj EnemyRow.obj Fighter.obj \
	FighterBullet.obj Item.obj Main.obj MovingEnemy.obj Print.obj Stage.obj \
	Stages.obj Star.obj Status.obj Team.obj Vram.obj VVram.obj \
	Chars.obj Math.obj ScanKeys.obj Sound.obj SoundOpll.obj SoundPsg.obj \
	Sprite.obj VramA.obj VVramA.obj \
	..\..\cate\cate80.lib

$(name).hex: $(objects) makefile
	LinkLE.exe $(name).hex $(cseg) $(dseg) $(objects)

$(filename): $(name).hex
	ihx2bin $(name).hex $(filename)
