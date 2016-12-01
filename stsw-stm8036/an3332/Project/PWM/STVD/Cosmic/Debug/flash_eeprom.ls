   1                     ; C Compiler for STM8 (COSMIC Software)
   2                     ; Parser V4.8.32 - 23 Mar 2010
   3                     ; Generator V4.3.4 - 23 Mar 2010
   4                     ; Optimizer V4.3.3 - 10 Feb 2010
 241                     ; 44 void WriteMultiBlockByte(BlockStartAddress_TypeDef BlockStartAddress,FLASH_MemType_TypeDef FLASH_MemType, 
 241                     ; 45                 FLASH_ProgramMode_TypeDef FLASH_ProgMode, uint8_t *Buffer,uint8_t BlockNum)
 241                     ; 46 {
 243                     .text:	section	.text,new
 244  0000               _WriteMultiBlockByte:
 246  0000 89            	pushw	x
 247  0001 89            	pushw	x
 248       00000002      OFST:	set	2
 251                     ; 47   uint8_t  BlockNum_Temp,blocknum=0;
 253  0002 0f01          	clr	(OFST-1,sp)
 254                     ; 49   FLASH_Unlock(FLASH_MEMTYPE_DATA);
 256  0004 a6f7          	ld	a,#247
 257  0006 cd0000        	call	_FLASH_Unlock
 260  0009               L131:
 261                     ; 51   while (FLASH_GetFlagStatus(FLASH_FLAG_DUL) == RESET)
 263  0009 a608          	ld	a,#8
 264  000b cd0000        	call	_FLASH_GetFlagStatus
 266  000e 4d            	tnz	a
 267  000f 27f8          	jreq	L131
 268                     ; 53   for(BlockNum_Temp=BlockStartAddress;BlockNum_Temp<BlockNum;BlockNum_Temp++)
 270  0011 7b03          	ld	a,(OFST+1,sp)
 271  0013 6b02          	ld	(OFST+0,sp),a
 273  0015 2030          	jra	L141
 274  0017               L531:
 275                     ; 55     if(BlockNum_Temp>FLASH_DATA_BLOCKS_NUMBER)
 277  0017 a10b          	cp	a,#11
 278  0019 2508          	jrult	L541
 279                     ; 56       break;
 280  001b               L341:
 281                     ; 64   FLASH_Lock(FLASH_MEMTYPE_DATA);/*操作完要加锁*/
 283  001b a6f7          	ld	a,#247
 284  001d cd0000        	call	_FLASH_Lock
 286                     ; 66 }
 289  0020 5b04          	addw	sp,#4
 290  0022 81            	ret	
 291  0023               L541:
 292                     ; 58       FLASH_ProgramBlock(BlockNum_Temp, FLASH_MemType, FLASH_ProgMode,Buffer+blocknum*FLASH_BLOCK_SIZE);
 294  0023 7b01          	ld	a,(OFST-1,sp)
 295  0025 97            	ld	xl,a
 296  0026 a640          	ld	a,#64
 297  0028 42            	mul	x,a
 298  0029 72fb08        	addw	x,(OFST+6,sp)
 299  002c 89            	pushw	x
 300  002d 7b09          	ld	a,(OFST+7,sp)
 301  002f 88            	push	a
 302  0030 7b07          	ld	a,(OFST+5,sp)
 303  0032 88            	push	a
 304  0033 7b06          	ld	a,(OFST+4,sp)
 305  0035 5f            	clrw	x
 306  0036 97            	ld	xl,a
 307  0037 cd0000        	call	_FLASH_ProgramBlock
 309  003a 5b04          	addw	sp,#4
 310                     ; 59       blocknum++;
 312  003c 0c01          	inc	(OFST-1,sp)
 313                     ; 60       FLASH_WaitForLastOperation(FLASH_MemType);
 315  003e 7b04          	ld	a,(OFST+2,sp)
 316  0040 cd0000        	call	_FLASH_WaitForLastOperation
 318                     ; 53   for(BlockNum_Temp=BlockStartAddress;BlockNum_Temp<BlockNum;BlockNum_Temp++)
 320  0043 0c02          	inc	(OFST+0,sp)
 321  0045 7b02          	ld	a,(OFST+0,sp)
 322  0047               L141:
 325  0047 110a          	cp	a,(OFST+8,sp)
 326  0049 25cc          	jrult	L531
 327  004b 20ce          	jra	L341
 409                     .const:	section	.text
 410  0000               L22:
 411  0000 00004000      	dc.l	16384
 412                     ; 88 void ReadMultiBlockByte(BlockStartAddress_TypeDef BlockStartAddress,uint8_t BlockNum,
 412                     ; 89                         uint8_t ReadBlockByte[])
 412                     ; 90 {
 413                     .text:	section	.text,new
 414  0000               _ReadMultiBlockByte:
 416  0000 89            	pushw	x
 417  0001 5208          	subw	sp,#8
 418       00000008      OFST:	set	8
 421                     ; 92   start_add = FLASH_DATA_START_PHYSICAL_ADDRESS+(u32)((BlockNum-1)*FLASH_BLOCK_SIZE);
 423  0003 a640          	ld	a,#64
 424  0005 42            	mul	x,a
 425  0006 1d0040        	subw	x,#64
 426  0009 ad44          	call	LC001
 428  000b 96            	ldw	x,sp
 429  000c 1c0005        	addw	x,#OFST-3
 430  000f cd0000        	call	c_rtol
 432                     ; 93   stop_add = FLASH_DATA_START_PHYSICAL_ADDRESS + (u32)(BlockNum*FLASH_BLOCK_SIZE);
 434  0012 7b0a          	ld	a,(OFST+2,sp)
 435  0014 97            	ld	xl,a
 436  0015 a640          	ld	a,#64
 437  0017 42            	mul	x,a
 438  0018 ad35          	call	LC001
 440  001a 96            	ldw	x,sp
 441  001b 5c            	incw	x
 442  001c cd0000        	call	c_rtol
 444                     ; 95   for (add = start_add; add < stop_add; add++)
 447  001f 201d          	jra	L512
 448  0021               L112:
 449                     ; 96       ReadBlockByte[add-FLASH_DATA_START_PHYSICAL_ADDRESS]=FLASH_ReadByte(add);
 451  0021 1e07          	ldw	x,(OFST-1,sp)
 452  0023 89            	pushw	x
 453  0024 1e07          	ldw	x,(OFST-1,sp)
 454  0026 89            	pushw	x
 455  0027 cd0000        	call	_FLASH_ReadByte
 457  002a 5b04          	addw	sp,#4
 458  002c 1e07          	ldw	x,(OFST-1,sp)
 459  002e 1d4000        	subw	x,#16384
 460  0031 72fb0d        	addw	x,(OFST+5,sp)
 461  0034 f7            	ld	(x),a
 462                     ; 95   for (add = start_add; add < stop_add; add++)
 464  0035 96            	ldw	x,sp
 465  0036 1c0005        	addw	x,#OFST-3
 466  0039 a601          	ld	a,#1
 467  003b cd0000        	call	c_lgadc
 469  003e               L512:
 472  003e 96            	ldw	x,sp
 473  003f 1c0005        	addw	x,#OFST-3
 474  0042 cd0000        	call	c_ltor
 476  0045 96            	ldw	x,sp
 477  0046 5c            	incw	x
 478  0047 cd0000        	call	c_lcmp
 480  004a 25d5          	jrult	L112
 481                     ; 99 }
 484  004c 5b0a          	addw	sp,#10
 485  004e 81            	ret	
 486  004f               LC001:
 487  004f cd0000        	call	c_itolx
 489  0052 ae0000        	ldw	x,#L22
 490  0055 cc0000        	jp	c_ladd
 503                     	xdef	_ReadMultiBlockByte
 504                     	xdef	_WriteMultiBlockByte
 505                     	xref	_FLASH_WaitForLastOperation
 506                     	xref	_FLASH_ProgramBlock
 507                     	xref	_FLASH_GetFlagStatus
 508                     	xref	_FLASH_ReadByte
 509                     	xref	_FLASH_Lock
 510                     	xref	_FLASH_Unlock
 529                     	xref	c_lcmp
 530                     	xref	c_ltor
 531                     	xref	c_lgadc
 532                     	xref	c_rtol
 533                     	xref	c_ladd
 534                     	xref	c_itolx
 535                     	end
