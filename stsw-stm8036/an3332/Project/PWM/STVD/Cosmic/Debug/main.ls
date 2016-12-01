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
  30  002d               _CmdPosition:
  31  002d 0000          	dc.w	0
  32  002f               _CmdTime:
  33  002f 0000          	dc.w	0
  34  0031               _NewI2cCmd:
  35  0031 00            	dc.b	0
  36  0032               _Systemid:
  37  0032 0000          	dc.w	0
  38  0034               _SystemStatus:
  39  0034 0000          	dc.w	0
  70                     ; 125 void CLK_Configuration(void)
  70                     ; 126 {
  72                     .text:	section	.text,new
  73  0000               _CLK_Configuration:
  77                     ; 127    CLK_HSICmd(ENABLE);/* Set HSIEN bit */
  79  0000 a601          	ld	a,#1
  80  0002 cd0000        	call	_CLK_HSICmd
  82                     ; 130   CLK_HSIPrescalerConfig(CLK_PRESCALER_HSIDIV1); /* Fmaster = 16MHz */
  84  0005 4f            	clr	a
  86                     ; 132 }
  89  0006 cc0000        	jp	_CLK_HSIPrescalerConfig
 164                     ; 135 void main(void)
 164                     ; 136 {
 165                     .text:	section	.text,new
 166  0000               _main:
 168  0000 89            	pushw	x
 169       00000002      OFST:	set	2
 172                     ; 138 	unsigned char pwm=0,i=0;
 174  0001 0f01          	clr	(OFST-1,sp)
 177                     ; 140 CLK_Configuration();
 179  0003 cd0000        	call	_CLK_Configuration
 181                     ; 142 	LED_Init();//led3->PC3
 183  0006 cd0000        	call	_LED_Init
 185                     ; 145 	Systemid=0;
 187  0009 5f            	clrw	x
 188  000a bf32          	ldw	_Systemid,x
 189                     ; 146 	SystemStatus=0;//system init ok
 191  000c bf34          	ldw	_SystemStatus,x
 192                     ; 148 	NewI2cCmd=1;//开机执行一次命令，回到中间位置
 194  000e 35010031      	mov	_NewI2cCmd,#1
 195                     ; 149 	CmdPosition=180;//中间位置(0-360)
 197  0012 ae00b4        	ldw	x,#180
 198  0015 bf2d          	ldw	_CmdPosition,x
 199                     ; 150 	CmdTime=1000;//默认1000ms，暂时没有使用
 201  0017 ae03e8        	ldw	x,#1000
 202  001a bf2f          	ldw	_CmdTime,x
 203                     ; 152 	Moto_Init();//PC5->M_PHA PC3->M_nSLEEP PC4->nFAULT PC6->VISEN
 205  001c cd0000        	call	_Moto_Init
 207                     ; 153 	LED_Init();//led3->PC3
 209  001f cd0000        	call	_LED_Init
 211                     ; 154 	Tim1_Init();	
 213  0022 cd0000        	call	_Tim1_Init
 215                     ; 155 	Pwm_Init(); //channel3->PA3
 217  0025 cd0000        	call	_Pwm_Init
 219                     ; 156 	ADC_Init();// ADC1 Channel4 PD3
 221  0028 cd0000        	call	_ADC_Init
 223                     ; 157 	Uart1_Init();//PD5->Uart1 Tx   PD6->Uart1 Rx
 225  002b cd0000        	call	_Uart1_Init
 227                     ; 158 	SetLedOFF(); /* 让所有灯灭 */
 229  002e cd0000        	call	_SetLedOFF
 231                     ; 165 	Systemid=0x51;//lefthand
 233  0031 ae0051        	ldw	x,#81
 234  0034 bf32          	ldw	_Systemid,x
 235                     ; 170 	UART1_printf("Read Sysid is:%d\r\n",Systemid);//for 16bits printf
 237  0036 be32          	ldw	x,_Systemid
 238  0038 89            	pushw	x
 239  0039 ae0170        	ldw	x,#L75
 240  003c cd0000        	call	_UART1_printf
 242  003f 85            	popw	x
 243                     ; 172   switch (Systemid)
 245  0040 be32          	ldw	x,_Systemid
 247                     ; 194 		break;
 248  0042 1d0051        	subw	x,#81
 249  0045 271a          	jreq	L32
 250  0047 5a            	decw	x
 251  0048 2723          	jreq	L52
 252  004a 5a            	decw	x
 253  004b 272c          	jreq	L72
 254  004d 5a            	decw	x
 255  004e 2735          	jreq	L13
 256                     ; 190 		default :
 256                     ; 191 		UART1_printf("The Systemid is error....\r\n");
 258  0050 ae00d4        	ldw	x,#L57
 259  0053 cd0000        	call	_UART1_printf
 261                     ; 192 		SystemStatus=1;//system is error
 263  0056 ae0001        	ldw	x,#1
 264  0059 bf34          	ldw	_SystemStatus,x
 265                     ; 193 		SLAVE_ADDRESS=0x50;//default addr
 267  005b 35500000      	mov	_SLAVE_ADDRESS,#80
 268                     ; 194 		break;
 270  005f 202e          	jra	L36
 271  0061               L32:
 272                     ; 174 		case 0x51:
 272                     ; 175 		UART1_printf("The System is for Lefthand\r\n");
 274  0061 ae0153        	ldw	x,#L56
 275  0064 cd0000        	call	_UART1_printf
 277                     ; 176 		SLAVE_ADDRESS=0x51;
 279  0067 35510000      	mov	_SLAVE_ADDRESS,#81
 280                     ; 177 		break;
 282  006b 2022          	jra	L36
 283  006d               L52:
 284                     ; 178 		case 0x52:
 284                     ; 179 		UART1_printf("The System is for Righthand\r\n");
 286  006d ae0135        	ldw	x,#L76
 287  0070 cd0000        	call	_UART1_printf
 289                     ; 180 		SLAVE_ADDRESS=0x52;
 291  0073 35520000      	mov	_SLAVE_ADDRESS,#82
 292                     ; 181 		break;
 294  0077 2016          	jra	L36
 295  0079               L72:
 296                     ; 182 		case 0x53:
 296                     ; 183 		UART1_printf("The System is for Left-Right-head\r\n");
 298  0079 ae0111        	ldw	x,#L17
 299  007c cd0000        	call	_UART1_printf
 301                     ; 184 		SLAVE_ADDRESS=0x53;
 303  007f 35530000      	mov	_SLAVE_ADDRESS,#83
 304                     ; 185 		break;
 306  0083 200a          	jra	L36
 307  0085               L13:
 308                     ; 186 		case 0x54:
 308                     ; 187 		UART1_printf("The System is for up-down-head\r\n");
 310  0085 ae00f0        	ldw	x,#L37
 311  0088 cd0000        	call	_UART1_printf
 313                     ; 188 		SLAVE_ADDRESS=0x54;
 315  008b 35540000      	mov	_SLAVE_ADDRESS,#84
 316                     ; 189 		break;		
 318  008f               L36:
 319                     ; 196 	Init_I2C();//PB4-SCL PB5->SDA
 321  008f cd0000        	call	_Init_I2C
 323                     ; 198 	UART1_printf("System is on....!!!\r\n");
 325  0092 ae00be        	ldw	x,#L77
 326  0095 cd0000        	call	_UART1_printf
 328                     ; 199 	enableInterrupts(); 
 331  0098 9a            	rim	
 333  0099               L101:
 334                     ; 210 		if(Sys_10ms_Flag==1)
 336  0099 b600          	ld	a,_Sys_10ms_Flag
 337  009b 4a            	dec	a
 338  009c 2608          	jrne	L501
 339                     ; 212 			Sys_10ms_Flag=0;
 341  009e b700          	ld	_Sys_10ms_Flag,a
 342                     ; 213 			Check_I2c_Data();
 344  00a0 cd0000        	call	_Check_I2c_Data
 346                     ; 214 			CmdDeal();
 348  00a3 cd0000        	call	_CmdDeal
 350  00a6               L501:
 351                     ; 216 		if(Sys_20ms_Flag==1)
 353  00a6 b600          	ld	a,_Sys_20ms_Flag
 354  00a8 4a            	dec	a
 355  00a9 2640          	jrne	L701
 356                     ; 218 			Sys_20ms_Flag=0;
 358  00ab b700          	ld	_Sys_20ms_Flag,a
 359                     ; 219 			if(SystemStatus==0)
 361  00ad be34          	ldw	x,_SystemStatus
 362  00af 263a          	jrne	L701
 363                     ; 221 				AdcBufCnt++;
 365  00b1 3c28          	inc	_AdcBufCnt
 366                     ; 222 				if(AdcBufCnt>=ADC_FILTER_LENGTH)
 368  00b3 b628          	ld	a,_AdcBufCnt
 369  00b5 a114          	cp	a,#20
 370  00b7 2502          	jrult	L311
 371                     ; 223 				AdcBufCnt=0;
 373  00b9 3f28          	clr	_AdcBufCnt
 374  00bb               L311:
 375                     ; 225 				ADC_BUF[AdcBufCnt]=GetMotoADValue();
 377  00bb cd0000        	call	_GetMotoADValue
 379  00be b628          	ld	a,_AdcBufCnt
 380  00c0 905f          	clrw	y
 381  00c2 9097          	ld	yl,a
 382  00c4 9058          	sllw	y
 383  00c6 90ef00        	ldw	(_ADC_BUF,y),x
 384                     ; 227 				AdcSum=0;
 386  00c9 5f            	clrw	x
 387  00ca bf2b          	ldw	_AdcSum,x
 388                     ; 228 				for(i=0;i<ADC_FILTER_LENGTH;i++)
 390  00cc 4f            	clr	a
 391  00cd 6b02          	ld	(OFST+0,sp),a
 392  00cf               L511:
 393                     ; 229 				AdcSum+=ADC_BUF[i];
 395  00cf 5f            	clrw	x
 396  00d0 97            	ld	xl,a
 397  00d1 58            	sllw	x
 398  00d2 ee00          	ldw	x,(_ADC_BUF,x)
 399  00d4 72bb002b      	addw	x,_AdcSum
 400  00d8 bf2b          	ldw	_AdcSum,x
 401                     ; 228 				for(i=0;i<ADC_FILTER_LENGTH;i++)
 403  00da 0c02          	inc	(OFST+0,sp)
 406  00dc 7b02          	ld	a,(OFST+0,sp)
 407  00de a114          	cp	a,#20
 408  00e0 25ed          	jrult	L511
 409                     ; 231 				AdcValue=AdcSum/ADC_FILTER_LENGTH;
 411                     ; 234 				AdcValue=ADC_BUF[AdcBufCnt];
 413  00e2 b628          	ld	a,_AdcBufCnt
 414  00e4 5f            	clrw	x
 415  00e5 97            	ld	xl,a
 416  00e6 58            	sllw	x
 417  00e7 ee00          	ldw	x,(_ADC_BUF,x)
 418  00e9 bf29          	ldw	_AdcValue,x
 420  00eb               L701:
 421                     ; 242 		if(Sys_50ms_Flag==1)
 423  00eb b600          	ld	a,_Sys_50ms_Flag
 424  00ed 4a            	dec	a
 425  00ee 2609          	jrne	L521
 426                     ; 244 			Sys_50ms_Flag=0;
 428  00f0 b700          	ld	_Sys_50ms_Flag,a
 429                     ; 246 			if(SystemStatus==0)
 431  00f2 be34          	ldw	x,_SystemStatus
 432  00f4 2603          	jrne	L521
 433                     ; 248 				Check_I2c_Data();
 435  00f6 cd0000        	call	_Check_I2c_Data
 438  00f9               L521:
 439                     ; 256 		if(Sys_100ms_Flag==1)
 441  00f9 b600          	ld	a,_Sys_100ms_Flag
 442  00fb 4a            	dec	a
 443  00fc 2604          	jrne	L331
 444                     ; 258 			Sys_100ms_Flag=0;
 446  00fe b700          	ld	_Sys_100ms_Flag,a
 447                     ; 260 			if(SystemStatus==0)
 449  0100 be34          	ldw	x,_SystemStatus
 451  0102               L331:
 452                     ; 278 		if(Sys_200ms_Flag==1)
 454  0102 b600          	ld	a,_Sys_200ms_Flag
 455  0104 4a            	dec	a
 456  0105 260b          	jrne	L141
 457                     ; 280 			Sys_200ms_Flag=0;
 459  0107 b700          	ld	_Sys_200ms_Flag,a
 460                     ; 282 			if(SystemStatus==0)
 462  0109 be34          	ldw	x,_SystemStatus
 463  010b 2705          	jreq	L141
 465                     ; 290 				LED_Reverse(LED_3);
 467  010d a680          	ld	a,#128
 468  010f cd0000        	call	_LED_Reverse
 470  0112               L141:
 471                     ; 294 		if(Sys_500ms_Flag==1)
 473  0112 b600          	ld	a,_Sys_500ms_Flag
 474  0114 4a            	dec	a
 475  0115 2604          	jrne	L741
 476                     ; 296 			Sys_500ms_Flag=0;
 478  0117 b700          	ld	_Sys_500ms_Flag,a
 479                     ; 298 			if(SystemStatus==0)
 481  0119 be34          	ldw	x,_SystemStatus
 483  011b               L741:
 484                     ; 307 		if(Sys_1000ms_Flag==1)
 486  011b b600          	ld	a,_Sys_1000ms_Flag
 487  011d 4a            	dec	a
 488  011e 2703cc0099    	jrne	L101
 489                     ; 309 			Sys_1000ms_Flag=0;
 491  0123 b700          	ld	_Sys_1000ms_Flag,a
 492                     ; 311 			if(SystemStatus==0)
 494  0125 be34          	ldw	x,_SystemStatus
 495  0127 26f7          	jrne	L101
 496                     ; 313 				LED_Reverse(LED_3);
 498  0129 a680          	ld	a,#128
 499  012b cd0000        	call	_LED_Reverse
 501                     ; 314 				UART1_printf("The Adc Is:%d\r\n",AdcValue);
 503  012e be29          	ldw	x,_AdcValue
 504  0130 89            	pushw	x
 505  0131 ae00ae        	ldw	x,#L161
 506  0134 cd0000        	call	_UART1_printf
 508  0137 85            	popw	x
 510  0138 cc0099        	jra	L101
 542                     ; 346 void CheckUartRxI2cAddr(void)
 542                     ; 347 {
 543                     .text:	section	.text,new
 544  0000               _CheckUartRxI2cAddr:
 548                     ; 348 	if(UartRxI2cAddrFlag==1)
 550  0000 b600          	ld	a,_UartRxI2cAddrFlag
 551  0002 4a            	dec	a
 552  0003 266d          	jrne	L702
 553                     ; 350 		UartRxI2cAddrFlag=0;
 555  0005 b700          	ld	_UartRxI2cAddrFlag,a
 556                     ; 351 		SLAVE_ADDRESS=UartRxI2cAddr;
 558  0007 450000        	mov	_SLAVE_ADDRESS,_UartRxI2cAddr
 559                     ; 352 		SaveSysId(SLAVE_ADDRESS);
 561  000a b600          	ld	a,_SLAVE_ADDRESS
 562  000c cd0000        	call	_SaveSysId
 564                     ; 353 		Systemid=ReadSysId();
 566  000f cd0000        	call	_ReadSysId
 568  0012 5f            	clrw	x
 569  0013 97            	ld	xl,a
 570  0014 bf32          	ldw	_Systemid,x
 571                     ; 354 		UART1_printf("Read Sysid is:%d\r\n",Systemid);//for 16bits printf
 573  0016 be32          	ldw	x,_Systemid
 574  0018 89            	pushw	x
 575  0019 ae0170        	ldw	x,#L75
 576  001c cd0000        	call	_UART1_printf
 578  001f 85            	popw	x
 579                     ; 356 		switch (Systemid)
 581  0020 be32          	ldw	x,_Systemid
 583                     ; 378 			break;
 584  0022 1d0051        	subw	x,#81
 585  0025 271a          	jreq	L561
 586  0027 5a            	decw	x
 587  0028 2723          	jreq	L761
 588  002a 5a            	decw	x
 589  002b 272c          	jreq	L171
 590  002d 5a            	decw	x
 591  002e 2735          	jreq	L371
 592                     ; 374 			default :
 592                     ; 375 			UART1_printf("The Systemid is error....\r\n");
 594  0030 ae00d4        	ldw	x,#L57
 595  0033 cd0000        	call	_UART1_printf
 597                     ; 376 			SystemStatus=1;//system is error
 599  0036 ae0001        	ldw	x,#1
 600  0039 bf34          	ldw	_SystemStatus,x
 601                     ; 377 			SLAVE_ADDRESS=0x50;//default addr
 603  003b 35500000      	mov	_SLAVE_ADDRESS,#80
 604                     ; 378 			break;
 606  003f 202e          	jra	L312
 607  0041               L561:
 608                     ; 358 			case 0x51:
 608                     ; 359 			UART1_printf("The System is for Lefthand\r\n");
 610  0041 ae0153        	ldw	x,#L56
 611  0044 cd0000        	call	_UART1_printf
 613                     ; 360 			SLAVE_ADDRESS=0x51;
 615  0047 35510000      	mov	_SLAVE_ADDRESS,#81
 616                     ; 361 			break;
 618  004b 2022          	jra	L312
 619  004d               L761:
 620                     ; 362 			case 0x52:
 620                     ; 363 			UART1_printf("The System is for Righthand\r\n");
 622  004d ae0135        	ldw	x,#L76
 623  0050 cd0000        	call	_UART1_printf
 625                     ; 364 			SLAVE_ADDRESS=0x52;
 627  0053 35520000      	mov	_SLAVE_ADDRESS,#82
 628                     ; 365 			break;
 630  0057 2016          	jra	L312
 631  0059               L171:
 632                     ; 366 			case 0x53:
 632                     ; 367 			UART1_printf("The System is for Left-Right-head\r\n");
 634  0059 ae0111        	ldw	x,#L17
 635  005c cd0000        	call	_UART1_printf
 637                     ; 368 			SLAVE_ADDRESS=0x53;
 639  005f 35530000      	mov	_SLAVE_ADDRESS,#83
 640                     ; 369 			break;
 642  0063 200a          	jra	L312
 643  0065               L371:
 644                     ; 370 			case 0x54:
 644                     ; 371 			UART1_printf("The System is for up-down-head\r\n");
 646  0065 ae00f0        	ldw	x,#L37
 647  0068 cd0000        	call	_UART1_printf
 649                     ; 372 			SLAVE_ADDRESS=0x54;
 651  006b 35540000      	mov	_SLAVE_ADDRESS,#84
 652                     ; 373 			break;		
 654  006f               L312:
 655                     ; 380 		Init_I2C();//PB4-SCL PB5->SDA		
 657  006f cd0000        	call	_Init_I2C
 659  0072               L702:
 660                     ; 382 }
 663  0072 81            	ret	
 666                     	bsct
 667  0036               _ReadBuffer:
 668  0036 00            	dc.b	0
 669  0037 000000000000  	ds.b	63
 692                     ; 385 unsigned char ReadSysId(void)
 692                     ; 386 {
 693                     .text:	section	.text,new
 694  0000               _ReadSysId:
 698                     ; 388 	ReadMultiBlockByte(Block_0,1,ReadBuffer);
 700  0000 ae0036        	ldw	x,#_ReadBuffer
 701  0003 89            	pushw	x
 702  0004 ae0001        	ldw	x,#1
 703  0007 4f            	clr	a
 704  0008 95            	ld	xh,a
 705  0009 cd0000        	call	_ReadMultiBlockByte
 707  000c b636          	ld	a,_ReadBuffer
 708  000e 85            	popw	x
 709                     ; 389 	return ReadBuffer[0];
 713  000f 81            	ret	
 754                     ; 391 unsigned char SaveSysId(unsigned char id)
 754                     ; 392 {
 755                     .text:	section	.text,new
 756  0000               _SaveSysId:
 758  0000 88            	push	a
 759       00000000      OFST:	set	0
 762                     ; 393 	ReadMultiBlockByte(Block_0,1,ReadBuffer);
 764  0001 ae0036        	ldw	x,#_ReadBuffer
 765  0004 89            	pushw	x
 766  0005 ae0001        	ldw	x,#1
 767  0008 4f            	clr	a
 768  0009 95            	ld	xh,a
 769  000a cd0000        	call	_ReadMultiBlockByte
 771  000d 85            	popw	x
 772                     ; 394 	ReadBuffer[0]=id;
 774  000e 7b01          	ld	a,(OFST+1,sp)
 775  0010 b736          	ld	_ReadBuffer,a
 776                     ; 396 	FLASH_SetProgrammingTime(FLASH_PROGRAMTIME_STANDARD);
 778  0012 4f            	clr	a
 779  0013 cd0000        	call	_FLASH_SetProgrammingTime
 781                     ; 398 	FLASH_EraseBlock(Block_0, FLASH_MEMTYPE_DATA);/*往FLASH写数据前，要擦除对应的区域*/
 783  0016 4bf7          	push	#247
 784  0018 5f            	clrw	x
 785  0019 cd0000        	call	_FLASH_EraseBlock
 787  001c 84            	pop	a
 788                     ; 399 	FLASH_WaitForLastOperation(FLASH_MEMTYPE_DATA);
 790  001d a6f7          	ld	a,#247
 791  001f cd0000        	call	_FLASH_WaitForLastOperation
 793                     ; 401 	WriteMultiBlockByte(Block_0,FLASH_MEMTYPE_DATA,FLASH_PROGRAMMODE_STANDARD,ReadBuffer,1);
 795  0022 4b01          	push	#1
 796  0024 ae0036        	ldw	x,#_ReadBuffer
 797  0027 89            	pushw	x
 798  0028 4b00          	push	#0
 799  002a ae00f7        	ldw	x,#247
 800  002d 4f            	clr	a
 801  002e 95            	ld	xh,a
 802  002f cd0000        	call	_WriteMultiBlockByte
 804  0032 5b04          	addw	sp,#4
 805                     ; 404 	UART1_printf("Save Sysid ok,the id is:0x%02h",ReadBuffer[0]);
 807  0034 3b0036        	push	_ReadBuffer
 808  0037 ae008f        	ldw	x,#L342
 809  003a cd0000        	call	_UART1_printf
 811  003d 84            	pop	a
 812                     ; 406 }
 815  003e 84            	pop	a
 816  003f 81            	ret	
 857                     ; 407 void Check_I2c_Data(void)
 857                     ; 408 {
 858                     .text:	section	.text,new
 859  0000               _Check_I2c_Data:
 861  0000 88            	push	a
 862       00000001      OFST:	set	1
 865                     ; 409 	u8 i=0;
 867  0001 0f01          	clr	(OFST+0,sp)
 868                     ; 411 	if(IIC_RECV_ONE_FRAME_OK==1)
 870  0003 b600          	ld	a,_IIC_RECV_ONE_FRAME_OK
 871  0005 4a            	dec	a
 872  0006 2703cc00e6    	jrne	L372
 873                     ; 414 		IIC_RECV_ONE_FRAME_OK=0;
 875  000b b700          	ld	_IIC_RECV_ONE_FRAME_OK,a
 876                     ; 415 		NewI2cCmd=IIC_BUF[0];
 878  000d 450031        	mov	_NewI2cCmd,_IIC_BUF
 879                     ; 416 		switch (NewI2cCmd){
 881  0010 b631          	ld	a,_NewI2cCmd
 883                     ; 498 			break;
 884  0012 2718          	jreq	L542
 885  0014 4a            	dec	a
 886  0015 271b          	jreq	L742
 887  0017 4a            	dec	a
 888  0018 2603cc00e0    	jreq	L152
 889                     ; 496 			default:
 889                     ; 497 			UART1_printf("Receive a error cmd:%d\r\n",(unsigned int)(NewI2cCmd));
 891  001d b631          	ld	a,_NewI2cCmd
 892  001f 5f            	clrw	x
 893  0020 97            	ld	xl,a
 894  0021 89            	pushw	x
 895  0022 ae0000        	ldw	x,#L763
 896  0025 cd0000        	call	_UART1_printf
 898  0028 85            	popw	x
 899                     ; 498 			break;
 901  0029 cc00e6        	jra	L372
 902  002c               L542:
 903                     ; 417 			case 0x00:
 903                     ; 418 			UART1_printf("Receive a null cmd (0)\r\n");
 905  002c ae0076        	ldw	x,#L103
 907                     ; 419 			break;
 909  002f cc00e3        	jp	LC002
 910  0032               L742:
 911                     ; 420 			case 0x01:
 911                     ; 421 			//cmd buf (-180,180)->CmdPosition (0-360) 
 911                     ; 422 			CmdPosition=180;
 913  0032 ae00b4        	ldw	x,#180
 914  0035 bf2d          	ldw	_CmdPosition,x
 915                     ; 424 			if(IIC_BUF[1]==0x00)//shunshizhen
 917  0037 3d01          	tnz	_IIC_BUF+1
 918  0039 260f          	jrne	L303
 919                     ; 426 				if(IIC_BUF[2]<=180)
 921  003b b602          	ld	a,_IIC_BUF+2
 922  003d a1b5          	cp	a,#181
 923  003f 241a          	jruge	L703
 924                     ; 427 				CmdPosition=IIC_BUF[2]+180;
 926  0041 b602          	ld	a,_IIC_BUF+2
 927  0043 5f            	clrw	x
 928  0044 97            	ld	xl,a
 929  0045 1c00b4        	addw	x,#180
 930  0048 200f          	jp	LC001
 931  004a               L303:
 932                     ; 429 			else if(IIC_BUF[1]==0x01)//nishizhen
 934  004a b601          	ld	a,_IIC_BUF+1
 935  004c 4a            	dec	a
 936  004d 260c          	jrne	L703
 937                     ; 431 				if(IIC_BUF[2]<=180)
 939  004f b602          	ld	a,_IIC_BUF+2
 940  0051 a1b5          	cp	a,#181
 941  0053 2406          	jruge	L703
 942                     ; 432 				CmdPosition=IIC_BUF[2];
 944  0055 b602          	ld	a,_IIC_BUF+2
 945  0057 5f            	clrw	x
 946  0058 97            	ld	xl,a
 947  0059               LC001:
 948  0059 bf2d          	ldw	_CmdPosition,x
 949  005b               L703:
 950                     ; 438 			if(CmdPosition>360)
 952  005b a30169        	cpw	x,#361
 953  005e 2505          	jrult	L713
 954                     ; 439 			CmdPosition=360;
 956  0060 ae0168        	ldw	x,#360
 957  0063 bf2d          	ldw	_CmdPosition,x
 958  0065               L713:
 959                     ; 440 			CmdTime=IIC_BUF[3]*256+IIC_BUF[4];
 961  0065 b603          	ld	a,_IIC_BUF+3
 962  0067 5f            	clrw	x
 963  0068 97            	ld	xl,a
 964  0069 4f            	clr	a
 965  006a bb04          	add	a,_IIC_BUF+4
 966  006c 2401          	jrnc	L641
 967  006e 5c            	incw	x
 968  006f               L641:
 969  006f b730          	ld	_CmdTime+1,a
 970  0071 9f            	ld	a,xl
 971  0072 b72f          	ld	_CmdTime,a
 972                     ; 453 			if(Systemid==0x51){
 974  0074 be32          	ldw	x,_Systemid
 975  0076 a30051        	cpw	x,#81
 976  0079 260e          	jrne	L123
 977                     ; 454 				if(CmdPosition<(180-110)||CmdPosition>(180+50))
 979  007b be2d          	ldw	x,_CmdPosition
 980  007d a30046        	cpw	x,#70
 981  0080 2505          	jrult	L523
 983  0082 a300e7        	cpw	x,#231
 984  0085 2543          	jrult	L723
 985  0087               L523:
 986                     ; 456 					return;
 989  0087 84            	pop	a
 990  0088 81            	ret	
 991  0089               L123:
 992                     ; 462 			else if(Systemid==0x52){
 994  0089 be32          	ldw	x,_Systemid
 995  008b a30052        	cpw	x,#82
 996  008e 260e          	jrne	L133
 997                     ; 463 				if(CmdPosition<(180-50)||CmdPosition>(180+110))
 999  0090 be2d          	ldw	x,_CmdPosition
1000  0092 a30082        	cpw	x,#130
1001  0095 2505          	jrult	L533
1003  0097 a30123        	cpw	x,#291
1004  009a 252e          	jrult	L723
1005  009c               L533:
1006                     ; 465 					return;
1009  009c 84            	pop	a
1010  009d 81            	ret	
1011  009e               L133:
1012                     ; 471 			else if(Systemid==0x53){
1014  009e be32          	ldw	x,_Systemid
1015  00a0 a30053        	cpw	x,#83
1016  00a3 260e          	jrne	L143
1017                     ; 472 				if(CmdPosition<(180-90)||CmdPosition>(180+90))
1019  00a5 be2d          	ldw	x,_CmdPosition
1020  00a7 a3005a        	cpw	x,#90
1021  00aa 2505          	jrult	L543
1023  00ac a3010f        	cpw	x,#271
1024  00af 2519          	jrult	L723
1025  00b1               L543:
1026                     ; 474 					return;
1029  00b1 84            	pop	a
1030  00b2 81            	ret	
1031  00b3               L143:
1032                     ; 480 			else if(Systemid==0x54){
1034  00b3 be32          	ldw	x,_Systemid
1035  00b5 a30054        	cpw	x,#84
1036  00b8 260e          	jrne	L153
1037                     ; 481 				if(CmdPosition<(180-15)||CmdPosition>(180+10))
1039  00ba be2d          	ldw	x,_CmdPosition
1040  00bc a300a5        	cpw	x,#165
1041  00bf 2505          	jrult	L553
1043  00c1 a300bf        	cpw	x,#191
1044  00c4 2504          	jrult	L723
1045  00c6               L553:
1046                     ; 483 					return;
1049  00c6 84            	pop	a
1050  00c7 81            	ret	
1051  00c8               L153:
1052                     ; 488 				return;
1055  00c8 84            	pop	a
1056  00c9 81            	ret	
1057  00ca               L723:
1058                     ; 490 			UART1_printf("Receive a Position Change Cmd\r\n");
1060  00ca ae0056        	ldw	x,#L163
1061  00cd cd0000        	call	_UART1_printf
1063                     ; 491 			UART1_printf("The CmdPosition is:%d,The CmdTime is:%d\r\n",CmdPosition,CmdTime);			
1065  00d0 be2f          	ldw	x,_CmdTime
1066  00d2 89            	pushw	x
1067  00d3 be2d          	ldw	x,_CmdPosition
1068  00d5 89            	pushw	x
1069  00d6 ae002c        	ldw	x,#L363
1070  00d9 cd0000        	call	_UART1_printf
1072  00dc 5b04          	addw	sp,#4
1073                     ; 492 			break;
1075  00de 2006          	jra	L372
1076  00e0               L152:
1077                     ; 493 			case 0x02:
1077                     ; 494 			UART1_printf("Receive stop Cmd\r\n");
1079  00e0 ae0019        	ldw	x,#L563
1080  00e3               LC002:
1081  00e3 cd0000        	call	_UART1_printf
1083                     ; 495 			break;
1085  00e6               L372:
1086                     ; 501 }
1089  00e6 84            	pop	a
1090  00e7 81            	ret	
1115                     ; 503 void Moto_Init(void)
1115                     ; 504 {
1116                     .text:	section	.text,new
1117  0000               _Moto_Init:
1121                     ; 506 	GPIO_Init(GPIOC,GPIO_PIN_3|GPIO_PIN_5|GPIO_PIN_4|GPIO_PIN_6, GPIO_MODE_OUT_PP_HIGH_FAST );	
1123  0000 4bf0          	push	#240
1124  0002 4b78          	push	#120
1125  0004 ae500a        	ldw	x,#20490
1126  0007 cd0000        	call	_GPIO_Init
1128  000a 85            	popw	x
1129                     ; 508 	GPIO_WriteHigh(GPIOC, GPIO_PIN_5);//init to high
1131  000b 4b20          	push	#32
1132  000d ae500a        	ldw	x,#20490
1133  0010 cd0000        	call	_GPIO_WriteHigh
1135  0013 84            	pop	a
1136                     ; 509 	GPIO_WriteHigh(GPIOC, GPIO_PIN_3);//low->sleep, init to high not sleep
1138  0014 4b08          	push	#8
1139  0016 ae500a        	ldw	x,#20490
1140  0019 cd0000        	call	_GPIO_WriteHigh
1142  001c 84            	pop	a
1143                     ; 511 }
1146  001d 81            	ret	
1149                     	bsct
1150  0076               L104_p:
1151  0076 3f800000      	dc.w	16256,0
1152  007a               L304_d:
1153  007a 3f800000      	dc.w	16256,0
1227                     ; 513 void CmdDeal(void)
1227                     ; 514 {
1228                     .text:	section	.text,new
1229  0000               _CmdDeal:
1231  0000 520b          	subw	sp,#11
1232       0000000b      OFST:	set	11
1235                     ; 516 	float temp=0;
1237                     ; 517 	unsigned char pwm=0;
1239                     ; 518 	unsigned short CmdAdc=0;//nishizhen->shunshizhen:1024->0
1241                     ; 519 	if(NewI2cCmd!=0){
1243  0002 b631          	ld	a,_NewI2cCmd
1244  0004 2603cc00a0    	jreq	L344
1245                     ; 520 		if(NewI2cCmd==0x01)//position change
1247  0009 4a            	dec	a
1248  000a 2703cc009b    	jrne	L164
1249                     ; 522 			if(CmdPosition>360)
1251  000f be2d          	ldw	x,_CmdPosition
1252  0011 a30169        	cpw	x,#361
1253  0014 24f0          	jruge	L344
1254                     ; 523 			return;
1256                     ; 525 			temp=CmdPosition*1024/360;
1258  0016 02            	rlwa	x,a
1259  0017 58            	sllw	x
1260  0018 58            	sllw	x
1261  0019 90ae0168      	ldw	y,#360
1262  001d 65            	divw	x,y
1263  001e cd0000        	call	c_uitof
1265  0021 96            	ldw	x,sp
1266  0022 1c0007        	addw	x,#OFST-4
1267  0025 cd0000        	call	c_rtol
1269                     ; 526 			CmdAdc=temp;
1271  0028 96            	ldw	x,sp
1272  0029 1c0007        	addw	x,#OFST-4
1273  002c cd0000        	call	c_ltor
1275  002f cd0000        	call	c_ftoi
1277  0032 1f05          	ldw	(OFST-6,sp),x
1278                     ; 528 			if(CmdAdc>(AdcValue+10))
1280  0034 be29          	ldw	x,_AdcValue
1281  0036 1c000a        	addw	x,#10
1282  0039 1305          	cpw	x,(OFST-6,sp)
1283  003b 1e05          	ldw	x,(OFST-6,sp)
1284  003d 242a          	jruge	L154
1285                     ; 530 				temp=(CmdAdc-AdcValue);
1287  003f 72b00029      	subw	x,_AdcValue
1288  0043 cd0000        	call	c_uitof
1290  0046 96            	ldw	x,sp
1291  0047 ad5a          	call	LC004
1293  0049 96            	ldw	x,sp
1294  004a 5c            	incw	x
1295  004b cd0000        	call	c_rtol
1297  004e 96            	ldw	x,sp
1298  004f 1c0007        	addw	x,#OFST-4
1299  0052 cd0000        	call	c_ltor
1301  0055 96            	ldw	x,sp
1302  0056 5c            	incw	x
1303  0057 cd0000        	call	c_fcmp
1305  005a 2d04          	jrsle	L354
1306                     ; 533 					pwm=95;
1308  005c a65f          	ld	a,#95
1310  005e 2002          	jra	L554
1311  0060               L354:
1312                     ; 537 					pwm=70;
1314  0060 a646          	ld	a,#70
1315  0062               L554:
1316  0062 6b0b          	ld	(OFST+0,sp),a
1317                     ; 539 				SetMotoForward(pwm);
1319  0064 cd0000        	call	_SetMotoForward
1322  0067 2037          	jra	L344
1323  0069               L154:
1324                     ; 541 			else if((CmdAdc+10)<AdcValue)
1326  0069 1c000a        	addw	x,#10
1327  006c b329          	cpw	x,_AdcValue
1328  006e 242b          	jruge	L164
1329                     ; 543 				temp=(AdcValue-CmdAdc);
1331  0070 be29          	ldw	x,_AdcValue
1332  0072 72f005        	subw	x,(OFST-6,sp)
1333  0075 cd0000        	call	c_uitof
1335  0078 96            	ldw	x,sp
1336  0079 ad28          	call	LC004
1338  007b 96            	ldw	x,sp
1339  007c 5c            	incw	x
1340  007d cd0000        	call	c_rtol
1342  0080 96            	ldw	x,sp
1343  0081 1c0007        	addw	x,#OFST-4
1344  0084 cd0000        	call	c_ltor
1346  0087 96            	ldw	x,sp
1347  0088 5c            	incw	x
1348  0089 cd0000        	call	c_fcmp
1350  008c 2d04          	jrsle	L364
1351                     ; 546 					pwm=95;
1353  008e a65f          	ld	a,#95
1355  0090 2002          	jra	L564
1356  0092               L364:
1357                     ; 550 					pwm=70;
1359  0092 a646          	ld	a,#70
1360  0094               L564:
1361  0094 6b0b          	ld	(OFST+0,sp),a
1362                     ; 552 				SetMotoReverse(pwm);
1364  0096 cd0000        	call	_SetMotoReverse
1367  0099 2005          	jra	L344
1368  009b               L164:
1369                     ; 556 				NewI2cCmd=0;
1370                     ; 557 				SetMotoStop();
1372                     ; 560 		else if(NewI2cCmd==0x02)//stop
1374                     ; 562 			NewI2cCmd=0;
1375                     ; 563 			SetMotoStop();
1378                     ; 567 			NewI2cCmd=0;
1380                     ; 568    			SetMotoStop();
1384  009b 3f31          	clr	_NewI2cCmd
1387  009d cd0000        	call	_SetMotoStop
1389  00a0               L344:
1390                     ; 571 }
1393  00a0 5b0b          	addw	sp,#11
1394  00a2 81            	ret	
1395  00a3               LC004:
1396  00a3 1c0007        	addw	x,#OFST-4
1397  00a6 cd0000        	call	c_rtol
1399                     ; 531 				if(temp>100)
1401  00a9 a664          	ld	a,#100
1402  00ab cc0000        	jp	c_ctof
1438                     ; 572 void SetMotoForward(unsigned char pwm)
1438                     ; 573 {
1439                     .text:	section	.text,new
1440  0000               _SetMotoForward:
1442  0000 88            	push	a
1443       00000000      OFST:	set	0
1446                     ; 574 	GPIO_WriteHigh(GPIOC, GPIO_PIN_5);
1448  0001 4b20          	push	#32
1449  0003 ae500a        	ldw	x,#20490
1450  0006 cd0000        	call	_GPIO_WriteHigh
1452  0009 84            	pop	a
1453                     ; 575 	Set_Pwm_Channel3(pwm);
1455  000a 7b01          	ld	a,(OFST+1,sp)
1456  000c cd0000        	call	_Set_Pwm_Channel3
1458                     ; 576 }
1461  000f 84            	pop	a
1462  0010 81            	ret	
1498                     ; 577 void SetMotoReverse(unsigned char pwm)
1498                     ; 578 {
1499                     .text:	section	.text,new
1500  0000               _SetMotoReverse:
1502  0000 88            	push	a
1503       00000000      OFST:	set	0
1506                     ; 579 	GPIO_WriteLow(GPIOC, GPIO_PIN_5);
1508  0001 4b20          	push	#32
1509  0003 ae500a        	ldw	x,#20490
1510  0006 cd0000        	call	_GPIO_WriteLow
1512  0009 84            	pop	a
1513                     ; 580 	Set_Pwm_Channel3(pwm);
1515  000a 7b01          	ld	a,(OFST+1,sp)
1516  000c cd0000        	call	_Set_Pwm_Channel3
1518                     ; 581 }
1521  000f 84            	pop	a
1522  0010 81            	ret	
1546                     ; 582 void SetMotoStop(void)
1546                     ; 583 {
1547                     .text:	section	.text,new
1548  0000               _SetMotoStop:
1552                     ; 584 	Set_Pwm_Channel3(0);
1554  0000 4f            	clr	a
1556                     ; 585 }
1559  0001 cc0000        	jp	_Set_Pwm_Channel3
1583                     ; 586 void SetMotoSleep(void)
1583                     ; 587 {
1584                     .text:	section	.text,new
1585  0000               _SetMotoSleep:
1589                     ; 588 	Set_Pwm_Channel3(0);
1591  0000 4f            	clr	a
1593                     ; 589 }
1596  0001 cc0000        	jp	_Set_Pwm_Channel3
1703                     	xdef	_ReadBuffer
1704                     	xdef	_main
1705                     	xdef	_CLK_Configuration
1706                     	xdef	_CheckUartRxI2cAddr
1707                     	xdef	_SetMotoSleep
1708                     	xdef	_SetMotoStop
1709                     	xdef	_SetMotoReverse
1710                     	xdef	_SetMotoForward
1711                     	xdef	_Moto_Init
1712                     	xdef	_CmdDeal
1713                     	xdef	_Check_I2c_Data
1714                     	xdef	_SaveSysId
1715                     	xdef	_ReadSysId
1716                     	xdef	_SystemStatus
1717                     	xdef	_Systemid
1718                     	xdef	_NewI2cCmd
1719                     	xdef	_CmdTime
1720                     	xdef	_CmdPosition
1721                     	xdef	_AdcSum
1722                     	xdef	_AdcValue
1723                     	xdef	_AdcBufCnt
1724                     	xdef	_ADC_BUF
1725                     	xref.b	_UartRxI2cAddrFlag
1726                     	xref.b	_UartRxI2cAddr
1727                     	xref.b	_IIC_BUF
1728                     	xref.b	_IIC_RECV_ONE_FRAME_OK
1729                     	xref.b	_SLAVE_ADDRESS
1730                     	xref.b	_Sys_1000ms_Flag
1731                     	xref.b	_Sys_500ms_Flag
1732                     	xref.b	_Sys_200ms_Flag
1733                     	xref.b	_Sys_100ms_Flag
1734                     	xref.b	_Sys_50ms_Flag
1735                     	xref.b	_Sys_20ms_Flag
1736                     	xref.b	_Sys_10ms_Flag
1737                     	xref	_ReadMultiBlockByte
1738                     	xref	_WriteMultiBlockByte
1739                     	xref	_UART1_printf
1740                     	xref	_Uart1_Init
1741                     	xref	_GetMotoADValue
1742                     	xref	_ADC_Init
1743                     	xref	_Init_I2C
1744                     	xref	_Tim1_Init
1745                     	xref	_LED_Reverse
1746                     	xref	_SetLedOFF
1747                     	xref	_LED_Init
1748                     	xref	_Set_Pwm_Channel3
1749                     	xref	_Pwm_Init
1750                     	xref	_GPIO_WriteLow
1751                     	xref	_GPIO_WriteHigh
1752                     	xref	_GPIO_Init
1753                     	xref	_FLASH_WaitForLastOperation
1754                     	xref	_FLASH_EraseBlock
1755                     	xref	_FLASH_SetProgrammingTime
1756                     	xref	_CLK_HSIPrescalerConfig
1757                     	xref	_CLK_HSICmd
1758                     .const:	section	.text
1759  0000               L763:
1760  0000 526563656976  	dc.b	"Receive a error cm"
1761  0012 643a25640d    	dc.b	"d:%d",13
1762  0017 0a00          	dc.b	10,0
1763  0019               L563:
1764  0019 526563656976  	dc.b	"Receive stop Cmd",13
1765  002a 0a00          	dc.b	10,0
1766  002c               L363:
1767  002c 54686520436d  	dc.b	"The CmdPosition is"
1768  003e 3a25642c5468  	dc.b	":%d,The CmdTime is"
1769  0050 3a25640d      	dc.b	":%d",13
1770  0054 0a00          	dc.b	10,0
1771  0056               L163:
1772  0056 526563656976  	dc.b	"Receive a Position"
1773  0068 204368616e67  	dc.b	" Change Cmd",13
1774  0074 0a00          	dc.b	10,0
1775  0076               L103:
1776  0076 526563656976  	dc.b	"Receive a null cmd"
1777  0088 202830290d    	dc.b	" (0)",13
1778  008d 0a00          	dc.b	10,0
1779  008f               L342:
1780  008f 536176652053  	dc.b	"Save Sysid ok,the "
1781  00a1 69642069733a  	dc.b	"id is:0x%02h",0
1782  00ae               L161:
1783  00ae 546865204164  	dc.b	"The Adc Is:%d",13
1784  00bc 0a00          	dc.b	10,0
1785  00be               L77:
1786  00be 53797374656d  	dc.b	"System is on....!!"
1787  00d0 210d          	dc.b	"!",13
1788  00d2 0a00          	dc.b	10,0
1789  00d4               L57:
1790  00d4 546865205379  	dc.b	"The Systemid is er"
1791  00e6 726f722e2e2e  	dc.b	"ror....",13
1792  00ee 0a00          	dc.b	10,0
1793  00f0               L37:
1794  00f0 546865205379  	dc.b	"The System is for "
1795  0102 75702d646f77  	dc.b	"up-down-head",13
1796  010f 0a00          	dc.b	10,0
1797  0111               L17:
1798  0111 546865205379  	dc.b	"The System is for "
1799  0123 4c6566742d52  	dc.b	"Left-Right-head",13
1800  0133 0a00          	dc.b	10,0
1801  0135               L76:
1802  0135 546865205379  	dc.b	"The System is for "
1803  0147 526967687468  	dc.b	"Righthand",13
1804  0151 0a00          	dc.b	10,0
1805  0153               L56:
1806  0153 546865205379  	dc.b	"The System is for "
1807  0165 4c6566746861  	dc.b	"Lefthand",13
1808  016e 0a00          	dc.b	10,0
1809  0170               L75:
1810  0170 526561642053  	dc.b	"Read Sysid is:%d",13
1811  0181 0a00          	dc.b	10,0
1812                     	xref.b	c_x
1832                     	xref	c_fcmp
1833                     	xref	c_ctof
1834                     	xref	c_ftoi
1835                     	xref	c_ltor
1836                     	xref	c_rtol
1837                     	xref	c_uitof
1838                     	end
