name=hopman

all: $(name).ram

cseg=9000
dseg=C200
fixed=C100

.c.asm:
	Cate80.exe $*.c

.asm.obj:
	Asm80.exe $*.asm

Goal.asm: Goal.c Goal.h Movable.h Stage.h Movable.h Vram.h \
	Sprite.h Movable.h Chars.h VVram.h 
Lift.asm: Lift.c Lift.h Movable.h Stages.h Stage.h Movable.h \
	Chars.h Sprite.h Movable.h Vram.h Man.h Movable.h 
Main.asm: Main.c Main.h ScanKeys.h Vram.h Sound.h Sprite.h \
	Movable.h Status.h Stage.h Movable.h Math.h Man.h \
	Movable.h Lift.h Movable.h Monster.h Movable.h VVram.h 
Man.asm: Man.c Man.h Movable.h Stage.h Movable.h Chars.h \
	Sprite.h Movable.h ScanKeys.h Sound.h Goal.h Movable.h \
	Stage.h Movable.h Vram.h Vram.h Main.h Lift.h \
	Movable.h VVram.h 
Monster.asm: Monster.c Monster.h Movable.h Stages.h Stage.h Movable.h \
	Chars.h Sprite.h Movable.h Vram.h Man.h Movable.h 
Movable.asm: Movable.c Movable.h Stage.h Movable.h Lift.h Movable.h \
	Math.h Vram.h 
Sprite.asm: Sprite.c Sprite.h Movable.h Chars.h VVram.h Vram.h \
	Stage.h Movable.h 
Stage.asm: Stage.c Stage.h Movable.h Stages.h Stage.h Movable.h \
	Main.h Vram.h Math.h Sprite.h Movable.h Status.h \
	CopyMemory.h Man.h Movable.h Goal.h Movable.h Stage.h \
	Movable.h Vram.h Lift.h Movable.h Monster.h Movable.h \
	VVram.h 
Stages.asm: Stages.c Stage.h Movable.h Stages.h Stage.h Movable.h 
Status.asm: Status.c Status.h Vram.h Stage.h Movable.h Main.h \
	Sprite.h Movable.h Print.h Chars.h 
Vram.asm: Vram.c Vram.h 
VVram.asm: VVram.c VVram.h Chars.h Sprite.h Movable.h Vram.h \
	Goal.h Movable.h Stage.h Movable.h Vram.h Sound.h 
Chars.obj: Chars.asm 
CopyMemory.obj: CopyMemory.asm 
Math.obj: Math.asm 
Print.obj: Print.asm 
ScanKeys.obj: ScanKeys.asm 
Sound.obj: Sound.asm 
StageA.obj: StageA.asm 
Startup.obj: Startup.asm  FixedCode.inc
VramA.obj: VramA.asm Vram.inc VVram.inc Chars.inc 
VVramA.obj: VVramA.asm VVram.inc Vram.inc Chars.inc 

FixedCode.bin: VramTrans.obj makefile
	LinkLE.exe FixedCode.bin $(fixed) F000 VramTrans.obj

FixedCode.asm FixedCode.inc: FixedCode.bin
	dotnet script binasm.csx

objects = Startup.obj \
	Goal.obj Lift.obj Main.obj Man.obj Monster.obj Movable.obj \
	Sprite.obj Stage.obj Stages.obj Status.obj Vram.obj VVram.obj \
	Chars.obj CopyMemory.obj  Math.obj Print.obj ScanKeys.obj \
	Sound.obj StageA.obj  VramA.obj VVramA.obj \
	FixedCode.obj \
	..\..\cate\cate80.lib

$(name).ram: $(objects) makefile
	LinkLE.exe $(name).ram $(cseg) $(dseg) $(objects)
