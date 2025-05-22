name=mazy2

all: $(name).a78

cseg=fff8-ffff,c000-cfff,8000-bfff,d000
dseg=1e00-203F,2100-213f,0070-00ff,0140
zseg=0040

.c.asm:
	Cate65.exe -v2 $*.c

.asm.obj:
	Asm65.exe $*.asm

Knife.asm: Knife.c Knife.h Movable.h Stages.h Stage.h Sprite.h \
	Movable.h Chars.h Man.h Movable.h Main.h Status.h \
	Sound.h Math.h Monster.h Movable.h Point.h Movable.h 
Main.asm: Main.c Main.h Vram.h Chars.h Status.h ScanKeys.h \
	Stage.h Sound.h Sprite.h Movable.h Man.h Movable.h \
	Monster.h Movable.h Knife.h Movable.h Point.h Movable.h 
Man.asm: Man.c Man.h Movable.h Sprite.h Movable.h Stage.h \
	Chars.h ScanKeys.h Knife.h Movable.h Sound.h 
Monster.asm: Monster.c Monster.h Movable.h Stages.h Stage.h Sprite.h \
	Movable.h Chars.h Math.h Man.h Movable.h Knife.h \
	Movable.h Sound.h Point.h Movable.h 
Movable.asm: Movable.c Movable.h Stage.h 
Point.asm: Point.c Point.h Movable.h Sprite.h Movable.h Main.h \
	Chars.h 
Stage.asm: Stage.c Stage.h Stages.h Stage.h Main.h Sprite.h \
	Movable.h Vram.h Status.h Man.h Movable.h Chars.h \
	Monster.h Movable.h Knife.h Movable.h Point.h Movable.h 
Stages.asm: Stages.c Stage.h Stages.h Stage.h 
Status.asm: Status.c Status.h Vram.h Main.h Print.h Chars.h \
	Sprite.h Movable.h 
Vram.asm: Vram.c Vram.h Chars.h 
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
	Knife.obj Main.obj Man.obj Monster.obj Movable.obj Point.obj \
	Stage.obj Stages.obj Status.obj Vram.obj Math.obj Print.obj \
	ScanKeys.obj Sound.obj Sprite.obj StageA.obj VramA.obj ZeroPage.obj \
	..\..\cate\cate65.lib

$(name).bin: $(objects) makefile
	LinkLE.exe $(name).bin $(cseg) $(dseg) $(zseg) $(objects)
	7800sign -w $(name).bin

$(name).a78: $(name).bin A78.csx
	dotnet script A78.csx $(name)
