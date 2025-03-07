name=impetus

all:$(name).dsk

cseg=6000
zseg=00e0-00ff,0000
dseg=0900

.c.asm:
	Cate65.exe $*.c

.asm.obj:
	Asm65.exe $*.asm

Bang.asm: Bang.c Bang.h Sprite.h VVram.h Chars.h 
Barrier.asm: Barrier.c Barrier.h Sprite.h Math.h Main.h VVram.h \
	Chars.h VVram.h Bang.h Fighter.h Sound.h 
EnemyBullet.asm: EnemyBullet.c EnemyBullet.h Sprite.h VVram.h Fighter.h Math.h \
	Chars.h 
Fighter.asm: Fighter.c Fighter.h VVram.h Sprite.h ScanKeys.h FighterBullet.h \
	Bang.h Barrier.h Sound.h Status.h Main.h Chars.h 
FighterBullet.asm: FighterBullet.c FighterBullet.h VVram.h Sprite.h Fighter.h Vram.h \
	SkyEnemy.h GroundEnemy.h Stage.h Barrier.h Fort.h Sound.h \
	Chars.h 
Fort.asm: Fort.c Fort.h Sprite.h Chars.h VVram.h Stage.h \
	Bang.h Main.h EnemyBullet.h Math.h Sound.h 
GroundEnemy.asm: GroundEnemy.c Stage.h GroundEnemy.h Stage.h Sprite.h VVram.h \
	Math.h Main.h EnemyBullet.h Bang.h Main.h Sound.h \
	Chars.h 
Item.asm: Item.c Item.h Sprite.h Vram.h Fighter.h Status.h \
	Main.h Sound.h VVram.h Chars.h 
Main.asm: Main.c Main.h Init.h Stage.h ScanKeys.h VVram.h \
	Sprite.h Fighter.h FighterBullet.h SkyEnemy.h EnemyBullet.h Status.h \
	Bang.h Barrier.h GroundEnemy.h Stage.h Fort.h Sound.h \
	Item.h Vram.h 
Math.asm: Math.c Math.h 
Print.asm: Print.c Print.h Vram.h Status.h 
SkyEnemy.asm: SkyEnemy.c SkyEnemy.h Sprite.h VVram.h Math.h Main.h \
	Fighter.h EnemyBullet.h Stage.h Bang.h Main.h Barrier.h \
	Sound.h Item.h Chars.h 
Sprite.asm: Sprite.c Sprite.h Chars.h VVram.h Vram.h 
Stage.asm: Stage.c Stage.h Stages.h Main.h Vram.h Chars.h \
	CopyMemory.h VVram.h Fighter.h FighterBullet.h SkyEnemy.h EnemyBullet.h \
	Bang.h Math.h Status.h Barrier.h GroundEnemy.h Stage.h \
	Fort.h Sprite.h Item.h 
Stages.asm: Stages.c Stage.h Stages.h Chars.h 
Status.asm: Status.c Status.h Vram.h Stage.h Main.h Sprite.h \
	Print.h Chars.h VVram.h CopyMemory.h 
Vram.asm: Vram.c Vram.h VVram.h CopyMemory.h Chars.h 
VVram.asm: VVram.c VVram.h Chars.h Sprite.h Vram.h Fort.h \
	Barrier.h 
Chars.obj: Chars.asm 
CopyMemory.obj: CopyMemory.asm ZeroPage.inc 
Init.obj: Init.asm Apple2.inc 
Loader.obj: Loader.asm BinSize.inc
ScanKeys.obj: ScanKeys.asm Apple2.inc ZeroPage.inc 
Sound.obj: Sound.asm Apple2.inc ZeroPage.inc 
VramA.obj: VramA.asm ZeroPage.inc Vram.inc VVram.inc 
VVramA.obj: VVramA.asm ZeroPage.inc VVram.inc 
ZeroPage.obj: ZeroPage.asm 

objects = Main.obj \
	Bang.obj Barrier.obj EnemyBullet.obj Fighter.obj FighterBullet.obj Fort.obj \
	GroundEnemy.obj Item.obj Math.obj Print.obj SkyEnemy.obj Sprite.obj \
	Stage.obj Stages.obj Status.obj Vram.obj VVram.obj Chars.obj \
	CopyMemory.obj Init.obj ScanKeys.obj Sound.obj VramA.obj VVramA.obj \
	ZeroPage.obj \
	..\..\cate\cate65.lib

$(name).bin: $(objects) makefile
	LinkLE.exe $(name).bin $(cseg) $(dseg) $(zseg) $(objects)

BinSize.inc: $(name).bin BinSize.csx
	dotnet script BinSize.csx $(name) $(cseg)

Loader.bin: Loader.obj BinSize.inc makefile 
	LinkLE.exe Loader.bin 0800 08f0 00e0 Loader.obj

$(name).dsk: $(name).bin Loader.bin Disk.csx
	dotnet script Disk.csx $(name)
