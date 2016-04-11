# A Makefile for booting os9


all: boot.dsk rom.img


rom.img: rom.asm
	lwasm -fraw -orom.img -mrom.map rom.asm

boot.dsk: test.bin AUTOEXEC.BAS
	rm -f boot.dsk
	decb dskini boot.dsk
#	decb copy -b -2 boot.bin boot.dsk,BOOT.BIN
	decb copy -b -2 test.bin boot.dsk,TEST.BIN
	decb copy -a -0 -l AUTOEXEC.BAS boot.dsk,AUTOEXEC.BAS


boot.bin: boot.asm sd.asm
	lwasm -mboot.map -oboot.bin boot.asm

test.bin: boot.asm sd.asm test.lnk
	lwasm -fobj -oboot.o boot.asm
	lwasm -fobj -osd.o   sd.asm
	lwlink -mtest.map -otest.bin -stest.lnk -b boot.o sd.o


clean: 
	rm -f boot.dsk boot.bin *.o test.bin rom.img
