name=svellas

all: $(name).wav

cseg=4500
dseg=6100

.c.asm:
	Cate80.exe $*.c

.asm.obj:
	Asm80.exe $*.asm

Main.asm: Main.c Main.h Status.h ScanKeys.h Stage.h Man.h \
	Movable.h Sound.h Sprite.h Movable.h Monster.h Movable.h \
	VVram.h Vram.h 
Man.asm: Man.c Man.h Movable.h Sprite.h Movable.h Chars.h \
	ScanKeys.h Stage.h VVram.h Sound.h Main.h 
Monster.asm: Monster.c Monster.h Movable.h Stages.h Stage.h Sprite.h \
	Movable.h Chars.h Math.h Man.h Movable.h Stage.h \
	Math.h Main.h 
Movable.asm: Movable.c Movable.h Stage.h 
Sprite.asm: Sprite.c Sprite.h Movable.h Chars.h VVram.h Vram.h 
Stage.asm: Stage.c Stage.h Stages.h Stage.h Main.h VVram.h \
	Sprite.h Movable.h Status.h Chars.h CopyMemory.h Man.h \
	Movable.h Monster.h Movable.h Math.h Sound.h Vram.h 
Stages.asm: Stages.c Stage.h Stages.h Stage.h 
Status.asm: Status.c Status.h Vram.h Main.h Print.h Chars.h 
Vram.asm: Vram.c Vram.h 
VVram.asm: VVram.c VVram.h Sprite.h Movable.h Vram.h Chars.h \
	Sound.h 
Chars.obj: Chars.asm 
CopyMemory.obj: CopyMemory.asm 
Math.obj: Math.asm 
Print.obj: Print.asm 
ScanKeys.obj: ScanKeys.asm 
Sound.obj: Sound.asm 
StageA.obj: StageA.asm 
Startup.obj: Startup.asm 
VramA.obj: VramA.asm Vram.inc VVram.inc 
VVramA.obj: VVramA.asm VVram.inc 

objects = Startup.obj \
	Main.obj Man.obj Monster.obj Movable.obj Sprite.obj Stage.obj \
	Stages.obj Status.obj Vram.obj VVram.obj Chars.obj CopyMemory.obj \
	Math.obj Print.obj ScanKeys.obj Sound.obj StageA.obj VramA.obj \
	VVramA.obj \
	..\..\cate\cate80.lib

$(name).bin: $(objects) makefile
	LinkLE.exe $(name).bin $(cseg) $(dseg) $(objects)

$(name).cas: $(name).bin bincas.csx
	dotnet script bincas.csx $(name) $(cseg)

$(name).wav: $(name).cas
	cas2wav $(name).cas
