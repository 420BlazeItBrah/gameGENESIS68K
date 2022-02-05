; Address of top of stack
stack_top				equ 0x00FFE000

; Size of RAM in bytes (64kb)
size_ram_b				equ 0x0000FFFF

; Start of RAM
ram_start				equ 0x00FF0000

; End of RAM
ram_end					equ (ram_start+size_ram_b)

; Size of RAM
size_ram_b				equ 0x0000FFFF
size_ram_w				equ (size_ram_b/2)
size_ram_l				equ (size_ram_b/4)

; VDP port addresses
vdp_control				equ 0x00C00004
vdp_data				equ 0x00C00000

; VDP commands
vdp_cmd_vram_read		equ 0x00000000
vdp_cmd_vram_write		equ 0x40000000
vdp_cmd_cram_write		equ 0xC0000000
vdp_cmd_vsram_write		equ 0x40000010

VDP_CRAM_READ					EQU $20000000				
VDP_CRAM_WRITE					EQU $C0000000				
VDP_VRAM_READ					EQU $00000000				
VDP_VRAM_WRITE					EQU $40000000				
VDP_VSRAM_READ					EQU $10000000				
VDP_VSRAM_WRITE					EQU $14000000

VDP_GRAPHICS_ADDR				EQU $00200000
VDP_BACKGROUND_L01_ADDR			EQU $00000003
VDP_BACKGROUND_L02_ADDR			EQU $00800003
VDP_BACKGROUND_L11_ADDR			EQU $01000003		; 6TH BIT = LAYER
VDP_BACKGROUND_L12_ADDR			EQU $01800003		; 5TH BIT = SUB LAYER
VDP_BACKGROUND_L21_ADDR			EQU $02000003
VDP_BACKGROUND_L22_ADDR			EQU $02800003
VDP_BACKGROUND_L31_ADDR			EQU $03000003
VDP_BACKGROUND_L32_ADDR			EQU $03800003
VDP_BACKGROUND_L41_ADDR			EQU $04000003
VDP_BACKGROUND_L42_ADDR			EQU $04800003
VDP_BACKGROUND_L51_ADDR			EQU $05000003
VDP_BACKGROUND_L52_ADDR			EQU $05800003
VDP_BACKGROUND_L61_ADDR			EQU $06000003
VDP_BACKGROUND_L62_ADDR			EQU $06800003
;VDP_HSCROLL_ADDR				EQU $00

; Vertical blanking test bit
vdp_status_vblank		equ 0x3

; Screen width/height
screen_width    equ $1C0  ;320 dec = 140 hex. 140 + 80 hex = 1C0
screen_height   equ $170  ;240 dec = F0 hex. F0 + 80 hex = 170

;addresses
sprite_addr         equ 0xF000
background_addr     equ 0xC000
palette_addr        equ 0x0000
graphics_addr       equ 0x0020

realbg_addr         equ background_addr+$80

; Hardware version address
hardware_ver_address	equ 0x00A10001

