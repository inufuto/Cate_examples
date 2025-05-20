name=mazy2

tap=$(name)_MVNSB1B2B3.tap

all: $(tap) $(name)_cart.zip

t_cseg=1c00 # 7168 
t_dseg=5a00
r_cseg=a000-bfff,2000
r_dseg=1240-13ff,1bc0-1fff
zseg=00d0

.c.asm:
	Cate65.exe -v2 $*.c

.asm.obj:
	Asm65.exe $*.asm

Knife.asm: Knife.c Knife.h Movable.h Stages.h Stage.h Sprite.h \
	Movable.h Chars.h Man.h Movable.h Main.h Status.h \
	Sound.h Math.h Monster.h Movable.h Point.h Movable.h 
Main.asm: Main.c Main.h Vram.h Chars.h Status.h ScanKeys.h \
	Stage.h Sound.h Sprite.h Movable.h Man.h Movable.h \
	Monster.h Movable.h Knife.h Movable.h Point.h Movable.h \
	VVram.h 
Man.asm: Man.c Man.h Movable.h Sprite.h Movable.h Stage.h \
	Chars.h ScanKeys.h Knife.h Movable.h Sound.h VVram.h \
	Vram.h 
Monster.asm: Monster.c Monster.h Movable.h Stages.h Stage.h Sprite.h \
	Movable.h Chars.h Math.h Man.h Movable.h Knife.h \
	Movable.h Sound.h Point.h Movable.h 
Movable.asm: Movable.c Movable.h Stage.h 
Point.asm: Point.c Point.h Movable.h Sprite.h Movable.h Main.h \
	Chars.h 
Sprite.asm: Sprite.c Movable.h Sprite.h Movable.h VVram.h Chars.h \
	Vram.h Stage.h 
Stage.asm: Stage.c Stage.h Stages.h Stage.h Main.h Sprite.h \
	Movable.h VVram.h Status.h Man.h Movable.h Chars.h \
	Monster.h Movable.h Knife.h Movable.h Point.h Movable.h \
	Vram.h 
Stages.asm: Stages.c Stage.h Stages.h Stage.h 
Status.asm: Status.c Status.h Vram.h Stage.h Main.h Sprite.h \
	Movable.h Print.h Chars.h 
Vram.asm: Vram.c Vram.h 
VVram.asm: VVram.c VVram.h Sprite.h Movable.h Vram.h Chars.h \
	Stage.h 
Background.obj: Background.asm Chars.inc 
Chars.obj: Chars.asm 
MapToVVram.obj: MapToVVram.asm ZeroPage.inc VVram.inc Chars.inc 
Math.obj: Math.asm 
Print.obj: Print.asm 
RomHead.obj: RomHead.asm 
ScanKeys.obj: ScanKeys.asm ZeroPage.inc 
Sound.obj: Sound.asm ZeroPage.inc 
StageA.obj: StageA.asm ZeroPage.inc 
Startup.obj: Startup.asm Vram.inc ZeroPage.inc 
VramA.obj: VramA.asm Zeropage.inc Vram.inc VVram.inc Chars.inc 
VramB.obj: VramB.asm Zeropage.inc Vram.inc 
VramC.obj: VramC.asm Zeropage.inc Vram.inc Chars.inc 
VVramA.obj: VVramA.asm ZeroPage.inc VVram.inc 
ZeroPage.obj: ZeroPage.asm 

objects = Startup.obj Sound.obj \
	Knife.obj Main.obj Man.obj Monster.obj Movable.obj Point.obj \
	Sprite.obj Stage.obj Stages.obj Status.obj Vram.obj VVram.obj \
	Background.obj Chars.obj MapToVVram.obj Math.obj Print.obj ScanKeys.obj \
	StageA.obj VramA.obj VramB.obj VramC.obj VVramA.obj \
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
