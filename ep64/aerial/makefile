name=aerial

all: $(name).rom

cseg=c000
dseg=0100

.c.asm:
	Cate80.exe $*.c

.asm.obj:
	Asm80.exe $*.asm

Bang.asm: Bang.c Bang.h Movable.h VVram.h Vram.h Sprite.h \
	Movable.h Stage.h Vram.h Chars.h 
Bullet.asm: Bullet.c Bullet.h Movable.h Sprite.h Movable.h Stage.h \
	Vram.h 
EnemyBullet.asm: EnemyBullet.c EnemyBullet.h Bullet.h Movable.h Sprite.h Movable.h \
	Chars.h MyFighter.h Fighter.h Movable.h 
EnemyFighter.asm: EnemyFighter.c EnemyFighter.h Fighter.h Movable.h Sprite.h Movable.h \
	Stage.h Vram.h Chars.h Math.h Bullet.h Movable.h \
	Sound.h Bang.h Movable.h Main.h EnemyBullet.h Bullet.h \
	Movable.h MyFighter.h Fighter.h Movable.h MyBullet.h Bullet.h \
	Movable.h 
Fighter.asm: Fighter.c Fighter.h Movable.h Sprite.h Movable.h 
Fort.asm: Fort.c Fort.h Chars.h VVram.h Vram.h Main.h \
	Stage.h Vram.h Movable.h Sound.h Bang.h Movable.h \
	Math.h EnemyBullet.h Bullet.h Movable.h MyFighter.h Fighter.h \
	Movable.h 
GroundEnemy.asm: GroundEnemy.c GroundEnemy.h Movable.h Sprite.h Movable.h Chars.h \
	Stage.h Vram.h MyBullet.h Bullet.h Movable.h Sound.h \
	Bang.h Movable.h Main.h Math.h MyFighter.h Fighter.h \
	Movable.h EnemyBullet.h Bullet.h Movable.h Item.h Movable.h 
Item.asm: Item.c Item.h Movable.h Sprite.h Movable.h Vram.h \
	MyFighter.h Fighter.h Movable.h Status.h Main.h Sound.h \
	Chars.h 
Main.asm: Main.c Main.h  Stage.h Vram.h ScanKeys.h \
	Sprite.h Movable.h Status.h Sound.h MyFighter.h Fighter.h \
	Movable.h MyBullet.h Bullet.h Movable.h EnemyFighter.h Fighter.h \
	Movable.h EnemyBullet.h Bullet.h Movable.h GroundEnemy.h Movable.h \
	Fort.h Bang.h Movable.h Item.h Movable.h VVram.h \
	Vram.h 
Math.asm: Math.c Math.h 
Movable.asm: Movable.c Movable.h 
MyBullet.asm: MyBullet.c MyBullet.h Bullet.h Movable.h Sprite.h Movable.h \
	Chars.h Sound.h MyFighter.h Fighter.h Movable.h EnemyFighter.h \
	Fighter.h Movable.h GroundEnemy.h Movable.h Fort.h 
MyFighter.asm: MyFighter.c MyFighter.h Fighter.h Movable.h Stage.h Vram.h \
	Chars.h ScanKeys.h Sprite.h Movable.h MyBullet.h Bullet.h \
	Movable.h Sound.h Bang.h Movable.h Status.h Main.h \
	Fort.h 
Sprite.asm: Sprite.c Sprite.h Movable.h Chars.h VVram.h Vram.h \
	Bullet.h Movable.h 
Stage.asm: Stage.c Stage.h Vram.h Stages.h Main.h Chars.h \
	CopyMemory.h Math.h Status.h Sprite.h Movable.h MyFighter.h \
	Fighter.h Movable.h MyBullet.h Bullet.h Movable.h EnemyFighter.h \
	Fighter.h Movable.h EnemyBullet.h Bullet.h Movable.h GroundEnemy.h \
	Movable.h Fort.h Bang.h Movable.h Item.h Movable.h 
Stages.asm: Stages.c Vram.h Stage.h Vram.h Stages.h 
Status.asm: Status.c Status.h Vram.h Stage.h Vram.h Main.h \
	Sprite.h Movable.h Print.h Chars.h VVram.h Vram.h 
Vram.asm: Vram.c Vram.h VVram.h Vram.h Chars.h 
VVram.asm: VVram.c VVram.h Vram.h Chars.h Sprite.h Movable.h \
	Vram.h Fort.h 
Chars.obj: Chars.asm 
CopyMemory.obj: CopyMemory.asm 
Init.obj: Init.asm 
Print.obj: Print.asm 
ScanKeys.obj: ScanKeys.asm 
Sound.obj: Sound.asm 
VramA.obj: VramA.asm Vram.inc VVram.inc 
VVramA.obj: VVramA.asm VVram.inc 


objects = Startup.obj \
	Main.obj Stages.obj Stage.obj Status.obj  \
	Fighter.obj MyFighter.obj Bullet.obj MyBullet.obj EnemyFighter.obj Bang.obj \
	EnemyBullet.obj GroundEnemy.obj Fort.obj Item.obj \
	 ScanKeys.obj Sound.obj Vram.obj VramA.obj Print.obj   \
	Movable.obj Sprite.obj VVram.obj VVramA.obj \
	Chars.obj Math.obj CopyMemory.obj \
	..\..\cate\cate80.lib

$(name).rom: $(objects) makefile 
	LinkLE.exe $(name).rom $(cseg) $(dseg) $(objects)