; TMSS
tmss_address			equ 0x00A14000
tmss_signature			equ 'SEGA'

	; CPU vector table
	
	dc.l   stack_top			; Initial stack pointer value
	dc.l   CPU_EntryPoint		; Start of program
	dc.l   CPU_Exception 		; Bus error
	dc.l   CPU_Exception 		; Address error
	dc.l   CPU_Exception 		; Illegal instruction
	dc.l   CPU_Exception 		; Division by zero
	dc.l   CPU_Exception 		; CHK CPU_Exception
	dc.l   CPU_Exception 		; TRAPV CPU_Exception
	dc.l   CPU_Exception 		; Privilege violation
	dc.l   INT_Null				; TRACE exception
	dc.l   INT_Null				; Line-A emulator
	dc.l   INT_Null				; Line-F emulator
	dc.l   INT_Null				; Unused (reserved)
	dc.l   INT_Null				; Unused (reserved)
	dc.l   INT_Null				; Unused (reserved)
	dc.l   INT_Null				; Unused (reserved)
	dc.l   INT_Null				; Unused (reserved)
	dc.l   INT_Null				; Unused (reserved)
	dc.l   INT_Null				; Unused (reserved)
	dc.l   INT_Null				; Unused (reserved)
	dc.l   INT_Null				; Unused (reserved)
	dc.l   INT_Null				; Unused (reserved)
	dc.l   INT_Null				; Unused (reserved)
	dc.l   INT_Null				; Unused (reserved)
	dc.l   INT_Null				; Spurious exception
	dc.l   INT_Null				; IRQ level 1
	dc.l   INT_Null				; IRQ level 2
	dc.l   INT_Null				; IRQ level 3
	dc.l   INT_HBlank			; IRQ level 4 (horizontal retrace interrupt)
	dc.l   INT_Null  			; IRQ level 5
	dc.l   INT_VBlank			; IRQ level 6 (vertical retrace interrupt)
	dc.l   INT_Null				; IRQ level 7
	dc.l   INT_Null				; TRAP #00 exception
	dc.l   INT_Null				; TRAP #01 exception
	dc.l   INT_Null				; TRAP #02 exception
	dc.l   INT_Null				; TRAP #03 exception
	dc.l   INT_Null				; TRAP #04 exception
	dc.l   INT_Null				; TRAP #05 exception
	dc.l   INT_Null				; TRAP #06 exception
	dc.l   INT_Null				; TRAP #07 exception
	dc.l   INT_Null				; TRAP #08 exception
	dc.l   INT_Null				; TRAP #09 exception
	dc.l   INT_Null				; TRAP #10 exception
	dc.l   INT_Null				; TRAP #11 exception
	dc.l   INT_Null				; TRAP #12 exception
	dc.l   INT_Null				; TRAP #13 exception
	dc.l   INT_Null				; TRAP #14 exception
	dc.l   INT_Null				; TRAP #15 exception
	dc.l   INT_Null				; Unused (reserved)
	dc.l   INT_Null				; Unused (reserved)
	dc.l   INT_Null				; Unused (reserved)
	dc.l   INT_Null				; Unused (reserved)
	dc.l   INT_Null				; Unused (reserved)
	dc.l   INT_Null				; Unused (reserved)
	dc.l   INT_Null				; Unused (reserved)
	dc.l   INT_Null				; Unused (reserved)
	dc.l   INT_Null				; Unused (reserved)
	dc.l   INT_Null				; Unused (reserved)
	dc.l   INT_Null				; Unused (reserved)
	dc.l   INT_Null				; Unused (reserved)
	dc.l   INT_Null				; Unused (reserved)
	dc.l   INT_Null				; Unused (reserved)
	dc.l   INT_Null				; Unused (reserved)
	dc.l   INT_Null				; Unused (reserved)

	; ROM metadata
	
	dc.b "SEGA MEGA DRIVE "                                 ; Console name
	dc.b "DB MANUFACTURE  "                                 ; Copyright holder and release date
	dc.b "SEEDS X                                         " ; Domestic name
	dc.b "SEEDS X                                         " ; International name
	dc.b "GM XXXXXXXX-XX"                                   ; Version number
	dc.w 0x0000                                             ; Checksum
	dc.b "J               "                                 ; I/O support
	dc.l ROM_Start                                          ; Start address of ROM
	dc.l ROM_End-1                                          ; End address of ROM
	dc.l ram_start                                          ; Start address of RAM
	dc.l ram_end                                            ; End address of RAM
	dc.l 0x00000000                                         ; SRAM enabled
	dc.l 0x00000000                                         ; Unused
	dc.l 0x00000000                                         ; Start address of SRAM
	dc.l 0x00000000                                         ; End address of SRAM
	dc.l 0x00000000                                         ; Unused
	dc.l 0x00000000                                         ; Unused
	dc.b "                                        "         ; Notes (unused)
	dc.b "  U             "                                 ; Country codes

; Initial VDP register values
VDPRegisters:
	dc.b 0x14 ; 0:  H interrupt on, palettes on
	dc.b 0x74 ; 1:  V interrupt on, display on, DMA on, Genesis mode on
	dc.b 0x30 ; 2:  Pattern table for Scroll Plane A at VRAM 0xC000 (bits 3-5 = bits 13-15)
	dc.b 0x00 ; 3:  Pattern table for Window Plane at VRAM 0x0000 (disabled) (bits 1-5 = bits 11-15)
	dc.b 0x07 ; 4:  Pattern table for Scroll Plane B at VRAM 0xE000 (bits 0-2 = bits 11-15)
	dc.b 0x78 ; 5:  Sprite table at VRAM 0xF000 (bits 0-6 = bits 9-15)
	dc.b 0x00 ; 6:  Unused
	dc.b 0x00 ; 7:  Background colour - bits 0-3 = colour, bits 4-5 = palette
	dc.b 0x00 ; 8:  Unused
	dc.b 0x00 ; 9:  Unused
	dc.b 0x08 ; 10: Frequency of Horiz. interrupt in Rasters (number of lines travelled by the beam)
	dc.b 0x00 ; 11: External interrupts off, V scroll fullscreen, H scroll fullscreen
	dc.b 0x81 ; 12: Shadows and highlights off, interlace off, H40 mode (320 x 224 screen res)
	dc.b 0x3F ; 13: Horiz. scroll table at VRAM 0xFC00 (bits 0-5)
	dc.b 0x00 ; 14: Unused
	dc.b 0x02 ; 15: Autoincrement 2 bytes
	dc.b 0x01 ; 16: Vert. scroll 32, Horiz. scroll 64
	dc.b 0x00 ; 17: Window Plane X pos 0 left (pos in bits 0-4, left/right in bit 7)
	dc.b 0x00 ; 18: Window Plane Y pos 0 up (pos in bits 0-4, up/down in bit 7)
	dc.b 0xFF ; 19: DMA length lo byte
	dc.b 0xFF ; 20: DMA length hi byte
	dc.b 0x00 ; 21: DMA source address lo byte
	dc.b 0x00 ; 22: DMA source address mid byte
	dc.b 0x80 ; 23: DMA source address hi byte, memory-to-VRAM mode (bits 6-7)
	
	even
	
