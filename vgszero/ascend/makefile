name=ascend

all: game.pkg

cseg=0000
dseg=C000

.c.asm:
	Cate80.exe $*.c

.asm.obj:
	Asm80.exe $*.asm

Actor.asm: Actor.c Movable.h Actor.h Stage.h Block.h Sprite.h \
	Movable.h Man.h 
Block.asm: Block.c Movable.h Sprite.h Movable.h Actor.h Block.h \
	Chars.h Stage.h Stages.h Vram.h Man.h 
Fire.asm: Fire.c Movable.h Sprite.h Movable.h Actor.h Fire.h \
	Chars.h Math.h Main.h Stage.h Man.h Vram.h 
Main.asm: Main.c Main.h ScanKeys.h Vram.h Sound.h Status.h \
	Movable.h Actor.h Stage.h Sprite.h Movable.h Man.h \
	Fire.h Monster.h 
Man.asm: Man.c Movable.h Sprite.h Movable.h Actor.h Man.h \
	Stage.h Chars.h ScanKeys.h Vram.h Block.h Sound.h \
	Main.h Fire.h Status.h 
Monster.asm: Monster.c Movable.h Sprite.h Movable.h Actor.h Monster.h \
	Chars.h Math.h Main.h Stage.h Man.h Vram.h 
Movable.asm: Movable.c Movable.h 
Sprite.asm: Sprite.c Sprite.h Movable.h Vram.h Stage.h 
Stage.asm: Stage.c Vram.h Stage.h Stages.h Main.h Chars.h \
	Status.h Movable.h Actor.h Man.h Sprite.h Movable.h \
	Stage.h Fire.h Monster.h Block.h Math.h 
Stages.asm: Stages.c Stage.h Stages.h 
Status.asm: Status.c Status.h Vram.h Main.h Movable.h Actor.h \
	Sprite.h Movable.h Print.h Chars.h 
Vram.asm: Vram.c Vram.h 
Math.obj: Math.asm 
Print.obj: Print.asm 
ScanKeys.obj: ScanKeys.asm vgszero.inc 
Sound.obj: Sound.asm vgszero.inc 
SpriteA.obj: SpriteA.asm vgszero.inc Vram.inc Chars.inc 
Startup.obj: Startup.asm vgszero.inc 
VramA.obj: VramA.asm vgszero.inc Vram.inc 

objects = Startup.obj \
	Actor.obj Block.obj Fire.obj Main.obj Man.obj Monster.obj \
	Movable.obj Sprite.obj Stage.obj Stages.obj Status.obj Vram.obj \
	Math.obj Print.obj ScanKeys.obj Sound.obj SpriteA.obj VramA.obj \
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

bgms = bgm_r.bgm start.bgm clear.bgm over.bgm loose.bgm beep.bgm

bgm: $(bgms) makefile
	makebgm bgm $(bgms)

ses = item.wav

se: $(ses) makefile
	makese se $(ses)

game.pkg: $(name).rom bgm se
	makepkg -o game.pkg -r $(name).rom -b bgm -s se
