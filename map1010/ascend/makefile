name=ascend

all: $(name).wav loader.txt

cseg=8800
dseg=a800
loader=8000

.c.asm:
	Cate80.exe $*.c

.asm.obj:
	Asm80.exe $*.asm

Main.asm: Main.c Main.h ScanKeys.h Vram.h Sound.h Status.h Stage.h \
	Movable.h Actor.h Sprite.h Man.h Fire.h Monster.h VVram.h
Movable.asm: Movable.c Movable.h
Actor.asm: Actor.c Movable.h Actor.h Stage.h Block.h Sprite.h Man.h
Man.asm: Man.c Movable.h Actor.h Man.h Sprite.h Chars.h Stage.h ScanKeys.h \
	Block.h Sound.h Main.h Fire.h Status.h VVram.h
Fire.asm: Fire.c Movable.h Actor.h Sprite.h Fire.h Chars.h Math.h Main.h \
	Stage.h Man.h Vram.h VVram.h
Monster.asm: Monster.c Movable.h Actor.h Sprite.h Monster.h Chars.h Math.h Main.h \
	Stage.h Man.h Vram.h
Block.asm: Block.c Movable.h Actor.h Sprite.h Block.h Chars.h Stage.h Stages.h \
	Vram.h Man.h

Status.asm: Status.c Status.h Main.h Print.h Chars.h Vram.h \
	Movable.h Actor.h Sprite.h
Stage.asm: Stage.c Stage.h Stages.h Main.h Chars.h Vram.h Status.h \
	Movable.h Actor.h Man.h Fire.h Monster.h Block.h Math.h VVram.h
Stages.asm: Stages.c Stage.h Stages.h

Vram.asm: Vram.c Vram.h Chars.h
VramA.obj: VramA.asm Vram.inc Chars.inc
Sprite.asm: Sprite.c Sprite.h VVram.h Chars.h Movable.h Vram.h Stage.h
VVram.asm: VVram.h Chars.h Vram.h Sprite.h
VVramA.obj: VramA.asm Vram.inc Chars.inc

objects = \
	Main.obj Status.obj Stage.obj Stages.obj Chars.obj \
	Init.obj ScanKeys.obj Vram.obj VramA.obj Print.obj VVram.obj VVramA.obj \
	Sprite.obj Sound.obj Math.obj \
	Actor.obj Movable.obj Man.obj Fire.obj Monster.obj Block.obj \
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
