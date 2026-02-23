name=impetus

all: $(name).tap $(name).d88

cseg=8100
dseg=D400 

.c.asm:
	Cate80.exe $*.c

.asm.obj:
	Asm80.exe -v2 $*.asm

Main.asm: Main.c Main.h Init.h Stage.h ScanKeys.h VVram.h Sprite.h \
	Fighter.h FighterBullet.h SkyEnemy.h EnemyBullet.h Status.h Bang.h Barrier.h \
	GroundEnemy.h Fort.h Sound.h Item.h
Stages.asm: Stages.c Stage.h Stages.h Chars.h
Stage.asm: Stage.c Stage.h Main.h Vram.h Chars.h CopyMemory.h VVram.h \
	Fighter.h FighterBullet.h SkyEnemy.h EnemyBullet.h Bang.h Math.h Status.h \
	Barrier.h GroundEnemy.h Fort.h Sprite.h Item.h
Fighter.asm: Fighter.c Fighter.h VVram.h Sprite.h ScanKeys.h FighterBullet.h Bang.h \
	Barrier.h Sound.h Status.h Main.h
FighterBullet.asm: FighterBullet.c FighterBullet.h Stage.h Sprite.h Fighter.h \
	Vram.h SkyEnemy.h GroundEnemy.h Barrier.h Fort.h Sound.h
SkyEnemy.asm: SkyEnemy.c SkyEnemy.h Stage.h Sprite.h VVram.h Math.h Main.h Fighter.h \
	EnemyBullet.h Bang.h Main.h Barrier.h Sound.h Item.h
Barrier.asm: Barrier.c Barrier.h Sprite.h Vram.h Math.h Main.h VVram.h Chars.h \
	Stage.h Bang.h Fighter.h Sound.h
GroundEnemy.asm: GroundEnemy.c SkyEnemy.h Stage.h Sprite.h VVram.h Math.h Main.h \
	EnemyBullet.h Bang.h Main.h Fighter.h Sound.h
Fort.asm: Fort.c Fort.h Sprite.h Vram.h Chars.h VVram.h Stage.h Bang.h Main.h \
	EnemyBullet.h Math.h Sound.h
EnemyBullet.asm: EnemyBullet.c EnemyBullet.h Stage.h Sprite.h VVram.h Math.h Fighter.h
Bang.asm: Bang.c Bang.h Sprite.h VVram.h Stage.h Chars.h
Item.asm: Item.c Item.h Sprite.h VVram.h Fighter.h Status.h Main.h Sound.h

Status.asm: Status.c Status.h Vram.h Sprite.h Main.h Sprite.h VVram.h \
	Chars.h Print.h CopyMemory.h

Math.asm: Math.c Math.h
Vram.asm: Vram.c Vram.h Chars.h
VVram.asm: VVram.c VVram.h Vram.h Barrier.h Stage.h Fort.h
VramA.obj: VramA.asm Vram.inc
VVramA.obj: VVramA.asm Vram.inc VVram.inc
Sprite.asm: Sprite.c Vram.h VVram.h Chars.h Init.h
SpriteA.obj: SpriteA.asm Vram.inc
Sound.obj: Sound.asm

objects = \
	Main.obj Stages.obj Stage.obj Fighter.obj FighterBullet.obj SkyEnemy.obj \
	Barrier.obj GroundEnemy.obj Fort.obj EnemyBullet.obj Bang.obj Item.obj \
	Status.obj VVram.obj VVramA.obj PrintA.obj \
	Init.obj ScanKeys.obj Sound.obj Vram.obj VramA.obj Sprite.obj SpriteA.obj Chars.obj \
	Math.obj CopyMemory.obj \
	..\..\cate\cate80.lib

$(name).bin: $(objects) makefile
	LinkLE.exe $(name).bin $(cseg) $(dseg) $(objects)

$(name).wav: $(name).bin
	x1tape -file2wav -filemode ipl -start 8100 -entry 8100 $(name).bin $(name).wav

$(name).tap: $(name).wav
	x1tape -wav2tap $(name).wav $(name).tap

$(name).d88: $(name).bin Disk.csx
	dotnet script Disk.csx $(name) $(cseg)