; Data port setup macros
SetVRAMWrite: macro addr, offx
	move.l  #(vdp_cmd_vram_write)|((\addr)&$3FFF)<<16|(\addr)>>14, vdp_control
    endm

ReadVRAM: macro addr
	move.l  #(vdp_cmd_vram_read)|((\addr)&$3FFF)<<16|(\addr)>>14, vdp_control
    endm
		
SetCRAMWrite: macro addr
	move.l  #(vdp_cmd_cram_write)|((\addr)&$3FFF)<<16|(\addr)>>14, vdp_control
    endm
    
SetVSRAMWrite: macro addr
	move.l  #(vdp_cmd_vsram_write)|((\addr)&$3FFF)<<16|(\addr)>>14, vdp_control
    endm

VDP_WriteTMSS:

	move.b hardware_ver_address, d0			; Move Megadrive hardware version to d0
	andi.b #0x0F, d0						; The version is stored in last four bits, so mask it with 0F
	beq @Skip								; If version is equal to 0, skip TMSS signature
	move.l #tmss_signature, tmss_address	; Move the string "SEGA" to 0xA14000
	@Skip:

	; Check VDP
	move.w vdp_control, d0					; Read VDP status register (hangs if no access)
	
	rts
	
VDP_LoadRegisters:

	; Set VDP registers
	move.l #VDPRegisters, a0	; Load address of register init table into a0
	move.w #0x17, d0			; 24 registers to write (-1 for loop counter)
	move.w #0x8000, d1			; 'Set register 0' command

	@CopyVDP:
	move.b (a0)+, d1			; Move register value to lower byte of d1
	move.w d1, vdp_control		; Write command and value to VDP control port
	add.w  #0x0100, d1			; Increment register #
	dbra   d0, @CopyVDP
	
	rts
	
VDP_WaitVSync:
	@WaitStart:
	move.w  vdp_control, d7
	btst    #vdp_status_vblank, d7
	beq     @WaitStart
	
	@WaitEnd:
	move.w  vdp_control, d7
	btst    #vdp_status_vblank, d7
	bne     @WaitEnd
	
	rts
	
	
ROM_Start
	RSSET ram_start

CPU_EntryPoint
	BSR VDP_WriteTMSS
	BSR VDP_LoadRegisters

LOAD_PALETTES:  
	MOVE.L #VDP_CRAM_WRITE, vdp_control
	MOVE.W #PALETTES, A0
	MOVE.W #$10, D0  
	MULS.W #PALETTE_COUNT, D0  
	SUB.W #$1, D0
  
LOAD_PALETTES_LOOP:
	MOVE.W (A0)+, vdp_data
	DBRA D0, LOAD_PALETTES_LOOP
  
SET_BACKGROUND_COLOR:
	MOVE.W #$8722, vdp_control   

LOAD_FONT:	
	MOVE.L #VDP_VRAM_WRITE, D1
	ADD.L #VDP_GRAPHICS_ADDR, D1
	MOVE.L D1, vdp_control
	MOVE.L #FONT, A0
	MOVE.W #$8, D0  
	MULS.W #FONT_COUNT, D0  
	SUB.W #$1, D0
  
LOAD_FONT_LOOP:
	MOVE.L (A0)+, vdp_data
	DBRA D0, LOAD_FONT_LOOP
	
DRAW_TEXT:	
	MOVE.L #VDP_VRAM_WRITE, D1
	ADD.L #VDP_BACKGROUND_L11_ADDR, D1
	MOVE.L D1, vdp_control	
	MOVE.W #TILE_SPACE, vdp_data 
	MOVE.W #TILE_SPACE, vdp_data 	
	MOVE.W #TILE_H, vdp_data 
	MOVE.W #TILE_E, vdp_data 
	MOVE.W #TILE_L, vdp_data 
	MOVE.W #TILE_L, vdp_data 
	MOVE.W #TILE_O, vdp_data 
	MOVE.W #TILE_SPACE, vdp_data 	
	MOVE.W #TILE_W, vdp_data 	
	MOVE.W #TILE_O, vdp_data 	
	MOVE.W #TILE_R, vdp_data 	
	MOVE.W #TILE_L, vdp_data 	
	MOVE.W #TILE_D, vdp_data 	
	
  
