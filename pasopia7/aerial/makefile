name=aerial

cseg=9000
dseg=C000

all: $(name).ram $(name).d88

.c.asm:
	Cate80.exe $*.c

.asm.obj:
	Asm80.exe $*.asm

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
	Main.h Sprite.h Movable.h Print.h Chars.h 
Vram.asm: Vram.c Vram.h Chars.h 
VVram.asm: VVram.c VVram.h Vram.h Chars.h Sprite.h Movable.h \
	Vram.h Fort.h 
Chars.obj: Chars.asm 
CopyMemory.obj: CopyMemory.asm 
FixedCode.obj: FixedCode.asm 
Init.obj: Init.asm FixedCode.inc 
Loader.obj: Loader.asm BinSize.inc 
Print.obj: Print.asm 
ScanKeys.obj: ScanKeys.asm 
Sound.obj: Sound.asm 
VramA.obj: VramA.asm FixedCode.inc Vram.inc VVram.inc 
VramTrans.obj: VramTrans.asm 
VVramA.obj: VVramA.asm VVram.inc 

objects = Main.obj \
	Bang.obj Bullet.obj EnemyBullet.obj EnemyFighter.obj Fighter.obj Fort.obj \
	GroundEnemy.obj Item.obj Math.obj Movable.obj MyBullet.obj MyFighter.obj \
	Sprite.obj Stage.obj Stages.obj Status.obj Vram.obj VVram.obj \
	Chars.obj CopyMemory.obj FixedCode.obj Init.obj Print.obj ScanKeys.obj \
	Sound.obj VramA.obj VVramA.obj \
	..\..\cate\cate80.lib

FixedCode.bin: VramTrans.obj
	LinkLE.exe FixedCode.bin D400 F000 VramTrans.obj

FixedCode.asm FixedCode.inc: FixedCode.bin
	dotnet script BinAsm.csx

$(name).ram: $(objects)
	LinkLE.exe $(name).ram $(cseg) $(dseg) $(objects)


$(name).bin: $(objects) makefile
	LinkLE.exe $(name).bin $(cseg) $(dseg) $(objects)

BinSize.inc: $(name).bin BinSize.csx
	dotnet script BinSize.csx $(name) $(cseg)

Loader.bin: Loader.obj makefile
    LinkLE.exe Loader.bin f000 f100 Loader.obj

$(name).d88: $(name).bin Loader.bin makefile disk.csx
    dotnet script disk.csx $(name)
