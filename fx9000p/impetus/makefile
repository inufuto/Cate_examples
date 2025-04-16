name=impetus

all: $(name).rom debug.bin

cseg=9000
dseg=ba00

.c.asm:
	Cate80.exe $*.c

.asm.obj:
	Asm80.exe $*.asm

Bang.asm: Bang.c Bang.h Sprite.h VVram.h Chars.h 
Barrier.asm: Barrier.c Barrier.h Sprite.h Math.h Main.h VVram.h \
	Chars.h VVram.h Bang.h Fighter.h 
EnemyBullet.asm: EnemyBullet.c EnemyBullet.h Sprite.h VVram.h Fighter.h Math.h \
	Chars.h 
Fighter.asm: Fighter.c Fighter.h VVram.h Sprite.h ScanKeys.h FighterBullet.h \
	Bang.h Barrier.h Status.h Main.h Chars.h 
FighterBullet.asm: FighterBullet.c FighterBullet.h VVram.h Sprite.h Fighter.h Vram.h \
	SkyEnemy.h GroundEnemy.h Stage.h Barrier.h Fort.h Chars.h 
Fort.asm: Fort.c Fort.h Sprite.h Chars.h VVram.h Stage.h \
	Bang.h Main.h EnemyBullet.h Math.h 
GroundEnemy.asm: GroundEnemy.c Stage.h GroundEnemy.h Stage.h Sprite.h VVram.h \
	Math.h Main.h EnemyBullet.h Bang.h Main.h Chars.h 
Item.asm: Item.c Item.h Sprite.h Vram.h Fighter.h Status.h \
	Main.h VVram.h Chars.h 
Main.asm: Main.c Main.h Stage.h ScanKeys.h VVram.h Sprite.h \
	Fighter.h FighterBullet.h SkyEnemy.h EnemyBullet.h Status.h Bang.h \
	Barrier.h GroundEnemy.h Stage.h Fort.h Item.h Vram.h 
Math.asm: Math.c Math.h 
SkyEnemy.asm: SkyEnemy.c SkyEnemy.h Sprite.h VVram.h Math.h Main.h \
	Fighter.h EnemyBullet.h Stage.h Bang.h Main.h Barrier.h \
	Item.h Chars.h 
Sprite.asm: Sprite.c Sprite.h Chars.h VVram.h Vram.h 
Stage.asm: Stage.c Stage.h Stages.h Main.h Vram.h Chars.h \
	CopyMemory.h VVram.h Fighter.h FighterBullet.h SkyEnemy.h EnemyBullet.h \
	Bang.h Math.h Status.h Barrier.h GroundEnemy.h Stage.h \
	Fort.h Sprite.h Item.h 
Stages.asm: Stages.c Stage.h Stages.h Chars.h 
Status.asm: Status.c Status.h Vram.h Main.h Sprite.h Print.h \
	Chars.h 
Vram.asm: Vram.c Vram.h Chars.h 
VVram.asm: VVram.c VVram.h Chars.h Sprite.h Vram.h Fort.h \
	Barrier.h Stage.h 
Chars.obj: Chars.asm 
CopyMemory.obj: CopyMemory.asm 
Loader.obj: Loader.asm BinSize.inc
Print.obj: Print.asm 
ScanKeys.obj: ScanKeys.asm 
Startup.obj: Startup.asm Vram.inc 
VramA.obj: VramA.asm Vram.inc VVram.inc 
VVramA.obj: VVramA.asm Vram.inc VVram.inc 

objects = Startup.obj \
	Bang.obj Barrier.obj EnemyBullet.obj Fighter.obj FighterBullet.obj Fort.obj \
	GroundEnemy.obj Item.obj Main.obj Math.obj SkyEnemy.obj Sprite.obj \
	Stage.obj Stages.obj Status.obj Vram.obj VVram.obj Chars.obj \
	CopyMemory.obj Print.obj ScanKeys.obj VramA.obj VVramA.obj \
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
