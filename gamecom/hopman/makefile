name=hopman

all: $(name).bin

cseg=2000-2053,4000-9fff,2054-3fda,3fdc
dseg=0200
zseg=00d0

.c.asm:
	Cate85.exe $*.c

.asm.obj:
	Asm85.exe $*.asm

Goal.asm: Goal.c Goal.h Movable.h Stage.h Movable.h Sprite.h \
	Movable.h Chars.h 
Lift.asm: Lift.c Lift.h Movable.h Stages.h Stage.h Movable.h \
	Chars.h Sprite.h Movable.h VVram.h Man.h Movable.h 
Main.asm: Main.c Main.h ScanKeys.h Vram.h Sound.h Sprite.h \
	Movable.h Status.h Stage.h Movable.h Man.h Movable.h \
	Lift.h Movable.h Monster.h Movable.h 
Man.asm: Man.c Man.h Movable.h Stage.h Movable.h Chars.h \
	Sprite.h Movable.h ScanKeys.h Sound.h Goal.h Movable.h \
	Stage.h Movable.h VVram.h Main.h Lift.h Movable.h \
	Vram.h 
Monster.asm: Monster.c Monster.h Movable.h Stages.h Stage.h Movable.h \
	Chars.h Sprite.h Movable.h VVram.h Man.h Movable.h 
Movable.asm: Movable.c Movable.h Stage.h Movable.h Lift.h Movable.h 
Stage.asm: Stage.c Stage.h Movable.h Stages.h Stage.h Movable.h \
	Main.h Vram.h VVram.h Sprite.h Movable.h Status.h \
	CopyMemory.h Man.h Movable.h Goal.h Movable.h Stage.h \
	Movable.h Lift.h Movable.h Monster.h Movable.h 
Stages.asm: Stages.c Stage.h Movable.h Stages.h Stage.h Movable.h 
Status.asm: Status.c Status.h Vram.h Main.h Sprite.h Movable.h \
	Print.h Chars.h 
Vram.asm: Vram.c Vram.h Sprite.h Movable.h Stage.h Movable.h \
	VVram.h 
CopyMemory.obj: CopyMemory.asm 
Print.obj: Print.asm 
RomChars.obj: RomChars.asm 
RomHead.obj: RomHead.asm 
ScanKeys.obj: ScanKeys.asm GameCom.inc 
Sound.obj: Sound.asm GameCom.inc 
Sprite.obj: Sprite.asm GameCom.inc Vram.inc VVram.inc 
StageA.obj: StageA.asm 
Startup.obj: Startup.asm GameCom.inc Vram.inc 
Vectors.obj: Vectors.asm 
VramA.obj: VramA.asm GameCom.inc Vram.inc VVram.inc 
VVramA.obj: VVramA.asm Vram.inc VVram.inc Chars.inc 

objects = Vectors.obj RomHead.obj RomChars.obj Startup.obj \
	Goal.obj Lift.obj Main.obj Man.obj Monster.obj Movable.obj \
	Stage.obj Stages.obj Status.obj Vram.obj CopyMemory.obj Print.obj \
	ScanKeys.obj Sound.obj Sprite.obj StageA.obj VramA.obj VVramA.obj \
	..\..\cate\cate85.lib

_.bin: $(objects) makefile
	LinkBE.exe _.bin $(cseg) $(dseg) $(zseg) $(objects)
	copy _.symbols.txt $(name).symbols.txt /y

$(name).bin: _.bin MakeRom.csx
	dotnet script MakeRom.csx $(name)
