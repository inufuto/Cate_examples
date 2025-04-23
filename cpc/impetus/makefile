name=impetus

all: $(name).wav

cseg=4000
dseg=9000

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
	Print.h Chars.h VVram.h 
Vram.asm: Vram.c Vram.h Chars.h 
VVram.asm: VVram.c VVram.h Chars.h Sprite.h Vram.h Fort.h \
	Barrier.h 
Chars.obj: Chars.asm 
CopyMemory.obj: CopyMemory.asm 
Init.obj: Init.asm 
PrintA.obj: PrintA.asm 
ScanKeys.obj: ScanKeys.asm 
Sound.obj: Sound.asm 
VramA.obj: VramA.asm Vram.inc VVram.inc 
VVramA.obj: VVramA.asm VVram.inc 

objects = Main.obj \
	Bang.obj Barrier.obj EnemyBullet.obj Fighter.obj FighterBullet.obj Fort.obj \
	GroundEnemy.obj Item.obj Math.obj SkyEnemy.obj Sprite.obj Stage.obj \
	Stages.obj Status.obj Vram.obj VVram.obj Chars.obj CopyMemory.obj \
	Init.obj PrintA.obj ScanKeys.obj Sound.obj VramA.obj VVramA.obj \
	..\..\cate\cate80.lib

$(name).bin: $(objects)
	LinkLE.exe $(name).bin $(cseg) $(dseg) $(objects)

$(name).cdt: $(name).bin
	2cdt.exe -n -r $(name) loader.bas $(name).cdt
	2cdt.exe -r BIN $(name).bin $(name).cdt

$(name).wav: $(name).cdt
	TZX2WAV $(name).cdt $(name).wav
