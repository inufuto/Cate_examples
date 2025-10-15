name=battlot

all: $(name).wav loader.txt

cseg=8800
dseg=b000
loader=8000

.c.asm:
	Cate80.exe $*.c

.asm.obj:
	Asm80.exe $*.asm

Main.asm : Main.c Main.h ScanKeys.h Status.h Stage.h Vram.h Sprite.h Bullet.h Bang.h \
	Fort.h VVram.h
Stages.asm: Stages.c Stage.h Stages.h Chars.h Bullet.h
Stage.asm: Stage.c Stage.h Stages.h Main.h Sprite.h Vram.h Fort.h Robo.h Bang.h \
	Status.h VVram.h
Status.asm: Status.c Status.h Stage.h Chars.h  Vram.h Sprite.h Print.h Chars.h VVram.h
Fort.asm: Fort.c Fort.h VVram.h Chars.h Stage.h Robo.h Bang.h Sprite.h Sound.h
Direction.asm: Direction.c Direction.h
Robo.h: Bullet.h
Robo.asm: Robo.c Robo.h Direction.h Sprite.h Stage.h Fort.h Bullet.h
MyRobo.asm: MyRobo.c Robo.h Sprite.h Direction.h Stage.h ScanKeys.h Fort.h Bang.h \
	Main.h Sound.h Chars.h
EnemyRobo.asm: EnemyRobo.c Robo.h Sprite.h Main.h Fort.h Stage.h Direction.h Bullet.h \
	Bang.h Sound.h Chars.h
Bullet.asm: Bullet.c Bullet.h Sprite.h Stage.h Direction.h Stage.h Robo.h Fort.h Chars.h
Bang.asm: Bang.c Bang.h Sprite.h Stage.h Chars.h

Vram.asm: Vram.c Vram.h
VramA.obj: VramA.asm Vram.inc 
Sprite.asm: Sprite.c Sprite.h Chars.h Vram.h VVram.h
VVram.h: Vram.h
VVram.asm: VVram.h Chars.h

objects = \
	Main.obj Stages.obj Stage.obj Status.obj Fort.obj Direction.obj  \
	Robo.obj MyRobo.obj EnemyRobo.obj Bullet.obj Bang.obj \
	PrintA.obj \
	Init.obj ScanKeys.obj Sound.obj Vram.obj VramA.obj VVram.obj VVramA.obj Sprite.obj \
	Chars.obj \
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
