name=aerial

all: $(name).bin

cseg=8000-8201,4000
dseg=1000
zseg=00d0

.c.asm:
	Cate65.exe -65c02 -v2 $*.c

.asm.obj:
	Asm65.exe -65c02 $*.asm

Bang.asm: Bang.c Bang.h Movable.h Vram.h VVram.h Sprite.h \
	Movable.h Stage.h Vram.h Chars.h 
Bullet.asm: Bullet.c Bullet.h Movable.h Sprite.h Movable.h Stage.h \
	Vram.h 
EnemyBullet.asm: EnemyBullet.c EnemyBullet.h Bullet.h Movable.h Sprite.h Movable.h \
	Chars.h MyFighter.h Movable.h 
EnemyFighter.asm: EnemyFighter.c EnemyFighter.h Movable.h Sprite.h Movable.h Stage.h \
	Vram.h Chars.h Math.h Bullet.h Movable.h Sound.h \
	Bang.h Movable.h Main.h EnemyBullet.h Bullet.h Movable.h \
	MyFighter.h Movable.h MyBullet.h Bullet.h Movable.h 
Fort.asm: Fort.c Fort.h Chars.h VVram.h Main.h Stage.h \
	Vram.h Movable.h Sound.h Bang.h Movable.h Math.h \
	EnemyBullet.h Bullet.h Movable.h MyFighter.h Movable.h 
GroundEnemy.asm: GroundEnemy.c GroundEnemy.h Movable.h Sprite.h Movable.h Chars.h \
	Stage.h Vram.h MyBullet.h Bullet.h Movable.h Sound.h \
	Bang.h Movable.h Main.h Math.h MyFighter.h Movable.h \
	EnemyBullet.h Bullet.h Movable.h Item.h Movable.h 
Item.asm: Item.c Item.h Movable.h Sprite.h Movable.h Vram.h \
	MyFighter.h Movable.h Status.h Main.h Sound.h Chars.h \
	Stage.h Vram.h 
Main.asm: Main.c Main.h Stage.h Vram.h ScanKeys.h Sprite.h \
	Movable.h Status.h Sound.h MyFighter.h Movable.h MyBullet.h \
	Bullet.h Movable.h EnemyFighter.h Movable.h EnemyBullet.h Bullet.h \
	Movable.h GroundEnemy.h Movable.h Fort.h Bang.h Movable.h \
	Item.h Movable.h Vram.h 
Math.asm: Math.c Math.h 
Movable.asm: Movable.c Movable.h 
MyBullet.asm: MyBullet.c MyBullet.h Bullet.h Movable.h Sprite.h Movable.h \
	Chars.h Sound.h MyFighter.h Movable.h EnemyFighter.h Movable.h \
	GroundEnemy.h Movable.h Fort.h 
MyFighter.asm: MyFighter.c MyFighter.h Movable.h Stage.h Vram.h Chars.h \
	ScanKeys.h Sprite.h Movable.h MyBullet.h Bullet.h Movable.h \
	Sound.h Bang.h Movable.h Status.h Main.h Fort.h 
Stage.asm: Stage.c Stage.h Vram.h Stages.h Main.h Chars.h \
	CopyMemory.h Math.h Status.h Sprite.h Movable.h MyFighter.h \
	Movable.h MyBullet.h Bullet.h Movable.h EnemyFighter.h Movable.h \
	EnemyBullet.h Bullet.h Movable.h GroundEnemy.h Movable.h Fort.h \
	Bang.h Movable.h Item.h Movable.h 
Stages.asm: Stages.c Vram.h Stage.h Vram.h Stages.h 
Status.asm: Status.c Status.h Vram.h Main.h Sprite.h Movable.h \
	Print.h 
Vram.asm: Vram.c Vram.h VVram.h Fort.h 
VVram.asm: VVram.c VVram.h Chars.h Vram.h 
Chars.obj: Chars.asm 
CopyMemory.obj: CopyMemory.asm ZeroPage.inc 
Print.obj: Print.asm 
RomHead.obj: RomHead.asm 
ScanKeys.obj: ScanKeys.asm GameKing.inc 
Sound.obj: Sound.asm GameKing.inc ZeroPage.inc 
Sprite.obj: Sprite.asm GameKing.inc ZeroPage.inc Vram.inc 
StageA.obj: StageA.asm ZeroPage.inc 
Startup.obj: Startup.asm GameKing.inc 
VramA.obj: VramA.asm GameKing.inc ZeroPage.inc Vram.inc VVram.inc 
VVramA.obj: VVramA.asm ZeroPage.inc Vram.inc VVram.inc 
ZeroPage.obj: ZeroPage.asm 

objects = RomHead.obj Startup.obj \
	Bang.obj Bullet.obj EnemyBullet.obj EnemyFighter.obj Fort.obj GroundEnemy.obj \
	Item.obj Main.obj Math.obj Movable.obj MyBullet.obj MyFighter.obj \
	Stage.obj Stages.obj Status.obj Vram.obj VVram.obj Chars.obj \
	CopyMemory.obj Print.obj ScanKeys.obj Sound.obj Sprite.obj StageA.obj \
	VramA.obj VVramA.obj ZeroPage.obj \
	..\..\cate\cate65.lib

_raw.bin: $(objects) makefile
	LinkLE.exe _raw.bin $(cseg) $(dseg) $(zseg) $(objects)
	copy _raw.symbols.txt $(name).symbols.txt /y

$(name).bin: _raw.bin MakeRom.csx
	dotnet script MakeRom.csx $(name)
