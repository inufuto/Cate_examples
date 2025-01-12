name=mieyen

tap=$(name)_MVNSB1B2B3.tap

all: $(tap) $(name)_cart.zip

t_cseg=1c00 # 7168 
t_dseg=5000
r_cseg=a000-bfff,2000
r_dseg=1240-13ff,1bc0-1fff
zseg=00d0

.c.asm:
	Cate65.exe -v2 $*.c

.asm.obj:
	Asm65.exe $*.asm

Fire.asm: Fire.c Fire.h Movable.h Sprite.h Movable.h Sound.h \
	Chars.h Man.h Movable.h Monster.h Movable.h Point.h \
	Movable.h 
Main.asm: Main.c Main.h Status.h ScanKeys.h Stage.h Sprite.h \
	Movable.h Sound.h Man.h Movable.h Monster.h Movable.h \
	Fire.h Movable.h Point.h Movable.h VVram.h 
Man.asm: Man.c Man.h Movable.h Sprite.h Movable.h Chars.h \
	Stage.h ScanKeys.h Sound.h Fire.h Movable.h Main.h \
	VVram.h 
Monster.asm: Monster.c Monster.h Movable.h Stage.h Stages.h Stage.h \
	Sprite.h Movable.h Chars.h Math.h Status.h Main.h \
	Sound.h Man.h Movable.h 
Movable.asm: Movable.c Movable.h Stage.h Sprite.h Movable.h 
Point.asm: Point.c Point.h Movable.h Sprite.h Movable.h Main.h \
	Chars.h VVram.h 
Sprite.asm: Sprite.c Movable.h Sprite.h Movable.h VVram.h Chars.h \
	Vram.h Stage.h 
Stage.asm: Stage.c Stage.h Stages.h Stage.h Main.h Math.h \
	Sprite.h Movable.h Status.h Chars.h VVram.h CopyMemory.h \
	Man.h Movable.h Monster.h Movable.h Fire.h Movable.h \
	Point.h Movable.h Vram.h 
Stages.asm: Stages.c Stage.h Stages.h Stage.h 
Status.asm: Status.c Status.h Vram.h Stage.h Main.h Sprite.h \
	Movable.h Print.h Chars.h CopyMemory.h 
Vram.asm: Vram.c Vram.h Chars.h 
VVram.asm: VVram.c VVram.h Sprite.h Movable.h Vram.h Chars.h \
	Stage.h Point.h Movable.h 
Background.obj: Background.asm Chars.inc 
Chars.obj: Chars.asm 
CopyMemory.obj: CopyMemory.asm ZeroPage.inc 
Math.obj: Math.asm 
Print.obj: Print.asm 
RomHead.obj: RomHead.asm 
ScanKeys.obj: ScanKeys.asm ZeroPage.inc 
Sound.obj: Sound.asm ZeroPage.inc 
StageA.obj: StageA.asm ZeroPage.inc VVram.inc Chars.inc 
Startup.obj: Startup.asm Vram.inc ZeroPage.inc 
VramA.obj: VramA.asm Zeropage.inc Vram.inc VVram.inc Chars.inc 
VramB.obj: VramB.asm Zeropage.inc Vram.inc 
VramC.obj: VramC.asm Zeropage.inc Vram.inc Chars.inc 
VVramA.obj: VVramA.asm ZeroPage.inc VVram.inc 
ZeroPage.obj: ZeroPage.asm 

objects = Startup.obj \
	Fire.obj Main.obj Man.obj Monster.obj Movable.obj Point.obj \
	Sprite.obj Stage.obj Stages.obj Status.obj Vram.obj VVram.obj \
	Background.obj Chars.obj CopyMemory.obj Math.obj Print.obj ScanKeys.obj \
	Sound.obj StageA.obj VramA.obj VramB.obj VramC.obj VVramA.obj \
	ZeroPage.obj \
	..\..\cate\cate65.lib

$(name).t64: $(objects) makefile
	linkLE.exe $(name).t64 $(t_cseg) $(t_dseg) $(zseg) $(objects)
	copy $(name).symbols.txt $(name).tape.symbols.txt /y

$(tap): $(name).t64
	prg2wav -s -m vicntsc -0  $(tap) $(name).t64

$(name).bin: RomHead.obj $(objects) makefile
	LinkLE $(name).bin $(r_cseg) $(r_dseg) $(zseg) RomHead.obj $(objects)
	copy $(name).symbols.txt $(name).rom.symbols.txt /y

$(name)_cart.zip: $(name).bin VicRom.csx cart_contents.txt
	dotnet script VicRom.csx $(name).bin
	cartconv -t vic20 -i $(name)-A000.prg -i $(name)-2000.prg -o $(name).crt
	7z a $(name)_cart.zip $(name)-A000.prg $(name)-2000.prg $(name).crt $(name)-A000.rom $(name)-2000.rom cart_contents.txt
