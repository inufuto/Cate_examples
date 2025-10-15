name=aerial

all: $(name).wav loader.txt

cseg=8800
dseg=b100
loader=8000

.c.asm:
	Cate80.exe $*.c

.asm.obj:
	Asm80.exe $*.asm

Main.asm: Main.c Main.h Init.h Vram.h Stage.h ScanKeys.h Sprite.h Sound.h \
	MyFighter.h MyBullet.h EnemyFighter.h EnemyBullet.h GroundEnemy.h Fort.h \
	Bang.h Item.h
Stages.asm: Stages.c Stage.h Stages.h Chars.h
Stage.h: Vram.h
Stage.asm: Stage.c Stage.h Main.h Chars.h CopyMemory.h \
	Math.h Status.h Movable.h Sprite.h MyBullet.h EnemyFighter.h EnemyBullet.h \
	GroundEnemy.h Fort.h Bang.h Item.h Stages.h
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
Fort.asm: Fort.c Fort.h Chars.h VVram.h Main.h Stage.h Movable.h Sound.h Bang.h \
	Math.h EnemyBullet.h MyFighter.h
Bang.asm: Bang.c Bang.h Sprite.h VVram.h Stage.h Chars.h
Item.h: Movable.h
Item.asm: Item.c Item.h Sprite.h Vram.h MyFighter.h Status.h Main.h Sound.h Chars.h


Math.asm: Math.c Math.h
Vram.asm: Vram.c Vram.h
VramA.obj: VramA.asm Vram.inc 
Sprite.h: Movable.h
Sprite.asm: Sprite.c Sprite.h VVram.h Bullet.h
Sound.obj: Sound.asm
VVram.h: Vram.h
VVram.asm: VVram.c VVram.h Vram.h

objects = \
	Main.obj Stages.obj Stage.obj Status.obj  \
	Fighter.obj MyFighter.obj Bullet.obj MyBullet.obj EnemyFighter.obj Bang.obj \
	EnemyBullet.obj GroundEnemy.obj Fort.obj Item.obj \
	Init.obj ScanKeys.obj Sound.obj Vram.obj VramA.obj Print.obj   \
	Movable.obj Sprite.obj VVram.obj VVramA.obj \
	Chars.obj Math.obj CopyMemory.obj \
	..\..\cate\cate80.lib

$(name).cmt: $(objects) makefile
	LinkLE.exe $(name).cmt $(cseg) $(dseg) $(objects)

$(name).wav: $(name).cmt CmtWav.csx 
	dotnet script CmtWav.csx $(name)

loader.obj: loader.asm

loader.bin: loader.obj makefile
	linkLE loader.bin $(loader) $(dseg) loader.obj

loader.txt: loader.bin loader.csx
	dotnet script loader.csx $(loader)
