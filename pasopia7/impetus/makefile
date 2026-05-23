name=impetus

all: $(name).ram $(name).d88

cseg=9000
dseg=D400

.c.asm:
	Cate80.exe $*.c

.asm.obj:
	Asm80.exe $*.asm

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
	Print.h Chars.h 
Vram.asm: Vram.c Vram.h Chars.h 
VVram.asm: VVram.c VVram.h Chars.h Sprite.h Vram.h Fort.h \
	Barrier.h 
Chars.obj: Chars.asm 
CopyMemory.obj: CopyMemory.asm 
FixedCode.obj: FixedCode.asm 
Init.obj: Init.asm FixedCode.inc 
Loader.obj: Loader.asm BinSize.inc 
PrintA.obj: PrintA.asm 
ScanKeys.obj: ScanKeys.asm 
Sound.obj: Sound.asm 
VramA.obj: VramA.asm FixedCode.inc Vram.inc VVram.inc 
VramTrans.obj: VramTrans.asm 
VVramA.obj: VVramA.asm VVram.inc 

objects = \
	Main.obj Stages.obj Stage.obj Fighter.obj FighterBullet.obj SkyEnemy.obj \
	Barrier.obj GroundEnemy.obj Fort.obj EnemyBullet.obj Bang.obj Item.obj \
	Status.obj VVram.obj VVramA.obj  PrintA.obj \
	Init.obj ScanKeys.obj Sound.obj Vram.obj VramA.obj Sprite.obj Chars.obj \
	Math.obj CopyMemory.obj \
	FixedCode.obj \
	..\..\cate\cate80.lib

FixedCode.bin: VramTrans.obj makefile
	LinkLE.exe FixedCode.bin E000 F000 VramTrans.obj

FixedCode.asm FixedCode.inc: FixedCode.bin
	dotnet script BinAsm.csx

$(name).ram: $(objects)
	LinkLE.exe $(name).ram $(cseg) $(dseg) $(objects)


$(name).bin: $(objects) makefile
	LinkLE.exe $(name).bin $(cseg) $(dseg) $(objects)

BinSize.inc: $(name).bin BinSize.csx
	dotnet script BinSize.csx $(name) $(cseg)

Loader.bin: Loader.obj makefile
    LinkLE.exe Loader.bin f000 f100 Loader.obj

$(name).d88: $(name).bin Loader.bin makefile disk.csx
    dotnet script disk.csx $(name)
