OS = Linux

# indicate the Hardware Image file
HDA_IMG = ./tools/hdc-0.11.img

#
# if you want the ram-disk device, define this to be the
# size in blocks.
#
RAMDISK =  #-DRAMDISK=512

# This is a basic Makefile for setting the general configuration
include ./include/Makefile.header

LDFLAGS	+= -Ttext 0 -e startup_32
CFLAGS	+= $(RAMDISK) -Iinclude
CPP	+= -Iinclude

#
# ROOT_DEV specifies the default root-device when making the image.
# This can be either FLOPPY, /dev/xxxx or empty, in which case the
# default of /dev/hd6 is used by 'build'.
#
ROOT_DEV= #FLOPPY 

.c.s:
	@$(CC) $(CFLAGS) -S -o $*.s $<
.s.o:
	@$(AS)  -o $*.o $<
.c.o:
	@$(CC) $(CFLAGS) -c -o $*.o $<

all:	Image	

Image: boot/bootsect boot/setup tools/system
	@cp -f tools/system system.tmp
	@$(STRIP) system.tmp
	@$(OBJCOPY) -O binary -R .note -R .comment system.tmp tools/kernel
	@tools/build.sh boot/bootsect boot/setup tools/kernel Image $(ROOT_DEV)
	@rm system.tmp
	@rm -f tools/kernel
	@sync

boot/setup: boot/setup.s
	@make setup -C boot
boot/bootsect: boot/bootsect.s
	@make bootsect -C boot

SYSTEM_OBJS = boot/head.o init/main.o kernel/console.o kernel/tty_io.o \
			  kernel/ctype.o kernel/sched.o kernel/keyboard.o \
			  kernel/printk.o kernel/vsprintf.o kernel/string.o \
			  kernel/system_call.o kernel/traps.o kernel/signal.o \
			  kernel/undefined.o kernel/asm.o\
			  mm/memory.o mm/page.o

tools/system: ${SYSTEM_OBJS}
	@$(LD) $(LDFLAGS) $^ -o $@

boot/head.o: boot/head.s
	@make head.o -C boot/
init/main.o: init/main.c
kernel/keyboard.o:
	@make -C kernel/

clean:
	@make clean -C kernel
	@make clean -C mm
	@rm -f Image System.map tmp_make core boot/bootsect boot/setup
	@rm -f init/*.o tools/system boot/*.o kernel/*.o typescript* info bochsout.txt

start:
	@qemu-system-x86_64 -m 1024M -boot a -fda Image -hda $(HDA_IMG)

debug:
	@echo $(OS)
	@qemu-system-x86_64 -m 1024M -boot a -fda Image -hda $(HDA_IMG) -s -S


