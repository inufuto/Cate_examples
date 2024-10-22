name=ruptus

all: $(name).bin

cseg=0000
dseg=c0a0

.c.asm:
	Cate83.exe $*.c

.asm.obj:
	Asm83.exe $*.asm

Bang.asm: Bang.c Bang.h Sprite.h Vram.h Stage.h Chars.h 
Barrier.asm: Barrier.c Barrier.h Stage.h Stages.h Vram.h Chars.h \
	Sprite.h Bang.h Main.h Mover.h Sound.h 
Direction.asm: Direction.c Direction.h 
Enemy.asm: Enemy.c Enemy.h Stage.h Fighter.h Vram.h Sprite.h \
	Chars.h Direction.h Main.h Bang.h Barrier.h Stage.h \
	Fort.h Stage.h Mover.h Item.h Sound.h 
EnemyBullet.asm: EnemyBullet.c EnemyBullet.h Enemy.h Sprite.h Enemy.h Stage.h \
	Vram.h Chars.h Direction.h Fighter.h Barrier.h Stage.h \
	Fort.h Stage.h 
Fighter.asm: Fighter.c Fighter.h Stage.h Sprite.h Vram.h Chars.h \
	Direction.h ScanKeys.h FighterBullet.h Bang.h Barrier.h Stage.h \
	Fort.h Stage.h Mover.h Item.h Main.h Status.h \
	Sound.h 
FighterBullet.asm: FighterBullet.c FighterBullet.h Sprite.h Fighter.h Stage.h Vram.h \
	Chars.h Direction.h Enemy.h Main.h Barrier.h Stage.h \
	Fort.h Stage.h Sound.h 
Fort.asm: Fort.c Fort.h Stage.h Stages.h Vram.h Chars.h \
	Bang.h Main.h Mover.h Status.h Sound.h 
Item.asm: Item.c Item.h Stage.h Vram.h Sprite.h Chars.h \
	Mover.h 
Main.asm: Main.c Main.h ScanKeys.h Stage.h Vram.h Sprite.h \
	Fort.h Stage.h Fighter.h Barrier.h Stage.h Star.h \
	Enemy.h FighterBullet.h EnemyBullet.h Enemy.h Status.h Bang.h \
	Item.h Sound.h 
Mover.asm: Mover.c Mover.h 
Stage.asm: Stage.c Stage.h Stages.h Vram.h Fighter.h Fort.h \
	Stage.h Barrier.h Stage.h Enemy.h FighterBullet.h Bang.h \
	Sprite.h EnemyBullet.h Enemy.h Item.h 
Stages.asm: Stages.c Stage.h Stages.h 
Star.asm: Star.c Star.h Fighter.h Vram.h Chars.h 
Status.asm: Status.c Status.h Vram.h Stage.h Main.h Chars.h \
	Print.h Sprite.h 
Vram.asm: Vram.c Vram.h Chars.h Star.h Fort.h Stage.h \
	Barrier.h Stage.h Sprite.h 
Chars.obj: Chars.asm 
Print.obj: Print.asm 
ScanKeys.obj: ScanKeys.asm MegaDuck.inc 
Sound.obj: Sound.asm MegaDuck.inc 
Sprite.obj: Sprite.asm MegaDuck.inc Vram.inc 
Startup.obj: Startup.asm MegaDuck.inc Vram.inc 
VramA.obj: VramA.asm MegaDuck.inc Vram.inc Chars.inc 

objects = startup.obj \
	Bang.obj Barrier.obj Direction.obj Enemy.obj EnemyBullet.obj Fighter.obj \
	FighterBullet.obj Fort.obj Item.obj Main.obj Mover.obj Stage.obj \
	Stages.obj Star.obj Status.obj Vram.obj Chars.obj Print.obj \
	ScanKeys.obj Sound.obj Sprite.obj VramA.obj \
	..\..\cate\cate83.lib

$(name).bin: $(objects) makefile
	LinkLE.exe $(name).bin $(cseg) $(dseg) $(objects)
