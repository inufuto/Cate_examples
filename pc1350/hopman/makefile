name=hopman

all: $(name).wav

cseg=4000 # CALL 16384
dseg=6700

.c.asm:
	Cate61s.exe $*.c

.asm.obj:
	Asm61s.exe $*.asm

Goal.asm: Goal.c Goal.h Movable.h Stage.h Movable.h Vram.h \
	Sprite.h Movable.h VVram.h 
Lift.asm: Lift.c Lift.h Movable.h Stages.h Stage.h Movable.h \
	Sprite.h Movable.h Vram.h Man.h Movable.h 
Main.asm: Main.c Main.h ScanKeys.h Vram.h Sound.h Sprite.h \
	Movable.h Status.h Stage.h Movable.h Man.h Movable.h \
	Lift.h Movable.h Monster.h Movable.h VVram.h 
Man.asm: Man.c Man.h Movable.h Stage.h Movable.h Sprite.h \
	Movable.h ScanKeys.h Goal.h Movable.h Stage.h Movable.h \
	Vram.h Vram.h Main.h Lift.h Movable.h VVram.h \
	Sound.h 
Monster.asm: Monster.c Monster.h Movable.h Stages.h Stage.h Movable.h \
	Sprite.h Movable.h Vram.h Man.h Movable.h 
Movable.asm: Movable.c Movable.h Stage.h Movable.h Lift.h Movable.h 
Stage.asm: Stage.c Stage.h Movable.h Stages.h Stage.h Movable.h \
	Main.h Vram.h Sprite.h Movable.h Status.h CopyMemory.h \
	Man.h Movable.h Goal.h Movable.h Stage.h Movable.h \
	Vram.h Lift.h Movable.h Monster.h Movable.h VVram.h 
Stages.asm: Stages.c Stage.h Movable.h Stages.h Stage.h Movable.h 
Status.asm: Status.c Status.h Vram.h Main.h Sprite.h Movable.h \
	Print.h Man.h Movable.h 
Vram.asm: Vram.c Vram.h 
VVram.asm: VVram.c VVram.h Sprite.h Movable.h Vram.h Sound.h \
	Goal.h Movable.h Stage.h Movable.h Vram.h 
CopyMemory.obj: CopyMemory.asm InternalRam.inc 
Print.obj: Print.asm InternalRam.inc 
ScanKeys.obj: ScanKeys.asm InternalRam.inc 
Sound.obj: Sound.asm InternalRam.inc 
Sprite.obj: Sprite.asm InternalRam.inc Vram.inc VVram.inc 
StageA.obj: StageA.asm InternalRam.inc Vram.inc VVram.inc 
Startup.obj: Startup.asm InternalRam.inc 
VramA.obj: VramA.asm InternalRam.inc Vram.inc VVram.inc 
VVramA.obj: VVramA.asm InternalRam.inc VVram.inc 

objects = Startup.obj \
	Goal.obj Lift.obj Main.obj Man.obj Monster.obj Movable.obj \
	Stage.obj Stages.obj Status.obj Vram.obj VVram.obj CopyMemory.obj \
	Print.obj ScanKeys.obj Sound.obj Sprite.obj StageA.obj VramA.obj \
	VVramA.obj \
	..\..\cate\cate61s.lib

$(name).bin: $(objects) makefile
	LinkLE.exe $(name).bin $(cseg) $(dseg) $(objects)

$(name).wav: $(name).bin makefile
	bin2wav.exe --pc=1350 --addr=0x$(cseg) $(name).bin
