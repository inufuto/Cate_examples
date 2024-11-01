name=cacorm

all: $(name).bin

cseg=2000-2053,4000-9fff,2054-3fda,3fdc
dseg=0200
zseg=00d0

.c.asm:
	Cate85.exe $*.c

.asm.obj:
	Asm85.exe $*.asm

Actor.asm: Actor.c Movable.h Actor.h 
Increaser.asm: Increaser.c Movable.h Increaser.h Sprite.h Movable.h Chars.h 
Item.asm: Item.c Item.h Stage.h Stages.h VVram.h Chars.h \
	Line.h Sound.h Movable.h Point.h Sprite.h Movable.h \
	Main.h Increaser.h Math.h Vram.h 
Line.asm: Line.c Line.h Chars.h Stage.h VVram.h Movable.h \
	Actor.h Sound.h Sprite.h Movable.h Item.h Monster.h \
	Vram.h 
Main.asm: Main.c Main.h ScanKeys.h Vram.h Sound.h Status.h \
	Movable.h Actor.h Stage.h Sprite.h Movable.h Man.h \
	Monster.h Item.h Point.h 
Man.asm: Man.c Movable.h Actor.h Man.h Sprite.h Movable.h \
	Stage.h ScanKeys.h Main.h Sound.h Chars.h Line.h \
	Item.h Vram.h Status.h Increaser.h 
Monster.asm: Monster.c Movable.h Actor.h Monster.h Sprite.h Movable.h \
	Stage.h Chars.h Math.h Man.h Line.h 
Movable.asm: Movable.c Movable.h Stage.h 
Point.asm: Point.c Movable.h Point.h Sprite.h Movable.h Main.h \
	Chars.h 
Stage.asm: Stage.c Stage.h Stages.h Main.h VVram.h Movable.h \
	Actor.h Sprite.h Movable.h Chars.h CopyMemory.h Status.h \
	Man.h Item.h Monster.h Point.h Increaser.h Vram.h 
Stages.asm: Stages.c Stage.h Stages.h 
Status.asm: Status.c Status.h Vram.h Main.h Sprite.h Movable.h \
	Print.h Chars.h 
Vram.asm: Vram.c Vram.h Sprite.h Movable.h 
VVram.asm: VVram.c VVram.h Chars.h 
Math.obj: Math.asm 
Print.obj: Print.asm 
RomChars.obj: RomChars.asm 
RomHead.obj: RomHead.asm 
ScanKeys.obj: ScanKeys.asm GameCom.inc 
Sound.obj: Sound.asm GameCom.inc 
Sprite.obj: Sprite.asm GameCom.inc Vram.inc VVram.inc 
StageA.obj: StageA.asm 
Startup.obj: Startup.asm GameCom.inc Vram.inc 
Vectors.obj: Vectors.asm 
VramA.obj: VramA.asm GameCom.inc Vram.inc VVram.inc 
VVramA.obj: VVramA.asm VVram.inc 

objects = Vectors.obj RomHead.obj RomChars.obj Startup.obj \
	Actor.obj Increaser.obj Item.obj Line.obj Main.obj Man.obj \
	Monster.obj Movable.obj Point.obj Stage.obj Stages.obj Status.obj \
	Vram.obj VVram.obj Math.obj Print.obj ScanKeys.obj Sound.obj \
	Sprite.obj StageA.obj VramA.obj VVramA.obj \
	..\..\cate\cate85.lib

_.bin: $(objects) makefile
	LinkBE.exe _.bin $(cseg) $(dseg) $(zseg) $(objects)
	copy _.symbols.txt $(name).symbols.txt /y

$(name).bin: _.bin MakeRom.csx
	dotnet script MakeRom.csx $(name)
