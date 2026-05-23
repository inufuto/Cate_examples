name=lift

cseg=9000
dseg=C200
fixed=C100

all: $(name).ram $(name).d88

.c.asm:
	Cate80.exe $*.c

.asm.obj:
	Asm80.exe $*.asm

Actor.asm: Actor.c Movable.h Actor.h Stage.h Lift.h 
Item.asm: Item.c Item.h Stage.h Stages.h Vram.h Chars.h \
	Main.h Movable.h Actor.h Man.h Point.h Movable.h \
	Sound.h Sprite.h Movable.h VVram.h 
Lift.asm: Lift.c Movable.h Actor.h Lift.h Stage.h Stages.h \
	Vram.h Chars.h Sprite.h Movable.h Man.h Monster.h 
Main.asm: Main.c Main.h Init.h ScanKeys.h Movable.h Sprite.h \
	Movable.h Vram.h Sound.h Status.h Stage.h Actor.h \
	Monster.h Lift.h Man.h Item.h Point.h Movable.h 
Man.asm: Man.c Movable.h Actor.h Man.h Stage.h Sprite.h \
	Movable.h Chars.h ScanKeys.h Item.h Sound.h VVram.h 
Math.asm: Math.c Math.h 
Monster.asm: Monster.c Movable.h Actor.h Monster.h Stages.h Stage.h \
	Sprite.h Movable.h Chars.h Man.h Lift.h 
Movable.asm: Movable.c Movable.h Stage.h Actor.h Lift.h 
Point.asm: Point.c Point.h Movable.h Sprite.h Movable.h Main.h \
	Chars.h 
Sprite.asm: Sprite.c Sprite.h Movable.h Chars.h VVram.h Vram.h 
Stage.asm: Stage.c Stage.h Stages.h Main.h Vram.h Movable.h \
	Sprite.h Movable.h Chars.h Status.h Item.h Actor.h \
	Man.h Lift.h Monster.h Point.h Movable.h VVram.h 
Stages.asm: Stages.c Stage.h Stages.h 
Status.asm: Status.c Status.h Vram.h Stage.h Main.h Sprite.h \
	Movable.h Print.h Chars.h 
Vram.asm: Vram.c Vram.h Chars.h 
VVram.asm: VVram.c VVram.h Chars.h Sprite.h Movable.h Vram.h \
	Sound.h 
Chars.obj: Chars.asm 
FixedCode.obj: FixedCode.asm 
Init.obj: Init.asm FixedCode.inc 
Loader.obj: Loader.asm BinSize.inc 
Print.obj: Print.asm 
ScanKeys.obj: ScanKeys.asm 
Sound.obj: Sound.asm 
VramA.obj: VramA.asm FixedCode.inc 
VramTrans.obj: VramTrans.asm 
VVramA.obj: VVramA.asm VVram.inc Chars.inc 

objects = Main.obj \
	Actor.obj Item.obj Lift.obj Man.obj Math.obj Monster.obj \
	Movable.obj Point.obj Sprite.obj Stage.obj Stages.obj Status.obj \
	Vram.obj VVram.obj Chars.obj FixedCode.obj Init.obj Print.obj \
	ScanKeys.obj Sound.obj VramA.obj VVramA.obj \
	..\..\cate\cate80.lib

FixedCode.bin: VramTrans.obj
	LinkLE.exe FixedCode.bin $(fixed) F000 VramTrans.obj

FixedCode.asm FixedCode.inc: FixedCode.bin
	dotnet script BinAsm.csx

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
