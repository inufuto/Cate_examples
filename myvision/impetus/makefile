name=impetus

all: $(name).rom

cseg=0000
dseg=a000

.c.asm:
	Cate80.exe $*.c

.asm.obj:
	Asm80.exe -v2 $*.asm

Bang.asm: Bang.c Bang.h Vram.h Sprite.h Stage.h Chars.h 
Barrier.asm: Barrier.c Barrier.h Sprite.h Vram.h Math.h Main.h \
	Chars.h Stage.h Bang.h Fighter.h Sound.h 
EnemyBullet.asm: EnemyBullet.c EnemyBullet.h Sprite.h Stage.h Fighter.h Vram.h \
	Math.h 
Fighter.asm: Fighter.c Fighter.h Vram.h Sprite.h ScanKeys.h FighterBullet.h \
	Bang.h Barrier.h Sound.h Status.h Main.h 
FighterBullet.asm: FighterBullet.c FighterBullet.h Stage.h Sprite.h Fighter.h Vram.h \
	SkyEnemy.h GroundEnemy.h Barrier.h Fort.h Sound.h 
Fort.asm: Fort.c Fort.h Sprite.h Vram.h Chars.h Stage.h \
	Bang.h Main.h EnemyBullet.h Math.h Sound.h 
GroundEnemy.asm: GroundEnemy.c Stage.h GroundEnemy.h Sprite.h Vram.h Math.h \
	Main.h EnemyBullet.h Bang.h Main.h Sound.h 
Item.asm: Item.c Item.h Sprite.h Vram.h Fighter.h Status.h \
	Main.h Sound.h 
Main.asm: Main.c Main.h Stage.h ScanKeys.h Sprite.h Fighter.h \
	FighterBullet.h SkyEnemy.h EnemyBullet.h Status.h Bang.h Barrier.h \
	GroundEnemy.h Fort.h Sound.h Item.h Vram.h 
Math.asm: Math.c Math.h 
SkyEnemy.asm: SkyEnemy.c SkyEnemy.h Sprite.h Vram.h Math.h Main.h \
	Fighter.h EnemyBullet.h Stage.h Bang.h Main.h Barrier.h \
	Sound.h Item.h 
Stage.asm: Stage.c Stage.h Stages.h Main.h Vram.h Chars.h \
	CopyMemory.h Fighter.h FighterBullet.h SkyEnemy.h EnemyBullet.h Bang.h \
	Math.h Status.h Barrier.h GroundEnemy.h Fort.h Sprite.h \
	Item.h 
Stages.asm: Stages.c Stage.h Stages.h Chars.h 
Status.asm: Status.c Status.h Vram.h Main.h Sprite.h Chars.h \
	Print.h CopyMemory.h 
Vram.asm: Vram.c Vram.h Stage.h Barrier.h Fort.h Sprite.h 
Chars.obj: Chars.asm 
CopyMemory.obj: CopyMemory.asm 
FortA.obj: FortA.asm kh1000.inc Vram.inc Chars.inc 
Print.obj: Print.asm 
ScanKeys.obj: ScanKeys.asm kh1000.inc 
Sound.obj: Sound.asm kh1000.inc 
Sprite.obj: Sprite.asm kh1000.inc Vram.inc 
StageA.obj: StageA.asm kh1000.inc Vram.inc Chars.inc 
Startup.obj: Startup.asm kh1000.inc 
Vdp.obj: Vdp.asm kh1000.inc Vram.inc 
VramA.obj: VramA.asm kh1000.inc Vram.inc Chars.inc 

objects = startup.obj \
	Bang.obj Barrier.obj EnemyBullet.obj Fighter.obj FighterBullet.obj Fort.obj \
	GroundEnemy.obj Item.obj Main.obj Math.obj SkyEnemy.obj Stage.obj \
	Stages.obj Status.obj Vram.obj Chars.obj CopyMemory.obj FortA.obj \
	Print.obj ScanKeys.obj Sound.obj Sprite.obj StageA.obj Vdp.obj \
	VramA.obj \
	..\..\cate\cate80.lib

$(name).rom: $(objects) makefile
	LinkLE.exe $(name).rom $(cseg) $(dseg) $(objects)
