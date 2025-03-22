name=aerial

all: game.pkg

cseg=0000
dseg=C000

.c.asm:
	Cate80.exe $*.c

.asm.obj:
	Asm80.exe $*.asm

Bang.asm: Bang.c Bang.h Movable.h Vram.h Sprite.h Movable.h \
	Stage.h Vram.h Chars.h 
Bullet.asm: Bullet.c Bullet.h Movable.h Sprite.h Movable.h Stage.h \
	Vram.h 
EnemyBullet.asm: EnemyBullet.c EnemyBullet.h Bullet.h Movable.h Sprite.h Movable.h \
	Chars.h MyFighter.h Fighter.h Movable.h 
EnemyFighter.asm: EnemyFighter.c EnemyFighter.h Fighter.h Movable.h Sprite.h Movable.h \
	Stage.h Vram.h Chars.h Math.h Bullet.h Movable.h \
	Sound.h Bang.h Movable.h Main.h EnemyBullet.h Bullet.h \
	Movable.h MyFighter.h Fighter.h Movable.h MyBullet.h Bullet.h \
	Movable.h 
Fighter.asm: Fighter.c Fighter.h Movable.h Sprite.h Movable.h 
Fort.asm: Fort.c Fort.h Chars.h Vram.h Main.h Stage.h \
	Vram.h Movable.h Sound.h Bang.h Movable.h Math.h \
	EnemyBullet.h Bullet.h Movable.h MyFighter.h Fighter.h Movable.h 
GroundEnemy.asm: GroundEnemy.c GroundEnemy.h Movable.h Sprite.h Movable.h Chars.h \
	Stage.h Vram.h MyBullet.h Bullet.h Movable.h Sound.h \
	Bang.h Movable.h Main.h Math.h MyFighter.h Fighter.h \
	Movable.h EnemyBullet.h Bullet.h Movable.h Item.h Movable.h 
Item.asm: Item.c Item.h Movable.h Sprite.h Movable.h Vram.h \
	MyFighter.h Fighter.h Movable.h Status.h Main.h Sound.h \
	Chars.h 
Main.asm: Main.c Main.h Stage.h Vram.h ScanKeys.h Sprite.h \
	Movable.h Status.h Sound.h MyFighter.h Fighter.h Movable.h \
	MyBullet.h Bullet.h Movable.h EnemyFighter.h Fighter.h Movable.h \
	EnemyBullet.h Bullet.h Movable.h GroundEnemy.h Movable.h Fort.h \
	Bang.h Movable.h Item.h Movable.h 
Math.asm: Math.c Math.h 
Movable.asm: Movable.c Movable.h 
MyBullet.asm: MyBullet.c MyBullet.h Bullet.h Movable.h Sprite.h Movable.h \
	Chars.h Sound.h MyFighter.h Fighter.h Movable.h EnemyFighter.h \
	Fighter.h Movable.h GroundEnemy.h Movable.h Fort.h 
MyFighter.asm: MyFighter.c MyFighter.h Fighter.h Movable.h Stage.h Vram.h \
	Chars.h ScanKeys.h Sprite.h Movable.h MyBullet.h Bullet.h \
	Movable.h Sound.h Bang.h Movable.h Status.h Main.h \
	Fort.h 
Stage.asm: Stage.c Stage.h Vram.h Stages.h Main.h Chars.h \
	CopyMemory.h Math.h Status.h Sprite.h Movable.h MyFighter.h \
	Fighter.h Movable.h MyBullet.h Bullet.h Movable.h EnemyFighter.h \
	Fighter.h Movable.h EnemyBullet.h Bullet.h Movable.h GroundEnemy.h \
	Movable.h Fort.h Bang.h Movable.h Item.h Movable.h 
Stages.asm: Stages.c Vram.h Stage.h Vram.h Stages.h 
Status.asm: Status.c Status.h Vram.h Main.h Sprite.h Movable.h \
	Print.h Chars.h 
Vram.asm: Vram.c Vram.h 
CopyMemory.obj: CopyMemory.asm 
Print.obj: Print.asm 
ScanKeys.obj: ScanKeys.asm vgszero.inc 
Sound.obj: Sound.asm vgszero.inc 
Sprite.obj: Sprite.asm vgszero.inc Vram.inc 
Startup.obj: Startup.asm vgszero.inc 
VramA.obj: VramA.asm vgszero.inc Vram.inc Chars.inc 

objects = Startup.obj \
	Bang.obj Bullet.obj EnemyBullet.obj EnemyFighter.obj Fighter.obj Fort.obj \
	GroundEnemy.obj Item.obj Main.obj Math.obj Movable.obj MyBullet.obj \
	MyFighter.obj Stage.obj Stages.obj Status.obj Vram.obj CopyMemory.obj \
	Print.obj ScanKeys.obj Sound.obj Sprite.obj VramA.obj \
	..\..\cate\cate80.lib

$(name).bin: $(objects) makefile
	LinkLE.exe $(name).bin $(cseg) $(dseg) $(objects)


$(name).rom: $(name).bin pattern.bin
	makerom $(name).rom $(name).bin pattern.bin

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
