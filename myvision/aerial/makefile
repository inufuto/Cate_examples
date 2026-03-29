name=aerial

all: $(name).rom

cseg=0000
dseg=a000

.c.asm:
	Cate80.exe $*.c

.asm.obj:
	Asm80.exe -v2 $*.asm

Bang.asm: Bang.c Bang.h Movable.h Vram.h Sprite.h Movable.h \
	Stage.h Vram.h Chars.h 
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
Fort.asm: Fort.c Fort.h Chars.h Vram.h Main.h Stage.h \
	Vram.h Movable.h Sound.h Bang.h Movable.h Math.h \
	EnemyBullet.h Bullet.h Movable.h MyFighter.h Fighter.h Movable.h 
GroundEnemy.asm: GroundEnemy.c GroundEnemy.h Movable.h Sprite.h Movable.h Chars.h \
	Stage.h Vram.h MyBullet.h Bullet.h Movable.h Sound.h \
	Bang.h Movable.h Main.h Math.h MyFighter.h Fighter.h \
	Movable.h EnemyBullet.h Bullet.h Movable.h Item.h Movable.h 
Item.asm: Item.c Item.h Movable.h Sprite.h Movable.h Vram.h \
	MyFighter.h Fighter.h Movable.h Status.h Main.h Sound.h \
	Chars.h 
Main.asm: Main.c Main.h Stage.h Vram.h ScanKeys.h Sprite.h \
	Movable.h Status.h Sound.h MyFighter.h Fighter.h Movable.h \
	MyBullet.h Bullet.h Movable.h EnemyFighter.h Fighter.h Movable.h \
	EnemyBullet.h Bullet.h Movable.h GroundEnemy.h Movable.h Fort.h \
	Bang.h Movable.h Item.h Movable.h 
Math.asm: Math.c Math.h 
Movable.asm: Movable.c Movable.h 
MyBullet.asm: MyBullet.c MyBullet.h Bullet.h Movable.h Sprite.h Movable.h \
	Chars.h Sound.h MyFighter.h Fighter.h Movable.h EnemyFighter.h \
	Fighter.h Movable.h GroundEnemy.h Movable.h Fort.h 
MyFighter.asm: MyFighter.c MyFighter.h Fighter.h Movable.h Stage.h Vram.h \
	Chars.h ScanKeys.h Sprite.h Movable.h MyBullet.h Bullet.h \
	Movable.h Sound.h Bang.h Movable.h Status.h Main.h \
	Fort.h 
Stage.asm: Stage.c Stage.h Vram.h Stages.h Main.h Chars.h \
	BackgroundChars.h CopyMemory.h Math.h Status.h Sprite.h Movable.h \
	MyFighter.h Fighter.h Movable.h MyBullet.h Bullet.h Movable.h \
	EnemyFighter.h Fighter.h Movable.h EnemyBullet.h Bullet.h Movable.h \
	GroundEnemy.h Movable.h Fort.h Bang.h Movable.h Item.h \
	Movable.h 
Stages.asm: Stages.c Vram.h Stage.h Vram.h Stages.h 
Status.asm: Status.c Status.h Vram.h Main.h Sprite.h Movable.h \
	Print.h Chars.h 
Vram.asm: Vram.c Vram.h 
BackgroundChars.obj: BackgroundChars.asm 
Chars.obj: Chars.asm 
CopyMemory.obj: CopyMemory.asm 
Print.obj: Print.asm 
ScanKeys.obj: ScanKeys.asm kh1000.inc 
Sound.obj: Sound.asm kh1000.inc 
Sprite.obj: Sprite.asm kh1000.inc Vram.inc 
Startup.obj: Startup.asm kh1000.inc 
Vdp.obj: Vdp.asm kh1000.inc Vram.inc 
VramA.obj: VramA.asm kh1000.inc Vram.inc Chars.inc 

objects = startup.obj \
	Bang.obj Bullet.obj EnemyBullet.obj EnemyFighter.obj Fighter.obj Fort.obj \
	GroundEnemy.obj Item.obj Main.obj Math.obj Movable.obj MyBullet.obj \
	MyFighter.obj Stage.obj Stages.obj Status.obj Vram.obj BackgroundChars.obj \
	Chars.obj CopyMemory.obj Print.obj ScanKeys.obj Sound.obj Sprite.obj \
	Vdp.obj VramA.obj \
	..\..\cate\cate80.lib

$(name).rom: $(objects) makefile
	LinkLE.exe $(name).rom $(cseg) $(dseg) $(objects)
