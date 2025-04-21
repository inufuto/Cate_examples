name=yewdow

all: $(name).wav

cseg=4000
dseg=8100

.c.asm:
	Cate80.exe $*.c

.asm.obj:
	Asm80.exe $*.asm

Actor.asm: Actor.c Movable.h Actor.h Movable.h Stage.h 
Car.asm: Car.c Car.h Actor.h Movable.h Chars.h Sprite.h \
	Movable.h Stage.h Stages.h Vram.h Item.h Man.h \
	Actor.h Movable.h Main.h Monster.h Actor.h Movable.h \
	Sound.h 
Item.asm: Item.c Item.h Stage.h Vram.h Chars.h Movable.h \
	Point.h Sound.h Main.h 
Main.asm: Main.c Main.h Status.h Movable.h ScanKeys.h Stage.h \
	Sound.h Man.h Actor.h Movable.h Sprite.h Movable.h \
	Item.h Car.h Actor.h Movable.h Monster.h Actor.h \
	Movable.h Point.h 
Man.asm: Man.c Man.h Actor.h Movable.h ScanKeys.h Chars.h \
	Sprite.h Movable.h Stage.h Actor.h Movable.h Sound.h \
	Vram.h Monster.h Actor.h Movable.h 
Monster.asm: Monster.c Monster.h Actor.h Movable.h Stage.h Stages.h \
	Math.h Man.h Actor.h Movable.h Chars.h Sprite.h \
	Movable.h Point.h Sound.h 
Movable.asm: Movable.c Movable.h 
Point.asm: Point.c Movable.h Point.h Sprite.h Movable.h Main.h \
	Chars.h 
Stage.asm: Stage.c Stage.h Stages.h Main.h Sprite.h Movable.h \
	Vram.h Status.h Man.h Actor.h Movable.h Chars.h \
	Car.h Actor.h Movable.h Monster.h Actor.h Movable.h \
	Item.h Point.h 
Stages.asm: Stages.c Stage.h Stages.h 
Status.asm: Status.c Status.h Vram.h Stage.h Main.h Sprite.h \
	Movable.h Print.h Chars.h 
Vram.asm: Vram.c Vram.h Chars.h 
Chars.obj: Chars.asm 
FixedCode.obj: FixedCode.asm 
Math.obj: Math.asm 
Plus.obj: Plus.asm 
Print.obj: Print.asm 
ScanKeys.obj: ScanKeys.asm 
Sound.obj: Sound.asm 
Sprite.obj: Sprite.asm Vram.inc Chars.inc FixedCode.inc 
StageA.obj: StageA.asm 
Startup.obj: Startup.asm FixedCode.inc 
VramA.obj: VramA.asm Vram.inc Chars.inc 

objects = Startup.obj \
	Actor.obj Car.obj Item.obj Main.obj Man.obj Monster.obj \
	Movable.obj Point.obj Stage.obj Stages.obj Status.obj Vram.obj \
	Chars.obj FixedCode.obj Math.obj Print.obj ScanKeys.obj Sound.obj \
	Sprite.obj StageA.obj VramA.obj \
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
