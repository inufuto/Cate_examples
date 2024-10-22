name=cavit

all: $(name).bin

cseg=0000
dseg=c0a0

.c.asm:
	Cate83.exe $*.c

.asm.obj:
	Asm83.exe $*.asm

Box.asm: Box.c Box.h Fixed.h Stage.h Stages.h Vram.h \
	Chars.h Sprite.h Movable.h Point.h Movable.h Man.h \
	Movable.h Sound.h 
Chaser.asm: Chaser.c Chaser.h Monster.h Movable.h Sprite.h Movable.h \
	Stage.h Man.h Movable.h Direction.h Chars.h 
Direction.asm: Direction.c Direction.h 
Fixed.asm: Fixed.c Fixed.h 
Ghost.asm: Ghost.c Ghost.h Monster.h Movable.h Sprite.h Movable.h \
	Stage.h Man.h Movable.h Direction.h Main.h Chars.h 
Main.asm: Main.c Main.h ScanKeys.h Sprite.h Movable.h Vram.h \
	Sound.h Status.h Stage.h Man.h Movable.h Chaser.h \
	Monster.h Movable.h Ghost.h Monster.h Movable.h Rock.h \
	Fixed.h Movable.h Point.h Movable.h Box.h Fixed.h 
Man.asm: Man.c Man.h Movable.h Movable.h Sprite.h Movable.h \
	Stage.h ScanKeys.h Direction.h Chars.h Vram.h Rock.h \
	Fixed.h Movable.h Sound.h 
Monster.asm: Monster.c Monster.h Movable.h Stage.h Rock.h Fixed.h \
	Movable.h Sprite.h Movable.h Chaser.h Monster.h Movable.h \
	Ghost.h Monster.h Movable.h Man.h Movable.h 
Movable.asm: Movable.c Movable.h Sprite.h Movable.h Stage.h Direction.h 
Point.asm: Point.c Point.h Movable.h Sprite.h Movable.h Main.h \
	Chars.h 
Rock.asm: Rock.c Rock.h Fixed.h Movable.h Stage.h Stages.h \
	Vram.h Chars.h Sprite.h Movable.h Direction.h Man.h \
	Movable.h Point.h Movable.h Chaser.h Monster.h Movable.h \
	Ghost.h Monster.h Movable.h Sound.h 
Stage.asm: Stage.c Stage.h Stages.h Main.h Status.h Vram.h \
	Sprite.h Movable.h Chars.h Man.h Movable.h Box.h \
	Fixed.h Rock.h Fixed.h Movable.h Chaser.h Monster.h \
	Movable.h Ghost.h Monster.h Movable.h Direction.h Point.h \
	Movable.h 
Stages.asm: Stages.c Stages.h 
Status.asm: Status.c Status.h Vram.h Main.h Sprite.h Movable.h \
	Print.h Chars.h 
Vram.asm: Vram.c Vram.h 
Chars.obj: Chars.asm 
Print.obj: Print.asm 
ScanKeys.obj: ScanKeys.asm MegaDuck.inc 
Sound.obj: Sound.asm MegaDuck.inc 
Sprite.obj: Sprite.asm MegaDuck.inc Vram.inc 
StageA.obj: StageA.asm 
Startup.obj: Startup.asm MegaDuck.inc Vram.inc 
VramA.obj: VramA.asm MegaDuck.inc Vram.inc Chars.inc 

objects = startup.obj \
	Box.obj Chaser.obj Direction.obj Fixed.obj Ghost.obj Main.obj \
	Man.obj Monster.obj Movable.obj Point.obj Rock.obj Stage.obj \
	Stages.obj Status.obj Vram.obj Chars.obj Print.obj ScanKeys.obj \
	Sound.obj Sprite.obj StageA.obj VramA.obj \
	..\..\cate\cate83.lib

$(name).bin: $(objects) makefile
	LinkLE.exe $(name).bin $(cseg) $(dseg) $(objects)
