name=ruptus

all: game.pkg

cseg=0000
dseg=C000

.c.asm:
	Cate80.exe $*.c

.asm.obj:
	Asm80.exe $*.asm

Bang.asm: Bang.c Bang.h Sprite.h VVram.h Stage.h Chars.h 
Barrier.asm: Barrier.c Barrier.h Stage.h Stages.h VVram.h Chars.h \
	Sprite.h Bang.h Main.h Mover.h Sound.h 
Direction.asm: Direction.c Direction.h 
Enemy.asm: Enemy.c Enemy.h Stage.h Fighter.h VVram.h Sprite.h \
	Chars.h Direction.h Main.h Bang.h Barrier.h Stage.h \
	Fort.h Stage.h Mover.h Item.h Sound.h 
EnemyBullet.asm: EnemyBullet.c EnemyBullet.h Enemy.h Sprite.h Enemy.h Stage.h \
	VVram.h Chars.h Direction.h Fighter.h Barrier.h Stage.h \
	Fort.h Stage.h 
Fighter.asm: Fighter.c Fighter.h Stage.h Sprite.h VVram.h Chars.h \
	Direction.h ScanKeys.h FighterBullet.h Bang.h Barrier.h Stage.h \
	Fort.h Stage.h Mover.h Item.h Main.h Status.h \
	Sound.h Rader.h 
FighterBullet.asm: FighterBullet.c FighterBullet.h Sprite.h Fighter.h Stage.h VVram.h \
	Chars.h Direction.h Enemy.h Main.h Barrier.h Stage.h \
	Fort.h Stage.h Sound.h 
Fort.asm: Fort.c Fort.h Stage.h Stages.h VVram.h Chars.h \
	Bang.h Main.h Mover.h Status.h Sound.h Rader.h 
Item.asm: Item.c Item.h Stage.h VVram.h Sprite.h Chars.h \
	Mover.h 
Main.asm: Main.c Main.h VVram.h ScanKeys.h Stage.h Vram.h \
	Sprite.h Fort.h Stage.h Fighter.h Barrier.h Stage.h \
	Star.h Enemy.h FighterBullet.h EnemyBullet.h Enemy.h Status.h \
	Bang.h Item.h Sound.h Rader.h 
Mover.asm: Mover.c Mover.h 
Rader.asm: Rader.c Rader.h Vram.h Fighter.h Chars.h VVram.h \
	Sprite.h 
Stage.asm: Stage.c Stage.h Stages.h VVram.h Fighter.h Fort.h \
	Stage.h Barrier.h Stage.h Enemy.h FighterBullet.h Bang.h \
	Sprite.h EnemyBullet.h Enemy.h Item.h 
Stages.asm: Stages.c Stage.h Stages.h 
Star.asm: Star.c Star.h Fighter.h VVram.h Chars.h 
Status.asm: Status.c Status.h Vram.h Stage.h Main.h Chars.h \
	Print.h Sprite.h Rader.h 
Vram.asm: Vram.c Vram.h Chars.h Sprite.h CopyMemory.h 
VVram.asm: VVram.c VVram.h Chars.h 
CopyMemory.obj: CopyMemory.asm 
Print.obj: Print.asm 
ScanKeys.obj: ScanKeys.asm vgszero.inc 
Sound.obj: Sound.asm vgszero.inc 
Sprite.obj: Sprite.asm vgszero.inc Vram.inc 
Startup.obj: Startup.asm vgszero.inc 
VramA.obj: VramA.asm vgszero.inc Vram.inc VVram.inc 
VVramA.obj: VVramA.asm vgszero.inc Vram.inc VVram.inc 

objects = Startup.obj \
	Bang.obj Barrier.obj Direction.obj Enemy.obj EnemyBullet.obj Fighter.obj \
	FighterBullet.obj Fort.obj Item.obj Main.obj Mover.obj Rader.obj \
	Stage.obj Stages.obj Star.obj Status.obj Vram.obj VVram.obj \
	CopyMemory.obj Print.obj ScanKeys.obj Sound.obj Sprite.obj VramA.obj \
	VVramA.obj \
	..\..\cate\cate80.lib

$(name).bin: $(objects) makefile
	LinkLE.exe $(name).bin $(cseg) $(dseg) $(objects)

patterns=tile.pattern.bin sprite.pattern.bin

$(name).rom: $(name).bin $(patterns)
	makerom $(name).rom $(name).bin $(patterns)

bgm.bgm: bgm.mml
	vgsmml bgm.mml bgm.bgm

start.bgm: start.mml
	vgsmml start.mml start.bgm

clear.bgm: clear.mml
	vgsmml clear.mml clear.bgm

over.bgm: over.mml
	vgsmml over.mml over.bgm

bgm_r.bgm: bgm.bgm Repeat.csx
	dotnet script Repeat.csx

bgms = bgm_r.bgm start.bgm clear.bgm over.bgm

bgm: $(bgms) makefile
	makebgm bgm $(bgms)

ses = fire.wav highBang.wav lowBang.wav up.wav

se: $(ses) makefile
	makese se $(ses)

game.pkg: $(name).rom bgm se
	makepkg -o game.pkg -r $(name).rom -b bgm -s se
