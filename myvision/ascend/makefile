name=ascend

all: $(name).rom

cseg=0000
dseg=a000

.c.asm:
	Cate80.exe $*.c

.asm.obj:
	Asm80.exe $*.asm

Main.asm: Main.c Main.h ScanKeys.h Vram.h Sound.h Status.h Stage.h \
	Movable.h Actor.h Sprite.h Man.h Fire.h Monster.h
Movable.asm: Movable.c Movable.h
Actor.asm: Actor.c Movable.h Actor.h Stage.h Block.h Sprite.h Man.h
Man.asm: Man.c Movable.h Actor.h Man.h Sprite.h Chars.h Stage.h ScanKeys.h \
	Block.h Sound.h Main.h Fire.h Status.h 
Fire.asm: Fire.c Movable.h Actor.h Sprite.h Fire.h Chars.h Math.h Main.h \
	Stage.h Man.h Vram.h
Monster.asm: Monster.c Movable.h Actor.h Sprite.h Monster.h Chars.h Math.h Main.h \
	Stage.h Man.h Vram.h
Block.asm: Block.c Movable.h Actor.h Sprite.h Block.h Chars.h Stage.h Stages.h \
	Vram.h Man.h

Status.asm: Status.c Status.h Main.h Print.h Chars.h Vram.h \
	Movable.h Actor.h Sprite.h
Stage.asm: Stage.c Stage.h Stages.h Main.h Chars.h Vram.h Status.h \
	Movable.h Actor.h Man.h Fire.h Monster.h Block.h Math.h
Stages.asm: Stages.c Stage.h Stages.h

Vram.asm: Vram.c Vram.h Chars.h
VramA.obj: VramA.asm Vram.inc Chars.inc
Sprite.obj: Sprite.asm Vram.inc Chars.inc

objects = startup.obj \
	Main.obj Status.obj Stage.obj Stages.obj Chars.obj BackgroundPattern.obj \
	ScanKeys.obj Vram.obj VramA.obj Print.obj \
	Sprite.obj Sound.obj Math.obj \
	Actor.obj Movable.obj Man.obj Fire.obj Monster.obj Block.obj \
	Vdp.obj \
	..\..\cate\cate80.lib

$(name).rom: $(objects) makefile
    linkle.exe $(name).rom $(cseg) $(dseg) $(objects)
