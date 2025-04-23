name=ruptus

all: $(name).wav

cseg=4000
dseg=9000

.c.asm:
	Cate80.exe $*.c

.asm.obj:
	Asm80.exe $*.asm

Bang.asm: Bang.c Bang.h Sprite.h Window.h Stage.h Chars.h 
Barrier.asm: Barrier.c Barrier.h Stage.h Stages.h Window.h Chars.h \
	Sprite.h Bang.h Main.h Mover.h Sound.h Vram.h 
Direction.asm: Direction.c Direction.h 
Enemy.asm: Enemy.c Enemy.h Stage.h Fighter.h Window.h Sprite.h \
	Chars.h Direction.h Main.h Bang.h Barrier.h Stage.h \
	Fort.h Stage.h Mover.h Item.h Sound.h Vram.h 
EnemyBullet.asm: EnemyBullet.c EnemyBullet.h Enemy.h Sprite.h Enemy.h Stage.h \
	Window.h Chars.h Direction.h Fighter.h Barrier.h Stage.h \
	Fort.h Stage.h Main.h 
Fighter.asm: Fighter.c Fighter.h Stage.h Sprite.h Window.h Chars.h \
	Direction.h ScanKeys.h FighterBullet.h Bang.h Barrier.h Stage.h \
	Fort.h Stage.h Mover.h Item.h Main.h Status.h \
	Sound.h Vram.h 
FighterBullet.asm: FighterBullet.c FighterBullet.h Sprite.h Fighter.h Stage.h Window.h \
	Chars.h Direction.h Enemy.h Main.h Barrier.h Stage.h \
	Fort.h Stage.h Sound.h 
Fort.asm: Fort.c Fort.h Stage.h Stages.h Window.h Chars.h \
	Bang.h Main.h Mover.h Status.h Sound.h Vram.h \
	Fighter.h Sprite.h Rader.h 
Item.asm: Item.c Item.h Stage.h Window.h Sprite.h Chars.h \
	Mover.h 
Main.asm: Main.c Main.h ScanKeys.h Stage.h Vram.h Sprite.h \
	Window.h Fort.h Stage.h Fighter.h Barrier.h Stage.h \
	Star.h Enemy.h FighterBullet.h EnemyBullet.h Enemy.h Status.h \
	Bang.h Item.h Sound.h 
Mover.asm: Mover.c Mover.h 
Rader.asm: Rader.c Rader.h Vram.h Fighter.h Chars.h 
Sprite.asm: Sprite.c Sprite.h Window.h Chars.h Vram.h 
Stage.asm: Stage.c Stage.h Stages.h Window.h Fighter.h Fort.h \
	Stage.h Barrier.h Stage.h Enemy.h FighterBullet.h Bang.h \
	Sprite.h EnemyBullet.h Enemy.h Item.h 
Stages.asm: Stages.c Stage.h Stages.h 
Star.asm: Star.c Star.h Fighter.h Window.h Chars.h 
Status.asm: Status.c Status.h Vram.h Stage.h Main.h Chars.h \
	Print.h Window.h Rader.h 
Vram.asm: Vram.c Vram.h Chars.h 
Window.asm: Window.c Window.h Chars.h 
Chars.obj: Chars.asm 
Init.obj: Init.asm 
Print.obj: Print.asm 
ScanKeys.obj: ScanKeys.asm 
Sound.obj: Sound.asm 
VramA.obj: VramA.asm 
WindowA.obj: WindowA.asm 

objects = Main.obj \
	Bang.obj Barrier.obj Direction.obj Enemy.obj EnemyBullet.obj Fighter.obj \
	FighterBullet.obj Fort.obj Item.obj Mover.obj Rader.obj Sprite.obj \
	Stage.obj Stages.obj Star.obj Status.obj Vram.obj Window.obj \
	Chars.obj Init.obj Print.obj ScanKeys.obj Sound.obj VramA.obj \
	WindowA.obj \
	..\..\cate\cate80.lib

$(name).bin: $(objects)
	LinkLE.exe $(name).bin $(cseg) $(dseg) $(objects)

$(name).cdt: $(name).bin
	2cdt.exe -n -r $(name) loader.bas $(name).cdt
	2cdt.exe -r BIN $(name).bin $(name).cdt

$(name).wav: $(name).cdt
	TZX2WAV $(name).cdt $(name).wav
