   1                     ; C Compiler for STM8 (COSMIC Software)
   2                     ; Parser V4.8.32 - 23 Mar 2010
   3                     ; Generator V4.3.4 - 23 Mar 2010
   4                     ; Optimizer V4.3.3 - 10 Feb 2010
  20                     	bsct
  21  0000               _SLAVE_ADDRESS:
  22  0000 50            	dc.b	80
  23  0001               _IIC_RECV_ONE_FRAME_OK:
  24  0001 00            	dc.b	0
  25  0002               _IIC_BUF:
  26  0002 00            	dc.b	0
  27  0003 000000000000  	ds.b	9
  28  000c               _Rev_Cnt:
  29  000c 00            	dc.b	0
  62                     ; 19 	void I2C_transaction_begin(void)
  62                     ; 20 	{
  64                     .text:	section	.text,new
  65  0000               _I2C_transaction_begin:
  69                     ; 21 		MessageBegin = TRUE;
  71  0000 35010003      	mov	_MessageBegin,#1
  72                     ; 22 		Rev_Cnt=0;
  74  0004 3f0c          	clr	_Rev_Cnt
  75                     ; 24 	}
  78  0006 81            	ret	
 102                     ; 25 	void I2C_transaction_end(void)
 102                     ; 26 	{
 103                     .text:	section	.text,new
 104  0000               _I2C_transaction_end:
 108                     ; 29 	}
 111  0000 81            	ret	
 179                     ; 30 	void I2C_byte_received(u8 u8_RxData)
 179                     ; 31 	{
 180                     .text:	section	.text,new
 181  0000               _I2C_byte_received:
 183  0000 88            	push	a
 184  0001 5204          	subw	sp,#4
 185       00000004      OFST:	set	4
 188                     ; 32 		unsigned char i=0;
 190                     ; 33 		unsigned int temp=0;
 192                     ; 34 		unsigned char SumCheck=0;
 194                     ; 36 		if (MessageBegin == TRUE  &&  u8_RxData < MAX_BUFFER) {
 196  0003 b603          	ld	a,_MessageBegin
 197  0005 4a            	dec	a
 198  0006 2610          	jrne	L36
 200  0008 7b05          	ld	a,(OFST+1,sp)
 201  000a a120          	cp	a,#32
 202  000c 240a          	jruge	L36
 203                     ; 37 			u8_MyBuffp= &u8_My_Buffer[u8_RxData];
 205  000e ab06          	add	a,#_u8_My_Buffer
 206  0010 5f            	clrw	x
 207  0011 97            	ld	xl,a
 208  0012 bf04          	ldw	_u8_MyBuffp,x
 209                     ; 38 			MessageBegin = FALSE;
 211  0014 3f03          	clr	_MessageBegin
 213  0016 200d          	jra	L56
 214  0018               L36:
 215                     ; 40     else if(u8_MyBuffp < &u8_My_Buffer[MAX_BUFFER])
 217  0018 be04          	ldw	x,_u8_MyBuffp
 218  001a a30026        	cpw	x,#_u8_My_Buffer+32
 219  001d 2406          	jruge	L56
 220                     ; 41       *(u8_MyBuffp++) = u8_RxData;
 222  001f 7b05          	ld	a,(OFST+1,sp)
 223  0021 f7            	ld	(x),a
 224  0022 5c            	incw	x
 225  0023 bf04          	ldw	_u8_MyBuffp,x
 226  0025               L56:
 227                     ; 43 		Rev_Cnt++;
 229  0025 3c0c          	inc	_Rev_Cnt
 230                     ; 44 		if(	Rev_Cnt>10){
 232  0027 b60c          	ld	a,_Rev_Cnt
 233  0029 a10b          	cp	a,#11
 234  002b 2573          	jrult	L17
 235                     ; 45 			Rev_Cnt=0;
 237  002d 3f0c          	clr	_Rev_Cnt
 238                     ; 48 			UART1_printf("Receive 10 Bytes\r\n:");
 240  002f ae004a        	ldw	x,#L37
 241  0032 cd0000        	call	_UART1_printf
 243                     ; 49 			for(i=0;i<10;i++){
 245  0035 4f            	clr	a
 246  0036 6b04          	ld	(OFST+0,sp),a
 247  0038               L57:
 248                     ; 50 				temp=u8_My_Buffer[i];
 250  0038 5f            	clrw	x
 251  0039 97            	ld	xl,a
 252  003a e606          	ld	a,(_u8_My_Buffer,x)
 253  003c 5f            	clrw	x
 254  003d 97            	ld	xl,a
 255  003e 1f02          	ldw	(OFST-2,sp),x
 256                     ; 51 				UART1_printf("%d-",temp);
 258  0040 89            	pushw	x
 259  0041 ae0046        	ldw	x,#L301
 260  0044 cd0000        	call	_UART1_printf
 262  0047 85            	popw	x
 263                     ; 49 			for(i=0;i<10;i++){
 265  0048 0c04          	inc	(OFST+0,sp)
 268  004a 7b04          	ld	a,(OFST+0,sp)
 269  004c a10a          	cp	a,#10
 270  004e 25e8          	jrult	L57
 271                     ; 53 			UART1_printf("\r\n");
 273  0050 ae0043        	ldw	x,#L501
 274  0053 cd0000        	call	_UART1_printf
 276                     ; 56 			SumCheck=0;
 278  0056 0f01          	clr	(OFST-3,sp)
 279                     ; 57 			for(i=0;i<5;i++)
 281  0058 4f            	clr	a
 282  0059 6b04          	ld	(OFST+0,sp),a
 283  005b               L701:
 284                     ; 59 				SumCheck+=u8_My_Buffer[i];
 286  005b 5f            	clrw	x
 287  005c 97            	ld	xl,a
 288  005d 7b01          	ld	a,(OFST-3,sp)
 289  005f eb06          	add	a,(_u8_My_Buffer,x)
 290  0061 6b01          	ld	(OFST-3,sp),a
 291                     ; 57 			for(i=0;i<5;i++)
 293  0063 0c04          	inc	(OFST+0,sp)
 296  0065 7b04          	ld	a,(OFST+0,sp)
 297  0067 a105          	cp	a,#5
 298  0069 25f0          	jrult	L701
 299                     ; 61 			if(SumCheck==u8_My_Buffer[5])//ok
 301  006b 7b01          	ld	a,(OFST-3,sp)
 302  006d b10b          	cp	a,_u8_My_Buffer+5
 303  006f 2629          	jrne	L511
 304                     ; 63 				UART1_printf("Check Sum ok\r\n");
 306  0071 ae0034        	ldw	x,#L711
 307  0074 cd0000        	call	_UART1_printf
 309                     ; 64 				if(IIC_RECV_ONE_FRAME_OK==0){
 311  0077 3d01          	tnz	_IIC_RECV_ONE_FRAME_OK
 312  0079 261a          	jrne	L121
 313                     ; 65 					IIC_RECV_ONE_FRAME_OK=1;
 315  007b 35010001      	mov	_IIC_RECV_ONE_FRAME_OK,#1
 316                     ; 66 					for(i=0;i<10;i++)
 318  007f 4f            	clr	a
 319  0080 6b04          	ld	(OFST+0,sp),a
 320  0082               L321:
 321                     ; 67 					IIC_BUF[i]=u8_My_Buffer[i];
 323  0082 5f            	clrw	x
 324  0083 97            	ld	xl,a
 325  0084 e606          	ld	a,(_u8_My_Buffer,x)
 326  0086 e702          	ld	(_IIC_BUF,x),a
 327                     ; 66 					for(i=0;i<10;i++)
 329  0088 0c04          	inc	(OFST+0,sp)
 332  008a 7b04          	ld	a,(OFST+0,sp)
 333  008c a10a          	cp	a,#10
 334  008e 25f2          	jrult	L321
 335                     ; 68 					UART1_printf("New Cmd come\r\n");
 337  0090 ae0025        	ldw	x,#L131
 340  0093 2008          	jp	LC001
 341  0095               L121:
 342                     ; 71 					UART1_printf("Old Cmd not deal\r\n");
 344  0095 ae0012        	ldw	x,#L531
 346  0098 2003          	jp	LC001
 347  009a               L511:
 348                     ; 77 				UART1_printf("Check Sum error\r\n");
 350  009a ae0000        	ldw	x,#L141
 351  009d               LC001:
 352  009d cd0000        	call	_UART1_printf
 354  00a0               L17:
 355                     ; 81 	}
 358  00a0 5b05          	addw	sp,#5
 359  00a2 81            	ret	
 384                     ; 82 	u8 I2C_byte_write(void)
 384                     ; 83 	{
 385                     .text:	section	.text,new
 386  0000               _I2C_byte_write:
 390                     ; 84 		if (u8_MyBuffp < &u8_My_Buffer[MAX_BUFFER])
 392  0000 be04          	ldw	x,_u8_MyBuffp
 393  0002 a30026        	cpw	x,#_u8_My_Buffer+32
 394  0005 2406          	jruge	L351
 395                     ; 85 			return *(u8_MyBuffp++);
 397  0007 5c            	incw	x
 398  0008 bf04          	ldw	_u8_MyBuffp,x
 399  000a 5a            	decw	x
 400  000b f6            	ld	a,(x)
 403  000c 81            	ret	
 404  000d               L351:
 405                     ; 87 			return 0x00;
 407  000d 4f            	clr	a
 410  000e 81            	ret	
 413                     	switch	.ubsct
 414  0000               L751_sr1:
 415  0000 00            	ds.b	1
 416  0001               L161_sr2:
 417  0001 00            	ds.b	1
 418  0002               L361_sr3:
 419  0002 00            	ds.b	1
 474                     ; 97 @far @interrupt void I2C_Slave_check_event(void) {
 476                     .text:	section	.text,new
 477  0000               f_I2C_Slave_check_event:
 479  0000 3b0002        	push	c_x+2
 480  0003 be00          	ldw	x,c_x
 481  0005 89            	pushw	x
 482  0006 3b0002        	push	c_y+2
 483  0009 be00          	ldw	x,c_y
 486                     ; 104 sr1 = I2C->SR1;
 488  000b 5552170000    	mov	L751_sr1,21015
 489                     ; 105 sr2 = I2C->SR2;
 491  0010 5552180001    	mov	L161_sr2,21016
 492                     ; 106 sr3 = I2C->SR3;
 494  0015 5552190002    	mov	L361_sr3,21017
 495  001a 89            	pushw	x
 496                     ; 109   if (sr2 & (I2C_SR2_WUFH | I2C_SR2_OVR |I2C_SR2_ARLO |I2C_SR2_BERR))
 498  001b b601          	ld	a,L161_sr2
 499  001d a52b          	bcp	a,#43
 500  001f 2708          	jreq	L312
 501                     ; 111     I2C->CR2|= I2C_CR2_STOP;  // stop communication - release the lines
 503  0021 72125211      	bset	21009,#1
 504                     ; 112     I2C->SR2= 0;					    // clear all error flags
 506  0025 725f5218      	clr	21016
 507  0029               L312:
 508                     ; 115   if ((sr1 & (I2C_SR1_RXNE | I2C_SR1_BTF)) == (I2C_SR1_RXNE | I2C_SR1_BTF))
 510  0029 b600          	ld	a,L751_sr1
 511  002b a444          	and	a,#68
 512  002d a144          	cp	a,#68
 513  002f 2606          	jrne	L512
 514                     ; 117     I2C_byte_received(I2C->DR);
 516  0031 c65216        	ld	a,21014
 517  0034 cd0000        	call	_I2C_byte_received
 519  0037               L512:
 520                     ; 120   if (sr1 & I2C_SR1_RXNE)
 522  0037 720d000006    	btjf	L751_sr1,#6,L712
 523                     ; 122     I2C_byte_received(I2C->DR);
 525  003c c65216        	ld	a,21014
 526  003f cd0000        	call	_I2C_byte_received
 528  0042               L712:
 529                     ; 125   if (sr2 & I2C_SR2_AF)
 531  0042 7205000107    	btjf	L161_sr2,#2,L122
 532                     ; 127     I2C->SR2 &= ~I2C_SR2_AF;	  // clear AF
 534  0047 72155218      	bres	21016,#2
 535                     ; 128 		I2C_transaction_end();
 537  004b cd0000        	call	_I2C_transaction_end
 539  004e               L122:
 540                     ; 131   if (sr1 & I2C_SR1_STOPF) 
 542  004e 7209000007    	btjf	L751_sr1,#4,L322
 543                     ; 133     I2C->CR2 |= I2C_CR2_ACK;	  // CR2 write to clear STOPF
 545  0053 72145211      	bset	21009,#2
 546                     ; 134 		I2C_transaction_end();
 548  0057 cd0000        	call	_I2C_transaction_end
 550  005a               L322:
 551                     ; 137   if (sr1 & I2C_SR1_ADDR)
 553  005a 7203000003    	btjf	L751_sr1,#1,L522
 554                     ; 139 		I2C_transaction_begin();
 556  005f cd0000        	call	_I2C_transaction_begin
 558  0062               L522:
 559                     ; 142   if ((sr1 & (I2C_SR1_TXE | I2C_SR1_BTF)) == (I2C_SR1_TXE | I2C_SR1_BTF))
 561  0062 b600          	ld	a,L751_sr1
 562  0064 a484          	and	a,#132
 563  0066 a184          	cp	a,#132
 564  0068 2606          	jrne	L722
 565                     ; 144 		I2C->DR = I2C_byte_write();
 567  006a cd0000        	call	_I2C_byte_write
 569  006d c75216        	ld	21014,a
 570  0070               L722:
 571                     ; 147   if (sr1 & I2C_SR1_TXE)
 573  0070 720f000006    	btjf	L751_sr1,#7,L132
 574                     ; 149 		I2C->DR = I2C_byte_write();
 576  0075 cd0000        	call	_I2C_byte_write
 578  0078 c75216        	ld	21014,a
 579  007b               L132:
 580                     ; 151 	GPIOD->ODR^=1;
 582  007b c6500f        	ld	a,20495
 583  007e a801          	xor	a,#1
 584  0080 c7500f        	ld	20495,a
 585                     ; 152 }
 588  0083 85            	popw	x
 589  0084 bf00          	ldw	c_y,x
 590  0086 320002        	pop	c_y+2
 591  0089 85            	popw	x
 592  008a bf00          	ldw	c_x,x
 593  008c 320002        	pop	c_x+2
 594  008f 80            	iret	
 617                     ; 157 void Init_I2C (void)
 617                     ; 158 {
 619                     .text:	section	.text,new
 620  0000               _Init_I2C:
 624                     ; 166 	GPIOB->DDR&= 0xcf;
 626  0000 c65007        	ld	a,20487
 627  0003 a4cf          	and	a,#207
 628  0005 c75007        	ld	20487,a
 629                     ; 167 	GPIOB->CR1&= 0xcf;
 631  0008 c65008        	ld	a,20488
 632  000b a4cf          	and	a,#207
 633  000d c75008        	ld	20488,a
 634                     ; 168 	GPIOB->CR2&= 0xcf;
 636  0010 c65009        	ld	a,20489
 637  0013 a4cf          	and	a,#207
 638  0015 c75009        	ld	20489,a
 639                     ; 172 		I2C->CR1 |= 0x01;				        	// Enable I2C peripheral
 641  0018 72105210      	bset	21008,#0
 642                     ; 173 		I2C->CR2 = 0x04;					      		// Enable I2C acknowledgement
 644  001c 35045211      	mov	21009,#4
 645                     ; 174 		I2C->FREQR = 16; 					      	// Set I2C Freq value (16MHz)
 647  0020 35105212      	mov	21010,#16
 648                     ; 175 		I2C->OARL = (SLAVE_ADDRESS << 1) ;	// set slave address to 0x51 (put 0xA2 for the register dues to7bit address) 
 650  0024 b600          	ld	a,_SLAVE_ADDRESS
 651  0026 48            	sll	a
 652  0027 c75213        	ld	21011,a
 653                     ; 176 		I2C->OARH = 0x40;					      	// Set 7bit address mode
 655  002a 35405214      	mov	21012,#64
 656                     ; 188 	I2C->ITR	= 0x07;					      // all I2C interrupt enable  
 658  002e 3507521a      	mov	21018,#7
 659                     ; 189 }
 662  0032 81            	ret	
 744                     	xdef	_I2C_byte_write
 745                     	xdef	_I2C_byte_received
 746                     	xdef	_I2C_transaction_end
 747                     	xdef	_I2C_transaction_begin
 748                     	xdef	_Rev_Cnt
 749                     	switch	.ubsct
 750  0003               _MessageBegin:
 751  0003 00            	ds.b	1
 752                     	xdef	_MessageBegin
 753  0004               _u8_MyBuffp:
 754  0004 0000          	ds.b	2
 755                     	xdef	_u8_MyBuffp
 756  0006               _u8_My_Buffer:
 757  0006 000000000000  	ds.b	32
 758                     	xdef	_u8_My_Buffer
 759                     	xdef	_IIC_BUF
 760                     	xdef	_IIC_RECV_ONE_FRAME_OK
 761                     	xdef	_SLAVE_ADDRESS
 762                     	xref	_UART1_printf
 763                     	xdef	f_I2C_Slave_check_event
 764                     	xdef	_Init_I2C
 765                     .const:	section	.text
 766  0000               L141:
 767  0000 436865636b20  	dc.b	"Check Sum error",13
 768  0010 0a00          	dc.b	10,0
 769  0012               L531:
 770  0012 4f6c6420436d  	dc.b	"Old Cmd not deal",13
 771  0023 0a00          	dc.b	10,0
 772  0025               L131:
 773  0025 4e657720436d  	dc.b	"New Cmd come",13
 774  0032 0a00          	dc.b	10,0
 775  0034               L711:
 776  0034 436865636b20  	dc.b	"Check Sum ok",13
 777  0041 0a00          	dc.b	10,0
 778  0043               L501:
 779  0043 0d0a00        	dc.b	13,10,0
 780  0046               L301:
 781  0046 25642d00      	dc.b	"%d-",0
 782  004a               L37:
 783  004a 526563656976  	dc.b	"Receive 10 Bytes",13
 784  005b 0a3a00        	dc.b	10,58,0
 785                     	xref.b	c_x
 786                     	xref.b	c_y
 806                     	end
