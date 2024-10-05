name=cacorm

all: $(name).bin

cseg=8000-8201,4000
dseg=0380
zseg=00d0

.c.asm:
	Cate65.exe -65c02 -v2 $*.c

.asm.obj:
	Asm65.exe -65c02 $*.asm

Actor.asm: Actor.c Movable.h Actor.h 
Increaser.asm: Increaser.c Movable.h Increaser.h Sprite.h Movable.h Chars.h 
Item.asm: Item.c Item.h Stage.h Stages.h Vram.h Chars.h \
	Line.h Sound.h Movable.h Point.h Movable.h Sprite.h \
	Movable.h Main.h Increaser.h Math.h 
Line.asm: Line.c Line.h Stage.h Vram.h Movable.h Actor.h \
	Sound.h Sprite.h Movable.h Item.h Monster.h 
Main.asm: Main.c Main.h ScanKeys.h Vram.h Sound.h Status.h \
	Movable.h Actor.h Stage.h Sprite.h Movable.h Man.h \
	Actor.h Monster.h Item.h Point.h Movable.h 
Man.asm: Man.c Movable.h Actor.h Man.h Actor.h Sprite.h \
	Movable.h Stage.h ScanKeys.h Main.h Sound.h Chars.h \
	Line.h Item.h Vram.h Status.h Increaser.h Vram.h 
Monster.asm: Monster.c Movable.h Actor.h Monster.h Sprite.h Movable.h \
	Stage.h Chars.h Math.h Man.h Actor.h Line.h 
Movable.asm: Movable.c Movable.h Stage.h 
Point.asm: Point.c Point.h Movable.h Vram.h Main.h Stage.h 
Stage.asm: Stage.c Stage.h Stages.h Main.h Vram.h Movable.h \
	Actor.h Sprite.h Movable.h Chars.h CopyMemory.h Status.h \
	Man.h Actor.h Item.h Monster.h Point.h Movable.h \
	Increaser.h 
Stages.asm: Stages.c Stage.h Stages.h 
Status.asm: Status.c Status.h Vram.h Main.h Sprite.h Movable.h \
	Print.h Man.h Actor.h 
Vram.asm: Vram.c Vram.h 
Chars.obj: Chars.asm 
Math.obj: Math.asm 
Print.obj: Print.asm 
RomHead.obj: RomHead.asm 
ScanKeys.obj: ScanKeys.asm GameKing.inc 
Sound.obj: Sound.asm GameKing.inc ZeroPage.inc 
Sprite.obj: Sprite.asm GameKing.inc ZeroPage.inc Vram.inc 
StageA.obj: StageA.asm ZeroPage.inc 
Startup.obj: Startup.asm GameKing.inc 
VramA.obj: VramA.asm GameKing.inc ZeroPage.inc Vram.inc 
ZeroPage.obj: ZeroPage.asm 

objects = RomHead.obj Startup.obj \
	Actor.obj Increaser.obj Item.obj Line.obj Main.obj Man.obj \
	Monster.obj Movable.obj Point.obj Stage.obj Stages.obj Status.obj \
	Vram.obj Chars.obj Math.obj Print.obj ScanKeys.obj Sound.obj \
	Sprite.obj StageA.obj VramA.obj ZeroPage.obj \
	..\..\cate\cate65.lib

_raw.bin: $(objects) makefile
	LinkLE.exe _raw.bin $(cseg) $(dseg) $(zseg) $(objects)
	copy _raw.symbols.txt $(name).symbols.txt /y

$(name).bin: _raw.bin MakeRom.csx
	dotnet script MakeRom.csx $(name)
