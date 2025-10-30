name=impetusp

all: $(name).cmt $(name).d88

cseg=0100
dseg=4000-7fff,c000

.c.asm:
	Cate80.exe $*.c

.asm.obj:
	Asm80.exe -v2 $*.asm

Bang.asm: Bang.c Bang.h Movable.h VVram.h Sprite.h Movable.h \
	Stage.h Chars.h 
Barrier.asm: Barrier.c Barrier.h Sprite.h Movable.h Vram.h Math.h \
	Main.h Chars.h Bang.h Movable.h Main.h Fighter.h \
	Movable.h Sound.h 
Enemy.asm: Enemy.c Enemy.h Movable.h 
EnemyBullet.asm: EnemyBullet.c EnemyBullet.h Movable.h Sprite.h Movable.h Chars.h \
	VVram.h Math.h Fighter.h Movable.h 
Fighter.asm: Fighter.c Fighter.h Movable.h VVram.h Sprite.h Movable.h \
	Chars.h Main.h Status.h ScanKeys.h FighterBullet.h Movable.h \
	Bang.h Movable.h Barrier.h Sound.h 
FighterBullet.asm: FighterBullet.c FighterBullet.h Movable.h Sprite.h Movable.h Chars.h \
	Fighter.h Movable.h Sound.h Vram.h SkyEnemy.h Enemy.h \
	Movable.h GroundEnemy.h Stage.h Enemy.h Movable.h Barrier.h \
	Fort.h 
Fort.asm: Fort.c Fort.h Vram.h Main.h Chars.h Stage.h \
	Movable.h Bang.h Movable.h EnemyBullet.h Movable.h Math.h \
	Sound.h 
GroundEnemy.asm: GroundEnemy.c GroundEnemy.h Stage.h Enemy.h Movable.h Sprite.h \
	Movable.h VVram.h Chars.h Stage.h Math.h Main.h \
	Bang.h Movable.h Sound.h EnemyBullet.h Movable.h 
Item.asm: Item.c Item.h Movable.h Vram.h Sprite.h Movable.h \
	Chars.h Fighter.h Movable.h Status.h Main.h Sound.h 
Main.asm: Main.c Main.h Status.h ScanKeys.h Vram.h Stage.h \
	Sound.h Sprite.h Movable.h Fighter.h Movable.h SkyEnemy.h \
	Enemy.h Movable.h GroundEnemy.h Stage.h Enemy.h Movable.h \
	FighterBullet.h Movable.h EnemyBullet.h Movable.h Bang.h Movable.h \
	Barrier.h Fort.h Item.h Movable.h 
SkyEnemy.asm: SkyEnemy.c SkyEnemy.h Enemy.h Movable.h Sprite.h Movable.h \
	Chars.h Main.h Math.h Stage.h VVram.h Fighter.h \
	Movable.h Bang.h Movable.h Sound.h EnemyBullet.h Movable.h \
	Barrier.h Item.h Movable.h 
Sprite.asm: Sprite.c Movable.h Sprite.h Movable.h Vram.h VVram.h \
	Chars.h 
Stage.asm: Stage.c Stage.h Main.h Vram.h Math.h CopyMemory.h \
	Movable.h Status.h Sprite.h Movable.h Fighter.h Movable.h \
	SkyEnemy.h Enemy.h Movable.h GroundEnemy.h Stage.h Enemy.h \
	Movable.h FighterBullet.h Movable.h EnemyBullet.h Movable.h Barrier.h \
	Bang.h Movable.h Fort.h Item.h Movable.h 
Stages.asm: Stages.c Stage.h Chars.h 
Status.asm: Status.c Status.h Vram.h Stage.h Main.h Sprite.h \
	Movable.h Print.h Chars.h 
Vram.asm: Vram.c Vram.h Sprite.h Movable.h Stage.h Fort.h 
VVram.asm: VVram.c VVram.h 
Chars.obj: Chars.asm 
CopyBank.obj: CopyBank.asm BinSize.inc 
CopyMemory.obj: CopyMemory.asm 
FortA.obj: FortA.asm VVram.inc Chars.inc 
Loader1.obj: Loader1.asm LoaderCode.inc 
Loader2.obj: Loader2.asm BinSize.inc 
LoaderCode.obj: LoaderCode.asm 
Math.obj: Math.asm 
Print.obj: Print.asm 
ScanKeys.obj: ScanKeys.asm 
Sound.obj: Sound.asm 
SpritePattern.obj: SpritePattern.asm 
StageA.obj: StageA.asm VVram.inc Chars.inc 
Startup.obj: Startup.asm 
VramA.obj: VramA.asm Vram.inc VVram.inc Chars.inc 

objects = Startup.obj \
	Bang.obj Barrier.obj Enemy.obj EnemyBullet.obj Fighter.obj FighterBullet.obj \
	Fort.obj GroundEnemy.obj Item.obj Main.obj SkyEnemy.obj Sprite.obj \
	Stage.obj Stages.obj Status.obj Vram.obj VVram.obj Chars.obj \
	CopyMemory.obj FortA.obj Math.obj Print.obj ScanKeys.obj Sound.obj \
	SpritePattern.obj StageA.obj VramA.obj \
	..\..\cate\cate80.lib

$(name).bin: $(objects) makefile
	LinkLE.exe $(name).bin $(cseg) $(dseg) $(objects)

BinSize.inc: $(name).bin BinSize.csx
	dotnet script BinSize.csx $(name) $(cseg)

CopyBank.bin: CopyBank.obj makefile
	LinkLE.exe CopyBank.bin 8100 8000 CopyBank.obj

~$(name).bin: CopyBank.bin $(name).bin
	copy /b /y CopyBank.bin+$(name).bin ~$(name).bin

Loader2.bin: Loader2.obj makefile
	LinkLE.exe Loader2.bin E000 E200 Loader2.obj

LoaderCode.asm LoaderCode.inc: Loader2.bin BinAsm.csx
	dotnet script BinAsm.csx

Loader1.bin: Loader1.obj LoaderCode.obj makefile
	LinkLE.exe Loader1.bin C000 C200 Loader1.obj LoaderCode.obj

$(name).d88: ~$(name).bin Loader1.bin
	dotnet script disk.csx $(name)

$(name).cmt: ~$(name).bin cmt.csx
	dotnet script cmt.csx $(name)
