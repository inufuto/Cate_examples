name=cracky

all: $(name).bin

cseg=0000-1fff,4000
dseg=8000

.c.asm:
	Cate80.exe $*.c

.asm.obj:
	Asm80.exe -v2 $*.asm

Destruction.asm: Destruction.c Destruction.h Stage.h Movable.h Chars.h Vram.h 
Main.asm: Main.c Main.h ScanKeys.h Vram.h Sound.h Sprite.h \
	Movable.h Status.h Stage.h Movable.h Man.h Movable.h \
	Destruction.h Monster.h Movable.h 
Man.asm: Man.c Man.h Movable.h ScanKeys.h Chars.h Sprite.h \
	Movable.h Stage.h Movable.h Destruction.h Main.h Sound.h \
	Vram.h 
Monster.asm: Monster.c Monster.h Movable.h Stages.h Stage.h Movable.h \
	Sprite.h Movable.h Chars.h Math.h Man.h Movable.h 
Movable.asm: Movable.c Movable.h Stage.h Movable.h 
Sprite.asm: Sprite.c Sprite.h Movable.h Chars.h Vram.h Stage.h \
	Movable.h 
Stage.asm: Stage.c Stage.h Movable.h Stages.h Stage.h Movable.h \
	Main.h Vram.h Sprite.h Movable.h Chars.h Status.h \
	CopyMemory.h Man.h Movable.h Monster.h Movable.h Destruction.h 
Stages.asm: Stages.c Stage.h Movable.h Stages.h Stage.h Movable.h 
Status.asm: Status.c Status.h Vram.h Main.h Sprite.h Movable.h \
	Print.h Chars.h 
Vram.asm: Vram.c Vram.h Destruction.h Stage.h Movable.h Sprite.h \
	Movable.h 
Chars.obj: Chars.asm 
CopyMemory.obj: CopyMemory.asm 
Math.obj: Math.asm 
Print.obj: Print.asm 
ScanKeys.obj: ScanKeys.asm sv8000.inc 
Sound.obj: Sound.asm sv8000.inc 
StageA.obj: StageA.asm Chars.inc 
Startup.obj: Startup.asm sv8000.inc 
VramA.obj: VramA.asm sv8000.inc Vram.inc 

objects = Startup.obj \
	Destruction.obj Main.obj Man.obj Monster.obj Movable.obj Sprite.obj \
	Stage.obj Stages.obj Status.obj Vram.obj Chars.obj CopyMemory.obj \
	Math.obj Print.obj ScanKeys.obj Sound.obj StageA.obj VramA.obj \
	..\..\cate\cate80.lib

_.bin: $(objects) makefile
	LinkLE.exe _.bin $(cseg) $(dseg) $(objects)
	copy _.symbols.txt $(name).symbols.txt /y

$(name).bin: _.bin Divide.csx
	dotnet script Divide.csx $(name)
