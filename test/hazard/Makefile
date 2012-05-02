BIN = test
CC = mips-elf-gcc
AS = mips-elf-as
LD = mips-elf-ld
AR = mips-elf-ar
RM = rm -f 
OBJCOPY = mips-elf-objcopy
OBJDUMP = mips-elf-objdump
all:: $(BIN).elf

%.elf:%.s
	$(AS) -O0 -mips2 -o $(BIN).elf test.s 
	$(OBJDUMP) -d $(BIN).elf > $(BIN).dis
	$(OBJCOPY) -O srec -j .text -j .data --gap-fill 0 --pad-to 0x4000 $(BIN).elf imem.srec
	srec_cat -Output imem.vmem -VMem 32 imem.srec 

clean:
	$(RM) $(BIN).elf
	$(RM) $(BIN).hex
	$(RM) $(BIN).dis
	$(RM) imem.*
