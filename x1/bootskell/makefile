name=bootskell

all: $(name).tap $(name).d88

cseg=8100
dseg=C400 

.c.asm:
	Cate80.exe $*.c

.asm.obj:
	Asm80.exe $*.asm

Main.asm: Main.c Main.h ScanKeys.h Sprite.h Vram.h Sound.h Status.h Stage.h Man.h \
	Block.h Monster.h Math.h Point.h

Status.asm: Status.c Status.h Main.h Print.h Chars.h Sprite.h
Stage.asm: Stage.c Stage.h Stages.h Main.h Sprite.h Chars.h CopyMemory.h Status.h \
	Man.h Block.h Point.h VVram.h
Stages.asm: Stages.c Stage.h Stages.h
Movable.asm: Movable.c Movable.h Stage.h Man.h Block.h Monster.h
Man.asm: Man.c Movable.h Man.h Sprite.h Stage.h Movable.h ScanKeys.h Block.h \
	Sound.h Main.h Chars.h VVram.h
Block.asm: Block.c Movable.h Block.h Sprite.h Stage.h Vram.h Chars.h Man.h Monster.h \
	Point.h Math.h Sound.h VVram.h Main.h
Monster.asm: Monster.c Movable.h Monster.h Sprite.h Stage.h Movable.h Block.h \
	Math.h Man.h Main.h Chars.h
Point.asm: Point.c Movable.h Point.h Sprite.h Main.h	

Math.asm: Math.c Math.h
Vram.asm: Vram.c Vram.h
VVram.asm: VVram.h Chars.h Vram.h
Sprite.asm: Sprite.c Sprite.h Chars.h Vram.h VVram.h

objects = \
	Main.obj Status.obj Stage.obj Movable.obj \
	Man.obj Block.obj Monster.obj Point.obj \
	Stages.obj Chars.obj VVram.obj VVramA.obj \
	Init.obj ScanKeys.obj Vram.obj VramA.obj PrintA.obj \
	Sprite.obj Sound.obj CopyMemory.obj Math.obj \
	..\..\cate\cate80.lib

$(name).bin: $(objects)
	LinkLE.exe $(name).bin $(cseg) $(dseg) $(objects)

$(name).wav: $(name).bin
	..\x1tape\x1tape -file2wav -filemode ipl -start 8100 -entry 8100 $(name).bin $(name).wav

$(name).tap: $(name).wav
	..\x1tape\x1tape -wav2tap $(name).wav $(name).tap

$(name).d88: $(name).bin Disk.csx
	dotnet script Disk.csx $(name) $(cseg)
