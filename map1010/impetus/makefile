name=impetus

all: $(name).wav loader.txt

cseg=8800
dseg=be00
loader=8000

.c.asm:
	Cate80.exe $*.c

.asm.obj:
	Asm80.exe $*.asm

Main.asm: Main.c Main.h Init.h Stage.h ScanKeys.h VVram.h Sprite.h \
	Fighter.h FighterBullet.h SkyEnemy.h EnemyBullet.h Status.h Bang.h Barrier.h \
	GroundEnemy.h Fort.h Sound.h Item.h Vram.h
Stages.asm: Stages.c Stage.h Stages.h Chars.h
Stage.asm: Stage.c Stage.h Main.h Vram.h Chars.h CopyMemory.h VVram.h \
	Fighter.h FighterBullet.h SkyEnemy.h EnemyBullet.h Bang.h Math.h Status.h \
	Barrier.h GroundEnemy.h Fort.h Sprite.h Item.h
Fighter.asm: Fighter.c Fighter.h VVram.h Sprite.h ScanKeys.h FighterBullet.h Bang.h \
	Barrier.h Sound.h Status.h Main.h Chars.h
FighterBullet.asm: FighterBullet.c FighterBullet.h VVram.h Sprite.h Fighter.h \
	Vram.h SkyEnemy.h GroundEnemy.h Barrier.h Fort.h Sound.h Chars.h
SkyEnemy.asm: SkyEnemy.c SkyEnemy.h VVram.h Sprite.h Stage.h Math.h Main.h Fighter.h \
	EnemyBullet.h Bang.h Main.h Barrier.h Sound.h Item.h Chars.h
Barrier.asm: Barrier.c Barrier.h Sprite.h Math.h Main.h VVram.h Chars.h \
	VVram.h Bang.h Fighter.h Sound.h
GroundEnemy.h: Stage.h
GroundEnemy.asm: GroundEnemy.c SkyEnemy.h VVram.h Sprite.h Stage.h Math.h Main.h \
	EnemyBullet.h Bang.h Main.h Fighter.h Sound.h Chars.h
Fort.asm: Fort.c Fort.h Sprite.h Chars.h VVram.h Stage.h Bang.h Main.h \
	EnemyBullet.h Math.h Sound.h
EnemyBullet.asm: EnemyBullet.c EnemyBullet.h VVram.h Sprite.h Math.h Fighter.h \
	Chars.h
Bang.asm: Bang.c Bang.h Sprite.h VVram.h Chars.h
Item.asm: Item.c Item.h Sprite.h Vram.h Fighter.h Status.h Main.h Sound.h VVram.h Chars.h

Status.asm: Status.c Status.h Vram.h Sprite.h Main.h Sprite.h VVram.h \
	Chars.h Print.h CopyMemory.h

VVram.asm: VVram.c VVram.h Vram.h Barrier.h Fort.h 

Math.asm: Math.c Math.h
Vram.asm: Vram.c Vram.h
VramA.obj: VramA.asm Vram.inc VVram.inc
Sprite.asm: Sprite.c Sprite.h Vram.h VVram.h Stage.h


objects = \
	Main.obj Stages.obj Stage.obj Fighter.obj FighterBullet.obj SkyEnemy.obj \
	Barrier.obj GroundEnemy.obj Fort.obj EnemyBullet.obj Bang.obj Item.obj \
	Status.obj VVram.obj VVramA.obj  PrintA.obj \
	Init.obj ScanKeys.obj Sound.obj Vram.obj VramA.obj Sprite.obj Chars.obj \
	Math.obj CopyMemory.obj \
	..\..\cate\cate80.lib

$(name).cmt: $(objects) makefile
	LinkLE.exe $(name).cmt $(cseg) $(dseg) $(objects)

$(name).wav: $(name).cmt CmtWav.csx 
	dotnet script CmtWav.csx $(name)

loader.obj: loader.asm

loader.bin: loader.obj makefile
	linkLE loader.bin $(loader) $(dseg) loader.obj

loader.txt: loader.bin loader.csx
	dotnet script loader.csx $(loader)
