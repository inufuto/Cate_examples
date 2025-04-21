name=lift

all: $(name).wav

cseg=4000
dseg=8100

.c.asm:
	Cate80.exe $*.c

.asm.obj:
	Asm80.exe $*.asm

Actor.asm: Actor.c Movable.h Actor.h Stage.h Lift.h 
Item.asm: Item.c Item.h Stage.h Stages.h Vram.h Chars.h \
	Main.h Movable.h Actor.h Man.h Point.h Movable.h \
	Sound.h Sprite.h 
Lift.asm: Lift.c Movable.h Actor.h Lift.h Stage.h Stages.h \
	Vram.h Chars.h Sprite.h Man.h Monster.h 
Main.asm: Main.c Main.h ScanKeys.h Movable.h Sprite.h Vram.h \
	Sound.h Status.h Stage.h Actor.h Monster.h Lift.h \
	Man.h Item.h Point.h Movable.h 
Man.asm: Man.c Movable.h Actor.h Man.h Stage.h Sprite.h \
	Chars.h ScanKeys.h Item.h Sound.h 
Math.asm: Math.c Math.h 
Monster.asm: Monster.c Movable.h Actor.h Monster.h Stages.h Stage.h \
	Sprite.h Chars.h Man.h Lift.h 
Movable.asm: Movable.c Movable.h Stage.h Actor.h Lift.h 
Point.asm: Point.c Point.h Movable.h Sprite.h Main.h Chars.h 
Print.asm: Print.c Print.h Vram.h 
Stage.asm: Stage.c Stage.h Stages.h Main.h Vram.h Movable.h \
	Sprite.h Chars.h Status.h Item.h Actor.h Man.h \
	Lift.h Monster.h Point.h Movable.h 
Stages.asm: Stages.c Stage.h Stages.h 
Status.asm: Status.c Status.h Vram.h Stage.h Main.h Movable.h \
	Sprite.h Print.h Chars.h 
Vram.asm: Vram.c Vram.h Chars.h 
Chars.obj: Chars.asm 
FixedCode.obj: FixedCode.asm 
Plus.obj: Plus.asm 
ScanKeys.obj: ScanKeys.asm 
Sound.obj: Sound.asm 
Sprite.obj: Sprite.asm Vram.inc Chars.inc FixedCode.inc 
Startup.obj: Startup.asm FixedCode.inc 
VramA.obj: VramA.asm Vram.inc Chars.inc 

objects = Startup.obj \
	Actor.obj Item.obj Lift.obj Main.obj Man.obj Math.obj \
	Monster.obj Movable.obj Point.obj Print.obj Stage.obj Stages.obj \
	Status.obj Vram.obj Chars.obj FixedCode.obj ScanKeys.obj Sound.obj \
	Sprite.obj VramA.obj \
	..\..\cate\cate80.lib

$(name).bin: $(objects) makefile
	LinkLE.exe $(name).bin $(cseg) $(dseg) $(objects)

FixedCode.bin: Plus.obj makefile
	LinkLE.exe FixedCode.bin 8000 b000 Plus.obj

FixedCode.asm FixedCode.inc: FixedCode.bin BinAsm.csx
	dotnet script BinAsm.csx

$(name).cdt: $(name).bin loader.bas
	2cdt.exe -n -r $(name) loader.bas $(name).cdt
	2cdt.exe -r BIN $(name).bin $(name).cdt

$(name).wav: $(name).cdt
	TZX2WAV $(name).cdt $(name).wav
