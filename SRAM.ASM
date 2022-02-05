;---------------------------------------
;
; SRAM test
;
; Shows how many times you have played the rom
;
; by drx [www.hacking-cult.org]
;
;---------------------------------------


Vectors:	dc.l $FFFE00,	Entrypoint,	Error,	Error
		dc.l Error,	Error,		Error,	Error
		dc.l Error,	Error,		Error,	Error
		dc.l Error,	Error,		Error,	Error
		dc.l Error,	Error,		Error,	Error
		dc.l Error,	Error,		Error,	Error
		dc.l Error,	Error,		Error,	Error
		dc.l HBlank,	Error,		VBlank,	Error
		dc.l Error,	Error,		Error,	Error
		dc.l Error,	Error,		Error,	Error
		dc.l Error,	Error,		Error,	Error
		dc.l Error,	Error,		Error,	Error
		dc.l Error,	Error,		Error,	Error
		dc.l Error,	Error,		Error,	Error
		dc.l Error,	Error,		Error,	Error
		dc.l Error,	Error,		Error,	Error
Header:		dc.b 'SEGA MEGA DRIVE ' ; Console name
		dc.b '(C) DRX 2004.NOV' ; Copyright/Date
DomesticName:	dc.b 'SRAM test by drx - www.hacking-cult.org         ' ; Domestic Name
		dc.b 'SRAM test by drx - www.hacking-cult.org         ' ; International Name
		dc.b 'GM 00000000-00'   ; Version
Checksum:	dc.w $1337
					; Checksum
		dc.b 'J               ' ; I/O Support
RomStartLoc:	dc.l 0			; ROM Start
RomEndLoc:	dc.l RomEnd
					; ROM End
RamStartLoc:	dc.l $FF0000		; RAM Start
RamEndLoc:	dc.l $FFFFFF		; RAM End

		dc.b 'RA',$F8,$20	; 'RA',$F8,$20 if SRAM = on
		
SramStart:	dc.l $200000		; $200000 if SRAM = on
SramEnd:	dc.l $20FFFF		; $20xxxx if SRAM = on
		
		dc.b '                                              ' ; Notes
		dc.b '      '
		dc.b 'JUE             ' ; Country

;---------------------
; Code start
;---------------------
		
Entrypoint:

		tst.l	($A10008).l		;Test Port A control
		bne	PortA_Ok

		tst.w	($A1000C).l		;Test Port C control

PortA_Ok:
		bne	SkipSetup

		move.b	($A10001).l,d0		;version
		andi.b	#$F,d0
		beq	SkipSecurity		;if the smd/gen model is 1, skip the security
		move.l	#'SEGA',($A14000).l

SkipSecurity:   

		move.w	($C00004).l,d0		;test if VDP works

		moveq	#0,d0
		movea.l	d0,a6
		move	a6,usp			;set usp to $0
		
;---------------------
; Setup VDP registers
;---------------------
		lea	(VDPSetupArray),a0
		move.w	#(VDPSetupArrayEnd-VDPSetupArray)/2,d1	;$18 VDP registers
		
VDPSetupLoop:
		move.w	(a0)+,($C00004).l
		dbf	d1,VDPSetupLoop
		
		
		move.l	#$40000080,($C00004).l
		move.w	#0,($C00000).l		;clean the screen
	
	
;---------------------
; Init the Z80
;---------------------	

		move.w	#$100,($A11100).l	;Stop the Z80
		move.w	#$100,($A11200).l	;Reset the Z80
		
Waitforz80:
		btst	#0,($A11100).l
		bne	Waitforz80		;Wait for z80 to halt
		
		lea	(Z80Init),a0
		lea	($A00000).l,a1
		move.w	#Z80InitEnd-Z80Init,d1
		
InitZ80:
		move.b	(a0)+,(a1)+
		dbf	d1,InitZ80
		
		move.w	#0,($A11200).l
		move.w	#0,($A11100).l		;Start the Z80
		move.w	#$100,($A11200).l
		
	
;---------------------
; Reset the RAM
;---------------------	

		lea	($FFFF0000).l,a0
		move.w	#$3fff,d1
		
