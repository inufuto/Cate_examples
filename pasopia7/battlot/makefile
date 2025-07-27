name=battlot

all: $(name).ram

cseg=9000
dseg=C200
fixed=C100

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

Init.obj: Init.asm FixedCode.inc
Vram.asm: Vram.c Vram.h Chars.h
VramA.obj: VramA.asm 
Sprite.asm: Sprite.c Sprite.h Chars.h Vram.h VVram.h
VVram.h: Vram.h
VVram.asm: VVram.h Chars.h

FixedCode.bin: VramTrans.obj
	LinkLE.exe FixedCode.bin C000 F000 VramTrans.obj

FixedCode.asm FixedCode.inc: FixedCode.bin
	dotnet script BinAsm.csx

objects = \
	Main.obj Stages.obj Stage.obj Status.obj Fort.obj Direction.obj  \
	Robo.obj MyRobo.obj EnemyRobo.obj Bullet.obj Bang.obj \
	PrintA.obj \
	Init.obj ScanKeys.obj Sound.obj Vram.obj VramA.obj VVram.obj VVramA.obj Sprite.obj \
	Chars.obj FixedCode.obj\
	..\..\cate\cate80.lib

$(name).ram: $(objects)
	LinkLE.exe $(name).ram 9000 C100 $(objects)
