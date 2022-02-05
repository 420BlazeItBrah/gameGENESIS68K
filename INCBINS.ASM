Z80drv:                           
    INCBIN 'BIN/Z80_XGM.BIN'
Z80drv_end:

	ALIGN 256
NULLpcm:
    INCBIN 'BIN/NULL.RAW'
NULLpcmend:

	ALIGN 256
XGMsong:
    INCBIN 'MUSIC/BUP.XGC'
XGMsongend:

    ALIGN 256
LOOPpcm:
    INCBIN 'BIN/LOOP.RAW'
LOOPpcm_end:
     
    ALIGN 256
HATpcm:
    INCBIN 'BIN/HAT.RAW'
HATpcm_end:
     
    ALIGN 256
SNAREpcm:
    INCBIN 'BIN/SNARE.RAW'
SNAREpcm_end: