name=bootskell

cseg=9000
dseg=C200
fixed=C100

all: $(name).ram $(name).d88

.c.asm:
	Cate80.exe $*.c

.asm.obj:
	Asm80.exe $*.asm

Block.asm: Block.c Movable.h Block.h Sprite.h Movable.h Stage.h \
	Vram.h Chars.h Man.h Monster.h Point.h Movable.h \
	Math.h Sound.h VVram.h 
Main.asm: Main.c Main.h ScanKeys.h Sprite.h Movable.h Vram.h \
	Sound.h Status.h Stage.h Man.h Block.h Monster.h \
	Math.h Point.h Movable.h VVram.h 
Man.asm: Man.c Movable.h Man.h Sprite.h Movable.h Stage.h \
	ScanKeys.h Block.h Sound.h Main.h Chars.h VVram.h 
Math.asm: Math.c Math.h 
Monster.asm: Monster.c Movable.h Monster.h Sprite.h Movable.h Stage.h \
	Block.h Math.h Man.h Main.h Chars.h 
Movable.asm: Movable.c Movable.h Stage.h Man.h Block.h Monster.h 
Point.asm: Point.c Point.h Movable.h Sprite.h Movable.h Main.h \
	Chars.h 
Sprite.asm: Sprite.c Sprite.h Movable.h Chars.h VVram.h Vram.h 
Stage.asm: Stage.c Stage.h Stages.h Main.h Vram.h Sprite.h \
	Movable.h Chars.h CopyMemory.h Status.h Movable.h Man.h \
	Block.h Monster.h Point.h Movable.h VVram.h 
Stages.asm: Stages.c Stage.h Stages.h 
Status.asm: Status.c Status.h Vram.h Stage.h Main.h Sprite.h \
	Movable.h Print.h Chars.h 
Vram.asm: Vram.c Vram.h Chars.h 
VVram.asm: VVram.c VVram.h Chars.h Sprite.h Movable.h Vram.h 
Chars.obj: Chars.asm 
CopyMemory.obj: CopyMemory.asm 
FixedCode.obj: FixedCode.asm 
Init.obj: Init.asm FixedCode.inc 
Loader.obj: Loader.asm BinSize.inc 
PrintA.obj: PrintA.asm 
ScanKeys.obj: ScanKeys.asm 
Sound.obj: Sound.asm 
VramA.obj: VramA.asm FixedCode.inc 
VramTrans.obj: VramTrans.asm 
VVramA.obj: VVramA.asm 

objects = Main.obj \
	Block.obj Man.obj Math.obj Monster.obj Movable.obj Point.obj \
	Sprite.obj Stage.obj Stages.obj Status.obj Vram.obj VVram.obj \
	Chars.obj CopyMemory.obj FixedCode.obj Init.obj PrintA.obj ScanKeys.obj \
	Sound.obj VramA.obj VVramA.obj \
	..\..\cate\cate80.lib

FixedCode.bin: VramTrans.obj
	LinkLE.exe FixedCode.bin $(fixed) F000 VramTrans.obj

FixedCode.asm FixedCode.inc: FixedCode.bin
	dotnet script BinAsm.csx

$(name).ram: $(objects) makefile
	LinkLE.exe $(name).ram $(cseg) $(dseg) $(objects)


$(name).bin: $(objects) makefile
	LinkLE.exe $(name).bin $(cseg) $(dseg) $(objects)

BinSize.inc: $(name).bin BinSize.csx
	dotnet script BinSize.csx $(name) $(cseg)

Loader.bin: Loader.obj makefile
    LinkLE.exe Loader.bin f000 f100 Loader.obj

$(name).d88: $(name).bin Loader.bin makefile disk.csx
    dotnet script disk.csx $(name)
