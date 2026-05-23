name=svellas

all: $(name).ram $(name).d88

cseg=9000
dseg=C200
fixed=C100

.c.asm:
	Cate80.exe $*.c

.asm.obj:
	Asm80.exe -v2 $*.asm

Main.asm: Main.c Main.h Status.h ScanKeys.h Stage.h Man.h \
	Movable.h Sound.h Sprite.h Movable.h Monster.h Movable.h \
	VVram.h 
Man.asm: Man.c Man.h Movable.h Sprite.h Movable.h Chars.h \
	ScanKeys.h Stage.h VVram.h Sound.h Main.h 
Monster.asm: Monster.c Monster.h Movable.h Stages.h Stage.h Sprite.h \
	Movable.h Chars.h Math.h Man.h Movable.h Stage.h \
	Math.h Main.h 
Movable.asm: Movable.c Movable.h Stage.h 
Sprite.asm: Sprite.c Sprite.h Movable.h Chars.h VVram.h Vram.h 
Stage.asm: Stage.c Stage.h Stages.h Stage.h Main.h VVram.h \
	Sprite.h Movable.h Status.h Chars.h CopyMemory.h Man.h \
	Movable.h Monster.h Movable.h Math.h Sound.h Vram.h 
Stages.asm: Stages.c Stage.h Stages.h Stage.h 
Status.asm: Status.c Status.h Vram.h Stage.h Main.h Sprite.h \
	Movable.h Print.h Chars.h 
Vram.asm: Vram.c Vram.h Chars.h 
VVram.asm: VVram.c VVram.h Sprite.h Movable.h Vram.h Chars.h 
Chars.obj: Chars.asm 
CopyMemory.obj: CopyMemory.asm 
FixedCode.obj: FixedCode.asm 
Math.obj: Math.asm 
Print.obj: Print.asm 
ScanKeys.obj: ScanKeys.asm 
Sound.obj: Sound.asm 
StageA.obj: StageA.asm 
Startup.obj: Startup.asm FixedCode.inc 
VramA.obj: VramA.asm FixedCode.inc Vram.inc VVram.inc Chars.inc 
VramTrans.obj: VramTrans.asm 
VVramA.obj: VVramA.asm VVram.inc 

objects = Startup.obj \
	Main.obj Man.obj Monster.obj Movable.obj Sprite.obj Stage.obj \
	Stages.obj Status.obj Vram.obj VVram.obj Chars.obj CopyMemory.obj \
	FixedCode.obj Math.obj Print.obj ScanKeys.obj Sound.obj StageA.obj \
	VramA.obj VVramA.obj \
	..\..\cate\cate80.lib

FixedCode.bin: VramTrans.obj makefile
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
