name=impetus

all: game.pkg

cseg=0000
dseg=C000

.c.asm:
	Cate80.exe $*.c

.asm.obj:
	Asm80.exe $*.asm

Bang.asm: Bang.c Bang.h Sprite.h Vram.h Stage.h Chars.h \
	Vram.h 
Barrier.asm: Barrier.c Barrier.h Sprite.h Vram.h Vram.h Math.h \
	Main.h Chars.h Stage.h Bang.h Fighter.h Sound.h 
EnemyBullet.asm: EnemyBullet.c EnemyBullet.h Sprite.h Vram.h Stage.h Fighter.h \
	Math.h Chars.h Vram.h 
Fighter.asm: Fighter.c Fighter.h Sprite.h Vram.h ScanKeys.h FighterBullet.h \
	Bang.h Barrier.h Sound.h Status.h Main.h Chars.h \
	Vram.h 
FighterBullet.asm: FighterBullet.c FighterBullet.h Stage.h Sprite.h Vram.h Fighter.h \
	Vram.h SkyEnemy.h GroundEnemy.h Barrier.h Fort.h Sound.h \
	Chars.h 
Fort.asm: Fort.c Fort.h Sprite.h Vram.h Vram.h Chars.h \
	Stage.h Bang.h Main.h EnemyBullet.h Math.h Sound.h 
GroundEnemy.asm: GroundEnemy.c Stage.h GroundEnemy.h Sprite.h Vram.h Math.h \
	Main.h EnemyBullet.h Bang.h Main.h Sound.h Chars.h \
	Vram.h 
Item.asm: Item.c Item.h Sprite.h Vram.h Vram.h Fighter.h \
	Status.h Main.h Sound.h Chars.h 
Main.asm: Main.c Main.h Stage.h ScanKeys.h Sprite.h Vram.h \
	Fighter.h FighterBullet.h SkyEnemy.h EnemyBullet.h Status.h Bang.h \
	Barrier.h GroundEnemy.h Fort.h Sound.h Item.h Vram.h 
Math.asm: Math.c Math.h 
SkyEnemy.asm: SkyEnemy.c SkyEnemy.h Sprite.h Vram.h Math.h Main.h \
	Fighter.h EnemyBullet.h Stage.h Bang.h Main.h Barrier.h \
	Sound.h Item.h Chars.h Vram.h 
Sprite.asm: Sprite.c Sprite.h Vram.h 
Stage.asm: Stage.c Stage.h Stages.h Main.h Chars.h CopyMemory.h \
	Fighter.h FighterBullet.h SkyEnemy.h EnemyBullet.h Bang.h Math.h \
	Status.h Barrier.h GroundEnemy.h Fort.h Sprite.h Vram.h \
	Item.h 
Stages.asm: Stages.c Stage.h Stages.h Chars.h 
Status.asm: Status.c Status.h Vram.h Sprite.h Vram.h Print.h \
	Chars.h Main.h 
Vram.asm: Vram.c Vram.h Chars.h Sprite.h Vram.h Status.h \
	Stage.h Barrier.h 
CopyMemory.obj: CopyMemory.asm 
Print.obj: Print.asm 
ScanKeys.obj: ScanKeys.asm vgszero.inc 
Sound.obj: Sound.asm vgszero.inc 
SpriteA.obj: SpriteA.asm vgszero.inc Vram.inc Chars.inc 
Startup.obj: Startup.asm vgszero.inc 
VramA.obj: VramA.asm vgszero.inc Vram.inc 

objects = Startup.obj \
	Bang.obj Barrier.obj EnemyBullet.obj Fighter.obj FighterBullet.obj Fort.obj \
	GroundEnemy.obj Item.obj Main.obj Math.obj SkyEnemy.obj Sprite.obj \
	Stage.obj Stages.obj Status.obj Vram.obj CopyMemory.obj Print.obj \
	ScanKeys.obj Sound.obj SpriteA.obj VramA.obj \
	..\..\cate\cate80.lib

$(name).bin: $(objects) makefile
	LinkLE.exe $(name).bin $(cseg) $(dseg) $(objects)

patterns = pattern.bin

$(name).rom: $(name).bin $(patterns)
	makerom $(name).rom $(name).bin $(patterns)

bgm.bgm: bgm.mml
	vgsmml bgm.mml bgm.bgm

start.bgm: start.mml
	vgsmml start.mml start.bgm

over.bgm: over.mml
	vgsmml over.mml over.bgm

bgm_r.bgm: bgm.bgm Repeat.csx
	dotnet script Repeat.csx

bgms = bgm_r.bgm start.bgm over.bgm

bgm: $(bgms) makefile
	makebgm bgm $(bgms)

ses = fire.wav highBang.wav lowBang.wav up.wav

se: $(ses) makefile
	makese se $(ses)

game.pkg: $(name).rom bgm se
	makepkg -o game.pkg -r $(name).rom -b bgm -s se
