include ../include/Makefile.header

CFLAGS	+= -I../include
CPP	+= -I../include

OBJS  = memory.o page.o

all: ${OBJS}

.c.s:
	@$(CC) $(CFLAGS) \
	-S -o $*.s $<
.s.o:
	@$(AS) -o $*.o $<
.c.o:
	@$(CC) $(CFLAGS) \
	-c -o $*.o $<

clean:
	@rm -f *.o
