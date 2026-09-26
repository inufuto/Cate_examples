name=uchotos

all: $(name).d88

cseg=0000
dseg=3000

.c.asm:
	Cate86.exe $*.c

.asm.obj:
	Asm86.exe -v2 $*.asm

Debri.asm: Debri.c Debri.h Movable.h Sprite.h Movable.h Chars.h \
	Stage.h Movable.h Vram.h 
Fire.asm: Fire.c Fire.h Movable.h Sprite.h Movable.h Man.h \
	Movable.h Chars.h Monster.h Movable.h Stage.h Movable.h \
	Main.h Sound.h ScanKeys.h Vram.h 
Main.asm: Main.c Main.h Status.h ScanKeys.h VVram.h Stage.h \
	Movable.h Man.h Movable.h Monster.h Movable.h Fire.h \
	Movable.h Debri.h Movable.h Sound.h Sprite.h Movable.h 
Man.asm: Man.c Man.h Movable.h ScanKeys.h Chars.h Sprite.h \
	Movable.h Stage.h Movable.h Fire.h Movable.h Sound.h \
	Main.h Status.h OneUp.h Movable.h 
Monster.asm: Monster.c Monster.h Movable.h Sprite.h Movable.h Stage.h \
	Movable.h Chars.h Math.h Man.h Movable.h Debri.h \
	Movable.h OneUp.h Movable.h Vram.h 
Movable.asm: Movable.c Movable.h Stage.h Movable.h 
OneUp.asm: OneUp.c OneUp.h Movable.h Sprite.h Movable.h Chars.h \
	Math.h Main.h Stage.h Movable.h Sound.h Status.h 
Sprite.asm: Sprite.c Movable.h Sprite.h Movable.h Vram.h VVram.h \
	Chars.h 
Stage.asm: Stage.c Stage.h Movable.h Stages.h Stage.h Movable.h \
	Main.h Math.h Chars.h VVram.h Status.h Man.h \
	Movable.h Monster.h Movable.h Fire.h Movable.h Debri.h \
	Movable.h Sprite.h Movable.h OneUp.h Movable.h Vram.h 
Stages.asm: Stages.c Stage.h Movable.h Stages.h Stage.h Movable.h 
Status.asm: Status.c Status.h Vram.h Stage.h Movable.h Main.h \
	Sprite.h Movable.h Print.h Chars.h 
Vram.asm: Vram.c Vram.h Chars.h 
VVram.asm: VVram.c VVram.h Sprite.h Movable.h Vram.h 
Chars.obj: Chars.asm 
Loader.obj: Loader.asm BinSize.inc 
Math.obj: Math.asm 
Print.obj: Print.asm 
ScanKeys.obj: ScanKeys.asm 
Sound.obj: Sound.asm 
StageA.obj: StageA.asm VVram.inc 
Startup.obj: Startup.asm Segment.inc 
VramA.obj: VramA.asm Vram.inc VVram.inc Chars.inc 
VVramA.obj: VVramA.asm VVram.inc 

objects = Startup.obj \
	Debri.obj Fire.obj Main.obj Man.obj Monster.obj Movable.obj \
	OneUp.obj Sprite.obj Stage.obj Stages.obj Status.obj Vram.obj \
	VVram.obj Chars.obj Math.obj Print.obj ScanKeys.obj Sound.obj \
	StageA.obj VramA.obj VVramA.obj \
	..\..\cate\cate86.lib

$(name).bin: $(objects) makefile
	LinkLE.exe $(name).bin $(cseg) $(dseg) $(objects)

BinSize.inc: $(name).bin BinSize.csx
	dotnet script BinSize.csx $(name) 

loader.obj: loader.asm BinSize.inc

loader.bin: loader.obj makefile
	LinkLE.exe loader.bin 0000 0000 loader.obj
	copy loader.bin debug.bin /y

$(name).d88: $(name).bin loader.bin
	dotnet script disk.csx $(name)
