name=aerial

all: $(name).d88

cseg=0000
dseg=3a00

.c.asm:
	Cate86.exe $*.c

.asm.obj:
	Asm86.exe $*.asm

Main.asm: Main.c Main.h  Vram.h Stage.h ScanKeys.h Sprite.h Sound.h \
	MyFighter.h MyBullet.h EnemyFighter.h EnemyBullet.h GroundEnemy.h Fort.h \
	Bang.h Item.h Vram.h
Stages.asm: Stages.c Stage.h Stages.h Chars.h
Stage.asm: Stage.c Stage.h Main.h Chars.h CopyMemory.h \
	Math.h Status.h Movable.h Sprite.h MyBullet.h EnemyFighter.h EnemyBullet.h \
	GroundEnemy.h Fort.h Bang.h Item.h Stages.h Vram.h
Status.asm: Status.c Status.h Vram.h Sprite.h Main.h Movable.h Movable.h Sprite.h \
	Chars.h Print.h CopyMemory.h

Movable.asm: Movable.c Movable.h
Fighter.h: Movable.h
Fighter.asm: Fighter.c Fighter.h
MyFighter.h: Fighter.h
MyFighter.asm: MyFighter.c MyFighter.h Stage.h Chars.h Sprite.h ScanKeys.h Sprite.h \
	MyBullet.h Sound.h Bang.h Status.h Main.h Fort.h
Bullet.h: Movable.h
Bullet.asm: Bullet.c Bullet.h Sprite.h Stage.h
MyBullet.h: Bullet.h
MyBullet.asm: MyBullet.c MyBullet.h Sprite.h Chars.h Sound.h MyFighter.h EnemyFighter.h \
	GroundEnemy.h Fort.h
EnemyFighter.h: Fighter.h
EnemyFighter.asm: EnemyFighter.c EnemyFighter.h Sprite.h Stage.h Chars.h Math.h Bullet.h \
	Sound.h Bang.h Main.h EnemyBullet.h MyFighter.h MyBullet.h
EnemyBullet.h: Bullet.h
EnemyBullet.asm: EnemyBullet.c EnemyBullet.h Sprite.h Chars.h
GroundEnemy.h: Movable.h
GroundEnemy.asm: GroundEnemy.c GroundEnemy.h Sprite.h Chars.h Stage.h MyBullet.h \
	Sound.h Bang.h Main.h Math.h MyFighter.h EnemyBullet.h
Fort.asm: Fort.c Fort.h Chars.h Vram.h Main.h Stage.h Movable.h Sound.h Bang.h \
	Math.h EnemyBullet.h MyFighter.h
Bang.asm: Bang.c Bang.h Sprite.h Vram.h Stage.h Chars.h
Item.h: Movable.h
Item.asm: Item.c Item.h Sprite.h Vram.h MyFighter.h Status.h Main.h Sound.h Chars.h \
	Stage.h


Vram.asm: Vram.c Vram.h Fort.h Sound.h
VramA.obj: VramA.asm Vram.inc Chars.inc
Sprite.h: Movable.h
Sprite.asm: Sprite.c Sprite.h Vram.h

objects = Startup.obj \
	Main.obj Stages.obj Stage.obj Status.obj  \
	Fighter.obj MyFighter.obj Bullet.obj MyBullet.obj EnemyFighter.obj Bang.obj \
	EnemyBullet.obj GroundEnemy.obj Fort.obj Item.obj \
	 ScanKeys.obj Sound.obj Vram.obj VramA.obj Print.obj   \
	Movable.obj Sprite.obj \
	Chars.obj Math.obj CopyMemory.obj \
	..\..\cate\cate86.lib

$(name).bin: $(objects) makefile
	LinkLE.exe $(name).bin $(cseg) $(dseg) $(objects)

BinSize.inc: $(name).bin BinSize.csx
	dotnet script BinSize.csx $(name)

Loader.obj: Loader.asm BinSize.inc

Loader.bin: Loader.obj makefile
	LinkLE.exe Loader.bin 0000 0000 Loader.obj

$(name).d88: $(name).bin Loader.bin Disk.csx
	dotnet script Disk.csx $(name)