INITIALIZE_SCROLL:
	SetVRAMWrite $FC00 ;hscroll addr
	MOVE.W #$0000, vdp_data	; Plane A h-scroll  
	MOVE.W #$0000, vdp_data	; Plane B h-scroll

	SetVSRAMWrite $0000
	MOVE.W #$0000, vdp_data	; Plane A v-scroll
	MOVE.W #$0000, vdp_data	; Plane B v-scroll

INITIATE_INTERRUPTS:  
	MOVE.W #$2300, sr
	
GAME_LOOP:    
	BRA GAME_LOOP


INT_VBlank:
    RTE
	
INT_HBlank:
    RTE

INT_Null:
    RTE

CPU_Exception:
    STOP   #$2700
    RTE 
  
ROM_End

FONT_COUNT EQU $4E

TILE_SPACE EQU $01
TILE_EXCLAMATION EQU $02
TILE_QUOTE EQU $03
TILE_POUND EQU $04
TILE_DOLLAR EQU $05
TILE_PERCENT EQU $06
TILE_AND EQU $07
TILE_APOSTROPHY EQU $08
TILE_COMMA EQU $09
TILE_MINUS EQU $0A
TILE_PERIOD EQU $0B
TILE_SLASH EQU $0C
TILE_COLON EQU $0D
TILE_QUESTION EQU $0F
TILE_PARENTHESISL EQU $0F
TILE_PARENTHESISR EQU $10
TILE_0 EQU $11
TILE_1 EQU $12
TILE_2 EQU $13
TILE_3 EQU $14
TILE_4 EQU $15
TILE_5 EQU $16
TILE_6 EQU $17
TILE_7 EQU $18
TILE_8 EQU $19
TILE_9 EQU $1A
TILE_A EQU $1B
TILE_B EQU $1C
TILE_C EQU $1D
TILE_D EQU $1E
TILE_E EQU $1F
TILE_F EQU $20
TILE_G EQU $21
TILE_H EQU $22
TILE_I EQU $23
TILE_J EQU $24
TILE_K EQU $25
TILE_L EQU $26
TILE_M EQU $27
TILE_N EQU $28
TILE_O EQU $29
TILE_P EQU $2A
TILE_Q EQU $2B
TILE_R EQU $2C
TILE_S EQU $2D
TILE_T EQU $2E
TILE_U EQU $2F
TILE_V EQU $30
TILE_W EQU $31
TILE_X EQU $32
TILE_Y EQU $33
TILE_Z EQU $34
TILE_Aa EQU $35
TILE_Bb EQU $36
TILE_Cc EQU $37
TILE_Dd EQU $38
TILE_Ee EQU $39
TILE_Ff EQU $3A
TILE_Gg EQU $3B
TILE_Hh EQU $3C
TILE_Ii EQU $3D
TILE_Jj EQU $3E
TILE_Kk EQU $3F
TILE_Ll EQU $40
TILE_Mm EQU $41
TILE_Nn EQU $42
TILE_Oo EQU $43
TILE_Pp EQU $44
TILE_Qq EQU $45
TILE_Rr EQU $46
TILE_Ss EQU $47
TILE_Tt EQU $48
TILE_Uu EQU $49
TILE_Vv EQU $4A
TILE_Ww EQU $4B
TILE_Xx EQU $4C
TILE_Yy EQU $4D
TILE_Zz EQU $4E

