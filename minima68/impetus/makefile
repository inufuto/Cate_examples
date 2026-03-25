name=impetus

filename=$(name).bin

all: $(filename)

cseg=0100
dseg=4800
zseg=0000

.c.asm:
	Cate68.exe $*.c

.asm.obj:
	Asm68.exe -v2 $*.asm

Bang.asm: Bang.c Bang.h Vram.h Sprite.h Stage.h Chars.h 
Barrier.asm: Barrier.c Barrier.h Sprite.h Vram.h Math.h Main.h \
	Chars.h Stage.h Bang.h Fighter.h Sound.h 
EnemyBullet.asm: EnemyBullet.c EnemyBullet.h Sprite.h Stage.h Fighter.h Vram.h \
	Math.h Chars.h 
Fighter.asm: Fighter.c Fighter.h Vram.h Sprite.h ScanKeys.h FighterBullet.h \
	Bang.h Barrier.h Sound.h Status.h Main.h Chars.h 
FighterBullet.asm: FighterBullet.c FighterBullet.h Stage.h Sprite.h Fighter.h Vram.h \
	SkyEnemy.h GroundEnemy.h Barrier.h Fort.h Sound.h Chars.h 
Fort.asm: Fort.c Fort.h Sprite.h Vram.h Chars.h Stage.h \
	Bang.h Main.h EnemyBullet.h Math.h Sound.h 
GroundEnemy.asm: GroundEnemy.c Stage.h GroundEnemy.h Sprite.h Vram.h Math.h \
	Main.h EnemyBullet.h Bang.h Main.h Sound.h Chars.h 
Item.asm: Item.c Item.h Sprite.h Vram.h Fighter.h Status.h \
	Main.h Sound.h Chars.h 
Main.asm: Main.c Main.h Stage.h ScanKeys.h Vram.h Sprite.h \
	Fighter.h FighterBullet.h SkyEnemy.h EnemyBullet.h Status.h Bang.h \
	Barrier.h GroundEnemy.h Fort.h Sound.h Item.h 
Math.asm: Math.c Math.h 
SkyEnemy.asm: SkyEnemy.c SkyEnemy.h Sprite.h Vram.h Math.h Main.h \
	Fighter.h EnemyBullet.h Stage.h Bang.h Main.h Barrier.h \
	Sound.h Item.h Chars.h 
Stage.asm: Stage.c Stage.h Stages.h Main.h Vram.h Chars.h \
	CopyMemory.h Fighter.h FighterBullet.h SkyEnemy.h EnemyBullet.h Bang.h \
	Math.h Status.h Barrier.h GroundEnemy.h Fort.h Sprite.h \
	Item.h 
Stages.asm: Stages.c Stage.h Stages.h Chars.h 
Status.asm: Status.c Status.h Vram.h Main.h Sprite.h Chars.h \
	Print.h CopyMemory.h Stage.h 
Vram.asm: Vram.c Vram.h Chars.h Sprite.h Stage.h Barrier.h \
	Fort.h 
Chars.obj: Chars.asm 
CopyMemory.obj: CopyMemory.asm 
FortA.obj: FortA.asm Vram.inc Chars.inc 
Print.obj: Print.asm 
ScanKeys.obj: ScanKeys.asm 
Sound.obj: Sound.asm 
Sprite.obj: Sprite.asm Direct.inc  Vram.inc 
StageA.obj: StageA.asm Direct.inc  Vram.inc Chars.inc 
Startup.obj: Startup.asm Vram.inc 
VramA.obj: VramA.asm Direct.inc  Vram.inc Chars.inc 

objects = Startup.obj \
	Bang.obj Barrier.obj EnemyBullet.obj Fighter.obj FighterBullet.obj Fort.obj \
	GroundEnemy.obj Item.obj Main.obj Math.obj SkyEnemy.obj Stage.obj \
	Stages.obj Status.obj Vram.obj Chars.obj CopyMemory.obj FortA.obj \
	Print.obj ScanKeys.obj Sound.obj Sprite.obj StageA.obj VramA.obj \
	..\..\cate\cate68.lib

$(filename): $(objects) makefile
	LinkBE.exe $(filename) $(cseg) $(dseg) $(zseg) $(objects)
