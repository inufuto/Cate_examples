name=impetus

all: $(name).d88

cseg=0000
dseg=4700

.c.asm:
	Cate86.exe $*.c

.asm.obj:
	Asm86.exe $*.asm

Bang.asm: Bang.c Bang.h Sprite.h Stage.h Chars.h Vram.h 
Barrier.asm: Barrier.c Barrier.h Sprite.h Vram.h Math.h Main.h \
	Chars.h Stage.h Bang.h Fighter.h Sound.h 
EnemyBullet.asm: EnemyBullet.c EnemyBullet.h Sprite.h Stage.h Fighter.h Math.h \
	Chars.h Vram.h 
Fighter.asm: Fighter.c Fighter.h Sprite.h ScanKeys.h FighterBullet.h Bang.h \
	Barrier.h Sound.h Status.h Main.h Chars.h Vram.h 
FighterBullet.asm: FighterBullet.c FighterBullet.h Stage.h Sprite.h Fighter.h Vram.h \
	SkyEnemy.h GroundEnemy.h Barrier.h Fort.h Sound.h Chars.h 
Fort.asm: Fort.c Fort.h Sprite.h Vram.h Chars.h Stage.h \
	Bang.h Main.h EnemyBullet.h Math.h Sound.h 
GroundEnemy.asm: GroundEnemy.c Stage.h GroundEnemy.h Sprite.h Math.h Main.h \
	EnemyBullet.h Bang.h Main.h Sound.h Chars.h Vram.h 
Item.asm: Item.c Item.h Sprite.h Vram.h Fighter.h Status.h \
	Main.h Sound.h Chars.h 
Main.asm: Main.c Main.h Stage.h ScanKeys.h Sprite.h Fighter.h \
	FighterBullet.h SkyEnemy.h EnemyBullet.h Status.h Bang.h Barrier.h \
	GroundEnemy.h Fort.h Sound.h Item.h Vram.h 
Math.asm: Math.c Math.h 
SkyEnemy.asm: SkyEnemy.c SkyEnemy.h Sprite.h Math.h Main.h Fighter.h \
	EnemyBullet.h Stage.h Bang.h Main.h Barrier.h Sound.h \
	Item.h Chars.h Vram.h 
Sprite.asm: Sprite.c Sprite.h Vram.h 
Stage.asm: Stage.c Stage.h Stages.h Main.h Vram.h Chars.h \
	CopyMemory.h Fighter.h FighterBullet.h SkyEnemy.h EnemyBullet.h Bang.h \
	Math.h Status.h Barrier.h GroundEnemy.h Fort.h Sprite.h \
	Item.h 
Stages.asm: Stages.c Stage.h Stages.h Chars.h 
Status.asm: Status.c Status.h Vram.h Stage.h Main.h Sprite.h \
	Print.h Chars.h 
Vram.asm: Vram.c Vram.h Chars.h Sprite.h CopyMemory.h Barrier.h \
	Fort.h Sound.h 
Chars.obj: Chars.asm 
CopyMemory.obj: CopyMemory.asm 
Loader.obj: Loader.asm BinSize.inc 
Print.obj: Print.asm 
ScanKeys.obj: ScanKeys.asm 
Sound.obj: Sound.asm 
Startup.obj: Startup.asm 
VramA.obj: VramA.asm Vram.inc Chars.inc 

objects = Startup.obj \
	Bang.obj Barrier.obj EnemyBullet.obj Fighter.obj FighterBullet.obj Fort.obj \
	GroundEnemy.obj Item.obj Main.obj Math.obj SkyEnemy.obj Sprite.obj \
	Stage.obj Stages.obj Status.obj Vram.obj Chars.obj CopyMemory.obj \
	Print.obj ScanKeys.obj Sound.obj VramA.obj \
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
