#-------------------------------------------------------------------------------- 					
#	makefile 					
#											
#	- assemble								
#	- link 
#	- create output hex file
#									
#-------------------------------------------------------------------------------

.PHONY:  all clean

TARGET  := EternalLoop

all:
	./riscv32-unknown-elf-as $(TARGET).asm -o $(TARGET).o
	./riscv32-unknown-elf-ld $(TARGET).o -o $(TARGET).elf
	./riscv32-unknown-elf-objcopy -O ihex $(TARGET).elf $(TARGET).hex


clean:
	rm -f ./*.o ./*.elf ./*.hex