ClearRAM:
		move.l	#0,(a0)+
		dbf	d1,ClearRAM
		
		
;---------------------
; VDP again
;---------------------			
		
		move.w	#$8174,($C00004).l
		move.w	#$8F02,($C00004).l
		
		
;---------------------
; Clear the CRAM
;---------------------	

		move.l	#$C0000000,($C00004).l	;Set VDP ctrl to CRAM write
		move.w	#$3f,d1
		
ClearCRAM:
		move.w	#0,($C00000).l
		dbf	d1,ClearCRAM
		
			
;---------------------
; Clear the VDP stuff
;---------------------		

		move.l	#$40000010,($C00004).l
		move.w	#$13,d1
		
ClearStuff:
		move.l	#0,($C00000).l
		dbf	d1,ClearStuff
		

;---------------------
; Init the PSG
;---------------------	

		move.b	#$9F,($C00011).l
		move.b	#$BF,($C00011).l
		move.b	#$DF,($C00011).l
		move.b	#$FF,($C00011).l
		
		
		move.w	#0,($A11200).l
		
		
;---------------------
; Load the z80 driver
;---------------------

		move.w	#$100,($A11100).l	;Stop the Z80
		move.w	#$100,($A11200).l	;Reset the Z80
		
Waitforz80a:
		btst	#0,($A11100).l
		bne	Waitforz80a		;Wait for z80 to halt
		
		lea	(Z80Driver),a0
		lea	($A00000).l,a1
		move.W	#Z80DriverEnd-Z80Driver,d1
		
LoadZ80Driver:
		move.b	(a0)+,(a1)+
		dbf	d1,LoadZ80Driver
		
		move.w	#0,($A11100).l		;Start the Z80
	
;---------------------
; Clear the registers
; and set the SR
;---------------------	

		movem.l	($FF0000).l,d0-a6	
		lea	($FFFE00).l,a7
		move	#$2700,sr

SkipSetup:	

	
;-----------------------
; Here starts your code
;-----------------------
Main:

		add.l	#1,($200000).l		
		
		lea	(Font),a0
		move.l	#$F0,d0
		move.l	#0,d1
		jsr	Load1bpp
		
		move.l	#$C0000000,($C00004).l
		move.w	#$0,($C00000).l	
		move.w	#$EEE,($C00000).l
				
		move.l	#$60000003,($C00004).l
		lea	(Test),a0
		jsr	Print
		
		move.l	($200000).l,d0
		jsr	PrintLong
		
		jsr	Print

				
End:
		bra	End
		rts
		
Test:		dc.b	'You have opened this ROM $',0
		dc.b	' times',0
	
		even
		
PrintLong:
		movem	d0-d3,-(sp)
		move.l	d0,d1
		move.w	#7,d2
		
PrintLongLoop:
		move.b	d1,d3
		and.w	#$F,d3
		cmp.b	#$A,d3
		blt	NoAdd
		add.b	#$7,d3	
NoAdd:
		add.b	#$30,d3
		move.w	d3,-(sp)
		lsr.l	#4,d1
		dbf	d2,PrintLongLoop
		
		move.w	#7,d2
		
PrintLongLoop2:
		move.w	(sp)+,($C00000).l
		dbf	d2,PrintLongLoop2
		movem	(sp)+,d0-d3
		rts
	
Print:
		move.l	d0,-(sp)
		moveq	#0,d0
		
Loopy:
		move.b	(a0)+,d0
		beq	Die
		
		move.w	d0,($C00000).l
		bra	Loopy
		
Die:
		move.l	(sp)+,d0
		rts	
		
		rts
				
			
Load1bpp:				; CODE XREF: ROM:000028A2p
		move	#$2700,sr
		move.w	#$8F02,($C00004).l
		lsl.l	#2,d1
		lsr.w	#2,d1
		swap	d1
		addi.l	#$40000000,d1
		move.l	d1,($C00004).l
		lsl.l	#3,d0
		subi.l	#1,d0
		clr.l	d1
		clr.l	d2
		move.l	#1,d3
		move.l	#3,d4
		move.b	(a0)+,d1

