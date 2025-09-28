name=hopman

all: $(name).l3

cseg=4000
zseg=6c00 
dseg=6d00

.c.asm:
	Cate09.exe $*.c

.asm.obj:
	Asm09.exe -v2 $*.asm

Goal.asm: Goal.c Goal.h Movable.h Stage.h Movable.h Sprite.h \
	Movable.h Chars.h 
Lift.asm: Lift.c Lift.h Movable.h Stages.h Stage.h Movable.h \
	Chars.h Sprite.h Movable.h Vram.h Man.h Movable.h 
Main.asm: Main.c Main.h ScanKeys.h Vram.h Sound.h Sprite.h \
	Movable.h Status.h Stage.h Movable.h Man.h Movable.h \
	Lift.h Movable.h Monster.h Movable.h  
Man.asm: Man.c Man.h Movable.h Stage.h Movable.h Chars.h \
	Sprite.h Movable.h ScanKeys.h Sound.h Goal.h Movable.h \
	Stage.h Movable.h  Main.h Lift.h Movable.h 
Monster.asm: Monster.c Monster.h Movable.h Stages.h Stage.h Movable.h \
	Chars.h Sprite.h Movable.h Vram.h Man.h Movable.h 
Movable.asm: Movable.c Movable.h Stage.h Movable.h Lift.h Movable.h 
Sprite.asm: Sprite.c Movable.h Sprite.h Movable.h Vram.h  
Stage.asm: Stage.c Stage.h Movable.h Stages.h Stage.h Movable.h \
	Main.h Vram.h  Sprite.h Movable.h Status.h \
	CopyMemory.h Man.h Movable.h Goal.h Movable.h Stage.h \
	Movable.h Lift.h Movable.h Monster.h Movable.h 
Stages.asm: Stages.c Stage.h Movable.h Stages.h Stage.h Movable.h 
Status.asm: Status.c Status.h Vram.h Stage.h Movable.h Main.h \
	Sprite.h Movable.h Print.h Chars.h 
Vram.asm: Vram.c Vram.h Chars.h Movable.h Sprite.h Movable.h \
	Sound.h 
VVram.asm: VVram.c Vram.h  Chars.h Sprite.h Movable.h \
	Sound.h 
Chars.obj: Chars.asm 
CopyMemory.obj: CopyMemory.asm 
Loader.obj: Loader.asm S1.inc BinSize.inc
ScanKeys.obj: ScanKeys.asm 
Sound.obj: Sound.asm S1.inc 
SoundBeep.obj: SoundBeep.asm 
SoundOpn.obj: SoundOpn.asm 
StageA.obj: StageA.asm 
Startup.obj: Startup.asm S1.inc 
VramA.obj: VramA.asm S1.inc Vram.inc  Chars.inc 
VVramA.obj: VVramA.asm  


objects = Startup.obj \
	Goal.obj Lift.obj Main.obj Man.obj Monster.obj Movable.obj \
	Print.obj Sprite.obj Stage.obj Stages.obj Status.obj Vram.obj \
	Chars.obj CopyMemory.obj  ScanKeys.obj Sound.obj \
	 StageA.obj  VramA.obj\
	..\..\cate\cate09.lib

$(name).bin: $(objects) makefile
	LinkBE.exe $(name).bin $(cseg) $(dseg) $(zseg) $(objects)

BinSize.inc: $(name).bin BinSize.csx
	dotnet script BinSize.csx $(name)

$(name)_01.l3: Loader.obj makefile
	LinkBE.exe Loader.l3 d000 d200 d100 Loader.obj
	copy Loader.l3 $(name)_01.l3 /y

$(name)_02.l3: $(name).bin BinL3.csx
	dotnet script BinL3.csx $(name) $(cseg)

$(name).l3: $(name)_01.l3 $(name)_02.l3
	copy /b $(name)_01.l3+$(name)_02.l3 $(name).l3
