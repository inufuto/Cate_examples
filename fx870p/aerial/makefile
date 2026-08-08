name=aerial

all: $(name).pbf Clear.bas loader.bas $(name)_1.bas

cseg=1cd0 # MODE110(7376)
dseg=4700

.c.asm:
	Cate61h.exe $*.c

.asm.obj:
	Asm61h.exe $*.asm

Bang.asm: Bang.c Bang.h Movable.h VVram.h Vram.h Sprite.h \
	Movable.h Stage.h VVram.h Vram.h 
Bullet.asm: Bullet.c Bullet.h Movable.h Sprite.h Movable.h Stage.h \
	VVram.h Vram.h 
EnemyBullet.asm: EnemyBullet.c EnemyBullet.h Bullet.h Movable.h Sprite.h Movable.h \
	MyFighter.h Fighter.h Movable.h 
EnemyFighter.asm: EnemyFighter.c EnemyFighter.h Fighter.h Movable.h Sprite.h Movable.h \
	Stage.h VVram.h Vram.h Math.h Bullet.h Movable.h \
	Sound.h Bang.h Movable.h Main.h EnemyBullet.h Bullet.h \
	Movable.h MyFighter.h Fighter.h Movable.h MyBullet.h Bullet.h \
	Movable.h 
Fighter.asm: Fighter.c Fighter.h Movable.h Sprite.h Movable.h 
Fort.asm: Fort.c Fort.h VVram.h Vram.h Main.h Stage.h \
	VVram.h Vram.h Movable.h Sound.h Bang.h Movable.h \
	Math.h EnemyBullet.h Bullet.h Movable.h MyFighter.h Fighter.h \
	Movable.h 
GroundEnemy.asm: GroundEnemy.c GroundEnemy.h Movable.h Sprite.h Movable.h Stage.h \
	VVram.h Vram.h MyBullet.h Bullet.h Movable.h Sound.h \
	Bang.h Movable.h Main.h Math.h MyFighter.h Fighter.h \
	Movable.h EnemyBullet.h Bullet.h Movable.h Item.h Movable.h 
Item.asm: Item.c Item.h Movable.h Sprite.h Movable.h VVram.h \
	Vram.h MyFighter.h Fighter.h Movable.h Status.h Main.h \
	Sound.h 
Main.asm: Main.c Main.h Stage.h VVram.h Vram.h ScanKeys.h \
	Sprite.h Movable.h Status.h Sound.h MyFighter.h Fighter.h \
	Movable.h MyBullet.h Bullet.h Movable.h EnemyFighter.h Fighter.h \
	Movable.h EnemyBullet.h Bullet.h Movable.h GroundEnemy.h Movable.h \
	Fort.h Bang.h Movable.h Item.h Movable.h VVram.h \
	Vram.h 
Math.asm: Math.c Math.h 
Movable.asm: Movable.c Movable.h 
MyBullet.asm: MyBullet.c MyBullet.h Bullet.h Movable.h Sprite.h Movable.h \
	Sound.h MyFighter.h Fighter.h Movable.h EnemyFighter.h Fighter.h \
	Movable.h GroundEnemy.h Movable.h Fort.h 
MyFighter.asm: MyFighter.c MyFighter.h Fighter.h Movable.h Stage.h VVram.h \
	Vram.h ScanKeys.h Sprite.h Movable.h MyBullet.h Bullet.h \
	Movable.h Sound.h Bang.h Movable.h Status.h Main.h \
	Fort.h 
Sprite.asm: Sprite.c Sprite.h Movable.h VVram.h Vram.h Bullet.h \
	Movable.h 
Stage.asm: Stage.c Stage.h VVram.h Vram.h Stages.h Main.h \
	CopyMemory.h Math.h Status.h Sprite.h Movable.h MyFighter.h \
	Fighter.h Movable.h MyBullet.h Bullet.h Movable.h EnemyFighter.h \
	Fighter.h Movable.h EnemyBullet.h Bullet.h Movable.h GroundEnemy.h \
	Movable.h Fort.h Bang.h Movable.h Item.h Movable.h 
Stages.asm: Stages.c Vram.h Stage.h VVram.h Vram.h Stages.h 
Status.asm: Status.c Status.h Vram.h Main.h Sprite.h Movable.h \
	Print.h 
Vram.asm: Vram.c Vram.h 
VVram.asm: VVram.c VVram.h Vram.h Sprite.h Movable.h Vram.h \
	Fort.h Sound.h 
CopyMemory.obj: CopyMemory.asm 
Loader.obj: Loader.asm 
Print.obj: Print.asm 
ScanKeys.obj: ScanKeys.asm 
Sound.obj: Sound.asm 
Startup.obj: Startup.asm 
VramA.obj: VramA.asm Vram.inc VVram.inc 
VVramA.obj: VVramA.asm VVram.inc 

objects = Startup.obj \
	Bang.obj Bullet.obj EnemyBullet.obj EnemyFighter.obj Fighter.obj Fort.obj \
	GroundEnemy.obj Item.obj Main.obj Math.obj Movable.obj MyBullet.obj \
	MyFighter.obj Sprite.obj Stage.obj Stages.obj Status.obj Vram.obj \
	VVram.obj CopyMemory.obj Print.obj ScanKeys.obj Sound.obj VramA.obj \
	VVramA.obj \
	..\..\cate\cate61h.lib

$(name).bin: $(objects) makefile
	LinkLE.exe $(name).bin $(cseg) $(dseg) $(objects)

$(name).pbf: $(objects) makefile
	LinkLE.exe $(name).pbf $(cseg) $(dseg) $(objects)

loader.bin: loader.obj makefile
	LinkLE.exe loader.bin $(dseg) $(dseg) loader.obj

$(name)_1.bas: $(name).bin BinBas.csx loader.bin makefile
	dotnet script BinBas.csx $(name) $(cseg) $(dseg)

Clear.bas: $(name).bin Clear.csx makefile
	dotnet script Clear.csx $(name)

loader.bas: Makeloader.csx $(name).bin loader.bin makefile
	dotnet script Makeloader.csx $(name) $(cseg) $(dseg)
