name=ascend

all: $(name).ram $(name).d88

cseg=9000
dseg=C200
fixed=C100

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
Main.asm: Main.c Main.h Init.h ScanKeys.h Vram.h Sound.h \
	Status.h Movable.h Actor.h Stage.h Sprite.h Man.h \
	Fire.h Monster.h VVram.h 
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
FixedCode.obj: FixedCode.asm 
Init.obj: Init.asm FixedCode.inc 
Loader.obj: Loader.asm BinSize.inc 
Math.obj: Math.asm 
Print.obj: Print.asm 
ScanKeys.obj: ScanKeys.asm 
Sound.obj: Sound.asm 
VramA.obj: VramA.asm Vram.inc VVram.inc FixedCode.inc 
VramTrans.obj: VramTrans.asm 
VVramA.obj: VVramA.asm VVram.inc Chars.inc 

objects = Main.obj \
	Actor.obj Block.obj Fire.obj Man.obj Monster.obj Movable.obj \
	Sprite.obj Stage.obj Stages.obj Status.obj Vram.obj VVram.obj \
	Chars.obj FixedCode.obj Init.obj Math.obj Print.obj ScanKeys.obj \
	Sound.obj VramA.obj VVramA.obj \
	..\..\cate\cate80.lib

FixedCode.bin: VramTrans.obj
	LinkLE.exe FixedCode.bin $(fixed) F000 VramTrans.obj

FixedCode.asm: FixedCode.bin
	dotnet script binasm.csx

$(name).ram: $(objects)
	LinkLE.exe $(name).ram $(cseg) $(dseg) $(objects)


$(name).bin: $(objects) makefile
	LinkLE.exe $(name).bin $(cseg) $(dseg) $(objects)

BinSize.inc: $(name).bin BinSize.csx
	dotnet script BinSize.csx $(name) $(cseg)

Loader.bin: Loader.obj makefile
    LinkLE.exe Loader.bin f000 f100 Loader.obj

$(name).d88: $(name).bin Loader.bin makefile disk.csx
    dotnet script disk.csx $(name)
