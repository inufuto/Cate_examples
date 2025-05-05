name=mazy2

nameV1=$(name)_v1
nameV2=$(name)_v2

all: $(nameV1).cmt $(nameV1).d88 $(nameV2).d88

cseg=9000
dseg=c200

.c.asm:
	Cate80.exe $*.c

.asm.obj:
	Asm80.exe $*.asm

Knife.asm: Knife.c Knife.h Movable.h Stages.h Stage.h Sprite.h \
	Movable.h Chars.h Man.h Movable.h Main.h Status.h \
	Sound.h Math.h Monster.h Movable.h Point.h Movable.h 
Main.asm: Main.c Main.h Vram.h Chars.h Status.h ScanKeys.h \
	Stage.h Sound.h Sprite.h Movable.h Man.h Movable.h \
	Monster.h Movable.h Knife.h Movable.h Point.h Movable.h \
	VVram.h 
Man.asm: Man.c Man.h Movable.h Sprite.h Movable.h Stage.h \
	Chars.h ScanKeys.h Knife.h Movable.h Sound.h VVram.h 
Monster.asm: Monster.c Monster.h Movable.h Stages.h Stage.h Sprite.h \
	Movable.h Chars.h Math.h Man.h Movable.h Knife.h \
	Movable.h Sound.h Point.h Movable.h 
Movable.asm: Movable.c Movable.h Stage.h 
Point.asm: Point.c Point.h Movable.h Sprite.h Movable.h Main.h \
	Chars.h 
Sprite.asm: Sprite.c Sprite.h Movable.h Chars.h VVram.h Vram.h 
Stage.asm: Stage.c Stage.h Stages.h Stage.h Main.h Sprite.h \
	Movable.h VVram.h Status.h Man.h Movable.h Chars.h \
	Monster.h Movable.h Knife.h Movable.h Point.h Movable.h \
	Vram.h 
Stages.asm: Stages.c Stage.h Stages.h Stage.h 
Status.asm: Status.c Status.h Vram.h Stage.h Main.h Sprite.h \
	Movable.h Print.h Chars.h 
Vram.asm: Vram.c Vram.h 
VVram.asm: VVram.c VVram.h Sprite.h Movable.h Vram.h Chars.h \
	Sound.h 
Chars.obj: Chars.asm 
Loader1.obj: Loader1.asm LoaderCode.inc 
Loader2.obj: Loader2.asm BinSize.inc 
LoaderCode.obj: LoaderCode.asm 
Math.obj: Math.asm 
Print.obj: Print.asm 
ScanKeys.obj: ScanKeys.asm 
SoundV1.obj: SoundV1.asm 
SoundV2.obj: SoundV2.asm 
StageA.obj: StageA.asm 
Startup.obj: Startup.asm 
VramA.obj: VramA.asm Vram.inc VVram.inc Chars.inc 
VramV1.obj: VramV1.asm Vram.inc VVram.inc Chars.inc 
VramV2.obj: VramV2.asm Vram.inc VVram.inc Chars.inc 
VVramA.obj: VVramA.asm VVram.inc 

objects = VramA.obj \
	Knife.obj Main.obj Man.obj Monster.obj Movable.obj Point.obj \
	Sprite.obj Stage.obj Stages.obj Status.obj Vram.obj VVram.obj \
	Chars.obj Math.obj Print.obj ScanKeys.obj StageA.obj VVramA.obj \
	..\..\cate\cate80.lib

objectsV1 = Startup.obj VramV1.obj SoundV1.obj \
	$(objects)

objectsV2 = Startup.obj VramV2.obj SoundV2.obj \
	$(objects)

$(nameV1).cmt: $(objectsV1) makefile
	LinkLE.exe $(nameV1).cmt $(cseg) $(dseg) $(objectsV1)

$(nameV1).bin: $(objectsV1) makefile
	LinkLE.exe $(nameV1).bin $(cseg) $(dseg) $(objectsV1)

$(nameV2).bin: $(objectsV2) makefile
	LinkLE.exe $(nameV2).bin $(cseg) $(dseg) $(objectsV2)

BinSize.inc: $(nameV1).bin $(nameV2).bin BinSize.csx
	dotnet script BinSize.csx $(name)

Loader2.bin: Loader2.obj makefile
	LinkLE.exe Loader2.bin E000 E200 Loader2.obj

LoaderCode.asm LoaderCode.inc: Loader2.bin BinAsm.csx
	dotnet script BinAsm.csx

Loader1.bin: Loader1.obj LoaderCode.obj makefile
	LinkLE.exe Loader1.bin C000 C200 Loader1.obj LoaderCode.obj

$(nameV1).d88: $(nameV1).bin Loader1.bin
	dotnet script disk.csx $(nameV1)

$(nameV2).d88: $(nameV2).bin Loader1.bin
	dotnet script disk.csx $(nameV2)
