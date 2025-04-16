name=ruptus

all: $(name).rom debug.bin

cseg=9000
dseg=b900

.c.asm:
	Cate80.exe $*.c

.asm.obj:
	Asm80.exe $*.asm

Bang.asm: Bang.c Bang.h Sprite.h VVram.h Stage.h Chars.h 
Barrier.asm: Barrier.c Barrier.h Stage.h Stages.h VVram.h Chars.h \
	Sprite.h Bang.h Main.h Mover.h Vram.h 
Direction.asm: Direction.c Direction.h 
Enemy.asm: Enemy.c Enemy.h Stage.h Fighter.h VVram.h Sprite.h \
	Chars.h Direction.h Main.h Bang.h Barrier.h Stage.h \
	Fort.h Stage.h Mover.h Item.h Vram.h 
EnemyBullet.asm: EnemyBullet.c EnemyBullet.h Enemy.h Sprite.h Enemy.h Stage.h \
	VVram.h Chars.h Direction.h Fighter.h Barrier.h Stage.h \
	Fort.h Stage.h Main.h 
Fighter.asm: Fighter.c Fighter.h Stage.h Sprite.h VVram.h Chars.h \
	Direction.h ScanKeys.h FighterBullet.h Bang.h Barrier.h Stage.h \
	Fort.h Stage.h Mover.h Item.h Main.h Status.h \
	Vram.h 
FighterBullet.asm: FighterBullet.c FighterBullet.h Sprite.h Fighter.h Stage.h VVram.h \
	Chars.h Direction.h Enemy.h Main.h Barrier.h Stage.h \
	Fort.h Stage.h 
Fort.asm: Fort.c Fort.h Stage.h Stages.h VVram.h Chars.h \
	Bang.h Main.h Mover.h Status.h Vram.h Fighter.h \
	Sprite.h Rader.h 
Item.asm: Item.c Item.h Stage.h VVram.h Sprite.h Chars.h \
	Mover.h 
Main.asm: Main.c Main.h ScanKeys.h Stage.h Vram.h Sprite.h \
	VVram.h Fort.h Stage.h Fighter.h Barrier.h Stage.h \
	Star.h Enemy.h FighterBullet.h EnemyBullet.h Enemy.h Status.h \
	Bang.h Item.h 
Mover.asm: Mover.c Mover.h 
Sprite.asm: Sprite.c Sprite.h VVram.h Chars.h Vram.h 
Stage.asm: Stage.c Stage.h Stages.h VVram.h Fighter.h Fort.h \
	Stage.h Barrier.h Stage.h Enemy.h FighterBullet.h Bang.h \
	Sprite.h EnemyBullet.h Enemy.h Item.h Main.h 
Stages.asm: Stages.c Stage.h Stages.h 
Star.asm: Star.c Star.h Fighter.h VVram.h Chars.h 
Status.asm: Status.c Status.h Vram.h Stage.h Sprite.h Print.h \
	Chars.h Main.h Rader.h 
Vram.asm: Vram.c Vram.h Chars.h 
VVram.asm: VVram.c VVram.h Chars.h 
Chars.obj: Chars.asm 
Loader.obj: Loader.asm BinSize.inc
Print.obj: Print.asm 
RaderA.obj: RaderA.asm Vram.inc 
ScanKeys.obj: ScanKeys.asm 
Startup.obj: Startup.asm Vram.inc 
VramA.obj: VramA.asm Vram.inc VVram.inc 
VVramA.obj: VVramA.asm Vram.inc VVram.inc 

objects = Startup.obj \
	Bang.obj Barrier.obj Direction.obj Enemy.obj EnemyBullet.obj Fighter.obj \
	FighterBullet.obj Fort.obj Item.obj Main.obj Mover.obj Sprite.obj \
	Stage.obj Stages.obj Star.obj Status.obj Vram.obj VVram.obj \
	Chars.obj Print.obj RaderA.obj ScanKeys.obj VramA.obj VVramA.obj \
	..\..\cate\cate80.lib

$(name).bin: $(objects) makefile
	LinkLE.exe $(name).bin $(cseg) $(dseg) $(objects)

BinSize.inc: $(name).bin BinSize.csx
	dotnet script BinSize.csx $(name) $(cseg)

Loader.bin: Loader.obj makefile
	LinkLE.exe Loader.bin 4000 $(dseg) Loader.obj

$(name).rom: $(name).bin Loader.bin MakeRom.csx
	dotnet script MakeRom.csx $(name)

debug.bin: $(name).bin
	copy $(name).bin debug.bin /y
