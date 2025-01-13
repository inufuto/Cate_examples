name=mieyen

all: $(name).a78

cseg=fff8-ffff,c000-cfff,8000-bfff,d000
dseg=1e00-203F,2100-213f,0070-00ff,0140
zseg=0040

.c.asm:
	Cate65.exe -v2 $*.c

.asm.obj:
	Asm65.exe $*.asm

Fire.asm: Fire.c Fire.h Movable.h Sprite.h Movable.h Sound.h \
	Chars.h Man.h Movable.h Monster.h Movable.h Point.h \
	Movable.h 
Main.asm: Main.c Main.h Status.h ScanKeys.h Stage.h Sprite.h \
	Movable.h Sound.h Man.h Movable.h Monster.h Movable.h \
	Fire.h Movable.h Point.h Movable.h 
Man.asm: Man.c Man.h Movable.h Sprite.h Movable.h Chars.h \
	Stage.h ScanKeys.h Sound.h Fire.h Movable.h Main.h 
Monster.asm: Monster.c Monster.h Movable.h Stage.h Stages.h Stage.h \
	Sprite.h Movable.h Chars.h Math.h Status.h Main.h \
	Sound.h Man.h Movable.h 
Movable.asm: Movable.c Movable.h Stage.h Sprite.h Movable.h 
Point.asm: Point.c Point.h Movable.h Sprite.h Movable.h Main.h \
	Chars.h 
Stage.asm: Stage.c Stage.h Stages.h Stage.h Main.h Math.h \
	Sprite.h Movable.h Status.h Chars.h Vram.h CopyMemory.h \
	Man.h Movable.h Monster.h Movable.h Fire.h Movable.h \
	Point.h Movable.h 
Stages.asm: Stages.c Stage.h Stages.h Stage.h 
Status.asm: Status.c Status.h Vram.h Main.h Print.h Chars.h \
	Sprite.h Movable.h 
Vram.asm: Vram.c Vram.h Chars.h 
CopyMemory.obj: CopyMemory.asm ZeroPage.inc 
DisplayList.obj: DisplayList.asm Atari7800.inc ZeroPage.inc Vram.inc 
Math.obj: Math.asm 
Print.obj: Print.asm 
RomChars.obj: RomChars.asm 
RomSprites.obj: RomSprites.asm 
ScanKeys.obj: ScanKeys.asm Atari7800.inc ZeroPage.inc 
Sound.obj: Sound.asm Atari7800.inc ZeroPage.inc 
Sprite.obj: Sprite.asm Atari7800.inc ZeroPage.inc Vram.inc 
StageA.obj: StageA.asm ZeroPage.inc 
Startup.obj: Startup.asm Atari7800.inc 
Vectors.obj: Vectors.asm 
VramA.obj: VramA.asm Atari7800.inc ZeroPage.inc Vram.inc 
ZeroPage.obj: ZeroPage.asm 

objects = Vectors.obj RomSprites.obj RomChars.obj DisplayList.obj Startup.obj \
	Fire.obj Main.obj Man.obj Monster.obj Movable.obj Point.obj \
	Stage.obj Stages.obj Status.obj Vram.obj CopyMemory.obj Math.obj \
	Print.obj ScanKeys.obj Sound.obj Sprite.obj StageA.obj VramA.obj \
	ZeroPage.obj \
	..\..\cate\cate65.lib

$(name).bin: $(objects) makefile
	LinkLE.exe $(name).bin $(cseg) $(dseg) $(zseg) $(objects)
	7800sign -w $(name).bin

$(name).a78: $(name).bin A78.csx
	dotnet script A78.csx $(name)
