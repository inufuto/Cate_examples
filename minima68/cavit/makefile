name=cavit

filename=$(name).bin

all: $(filename)

cseg=0100
dseg=3400
zseg=0000

.c.asm:
	Cate68.exe $*.c

.asm.obj:
	Asm68.exe -v2 $*.asm

Box.asm: Box.c Box.h Fixed.h Stage.h Stages.h Chars.h \
	Sprite.h Point.h Movable.h Man.h Movable.h Sound.h 
Chaser.asm: Chaser.c Chaser.h Monster.h Movable.h Sprite.h Stage.h \
	Man.h Movable.h Direction.h Chars.h 
Direction.asm: Direction.c Direction.h 
Fixed.asm: Fixed.c Fixed.h 
Ghost.asm: Ghost.c Ghost.h Monster.h Movable.h Sprite.h Stage.h \
	Man.h Movable.h Direction.h Main.h Chars.h 
Main.asm: Main.c Main.h ScanKeys.h Sprite.h Vram.h Sound.h \
	Status.h Stage.h Man.h Movable.h Chaser.h Monster.h \
	Movable.h Ghost.h Monster.h Movable.h Rock.h Fixed.h \
	Movable.h Point.h Movable.h Box.h Fixed.h 
Man.asm: Man.c Man.h Movable.h Movable.h Sprite.h Stage.h \
	ScanKeys.h Direction.h Chars.h Vram.h Rock.h Fixed.h \
	Movable.h Sound.h 
Monster.asm: Monster.c Monster.h Movable.h Stage.h Rock.h Fixed.h \
	Movable.h Sprite.h Chaser.h Monster.h Movable.h Ghost.h \
	Monster.h Movable.h Man.h Movable.h 
Movable.asm: Movable.c Movable.h Sprite.h Stage.h Direction.h 
Point.asm: Point.c Point.h Movable.h Sprite.h Main.h Chars.h 
Rock.asm: Rock.c Rock.h Fixed.h Movable.h Stage.h Stages.h \
	Vram.h Chars.h Sprite.h Direction.h Man.h Movable.h \
	Point.h Movable.h Chaser.h Monster.h Movable.h Ghost.h \
	Monster.h Movable.h Sound.h 
Stage.asm: Stage.c Stage.h Stages.h Main.h Status.h Sprite.h \
	Chars.h Man.h Movable.h Box.h Fixed.h Rock.h \
	Fixed.h Movable.h Chaser.h Monster.h Movable.h Ghost.h \
	Monster.h Movable.h Direction.h Point.h Movable.h Vram.h 
Stages.asm: Stages.c Stages.h 
Status.asm: Status.c Status.h Vram.h Stage.h Main.h Sprite.h \
	Print.h Chars.h 
Vram.asm: Vram.c Vram.h Chars.h 
Chars.obj: Chars.asm 
Print.obj: Print.asm 
ScanKeys.obj: ScanKeys.asm 
Sound.obj: Sound.asm 
Sprite.obj: Sprite.asm Direct.inc  Vram.inc 
Startup.obj: Startup.asm Vram.inc 
VramA.obj: VramA.asm Direct.inc  Vram.inc Chars.inc 

objects = Startup.obj \
	Box.obj Chaser.obj Direction.obj Fixed.obj Ghost.obj Main.obj \
	Man.obj Monster.obj Movable.obj Point.obj Rock.obj Stage.obj \
	Stages.obj Status.obj Vram.obj Chars.obj Print.obj ScanKeys.obj \
	Sound.obj Sprite.obj VramA.obj \
	..\..\cate\cate68.lib

$(filename): $(objects) makefile
	LinkBE.exe $(filename) $(cseg) $(dseg) $(zseg) $(objects)
