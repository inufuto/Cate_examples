name=ruptus

all: $(name).l3

cseg=4000
zseg=7900 
dseg=7a00

.c.asm:
	Cate09.exe $*.c

.asm.obj:
	Asm09.exe -v2 $*.asm

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
	Sound.h Rader.h 
FighterBullet.asm: FighterBullet.c FighterBullet.h Sprite.h Fighter.h Stage.h Vram.h \
	Chars.h Direction.h Enemy.h Main.h Barrier.h Stage.h \
	Fort.h Stage.h Sound.h 
Fort.asm: Fort.c Fort.h Stage.h Stages.h Vram.h Chars.h \
	Bang.h Main.h Mover.h Status.h Sound.h Rader.h 
Item.asm: Item.c Item.h Stage.h Vram.h Sprite.h Chars.h \
	Mover.h 
Main.asm: Main.c Main.h ScanKeys.h Stage.h Vram.h Sprite.h \
	Vram.h Fort.h Stage.h Fighter.h Barrier.h Stage.h \
	Star.h Enemy.h FighterBullet.h EnemyBullet.h Enemy.h Status.h \
	Bang.h Item.h Sound.h Rader.h 
Mover.asm: Mover.c Mover.h 
Rader.asm: Rader.c Rader.h Vram.h Fighter.h Chars.h 
Sprite.asm: Sprite.c Sprite.h Vram.h 
Stage.asm: Stage.c Stage.h Stages.h Vram.h Fighter.h Fort.h \
	Stage.h Barrier.h Stage.h Enemy.h FighterBullet.h Bang.h \
	Sprite.h EnemyBullet.h Enemy.h Item.h 
Stages.asm: Stages.c Stage.h Stages.h 
Star.asm: Star.c Star.h Fighter.h Vram.h Chars.h 
Status.asm: Status.c Status.h Vram.h Print.h Chars.h Sprite.h \
	Main.h Stage.h Rader.h 
Vram.asm: Vram.c Vram.h Chars.h Sprite.h CopyMemory.h Fort.h \
	Stage.h Sound.h 
Chars.obj: Chars.asm 
CopyMemory.obj: CopyMemory.asm 
Loader.obj: Loader.asm S1.inc BinSize.inc 
Print.obj: Print.asm 
ScanKeys.obj: ScanKeys.asm S1.inc 
Sound.obj: Sound.asm 
Startup.obj: Startup.asm S1.inc 
VramA.obj: VramA.asm S1.inc Vram.inc Chars.inc 

objects = Startup.obj \
	Bang.obj Barrier.obj Direction.obj Enemy.obj EnemyBullet.obj Fighter.obj \
	FighterBullet.obj Fort.obj Item.obj Main.obj Mover.obj Rader.obj \
	Sprite.obj Stage.obj Stages.obj Star.obj Status.obj Vram.obj \
	Chars.obj CopyMemory.obj Print.obj ScanKeys.obj Sound.obj VramA.obj \
	..\..\cate\cate09.lib

$(name).bin: $(objects) makefile
	LinkBE.exe $(name).bin $(cseg) $(dseg) $(zseg) $(objects)

BinSize.inc: $(name).bin BinSize.csx
	dotnet script BinSize.csx $(name)

$(name)_01.l3: Loader.obj makefile
	LinkBE.exe Loader.l3 d000 d200 d100 Loader.obj
	copy Loader.l3 $(name)_01.l3 /y

$(name)_02.l3: $(name).bin BinL3.csx
	dotnet script BinL3.csx $(name) $(cseg)

$(name).l3: $(name)_01.l3 $(name)_02.l3
	copy /b $(name)_01.l3+$(name)_02.l3 $(name).l3
