name=aerial

all:$(name).dsk

cseg=6000
zseg=00e0-00ff,0000
dseg=0900

.c.asm:
	Cate65.exe $*.c

.asm.obj:
	Asm65.exe $*.asm

Bang.asm: Bang.c Bang.h Movable.h VVram.h Vram.h Sprite.h \
	Movable.h Stage.h VVram.h Vram.h Chars.h 
Bullet.asm: Bullet.c Bullet.h Movable.h Sprite.h Movable.h Stage.h \
	VVram.h Vram.h 
EnemyBullet.asm: EnemyBullet.c EnemyBullet.h Bullet.h Movable.h Sprite.h Movable.h \
	Chars.h MyFighter.h Fighter.h Movable.h 
EnemyFighter.asm: EnemyFighter.c EnemyFighter.h Fighter.h Movable.h Sprite.h Movable.h \
	Stage.h VVram.h Vram.h Chars.h Math.h Bullet.h \
	Movable.h Sound.h Bang.h Movable.h Main.h EnemyBullet.h \
	Bullet.h Movable.h MyFighter.h Fighter.h Movable.h MyBullet.h \
	Bullet.h Movable.h 
Fighter.asm: Fighter.c Fighter.h Movable.h Sprite.h Movable.h 
Fort.asm: Fort.c Fort.h Chars.h VVram.h Vram.h Main.h \
	Stage.h VVram.h Vram.h Movable.h Sound.h Bang.h \
	Movable.h Math.h EnemyBullet.h Bullet.h Movable.h MyFighter.h \
	Fighter.h Movable.h 
GroundEnemy.asm: GroundEnemy.c GroundEnemy.h Movable.h Sprite.h Movable.h Chars.h \
	Stage.h VVram.h Vram.h MyBullet.h Bullet.h Movable.h \
	Sound.h Bang.h Movable.h Main.h Math.h MyFighter.h \
	Fighter.h Movable.h EnemyBullet.h Bullet.h Movable.h Item.h \
	Movable.h 
Item.asm: Item.c Item.h Movable.h Sprite.h Movable.h VVram.h \
	Vram.h MyFighter.h Fighter.h Movable.h Status.h Main.h \
	Sound.h Chars.h 
Main.asm: Main.c Main.h Init.h Stage.h VVram.h Vram.h \
	ScanKeys.h Sprite.h Movable.h Status.h Sound.h MyFighter.h \
	Fighter.h Movable.h MyBullet.h Bullet.h Movable.h EnemyFighter.h \
	Fighter.h Movable.h EnemyBullet.h Bullet.h Movable.h GroundEnemy.h \
	Movable.h Fort.h Bang.h Movable.h Item.h Movable.h \
	VVram.h Vram.h 
Math.asm: Math.c Math.h 
Movable.asm: Movable.c Movable.h 
MyBullet.asm: MyBullet.c MyBullet.h Bullet.h Movable.h Sprite.h Movable.h \
	Chars.h Sound.h MyFighter.h Fighter.h Movable.h EnemyFighter.h \
	Fighter.h Movable.h GroundEnemy.h Movable.h Fort.h 
MyFighter.asm: MyFighter.c MyFighter.h Fighter.h Movable.h Stage.h VVram.h \
	Vram.h Chars.h ScanKeys.h Sprite.h Movable.h MyBullet.h \
	Bullet.h Movable.h Sound.h Bang.h Movable.h Status.h \
	Main.h Fort.h 
Print.asm: Print.c Print.h Vram.h 
Sprite.asm: Sprite.c Sprite.h Movable.h Chars.h VVram.h Vram.h \
	Bullet.h Movable.h 
Stage.asm: Stage.c Stage.h VVram.h Vram.h Stages.h Main.h \
	Chars.h CopyMemory.h Math.h Status.h Sprite.h Movable.h \
	MyFighter.h Fighter.h Movable.h MyBullet.h Bullet.h Movable.h \
	EnemyFighter.h Fighter.h Movable.h EnemyBullet.h Bullet.h Movable.h \
	GroundEnemy.h Movable.h Fort.h Bang.h Movable.h Item.h \
	Movable.h 
Stages.asm: Stages.c Vram.h Stage.h VVram.h Vram.h Stages.h 
Status.asm: Status.c Status.h Vram.h Stage.h VVram.h Vram.h \
	Main.h Sprite.h Movable.h Print.h Chars.h VVram.h \
	Vram.h CopyMemory.h 
Vram.asm: Vram.c Vram.h VVram.h Vram.h CopyMemory.h Chars.h 
VVram.asm: VVram.c VVram.h Vram.h Chars.h Sprite.h Movable.h \
	Vram.h Fort.h 
Chars.obj: Chars.asm 
CopyMemory.obj: CopyMemory.asm ZeroPage.inc 
Init.obj: Init.asm Apple2.inc 
Loader.obj: Loader.asm BinSize.inc
ScanKeys.obj: ScanKeys.asm Apple2.inc ZeroPage.inc 
Sound.obj: Sound.asm Apple2.inc ZeroPage.inc 
VramA.obj: VramA.asm ZeroPage.inc Vram.inc 
VVramA.obj: VVramA.asm ZeroPage.inc VVram.inc 
ZeroPage.obj: ZeroPage.asm 

objects = Main.obj \
	Bang.obj Bullet.obj EnemyBullet.obj EnemyFighter.obj Fighter.obj Fort.obj \
	GroundEnemy.obj Item.obj Math.obj Movable.obj MyBullet.obj MyFighter.obj \
	Print.obj Sprite.obj Stage.obj Stages.obj Status.obj Vram.obj \
	VVram.obj Chars.obj CopyMemory.obj Init.obj ScanKeys.obj Sound.obj \
	VramA.obj VVramA.obj ZeroPage.obj \
	..\..\cate\cate65.lib

$(name).bin: $(objects) makefile
	LinkLE.exe $(name).bin $(cseg) $(dseg) $(zseg) $(objects)

BinSize.inc: $(name).bin BinSize.csx
	dotnet script BinSize.csx $(name) $(cseg)

Loader.bin: Loader.obj BinSize.inc makefile 
	LinkLE.exe Loader.bin 0800 08f0 00e0 Loader.obj

$(name).dsk: $(name).bin Loader.bin Disk.csx
	dotnet script Disk.csx $(name)
