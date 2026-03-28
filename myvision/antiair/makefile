name=antiair

all: $(name).rom

cseg=0000
dseg=a000

.c.asm:
	Cate80.exe $*.c

.asm.obj:
	Asm80.exe $*.asm

Bang.asm: Bang.c Bang.h Movable.h Vram.h Sprite.h Movable.h \
	Stage.h Chars.h 
Block.asm: Block.c Block.h Movable.h Sprite.h Movable.h Chars.h \
	Vram.h CopyMemory.h Chars.h Bang.h Movable.h Sound.h \
	Cannon.h Movable.h Status.h 
Bullet.asm: Bullet.c Bullet.h Sprite.h Movable.h Chars.h Vram.h \
	Sound.h Cannon.h Movable.h Ufo.h Stage.h Block.h \
	Movable.h 
Cannon.asm: Cannon.c Cannon.h Movable.h Vram.h Sprite.h Movable.h \
	Chars.h ScanKeys.h Bullet.h Block.h Movable.h Bang.h \
	Movable.h Sound.h 
Main.asm: Main.c Status.h ScanKeys.h Sound.h Stage.h Cannon.h \
	Movable.h Sprite.h Movable.h Bullet.h Vram.h Ufo.h \
	Stage.h Bang.h Movable.h Block.h Movable.h 
Stage.asm: Stage.c Stages.h Stage.h Vram.h Math.h Status.h \
	Sprite.h Movable.h Cannon.h Movable.h Bullet.h Ufo.h \
	Stage.h Bang.h Movable.h Block.h Movable.h 
Stages.asm: Stages.c Stages.h Stage.h 
Status.asm: Status.c Status.h Vram.h Print.h Chars.h Sprite.h \
	Movable.h 
Ufo.asm: Ufo.c Ufo.h Stage.h Vram.h Movable.h CopyMemory.h \
	Chars.h Bang.h Movable.h Sound.h Block.h Movable.h \
	Math.h Status.h 
Vram.asm: Vram.c Vram.h Chars.h Ufo.h Stage.h Block.h \
	Movable.h 
Chars.obj: Chars.asm 
CopyMemory.obj: CopyMemory.asm 
Math.obj: Math.asm 
Print.obj: Print.asm 
ScanKeys.obj: ScanKeys.asm 
Sound.obj: Sound.asm 
Sprite.obj: Sprite.asm kh1000.inc Vram.inc Chars.inc 
Startup.obj: Startup.asm kh1000.inc Vram.inc 
Vdp.obj: Vdp.asm kh1000.inc Vram.inc 
VramA.obj: VramA.asm kh1000.inc Vram.inc Chars.inc 

objects = Startup.obj \
	Bang.obj Block.obj Bullet.obj Cannon.obj Main.obj Stage.obj \
	Stages.obj Status.obj Ufo.obj Vram.obj Chars.obj CopyMemory.obj \
	Math.obj Print.obj ScanKeys.obj Sound.obj Sprite.obj Vdp.obj \
	VramA.obj \
	..\..\cate\cate80.lib

$(name).rom: $(objects) makefile
	LinkLE.exe $(name).bin $(cseg) $(dseg) $(objects)
