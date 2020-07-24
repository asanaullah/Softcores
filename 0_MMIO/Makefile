RISCV_TOOLCHAIN = riscv64-linux-gnu-
FLAGS = -O0   -ffreestanding -nostdlib  -Wno-int-conversion
ARCH = rv32i
ABI = ilp32
LINKER_SCRIPT = host/lnk/firmware.ld


rtl/src/firmware.hex: firmware.elf
	$(RISCV_TOOLCHAIN)objcopy -O verilog $< /dev/stdout > $@


firmware.elf: host/src/test.c
	$(RISCV_TOOLCHAIN)gcc  $(FLAGS) -march=$(ARCH) -mabi=$(ABI)  -o $@ 	-T  $(LINKER_SCRIPT) 	$<
	
clean:
	rm *.elf