FONT:
	; (blank)	
	dc.l	$00000000
	dc.l	$00000000
	dc.l	$00000000
	dc.l	$00000000
	dc.l	$00000000
	dc.l	$00000000
	dc.l	$00000000
	dc.l	$00000000
	
	; !
	dc.l	$00000000
	dc.l	$00800800
	dc.l	$00800800
	dc.l	$00800800
	dc.l	$00800800
	dc.l	$00800800
	dc.l	$00000000
	dc.l	$00800800

	; "
	dc.l	$00808000
	dc.l	$00808000
	dc.l	$00808000
	dc.l	$00000000
	dc.l	$00000000
	dc.l	$00000000
	dc.l	$00000000
	dc.l	$00000000

	; #
	dc.l	$00000000
	dc.l	$00080008
	dc.l	$00800080
	dc.l	$08888880
	dc.l	$00800800
	dc.l	$08888880
	dc.l	$00800800
	dc.l	$08008000

	; $
	dc.l	$00008000
	dc.l	$00088880
	dc.l	$00808000
	dc.l	$00088800
	dc.l	$00008080
	dc.l	$00808080
	dc.l	$00088800
	dc.l	$00008000

	; %
	dc.l	$00000000
	dc.l	$00800008
	dc.l	$08080080
	dc.l	$00800800
	dc.l	$00008000
	dc.l	$00080080
	dc.l	$00800808
	dc.l	$08000080

	; &
	dc.l	$00000000
	dc.l	$00880000
	dc.l	$08008000
	dc.l	$00880000
	dc.l	$00808000
	dc.l	$08000808
	dc.l	$08000880
	dc.l	$00888008

	; '
	dc.l	$00000000
	dc.l	$00088000
	dc.l	$00088000
	dc.l	$00008000
	dc.l	$00080000
	dc.l	$00000000
	dc.l	$00000000
	dc.l	$00000000

	; ,
	dc.l	$00000000
	dc.l	$00000000
	dc.l	$00000000
	dc.l	$00000000
	dc.l	$00000000
	dc.l	$00008000
	dc.l	$00008000
	dc.l	$00080000

	; -
	dc.l	$00000000
	dc.l	$00000000
	dc.l	$00000000
	dc.l	$08888880
	dc.l	$00000000
	dc.l	$00000000
	dc.l	$00000000
	dc.l	$00000000

	; .
	dc.l	$00000000
	dc.l	$00000000
	dc.l	$00000000
	dc.l	$00000000
	dc.l	$00000000
	dc.l	$00000000
	dc.l	$00008000
	dc.l	$00000000

	; /
	dc.l	$00000008
	dc.l	$00000080
	dc.l	$00000800
	dc.l	$00008000
	dc.l	$00080000
	dc.l	$00800000
	dc.l	$08000000
	dc.l	$80000000
	
	; :
	dc.l	$00000000
	dc.l	$00000000
	dc.l	$00080000
	dc.l	$00000000
	dc.l	$00000000
	dc.l	$00000000
	dc.l	$00080000
	dc.l	$00000000

	; ?
	dc.l	$00000000
	dc.l	$00888800
	dc.l	$00000080
	dc.l	$00008800
	dc.l	$00008000
	dc.l	$00008000
	dc.l	$00000000
	dc.l	$00008000

	; [
	dc.l	$00000000
	dc.l	$00008800
	dc.l	$00080000
	dc.l	$00080000
	dc.l	$00080000
	dc.l	$00080000
	dc.l	$00080000
	dc.l	$00008800

	; ]
	dc.l	$00000000
	dc.l	$00880000
	dc.l	$00008000
	dc.l	$00008000
	dc.l	$00008000
	dc.l	$00008000
	dc.l	$00008000
	dc.l	$00880000

	; 0
	dc.l	$00000000
	dc.l	$00088800
	dc.l	$00800880
	dc.l	$00808080
	dc.l	$00880080
	dc.l	$00800080
	dc.l	$00800080
	dc.l	$00088800

	; 0
	dc.l	$00000000
	dc.l	$00008000
	dc.l	$00088000
	dc.l	$00008000
	dc.l	$00008000
	dc.l	$00008000
	dc.l	$00008000
	dc.l	$00888880

	; 2
	dc.l	$00000000
	dc.l	$00088800
	dc.l	$00000080
	dc.l	$00088800
	dc.l	$00800000
	dc.l	$00800000
	dc.l	$00800000
	dc.l	$00888880

	; 3
	dc.l	$00000000
	dc.l	$00888880
	dc.l	$00000800
	dc.l	$00008800
	dc.l	$00000080
	dc.l	$00000080
	dc.l	$00800080
	dc.l	$00088800

	; 4
	dc.l	$00000000
	dc.l	$00800000
	dc.l	$00808000
	dc.l	$00888880
	dc.l	$00008000
	dc.l	$00008000
	dc.l	$00008000
	dc.l	$00008000

	; 5
	dc.l	$00000000
	dc.l	$00888880
	dc.l	$00800000
	dc.l	$00888800
	dc.l	$00000080
	dc.l	$00000080
	dc.l	$00800080
	dc.l	$00088800

	; 6
	dc.l	$00000000
	dc.l	$00088800
	dc.l	$00800000
	dc.l	$00888800
	dc.l	$00800080
	dc.l	$00800080
	dc.l	$00800080
	dc.l	$00088800

	; 7
	dc.l	$00000000
	dc.l	$00888880
	dc.l	$00000080
	dc.l	$00000800
	dc.l	$00008000
	dc.l	$00008000
	dc.l	$00008000
	dc.l	$00008000

	; 8
	dc.l	$00000000
	dc.l	$00088800
	dc.l	$00800080
	dc.l	$00088800
	dc.l	$00800080
	dc.l	$00800080
	dc.l	$00800080
	dc.l	$00088800

	; 9
	dc.l	$00000000
	dc.l	$00088880
	dc.l	$00800080
	dc.l	$00800080
	dc.l	$00088880
	dc.l	$00000080
	dc.l	$00000080
	dc.l	$00000080

	; A
	dc.l	$00000000
	dc.l	$00088800
	dc.l	$00800080
	dc.l	$00888880
	dc.l	$00800080
	dc.l	$00800080
	dc.l	$00800080
	dc.l	$00800080

	; B
	dc.l	$00000000
	dc.l	$00888800
	dc.l	$00800080
	dc.l	$00888800
	dc.l	$00800080
	dc.l	$00800080
	dc.l	$00800080
	dc.l	$00888800

	; C
	dc.l	$00000000
	dc.l	$00088800
	dc.l	$00800080
	dc.l	$00800000
	dc.l	$00800000
	dc.l	$00800080
	dc.l	$00800080
	dc.l	$00088800

	; D
	dc.l	$00000000
	dc.l	$00888800
	dc.l	$00800080
	dc.l	$00800080
	dc.l	$00800080
	dc.l	$00800080
	dc.l	$00800800
	dc.l	$00888000

	; E
	dc.l	$00000000
	dc.l	$00888880
	dc.l	$00800000
	dc.l	$00888880
	dc.l	$00800000
	dc.l	$00800000
	dc.l	$00800000
	dc.l	$00888880

	; F
	dc.l	$00000000
	dc.l	$00888880
	dc.l	$00800000
	dc.l	$00888880
	dc.l	$00800000
	dc.l	$00800000
	dc.l	$00800000
	dc.l	$00800000

	; G
	dc.l	$00000000
	dc.l	$00888000
	dc.l	$08000000
	dc.l	$08008880
	dc.l	$08000080
	dc.l	$08000080
	dc.l	$08000080
	dc.l	$00888800

	; H
	dc.l	$00000000
	dc.l	$00800080
	dc.l	$00800080
	dc.l	$00800080
	dc.l	$00888880
	dc.l	$00800080
	dc.l	$00800080
	dc.l	$00800080

	; I
	dc.l	$00000000
	dc.l	$08888800
	dc.l	$00080000
	dc.l	$00080000
	dc.l	$00080000
	dc.l	$00080000
	dc.l	$00080000
	dc.l	$08888800

	; J
	dc.l	$00000000
	dc.l	$00008800
	dc.l	$00000800
	dc.l	$00000800
	dc.l	$00000800
	dc.l	$08000800
	dc.l	$08000800
	dc.l	$00888000

	; K
	dc.l	$00000000
	dc.l	$08008000
	dc.l	$08080000
	dc.l	$08888000
	dc.l	$08000800
	dc.l	$08000800
	dc.l	$08000800
	dc.l	$08000800

	; L
	dc.l	$00000000
	dc.l	$08000000
	dc.l	$08000000
	dc.l	$08000000
	dc.l	$08000000
	dc.l	$08000000
	dc.l	$08000000
	dc.l	$08888800

	; M
	dc.l	$00000000
	dc.l	$00800080
	dc.l	$00880880
	dc.l	$00808080
	dc.l	$00800080
	dc.l	$00800080
	dc.l	$00800080
	dc.l	$00800080

	; N
	dc.l	$00000000
	dc.l	$00800080
	dc.l	$00880080
	dc.l	$00808080
	dc.l	$00800880
	dc.l	$00800080
	dc.l	$00800080
	dc.l	$00800080

	; O
	dc.l	$00000000
	dc.l	$00088800
	dc.l	$00800080
	dc.l	$00800080
	dc.l	$00800080
	dc.l	$00800080
	dc.l	$00800080
	dc.l	$00088800

	; P
	dc.l	$00000000
	dc.l	$00888800
	dc.l	$00800080
	dc.l	$00800080
	dc.l	$00888800
	dc.l	$00800000
	dc.l	$00800000
	dc.l	$00800000

	; Q
	dc.l	$00000000
	dc.l	$00088800
	dc.l	$00800080
	dc.l	$00800080
	dc.l	$00800080
	dc.l	$00808080
	dc.l	$00800880
	dc.l	$00088880

	; R
	dc.l	$00000000
	dc.l	$00888800
	dc.l	$00800080
	dc.l	$00888800
	dc.l	$00800080
	dc.l	$00800080
	dc.l	$00800080
	dc.l	$00800080

	; S
	dc.l	$00000000
	dc.l	$00088800
	dc.l	$00800000
	dc.l	$00088800
	dc.l	$00000080
	dc.l	$00000080
	dc.l	$00800080
	dc.l	$00088800

	; T
	dc.l	$00000000
	dc.l	$00888880
	dc.l	$00008000
	dc.l	$00008000
	dc.l	$00008000
	dc.l	$00008000
	dc.l	$00008000
	dc.l	$00008000

	; U
	dc.l	$00000000
	dc.l	$00800080
	dc.l	$00800080
	dc.l	$00800080
	dc.l	$00800080
	dc.l	$00800080
	dc.l	$00800080
	dc.l	$00088800

	; V
	dc.l	$00000000
	dc.l	$00800080
	dc.l	$00800080
	dc.l	$00800080
	dc.l	$00800080
	dc.l	$00800080
	dc.l	$00080800
	dc.l	$00008000

	; W
	dc.l	$00000000
	dc.l	$00800080
	dc.l	$00800080
	dc.l	$00800080
	dc.l	$00800080
	dc.l	$00808080
	dc.l	$00880880
	dc.l	$00800080

	; X
	dc.l	$00000000
	dc.l	$00800080
	dc.l	$00080800
	dc.l	$00008000
	dc.l	$00080800
	dc.l	$00800080
	dc.l	$00800080
	dc.l	$00800080

	; Y
	dc.l	$00000000
	dc.l	$08000800
	dc.l	$00808000
	dc.l	$00080000
	dc.l	$00080000
	dc.l	$00080000
	dc.l	$00080000
	dc.l	$00080000

	; Z
	dc.l	$00000000
	dc.l	$00888880
	dc.l	$00000800
	dc.l	$00008000
	dc.l	$00080000
	dc.l	$00800000
	dc.l	$00800000
	dc.l	$00888880

	; a
	dc.l	$00000000
	dc.l	$00000000
	dc.l	$00888000
	dc.l	$00000800
	dc.l	$00888800
	dc.l	$08000800
	dc.l	$08000800
	dc.l	$00888800

	; b
	dc.l	$00000000
	dc.l	$00800000
	dc.l	$00800000
	dc.l	$00808800
	dc.l	$00880080
	dc.l	$00800080
	dc.l	$00800080
	dc.l	$00888800

	; c
	dc.l	$00000000
	dc.l	$00000000
	dc.l	$00088800
	dc.l	$00800080
	dc.l	$00800000
	dc.l	$00800000
	dc.l	$00800080
	dc.l	$00088800

	; d
	dc.l	$00000000
	dc.l	$00000800
	dc.l	$00000800
	dc.l	$00880800
	dc.l	$08008800
	dc.l	$08000800
	dc.l	$08000800
	dc.l	$00888800

	; e
	dc.l	$00000000
	dc.l	$00000000
	dc.l	$00888000
	dc.l	$08000800
	dc.l	$08888800
	dc.l	$08000000
	dc.l	$08000000
	dc.l	$00888000

	; f
	dc.l	$00000000
	dc.l	$00008800
	dc.l	$00080000
	dc.l	$00088880
	dc.l	$00080000
	dc.l	$00080000
	dc.l	$00080000
	dc.l	$00080000

	; g
	dc.l	$00000000
	dc.l	$00000000
	dc.l	$00888800
	dc.l	$08000800
	dc.l	$08000800
	dc.l	$00888800
	dc.l	$00000800
	dc.l	$00888000

	; h
	dc.l	$00000000
	dc.l	$00800000
	dc.l	$00800000
	dc.l	$00808800
	dc.l	$00880080
	dc.l	$00800080
	dc.l	$00800080
	dc.l	$00800080

	; i
	dc.l	$00000000
	dc.l	$00008000
	dc.l	$00000000
	dc.l	$00008000
	dc.l	$00008000
	dc.l	$00008000
	dc.l	$00008000
	dc.l	$00008000

	; j
	dc.l	$00000000
	dc.l	$00000800
	dc.l	$00000000
	dc.l	$00000800
	dc.l	$00000800
	dc.l	$00000800
	dc.l	$00800800
	dc.l	$00088000

	; k
	dc.l	$00000000
	dc.l	$00800000
	dc.l	$00800800
	dc.l	$00808000
	dc.l	$00888800
	dc.l	$00800080
	dc.l	$00800080
	dc.l	$00800080

	; l
	dc.l	$00000000
	dc.l	$00008000
	dc.l	$00008000
	dc.l	$00008000
	dc.l	$00008000
	dc.l	$00008000
	dc.l	$00008000
	dc.l	$00008000

	; m
	dc.l	$00000000
	dc.l	$00000000
	dc.l	$00880800
	dc.l	$00808080
	dc.l	$00808080
	dc.l	$00808080
	dc.l	$00808080
	dc.l	$00808080

	; n
	dc.l	$00000000
	dc.l	$00000000
	dc.l	$00808800
	dc.l	$00880080
	dc.l	$00800080
	dc.l	$00800080
	dc.l	$00800080
	dc.l	$00800080

	; o
	dc.l	$00000000
	dc.l	$00000000
	dc.l	$00088800
	dc.l	$00800080
	dc.l	$00800080
	dc.l	$00800080
	dc.l	$00800080
	dc.l	$00088800

	; p
	dc.l	$00000000
	dc.l	$00000000
	dc.l	$00808800
	dc.l	$00880080
	dc.l	$00800080
	dc.l	$00888800
	dc.l	$00800000
	dc.l	$00800000

	; q
	dc.l	$00000000
	dc.l	$00000000
	dc.l	$00880800
	dc.l	$08008800
	dc.l	$08000800
	dc.l	$00888800
	dc.l	$00000800
	dc.l	$00000800

	; r
	dc.l	$00000000
	dc.l	$00000000
	dc.l	$00800880
	dc.l	$00808000
	dc.l	$00880000
	dc.l	$00800000
	dc.l	$00800000
	dc.l	$00800000

	; s
	dc.l	$00000000
	dc.l	$00000000
	dc.l	$00888000
	dc.l	$08000000
	dc.l	$00888000
	dc.l	$00000800
	dc.l	$08000800
	dc.l	$00888000

	; t
	dc.l	$00000000
	dc.l	$00080000
	dc.l	$00088880
	dc.l	$00080000
	dc.l	$00080000
	dc.l	$00080000
	dc.l	$00080080
	dc.l	$00008800

	; u
	dc.l	$00000000
	dc.l	$00000000
	dc.l	$08000800
	dc.l	$08000800
	dc.l	$08000800
	dc.l	$08000800
	dc.l	$08000800
	dc.l	$00888800

	; v
	dc.l	$00000000
	dc.l	$00000000
	dc.l	$00800080
	dc.l	$00800080
	dc.l	$00800080
	dc.l	$00800080
	dc.l	$00080800
	dc.l	$00008000

	; w
	dc.l	$00000000
	dc.l	$00000000
	dc.l	$00808080
	dc.l	$00808080
	dc.l	$00808080
	dc.l	$00808080
	dc.l	$00808080
	dc.l	$00080800

	; x
	dc.l	$00000000
	dc.l	$00000000
	dc.l	$08000800
	dc.l	$00808000
	dc.l	$00080000
	dc.l	$00808000
	dc.l	$08000800
	dc.l	$08000800

	; y
	dc.l	$00000000
	dc.l	$00000000
	dc.l	$08000800
	dc.l	$08000800
	dc.l	$08000800
	dc.l	$00888800
	dc.l	$00000800
	dc.l	$00888000

	; z
	dc.l	$00000000
	dc.l	$00000000
	dc.l	$08888880
	dc.l	$00000800
	dc.l	$00008000
	dc.l	$00080000
	dc.l	$00800000
	dc.l	$08888880
	
