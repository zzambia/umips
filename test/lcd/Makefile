BIN = test
CC = mips-elf-gcc
AS = mips-elf-as
LD = mips-elf-ld
AR = mips-elf-ar
RM = rm -f 
OBJCOPY = mips-elf-objcopy
OBJDUMP = mips-elf-objdump
CFLAGS = -O2 -ggdb -static -msoft-float -nostdlib -fno-inline -mips1 -Wa,-mno-fix-vr4120,-mips1
LDFLAGS= -Wl,-Ttest.ld,--no-check-sections
SRC=test.c startup.s
LIBS=-lc -lgcc
all:: $(BIN).elf

%.elf:%.c
	$(CC) $(CFLAGS) $(LDFLAGS) -o $(BIN).elf $(SRC) $(LIBS)
	$(OBJDUMP) -d $(BIN).elf > $(BIN).dis
	$(OBJCOPY) -O srec -j.text --gap-fill 0 --pad-to 0x4000 $(BIN).elf imem.srec
	$(OBJCOPY) -O srec -j.data --gap-fill 0 --pad-to 0x4000 $(BIN).elf dmem.srec
	srec_cat -Output imem.hex -VMem 32 imem.srec 
	srec_cat -Output dmem.hex -VMem 32 dmem.srec 

clean:
	$(RM) $(BIN).elf
	$(RM) $(BIN).hex
	$(RM) $(BIN).dis
	$(RM) *.srec
	$(RM) *.hex
