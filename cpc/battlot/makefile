name=battlot

all: $(name).wav

cseg=4000
dseg=9000

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
Fort.asm: Fort.c Fort.h Chars.h Stage.h Robo.h Bullet.h \
	Bang.h Sprite.h Sound.h VVram.h 
Main.asm: Main.c Main.h Stage.h ScanKeys.h Status.h Sprite.h \
	Vram.h Robo.h Bullet.h Bullet.h Bang.h Fort.h \
	Sound.h VVram.h 
MyRobo.asm: MyRobo.c Robo.h Bullet.h Sprite.h Direction.h Stage.h \
	ScanKeys.h Fort.h Bang.h Main.h Sound.h Chars.h 
Robo.asm: Robo.c Robo.h Bullet.h Direction.h Sprite.h Stage.h \
	Fort.h Bullet.h 
Sprite.asm: Sprite.c Sprite.h Chars.h VVram.h Vram.h 
Stage.asm: Stage.c Stage.h Stages.h Main.h Sprite.h Vram.h \
	Chars.h Fort.h Robo.h Bullet.h Bullet.h Bang.h \
	VVram.h 
Stages.asm: Stages.c Stage.h Stages.h 
Status.asm: Status.c Status.h Vram.h Stage.h Main.h Sprite.h \
	Print.h Chars.h 
Vram.asm: Vram.c Vram.h VVram.h CopyMemory.h Chars.h 
VVram.asm: VVram.c VVram.h Chars.h 
Chars.obj: Chars.asm 
Init.obj: Init.asm 
PrintA.obj: PrintA.asm 
ScanKeys.obj: ScanKeys.asm 
Sound.obj: Sound.asm 
VramA.obj: VramA.asm 
VVramA.obj: VVramA.asm 

objects = Main.obj \
	Bang.obj Bullet.obj Direction.obj EnemyRobo.obj Fort.obj MyRobo.obj \
	Robo.obj Sprite.obj Stage.obj Stages.obj Status.obj Vram.obj \
	VVram.obj Chars.obj Init.obj PrintA.obj ScanKeys.obj Sound.obj \
	VramA.obj VVramA.obj \
	..\..\cate\cate80.lib

$(name).bin: $(objects)
	LinkLE.exe $(name).bin $(cseg) $(dseg) $(objects)

$(name).cdt: $(name).bin
	2cdt.exe -n -r $(name) loader.bas $(name).cdt
	2cdt.exe -r BIN $(name).bin $(name).cdt

$(name).wav: $(name).cdt
	TZX2WAV $(name).cdt $(name).wav
