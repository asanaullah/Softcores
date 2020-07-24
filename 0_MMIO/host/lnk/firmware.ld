ENTRY (main)

MEMORY {
	rom : ORIGIN = 0x00000000, LENGTH = 10K
}

SECTIONS {
	.memory : {
		. = 0x000000;
		start*(.text);
		*(.text);
		*(*);
		end = .;
	} > rom
}
