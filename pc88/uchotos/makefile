name=uchotos

nameV1=$(name)_v1
nameV2=$(name)_v2

all: $(nameV1).cmt $(nameV1).d88 $(nameV2).d88

cseg=0100
dseg=2c00

.c.asm:
	Cate80.exe $*.c

.asm.obj:
	Asm80.exe -v2 $*.asm

Debri.asm: Debri.c Debri.h Movable.h Sprite.h Movable.h Chars.h \
	Stage.h Movable.h 
Fire.asm: Fire.c Fire.h Movable.h Sprite.h Movable.h Man.h \
	Movable.h Chars.h Monster.h Movable.h Stage.h Movable.h \
	Main.h Sound.h ScanKeys.h 
Main.asm: Main.c Main.h Status.h ScanKeys.h Stage.h Movable.h \
	Man.h Movable.h Monster.h Movable.h Fire.h Movable.h \
	Debri.h Movable.h Sound.h VVram.h 
Man.asm: Man.c Man.h Movable.h ScanKeys.h Chars.h Sprite.h \
	Movable.h Stage.h Movable.h Fire.h Movable.h Sound.h \
	Main.h Status.h OneUp.h Movable.h 
Monster.asm: Monster.c Monster.h Movable.h Sprite.h Movable.h Stage.h \
	Movable.h Chars.h Math.h Man.h Movable.h Debri.h \
	Movable.h OneUp.h Movable.h 
Movable.asm: Movable.c Movable.h Stage.h Movable.h 
OneUp.asm: OneUp.c OneUp.h Movable.h Sprite.h Movable.h Chars.h \
	Math.h Main.h Stage.h Movable.h Sound.h Status.h 
Sprite.asm: Sprite.c Movable.h Sprite.h Movable.h Vram.h VVram.h \
	Chars.h 
Stage.asm: Stage.c Stage.h Movable.h Stages.h Stage.h Movable.h \
	Main.h Math.h Chars.h VVram.h Status.h Man.h \
	Movable.h Monster.h Movable.h Fire.h Movable.h Debri.h \
	Movable.h Sprite.h Movable.h OneUp.h Movable.h Vram.h 
Stages.asm: Stages.c Stage.h Movable.h Stages.h Stage.h Movable.h 
Status.asm: Status.c Status.h Vram.h Stage.h Movable.h Main.h \
	Sprite.h Movable.h Print.h Chars.h 
Vram.asm: Vram.c Vram.h Chars.h 
VVram.asm: VVram.c VVram.h Sprite.h Movable.h Vram.h Sound.h 
Chars.obj: Chars.asm 
CharsV1.obj: CharsV1.asm 
CharsV2.obj: CharsV2.asm 
CopyBank.obj: CopyBank.asm BinSize.inc 
Loader1.obj: Loader1.asm LoaderCode.inc 
Loader2.obj: Loader2.asm BinSize.inc 
LoaderCode.obj: LoaderCode.asm 
Math.obj: Math.asm 
Print.obj: Print.asm 
ScanKeysV1.obj: ScanKeysV1.asm 
ScanKeysV2.obj: ScanKeysV2.asm 
SoundV1.obj: SoundV1.asm 
SoundV2.obj: SoundV2.asm 
SpritePatternV2.obj: SpritePatternV2.asm 
StageA.obj: StageA.asm Vram.inc 
Startup.obj: Startup.asm 
VramV1.obj: VramV1.asm Vram.inc VVram.inc Chars.inc 
VramV2.obj: VramV2.asm Vram.inc VVram.inc Chars.inc 
VVramA.obj: VVramA.asm VVram.inc 

objects = Startup.obj \
	Debri.obj Fire.obj Main.obj Man.obj Monster.obj Movable.obj \
	OneUp.obj Sprite.obj Stage.obj Stages.obj Status.obj Vram.obj \
	VVram.obj Chars.obj Math.obj Print.obj StageA.obj VVramA.obj \
	..\..\cate\cate80.lib

objectsV1 = $(objects) CharsV1.obj VramV1.obj SoundV1.obj ScanKeysV1.obj
	
objectsV2 = $(objects) CharsV2.obj VramV2.obj SoundV2.obj ScanKeysV2.obj SpritePatternV2.obj

$(nameV1).bin: $(objectsV1) makefile
	LinkLE.exe $(nameV1).bin $(cseg) $(dseg) $(objectsV1)

$(nameV2).bin: $(objectsV2) makefile
	LinkLE.exe $(nameV2).bin $(cseg) $(dseg) $(objectsV2)

BinSize.inc: $(nameV2).bin BinSize.csx
	dotnet script BinSize.csx $(nameV2) $(cseg)

CopyBank.bin: CopyBank.obj makefile
	LinkLE.exe CopyBank.bin 9000 9100 CopyBank.obj

~$(nameV1).bin: CopyBank.bin $(nameV1).bin
	copy /b /y CopyBank.bin+$(nameV1).bin ~$(nameV1).bin

~$(nameV2).bin: CopyBank.bin $(nameV2).bin
	copy /b /y CopyBank.bin+$(nameV2).bin ~$(nameV2).bin

Loader2.bin: Loader2.obj makefile
	LinkLE.exe Loader2.bin E000 E200 Loader2.obj

LoaderCode.asm LoaderCode.inc: Loader2.bin BinAsm.csx
	dotnet script BinAsm.csx

Loader1.bin: Loader1.obj LoaderCode.obj makefile
	LinkLE.exe Loader1.bin C000 C200 Loader1.obj LoaderCode.obj

$(nameV1).d88: ~$(nameV1).bin Loader1.bin
	dotnet script disk.csx $(nameV1)

$(nameV2).d88: ~$(nameV2).bin Loader1.bin
	dotnet script disk.csx $(nameV2)

$(nameV1).cmt: ~$(nameV1).bin cmt.csx
	dotnet script cmt.csx $(nameV1)
