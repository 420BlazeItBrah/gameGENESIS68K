; Initial VDP register values
VDPREGISTERS:
	DC.B 0x14 ; 0:  H interrupt on, palettes on ; used to be 14
	DC.B 0x74 ; 1:  V interrupt on, display on, DMA on, Genesis mode on
	DC.B 0x30 ; 2:  Pattern table for Scroll Plane A at VRAM 0xC000 (bits 3-5 = bits 13-15)
	DC.B 0x00 ; 3:  Pattern table for Window Plane at VRAM 0x0000 (disabled) (bits 1-5 = bits 11-15)
	DC.B 0x07 ; 4:  Pattern table for Scroll Plane B at VRAM 0xE000 (bits 0-2 = bits 11-15)
	DC.B 0x78 ; 5:  Sprite table at VRAM 0xF000 (bits 0-6 = bits 9-15)
	DC.B 0x00 ; 6:  Unused
	DC.B 0x32 ; 7:  Background colour - bits 0-3 = colour, bits 4-5 = palette
	DC.B 0x00 ; 8:  Unused
	DC.B 0x00 ; 9:  Unused
	DC.B 0x01 ; 10: Frequency of Horiz. interrupt in Rasters (number of lines travelled by the beam) ; used to be 8
	DC.B 0x00 ; 11: External interrupts off, V scroll fullscreen, H scroll fullscreen
	DC.B 0x81 ; 12: Shadows and highlights off, interlace off, H40 mode (320 x 224 screen res)
	DC.B 0x3F ; 13: Horiz. scroll table at VRAM 0xFC00 (bits 0-5)
	DC.B 0x00 ; 14: Unused
	DC.B 0x02 ; 15: Autoincrement 2 bytes
	DC.B 0x01 ; 16: Vert. scroll 32, Horiz. scroll 64
	DC.B 0x00 ; 17: Window Plane X pos 0 left (pos in bits 0-4, left/right in bit 7)
	DC.B 0x00 ; 18: Window Plane Y pos 0 up (pos in bits 0-4, up/down in bit 7)
	DC.B 0xFF ; 19: DMA length lo byte
	DC.B 0xFF ; 20: DMA length hi byte
	DC.B 0x00 ; 21: DMA source address lo byte
	DC.B 0x00 ; 22: DMA source address mid byte
	DC.B 0x80 ; 23: DMA source address hi byte, memory-to-VRAM mode (bits 6-7)
	EVEN
    
WRITE_TMSS_TO_VDP:
	MOVE.B HARDWARE_VER_ADDRESS, D0			; Move Megadrive hardware version to d0
	ANDI.B #$0F, D0						; The version is stored in last four bits, so mask it with 0F
	BEQ @SKIP								; If version is equal to 0, skip TMSS signature
	MOVE.L #TMSS_SIGNATURE, TMSS_ADDRESS	; Move the string "SEGA" to 0xA14000
	@SKIP:	
	MOVE.W VDP_CONTROL, D0					; Read VDP status register (hangs if no access)	
	RTS
	
LOAD_VDP_REGISTERS:	
	MOVE.L #VDPREGISTERS, A0	; Load address of register init table into a0
	MOVE.W #$0017, D0			; 24 registers to write (-1 for loop counter)
	MOVE.W #$8000, D1			; 'Set register 0' command

	@COPYVDP:
	MOVE.B (A0)+, D1			; Move register value to lower byte of d1
	MOVE.W D1, VDP_CONTROL		; Write command and value to VDP control port
	ADD.W #$0100, D1			; Increment register #
	DBRA D0, @COPYVDP
	RTS	