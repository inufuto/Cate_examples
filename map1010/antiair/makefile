name=antiair

all: $(name).wav loader.txt

cseg=8800
dseg=a400
loader=8000

.c.asm:
	Cate80.exe $*.c

.asm.obj:
	Asm80.exe $*.asm

Bang.asm: Bang.c Bang.h Movable.h VVram.h Sprite.h Movable.h \
	Stage.h Chars.h 
Block.asm: Block.c Block.h Movable.h Sprite.h Movable.h Chars.h \
	VVram.h CopyMemory.h Chars.h Bang.h Movable.h Sound.h \
	Cannon.h Movable.h Status.h 
Bullet.asm: Bullet.c Bullet.h Sprite.h Movable.h Chars.h VVram.h \
	Sound.h Cannon.h Movable.h Ufo.h Stage.h Block.h \
	Movable.h 
Cannon.asm: Cannon.c Cannon.h Movable.h VVram.h Sprite.h Movable.h \
	Chars.h ScanKeys.h Bullet.h Block.h Movable.h Bang.h \
	Movable.h Sound.h 
Main.asm: Main.c Status.h ScanKeys.h Sound.h Stage.h Cannon.h \
	Movable.h Sprite.h Movable.h Bullet.h Vram.h VVram.h \
	Ufo.h Stage.h Bang.h Movable.h Block.h Movable.h 
Sprite.asm: Sprite.c Sprite.h Movable.h Chars.h VVram.h Vram.h 
Stage.asm: Stage.c Stages.h Stage.h VVram.h Math.h Status.h \
	Sprite.h Movable.h Cannon.h Movable.h Bullet.h Ufo.h \
	Stage.h Bang.h Movable.h Block.h Movable.h 
Stages.asm: Stages.c Stages.h Stage.h 
Status.asm: Status.c Status.h Vram.h Print.h Chars.h Sprite.h \
	Movable.h 
Ufo.asm: Ufo.c Ufo.h Stage.h VVram.h Movable.h CopyMemory.h \
	Chars.h Bang.h Movable.h Sound.h Block.h Movable.h \
	Math.h Status.h 
Vram.asm: Vram.c Vram.h Chars.h 
VVram.asm: VVram.c VVram.h Chars.h Sprite.h Movable.h Vram.h \
	Ufo.h Stage.h 
Chars.obj: Chars.asm 
chead.obj: chead.asm 
CopyMemory.obj: CopyMemory.asm 
Math.obj: Math.asm 
Print.obj: Print.asm 
ScanKeys.obj: ScanKeys.asm 
Sound.obj: Sound.asm 
Startup.obj: Startup.asm 
VramA.obj: VramA.asm Vram.inc VVram.inc 
VVramA.obj: VVramA.asm VVram.inc Chars.inc 

objects = Startup.obj \
	Bang.obj Block.obj Bullet.obj Cannon.obj Main.obj Sprite.obj \
	Stage.obj Stages.obj Status.obj Ufo.obj Vram.obj VVram.obj \
	Chars.obj CopyMemory.obj Math.obj Print.obj ScanKeys.obj Sound.obj \
	VramA.obj VVramA.obj \
	..\..\cate\cate80.lib

$(name).cmt: $(objects) makefile
	LinkLE.exe $(name).cmt $(cseg) $(dseg) $(objects)

$(name).wav: $(name).cmt CmtWav.csx 
	dotnet script CmtWav.csx $(name)

loader.obj: loader.asm

loader.bin: loader.obj makefile
	linkLE loader.bin $(loader) $(dseg) loader.obj

loader.txt: loader.bin loader.csx
	dotnet script loader.csx $(loader)