loc_1FC6:				; CODE XREF: sub_1F8E+46j sub_1F8E+58j ...
		lsl.w	#4,d2
		move.b	d1,d1
		bmi.w	loc_1FFC
		addi.w	#0,d2

loc_1FD2:				; CODE XREF: sub_1F8E+72j
		lsl.b	#1,d1
		dbf	d4,loc_1FC6
		move.w	d2,($C00000).l
		clr.l	d2
		move.l	#3,d4
		dbf	d3,loc_1FC6
		move.l	#1,d3
		move.b	(a0)+,d1
		dbf	d0,loc_1FC6
		move	#$2300,sr
		rts	
; ФФФФФФФФФФФФФФФФФФФФФФФФФФФФФФФФФФФФФФФФФФФФФФФФФФФФФФФФФФФФФФФФФФФФФФФФФФФ

loc_1FFC:				; CODE XREF: sub_1F8E+3Cj
		addi.w	#1,d2
		bra.w	loc_1FD2
	
			


		rts
		
		
;---------------------
; Error exceptions
;---------------------

Error:
		rte
		
;---------------------
; Horizontal Blank
;---------------------
HBlank:

		rte
				
;---------------------
; Vertical Blank
;---------------------
VBlank:

		rte

;---------------------
; VDP registers array
;---------------------

VDPSetupArray:
		dc.w	$8004
		dc.w	$8134
		dc.w	$8230
		dc.w	$8338
		dc.w	$8407
		dc.w	$857c
		dc.w	$8600
		dc.w	$8700
		dc.w	$8800
		dc.w	$8900
		dc.w	$8A00
		dc.w	$8B00
		dc.w	$8C81
		dc.w	$8D3F
		dc.w	$8E00
		dc.w	$8F02
		dc.w	$9001
		dc.w	$9100
		dc.w	$9200
		dc.w	$93FF
		dc.w	$94FF
		dc.w	$9500
		dc.w	$9600
		dc.w	$9780
VDPSetupArrayEnd:


;---------------------
; Z80 init code
;---------------------

Z80Init:
	dc.w	$af01, $d91f, $1127, $0021, $2600, $f977 
	dc.w    $edb0, $dde1, $fde1, $ed47, $ed4f, $d1e1                                   
	dc.w    $f108, $d9c1, $d1e1, $f1f9, $f3ed, $5636
	dc.w	$e9e9 
Z80InitEnd:

;---------------------
; Music driver (z80)
;---------------------		

Z80Driver:
		dc.b	$c3,$46,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
		dc.b	$00,$00,$00,$00,$00,$f3,$ed,$56,$31,$00,$20,$3a,$39,$00,$b7,$ca,$4c,$00,$21,$3a,$00,$11,$40,$00,$01,$06,$00,$ed,$b0,$3e,$00,$32,$39,$00,$3e,$b4,$32,$02,$40,$3e,$c0,$32,$03,$40,$3e,$2b,$32,$00,$40,$3e,$80,$32,$01,$40,$3a,$43,$00,$4f,$3a,$44,$00,$47,$3e,$06,$3d
		dc.b	$c2,$81,$00,$21,$00,$60,$3a,$41,$00,$07,$77,$3a,$42,$00,$77,$0f,$77,$0f,$77,$0f,$77,$0f,$77,$0f,$77,$0f,$77,$0f,$77,$3a,$40,$00,$6f,$3a,$41,$00,$f6,$80,$67,$3e,$2a,$32,$00,$40,$7e,$32,$01,$40,$21,$40,$00,$7e,$c6,$01,$77,$23,$7e,$ce,$00,$77,$23,$7e,$ce,$00,$77
		dc.b	$3a,$39,$00,$b7,$c2,$4c,$00,$0b,$78,$b1,$c2,$7f,$00,$3a,$45,$00,$b7,$ca,$4c,$00,$3d,$3a,$45,$00,$06,$ff,$0e,$ff,$c3,$7f,$00
Z80DriverEnd:

