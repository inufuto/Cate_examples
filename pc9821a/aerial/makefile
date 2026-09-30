name=aerial

all: $(name).d88

cseg=0000
dseg=4000

.c.asm:
	Cate86.exe $*.c

.asm.obj:
	Asm86.exe $*.asm

Bang.asm: Bang.c Bang.h Movable.h Vram.h Sprite.h Movable.h \
	Stage.h Chars.h 
Bullet.asm: Bullet.c Bullet.h Movable.h Sprite.h Movable.h Stage.h 
EnemyBullet.asm: EnemyBullet.c EnemyBullet.h Bullet.h Movable.h Sprite.h Movable.h \
	Chars.h MyFighter.h Fighter.h Movable.h 
EnemyFighter.asm: EnemyFighter.c EnemyFighter.h Fighter.h Movable.h Sprite.h Movable.h \
	Stage.h Chars.h Math.h Bullet.h Movable.h Sound.h \
	Bang.h Movable.h Main.h EnemyBullet.h Bullet.h Movable.h \
	MyFighter.h Fighter.h Movable.h MyBullet.h Bullet.h Movable.h 
Fighter.asm: Fighter.c Fighter.h Movable.h Sprite.h Movable.h 
Fort.asm: Fort.c Fort.h Chars.h Vram.h Main.h Stage.h \
	Movable.h Sound.h Bang.h Movable.h Math.h EnemyBullet.h \
	Bullet.h Movable.h MyFighter.h Fighter.h Movable.h 
GroundEnemy.asm: GroundEnemy.c GroundEnemy.h Movable.h Sprite.h Movable.h Chars.h \
	Stage.h MyBullet.h Bullet.h Movable.h Sound.h Bang.h \
	Movable.h Main.h Math.h MyFighter.h Fighter.h Movable.h \
	EnemyBullet.h Bullet.h Movable.h Item.h Movable.h 
Item.asm: Item.c Item.h Movable.h Sprite.h Movable.h Vram.h \
	MyFighter.h Fighter.h Movable.h Status.h Main.h Sound.h \
	Chars.h Stage.h 
Main.asm: Main.c Main.h Stage.h ScanKeys.h Sprite.h Movable.h \
	Status.h Sound.h MyFighter.h Fighter.h Movable.h MyBullet.h \
	Bullet.h Movable.h EnemyFighter.h Fighter.h Movable.h EnemyBullet.h \
	Bullet.h Movable.h GroundEnemy.h Movable.h Fort.h Bang.h \
	Movable.h Item.h Movable.h Vram.h 
Movable.asm: Movable.c Movable.h 
MyBullet.asm: MyBullet.c MyBullet.h Bullet.h Movable.h Sprite.h Movable.h \
	Chars.h Sound.h MyFighter.h Fighter.h Movable.h EnemyFighter.h \
	Fighter.h Movable.h GroundEnemy.h Movable.h Fort.h 
MyFighter.asm: MyFighter.c MyFighter.h Fighter.h Movable.h Stage.h Chars.h \
	ScanKeys.h Sprite.h Movable.h MyBullet.h Bullet.h Movable.h \
	Sound.h Bang.h Movable.h Status.h Main.h Fort.h 
Sprite.asm: Sprite.c Sprite.h Movable.h Vram.h 
Stage.asm: Stage.c Stage.h Stages.h Main.h Chars.h CopyMemory.h \
	Math.h Status.h Sprite.h Movable.h MyFighter.h Fighter.h \
	Movable.h MyBullet.h Bullet.h Movable.h EnemyFighter.h Fighter.h \
	Movable.h EnemyBullet.h Bullet.h Movable.h GroundEnemy.h Movable.h \
	Fort.h Bang.h Movable.h Item.h Movable.h Vram.h 
Stages.asm: Stages.c Vram.h Stage.h Stages.h 
Status.asm: Status.c Status.h Vram.h Stage.h Main.h Sprite.h \
	Movable.h Print.h Chars.h 
Vram.asm: Vram.c Vram.h Chars.h Sprite.h Movable.h CopyMemory.h \
	Fort.h 
Chars.obj: Chars.asm 
CopyMemory.obj: CopyMemory.asm 
FortPattern.obj: FortPattern.asm 
Loader.obj: Loader.asm BinSize.inc 
Math.obj: Math.asm 
Print.obj: Print.asm 
ScanKeys.obj: ScanKeys.asm 
Sound.obj: Sound.asm 
Startup.obj: Startup.asm Segment.inc 
VramA.obj: VramA.asm Vram.inc Chars.inc 

objects = Startup.obj \
	Bang.obj Bullet.obj EnemyBullet.obj EnemyFighter.obj Fighter.obj Fort.obj \
	GroundEnemy.obj Item.obj Main.obj Movable.obj MyBullet.obj MyFighter.obj \
	Sprite.obj Stage.obj Stages.obj Status.obj Vram.obj Chars.obj \
	CopyMemory.obj FortPattern.obj Math.obj Print.obj ScanKeys.obj Sound.obj \
	VramA.obj \
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
