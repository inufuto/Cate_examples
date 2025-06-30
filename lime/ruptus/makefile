name=ruptus

all: $(name).d88

cseg=4000
zseg=7600 
dseg=7700

.c.asm:
	Cate09.exe $*.c

.asm.obj:
	Asm09.exe $*.asm

Bang.asm: Bang.c Bang.h Sprite.h VVram.h Stage.h Chars.h 
Barrier.asm: Barrier.c Barrier.h Stage.h Stages.h VVram.h Chars.h \
	Sprite.h Bang.h Main.h Mover.h Sound.h Vram.h 
Direction.asm: Direction.c Direction.h 
Enemy.asm: Enemy.c Enemy.h Stage.h Fighter.h VVram.h Sprite.h \
	Chars.h Direction.h Main.h Bang.h Barrier.h Stage.h \
	Fort.h Stage.h Mover.h Item.h Sound.h Vram.h 
EnemyBullet.asm: EnemyBullet.c EnemyBullet.h Enemy.h Sprite.h Enemy.h Stage.h \
	VVram.h Chars.h Direction.h Fighter.h Barrier.h Stage.h \
	Fort.h Stage.h Main.h 
Fighter.asm: Fighter.c Fighter.h Stage.h Sprite.h VVram.h Chars.h \
	Direction.h ScanKeys.h FighterBullet.h Bang.h Barrier.h Stage.h \
	Fort.h Stage.h Mover.h Item.h Main.h Status.h \
	Sound.h Vram.h 
FighterBullet.asm: FighterBullet.c FighterBullet.h Sprite.h Fighter.h Stage.h VVram.h \
	Chars.h Direction.h Enemy.h Main.h Barrier.h Stage.h \
	Fort.h Stage.h Sound.h 
Fort.asm: Fort.c Fort.h Stage.h Stages.h VVram.h Chars.h \
	Bang.h Main.h Mover.h Status.h Sound.h Vram.h \
	Fighter.h Sprite.h Rader.h 
Item.asm: Item.c Item.h Stage.h VVram.h Sprite.h Chars.h \
	Mover.h 
Main.asm: Main.c Main.h ScanKeys.h Stage.h Vram.h Sprite.h \
	VVram.h Fort.h Stage.h Fighter.h Barrier.h Stage.h \
	Star.h Enemy.h FighterBullet.h EnemyBullet.h Enemy.h Status.h \
	Bang.h Item.h Sound.h 
Mover.asm: Mover.c Mover.h 
Rader.asm: Rader.c Rader.h Vram.h Fighter.h Chars.h VVram.h 
Sprite.asm: Sprite.c Sprite.h Vram.h VVram.h 
Stage.asm: Stage.c Stage.h Stages.h VVram.h Fighter.h Fort.h \
	Stage.h Barrier.h Stage.h Enemy.h FighterBullet.h Bang.h \
	Sprite.h EnemyBullet.h Enemy.h Item.h 
Stages.asm: Stages.c Stage.h Stages.h 
Star.asm: Star.c Star.h Fighter.h Vram.h VVram.h Chars.h 
Status.asm: Status.c Status.h Vram.h VVram.h Print.h Chars.h \
	Sprite.h VVram.h Main.h Stage.h Rader.h 
Vram.asm: Vram.c Vram.h Chars.h 
VVram.asm: VVram.c VVram.h Chars.h 
Chars.obj: Chars.asm 
Loader.obj: Loader.asm S1.inc BinSize.inc 
Print.obj: Print.asm 
RaderA.obj: RaderA.asm 
ScanKeys.obj: ScanKeys.asm S1.inc 
Sound.obj: Sound.asm 
Startup.obj: Startup.asm S1.inc 
VramA.obj: VramA.asm S1.inc Vram.inc VVram.inc Chars.inc 
VVramA.obj: VVramA.asm VVram.inc 

objects = Startup.obj \
	Bang.obj Barrier.obj Direction.obj Enemy.obj EnemyBullet.obj Fighter.obj \
	FighterBullet.obj Fort.obj Item.obj Main.obj Mover.obj Rader.obj \
	Sprite.obj Stage.obj Stages.obj Star.obj Status.obj Vram.obj \
	VVram.obj Chars.obj Print.obj RaderA.obj ScanKeys.obj Sound.obj \
	VramA.obj VVramA.obj \
	..\..\cate\cate09.lib

$(name).bin: $(objects) makefile
	LinkBE.exe $(name).bin $(cseg) $(dseg) $(zseg) $(objects)

BinSize.inc: $(name).bin BinSize.csx
	dotnet script BinSize.csx $(name) $(cseg)

Loader.bin: Loader.obj makefile BinSize.inc
	LinkBE.exe Loader.bin 2000 2300 2200 Loader.obj

$(name).d88: Loader.bin $(name).bin disk.csx
	dotnet script disk.csx $(name)