PALETTE_COUNT	EQU $03

PALETTES:
  dc.w $0EEE
  dc.w $00EE
  dc.w $0E0E
  dc.w $000E
  dc.w $0EE0
  dc.w $00E0
  dc.w $0E00
  dc.w $0888
	dc.w $0CCC
	dc.w $0088
	dc.w $0808
	dc.w $0008
	dc.w $0880
	dc.w $0080
	dc.w $0800
	dc.w $0000
	
	dc.w 0x0000
	dc.w 0x0020
	dc.w 0x0EEE
	dc.w 0x00AC
	dc.w 0x02EA
	dc.w 0x00EE
	dc.w 0x0008
	dc.w 0x000C
	dc.w 0x000A
	dc.w 0x0000
	dc.w 0x0000
	dc.w 0x0000
	dc.w 0x0000
	dc.w 0x0000
	dc.w 0x0000
	dc.w 0x0000

	dc.w 0x0000
	dc.w 0x0004
	dc.w 0x0226
	dc.w 0x0040
	dc.w 0x0446
	dc.w 0x0262
	dc.w 0x0662
	dc.w 0x004A
	dc.w 0x0468
	dc.w 0x0882
	dc.w 0x006C
	dc.w 0x0202
	dc.w 0x04A0
	dc.w 0x0AC2
	dc.w 0x06AE
	dc.w 0x02EC