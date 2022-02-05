	; CPU vector table
	
	DC.L   STACK_TOP			; Initial stack pointer value
	DC.L   RESET      			; Start of program
	DC.L   CPU_EXCEPTION 		; Bus error
	DC.L   CPU_EXCEPTION 		; Address error
	DC.L   CPU_EXCEPTION 		; Illegal instruction
	DC.L   CPU_EXCEPTION 		; Division by zero
	DC.L   CPU_EXCEPTION 		; CHK CPU_EXCEPTION
	DC.L   CPU_EXCEPTION 		; TRAPV CPU_EXCEPTION
	DC.L   CPU_EXCEPTION 		; Privilege violation
	DC.L   INT_NULL				; TRACE exception
	DC.L   INT_NULL				; Line-A emulator
	DC.L   INT_NULL				; Line-F emulator
	DC.L   INT_NULL				; Unused (reserved)
	DC.L   INT_NULL				; Unused (reserved)
	DC.L   INT_NULL				; Unused (reserved)
	DC.L   INT_NULL				; Unused (reserved)
	DC.L   INT_NULL				; Unused (reserved)
	DC.L   INT_NULL				; Unused (reserved)
	DC.L   INT_NULL				; Unused (reserved)
	DC.L   INT_NULL				; Unused (reserved)
	DC.L   INT_NULL				; Unused (reserved)
	DC.L   INT_NULL				; Unused (reserved)
	DC.L   INT_NULL				; Unused (reserved)
	DC.L   INT_NULL				; Unused (reserved)
	DC.L   INT_NULL				; Spurious exception
	DC.L   INT_NULL				; IRQ level 1
	DC.L   INT_NULL				; IRQ level 2
	DC.L   INT_NULL				; IRQ level 3
	DC.L   INT_HBLANK			; IRQ level 4 (horizontal retrace interrupt)
	DC.L   INT_NULL  			; IRQ level 5
	DC.L   INT_VBLANK			; IRQ level 6 (vertical retrace interrupt)
	DC.L   INT_NULL				; IRQ level 7
	DC.L   INT_NULL				; TRAP #00 exception
	DC.L   INT_NULL				; TRAP #01 exception
	DC.L   INT_NULL				; TRAP #02 exception
	DC.L   INT_NULL				; TRAP #03 exception
	DC.L   INT_NULL				; TRAP #04 exception
	DC.L   INT_NULL				; TRAP #05 exception
	DC.L   INT_NULL				; TRAP #06 exception
	DC.L   INT_NULL				; TRAP #07 exception
	DC.L   INT_NULL				; TRAP #08 exception
	DC.L   INT_NULL				; TRAP #09 exception
	DC.L   INT_NULL				; TRAP #10 exception
	DC.L   INT_NULL				; TRAP #11 exception
	DC.L   INT_NULL				; TRAP #12 exception
	DC.L   INT_NULL				; TRAP #13 exception
	DC.L   INT_NULL				; TRAP #14 exception
	DC.L   INT_NULL				; TRAP #15 exception
	DC.L   INT_NULL				; Unused (reserved)
	DC.L   INT_NULL				; Unused (reserved)
	DC.L   INT_NULL				; Unused (reserved)
	DC.L   INT_NULL				; Unused (reserved)
	DC.L   INT_NULL				; Unused (reserved)
	DC.L   INT_NULL				; Unused (reserved)
	DC.L   INT_NULL				; Unused (reserved)
	DC.L   INT_NULL				; Unused (reserved)
	DC.L   INT_NULL				; Unused (reserved)
	DC.L   INT_NULL				; Unused (reserved)
	DC.L   INT_NULL				; Unused (reserved)
	DC.L   INT_NULL				; Unused (reserved)
	DC.L   INT_NULL				; Unused (reserved)
	DC.L   INT_NULL				; Unused (reserved)
	DC.L   INT_NULL				; Unused (reserved)
	DC.L   INT_NULL				; Unused (reserved)

	; ROM metadata
	
	DC.B "SEGA MEGA DRIVE "                                 ; Console name
	DC.B "DMANUFACTURE    "                                 ; Copyright holder and release date
	DC.B "REGEN                                            " ; Domestic name
	;DC.B "SEEDS X                                         " ; Domestic name
	DC.B "REGEN                                            " ; International name
	;DC.B "SEEDS X                                         " ; International name
	DC.B "GM XXXXXXXX-XX"                                   ; Version number
	DC.W 0x0000                                             ; Checksum
	DC.B "JD              "                                 ; I/O support
	DC.L ROM_START                                          ; Start address of ROM
	DC.L ROM_END-1                                          ; End address of ROM
	DC.L RAM_START                                          ; Start address of RAM
	DC.L RAM_END                                            ; End address of RAM
	DC.L "RA"                                               ; SRAM enabled
	DC.L 0xF820                                             ; Unused
	DC.L 0x00200000                                         ; Start address of SRAM
	DC.L 0x002001FF                                         ; End address of SRAM
	DC.L 0x00000000                                         ; Unused
	DC.L 0x00000000                                         ; Unused
	DC.B "                                        "         ; Notes (unused)
	DC.B "JUE             "                                 ; Country codes
