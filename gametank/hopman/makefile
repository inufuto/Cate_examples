name=hopman

all: $(name).gtr

cseg=fffa-ffff,c000
dseg=0200
zseg=0000

.c.asm:
	Cate65.exe -65c02 -v2 $*.c

.asm.obj:
	Asm65.exe -65c02 $*.asm

Goal.asm: Goal.c Goal.h Movable.h Stage.h Movable.h Sprite.h \
	Movable.h Chars.h 
Lift.asm: Lift.c Lift.h Movable.h Stages.h Stage.h Movable.h \
	Chars.h Sprite.h Movable.h Vram.h VVram.h Man.h \
	Movable.h 
Main.asm: Main.c Main.h ScanKeys.h Vram.h VVram.h Sound.h \
	Sprite.h Movable.h Status.h Stage.h Movable.h Man.h \
	Movable.h Lift.h Movable.h Monster.h Movable.h VVram.h 
Man.asm: Man.c Man.h Movable.h Stage.h Movable.h Chars.h \
	Sprite.h Movable.h ScanKeys.h Sound.h Goal.h Movable.h \
	Stage.h Movable.h VVram.h Main.h Lift.h Movable.h 
Monster.asm: Monster.c Monster.h Movable.h Stages.h Stage.h Movable.h \
	Chars.h Sprite.h Movable.h Vram.h VVram.h Man.h \
	Movable.h 
Movable.asm: Movable.c Movable.h Stage.h Movable.h Lift.h Movable.h 
Sprite.asm: Sprite.c Movable.h Sprite.h Movable.h Vram.h VVram.h \
	Stage.h Movable.h 
Stage.asm: Stage.c Stage.h Movable.h Stages.h Stage.h Movable.h \
	Main.h Vram.h VVram.h VVram.h Sprite.h Movable.h \
	Status.h CopyMemory.h Man.h Movable.h Goal.h Movable.h \
	Stage.h Movable.h Lift.h Movable.h Monster.h Movable.h 
Stages.asm: Stages.c Stage.h Movable.h Stages.h Stage.h Movable.h 
Status.asm: Status.c Status.h Vram.h VVram.h Main.h Print.h \
	Chars.h Sprite.h Movable.h 
Vram.asm: Vram.c Vram.h VVram.h 
VVram.asm: VVram.c Vram.h VVram.h VVram.h Chars.h Sprite.h \
	Movable.h Sound.h Stage.h Movable.h 
Chars.obj: Chars.asm 
CopyMemory.obj: CopyMemory.asm ZeroPage.inc 
Print.obj: Print.asm 
ScanKeys.obj: ScanKeys.asm gametank.inc 
Sound.obj: Sound.asm ZeroPage.inc gametank.inc SubBin.inc 
StageA.obj: StageA.asm ZeroPage.inc 
Startup.obj: Startup.asm ZeroPage.inc gametank.inc 
SubBin.obj: SubBin.asm 
SubMain.obj: SubMain.asm 
Vectors.obj: Vectors.asm 
VramA.obj: VramA.asm ZeroPage.inc gametank.inc Vram.inc VVram.inc Chars.inc 
VVramA.obj: VVramA.asm ZeroPage.inc Vram.inc VVram.inc VVram.inc Chars.inc 
ZeroPage.obj: ZeroPage.asm 

objects = Vectors.obj Startup.obj \
	Goal.obj Lift.obj Main.obj Man.obj Monster.obj Movable.obj \
	Sprite.obj Stage.obj Stages.obj Status.obj Vram.obj VVram.obj \
	Chars.obj CopyMemory.obj Print.obj ScanKeys.obj Sound.obj StageA.obj \
	SubBin.obj VramA.obj VVramA.obj ZeroPage.obj \
	..\..\cate\cate65.lib

$(name).bin: $(objects) makefile
	LinkLE.exe $(name).bin $(cseg) $(dseg) $(zseg) $(objects)

SubBin.bin: SubMain.obj makefile
	LinkLE.exe SubBin.bin 0200 3f00 0010 SubMain.obj

SubBin.asm SubBin.inc: SubBin.bin BinAsm.csx
	dotnet script BinAsm.csx

$(name).gtr: $(name).bin MakeRom.csx
	dotnet script MakeRom.csx $(name)
