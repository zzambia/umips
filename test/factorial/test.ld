ENTRY(main)
SEARCH_DIR("/usr/local/mips/mips-elf/lib");
MEMORY 
{
    rom (rwx) : ORIGIN = 0x00000000, LENGTH = 32K
    ram (rwx) : ORIGIN = 0x00000000, LENGTH = 32K
}

SECTIONS
{
    .  = 0x0;
    .text : {
        *(.mips.reset)
        *(.text)
    } > rom
    .data : {
        . = ALIGN(8); 
        *(.data .rodata* .bss .sdata .sbss)
    } > ram
}
