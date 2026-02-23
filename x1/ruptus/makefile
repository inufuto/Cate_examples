name=ruptus

all: $(name).tap $(name).d88

cseg=8100
dseg=c400 

.c.asm:
	Cate80.exe $*.c

.asm.obj:
	Asm80.exe $*.asm

Main.asm: Main.c Main.h ScanKeys.h Stage.h Vram.h Fighter.h Fort.h Star.h Barrier.h \
	Window.h Enemy.h FighterBullet.h EnemyBullet.h Bang.h Item.h \
	Status.h Sprite.h Sound.h Rader.h 
Stages.asm: Stages.c Stages.h
Stage.asm: Stage.c Stage.h Stages.h Window.h Fighter.h Fort.h Barrier.h Enemy.h \
	FighterBullet.h Bang.h Sprite.h EnemyBullet.h Item.h
Window.asm: Window.h
Direction.asm: Direction.c Direction.h
Star.asm: Star.c Star.h Window.h Chars.h
Mover.asm: Mover.c Mover.h
Fighter.asm: Fighter.c Fighter.h Stage.h Sprite.h Window.h Chars.h Direction.h \
	ScanKeys.h FighterBullet.h Bang.h Barrier.h Fort.h Mover.h Item.h Main.h Status.h \
	Sound.h Rader.h
Fort.asm: Fort.c Fort.h Stages.h Window.h Chars.h Bang.h Main.h Mover.h Status.h Sound.h \
	Rader.h
Fort.h: Stage.h
Barrier.asm: Barrier.c Barrier.h Stage.h Window.h Chars.h Sprite.h Bang.h Main.h Sound.h
Barrier.h: Stage.h
Enemy.asm: Enemy.c Enemy.h Stage.h Window.h Sprite.h Chars.h Direction.h Main.h \
	Bang.h Barrier.h Fort.h Mover.h Item.h Sound.h
FighterBullet.asm: FighterBullet.c FighterBullet.h Sprite.h Fighter.h Stage.h Window.h \
	Chars.h Direction.h Enemy.h Main.h Barrier.h Fort.h Sound.h
EnemyBullet.asm: EnemyBullet.c EnemyBullet.h Sprite.h Stage.h Window.h \
	Chars.h Direction.h Fighter.h Barrier.h Fort.h
EnemyBullet.h:  Enemy.h
Bang.asm: Bang.c Bang.h Sprite.h Window.h Stage.h Chars.h
Item.asm: Item.c Item.h Chars.h

Status.asm: Status.c Status.h Stage.h Chars.h  Vram.h Print.h Main.h Window.h Rader.h
Rader.asm: Rader.c Rader.h Vram.h Fighter.h Chars.h
ScanKeys.obj: ScanKeys.asm
VramA.obj: VramA.asm Vram.inc
Vram.asm: Vram.c Vram.h Chars.h
Sprite.asm: Sprite.c Sprite.h Window.h Chars.h Vram.h
Sound.obj: Sound.asm
Init.obj: Init.asm Vram.inc

objects= \
	Main.obj Init.obj ScanKeys.obj VramA.obj Vram.obj Window.obj WindowA.obj \
	Sprite.obj Chars.obj Status.obj Print.obj Sound.obj \
	Stages.obj Stage.obj Direction.obj Mover.obj Fighter.obj Fort.obj Barrier.obj \
	Enemy.obj Star.obj FighterBullet.obj EnemyBullet.obj Bang.obj Item.obj Rader.obj \
	..\..\cate\cate80.lib


$(name).bin: $(objects)
	LinkLE.exe $(name).bin $(cseg) $(dseg) $(objects)

$(name).wav: $(name).bin
	..\x1tape\x1tape -file2wav -filemode ipl -start 8100 -entry 8100 $(name).bin $(name).wav

$(name).tap: $(name).wav
	..\x1tape\x1tape -wav2tap $(name).wav $(name).tap

$(name).d88: $(name).bin Disk.csx
	dotnet script Disk.csx $(name) $(cseg)
