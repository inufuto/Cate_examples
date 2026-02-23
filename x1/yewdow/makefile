name=yewdow

all: $(name).tap $(name).d88

cseg=8100
dseg=B000 

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
	Vram.h 
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
Status.asm: Status.c Status.h Vram.h Main.h Print.h Chars.h \
	Sprite.h Movable.h 
Vram.asm: Vram.c Vram.h Chars.h VVram.h Item.h Sprite.h \
	Movable.h 
VVram.asm: VVram.c VVram.h Chars.h Sprite.h Movable.h Vram.h 
Chars.obj: Chars.asm 
chead.obj: chead.asm 
Math.obj: Math.asm 
Print.obj: Print.asm 
ScanKeys.obj: ScanKeys.asm 
Sound.obj: Sound.asm 
StageA.obj: StageA.asm 
Startup.obj: Startup.asm 
VramA.obj: VramA.asm Vram.inc VVram.inc 
VVramA.obj: VVramA.asm VVram.inc 

objects = Startup.obj \
	Actor.obj Car.obj Item.obj Main.obj Man.obj Monster.obj \
	Movable.obj Point.obj Sprite.obj Stage.obj Stages.obj Status.obj \
	Vram.obj VVram.obj Chars.obj Math.obj Print.obj ScanKeys.obj \
	Sound.obj StageA.obj VramA.obj VVramA.obj \
	..\..\cate\cate80.lib

$(name).bin: $(objects)
	LinkLE.exe $(name).bin $(cseg) $(dseg) $(objects)

$(name).wav: $(name).bin
	..\x1tape\x1tape -file2wav -filemode ipl -start 8100 -entry 8100 $(name).bin $(name).wav

$(name).tap: $(name).wav
	..\x1tape\x1tape -wav2tap $(name).wav $(name).tap

$(name).d88: $(name).bin Disk.csx
	dotnet script Disk.csx $(name) $(cseg)