Font:
		dc.b   0,  0,  0,  0,  0,  0,  0,  0,$7E,$81,$A5,$81,$BD,$99,$81,$7E,$7E,$FF,$DB,$FF,$C3,$E7,$FF,$7E,$6C,$FE,$FE,$FE,$7C,$38,$10,  0,$10,$38,$7C,$FE,$7C,$38,$10,  0,$38,$7C,$38,$FE,$FE,$7C,$38,$7C,$10,$10,$38,$7C,$FE,$7C,$38,$7C,  0,  0,$18,$3C,$3C,$18,  0,  0; 0
		dc.b $FF,$FF,$E7,$C3,$C3,$E7,$FF,$FF,  0,$3C,$66,$42,$42,$66,$3C,  0,$FF,$C3,$99,$BD,$BD,$99,$C3,$FF, $F,  7, $F,$7D,$CC,$CC,$CC,$78,$3C,$66,$66,$66,$3C,$18,$7E,$18,$3F,$33,$3F,$30,$30,$70,$F0,$E0,$7F,$63,$7F,$63,$63,$67,$E6,$C0,$99,$5A,$3C,$E7,$E7,$3C,$5A,$99; 64
		dc.b $80,$E0,$F8,$FE,$F8,$E0,$80,  0,  2, $E,$3E,$FE,$3E, $E,  2,  0,$18,$3C,$7E,$18,$18,$7E,$3C,$18,$66,$66,$66,$66,$66,  0,$66,  0,$7F,$DB,$DB,$7B,$1B,$1B,$1B,  0,$3E,$63,$38,$6C,$6C,$38,$CC,$78,  0,  0,  0,  0,$7E,$7E,$7E,  0,$18,$3C,$7E,$18,$7E,$3C,$18,$FF; 128
		dc.b $18,$3C,$7E,$18,$18,$18,$18,  0,$18,$18,$18,$18,$7E,$3C,$18,  0,  0,$18, $C,$FE, $C,$18,  0,  0,  0,$30,$60,$FE,$60,$30,  0,  0,  0,  0,$C0,$C0,$C0,$FE,  0,  0,  0,$24,$66,$FF,$66,$24,  0,  0,  0,$18,$3C,$7E,$FF,$FF,  0,  0,  0,$FF,$FF,$7E,$3C,$18,  0,  0; 192
		dc.b   0,  0,  0,  0,  0,  0,  0,  0,$30,$30,$30,$30,$30,  0,$30,  0,$6C,$6C,$6C,  0,  0,  0,  0,  0,$6C,$6C,$FE,$6C,$FE,$6C,$6C,  0,$30,$7C,$C0,$78, $C,$F8,$30,  0,  0,$C6,$CC,$18,$30,$66,$C6,  0,$38,$6C,$38,$76,$DC,$CC,$76,  0,$60,$60,$C0,  0,  0,  0,  0,  0; 256
		dc.b $18,$30,$60,$60,$60,$30,$18,  0,$60,$30,$18,$18,$18,$30,$60,  0,  0,$66,$3C,$FF,$3C,$66,  0,  0,  0,$30,$30,$FC,$30,$30,  0,  0,  0,  0,  0,  0,  0,$30,$30,$60,  0,  0,  0,$FC,  0,  0,  0,  0,  0,  0,  0,  0,  0,$30,$30,  0,  6, $C,$18,$30,$60,$C0,$80,  0; 320
		dc.b $7C,$C6,$CE,$DE,$F6,$E6,$7C,  0,$30,$70,$30,$30,$30,$30,$FC,  0,$78,$CC, $C,$38,$60,$CC,$FC,  0,$78,$CC, $C,$38, $C,$CC,$78,  0,$1C,$3C,$6C,$CC,$FE, $C,$1E,  0,$FC,$C0,$F8, $C, $C,$CC,$78,  0,$38,$60,$C0,$F8,$CC,$CC,$78,  0,$FC,$CC, $C,$18,$30,$30,$30,  0; 384
		dc.b $78,$CC,$CC,$78,$CC,$CC,$78,  0,$78,$CC,$CC,$7C, $C,$18,$70,  0,  0,$30,$30,  0,  0,$30,$30,  0,  0,$30,$30,  0,  0,$30,$30,$60,$18,$30,$60,$C0,$60,$30,$18,  0,  0,  0,$FC,  0,  0,$FC,  0,  0,$60,$30,$18, $C,$18,$30,$60,  0,$78,$CC, $C,$18,$30,  0,$30,  0; 448
		dc.b $7C,$C6,$DE,$DE,$DE,$C0,$78,  0,$30,$78,$CC,$CC,$FC,$CC,$CC,  0,$FC,$66,$66,$7C,$66,$66,$FC,  0,$3C,$66,$C0,$C0,$C0,$66,$3C,  0,$F8,$6C,$66,$66,$66,$6C,$F8,  0,$7E,$60,$60,$78,$60,$60,$7E,  0,$7E,$60,$60,$78,$60,$60,$60,  0,$3C,$66,$C0,$C0,$CE,$66,$3E,  0; 512
		dc.b $CC,$CC,$CC,$FC,$CC,$CC,$CC,  0,$78,$30,$30,$30,$30,$30,$78,  0,$1E, $C, $C, $C,$CC,$CC,$78,  0,$E6,$66,$6C,$78,$6C,$66,$E6,  0,$60,$60,$60,$60,$60,$60,$7E,  0,$C6,$EE,$FE,$FE,$D6,$C6,$C6,  0,$C6,$E6,$F6,$DE,$CE,$C6,$C6,  0,$38,$6C,$C6,$C6,$C6,$6C,$38,  0; 576
		dc.b $FC,$66,$66,$7C,$60,$60,$F0,  0,$78,$CC,$CC,$CC,$DC,$78,$1C,  0,$FC,$66,$66,$7C,$6C,$66,$E6,  0,$78,$CC,$E0,$78,$1C,$CC,$78,  0,$FC,$30,$30,$30,$30,$30,$30,  0,$CC,$CC,$CC,$CC,$CC,$CC,$FC,  0,$CC,$CC,$CC,$CC,$CC,$78,$30,  0,$C6,$C6,$C6,$D6,$FE,$EE,$C6,  0; 640
		dc.b $C6,$C6,$6C,$38,$38,$6C,$C6,  0,$CC,$CC,$CC,$78,$30,$30,$78,  0,$FE,  6, $C,$18,$30,$60,$FE,  0,$78,$60,$60,$60,$60,$60,$78,  0,$C0,$60,$30,$18, $C,  6,  2,  0,$78,$18,$18,$18,$18,$18,$78,  0,$10,$38,$6C,$C6,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,$FF; 704
		dc.b $30,$30,$18,  0,  0,  0,  0,  0,  0,  0,$78, $C,$7C,$CC,$76,  0,$E0,$60,$60,$7C,$66,$66,$DC,  0,  0,  0,$78,$CC,$C0,$CC,$78,  0,$1C, $C, $C,$7C,$CC,$CC,$76,  0,  0,  0,$78,$CC,$FC,$C0,$78,  0,$38,$6C,$60,$F0,$60,$60,$F0,  0,  0,  0,$76,$CC,$CC,$7C, $C,$F8; 768
		dc.b $E0,$60,$6C,$76,$66,$66,$E6,  0,$30,  0,$70,$30,$30,$30,$78,  0, $C,  0, $C, $C, $C,$CC,$CC,$78,$E0,$60,$66,$6C,$78,$6C,$E6,  0,$70,$30,$30,$30,$30,$30,$78,  0,  0,  0,$CC,$FE,$FE,$D6,$C6,  0,  0,  0,$F8,$CC,$CC,$CC,$CC,  0,  0,  0,$78,$CC,$CC,$CC,$78,  0; 832
		dc.b   0,  0,$DC,$66,$66,$7C,$60,$F0,  0,  0,$76,$CC,$CC,$7C, $C,$1E,  0,  0,$DC,$76,$66,$60,$F0,  0,  0,  0,$7C,$C0,$78, $C,$F8,  0,$10,$30,$7C,$30,$30,$34,$18,  0,  0,  0,$CC,$CC,$CC,$CC,$76,  0,  0,  0,$CC,$CC,$CC,$78,$30,  0,  0,  0,$C6,$D6,$FE,$FE,$6C,  0; 896
		dc.b   0,  0,$C6,$6C,$38,$6C,$C6,  0,  0,  0,$CC,$CC,$CC,$7C, $C,$F8,  0,  0,$FC,$98,$30,$64,$FC,  0,$1C,$30,$30,$E0,$30,$30,$1C,  0,$18,$18,$18,  0,$18,$18,$18,  0,$E0,$30,$30,$1C,$30,$30,$E0,  0,$76,$DC,  0,  0,  0,  0,  0,  0,  0,$10,$38,$6C,$C6,$FE,  0,  0; 960
		dc.b $3C,$66,$C0,$C0,$66,$3C,  8,$18,$28,  0,$CC,$CC,$CC,$CC,$76,  0,  8,$10,$78,$CC,$FC,$C0,$78,  0,$10,$28,$78, $C,$7C,$CC,$76,  0,$28,  0,$78, $C,$7C,$CC,$76,  0,$20,$10,$78, $C,$7C,$CC,$76,  0,$18,$18,$78, $C,$7C,$CC,$76,  0,  0,$78,$CC,$C0,$CC,$78,$10,$30; 1024
		dc.b $10,$28,$78,$CC,$FC,$C0,$78,  0,$28,  0,$78,$CC,$FC,$C0,$78,  0,$20,$10,$78,$CC,$FC,$C0,$78,  0,$28,  0,$70,$30,$30,$30,$78,  0,$10,$28,$70,$30,$30,$30,$78,  0,$10,  8,$70,$30,$30,$30,$78,  0,$28,$30,$78,$CC,$FC,$CC,$CC,  0,$30,$48,$30,$CC,$FC,$CC,$CC,  0; 1088
		dc.b   8,$10,$7E,$60,$78,$60,$7E,  0,  0,  0,$6C,$12,$7E,$90,$7E,  0,$3E,$50,$90,$9C,$F0,$90,$9E,  0,$10,$28,$78,$CC,$CC,$CC,$78,  0,$28,  0,$78,$CC,$CC,$CC,$78,  0,$20,$10,$78,$CC,$CC,$CC,$78,  0,$10,$28,$CC,$CC,$CC,$CC,$76,  0,$20,$10,$CC,$CC,$CC,$CC,$76,  0; 1152
		dc.b $28,  0,$CC,$CC,$CC,$7C, $C,$F8,$28,$7C,$C6,$C6,$C6,$C6,$7C,  0,$28,$C6,$C6,$C6,$C6,$C6,$7C,  0,  0,$10,$78,$CC,$C0,$CC,$78,$10,$38,$44,$40,$F0,$40,$40,$FE,  0,$C3,$66,$3C,$7E,$18,$7E,$18,  0,$FC,$66,$66,$7C,$60,$60,$F0,  0,$1C,$30,$FC,$30,$30,$30,$30,$E0; 1216
		dc.b   8,$10,$78, $C,$7C,$CC,$76,  0,$10,$20,$70,$30,$30,$30,$78,  0,$10,$20,$78,$CC,$CC,$CC,$78,  0,$10,$20,$CC,$CC,$CC,$CC,$76,  0,$32,$4C,$F8,$CC,$CC,$CC,$CC,  0,$32,$4C,$C6,$E6,$D6,$CE,$C6,  0,  0,$38, $C,$3C,$6C,$36,  0,  0,  0,$38,$44,$44,$38,  0,  0,  0; 1280
		dc.b $18,  0,$18,$30,$60,$66,$3C,  0,  0,  0,$FE,$80,$80,  0,  0,  0,  0,  0,$FE,  2,  2,  0,  0,  0,$42,$44,$48,$56,$29,$46,$88,$1F,$42,$44,$48,$56,$2A,$5F,$82,  7,$30,  0,$30,$30,$30,$30,$30,  0,  0,$24,$48,$90,$48,$24,  0,  0,  0,$48,$24,$12,$24,$48,  0,  0; 1344
		dc.b $88,$22,$88,$22,$88,  0,$88,$22,$AA,$55,$AA,$55,$AA,  0,$AA,$55,$77,$DD,$77,$DD,$77,$FF,$77,$DD,$10,$10,$10,$10,$10,$10,$10,$10,$10,$10,$10,$F0,$10,$10,$10,$10,$10,$10,$F0,$10,$F0,$10,$10,$10,$28,$28,$28,$E8,$28,$28,$28,$28,  0,  0,  0,$F8,$28,$28,$28,$28; 1408
		dc.b   0,  0,$F0,$10,$F0,$10,$10,$10,$28,$28,$E8,  8,$E8,$28,$28,$28,$28,$28,$28,$28,$28,$28,$28,$28,  0,  0,$F8,  8,$E8,$28,$28,$28,$28,$28,$E8,  8,$F8,  0,  0,  0,$28,$28,$28,$F8,  0,  0,  0,  0,$10,$10,$F0,$10,$F0,  0,  0,  0,  0,  0,  0,$F0,$10,$10,$10,$10; 1472
		dc.b $10,$10,$10,$1F,  0,  0,  0,  0,$10,$10,$10,$FF,  0,  0,  0,  0,  0,  0,  0,$FF,$10,$10,$10,$10,$10,$10,$10,$1F,$10,$10,$10,$10,  0,  0,  0,$FF,  0,  0,  0,  0,$10,$10,$10,$FF,$10,$10,$10,$10,$10,$10,$1F,$10,$1F,$10,$10,$10,$28,$28,$28,$2F,$28,$28,$28,$28; 1536
		dc.b $28,$28,$2F,$20,$3F,  0,  0,  0,  0,  0,$3F,$20,$2F,$28,$28,$28,$28,$28,$EF,  0,$FF,  0,  0,  0,  0,  0,$FF,  0,$EF,$28,$28,$28,$28,$28,$2F,$20,$2F,$28,$28,$28,  0,  0,$FF,  0,$FF,  0,  0,  0,$28,$28,$EF,  0,$EF,$28,$28,$28,$10,$10,$FF,  0,$FF,  0,  0,  0; 1600
		dc.b $28,$28,$28,$FF,  0,  0,  0,  0,  0,  0,$FF,  0,$FF,$10,$10,$10,  0,  0,  0,$FF,$28,$28,$28,$28,$28,$28,$28,$3F,  0,  0,  0,  0,$10,$10,$1F,$10,$1F,  0,  0,  0,  0,  0,$1F,$10,$1F,$10,$10,$10,  0,  0,  0,$3F,$28,$28,$28,$28,$28,$28,$28,$FF,$28,$28,$28,$28; 1664
		dc.b $10,$10,$FF,$10,$FF,$10,$10,$10,$10,$10,$10,$F0,  0,  0,  0,  0,  0,  0,  0,$1F,$10,$10,$10,$10,$FF,$FF,$FF,$FF,$FF,$FF,$FF,$FF,  0,  0,  0,  0,$FF,$FF,$FF,$FF,$F0,$F0,$F0,$F0,$F0,$F0,$F0,$F0, $F, $F, $F, $F, $F, $F, $F, $F,$FF,$FF,$FF,$FF,  0,  0,  0,  0; 1728
		dc.b   0,  0,  0,$72,$8C,$88,$3A,  0,$30,$48,$48,$7C,$42,$42,$DC,  0,  0,  0,$FE,$42,$40,$40,$E0,  0,  0,  0,$FE,$44,$44,$44,$EE,  0,$FE,$42,$20,$10,$20,$42,$FE,  0,  0,  0,  0,$3E,$44,$44,$38,  0,  0,  0,$CC,$44,$44,$44,$7A,$40,  0,  0,$7C,$10,$10,$10,$1C,  0; 1792
		dc.b   0,$10,$7C,$92,$92,$7C,$10,  0,  0,  0,$7C,$82,$BA,$82,$7C,  0,  0,$7C,$82,$82,$6C,$28,$EE,  0,  0,$7C,$20,$38,$44,$44,$38,  0,  0,  0,$6C,$92,$92,$6C,  0,  0,  0,  0,$4C,$92,$92,$7C,$10,  0,  0,  0,$3C,$40,$30,$40,$3C,  0,  0,  0,$3C,$42,$42,$42,$42,  0; 1856
		dc.b   0		; 1920

RomEnd: