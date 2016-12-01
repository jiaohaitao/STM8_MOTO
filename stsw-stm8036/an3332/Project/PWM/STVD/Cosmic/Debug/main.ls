   1                     ; C Compiler for STM8 (COSMIC Software)
   2                     ; Parser V4.8.32 - 23 Mar 2010
   3                     ; Generator V4.3.4 - 23 Mar 2010
   4                     ; Optimizer V4.3.3 - 10 Feb 2010
  20                     	bsct
  21  0000               _ADC_BUF:
  22  0000 0000          	dc.w	0
  23  0002 000000000000  	ds.b	38
  24  0028               _AdcBufCnt:
  25  0028 00            	dc.b	0
  26  0029               _AdcValue:
  27  0029 0000          	dc.w	0
  28  002b               _AdcSum:
  29  002b 0000          	dc.w	0
  30  002d               _AdcPosition:
  31  002d 0000          	dc.w	0
  32  002f               _CmdPosition:
  33  002f 0000          	dc.w	0
  34  0031               _CmdTime:
  35  0031 0000          	dc.w	0
  36  0033               _NewI2cCmd:
  37  0033 00            	dc.b	0
  38  0034               _Systemid:
  39  0034 0000          	dc.w	0
  40  0036               _SystemStatus:
  41  0036 0000          	dc.w	0
  72                     ; 126 void CLK_Configuration(void)
  72                     ; 127 {
  74                     .text:	section	.text,new
  75  0000               _CLK_Configuration:
  79                     ; 128    CLK_HSICmd(ENABLE);/* Set HSIEN bit */
  81  0000 a601          	ld	a,#1
  82  0002 cd0000        	call	_CLK_HSICmd
  84                     ; 131   CLK_HSIPrescalerConfig(CLK_PRESCALER_HSIDIV1); /* Fmaster = 16MHz */
  86  0005 4f            	clr	a
  88                     ; 133 }
  91  0006 cc0000        	jp	_CLK_HSIPrescalerConfig
 167                     ; 136 void main(void)
 167                     ; 137 {
 168                     .text:	section	.text,new
 169  0000               _main:
 171  0000 89            	pushw	x
 172       00000002      OFST:	set	2
 175                     ; 139 	unsigned char pwm=0,i=0;
 177  0001 0f01          	clr	(OFST-1,sp)
 180                     ; 141 CLK_Configuration();
 182  0003 cd0000        	call	_CLK_Configuration
 184                     ; 143 	LED_Init();//led3->PC3
 186  0006 cd0000        	call	_LED_Init
 188                     ; 146 	Systemid=0;
 190  0009 5f            	clrw	x
 191  000a bf34          	ldw	_Systemid,x
 192                     ; 147 	SystemStatus=0;//system init ok
 194  000c bf36          	ldw	_SystemStatus,x
 195                     ; 149 	NewI2cCmd=1;//开机执行一次命令，回到中间位置
 197  000e 35010033      	mov	_NewI2cCmd,#1
 198                     ; 150 	CmdPosition=180;//中间位置(0-360)
 200  0012 ae00b4        	ldw	x,#180
 201  0015 bf2f          	ldw	_CmdPosition,x
 202                     ; 151 	CmdTime=1000;//默认1000ms，暂时没有使用
 204  0017 ae03e8        	ldw	x,#1000
 205  001a bf31          	ldw	_CmdTime,x
 206                     ; 153 	Moto_Init();//PC5->M_PHA PC3->M_nSLEEP PC4->nFAULT PC6->VISEN
 208  001c cd0000        	call	_Moto_Init
 210                     ; 154 	LED_Init();//led3->PC3
 212  001f cd0000        	call	_LED_Init
 214                     ; 155 	Tim1_Init();	
 216  0022 cd0000        	call	_Tim1_Init
 218                     ; 156 	Pwm_Init(); //channel3->PA3
 220  0025 cd0000        	call	_Pwm_Init
 222                     ; 157 	ADC_Init();// ADC1 Channel4 PD3
 224  0028 cd0000        	call	_ADC_Init
 226                     ; 158 	Uart1_Init();//PD5->Uart1 Tx   PD6->Uart1 Rx
 228  002b cd0000        	call	_Uart1_Init
 230                     ; 159 	SetLedOFF(); /* 让所有灯灭 */
 232  002e cd0000        	call	_SetLedOFF
 234                     ; 169 	Systemid=0x54;//up-down-head	
 236  0031 ae0054        	ldw	x,#84
 237  0034 bf34          	ldw	_Systemid,x
 238                     ; 171 	UART1_printf("Read Sysid is:%d\r\n",Systemid);//for 16bits printf
 240  0036 be34          	ldw	x,_Systemid
 241  0038 89            	pushw	x
 242  0039 ae0226        	ldw	x,#L75
 243  003c cd0000        	call	_UART1_printf
 245  003f 85            	popw	x
 246                     ; 173   switch (Systemid)
 248  0040 be34          	ldw	x,_Systemid
 250                     ; 195 		break;
 251  0042 1d0051        	subw	x,#81
 252  0045 271a          	jreq	L32
 253  0047 5a            	decw	x
 254  0048 2723          	jreq	L52
 255  004a 5a            	decw	x
 256  004b 272c          	jreq	L72
 257  004d 5a            	decw	x
 258  004e 2735          	jreq	L13
 259                     ; 191 		default :
 259                     ; 192 		UART1_printf("The Systemid is error....\r\n");
 261  0050 ae018a        	ldw	x,#L57
 262  0053 cd0000        	call	_UART1_printf
 264                     ; 193 		SystemStatus=1;//system is error
 266  0056 ae0001        	ldw	x,#1
 267  0059 bf36          	ldw	_SystemStatus,x
 268                     ; 194 		SLAVE_ADDRESS=0x50;//default addr
 270  005b 35500000      	mov	_SLAVE_ADDRESS,#80
 271                     ; 195 		break;
 273  005f 202e          	jra	L36
 274  0061               L32:
 275                     ; 175 		case 0x51:
 275                     ; 176 		UART1_printf("The System is for Lefthand\r\n");
 277  0061 ae0209        	ldw	x,#L56
 278  0064 cd0000        	call	_UART1_printf
 280                     ; 177 		SLAVE_ADDRESS=0x51;
 282  0067 35510000      	mov	_SLAVE_ADDRESS,#81
 283                     ; 178 		break;
 285  006b 2022          	jra	L36
 286  006d               L52:
 287                     ; 179 		case 0x52:
 287                     ; 180 		UART1_printf("The System is for Righthand\r\n");
 289  006d ae01eb        	ldw	x,#L76
 290  0070 cd0000        	call	_UART1_printf
 292                     ; 181 		SLAVE_ADDRESS=0x52;
 294  0073 35520000      	mov	_SLAVE_ADDRESS,#82
 295                     ; 182 		break;
 297  0077 2016          	jra	L36
 298  0079               L72:
 299                     ; 183 		case 0x53:
 299                     ; 184 		UART1_printf("The System is for Left-Right-head\r\n");
 301  0079 ae01c7        	ldw	x,#L17
 302  007c cd0000        	call	_UART1_printf
 304                     ; 185 		SLAVE_ADDRESS=0x53;
 306  007f 35530000      	mov	_SLAVE_ADDRESS,#83
 307                     ; 186 		break;
 309  0083 200a          	jra	L36
 310  0085               L13:
 311                     ; 187 		case 0x54:
 311                     ; 188 		UART1_printf("The System is for up-down-head\r\n");
 313  0085 ae01a6        	ldw	x,#L37
 314  0088 cd0000        	call	_UART1_printf
 316                     ; 189 		SLAVE_ADDRESS=0x54;
 318  008b 35540000      	mov	_SLAVE_ADDRESS,#84
 319                     ; 190 		break;		
 321  008f               L36:
 322                     ; 197 	Init_I2C();//PB4-SCL PB5->SDA
 324  008f cd0000        	call	_Init_I2C
 326                     ; 199 	UART1_printf("System is on....!!!\r\n");
 328  0092 ae0174        	ldw	x,#L77
 329  0095 cd0000        	call	_UART1_printf
 331                     ; 200 	enableInterrupts(); 
 334  0098 9a            	rim	
 336  0099               L101:
 337                     ; 211 		if(Sys_10ms_Flag==1)
 339  0099 b600          	ld	a,_Sys_10ms_Flag
 340  009b 4a            	dec	a
 341  009c 2608          	jrne	L501
 342                     ; 213 			Sys_10ms_Flag=0;
 344  009e b700          	ld	_Sys_10ms_Flag,a
 345                     ; 214 			Check_I2c_Data();
 347  00a0 cd0000        	call	_Check_I2c_Data
 349                     ; 215 			CmdDeal();
 351  00a3 cd0000        	call	_CmdDeal
 353  00a6               L501:
 354                     ; 217 		if(Sys_20ms_Flag==1)
 356  00a6 b600          	ld	a,_Sys_20ms_Flag
 357  00a8 4a            	dec	a
 358  00a9 2640          	jrne	L701
 359                     ; 219 			Sys_20ms_Flag=0;
 361  00ab b700          	ld	_Sys_20ms_Flag,a
 362                     ; 220 			if(SystemStatus==0)
 364  00ad be36          	ldw	x,_SystemStatus
 365  00af 263a          	jrne	L701
 366                     ; 222 				AdcBufCnt++;
 368  00b1 3c28          	inc	_AdcBufCnt
 369                     ; 223 				if(AdcBufCnt>=ADC_FILTER_LENGTH)
 371  00b3 b628          	ld	a,_AdcBufCnt
 372  00b5 a114          	cp	a,#20
 373  00b7 2502          	jrult	L311
 374                     ; 224 				AdcBufCnt=0;
 376  00b9 3f28          	clr	_AdcBufCnt
 377  00bb               L311:
 378                     ; 226 				ADC_BUF[AdcBufCnt]=GetMotoADValue();
 380  00bb cd0000        	call	_GetMotoADValue
 382  00be b628          	ld	a,_AdcBufCnt
 383  00c0 905f          	clrw	y
 384  00c2 9097          	ld	yl,a
 385  00c4 9058          	sllw	y
 386  00c6 90ef00        	ldw	(_ADC_BUF,y),x
 387                     ; 228 				AdcSum=0;
 389  00c9 5f            	clrw	x
 390  00ca bf2b          	ldw	_AdcSum,x
 391                     ; 229 				for(i=0;i<ADC_FILTER_LENGTH;i++)
 393  00cc 4f            	clr	a
 394  00cd 6b02          	ld	(OFST+0,sp),a
 395  00cf               L511:
 396                     ; 230 				AdcSum+=ADC_BUF[i];
 398  00cf 5f            	clrw	x
 399  00d0 97            	ld	xl,a
 400  00d1 58            	sllw	x
 401  00d2 ee00          	ldw	x,(_ADC_BUF,x)
 402  00d4 72bb002b      	addw	x,_AdcSum
 403  00d8 bf2b          	ldw	_AdcSum,x
 404                     ; 229 				for(i=0;i<ADC_FILTER_LENGTH;i++)
 406  00da 0c02          	inc	(OFST+0,sp)
 409  00dc 7b02          	ld	a,(OFST+0,sp)
 410  00de a114          	cp	a,#20
 411  00e0 25ed          	jrult	L511
 412                     ; 232 				AdcValue=AdcSum/ADC_FILTER_LENGTH;
 414                     ; 235 				AdcValue=ADC_BUF[AdcBufCnt];
 416  00e2 b628          	ld	a,_AdcBufCnt
 417  00e4 5f            	clrw	x
 418  00e5 97            	ld	xl,a
 419  00e6 58            	sllw	x
 420  00e7 ee00          	ldw	x,(_ADC_BUF,x)
 421  00e9 bf29          	ldw	_AdcValue,x
 423  00eb               L701:
 424                     ; 243 		if(Sys_50ms_Flag==1)
 426  00eb b600          	ld	a,_Sys_50ms_Flag
 427  00ed 4a            	dec	a
 428  00ee 2609          	jrne	L521
 429                     ; 245 			Sys_50ms_Flag=0;
 431  00f0 b700          	ld	_Sys_50ms_Flag,a
 432                     ; 247 			if(SystemStatus==0)
 434  00f2 be36          	ldw	x,_SystemStatus
 435  00f4 2603          	jrne	L521
 436                     ; 249 				Check_I2c_Data();
 438  00f6 cd0000        	call	_Check_I2c_Data
 441  00f9               L521:
 442                     ; 257 		if(Sys_100ms_Flag==1)
 444  00f9 b600          	ld	a,_Sys_100ms_Flag
 445  00fb 4a            	dec	a
 446  00fc 2604          	jrne	L331
 447                     ; 259 			Sys_100ms_Flag=0;
 449  00fe b700          	ld	_Sys_100ms_Flag,a
 450                     ; 261 			if(SystemStatus==0)
 452  0100 be36          	ldw	x,_SystemStatus
 454  0102               L331:
 455                     ; 279 		if(Sys_200ms_Flag==1)
 457  0102 b600          	ld	a,_Sys_200ms_Flag
 458  0104 4a            	dec	a
 459  0105 260b          	jrne	L141
 460                     ; 281 			Sys_200ms_Flag=0;
 462  0107 b700          	ld	_Sys_200ms_Flag,a
 463                     ; 283 			if(SystemStatus==0)
 465  0109 be36          	ldw	x,_SystemStatus
 466  010b 2705          	jreq	L141
 468                     ; 291 				LED_Reverse(LED_3);
 470  010d a680          	ld	a,#128
 471  010f cd0000        	call	_LED_Reverse
 473  0112               L141:
 474                     ; 295 		if(Sys_500ms_Flag==1)
 476  0112 b600          	ld	a,_Sys_500ms_Flag
 477  0114 4a            	dec	a
 478  0115 2604          	jrne	L741
 479                     ; 297 			Sys_500ms_Flag=0;
 481  0117 b700          	ld	_Sys_500ms_Flag,a
 482                     ; 299 			if(SystemStatus==0)
 484  0119 be36          	ldw	x,_SystemStatus
 486  011b               L741:
 487                     ; 308 		if(Sys_1000ms_Flag==1)
 489  011b b600          	ld	a,_Sys_1000ms_Flag
 490  011d 4a            	dec	a
 491  011e 2703cc0099    	jrne	L101
 492                     ; 310 			Sys_1000ms_Flag=0;
 494  0123 b700          	ld	_Sys_1000ms_Flag,a
 495                     ; 312 			if(SystemStatus==0)
 497  0125 be36          	ldw	x,_SystemStatus
 498  0127 26f7          	jrne	L101
 499                     ; 314 				LED_Reverse(LED_3);
 501  0129 a680          	ld	a,#128
 502  012b cd0000        	call	_LED_Reverse
 504                     ; 315 				UART1_printf("The Adc Is:%d\r\n",AdcValue);
 506  012e be29          	ldw	x,_AdcValue
 507  0130 89            	pushw	x
 508  0131 ae0164        	ldw	x,#L161
 509  0134 cd0000        	call	_UART1_printf
 511  0137 85            	popw	x
 512                     ; 316 				AdcPosition=(float)AdcValue/2.844;
 514  0138 be29          	ldw	x,_AdcValue
 515  013a cd0000        	call	c_uitof
 517  013d ae0160        	ldw	x,#L761
 518  0140 cd0000        	call	c_fdiv
 520  0143 cd0000        	call	c_ftoi
 522  0146 bf2d          	ldw	_AdcPosition,x
 523                     ; 317 				UART1_printf("The Position Is:%d\r\n",AdcPosition);
 525  0148 89            	pushw	x
 526  0149 ae014b        	ldw	x,#L371
 527  014c cd0000        	call	_UART1_printf
 529  014f 85            	popw	x
 531  0150 cc0099        	jra	L101
 563                     ; 349 void CheckUartRxI2cAddr(void)
 563                     ; 350 {
 564                     .text:	section	.text,new
 565  0000               _CheckUartRxI2cAddr:
 569                     ; 351 	if(UartRxI2cAddrFlag==1)
 571  0000 b600          	ld	a,_UartRxI2cAddrFlag
 572  0002 4a            	dec	a
 573  0003 266d          	jrne	L122
 574                     ; 353 		UartRxI2cAddrFlag=0;
 576  0005 b700          	ld	_UartRxI2cAddrFlag,a
 577                     ; 354 		SLAVE_ADDRESS=UartRxI2cAddr;
 579  0007 450000        	mov	_SLAVE_ADDRESS,_UartRxI2cAddr
 580                     ; 355 		SaveSysId(SLAVE_ADDRESS);
 582  000a b600          	ld	a,_SLAVE_ADDRESS
 583  000c cd0000        	call	_SaveSysId
 585                     ; 356 		Systemid=ReadSysId();
 587  000f cd0000        	call	_ReadSysId
 589  0012 5f            	clrw	x
 590  0013 97            	ld	xl,a
 591  0014 bf34          	ldw	_Systemid,x
 592                     ; 357 		UART1_printf("Read Sysid is:%d\r\n",Systemid);//for 16bits printf
 594  0016 be34          	ldw	x,_Systemid
 595  0018 89            	pushw	x
 596  0019 ae0226        	ldw	x,#L75
 597  001c cd0000        	call	_UART1_printf
 599  001f 85            	popw	x
 600                     ; 359 		switch (Systemid)
 602  0020 be34          	ldw	x,_Systemid
 604                     ; 381 			break;
 605  0022 1d0051        	subw	x,#81
 606  0025 271a          	jreq	L771
 607  0027 5a            	decw	x
 608  0028 2723          	jreq	L102
 609  002a 5a            	decw	x
 610  002b 272c          	jreq	L302
 611  002d 5a            	decw	x
 612  002e 2735          	jreq	L502
 613                     ; 377 			default :
 613                     ; 378 			UART1_printf("The Systemid is error....\r\n");
 615  0030 ae018a        	ldw	x,#L57
 616  0033 cd0000        	call	_UART1_printf
 618                     ; 379 			SystemStatus=1;//system is error
 620  0036 ae0001        	ldw	x,#1
 621  0039 bf36          	ldw	_SystemStatus,x
 622                     ; 380 			SLAVE_ADDRESS=0x50;//default addr
 624  003b 35500000      	mov	_SLAVE_ADDRESS,#80
 625                     ; 381 			break;
 627  003f 202e          	jra	L522
 628  0041               L771:
 629                     ; 361 			case 0x51:
 629                     ; 362 			UART1_printf("The System is for Lefthand\r\n");
 631  0041 ae0209        	ldw	x,#L56
 632  0044 cd0000        	call	_UART1_printf
 634                     ; 363 			SLAVE_ADDRESS=0x51;
 636  0047 35510000      	mov	_SLAVE_ADDRESS,#81
 637                     ; 364 			break;
 639  004b 2022          	jra	L522
 640  004d               L102:
 641                     ; 365 			case 0x52:
 641                     ; 366 			UART1_printf("The System is for Righthand\r\n");
 643  004d ae01eb        	ldw	x,#L76
 644  0050 cd0000        	call	_UART1_printf
 646                     ; 367 			SLAVE_ADDRESS=0x52;
 648  0053 35520000      	mov	_SLAVE_ADDRESS,#82
 649                     ; 368 			break;
 651  0057 2016          	jra	L522
 652  0059               L302:
 653                     ; 369 			case 0x53:
 653                     ; 370 			UART1_printf("The System is for Left-Right-head\r\n");
 655  0059 ae01c7        	ldw	x,#L17
 656  005c cd0000        	call	_UART1_printf
 658                     ; 371 			SLAVE_ADDRESS=0x53;
 660  005f 35530000      	mov	_SLAVE_ADDRESS,#83
 661                     ; 372 			break;
 663  0063 200a          	jra	L522
 664  0065               L502:
 665                     ; 373 			case 0x54:
 665                     ; 374 			UART1_printf("The System is for up-down-head\r\n");
 667  0065 ae01a6        	ldw	x,#L37
 668  0068 cd0000        	call	_UART1_printf
 670                     ; 375 			SLAVE_ADDRESS=0x54;
 672  006b 35540000      	mov	_SLAVE_ADDRESS,#84
 673                     ; 376 			break;		
 675  006f               L522:
 676                     ; 383 		Init_I2C();//PB4-SCL PB5->SDA		
 678  006f cd0000        	call	_Init_I2C
 680  0072               L122:
 681                     ; 385 }
 684  0072 81            	ret	
 687                     	bsct
 688  0038               _ReadBuffer:
 689  0038 00            	dc.b	0
 690  0039 000000000000  	ds.b	63
 713                     ; 388 unsigned char ReadSysId(void)
 713                     ; 389 {
 714                     .text:	section	.text,new
 715  0000               _ReadSysId:
 719                     ; 391 	ReadMultiBlockByte(Block_0,1,ReadBuffer);
 721  0000 ae0038        	ldw	x,#_ReadBuffer
 722  0003 89            	pushw	x
 723  0004 ae0001        	ldw	x,#1
 724  0007 4f            	clr	a
 725  0008 95            	ld	xh,a
 726  0009 cd0000        	call	_ReadMultiBlockByte
 728  000c b638          	ld	a,_ReadBuffer
 729  000e 85            	popw	x
 730                     ; 392 	return ReadBuffer[0];
 734  000f 81            	ret	
 775                     ; 394 unsigned char SaveSysId(unsigned char id)
 775                     ; 395 {
 776                     .text:	section	.text,new
 777  0000               _SaveSysId:
 779  0000 88            	push	a
 780       00000000      OFST:	set	0
 783                     ; 396 	ReadMultiBlockByte(Block_0,1,ReadBuffer);
 785  0001 ae0038        	ldw	x,#_ReadBuffer
 786  0004 89            	pushw	x
 787  0005 ae0001        	ldw	x,#1
 788  0008 4f            	clr	a
 789  0009 95            	ld	xh,a
 790  000a cd0000        	call	_ReadMultiBlockByte
 792  000d 85            	popw	x
 793                     ; 397 	ReadBuffer[0]=id;
 795  000e 7b01          	ld	a,(OFST+1,sp)
 796  0010 b738          	ld	_ReadBuffer,a
 797                     ; 399 	FLASH_SetProgrammingTime(FLASH_PROGRAMTIME_STANDARD);
 799  0012 4f            	clr	a
 800  0013 cd0000        	call	_FLASH_SetProgrammingTime
 802                     ; 401 	FLASH_EraseBlock(Block_0, FLASH_MEMTYPE_DATA);/*往FLASH写数据前，要擦除对应的区域*/
 804  0016 4bf7          	push	#247
 805  0018 5f            	clrw	x
 806  0019 cd0000        	call	_FLASH_EraseBlock
 808  001c 84            	pop	a
 809                     ; 402 	FLASH_WaitForLastOperation(FLASH_MEMTYPE_DATA);
 811  001d a6f7          	ld	a,#247
 812  001f cd0000        	call	_FLASH_WaitForLastOperation
 814                     ; 404 	WriteMultiBlockByte(Block_0,FLASH_MEMTYPE_DATA,FLASH_PROGRAMMODE_STANDARD,ReadBuffer,1);
 816  0022 4b01          	push	#1
 817  0024 ae0038        	ldw	x,#_ReadBuffer
 818  0027 89            	pushw	x
 819  0028 4b00          	push	#0
 820  002a ae00f7        	ldw	x,#247
 821  002d 4f            	clr	a
 822  002e 95            	ld	xh,a
 823  002f cd0000        	call	_WriteMultiBlockByte
 825  0032 5b04          	addw	sp,#4
 826                     ; 407 	UART1_printf("Save Sysid ok,the id is:0x%02h",ReadBuffer[0]);
 828  0034 3b0038        	push	_ReadBuffer
 829  0037 ae012c        	ldw	x,#L552
 830  003a cd0000        	call	_UART1_printf
 832  003d 84            	pop	a
 833                     ; 409 }
 836  003e 84            	pop	a
 837  003f 81            	ret	
 878                     ; 410 void Check_I2c_Data(void)
 878                     ; 411 {
 879                     .text:	section	.text,new
 880  0000               _Check_I2c_Data:
 882  0000 88            	push	a
 883       00000001      OFST:	set	1
 886                     ; 412 	u8 i=0;
 888  0001 0f01          	clr	(OFST+0,sp)
 889                     ; 414 	if(IIC_RECV_ONE_FRAME_OK==1)
 891  0003 b600          	ld	a,_IIC_RECV_ONE_FRAME_OK
 892  0005 4a            	dec	a
 893  0006 2703cc00ff    	jrne	L503
 894                     ; 417 		IIC_RECV_ONE_FRAME_OK=0;
 896  000b b700          	ld	_IIC_RECV_ONE_FRAME_OK,a
 897                     ; 418 		NewI2cCmd=IIC_BUF[0];
 899  000d 450033        	mov	_NewI2cCmd,_IIC_BUF
 900                     ; 419 		switch (NewI2cCmd){
 902  0010 b633          	ld	a,_NewI2cCmd
 904                     ; 506 			break;
 905  0012 2718          	jreq	L752
 906  0014 4a            	dec	a
 907  0015 271b          	jreq	L162
 908  0017 4a            	dec	a
 909  0018 2603cc00f9    	jreq	L362
 910                     ; 504 			default:
 910                     ; 505 			UART1_printf("Receive a error cmd:%d\r\n",(unsigned int)(NewI2cCmd));
 912  001d b633          	ld	a,_NewI2cCmd
 913  001f 5f            	clrw	x
 914  0020 97            	ld	xl,a
 915  0021 89            	pushw	x
 916  0022 ae0000        	ldw	x,#L114
 917  0025 cd0000        	call	_UART1_printf
 919  0028 85            	popw	x
 920                     ; 506 			break;
 922  0029 cc00ff        	jra	L503
 923  002c               L752:
 924                     ; 420 			case 0x00:
 924                     ; 421 			UART1_printf("Receive a null cmd (0)\r\n");
 926  002c ae0113        	ldw	x,#L313
 928                     ; 422 			break;
 930  002f cc00fc        	jp	LC001
 931  0032               L162:
 932                     ; 423 			case 0x01:
 932                     ; 424 		
 932                     ; 425 			
 932                     ; 426 			if(IIC_BUF[1]==0x00)//shunshizhen
 934  0032 3d01          	tnz	_IIC_BUF+1
 935  0034 2611          	jrne	L513
 936                     ; 428 				if(IIC_BUF[2]<=180)
 938  0036 b602          	ld	a,_IIC_BUF+2
 939  0038 a1b5          	cp	a,#181
 940  003a 2424          	jruge	L123
 941                     ; 429 				CmdPosition=IIC_BUF[2]+180;
 943  003c b602          	ld	a,_IIC_BUF+2
 944  003e 5f            	clrw	x
 945  003f 97            	ld	xl,a
 946  0040 1c00b4        	addw	x,#180
 947  0043 bf2f          	ldw	_CmdPosition,x
 948  0045 2019          	jra	L123
 949  0047               L513:
 950                     ; 431 			else if(IIC_BUF[1]==0x01)//nishizhen
 952  0047 b601          	ld	a,_IIC_BUF+1
 953  0049 4a            	dec	a
 954  004a 2614          	jrne	L123
 955                     ; 433 				if(IIC_BUF[2]<=180)
 957  004c b602          	ld	a,_IIC_BUF+2
 958  004e a1b5          	cp	a,#181
 959  0050 240e          	jruge	L123
 960                     ; 434 				CmdPosition=180-IIC_BUF[2];
 962  0052 4f            	clr	a
 963  0053 97            	ld	xl,a
 964  0054 a6b4          	ld	a,#180
 965  0056 b002          	sub	a,_IIC_BUF+2
 966  0058 2401          	jrnc	L051
 967  005a 5a            	decw	x
 968  005b               L051:
 969  005b b730          	ld	_CmdPosition+1,a
 970  005d 9f            	ld	a,xl
 971  005e b72f          	ld	_CmdPosition,a
 972  0060               L123:
 973                     ; 440 			if(CmdPosition>360)
 975  0060 be2f          	ldw	x,_CmdPosition
 976  0062 a30169        	cpw	x,#361
 977  0065 2505          	jrult	L133
 978                     ; 441 			CmdPosition=360;
 980  0067 ae0168        	ldw	x,#360
 981  006a bf2f          	ldw	_CmdPosition,x
 982  006c               L133:
 983                     ; 442 			CmdTime=IIC_BUF[3]*256+IIC_BUF[4];
 985  006c b603          	ld	a,_IIC_BUF+3
 986  006e 5f            	clrw	x
 987  006f 97            	ld	xl,a
 988  0070 4f            	clr	a
 989  0071 bb04          	add	a,_IIC_BUF+4
 990  0073 2401          	jrnc	L251
 991  0075 5c            	incw	x
 992  0076               L251:
 993  0076 b732          	ld	_CmdTime+1,a
 994  0078 9f            	ld	a,xl
 995  0079 b731          	ld	_CmdTime,a
 996                     ; 443 			UART1_printf("Receive a Position Change Cmd\r\n");
 998  007b ae00f3        	ldw	x,#L333
 999  007e cd0000        	call	_UART1_printf
1001                     ; 444 			UART1_printf("The CmdPosition is:%d,The CmdTime is:%d\r\n",CmdPosition,CmdTime);				
1003  0081 be31          	ldw	x,_CmdTime
1004  0083 89            	pushw	x
1005  0084 be2f          	ldw	x,_CmdPosition
1006  0086 89            	pushw	x
1007  0087 ae00c9        	ldw	x,#L533
1008  008a cd0000        	call	_UART1_printf
1010  008d 5b04          	addw	sp,#4
1011                     ; 457 			if(Systemid==0x51){
1013  008f be34          	ldw	x,_Systemid
1014  0091 a30051        	cpw	x,#81
1015  0094 2611          	jrne	L733
1016                     ; 458 				if(CmdPosition<(180-50)||CmdPosition>(180+110))
1018  0096 be2f          	ldw	x,_CmdPosition
1019  0098 a30082        	cpw	x,#130
1020  009b 2505          	jrult	L343
1022  009d a30123        	cpw	x,#291
1023  00a0 255d          	jrult	L503
1024  00a2               L343:
1025                     ; 460 					UART1_printf("Left Hand Cmd erro out of(70-230)\r\n");
1027  00a2 ae00a5        	ldw	x,#L543
1029                     ; 461 					CmdPosition=180;
1030                     ; 462 					NewI2cCmd=0;
1031  00a5 2046          	jp	LC003
1032  00a7               L733:
1033                     ; 468 			else if(Systemid==0x52){
1035  00a7 be34          	ldw	x,_Systemid
1036  00a9 a30052        	cpw	x,#82
1037  00ac 2611          	jrne	L153
1038                     ; 469 				if(CmdPosition<(180-110)||CmdPosition>(180+50))
1040  00ae be2f          	ldw	x,_CmdPosition
1041  00b0 a30046        	cpw	x,#70
1042  00b3 2505          	jrult	L553
1044  00b5 a300e7        	cpw	x,#231
1045  00b8 2545          	jrult	L503
1046  00ba               L553:
1047                     ; 471 					UART1_printf("Right Hand Cmd erro out of(130-290)\r\n");
1049  00ba ae007f        	ldw	x,#L753
1051                     ; 472 					CmdPosition=180;NewI2cCmd=0;
1053  00bd 202e          	jp	LC003
1054  00bf               L153:
1055                     ; 478 			else if(Systemid==0x53){
1057  00bf be34          	ldw	x,_Systemid
1058  00c1 a30053        	cpw	x,#83
1059  00c4 2611          	jrne	L363
1060                     ; 479 				if(CmdPosition<(180-80)||CmdPosition>(180+80))
1062  00c6 be2f          	ldw	x,_CmdPosition
1063  00c8 a30064        	cpw	x,#100
1064  00cb 2505          	jrult	L763
1066  00cd a30105        	cpw	x,#261
1067  00d0 252d          	jrult	L503
1068  00d2               L763:
1069                     ; 481 					UART1_printf("left-right-head Cmd erro out of(100-260)\r\n");
1071  00d2 ae0054        	ldw	x,#L173
1073                     ; 482 					CmdPosition=180;NewI2cCmd=0;
1075  00d5 2016          	jp	LC003
1076  00d7               L363:
1077                     ; 488 			else if(Systemid==0x54){
1079  00d7 be34          	ldw	x,_Systemid
1080  00d9 a30054        	cpw	x,#84
1081  00dc 2612          	jrne	LC002
1082                     ; 489 				if(CmdPosition<(180-10)||CmdPosition>(180+15))
1084  00de be2f          	ldw	x,_CmdPosition
1085  00e0 a300aa        	cpw	x,#170
1086  00e3 2505          	jrult	L104
1088  00e5 a300c4        	cpw	x,#196
1089  00e8 2515          	jrult	L503
1090  00ea               L104:
1091                     ; 491 					UART1_printf("up-down-head Cmd erro out of(165-190)\r\n");
1093  00ea ae002c        	ldw	x,#L304
1094  00ed               LC003:
1095  00ed cd0000        	call	_UART1_printf
1097                     ; 492 					CmdPosition=180;NewI2cCmd=0;
1101  00f0               LC002:
1106  00f0 ae00b4        	ldw	x,#180
1107  00f3 bf2f          	ldw	_CmdPosition,x
1112  00f5 3f33          	clr	_NewI2cCmd
1113  00f7 2006          	jra	L503
1114                     ; 497 				CmdPosition=180;NewI2cCmd=0;
1116  00f9               L362:
1117                     ; 501 			case 0x02:
1117                     ; 502 			UART1_printf("Receive stop Cmd\r\n");
1119  00f9 ae0019        	ldw	x,#L704
1120  00fc               LC001:
1121  00fc cd0000        	call	_UART1_printf
1123                     ; 503 			break;
1125  00ff               L503:
1126                     ; 509 }
1129  00ff 84            	pop	a
1130  0100 81            	ret	
1155                     ; 511 void Moto_Init(void)
1155                     ; 512 {
1156                     .text:	section	.text,new
1157  0000               _Moto_Init:
1161                     ; 514 	GPIO_Init(GPIOC,GPIO_PIN_3|GPIO_PIN_5|GPIO_PIN_4|GPIO_PIN_6, GPIO_MODE_OUT_PP_HIGH_FAST );	
1163  0000 4bf0          	push	#240
1164  0002 4b78          	push	#120
1165  0004 ae500a        	ldw	x,#20490
1166  0007 cd0000        	call	_GPIO_Init
1168  000a 85            	popw	x
1169                     ; 516 	GPIO_WriteHigh(GPIOC, GPIO_PIN_5);//init to high
1171  000b 4b20          	push	#32
1172  000d ae500a        	ldw	x,#20490
1173  0010 cd0000        	call	_GPIO_WriteHigh
1175  0013 84            	pop	a
1176                     ; 517 	GPIO_WriteHigh(GPIOC, GPIO_PIN_3);//low->sleep, init to high not sleep
1178  0014 4b08          	push	#8
1179  0016 ae500a        	ldw	x,#20490
1180  0019 cd0000        	call	_GPIO_WriteHigh
1182  001c 84            	pop	a
1183                     ; 519 }
1186  001d 81            	ret	
1189                     	bsct
1190  0078               L324_p:
1191  0078 3f800000      	dc.w	16256,0
1192  007c               L524_d:
1193  007c 3f800000      	dc.w	16256,0
1267                     ; 521 void CmdDeal(void)
1267                     ; 522 {
1268                     .text:	section	.text,new
1269  0000               _CmdDeal:
1271  0000 520b          	subw	sp,#11
1272       0000000b      OFST:	set	11
1275                     ; 524 	float temp=0;
1277                     ; 525 	unsigned char pwm=0;
1279                     ; 526 	unsigned short CmdAdc=0;//nishizhen->shunshizhen:1024->0
1281                     ; 527 	if(NewI2cCmd!=0){
1283  0002 b633          	ld	a,_NewI2cCmd
1284  0004 2603cc009f    	jreq	L564
1285                     ; 528 		if(NewI2cCmd==0x01)//position change
1287  0009 a101          	cp	a,#1
1288  000b 2703cc009a    	jrne	L305
1289                     ; 530 			if(CmdPosition>330)
1291  0010 be2f          	ldw	x,_CmdPosition
1292  0012 a3014b        	cpw	x,#331
1293  0015 24ef          	jruge	L564
1294                     ; 531 			return;
1296                     ; 534 			temp=CmdPosition*2.844;
1298  0017 cd0000        	call	c_uitof
1300  001a ae0160        	ldw	x,#L761
1301  001d cd0000        	call	c_fmul
1303  0020 96            	ldw	x,sp
1304  0021 1c0007        	addw	x,#OFST-4
1305  0024 cd0000        	call	c_rtol
1307                     ; 535 			CmdAdc=temp;
1309  0027 96            	ldw	x,sp
1310  0028 1c0007        	addw	x,#OFST-4
1311  002b cd0000        	call	c_ltor
1313  002e cd0000        	call	c_ftoi
1315  0031 1f05          	ldw	(OFST-6,sp),x
1316                     ; 537 			if(CmdAdc>(AdcValue+10))
1318  0033 be29          	ldw	x,_AdcValue
1319  0035 1c000a        	addw	x,#10
1320  0038 1305          	cpw	x,(OFST-6,sp)
1321  003a 1e05          	ldw	x,(OFST-6,sp)
1322  003c 242a          	jruge	L374
1323                     ; 539 				temp=(CmdAdc-AdcValue);
1325  003e 72b00029      	subw	x,_AdcValue
1326  0042 cd0000        	call	c_uitof
1328  0045 96            	ldw	x,sp
1329  0046 ad5a          	call	LC005
1331  0048 96            	ldw	x,sp
1332  0049 5c            	incw	x
1333  004a cd0000        	call	c_rtol
1335  004d 96            	ldw	x,sp
1336  004e 1c0007        	addw	x,#OFST-4
1337  0051 cd0000        	call	c_ltor
1339  0054 96            	ldw	x,sp
1340  0055 5c            	incw	x
1341  0056 cd0000        	call	c_fcmp
1343  0059 2d04          	jrsle	L574
1344                     ; 542 					pwm=95;
1346  005b a65f          	ld	a,#95
1348  005d 2002          	jra	L774
1349  005f               L574:
1350                     ; 546 					pwm=50;
1352  005f a632          	ld	a,#50
1353  0061               L774:
1354  0061 6b0b          	ld	(OFST+0,sp),a
1355                     ; 548 				SetMotoReverse(pwm);
1357  0063 cd0000        	call	_SetMotoReverse
1360  0066 2037          	jra	L564
1361  0068               L374:
1362                     ; 551 			else if((CmdAdc+10)<AdcValue)
1364  0068 1c000a        	addw	x,#10
1365  006b b329          	cpw	x,_AdcValue
1366  006d 242b          	jruge	L305
1367                     ; 553 				temp=(AdcValue-CmdAdc);
1369  006f be29          	ldw	x,_AdcValue
1370  0071 72f005        	subw	x,(OFST-6,sp)
1371  0074 cd0000        	call	c_uitof
1373  0077 96            	ldw	x,sp
1374  0078 ad28          	call	LC005
1376  007a 96            	ldw	x,sp
1377  007b 5c            	incw	x
1378  007c cd0000        	call	c_rtol
1380  007f 96            	ldw	x,sp
1381  0080 1c0007        	addw	x,#OFST-4
1382  0083 cd0000        	call	c_ltor
1384  0086 96            	ldw	x,sp
1385  0087 5c            	incw	x
1386  0088 cd0000        	call	c_fcmp
1388  008b 2d04          	jrsle	L505
1389                     ; 556 					pwm=95;
1391  008d a65f          	ld	a,#95
1393  008f 2002          	jra	L705
1394  0091               L505:
1395                     ; 560 					pwm=50;
1397  0091 a632          	ld	a,#50
1398  0093               L705:
1399  0093 6b0b          	ld	(OFST+0,sp),a
1400                     ; 562 				SetMotoForward(pwm);
1402  0095 cd0000        	call	_SetMotoForward
1405  0098 2005          	jra	L564
1406  009a               L305:
1407                     ; 566 				NewI2cCmd=0;
1408                     ; 567 				SetMotoStop();
1410                     ; 570 		else if(NewI2cCmd==0x02)//stop
1412                     ; 572 			NewI2cCmd=0;
1413                     ; 573 			SetMotoStop();
1416                     ; 577 			NewI2cCmd=0;
1418                     ; 578    			SetMotoStop();
1422  009a 3f33          	clr	_NewI2cCmd
1425  009c cd0000        	call	_SetMotoStop
1427  009f               L564:
1428                     ; 581 }
1431  009f 5b0b          	addw	sp,#11
1432  00a1 81            	ret	
1433  00a2               LC005:
1434  00a2 1c0007        	addw	x,#OFST-4
1435  00a5 cd0000        	call	c_rtol
1437                     ; 540 				if(temp>50)
1439  00a8 a632          	ld	a,#50
1440  00aa cc0000        	jp	c_ctof
1476                     ; 582 void SetMotoForward(unsigned char pwm)
1476                     ; 583 {
1477                     .text:	section	.text,new
1478  0000               _SetMotoForward:
1480  0000 88            	push	a
1481       00000000      OFST:	set	0
1484                     ; 584 	GPIO_WriteHigh(GPIOC, GPIO_PIN_5);
1486  0001 4b20          	push	#32
1487  0003 ae500a        	ldw	x,#20490
1488  0006 cd0000        	call	_GPIO_WriteHigh
1490  0009 84            	pop	a
1491                     ; 585 	Set_Pwm_Channel3(pwm);
1493  000a 7b01          	ld	a,(OFST+1,sp)
1494  000c cd0000        	call	_Set_Pwm_Channel3
1496                     ; 586 }
1499  000f 84            	pop	a
1500  0010 81            	ret	
1536                     ; 587 void SetMotoReverse(unsigned char pwm)
1536                     ; 588 {
1537                     .text:	section	.text,new
1538  0000               _SetMotoReverse:
1540  0000 88            	push	a
1541       00000000      OFST:	set	0
1544                     ; 589 	GPIO_WriteLow(GPIOC, GPIO_PIN_5);
1546  0001 4b20          	push	#32
1547  0003 ae500a        	ldw	x,#20490
1548  0006 cd0000        	call	_GPIO_WriteLow
1550  0009 84            	pop	a
1551                     ; 590 	Set_Pwm_Channel3(pwm);
1553  000a 7b01          	ld	a,(OFST+1,sp)
1554  000c cd0000        	call	_Set_Pwm_Channel3
1556                     ; 591 }
1559  000f 84            	pop	a
1560  0010 81            	ret	
1584                     ; 592 void SetMotoStop(void)
1584                     ; 593 {
1585                     .text:	section	.text,new
1586  0000               _SetMotoStop:
1590                     ; 594 	Set_Pwm_Channel3(0);
1592  0000 4f            	clr	a
1594                     ; 595 }
1597  0001 cc0000        	jp	_Set_Pwm_Channel3
1621                     ; 596 void SetMotoSleep(void)
1621                     ; 597 {
1622                     .text:	section	.text,new
1623  0000               _SetMotoSleep:
1627                     ; 598 	Set_Pwm_Channel3(0);
1629  0000 4f            	clr	a
1631                     ; 599 }
1634  0001 cc0000        	jp	_Set_Pwm_Channel3
1750                     	xdef	_ReadBuffer
1751                     	xdef	_main
1752                     	xdef	_CLK_Configuration
1753                     	xdef	_CheckUartRxI2cAddr
1754                     	xdef	_SetMotoSleep
1755                     	xdef	_SetMotoStop
1756                     	xdef	_SetMotoReverse
1757                     	xdef	_SetMotoForward
1758                     	xdef	_Moto_Init
1759                     	xdef	_CmdDeal
1760                     	xdef	_Check_I2c_Data
1761                     	xdef	_SaveSysId
1762                     	xdef	_ReadSysId
1763                     	xdef	_SystemStatus
1764                     	xdef	_Systemid
1765                     	xdef	_NewI2cCmd
1766                     	xdef	_CmdTime
1767                     	xdef	_CmdPosition
1768                     	xdef	_AdcPosition
1769                     	xdef	_AdcSum
1770                     	xdef	_AdcValue
1771                     	xdef	_AdcBufCnt
1772                     	xdef	_ADC_BUF
1773                     	xref.b	_UartRxI2cAddrFlag
1774                     	xref.b	_UartRxI2cAddr
1775                     	xref.b	_IIC_BUF
1776                     	xref.b	_IIC_RECV_ONE_FRAME_OK
1777                     	xref.b	_SLAVE_ADDRESS
1778                     	xref.b	_Sys_1000ms_Flag
1779                     	xref.b	_Sys_500ms_Flag
1780                     	xref.b	_Sys_200ms_Flag
1781                     	xref.b	_Sys_100ms_Flag
1782                     	xref.b	_Sys_50ms_Flag
1783                     	xref.b	_Sys_20ms_Flag
1784                     	xref.b	_Sys_10ms_Flag
1785                     	xref	_ReadMultiBlockByte
1786                     	xref	_WriteMultiBlockByte
1787                     	xref	_UART1_printf
1788                     	xref	_Uart1_Init
1789                     	xref	_GetMotoADValue
1790                     	xref	_ADC_Init
1791                     	xref	_Init_I2C
1792                     	xref	_Tim1_Init
1793                     	xref	_LED_Reverse
1794                     	xref	_SetLedOFF
1795                     	xref	_LED_Init
1796                     	xref	_Set_Pwm_Channel3
1797                     	xref	_Pwm_Init
1798                     	xref	_GPIO_WriteLow
1799                     	xref	_GPIO_WriteHigh
1800                     	xref	_GPIO_Init
1801                     	xref	_FLASH_WaitForLastOperation
1802                     	xref	_FLASH_EraseBlock
1803                     	xref	_FLASH_SetProgrammingTime
1804                     	xref	_CLK_HSIPrescalerConfig
1805                     	xref	_CLK_HSICmd
1806                     .const:	section	.text
1807  0000               L114:
1808  0000 526563656976  	dc.b	"Receive a error cm"
1809  0012 643a25640d    	dc.b	"d:%d",13
1810  0017 0a00          	dc.b	10,0
1811  0019               L704:
1812  0019 526563656976  	dc.b	"Receive stop Cmd",13
1813  002a 0a00          	dc.b	10,0
1814  002c               L304:
1815  002c 75702d646f77  	dc.b	"up-down-head Cmd e"
1816  003e 72726f206f75  	dc.b	"rro out of(165-190"
1817  0050 290d          	dc.b	")",13
1818  0052 0a00          	dc.b	10,0
1819  0054               L173:
1820  0054 6c6566742d72  	dc.b	"left-right-head Cm"
1821  0066 64206572726f  	dc.b	"d erro out of(100-"
1822  0078 323630290d    	dc.b	"260)",13
1823  007d 0a00          	dc.b	10,0
1824  007f               L753:
1825  007f 526967687420  	dc.b	"Right Hand Cmd err"
1826  0091 6f206f757420  	dc.b	"o out of(130-290)",13
1827  00a3 0a00          	dc.b	10,0
1828  00a5               L543:
1829  00a5 4c6566742048  	dc.b	"Left Hand Cmd erro"
1830  00b7 206f7574206f  	dc.b	" out of(70-230)",13
1831  00c7 0a00          	dc.b	10,0
1832  00c9               L533:
1833  00c9 54686520436d  	dc.b	"The CmdPosition is"
1834  00db 3a25642c5468  	dc.b	":%d,The CmdTime is"
1835  00ed 3a25640d      	dc.b	":%d",13
1836  00f1 0a00          	dc.b	10,0
1837  00f3               L333:
1838  00f3 526563656976  	dc.b	"Receive a Position"
1839  0105 204368616e67  	dc.b	" Change Cmd",13
1840  0111 0a00          	dc.b	10,0
1841  0113               L313:
1842  0113 526563656976  	dc.b	"Receive a null cmd"
1843  0125 202830290d    	dc.b	" (0)",13
1844  012a 0a00          	dc.b	10,0
1845  012c               L552:
1846  012c 536176652053  	dc.b	"Save Sysid ok,the "
1847  013e 69642069733a  	dc.b	"id is:0x%02h",0
1848  014b               L371:
1849  014b 54686520506f  	dc.b	"The Position Is:%d"
1850  015d 0d0a00        	dc.b	13,10,0
1851  0160               L761:
1852  0160 40360418      	dc.w	16438,1048
1853  0164               L161:
1854  0164 546865204164  	dc.b	"The Adc Is:%d",13
1855  0172 0a00          	dc.b	10,0
1856  0174               L77:
1857  0174 53797374656d  	dc.b	"System is on....!!"
1858  0186 210d          	dc.b	"!",13
1859  0188 0a00          	dc.b	10,0
1860  018a               L57:
1861  018a 546865205379  	dc.b	"The Systemid is er"
1862  019c 726f722e2e2e  	dc.b	"ror....",13
1863  01a4 0a00          	dc.b	10,0
1864  01a6               L37:
1865  01a6 546865205379  	dc.b	"The System is for "
1866  01b8 75702d646f77  	dc.b	"up-down-head",13
1867  01c5 0a00          	dc.b	10,0
1868  01c7               L17:
1869  01c7 546865205379  	dc.b	"The System is for "
1870  01d9 4c6566742d52  	dc.b	"Left-Right-head",13
1871  01e9 0a00          	dc.b	10,0
1872  01eb               L76:
1873  01eb 546865205379  	dc.b	"The System is for "
1874  01fd 526967687468  	dc.b	"Righthand",13
1875  0207 0a00          	dc.b	10,0
1876  0209               L56:
1877  0209 546865205379  	dc.b	"The System is for "
1878  021b 4c6566746861  	dc.b	"Lefthand",13
1879  0224 0a00          	dc.b	10,0
1880  0226               L75:
1881  0226 526561642053  	dc.b	"Read Sysid is:%d",13
1882  0237 0a00          	dc.b	10,0
1883                     	xref.b	c_x
1903                     	xref	c_fcmp
1904                     	xref	c_ctof
1905                     	xref	c_ltor
1906                     	xref	c_rtol
1907                     	xref	c_fmul
1908                     	xref	c_ftoi
1909                     	xref	c_fdiv
1910                     	xref	c_uitof
1911                     	end
