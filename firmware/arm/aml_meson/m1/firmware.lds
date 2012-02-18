
OUTPUT_FORMAT("elf32-littlearm", "elf32-littlearm", "elf32-littlearm")
OUTPUT_ARCH(arm)
ENTRY(_start)
SECTIONS
{
 . = 0x49000000;

 . = ALIGN(4);
 .start :
 {
   *rom_spl*.o (.text)

 }
 . = 0x49000000+0x1b0;
 .magic :{
   *magic.o(.text)
 }

 . = 0x49000000+0x200;
 . = ALIGN(4);
 .setting :
 {
  * (.setting)
 }


 . = ALIGN(4);
 .text :
 {
  * (.text)
 }
 .rodata : { *(SORT_BY_ALIGNMENT(SORT_BY_NAME(.rodata*))) }
 .data : { *(.data) }

 _end = .;
 . = ALIGN(4);
 _bssstart = . ;
 .bss : { *(.bss) }
 . = ALIGN(4);
 _bssend = . ;
}
ASSERT(_end <= 0x49001800, "ROM BOOT bootstrap too big");
ASSERT(_bssend <= (0x49000000 +0x1d80) - 256, "ROM BOOT bss  too big");
