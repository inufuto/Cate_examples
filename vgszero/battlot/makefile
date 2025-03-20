name=battlot

all: game.pkg

cseg=0000
dseg=C000

.c.asm:
	Cate80.exe $*.c

.asm.obj:
	Asm80.exe $*.asm

Bang.asm: Bang.c Bang.h Sprite.h Stage.h Chars.h 
Bullet.asm: Bullet.c Bullet.h Sprite.h Stage.h Direction.h Stage.h \
	Robo.h Bullet.h Fort.h Chars.h 
Direction.asm: Direction.c Direction.h 
EnemyRobo.asm: EnemyRobo.c Robo.h Bullet.h Sprite.h Main.h Fort.h \
	Stage.h Direction.h Bullet.h Bang.h Sound.h Chars.h 
Fort.asm: Fort.c Fort.h Vram.h Chars.h Stage.h Robo.h \
	Bullet.h Bang.h Sprite.h Sound.h 
Main.asm: Main.c Main.h Stage.h ScanKeys.h Status.h Sprite.h \
	Vram.h Robo.h Bullet.h Bullet.h Bang.h Fort.h \
	Sound.h 
MyRobo.asm: MyRobo.c Robo.h Bullet.h Sprite.h Direction.h Stage.h \
	ScanKeys.h Fort.h Bang.h Main.h Sound.h Chars.h 
Robo.asm: Robo.c Robo.h Bullet.h Direction.h Sprite.h Stage.h \
	Fort.h Bullet.h 
Sprite.asm: Sprite.c Sprite.h 
Stage.asm: Stage.c Stage.h Stages.h Main.h Sprite.h Vram.h \
	Chars.h Fort.h Robo.h Bullet.h Bullet.h Bang.h 
Stages.asm: Stages.c Stage.h Stages.h 
Status.asm: Status.c Status.h Vram.h Stage.h Main.h Sprite.h \
	Print.h Chars.h 
Vram.asm: Vram.c Vram.h 
Print.obj: Print.asm 
ScanKeys.obj: ScanKeys.asm vgszero.inc 
Sound.obj: Sound.asm vgszero.inc 
SpriteA.obj: SpriteA.asm vgszero.inc Vram.inc Chars.inc 
Startup.obj: Startup.asm vgszero.inc 
VramA.obj: VramA.asm vgszero.inc Vram.inc 

objects = startup.obj \
	Bang.obj Bullet.obj Direction.obj EnemyRobo.obj Fort.obj Main.obj \
	MyRobo.obj Robo.obj Sprite.obj Stage.obj Stages.obj Status.obj \
	Vram.obj Print.obj ScanKeys.obj Sound.obj SpriteA.obj VramA.obj \
	..\..\cate\cate80.lib


$(name).bin: $(objects) makefile
	LinkLE.exe $(name).bin $(cseg) $(dseg) $(objects)


$(name).rom: $(name).bin pattern.bin
	makerom $(name).rom $(name).bin pattern.bin

bgm.bgm: bgm.mml
	vgsmml bgm.mml bgm.bgm

start.bgm: start.mml
	vgsmml start.mml start.bgm

clear.bgm: clear.mml
	vgsmml clear.mml clear.bgm

over.bgm: over.mml
	vgsmml over.mml over.bgm

loose.bgm: loose.mml
	vgsmml loose.mml loose.bgm

beep.bgm: beep.mml
	vgsmml beep.mml beep.bgm

bgm_r.bgm: bgm.bgm Repeat.csx
	dotnet script Repeat.csx

bgms = bgm_r.bgm start.bgm clear.bgm over.bgm beep.bgm

bgm: $(bgms) makefile
	makebgm bgm $(bgms)

ses = fire.wav highBang.wav lowBang.wav

se: $(ses) makefile
	makese se $(ses)

game.pkg: $(name).rom bgm se
	makepkg -o game.pkg -r $(name).rom -b bgm -s se
