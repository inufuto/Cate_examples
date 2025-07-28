name=yewdow

all: $(name).ram

cseg=9000
dseg=C200
fixed=C100

.c.asm:
	Cate80.exe $*.c

.asm.obj:
	Asm80.exe $*.asm

Actor.asm: Actor.c Movable.h Actor.h Movable.h Stage.h 
Car.asm: Car.c Car.h Actor.h Movable.h Chars.h Sprite.h \
	Movable.h Stage.h Stages.h Vram.h Item.h Man.h \
	Actor.h Movable.h Main.h Monster.h Actor.h Movable.h \
	Sound.h 
Item.asm: Item.c Item.h Stage.h VVram.h Chars.h Movable.h \
	Point.h Sound.h Main.h 
Main.asm: Main.c Main.h Status.h Movable.h ScanKeys.h Stage.h \
	Sound.h Man.h Actor.h Movable.h Sprite.h Movable.h \
	Item.h Car.h Actor.h Movable.h Monster.h Actor.h \
	Movable.h Point.h Vram.h 
Man.asm: Man.c Man.h Actor.h Movable.h ScanKeys.h Chars.h \
	Sprite.h Movable.h Stage.h Actor.h Movable.h Sound.h \
	Vram.h Monster.h Actor.h Movable.h 
Monster.asm: Monster.c Monster.h Actor.h Movable.h Stage.h Stages.h \
	Math.h Man.h Actor.h Movable.h Chars.h Sprite.h \
	Movable.h Point.h Sound.h 
Movable.asm: Movable.c Movable.h 
Point.asm: Point.c Movable.h Point.h Sprite.h Movable.h Main.h \
	Chars.h 
Sprite.asm: Sprite.c Sprite.h Movable.h Chars.h VVram.h Vram.h 
Stage.asm: Stage.c Stage.h Stages.h Main.h Sprite.h Movable.h \
	Vram.h Status.h Man.h Actor.h Movable.h Chars.h \
	Car.h Actor.h Movable.h Monster.h Actor.h Movable.h \
	Item.h Point.h 
Stages.asm: Stages.c Stage.h Stages.h 
Status.asm: Status.c Status.h Vram.h Stage.h Main.h Sprite.h \
	Movable.h Print.h Chars.h 
Vram.asm: Vram.c Vram.h Chars.h VVram.h Item.h Sprite.h \
	Movable.h Sound.h 
VVram.asm: VVram.c VVram.h Chars.h Sprite.h Movable.h Vram.h 
Chars.obj: Chars.asm 
FixedCode.obj: FixedCode.asm 
Math.obj: Math.asm 
Print.obj: Print.asm 
ScanKeys.obj: ScanKeys.asm 
Sound.obj: Sound.asm 
StageA.obj: StageA.asm 
Startup.obj: Startup.asm FixedCode.inc 
VramA.obj: VramA.asm FixedCode.inc Vram.inc VVram.inc Chars.inc 
VramTrans.obj: VramTrans.asm 
VVramA.obj: VVramA.asm VVram.inc Chars.inc 

FixedCode.bin: VramTrans.obj makefile
	LinkLE.exe FixedCode.bin $(fixed) F000 VramTrans.obj

FixedCode.asm FixedCode.inc: FixedCode.bin
	dotnet script BinAsm.csx

objects = Startup.obj \
	Actor.obj Car.obj Item.obj Main.obj Man.obj Monster.obj \
	Movable.obj Point.obj Sprite.obj Stage.obj Stages.obj Status.obj \
	Vram.obj VVram.obj Chars.obj Math.obj Print.obj ScanKeys.obj \
	Sound.obj StageA.obj VramA.obj VVramA.obj \
	FixedCode.obj \
	..\..\cate\cate80.lib

$(name).ram: $(objects) makefile
	LinkLE.exe $(name).ram $(cseg) $(dseg) $(objects)
