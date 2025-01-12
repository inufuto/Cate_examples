name=mieyen

all: $(name).rom

cseg=9ff9-9fff,bff9-bfff,8000-9ff8,a000
dseg=2800
zseg=0080

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
Chars.obj: Chars.asm 
CopyMemory.obj: CopyMemory.asm ZeroPage.inc 
DisplayList.obj: DisplayList.asm Vram.inc 
LeftHead.obj: LeftHead.asm 
Math.obj: Math.asm 
Print.obj: Print.asm 
RightHead.obj: RightHead.asm 
ScanKeys.obj: ScanKeys.asm atari800.inc ZeroPage.inc 
Sound.obj: Sound.asm atari800.inc Zeropage.inc 
Sprite.obj: Sprite.asm atari800.inc Vram.inc ZeroPage.inc 
StageA.obj: StageA.asm ZeroPage.inc 
Startup.obj: Startup.asm atari800.inc Vram.inc ZeroPage.inc 
VramA.obj: VramA.asm Zeropage.inc Atari800.inc Vram.inc Chars.inc 
ZeroPage.obj: ZeroPage.asm 

objects = RightHead.obj LeftHead.obj DisplayList.obj Startup.obj \
	Fire.obj Main.obj Man.obj Monster.obj Movable.obj Point.obj \
	Stage.obj Stages.obj Status.obj Vram.obj Chars.obj CopyMemory.obj \
	Math.obj Print.obj ScanKeys.obj Sound.obj Sprite.obj StageA.obj \
	VramA.obj ZeroPage.obj \
	..\..\cate\cate65.lib

$(name).rom: $(objects) makefile
	LinkLE.exe $(name).bin $(cseg) $(dseg) $(zseg) $(objects)
	copy $(name).bin $(name).rom /y
