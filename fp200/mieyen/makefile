name=mieyen

all: $(name).wav

cseg=8935 # call 35125
dseg=a600

.c.asm:
	Cate80i.exe $*.c

.asm.obj:
	Asm80i.exe $*.asm

Fire.asm: Fire.c Fire.h Movable.h Sprite.h Movable.h Chars.h \
	Man.h Movable.h Monster.h Movable.h Point.h Movable.h 
Main.asm: Main.c Main.h Status.h ScanKeys.h Stage.h Sprite.h \
	Movable.h Man.h Movable.h Monster.h Movable.h Fire.h \
	Movable.h Point.h Movable.h VVram.h Vram.h 
Man.asm: Man.c Man.h Movable.h Sprite.h Movable.h Chars.h \
	Stage.h ScanKeys.h Fire.h Movable.h Main.h VVram.h 
Monster.asm: Monster.c Monster.h Movable.h Stage.h Stages.h Stage.h \
	Sprite.h Movable.h Chars.h Math.h Status.h Main.h \
	Man.h Movable.h 
Movable.asm: Movable.c Movable.h Stage.h Sprite.h Movable.h 
Point.asm: Point.c Point.h Movable.h Sprite.h Movable.h Main.h \
	Chars.h VVram.h 
Sprite.asm: Sprite.c Sprite.h Movable.h Chars.h VVram.h Vram.h 
Stage.asm: Stage.c Stage.h Stages.h Stage.h Main.h Math.h \
	Sprite.h Movable.h Status.h Chars.h VVram.h CopyMemory.h \
	Man.h Movable.h Monster.h Movable.h Fire.h Movable.h \
	Point.h Movable.h Vram.h 
Stages.asm: Stages.c Stage.h Stages.h Stage.h 
Status.asm: Status.c Status.h Vram.h Main.h Sprite.h Movable.h \
	Print.h Chars.h 
Vram.asm: Vram.c Vram.h 
VVram.asm: VVram.c VVram.h Sprite.h Movable.h Vram.h Chars.h \
	Point.h Movable.h 
Chars.obj: Chars.asm 
CopyMemory.obj: CopyMemory.asm 
Math.obj: Math.asm 
Print.obj: Print.asm 
ScanKeys.obj: ScanKeys.asm 
StageA.obj: StageA.asm Vram.inc 
Startup.obj: Startup.asm 
VramA.obj: VramA.asm Vram.inc VVram.inc 
VVramA.obj: VVramA.asm VVram.inc 

objects = Startup.obj \
	Fire.obj Main.obj Man.obj Monster.obj Movable.obj Point.obj \
	Sprite.obj Stage.obj Stages.obj Status.obj Vram.obj VVram.obj \
	Chars.obj CopyMemory.obj Math.obj Print.obj ScanKeys.obj StageA.obj \
	VramA.obj VVramA.obj \
	..\..\cate\cate80i.lib

$(name).bin: $(objects) makefile
	LinkLE.exe $(name).bin $(cseg) $(dseg) $(objects)

$(name).wav: $(name).bin fp200wav.csx
	dotnet script fp200wav.csx $(name)
