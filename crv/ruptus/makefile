name=ruptus

all: $(name).rom

cseg=bfe8-bfff,8000-bfe7,4000
dseg=0200-03ff,0040
zseg=0000

.c.asm:
	Cate65.exe -v2 $*.c

.asm.obj:
	Asm65.exe -v2 $*.asm

Bang.asm: Bang.c Bang.h Sprite.h VVram.h Stage.h Chars.h 
Barrier.asm: Barrier.c Barrier.h Stage.h Stages.h VVram.h Chars.h \
	Sprite.h Bang.h Main.h Mover.h Sound.h Vram.h 
Direction.asm: Direction.c Direction.h 
Enemy.asm: Enemy.c Enemy.h Stage.h Fighter.h VVram.h Sprite.h \
	Chars.h Direction.h Main.h Bang.h Barrier.h Stage.h \
	Fort.h Stage.h Mover.h Item.h Sound.h 
EnemyBullet.asm: EnemyBullet.c EnemyBullet.h Enemy.h Sprite.h Enemy.h Stage.h \
	VVram.h Chars.h Direction.h Fighter.h Barrier.h Stage.h \
	Fort.h Stage.h 
Fighter.asm: Fighter.c Fighter.h Stage.h Sprite.h VVram.h Chars.h \
	Direction.h ScanKeys.h FighterBullet.h Bang.h Barrier.h Stage.h \
	Fort.h Stage.h Mover.h Item.h Main.h Status.h \
	Sound.h 
FighterBullet.asm: FighterBullet.c FighterBullet.h Sprite.h Fighter.h Stage.h VVram.h \
	Chars.h Direction.h Enemy.h Main.h Barrier.h Stage.h \
	Fort.h Stage.h Sound.h 
Fort.asm: Fort.c Fort.h Stage.h Stages.h VVram.h Chars.h \
	Bang.h Main.h Mover.h Status.h Sound.h 
Item.asm: Item.c Item.h Stage.h VVram.h Sprite.h Chars.h \
	Mover.h 
Main.asm: Main.c Main.h ScanKeys.h Stage.h Vram.h Sprite.h \
	VVram.h Fort.h Stage.h Fighter.h Barrier.h Stage.h \
	Star.h Enemy.h FighterBullet.h EnemyBullet.h Enemy.h Status.h \
	Bang.h Item.h Sound.h 
Mover.asm: Mover.c Mover.h 
Stage.asm: Stage.c Stage.h Stages.h VVram.h Fighter.h Fort.h \
	Stage.h Barrier.h Stage.h Enemy.h FighterBullet.h Bang.h \
	Sprite.h EnemyBullet.h Enemy.h Item.h 
Stages.asm: Stages.c Stage.h Stages.h 
Star.asm: Star.c Star.h Fighter.h VVram.h Chars.h 
Status.asm: Status.c Status.h Vram.h Stage.h Main.h Chars.h \
	Print.h Sprite.h 
Vram.asm: Vram.c Vram.h Chars.h 
VVram.asm: VVram.c VVram.h Vram.h 
Chars.obj: Chars.asm 
Print.obj: Print.asm 
RomTail.obj: RomTail.asm Vram.inc 
ScanKeys.obj: ScanKeys.asm ZeroPage.inc Port.inc 
Sound.obj: Sound.asm ZeroPage.inc Port.inc 
Sprite.obj: Sprite.asm ZeroPage.inc Port.inc Vram.inc Chars.inc 
Startup.obj: Startup.asm Port.inc Vram.inc 
VramA.obj: VramA.asm ZeroPage.inc Port.inc Vram.inc Chars.inc 
VVramA.obj: VVramA.asm ZeroPage.inc Port.inc Vram.inc Chars.inc 
ZeroPage.obj: ZeroPage.asm 

objects = RomTail.obj Startup.obj \
	Bang.obj Barrier.obj Direction.obj Enemy.obj EnemyBullet.obj Fighter.obj \
	FighterBullet.obj Fort.obj Item.obj Main.obj Mover.obj Stage.obj \
	Stages.obj Star.obj Status.obj Vram.obj VVram.obj Chars.obj \
	Print.obj RomTail.obj ScanKeys.obj Sound.obj Sprite.obj VramA.obj \
	VVramA.obj ZeroPage.obj \
	..\..\cate\cate65.lib

$(name).rom: $(objects) makefile
	LinkLE.exe $(name).rom $(cseg) $(dseg) $(zseg) $(objects)