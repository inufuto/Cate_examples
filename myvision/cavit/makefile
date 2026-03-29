name=cavit

all: $(name).rom

cseg=0000
dseg=a000

.c.asm:
	Cate80.exe $*.c

.asm.obj:
	Asm80.exe -v2 $*.asm

Main.asm: Main.c Main.h ScanKeys.h Sound.h Status.h Stage.h Sprite.h \
	Man.h Chaser.h Ghost.h Rock.h Point.h Box.h
Status.asm: Status.c Status.h Main.h Print.h Chars.h Sprite.h
Stages.asm: Stages.c Stages.h
Stage.asm: Stage.c Stage.h Stages.h Main.h Status.h Vram.h Sprite.h Chars.h \
	Man.h Box.h Rock.h Chaser.h Ghost.h Direction.h Point.h
Fixed.asm: Fixed.c Fixed.h
Box.h: Fixed.h
Box.asm: Box.c Box.h Stage.h Stages.h Vram.h Chars.h Sprite.h Point.h Man.h Sound.h
Rock.h: Fixed.h Movable.h
Rock.asm: Rock.c Rock.h Stage.h Stages.h Vram.h Chars.h Sprite.h Direction.h \
	Man.h Point.h Chaser.h Ghost.h Sound.h
Direction.asm: Direction.c Direction.h
Movable.asm: Movable.c Movable.h Sprite.h Stage.h Direction.h 
Man.h: Movable.h 
Man.asm: Man.c Man.h Movable.h Sprite.h Stage.h ScanKeys.h Direction.h Chars.h Vram.h \
	Rock.h Sound.h
Monster.h: Movable.h
Monster.asm: Monster.c Monster.h Stage.h Rock.h Sprite.h Chaser.h Ghost.h Man.h
Chaser.h: Monster.h
Chaser.asm: Chaser.c Chaser.h Sprite.h Stage.h Man.h Direction.h
Ghost.h: Monster.h
Ghost.asm: Ghost.c Ghost.h Sprite.h Stage.h Man.h Direction.h Main.h
Point.h: Movable.h
Point.asm: Point.c Point.h Sprite.h Main.h
Vram.asm: Vram.c Vram.h
Sprite.h: Movable.h

objects = startup.obj \
	Main.obj Status.obj Stages.obj Stage.obj Fixed.obj Box.obj Rock.obj \
	Direction.obj Movable.obj Man.obj Monster.obj Chaser.obj Ghost.obj Point.obj \
	Chars.obj Print.obj \
	ScanKeys.obj Vram.obj VramA.obj Sprite.obj Sound.obj \
	Vdp.obj \
	..\..\cate\cate80.lib

$(name).rom: $(objects) makefile
    linkle.exe $(name).rom $(cseg) $(dseg) $(objects)
