include ../include/Makefile.header

CFLAGS	+= -I../include
CPP	+= -I../include

OBJS  = tty_io.o console.o keyboard.o sched.o ctype.o \
		printk.o vsprintf.o string.o system_call.o traps.o \
		signal.o undefined.o asm.o

all: ${OBJS}

.c.s:
	@$(CC) $(CFLAGS) \
	-S -o $*.s $<
.s.o:
	@$(AS) -o $*.o $<
.c.o:
	@$(CC) $(CFLAGS) \
	-c -o $*.o $<

keyboard.s: kb.S ../include/config.h
	@$(CPP) kb.S -o keyboard.s


clean:
	@rm -f core *.o *.a tmp_make keyboard.s
	@for i in *.c;do rm -f `basename $$i .c`.s;done
