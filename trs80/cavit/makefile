name=cavit

all: $(name).wav

cseg=4500
dseg=6500

.c.asm:
	Cate80.exe $*.c

.asm.obj:
	Asm80.exe -v2 $*.asm

Box.asm: Box.c Box.h Fixed.h Stage.h Stages.h VVram.h \
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
	Fixed.h Movable.h Point.h Movable.h Box.h Fixed.h \
	VVram.h 
Man.asm: Man.c Man.h Movable.h Movable.h Sprite.h Movable.h \
	Stage.h ScanKeys.h Direction.h Chars.h VVram.h Rock.h \
	Fixed.h Movable.h Sound.h 
Monster.asm: Monster.c Monster.h Movable.h Stage.h Rock.h Fixed.h \
	Movable.h Sprite.h Movable.h Chaser.h Monster.h Movable.h \
	Ghost.h Monster.h Movable.h Man.h Movable.h 
Movable.asm: Movable.c Movable.h Sprite.h Movable.h Stage.h Direction.h 
Point.asm: Point.c Point.h Movable.h Sprite.h Movable.h Main.h \
	Chars.h 
Rock.asm: Rock.c Rock.h Fixed.h Movable.h Stage.h Stages.h \
	VVram.h Chars.h Sprite.h Movable.h Direction.h Man.h \
	Movable.h Point.h Movable.h Chaser.h Monster.h Movable.h \
	Ghost.h Monster.h Movable.h Sound.h Main.h 
Sprite.asm: Sprite.c Sprite.h Movable.h Chars.h VVram.h Vram.h 
Stage.asm: Stage.c Stage.h Stages.h Main.h Status.h Vram.h \
	Sprite.h Movable.h Chars.h Man.h Movable.h Box.h \
	Fixed.h Rock.h Fixed.h Movable.h Chaser.h Monster.h \
	Movable.h Ghost.h Monster.h Movable.h Direction.h Point.h \
	Movable.h VVram.h 
Stages.asm: Stages.c Stages.h 
Status.asm: Status.c Status.h Vram.h Main.h Sprite.h Movable.h \
	Print.h Chars.h 
Vram.asm: Vram.c Vram.h 
VVram.asm: VVram.c VVram.h Chars.h Sprite.h Movable.h Vram.h 
Chars.obj: Chars.asm 
Print.obj: Print.asm 
ScanKeys.obj: ScanKeys.asm  
Sound.obj: Sound.asm  
Startup.obj: Startup.asm  
VramA.obj: VramA.asm  Vram.inc VVram.inc 
VVramA.obj: VVramA.asm Vram.inc VVram.inc 

objects = Startup.obj \
	Main.obj Status.obj Stages.obj Stage.obj Fixed.obj Box.obj Rock.obj \
	Direction.obj Movable.obj Man.obj Monster.obj Chaser.obj Ghost.obj Point.obj \
	Chars.obj Print.obj VVram.obj VVramA.obj \
	ScanKeys.obj Vram.obj VramA.obj Sprite.obj Sound.obj  \
	..\..\cate\cate80.lib

$(name).bin: $(objects) makefile
	LinkLE.exe $(name).bin $(cseg) $(dseg) $(objects)

$(name).cas: $(name).bin bincas.csx
	dotnet script bincas.csx $(name) $(cseg)

$(name).wav: $(name).cas
	cas2wav $(name).cas
