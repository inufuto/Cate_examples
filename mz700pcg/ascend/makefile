name=ascend

all: $(name).wav

cseg=1200
dseg=3000 

.c.asm:
	Cate80.exe $*.c

.asm.obj:
	Asm80.exe $*.asm

Actor.asm: Actor.c Movable.h Actor.h Stage.h Block.h Sprite.h \
	Man.h 
Block.asm: Block.c Movable.h Sprite.h Actor.h Block.h Chars.h \
	Stage.h Stages.h Vram.h Man.h 
Fire.asm: Fire.c Movable.h Sprite.h Actor.h Fire.h Chars.h \
	Math.h Main.h Stage.h Man.h Vram.h VVram.h 
Main.asm: Main.c Main.h ScanKeys.h Vram.h Sound.h Status.h \
	Movable.h Actor.h Stage.h Sprite.h Man.h Fire.h \
	Monster.h VVram.h 
Man.asm: Man.c Movable.h Sprite.h Actor.h Man.h Stage.h \
	Chars.h ScanKeys.h Vram.h Block.h Sound.h Main.h \
	Fire.h Status.h VVram.h 
Monster.asm: Monster.c Movable.h Sprite.h Actor.h Monster.h Chars.h \
	Math.h Main.h Stage.h Man.h Vram.h 
Movable.asm: Movable.c Movable.h 
Sprite.asm: Sprite.c Movable.h Sprite.h Chars.h VVram.h Vram.h \
	Stage.h 
Stage.asm: Stage.c Vram.h Stage.h Stages.h Main.h Chars.h \
	Status.h Movable.h Actor.h Man.h Sprite.h Stage.h \
	Fire.h Monster.h Block.h Math.h VVram.h 
Stages.asm: Stages.c Stage.h Stages.h 
Status.asm: Status.c Status.h Vram.h Stage.h Main.h Movable.h \
	Actor.h Sprite.h Print.h Chars.h 
Vram.asm: Vram.c Vram.h Chars.h 
VVram.asm: VVram.c VVram.h Chars.h Movable.h Sprite.h Vram.h \
	Sound.h 
Chars.obj: Chars.asm 
Math.obj: Math.asm 
Print.obj: Print.asm 
ScanKeys.obj: ScanKeys.asm 
Sound.obj: Sound.asm 
Startup.obj: Startup.asm 
VramA.obj: VramA.asm Vram.inc VVram.inc Chars.inc 
VVramA.obj: VVramA.asm VVram.inc Chars.inc 

objects = Startup.obj \
	Actor.obj Block.obj Fire.obj Main.obj Man.obj Monster.obj \
	Movable.obj Sprite.obj Stage.obj Stages.obj Status.obj Vram.obj \
	VVram.obj Chars.obj Math.obj Print.obj ScanKeys.obj Sound.obj \
	VramA.obj VVramA.obj \
	..\..\cate\cate80.lib

$(name).mzt: $(objects) makefile
	LinkLE.exe $(name).mzt $(cseg) $(dseg) $(objects)

$(name).wav: $(name).mzt
	mzt2wav $(name).mzt $(name).wav
	mztwav2pcm $(name).wav
