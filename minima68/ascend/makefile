name=ascend

filename=$(name).bin

all: $(filename)

cseg=0100
dseg=3000
zseg=0000

.c.asm:
	Cate68.exe $*.c

.asm.obj:
	Asm68.exe -v2 $*.asm

Actor.asm: Actor.c Movable.h Actor.h Stage.h Vram.h Block.h \
	Sprite.h Movable.h Man.h 
Block.asm: Block.c Movable.h Sprite.h Movable.h Actor.h Block.h \
	Chars.h Stage.h Vram.h Stages.h Vram.h Man.h 
Fire.asm: Fire.c Movable.h Sprite.h Movable.h Actor.h Fire.h \
	Chars.h Math.h Main.h Stage.h Vram.h Man.h \
	Vram.h 
Main.asm: Main.c Main.h ScanKeys.h Vram.h Sound.h Status.h \
	Movable.h Actor.h Stage.h Vram.h Sprite.h Movable.h \
	Man.h Fire.h Monster.h 
Man.asm: Man.c Movable.h Sprite.h Movable.h Actor.h Man.h \
	Stage.h Vram.h Chars.h ScanKeys.h Vram.h Block.h \
	Sound.h Main.h Fire.h Status.h 
Monster.asm: Monster.c Movable.h Sprite.h Movable.h Actor.h Monster.h \
	Chars.h Math.h Main.h Stage.h Vram.h Man.h \
	Vram.h 
Movable.asm: Movable.c Movable.h 
Stage.asm: Stage.c Vram.h Stage.h Vram.h Stages.h Main.h \
	Chars.h Status.h Movable.h Actor.h Man.h Sprite.h \
	Movable.h Stage.h Vram.h Fire.h Monster.h Block.h \
	Math.h 
Stages.asm: Stages.c Stage.h Vram.h Stages.h 
Status.asm: Status.c Status.h Vram.h Stage.h Vram.h Main.h \
	Movable.h Sprite.h Movable.h Print.h Chars.h 
Vram.asm: Vram.c Vram.h Chars.h Sprite.h Movable.h Stage.h \
	Vram.h 
Chars.obj: Chars.asm 
CopyMemory.obj: CopyMemory.asm 
Math.obj: Math.asm 
Print.obj: Print.asm 
ScanKeys.obj: ScanKeys.asm 
Sound.obj: Sound.asm 
StageA.obj: StageA.asm Vram.inc Chars.inc 
Startup.obj: Startup.asm 
VramA.obj: VramA.asm Vram.inc Chars.inc 

objects = Startup.obj \
	Actor.obj Block.obj Fire.obj Main.obj Man.obj Monster.obj \
	Movable.obj Sprite.obj Stage.obj Stages.obj Status.obj Vram.obj \
	Chars.obj  Math.obj Print.obj ScanKeys.obj Sound.obj \
	StageA.obj VramA.obj \
	..\..\cate\cate68.lib

$(filename): $(objects) makefile
	LinkBE.exe $(filename) $(cseg) $(dseg) $(zseg) $(objects)
