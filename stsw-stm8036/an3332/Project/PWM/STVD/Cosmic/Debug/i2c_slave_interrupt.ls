   1                     ; C Compiler for STM8 (COSMIC Software)
   2                     ; Parser V4.8.32 - 23 Mar 2010
   3                     ; Generator V4.3.4 - 23 Mar 2010
   4                     ; Optimizer V4.3.3 - 10 Feb 2010
  51                     ; 13 	void I2C_transaction_begin(void)
  51                     ; 14 	{
  53                     .text:	section	.text,new
  54  0000               _I2C_transaction_begin:
  58                     ; 15 		MessageBegin = TRUE;
  60  0000 35010003      	mov	_MessageBegin,#1
  61                     ; 16 	}
  64  0004 81            	ret	
  88                     ; 17 	void I2C_transaction_end(void)
  88                     ; 18 	{
  89                     .text:	section	.text,new
  90  0000               _I2C_transaction_end:
  94                     ; 20 	}
  97  0000 81            	ret	
 134                     ; 21 	void I2C_byte_received(u8 u8_RxData)
 134                     ; 22 	{
 135                     .text:	section	.text,new
 136  0000               _I2C_byte_received:
 138  0000 88            	push	a
 139       00000000      OFST:	set	0
 142                     ; 23 		if (MessageBegin == TRUE  &&  u8_RxData < MAX_BUFFER) {
 144  0001 b603          	ld	a,_MessageBegin
 145  0003 4a            	dec	a
 146  0004 2610          	jrne	L74
 148  0006 7b01          	ld	a,(OFST+1,sp)
 149  0008 a120          	cp	a,#32
 150  000a 240a          	jruge	L74
 151                     ; 24 			u8_MyBuffp= &u8_My_Buffer[u8_RxData];
 153  000c ab06          	add	a,#_u8_My_Buffer
 154  000e 5f            	clrw	x
 155  000f 97            	ld	xl,a
 156  0010 bf04          	ldw	_u8_MyBuffp,x
 157                     ; 25 			MessageBegin = FALSE;
 159  0012 3f03          	clr	_MessageBegin
 161  0014 200d          	jra	L15
 162  0016               L74:
 163                     ; 27     else if(u8_MyBuffp < &u8_My_Buffer[MAX_BUFFER])
 165  0016 be04          	ldw	x,_u8_MyBuffp
 166  0018 a30026        	cpw	x,#_u8_My_Buffer+32
 167  001b 2406          	jruge	L15
 168                     ; 28       *(u8_MyBuffp++) = u8_RxData;
 170  001d 7b01          	ld	a,(OFST+1,sp)
 171  001f f7            	ld	(x),a
 172  0020 5c            	incw	x
 173  0021 bf04          	ldw	_u8_MyBuffp,x
 174  0023               L15:
 175                     ; 29 	}
 178  0023 84            	pop	a
 179  0024 81            	ret	
 204                     ; 30 	u8 I2C_byte_write(void)
 204                     ; 31 	{
 205                     .text:	section	.text,new
 206  0000               _I2C_byte_write:
 210                     ; 32 		if (u8_MyBuffp < &u8_My_Buffer[MAX_BUFFER])
 212  0000 be04          	ldw	x,_u8_MyBuffp
 213  0002 a30026        	cpw	x,#_u8_My_Buffer+32
 214  0005 2406          	jruge	L56
 215                     ; 33 			return *(u8_MyBuffp++);
 217  0007 5c            	incw	x
 218  0008 bf04          	ldw	_u8_MyBuffp,x
 219  000a 5a            	decw	x
 220  000b f6            	ld	a,(x)
 223  000c 81            	ret	
 224  000d               L56:
 225                     ; 35 			return 0x00;
 227  000d 4f            	clr	a
 230  000e 81            	ret	
 233                     	switch	.ubsct
 234  0000               L17_sr1:
 235  0000 00            	ds.b	1
 236  0001               L37_sr2:
 237  0001 00            	ds.b	1
 238  0002               L57_sr3:
 239  0002 00            	ds.b	1
 294                     ; 45 @far @interrupt void I2C_Slave_check_event(void) {
 296                     .text:	section	.text,new
 297  0000               f_I2C_Slave_check_event:
 299  0000 3b0002        	push	c_x+2
 300  0003 be00          	ldw	x,c_x
 301  0005 89            	pushw	x
 302  0006 3b0002        	push	c_y+2
 303  0009 be00          	ldw	x,c_y
 306                     ; 52 sr1 = I2C->SR1;
 308  000b 5552170000    	mov	L17_sr1,21015
 309                     ; 53 sr2 = I2C->SR2;
 311  0010 5552180001    	mov	L37_sr2,21016
 312                     ; 54 sr3 = I2C->SR3;
 314  0015 5552190002    	mov	L57_sr3,21017
 315  001a 89            	pushw	x
 316                     ; 57   if (sr2 & (I2C_SR2_WUFH | I2C_SR2_OVR |I2C_SR2_ARLO |I2C_SR2_BERR))
 318  001b b601          	ld	a,L37_sr2
 319  001d a52b          	bcp	a,#43
 320  001f 2708          	jreq	L521
 321                     ; 59     I2C->CR2|= I2C_CR2_STOP;  // stop communication - release the lines
 323  0021 72125211      	bset	21009,#1
 324                     ; 60     I2C->SR2= 0;					    // clear all error flags
 326  0025 725f5218      	clr	21016
 327  0029               L521:
 328                     ; 63   if ((sr1 & (I2C_SR1_RXNE | I2C_SR1_BTF)) == (I2C_SR1_RXNE | I2C_SR1_BTF))
 330  0029 b600          	ld	a,L17_sr1
 331  002b a444          	and	a,#68
 332  002d a144          	cp	a,#68
 333  002f 2606          	jrne	L721
 334                     ; 65     I2C_byte_received(I2C->DR);
 336  0031 c65216        	ld	a,21014
 337  0034 cd0000        	call	_I2C_byte_received
 339  0037               L721:
 340                     ; 68   if (sr1 & I2C_SR1_RXNE)
 342  0037 720d000006    	btjf	L17_sr1,#6,L131
 343                     ; 70     I2C_byte_received(I2C->DR);
 345  003c c65216        	ld	a,21014
 346  003f cd0000        	call	_I2C_byte_received
 348  0042               L131:
 349                     ; 73   if (sr2 & I2C_SR2_AF)
 351  0042 7205000107    	btjf	L37_sr2,#2,L331
 352                     ; 75     I2C->SR2 &= ~I2C_SR2_AF;	  // clear AF
 354  0047 72155218      	bres	21016,#2
 355                     ; 76 		I2C_transaction_end();
 357  004b cd0000        	call	_I2C_transaction_end
 359  004e               L331:
 360                     ; 79   if (sr1 & I2C_SR1_STOPF) 
 362  004e 7209000007    	btjf	L17_sr1,#4,L531
 363                     ; 81     I2C->CR2 |= I2C_CR2_ACK;	  // CR2 write to clear STOPF
 365  0053 72145211      	bset	21009,#2
 366                     ; 82 		I2C_transaction_end();
 368  0057 cd0000        	call	_I2C_transaction_end
 370  005a               L531:
 371                     ; 85   if (sr1 & I2C_SR1_ADDR)
 373  005a 7203000003    	btjf	L17_sr1,#1,L731
 374                     ; 87 		I2C_transaction_begin();
 376  005f cd0000        	call	_I2C_transaction_begin
 378  0062               L731:
 379                     ; 90   if ((sr1 & (I2C_SR1_TXE | I2C_SR1_BTF)) == (I2C_SR1_TXE | I2C_SR1_BTF))
 381  0062 b600          	ld	a,L17_sr1
 382  0064 a484          	and	a,#132
 383  0066 a184          	cp	a,#132
 384  0068 2606          	jrne	L141
 385                     ; 92 		I2C->DR = I2C_byte_write();
 387  006a cd0000        	call	_I2C_byte_write
 389  006d c75216        	ld	21014,a
 390  0070               L141:
 391                     ; 95   if (sr1 & I2C_SR1_TXE)
 393  0070 720f000006    	btjf	L17_sr1,#7,L341
 394                     ; 97 		I2C->DR = I2C_byte_write();
 396  0075 cd0000        	call	_I2C_byte_write
 398  0078 c75216        	ld	21014,a
 399  007b               L341:
 400                     ; 99 	GPIOD->ODR^=1;
 402  007b c6500f        	ld	a,20495
 403  007e a801          	xor	a,#1
 404  0080 c7500f        	ld	20495,a
 405                     ; 100 }
 408  0083 85            	popw	x
 409  0084 bf00          	ldw	c_y,x
 410  0086 320002        	pop	c_y+2
 411  0089 85            	popw	x
 412  008a bf00          	ldw	c_x,x
 413  008c 320002        	pop	c_x+2
 414  008f 80            	iret	
 436                     ; 105 void Init_I2C (void)
 436                     ; 106 {
 438                     .text:	section	.text,new
 439  0000               _Init_I2C:
 443                     ; 114 	GPIOB->DDR&= 0xcf;
 445  0000 c65007        	ld	a,20487
 446  0003 a4cf          	and	a,#207
 447  0005 c75007        	ld	20487,a
 448                     ; 115 	GPIOB->CR1&= 0xcf;
 450  0008 c65008        	ld	a,20488
 451  000b a4cf          	and	a,#207
 452  000d c75008        	ld	20488,a
 453                     ; 116 	GPIOB->CR2&= 0xcf;
 455  0010 c65009        	ld	a,20489
 456  0013 a4cf          	and	a,#207
 457  0015 c75009        	ld	20489,a
 458                     ; 120 		I2C->CR1 |= 0x01;				        	// Enable I2C peripheral
 460  0018 72105210      	bset	21008,#0
 461                     ; 121 		I2C->CR2 = 0x04;					      		// Enable I2C acknowledgement
 463  001c 35045211      	mov	21009,#4
 464                     ; 122 		I2C->FREQR = 16; 					      	// Set I2C Freq value (16MHz)
 466  0020 35105212      	mov	21010,#16
 467                     ; 123 		I2C->OARL = (SLAVE_ADDRESS << 1) ;	// set slave address to 0x51 (put 0xA2 for the register dues to7bit address) 
 469  0024 35a25213      	mov	21011,#162
 470                     ; 124 		I2C->OARH = 0x40;					      	// Set 7bit address mode
 472  0028 35405214      	mov	21012,#64
 473                     ; 136 	I2C->ITR	= 0x07;					      // all I2C interrupt enable  
 475  002c 3507521a      	mov	21018,#7
 476                     ; 137 }
 479  0030 81            	ret	
 523                     	xdef	_I2C_byte_write
 524                     	xdef	_I2C_byte_received
 525                     	xdef	_I2C_transaction_end
 526                     	xdef	_I2C_transaction_begin
 527                     	switch	.ubsct
 528  0003               _MessageBegin:
 529  0003 00            	ds.b	1
 530                     	xdef	_MessageBegin
 531  0004               _u8_MyBuffp:
 532  0004 0000          	ds.b	2
 533                     	xdef	_u8_MyBuffp
 534  0006               _u8_My_Buffer:
 535  0006 000000000000  	ds.b	32
 536                     	xdef	_u8_My_Buffer
 537                     	xdef	f_I2C_Slave_check_event
 538                     	xdef	_Init_I2C
 539                     	xref.b	c_x
 540                     	xref.b	c_y
 560                     	end
