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
  42  0038               _Moto_nFAULT_Error:
  43  0038 01            	dc.b	1
  44  0039               _Moto_VISEN_Error:
  45  0039 01            	dc.b	1
  76                     ; 104 void CLK_Configuration(void)
  76                     ; 105 {
  78                     .text:	section	.text,new
  79  0000               _CLK_Configuration:
  83                     ; 106    CLK_HSICmd(ENABLE);/* Set HSIEN bit */
  85  0000 a601          	ld	a,#1
  86  0002 cd0000        	call	_CLK_HSICmd
  88                     ; 109   CLK_HSIPrescalerConfig(CLK_PRESCALER_HSIDIV1); /* Fmaster = 16MHz */
  90  0005 4f            	clr	a
  92                     ; 111 }
  95  0006 cc0000        	jp	_CLK_HSIPrescalerConfig
 176                     ; 114 void main(void)
 176                     ; 115 {
 177                     .text:	section	.text,new
 178  0000               _main:
 180  0000 89            	pushw	x
 181       00000002      OFST:	set	2
 184                     ; 117 	unsigned char pwm=0,i=0;
 186  0001 0f01          	clr	(OFST-1,sp)
 189                     ; 119   CLK_Configuration();
 191  0003 cd0000        	call	_CLK_Configuration
 193                     ; 122 	Systemid=0;
 195  0006 5f            	clrw	x
 196  0007 bf34          	ldw	_Systemid,x
 197                     ; 123 	SystemStatus=0;//system init ok
 199  0009 bf36          	ldw	_SystemStatus,x
 200                     ; 124 	Moto_nFAULT_Error=1;//=0异常
 202  000b 35010038      	mov	_Moto_nFAULT_Error,#1
 203                     ; 125   Moto_VISEN_Error=1;//=0异常	
 205  000f 35010039      	mov	_Moto_VISEN_Error,#1
 206                     ; 127 	NewI2cCmd=1;//开机执行一次命令，回到中间位置
 208  0013 35010033      	mov	_NewI2cCmd,#1
 209                     ; 128 	CmdPosition=180;//中间位置(0-360)
 211  0017 ae00b4        	ldw	x,#180
 212  001a bf2f          	ldw	_CmdPosition,x
 213                     ; 129 	CmdTime=1000;//默认1000ms，暂时没有使用
 215  001c ae03e8        	ldw	x,#1000
 216  001f bf31          	ldw	_CmdTime,x
 217                     ; 131 	Moto_Init();//PC5->M_PHA PC3->M_nSLEEP PC4->nFAULT PC6->VISEN
 219  0021 cd0000        	call	_Moto_Init
 221                     ; 132 	LED_Init();//led3->PC3
 223  0024 cd0000        	call	_LED_Init
 225                     ; 133 	Tim1_Init();	
 227  0027 cd0000        	call	_Tim1_Init
 229                     ; 134 	Pwm_Init(); //channel3->PA3
 231  002a cd0000        	call	_Pwm_Init
 233                     ; 135 	ADC_Init();// ADC1 Channel4 PD3
 235  002d cd0000        	call	_ADC_Init
 237                     ; 136 	Uart1_Init();//PD5->Uart1 Tx   PD6->Uart1 Rx
 239  0030 cd0000        	call	_Uart1_Init
 241                     ; 137 	SetLedOFF(); /* 让所有灯灭 */
 243  0033 cd0000        	call	_SetLedOFF
 245                     ; 145 	Systemid=0x52;//righthand
 247  0036 ae0052        	ldw	x,#82
 248  0039 bf34          	ldw	_Systemid,x
 249                     ; 149 	UART1_printf("Read Sysid is:%d\r\n",Systemid);//for 16bits printf
 251  003b be34          	ldw	x,_Systemid
 252  003d 89            	pushw	x
 253  003e ae0287        	ldw	x,#L75
 254  0041 cd0000        	call	_UART1_printf
 256  0044 85            	popw	x
 257                     ; 151   switch (Systemid)
 259  0045 be34          	ldw	x,_Systemid
 261                     ; 173 		break;
 262  0047 1d0051        	subw	x,#81
 263  004a 271a          	jreq	L32
 264  004c 5a            	decw	x
 265  004d 2723          	jreq	L52
 266  004f 5a            	decw	x
 267  0050 272c          	jreq	L72
 268  0052 5a            	decw	x
 269  0053 2735          	jreq	L13
 270                     ; 169 		default :
 270                     ; 170 		UART1_printf("The Systemid is error....\r\n");
 272  0055 ae01eb        	ldw	x,#L57
 273  0058 cd0000        	call	_UART1_printf
 275                     ; 171 		SystemStatus=1;//system is error
 277  005b ae0001        	ldw	x,#1
 278  005e bf36          	ldw	_SystemStatus,x
 279                     ; 172 		SLAVE_ADDRESS=0x50;//default addr
 281  0060 35500000      	mov	_SLAVE_ADDRESS,#80
 282                     ; 173 		break;
 284  0064 202e          	jra	L36
 285  0066               L32:
 286                     ; 153 		case 0x51:
 286                     ; 154 		UART1_printf("The System is for Lefthand\r\n");
 288  0066 ae026a        	ldw	x,#L56
 289  0069 cd0000        	call	_UART1_printf
 291                     ; 155 		SLAVE_ADDRESS=0x51;
 293  006c 35510000      	mov	_SLAVE_ADDRESS,#81
 294                     ; 156 		break;
 296  0070 2022          	jra	L36
 297  0072               L52:
 298                     ; 157 		case 0x52:
 298                     ; 158 		UART1_printf("The System is for Righthand\r\n");
 300  0072 ae024c        	ldw	x,#L76
 301  0075 cd0000        	call	_UART1_printf
 303                     ; 159 		SLAVE_ADDRESS=0x52;
 305  0078 35520000      	mov	_SLAVE_ADDRESS,#82
 306                     ; 160 		break;
 308  007c 2016          	jra	L36
 309  007e               L72:
 310                     ; 161 		case 0x53:
 310                     ; 162 		UART1_printf("The System is for Left-Right-head\r\n");
 312  007e ae0228        	ldw	x,#L17
 313  0081 cd0000        	call	_UART1_printf
 315                     ; 163 		SLAVE_ADDRESS=0x53;
 317  0084 35530000      	mov	_SLAVE_ADDRESS,#83
 318                     ; 164 		break;
 320  0088 200a          	jra	L36
 321  008a               L13:
 322                     ; 165 		case 0x54:
 322                     ; 166 		UART1_printf("The System is for up-down-head\r\n");
 324  008a ae0207        	ldw	x,#L37
 325  008d cd0000        	call	_UART1_printf
 327                     ; 167 		SLAVE_ADDRESS=0x54;
 329  0090 35540000      	mov	_SLAVE_ADDRESS,#84
 330                     ; 168 		break;		
 332  0094               L36:
 333                     ; 175 	Init_I2C();//PB4-SCL PB5->SDA
 335  0094 cd0000        	call	_Init_I2C
 337                     ; 177 	UART1_printf("System is on....!!!\r\n");
 339  0097 ae01d5        	ldw	x,#L77
 340  009a cd0000        	call	_UART1_printf
 342                     ; 178 	enableInterrupts(); 
 345  009d 9a            	rim	
 347  009e               L101:
 348                     ; 189 		if(Sys_10ms_Flag==1)
 350  009e b600          	ld	a,_Sys_10ms_Flag
 351  00a0 4a            	dec	a
 352  00a1 2620          	jrne	L501
 353                     ; 191 			Sys_10ms_Flag=0;
 355  00a3 b700          	ld	_Sys_10ms_Flag,a
 356                     ; 193 			if(SystemStatus==0)
 358  00a5 be36          	ldw	x,_SystemStatus
 359  00a7 261a          	jrne	L501
 360                     ; 195 				Check_I2c_Data();
 362  00a9 cd0000        	call	_Check_I2c_Data
 364                     ; 196 				MotoStatusCheck();
 366  00ac cd0000        	call	_MotoStatusCheck
 368                     ; 197 				if(Moto_nFAULT_Error==1&&Moto_VISEN_Error==1)//=1 ok
 370  00af b638          	ld	a,_Moto_nFAULT_Error
 371  00b1 4a            	dec	a
 372  00b2 260a          	jrne	L111
 374  00b4 b639          	ld	a,_Moto_VISEN_Error
 375  00b6 4a            	dec	a
 376  00b7 2605          	jrne	L111
 377                     ; 199 					CmdDeal();
 379  00b9 cd0000        	call	_CmdDeal
 382  00bc 2005          	jra	L501
 383  00be               L111:
 384                     ; 203 					NewI2cCmd=0;
 386  00be 3f33          	clr	_NewI2cCmd
 387                     ; 204 					SetMotoStop();
 389  00c0 cd0000        	call	_SetMotoStop
 391  00c3               L501:
 392                     ; 208 		if(Sys_20ms_Flag==1)
 394  00c3 b600          	ld	a,_Sys_20ms_Flag
 395  00c5 4a            	dec	a
 396  00c6 2640          	jrne	L511
 397                     ; 210 			Sys_20ms_Flag=0;
 399  00c8 b700          	ld	_Sys_20ms_Flag,a
 400                     ; 211 			if(SystemStatus==0)
 402  00ca be36          	ldw	x,_SystemStatus
 403  00cc 263a          	jrne	L511
 404                     ; 213 				AdcBufCnt++;
 406  00ce 3c28          	inc	_AdcBufCnt
 407                     ; 214 				if(AdcBufCnt>=ADC_FILTER_LENGTH)
 409  00d0 b628          	ld	a,_AdcBufCnt
 410  00d2 a114          	cp	a,#20
 411  00d4 2502          	jrult	L121
 412                     ; 215 				AdcBufCnt=0;
 414  00d6 3f28          	clr	_AdcBufCnt
 415  00d8               L121:
 416                     ; 217 				ADC_BUF[AdcBufCnt]=GetMotoADValue();
 418  00d8 cd0000        	call	_GetMotoADValue
 420  00db b628          	ld	a,_AdcBufCnt
 421  00dd 905f          	clrw	y
 422  00df 9097          	ld	yl,a
 423  00e1 9058          	sllw	y
 424  00e3 90ef00        	ldw	(_ADC_BUF,y),x
 425                     ; 219 				AdcSum=0;
 427  00e6 5f            	clrw	x
 428  00e7 bf2b          	ldw	_AdcSum,x
 429                     ; 220 				for(i=0;i<ADC_FILTER_LENGTH;i++)
 431  00e9 4f            	clr	a
 432  00ea 6b02          	ld	(OFST+0,sp),a
 433  00ec               L321:
 434                     ; 221 				AdcSum+=ADC_BUF[i];
 436  00ec 5f            	clrw	x
 437  00ed 97            	ld	xl,a
 438  00ee 58            	sllw	x
 439  00ef ee00          	ldw	x,(_ADC_BUF,x)
 440  00f1 72bb002b      	addw	x,_AdcSum
 441  00f5 bf2b          	ldw	_AdcSum,x
 442                     ; 220 				for(i=0;i<ADC_FILTER_LENGTH;i++)
 444  00f7 0c02          	inc	(OFST+0,sp)
 447  00f9 7b02          	ld	a,(OFST+0,sp)
 448  00fb a114          	cp	a,#20
 449  00fd 25ed          	jrult	L321
 450                     ; 223 				AdcValue=AdcSum/ADC_FILTER_LENGTH;
 452                     ; 226 				AdcValue=ADC_BUF[AdcBufCnt];
 454  00ff b628          	ld	a,_AdcBufCnt
 455  0101 5f            	clrw	x
 456  0102 97            	ld	xl,a
 457  0103 58            	sllw	x
 458  0104 ee00          	ldw	x,(_ADC_BUF,x)
 459  0106 bf29          	ldw	_AdcValue,x
 461  0108               L511:
 462                     ; 234 		if(Sys_50ms_Flag==1)
 464  0108 b600          	ld	a,_Sys_50ms_Flag
 465  010a 4a            	dec	a
 466  010b 2609          	jrne	L331
 467                     ; 236 			Sys_50ms_Flag=0;
 469  010d b700          	ld	_Sys_50ms_Flag,a
 470                     ; 238 			if(SystemStatus==0)
 472  010f be36          	ldw	x,_SystemStatus
 473  0111 2603          	jrne	L331
 474                     ; 240 				Check_I2c_Data();
 476  0113 cd0000        	call	_Check_I2c_Data
 479  0116               L331:
 480                     ; 248 		if(Sys_100ms_Flag==1)
 482  0116 b600          	ld	a,_Sys_100ms_Flag
 483  0118 4a            	dec	a
 484  0119 2604          	jrne	L141
 485                     ; 250 			Sys_100ms_Flag=0;
 487  011b b700          	ld	_Sys_100ms_Flag,a
 488                     ; 252 			if(SystemStatus==0)
 490  011d be36          	ldw	x,_SystemStatus
 492  011f               L141:
 493                     ; 262 		if(Sys_200ms_Flag==1)
 495  011f b600          	ld	a,_Sys_200ms_Flag
 496  0121 4a            	dec	a
 497  0122 260b          	jrne	L741
 498                     ; 264 			Sys_200ms_Flag=0;
 500  0124 b700          	ld	_Sys_200ms_Flag,a
 501                     ; 266 			if(SystemStatus==0)
 503  0126 be36          	ldw	x,_SystemStatus
 504  0128 2705          	jreq	L741
 506                     ; 274 				LED_Reverse(LED_3);
 508  012a a680          	ld	a,#128
 509  012c cd0000        	call	_LED_Reverse
 511  012f               L741:
 512                     ; 278 		if(Sys_500ms_Flag==1)
 514  012f b600          	ld	a,_Sys_500ms_Flag
 515  0131 4a            	dec	a
 516  0132 2619          	jrne	L551
 517                     ; 280 			Sys_500ms_Flag=0;
 519  0134 b700          	ld	_Sys_500ms_Flag,a
 520                     ; 282 			if(SystemStatus==0)
 522  0136 be36          	ldw	x,_SystemStatus
 523  0138 2613          	jrne	L551
 524                     ; 284 				if(Moto_nFAULT_Error==0||Moto_VISEN_Error==0)//=1 ok
 526  013a 3d38          	tnz	_Moto_nFAULT_Error
 527  013c 2704          	jreq	L361
 529  013e 3d39          	tnz	_Moto_VISEN_Error
 530  0140 260b          	jrne	L551
 531  0142               L361:
 532                     ; 286 					LED_Reverse(LED_3);
 534  0142 a680          	ld	a,#128
 535  0144 cd0000        	call	_LED_Reverse
 537                     ; 287 					UART1_SendString("Motor Driver error....\r\n");
 539  0147 ae01bc        	ldw	x,#L561
 540  014a cd0000        	call	_UART1_SendString
 542  014d               L551:
 543                     ; 296 		if(Sys_1000ms_Flag==1)
 545  014d b600          	ld	a,_Sys_1000ms_Flag
 546  014f 4a            	dec	a
 547  0150 2703cc009e    	jrne	L101
 548                     ; 298 			Sys_1000ms_Flag=0;
 550  0155 b700          	ld	_Sys_1000ms_Flag,a
 551                     ; 300 			if(SystemStatus==0)
 553  0157 be36          	ldw	x,_SystemStatus
 554  0159 26f7          	jrne	L101
 555                     ; 302 				LED_Reverse(LED_3);
 557  015b a680          	ld	a,#128
 558  015d cd0000        	call	_LED_Reverse
 560                     ; 303 				UART1_printf("The Adc Is:%d\r\n",AdcValue);
 562  0160 be29          	ldw	x,_AdcValue
 563  0162 89            	pushw	x
 564  0163 ae01ac        	ldw	x,#L571
 565  0166 cd0000        	call	_UART1_printf
 567  0169 85            	popw	x
 568                     ; 304 				AdcPosition=(float)AdcValue/2.844;
 570  016a be29          	ldw	x,_AdcValue
 571  016c cd0000        	call	c_uitof
 573  016f ae01a8        	ldw	x,#L302
 574  0172 cd0000        	call	c_fdiv
 576  0175 cd0000        	call	c_ftoi
 578  0178 bf2d          	ldw	_AdcPosition,x
 579                     ; 305 				UART1_printf("The Position Is:%d\r\n",AdcPosition);
 581  017a 89            	pushw	x
 582  017b ae0193        	ldw	x,#L702
 583  017e cd0000        	call	_UART1_printf
 585  0181 85            	popw	x
 587  0182 cc009e        	jra	L101
 619                     ; 337 void CheckUartRxI2cAddr(void)
 619                     ; 338 {
 620                     .text:	section	.text,new
 621  0000               _CheckUartRxI2cAddr:
 625                     ; 339 	if(UartRxI2cAddrFlag==1)
 627  0000 b600          	ld	a,_UartRxI2cAddrFlag
 628  0002 4a            	dec	a
 629  0003 266d          	jrne	L532
 630                     ; 341 		UartRxI2cAddrFlag=0;
 632  0005 b700          	ld	_UartRxI2cAddrFlag,a
 633                     ; 342 		SLAVE_ADDRESS=UartRxI2cAddr;
 635  0007 450000        	mov	_SLAVE_ADDRESS,_UartRxI2cAddr
 636                     ; 343 		SaveSysId(SLAVE_ADDRESS);
 638  000a b600          	ld	a,_SLAVE_ADDRESS
 639  000c cd0000        	call	_SaveSysId
 641                     ; 344 		Systemid=ReadSysId();
 643  000f cd0000        	call	_ReadSysId
 645  0012 5f            	clrw	x
 646  0013 97            	ld	xl,a
 647  0014 bf34          	ldw	_Systemid,x
 648                     ; 345 		UART1_printf("Read Sysid is:%d\r\n",Systemid);//for 16bits printf
 650  0016 be34          	ldw	x,_Systemid
 651  0018 89            	pushw	x
 652  0019 ae0287        	ldw	x,#L75
 653  001c cd0000        	call	_UART1_printf
 655  001f 85            	popw	x
 656                     ; 347 		switch (Systemid)
 658  0020 be34          	ldw	x,_Systemid
 660                     ; 369 			break;
 661  0022 1d0051        	subw	x,#81
 662  0025 271a          	jreq	L312
 663  0027 5a            	decw	x
 664  0028 2723          	jreq	L512
 665  002a 5a            	decw	x
 666  002b 272c          	jreq	L712
 667  002d 5a            	decw	x
 668  002e 2735          	jreq	L122
 669                     ; 365 			default :
 669                     ; 366 			UART1_printf("The Systemid is error....\r\n");
 671  0030 ae01eb        	ldw	x,#L57
 672  0033 cd0000        	call	_UART1_printf
 674                     ; 367 			SystemStatus=1;//system is error
 676  0036 ae0001        	ldw	x,#1
 677  0039 bf36          	ldw	_SystemStatus,x
 678                     ; 368 			SLAVE_ADDRESS=0x50;//default addr
 680  003b 35500000      	mov	_SLAVE_ADDRESS,#80
 681                     ; 369 			break;
 683  003f 202e          	jra	L142
 684  0041               L312:
 685                     ; 349 			case 0x51:
 685                     ; 350 			UART1_printf("The System is for Lefthand\r\n");
 687  0041 ae026a        	ldw	x,#L56
 688  0044 cd0000        	call	_UART1_printf
 690                     ; 351 			SLAVE_ADDRESS=0x51;
 692  0047 35510000      	mov	_SLAVE_ADDRESS,#81
 693                     ; 352 			break;
 695  004b 2022          	jra	L142
 696  004d               L512:
 697                     ; 353 			case 0x52:
 697                     ; 354 			UART1_printf("The System is for Righthand\r\n");
 699  004d ae024c        	ldw	x,#L76
 700  0050 cd0000        	call	_UART1_printf
 702                     ; 355 			SLAVE_ADDRESS=0x52;
 704  0053 35520000      	mov	_SLAVE_ADDRESS,#82
 705                     ; 356 			break;
 707  0057 2016          	jra	L142
 708  0059               L712:
 709                     ; 357 			case 0x53:
 709                     ; 358 			UART1_printf("The System is for Left-Right-head\r\n");
 711  0059 ae0228        	ldw	x,#L17
 712  005c cd0000        	call	_UART1_printf
 714                     ; 359 			SLAVE_ADDRESS=0x53;
 716  005f 35530000      	mov	_SLAVE_ADDRESS,#83
 717                     ; 360 			break;
 719  0063 200a          	jra	L142
 720  0065               L122:
 721                     ; 361 			case 0x54:
 721                     ; 362 			UART1_printf("The System is for up-down-head\r\n");
 723  0065 ae0207        	ldw	x,#L37
 724  0068 cd0000        	call	_UART1_printf
 726                     ; 363 			SLAVE_ADDRESS=0x54;
 728  006b 35540000      	mov	_SLAVE_ADDRESS,#84
 729                     ; 364 			break;		
 731  006f               L142:
 732                     ; 371 		Init_I2C();//PB4-SCL PB5->SDA		
 734  006f cd0000        	call	_Init_I2C
 736  0072               L532:
 737                     ; 373 }
 740  0072 81            	ret	
 743                     	bsct
 744  003a               _ReadBuffer:
 745  003a 00            	dc.b	0
 746  003b 000000000000  	ds.b	63
 769                     ; 376 unsigned char ReadSysId(void)
 769                     ; 377 {
 770                     .text:	section	.text,new
 771  0000               _ReadSysId:
 775                     ; 379 	ReadMultiBlockByte(Block_0,1,ReadBuffer);
 777  0000 ae003a        	ldw	x,#_ReadBuffer
 778  0003 89            	pushw	x
 779  0004 ae0001        	ldw	x,#1
 780  0007 4f            	clr	a
 781  0008 95            	ld	xh,a
 782  0009 cd0000        	call	_ReadMultiBlockByte
 784  000c b63a          	ld	a,_ReadBuffer
 785  000e 85            	popw	x
 786                     ; 380 	return ReadBuffer[0];
 790  000f 81            	ret	
 831                     ; 382 unsigned char SaveSysId(unsigned char id)
 831                     ; 383 {
 832                     .text:	section	.text,new
 833  0000               _SaveSysId:
 835  0000 88            	push	a
 836       00000000      OFST:	set	0
 839                     ; 384 	ReadMultiBlockByte(Block_0,1,ReadBuffer);
 841  0001 ae003a        	ldw	x,#_ReadBuffer
 842  0004 89            	pushw	x
 843  0005 ae0001        	ldw	x,#1
 844  0008 4f            	clr	a
 845  0009 95            	ld	xh,a
 846  000a cd0000        	call	_ReadMultiBlockByte
 848  000d 85            	popw	x
 849                     ; 385 	ReadBuffer[0]=id;
 851  000e 7b01          	ld	a,(OFST+1,sp)
 852  0010 b73a          	ld	_ReadBuffer,a
 853                     ; 387 	FLASH_SetProgrammingTime(FLASH_PROGRAMTIME_STANDARD);
 855  0012 4f            	clr	a
 856  0013 cd0000        	call	_FLASH_SetProgrammingTime
 858                     ; 389 	FLASH_EraseBlock(Block_0, FLASH_MEMTYPE_DATA);/*往FLASH写数据前，要擦除对应的区域*/
 860  0016 4bf7          	push	#247
 861  0018 5f            	clrw	x
 862  0019 cd0000        	call	_FLASH_EraseBlock
 864  001c 84            	pop	a
 865                     ; 390 	FLASH_WaitForLastOperation(FLASH_MEMTYPE_DATA);
 867  001d a6f7          	ld	a,#247
 868  001f cd0000        	call	_FLASH_WaitForLastOperation
 870                     ; 392 	WriteMultiBlockByte(Block_0,FLASH_MEMTYPE_DATA,FLASH_PROGRAMMODE_STANDARD,ReadBuffer,1);
 872  0022 4b01          	push	#1
 873  0024 ae003a        	ldw	x,#_ReadBuffer
 874  0027 89            	pushw	x
 875  0028 4b00          	push	#0
 876  002a ae00f7        	ldw	x,#247
 877  002d 4f            	clr	a
 878  002e 95            	ld	xh,a
 879  002f cd0000        	call	_WriteMultiBlockByte
 881  0032 5b04          	addw	sp,#4
 882                     ; 395 	UART1_printf("Save Sysid ok,the id is:0x%02h",ReadBuffer[0]);
 884  0034 3b003a        	push	_ReadBuffer
 885  0037 ae0174        	ldw	x,#L172
 886  003a cd0000        	call	_UART1_printf
 888  003d 84            	pop	a
 889                     ; 397 }
 892  003e 84            	pop	a
 893  003f 81            	ret	
 934                     ; 398 void Check_I2c_Data(void)
 934                     ; 399 {
 935                     .text:	section	.text,new
 936  0000               _Check_I2c_Data:
 938  0000 88            	push	a
 939       00000001      OFST:	set	1
 942                     ; 400 	u8 i=0;
 944  0001 0f01          	clr	(OFST+0,sp)
 945                     ; 402 	if(IIC_RECV_ONE_FRAME_OK==1)
 947  0003 b600          	ld	a,_IIC_RECV_ONE_FRAME_OK
 948  0005 4a            	dec	a
 949  0006 2703cc00ff    	jrne	L123
 950                     ; 405 		IIC_RECV_ONE_FRAME_OK=0;
 952  000b b700          	ld	_IIC_RECV_ONE_FRAME_OK,a
 953                     ; 406 		NewI2cCmd=IIC_BUF[0];
 955  000d 450033        	mov	_NewI2cCmd,_IIC_BUF
 956                     ; 407 		switch (NewI2cCmd){
 958  0010 b633          	ld	a,_NewI2cCmd
 960                     ; 494 			break;
 961  0012 2718          	jreq	L372
 962  0014 4a            	dec	a
 963  0015 271b          	jreq	L572
 964  0017 4a            	dec	a
 965  0018 2603cc00f9    	jreq	L772
 966                     ; 492 			default:
 966                     ; 493 			UART1_printf("Receive a error cmd:%d\r\n",(unsigned int)(NewI2cCmd));
 968  001d b633          	ld	a,_NewI2cCmd
 969  001f 5f            	clrw	x
 970  0020 97            	ld	xl,a
 971  0021 89            	pushw	x
 972  0022 ae0048        	ldw	x,#L524
 973  0025 cd0000        	call	_UART1_printf
 975  0028 85            	popw	x
 976                     ; 494 			break;
 978  0029 cc00ff        	jra	L123
 979  002c               L372:
 980                     ; 408 			case 0x00:
 980                     ; 409 			UART1_printf("Receive a null cmd (0)\r\n");
 982  002c ae015b        	ldw	x,#L723
 984                     ; 410 			break;
 986  002f cc00fc        	jp	LC001
 987  0032               L572:
 988                     ; 411 			case 0x01:
 988                     ; 412 		
 988                     ; 413 			
 988                     ; 414 			if(IIC_BUF[1]==0x00)//shunshizhen
 990  0032 3d01          	tnz	_IIC_BUF+1
 991  0034 2611          	jrne	L133
 992                     ; 416 				if(IIC_BUF[2]<=180)
 994  0036 b602          	ld	a,_IIC_BUF+2
 995  0038 a1b5          	cp	a,#181
 996  003a 2424          	jruge	L533
 997                     ; 417 				CmdPosition=IIC_BUF[2]+180;
 999  003c b602          	ld	a,_IIC_BUF+2
1000  003e 5f            	clrw	x
1001  003f 97            	ld	xl,a
1002  0040 1c00b4        	addw	x,#180
1003  0043 bf2f          	ldw	_CmdPosition,x
1004  0045 2019          	jra	L533
1005  0047               L133:
1006                     ; 419 			else if(IIC_BUF[1]==0x01)//nishizhen
1008  0047 b601          	ld	a,_IIC_BUF+1
1009  0049 4a            	dec	a
1010  004a 2614          	jrne	L533
1011                     ; 421 				if(IIC_BUF[2]<=180)
1013  004c b602          	ld	a,_IIC_BUF+2
1014  004e a1b5          	cp	a,#181
1015  0050 240e          	jruge	L533
1016                     ; 422 				CmdPosition=180-IIC_BUF[2];
1018  0052 4f            	clr	a
1019  0053 97            	ld	xl,a
1020  0054 a6b4          	ld	a,#180
1021  0056 b002          	sub	a,_IIC_BUF+2
1022  0058 2401          	jrnc	L651
1023  005a 5a            	decw	x
1024  005b               L651:
1025  005b b730          	ld	_CmdPosition+1,a
1026  005d 9f            	ld	a,xl
1027  005e b72f          	ld	_CmdPosition,a
1028  0060               L533:
1029                     ; 428 			if(CmdPosition>360)
1031  0060 be2f          	ldw	x,_CmdPosition
1032  0062 a30169        	cpw	x,#361
1033  0065 2505          	jrult	L543
1034                     ; 429 			CmdPosition=360;
1036  0067 ae0168        	ldw	x,#360
1037  006a bf2f          	ldw	_CmdPosition,x
1038  006c               L543:
1039                     ; 430 			CmdTime=IIC_BUF[3]*256+IIC_BUF[4];
1041  006c b603          	ld	a,_IIC_BUF+3
1042  006e 5f            	clrw	x
1043  006f 97            	ld	xl,a
1044  0070 4f            	clr	a
1045  0071 bb04          	add	a,_IIC_BUF+4
1046  0073 2401          	jrnc	L061
1047  0075 5c            	incw	x
1048  0076               L061:
1049  0076 b732          	ld	_CmdTime+1,a
1050  0078 9f            	ld	a,xl
1051  0079 b731          	ld	_CmdTime,a
1052                     ; 431 			UART1_printf("Receive a Position Change Cmd\r\n");
1054  007b ae013b        	ldw	x,#L743
1055  007e cd0000        	call	_UART1_printf
1057                     ; 432 			UART1_printf("The CmdPosition is:%d,The CmdTime is:%d\r\n",CmdPosition,CmdTime);				
1059  0081 be31          	ldw	x,_CmdTime
1060  0083 89            	pushw	x
1061  0084 be2f          	ldw	x,_CmdPosition
1062  0086 89            	pushw	x
1063  0087 ae0111        	ldw	x,#L153
1064  008a cd0000        	call	_UART1_printf
1066  008d 5b04          	addw	sp,#4
1067                     ; 445 			if(Systemid==0x51){
1069  008f be34          	ldw	x,_Systemid
1070  0091 a30051        	cpw	x,#81
1071  0094 2611          	jrne	L353
1072                     ; 446 				if(CmdPosition<(180-50)||CmdPosition>(180+110))
1074  0096 be2f          	ldw	x,_CmdPosition
1075  0098 a30082        	cpw	x,#130
1076  009b 2505          	jrult	L753
1078  009d a30123        	cpw	x,#291
1079  00a0 255d          	jrult	L123
1080  00a2               L753:
1081                     ; 448 					UART1_printf("Left Hand Cmd erro out of(70-230)\r\n");
1083  00a2 ae00ed        	ldw	x,#L163
1085                     ; 449 					CmdPosition=180;
1086                     ; 450 					NewI2cCmd=0;
1087  00a5 2046          	jp	LC003
1088  00a7               L353:
1089                     ; 456 			else if(Systemid==0x52){
1091  00a7 be34          	ldw	x,_Systemid
1092  00a9 a30052        	cpw	x,#82
1093  00ac 2611          	jrne	L563
1094                     ; 457 				if(CmdPosition<(180-110)||CmdPosition>(180+50))
1096  00ae be2f          	ldw	x,_CmdPosition
1097  00b0 a30046        	cpw	x,#70
1098  00b3 2505          	jrult	L173
1100  00b5 a300e7        	cpw	x,#231
1101  00b8 2545          	jrult	L123
1102  00ba               L173:
1103                     ; 459 					UART1_printf("Right Hand Cmd erro out of(130-290)\r\n");
1105  00ba ae00c7        	ldw	x,#L373
1107                     ; 460 					CmdPosition=180;NewI2cCmd=0;
1109  00bd 202e          	jp	LC003
1110  00bf               L563:
1111                     ; 466 			else if(Systemid==0x53){
1113  00bf be34          	ldw	x,_Systemid
1114  00c1 a30053        	cpw	x,#83
1115  00c4 2611          	jrne	L773
1116                     ; 467 				if(CmdPosition<(180-80)||CmdPosition>(180+80))
1118  00c6 be2f          	ldw	x,_CmdPosition
1119  00c8 a30064        	cpw	x,#100
1120  00cb 2505          	jrult	L304
1122  00cd a30105        	cpw	x,#261
1123  00d0 252d          	jrult	L123
1124  00d2               L304:
1125                     ; 469 					UART1_printf("left-right-head Cmd erro out of(100-260)\r\n");
1127  00d2 ae009c        	ldw	x,#L504
1129                     ; 470 					CmdPosition=180;NewI2cCmd=0;
1131  00d5 2016          	jp	LC003
1132  00d7               L773:
1133                     ; 476 			else if(Systemid==0x54){
1135  00d7 be34          	ldw	x,_Systemid
1136  00d9 a30054        	cpw	x,#84
1137  00dc 2612          	jrne	LC002
1138                     ; 477 				if(CmdPosition<(180-15)||CmdPosition>(180+25))
1140  00de be2f          	ldw	x,_CmdPosition
1141  00e0 a300a5        	cpw	x,#165
1142  00e3 2505          	jrult	L514
1144  00e5 a300ce        	cpw	x,#206
1145  00e8 2515          	jrult	L123
1146  00ea               L514:
1147                     ; 479 					UART1_printf("up-down-head Cmd erro out of(165-190)\r\n");
1149  00ea ae0074        	ldw	x,#L714
1150  00ed               LC003:
1151  00ed cd0000        	call	_UART1_printf
1153                     ; 480 					CmdPosition=180;NewI2cCmd=0;
1157  00f0               LC002:
1162  00f0 ae00b4        	ldw	x,#180
1163  00f3 bf2f          	ldw	_CmdPosition,x
1168  00f5 3f33          	clr	_NewI2cCmd
1169  00f7 2006          	jra	L123
1170                     ; 485 				CmdPosition=180;NewI2cCmd=0;
1172  00f9               L772:
1173                     ; 489 			case 0x02:
1173                     ; 490 			UART1_printf("Receive stop Cmd\r\n");
1175  00f9 ae0061        	ldw	x,#L324
1176  00fc               LC001:
1177  00fc cd0000        	call	_UART1_printf
1179                     ; 491 			break;
1181  00ff               L123:
1182                     ; 497 }
1185  00ff 84            	pop	a
1186  0100 81            	ret	
1211                     ; 499 void Moto_Init(void)
1211                     ; 500 {
1212                     .text:	section	.text,new
1213  0000               _Moto_Init:
1217                     ; 503 	GPIO_Init(GPIOC,GPIO_PIN_3|GPIO_PIN_5, GPIO_MODE_OUT_PP_HIGH_FAST );
1219  0000 4bf0          	push	#240
1220  0002 4b28          	push	#40
1221  0004 ae500a        	ldw	x,#20490
1222  0007 cd0000        	call	_GPIO_Init
1224  000a 85            	popw	x
1225                     ; 507   GPIO_Init(GPIOC,GPIO_PIN_4|GPIO_PIN_6, GPIO_MODE_IN_PU_NO_IT );	
1227  000b 4b40          	push	#64
1228  000d 4b50          	push	#80
1229  000f ae500a        	ldw	x,#20490
1230  0012 cd0000        	call	_GPIO_Init
1232  0015 85            	popw	x
1233                     ; 509 	GPIO_WriteHigh(GPIOC, GPIO_PIN_5);//init to high
1235  0016 4b20          	push	#32
1236  0018 ae500a        	ldw	x,#20490
1237  001b cd0000        	call	_GPIO_WriteHigh
1239  001e 84            	pop	a
1240                     ; 510 	GPIO_WriteHigh(GPIOC, GPIO_PIN_3);//low->sleep, init to high not sleep
1242  001f 4b08          	push	#8
1243  0021 ae500a        	ldw	x,#20490
1244  0024 cd0000        	call	_GPIO_WriteHigh
1246  0027 84            	pop	a
1247                     ; 512 }
1250  0028 81            	ret	
1253                     	bsct
1254  007a               L734_nFAULT_Cnt:
1255  007a 00            	dc.b	0
1256  007b               L144_Old_nFAULT:
1257  007b 01            	dc.b	1
1258  007c               L344_VISEN_Cnt:
1259  007c 00            	dc.b	0
1260  007d               L544_Old_VISEN:
1261  007d 01            	dc.b	1
1342                     ; 519 void MotoStatusCheck(void)
1342                     ; 520 {
1343                     .text:	section	.text,new
1344  0000               _MotoStatusCheck:
1346  0000 89            	pushw	x
1347       00000002      OFST:	set	2
1350                     ; 525 	unsigned char New_nFAULT=0,New_VISEN=0;
1354                     ; 527 	if(RESET==GPIO_ReadInputPin(GPIOC, GPIO_PIN_4))
1356  0001 4b10          	push	#16
1357  0003 ae500a        	ldw	x,#20490
1358  0006 cd0000        	call	_GPIO_ReadInputPin
1360  0009 5b01          	addw	sp,#1
1361  000b 4d            	tnz	a
1362                     ; 528 	New_nFAULT=0;//PC4->nFAULT 
1364  000c 2702          	jreq	L315
1365                     ; 530 	New_nFAULT=1;//PC4->nFAULT 
1367  000e a601          	ld	a,#1
1368  0010               L315:
1370  0010 6b01          	ld	(OFST-1,sp),a
1371                     ; 532 	if(RESET==GPIO_ReadInputPin(GPIOC, GPIO_PIN_6))
1373  0012 4b40          	push	#64
1374  0014 ae500a        	ldw	x,#20490
1375  0017 cd0000        	call	_GPIO_ReadInputPin
1377  001a 5b01          	addw	sp,#1
1378  001c 4d            	tnz	a
1379                     ; 533 	New_VISEN=0;//PC6->VISEN 
1381  001d 2702          	jreq	L715
1382                     ; 535 	New_VISEN=1;//PC6->VISEN 
1384  001f a601          	ld	a,#1
1385  0021               L715:
1387  0021 6b02          	ld	(OFST+0,sp),a
1388                     ; 537 	if(New_nFAULT!=Old_nFAULT)
1390  0023 7b01          	ld	a,(OFST-1,sp)
1391  0025 b17b          	cp	a,L144_Old_nFAULT
1392  0027 2706          	jreq	L125
1393                     ; 539 		Old_nFAULT=New_nFAULT;
1395  0029 b77b          	ld	L144_Old_nFAULT,a
1396                     ; 540 		nFAULT_Cnt=0;
1398  002b 3f7a          	clr	L734_nFAULT_Cnt
1400  002d 201d          	jra	L325
1401  002f               L125:
1402                     ; 543 		if(nFAULT_Cnt<10)//10*20=200ms 
1404  002f b67a          	ld	a,L734_nFAULT_Cnt
1405  0031 a10a          	cp	a,#10
1406  0033 2404          	jruge	L525
1407                     ; 545 			nFAULT_Cnt++;
1409  0035 3c7a          	inc	L734_nFAULT_Cnt
1411  0037 2013          	jra	L325
1412  0039               L525:
1413                     ; 548 			if(Moto_nFAULT_Error!=Old_nFAULT){
1415  0039 b638          	ld	a,_Moto_nFAULT_Error
1416  003b b17b          	cp	a,L144_Old_nFAULT
1417  003d 270d          	jreq	L325
1418                     ; 549 				Moto_nFAULT_Error=Old_nFAULT;
1420  003f 457b38        	mov	_Moto_nFAULT_Error,L144_Old_nFAULT
1421                     ; 550 				UART1_printf("Motor Driver nFAULT Change,nFAULT:%d",Moto_nFAULT_Error);
1423  0042 ae0023        	ldw	x,#L335
1424  0045 3b0038        	push	_Moto_nFAULT_Error
1425  0048 cd0000        	call	_UART1_printf
1427  004b 84            	pop	a
1428  004c               L325:
1429                     ; 555 	if(New_VISEN!=Old_VISEN)
1431  004c 7b02          	ld	a,(OFST+0,sp)
1432  004e b17d          	cp	a,L544_Old_VISEN
1433  0050 2706          	jreq	L535
1434                     ; 557 		Old_VISEN=New_VISEN;
1436  0052 b77d          	ld	L544_Old_VISEN,a
1437                     ; 558 		VISEN_Cnt=0;
1439  0054 3f7c          	clr	L344_VISEN_Cnt
1441  0056 201d          	jra	L735
1442  0058               L535:
1443                     ; 561 		if(VISEN_Cnt<=10)//10*20=200ms 
1445  0058 b67c          	ld	a,L344_VISEN_Cnt
1446  005a a10b          	cp	a,#11
1447  005c 2404          	jruge	L145
1448                     ; 563 			VISEN_Cnt++;
1450  005e 3c7c          	inc	L344_VISEN_Cnt
1452  0060 2013          	jra	L735
1453  0062               L145:
1454                     ; 566 			if(Moto_VISEN_Error!=Old_VISEN){
1456  0062 b639          	ld	a,_Moto_VISEN_Error
1457  0064 b17d          	cp	a,L544_Old_VISEN
1458  0066 270d          	jreq	L735
1459                     ; 567 				Moto_VISEN_Error=Old_VISEN;
1461  0068 457d39        	mov	_Moto_VISEN_Error,L544_Old_VISEN
1462                     ; 568 				UART1_printf("Motor Driver VISEN Change,VISEN:%d",Moto_VISEN_Error);
1464  006b ae0000        	ldw	x,#L745
1465  006e 3b0039        	push	_Moto_VISEN_Error
1466  0071 cd0000        	call	_UART1_printf
1468  0074 84            	pop	a
1469  0075               L735:
1470                     ; 572 }
1473  0075 85            	popw	x
1474  0076 81            	ret	
1477                     	bsct
1478  007e               L155_p:
1479  007e 3f800000      	dc.w	16256,0
1480  0082               L355_d:
1481  0082 3f800000      	dc.w	16256,0
1555                     ; 574 void CmdDeal(void)
1555                     ; 575 {
1556                     .text:	section	.text,new
1557  0000               _CmdDeal:
1559  0000 520b          	subw	sp,#11
1560       0000000b      OFST:	set	11
1563                     ; 577 	float temp=0;
1565                     ; 578 	unsigned char pwm=0;
1567                     ; 579 	unsigned short CmdAdc=0;//nishizhen->shunshizhen:1024->0
1569                     ; 580 	if(NewI2cCmd!=0){
1571  0002 b633          	ld	a,_NewI2cCmd
1572  0004 2603cc009f    	jreq	L316
1573                     ; 581 		if(NewI2cCmd==0x01)//position change
1575  0009 a101          	cp	a,#1
1576  000b 2703cc009a    	jrne	L136
1577                     ; 583 			if(CmdPosition>330)
1579  0010 be2f          	ldw	x,_CmdPosition
1580  0012 a3014b        	cpw	x,#331
1581  0015 24ef          	jruge	L316
1582                     ; 584 			return;
1584                     ; 587 			temp=CmdPosition*2.844;
1586  0017 cd0000        	call	c_uitof
1588  001a ae01a8        	ldw	x,#L302
1589  001d cd0000        	call	c_fmul
1591  0020 96            	ldw	x,sp
1592  0021 1c0007        	addw	x,#OFST-4
1593  0024 cd0000        	call	c_rtol
1595                     ; 588 			CmdAdc=temp;
1597  0027 96            	ldw	x,sp
1598  0028 1c0007        	addw	x,#OFST-4
1599  002b cd0000        	call	c_ltor
1601  002e cd0000        	call	c_ftoi
1603  0031 1f05          	ldw	(OFST-6,sp),x
1604                     ; 590 			if(CmdAdc>(AdcValue+10))
1606  0033 be29          	ldw	x,_AdcValue
1607  0035 1c000a        	addw	x,#10
1608  0038 1305          	cpw	x,(OFST-6,sp)
1609  003a 1e05          	ldw	x,(OFST-6,sp)
1610  003c 242a          	jruge	L126
1611                     ; 592 				temp=(CmdAdc-AdcValue);
1613  003e 72b00029      	subw	x,_AdcValue
1614  0042 cd0000        	call	c_uitof
1616  0045 96            	ldw	x,sp
1617  0046 ad5a          	call	LC005
1619  0048 96            	ldw	x,sp
1620  0049 5c            	incw	x
1621  004a cd0000        	call	c_rtol
1623  004d 96            	ldw	x,sp
1624  004e 1c0007        	addw	x,#OFST-4
1625  0051 cd0000        	call	c_ltor
1627  0054 96            	ldw	x,sp
1628  0055 5c            	incw	x
1629  0056 cd0000        	call	c_fcmp
1631  0059 2d04          	jrsle	L326
1632                     ; 595 					pwm=75;
1634  005b a64b          	ld	a,#75
1636  005d 2002          	jra	L526
1637  005f               L326:
1638                     ; 599 					pwm=65;
1640  005f a641          	ld	a,#65
1641  0061               L526:
1642  0061 6b0b          	ld	(OFST+0,sp),a
1643                     ; 601 				SetMotoReverse(pwm);
1645  0063 cd0000        	call	_SetMotoReverse
1648  0066 2037          	jra	L316
1649  0068               L126:
1650                     ; 604 			else if((CmdAdc+10)<AdcValue)
1652  0068 1c000a        	addw	x,#10
1653  006b b329          	cpw	x,_AdcValue
1654  006d 242b          	jruge	L136
1655                     ; 606 				temp=(AdcValue-CmdAdc);
1657  006f be29          	ldw	x,_AdcValue
1658  0071 72f005        	subw	x,(OFST-6,sp)
1659  0074 cd0000        	call	c_uitof
1661  0077 96            	ldw	x,sp
1662  0078 ad28          	call	LC005
1664  007a 96            	ldw	x,sp
1665  007b 5c            	incw	x
1666  007c cd0000        	call	c_rtol
1668  007f 96            	ldw	x,sp
1669  0080 1c0007        	addw	x,#OFST-4
1670  0083 cd0000        	call	c_ltor
1672  0086 96            	ldw	x,sp
1673  0087 5c            	incw	x
1674  0088 cd0000        	call	c_fcmp
1676  008b 2d04          	jrsle	L336
1677                     ; 609 					pwm=75;
1679  008d a64b          	ld	a,#75
1681  008f 2002          	jra	L536
1682  0091               L336:
1683                     ; 613 					pwm=65;
1685  0091 a641          	ld	a,#65
1686  0093               L536:
1687  0093 6b0b          	ld	(OFST+0,sp),a
1688                     ; 615 				SetMotoForward(pwm);
1690  0095 cd0000        	call	_SetMotoForward
1693  0098 2005          	jra	L316
1694  009a               L136:
1695                     ; 619 				NewI2cCmd=0;
1696                     ; 620 				SetMotoStop();
1698                     ; 623 		else if(NewI2cCmd==0x02)//stop
1700                     ; 625 			NewI2cCmd=0;
1701                     ; 626 			SetMotoStop();
1704                     ; 630 			NewI2cCmd=0;
1706                     ; 631    			SetMotoStop();
1710  009a 3f33          	clr	_NewI2cCmd
1713  009c cd0000        	call	_SetMotoStop
1715  009f               L316:
1716                     ; 634 }
1719  009f 5b0b          	addw	sp,#11
1720  00a1 81            	ret	
1721  00a2               LC005:
1722  00a2 1c0007        	addw	x,#OFST-4
1723  00a5 cd0000        	call	c_rtol
1725                     ; 593 				if(temp>50)
1727  00a8 a632          	ld	a,#50
1728  00aa cc0000        	jp	c_ctof
1764                     ; 635 void SetMotoForward(unsigned char pwm)
1764                     ; 636 {
1765                     .text:	section	.text,new
1766  0000               _SetMotoForward:
1768  0000 88            	push	a
1769       00000000      OFST:	set	0
1772                     ; 637 	GPIO_WriteHigh(GPIOC, GPIO_PIN_5);
1774  0001 4b20          	push	#32
1775  0003 ae500a        	ldw	x,#20490
1776  0006 cd0000        	call	_GPIO_WriteHigh
1778  0009 84            	pop	a
1779                     ; 638 	Set_Pwm_Channel3(pwm);
1781  000a 7b01          	ld	a,(OFST+1,sp)
1782  000c cd0000        	call	_Set_Pwm_Channel3
1784                     ; 639 }
1787  000f 84            	pop	a
1788  0010 81            	ret	
1824                     ; 640 void SetMotoReverse(unsigned char pwm)
1824                     ; 641 {
1825                     .text:	section	.text,new
1826  0000               _SetMotoReverse:
1828  0000 88            	push	a
1829       00000000      OFST:	set	0
1832                     ; 642 	GPIO_WriteLow(GPIOC, GPIO_PIN_5);
1834  0001 4b20          	push	#32
1835  0003 ae500a        	ldw	x,#20490
1836  0006 cd0000        	call	_GPIO_WriteLow
1838  0009 84            	pop	a
1839                     ; 643 	Set_Pwm_Channel3(pwm);
1841  000a 7b01          	ld	a,(OFST+1,sp)
1842  000c cd0000        	call	_Set_Pwm_Channel3
1844                     ; 644 }
1847  000f 84            	pop	a
1848  0010 81            	ret	
1872                     ; 645 void SetMotoStop(void)
1872                     ; 646 {
1873                     .text:	section	.text,new
1874  0000               _SetMotoStop:
1878                     ; 647 	Set_Pwm_Channel3(0);
1880  0000 4f            	clr	a
1882                     ; 648 }
1885  0001 cc0000        	jp	_Set_Pwm_Channel3
1909                     ; 649 void SetMotoSleep(void)
1909                     ; 650 {
1910                     .text:	section	.text,new
1911  0000               _SetMotoSleep:
1915                     ; 651 	Set_Pwm_Channel3(0);
1917  0000 4f            	clr	a
1919                     ; 652 }
1922  0001 cc0000        	jp	_Set_Pwm_Channel3
2056                     	xdef	_ReadBuffer
2057                     	xdef	_main
2058                     	xdef	_CLK_Configuration
2059                     	xdef	_MotoStatusCheck
2060                     	xdef	_CheckUartRxI2cAddr
2061                     	xdef	_SetMotoSleep
2062                     	xdef	_SetMotoStop
2063                     	xdef	_SetMotoReverse
2064                     	xdef	_SetMotoForward
2065                     	xdef	_Moto_Init
2066                     	xdef	_CmdDeal
2067                     	xdef	_Check_I2c_Data
2068                     	xdef	_SaveSysId
2069                     	xdef	_ReadSysId
2070                     	xdef	_Moto_VISEN_Error
2071                     	xdef	_Moto_nFAULT_Error
2072                     	xdef	_SystemStatus
2073                     	xdef	_Systemid
2074                     	xdef	_NewI2cCmd
2075                     	xdef	_CmdTime
2076                     	xdef	_CmdPosition
2077                     	xdef	_AdcPosition
2078                     	xdef	_AdcSum
2079                     	xdef	_AdcValue
2080                     	xdef	_AdcBufCnt
2081                     	xdef	_ADC_BUF
2082                     	xref.b	_UartRxI2cAddrFlag
2083                     	xref.b	_UartRxI2cAddr
2084                     	xref.b	_IIC_BUF
2085                     	xref.b	_IIC_RECV_ONE_FRAME_OK
2086                     	xref.b	_SLAVE_ADDRESS
2087                     	xref.b	_Sys_1000ms_Flag
2088                     	xref.b	_Sys_500ms_Flag
2089                     	xref.b	_Sys_200ms_Flag
2090                     	xref.b	_Sys_100ms_Flag
2091                     	xref.b	_Sys_50ms_Flag
2092                     	xref.b	_Sys_20ms_Flag
2093                     	xref.b	_Sys_10ms_Flag
2094                     	xref	_ReadMultiBlockByte
2095                     	xref	_WriteMultiBlockByte
2096                     	xref	_UART1_printf
2097                     	xref	_UART1_SendString
2098                     	xref	_Uart1_Init
2099                     	xref	_GetMotoADValue
2100                     	xref	_ADC_Init
2101                     	xref	_Init_I2C
2102                     	xref	_Tim1_Init
2103                     	xref	_LED_Reverse
2104                     	xref	_SetLedOFF
2105                     	xref	_LED_Init
2106                     	xref	_Set_Pwm_Channel3
2107                     	xref	_Pwm_Init
2108                     	xref	_GPIO_ReadInputPin
2109                     	xref	_GPIO_WriteLow
2110                     	xref	_GPIO_WriteHigh
2111                     	xref	_GPIO_Init
2112                     	xref	_FLASH_WaitForLastOperation
2113                     	xref	_FLASH_EraseBlock
2114                     	xref	_FLASH_SetProgrammingTime
2115                     	xref	_CLK_HSIPrescalerConfig
2116                     	xref	_CLK_HSICmd
2117                     .const:	section	.text
2118  0000               L745:
2119  0000 4d6f746f7220  	dc.b	"Motor Driver VISEN"
2120  0012 204368616e67  	dc.b	" Change,VISEN:%d",0
2121  0023               L335:
2122  0023 4d6f746f7220  	dc.b	"Motor Driver nFAUL"
2123  0035 54204368616e  	dc.b	"T Change,nFAULT:%d",0
2124  0048               L524:
2125  0048 526563656976  	dc.b	"Receive a error cm"
2126  005a 643a25640d    	dc.b	"d:%d",13
2127  005f 0a00          	dc.b	10,0
2128  0061               L324:
2129  0061 526563656976  	dc.b	"Receive stop Cmd",13
2130  0072 0a00          	dc.b	10,0
2131  0074               L714:
2132  0074 75702d646f77  	dc.b	"up-down-head Cmd e"
2133  0086 72726f206f75  	dc.b	"rro out of(165-190"
2134  0098 290d          	dc.b	")",13
2135  009a 0a00          	dc.b	10,0
2136  009c               L504:
2137  009c 6c6566742d72  	dc.b	"left-right-head Cm"
2138  00ae 64206572726f  	dc.b	"d erro out of(100-"
2139  00c0 323630290d    	dc.b	"260)",13
2140  00c5 0a00          	dc.b	10,0
2141  00c7               L373:
2142  00c7 526967687420  	dc.b	"Right Hand Cmd err"
2143  00d9 6f206f757420  	dc.b	"o out of(130-290)",13
2144  00eb 0a00          	dc.b	10,0
2145  00ed               L163:
2146  00ed 4c6566742048  	dc.b	"Left Hand Cmd erro"
2147  00ff 206f7574206f  	dc.b	" out of(70-230)",13
2148  010f 0a00          	dc.b	10,0
2149  0111               L153:
2150  0111 54686520436d  	dc.b	"The CmdPosition is"
2151  0123 3a25642c5468  	dc.b	":%d,The CmdTime is"
2152  0135 3a25640d      	dc.b	":%d",13
2153  0139 0a00          	dc.b	10,0
2154  013b               L743:
2155  013b 526563656976  	dc.b	"Receive a Position"
2156  014d 204368616e67  	dc.b	" Change Cmd",13
2157  0159 0a00          	dc.b	10,0
2158  015b               L723:
2159  015b 526563656976  	dc.b	"Receive a null cmd"
2160  016d 202830290d    	dc.b	" (0)",13
2161  0172 0a00          	dc.b	10,0
2162  0174               L172:
2163  0174 536176652053  	dc.b	"Save Sysid ok,the "
2164  0186 69642069733a  	dc.b	"id is:0x%02h",0
2165  0193               L702:
2166  0193 54686520506f  	dc.b	"The Position Is:%d"
2167  01a5 0d0a00        	dc.b	13,10,0
2168  01a8               L302:
2169  01a8 40360418      	dc.w	16438,1048
2170  01ac               L571:
2171  01ac 546865204164  	dc.b	"The Adc Is:%d",13
2172  01ba 0a00          	dc.b	10,0
2173  01bc               L561:
2174  01bc 4d6f746f7220  	dc.b	"Motor Driver error"
2175  01ce 2e2e2e2e0d    	dc.b	"....",13
2176  01d3 0a00          	dc.b	10,0
2177  01d5               L77:
2178  01d5 53797374656d  	dc.b	"System is on....!!"
2179  01e7 210d          	dc.b	"!",13
2180  01e9 0a00          	dc.b	10,0
2181  01eb               L57:
2182  01eb 546865205379  	dc.b	"The Systemid is er"
2183  01fd 726f722e2e2e  	dc.b	"ror....",13
2184  0205 0a00          	dc.b	10,0
2185  0207               L37:
2186  0207 546865205379  	dc.b	"The System is for "
2187  0219 75702d646f77  	dc.b	"up-down-head",13
2188  0226 0a00          	dc.b	10,0
2189  0228               L17:
2190  0228 546865205379  	dc.b	"The System is for "
2191  023a 4c6566742d52  	dc.b	"Left-Right-head",13
2192  024a 0a00          	dc.b	10,0
2193  024c               L76:
2194  024c 546865205379  	dc.b	"The System is for "
2195  025e 526967687468  	dc.b	"Righthand",13
2196  0268 0a00          	dc.b	10,0
2197  026a               L56:
2198  026a 546865205379  	dc.b	"The System is for "
2199  027c 4c6566746861  	dc.b	"Lefthand",13
2200  0285 0a00          	dc.b	10,0
2201  0287               L75:
2202  0287 526561642053  	dc.b	"Read Sysid is:%d",13
2203  0298 0a00          	dc.b	10,0
2204                     	xref.b	c_x
2224                     	xref	c_fcmp
2225                     	xref	c_ctof
2226                     	xref	c_ltor
2227                     	xref	c_rtol
2228                     	xref	c_fmul
2229                     	xref	c_ftoi
2230                     	xref	c_fdiv
2231                     	xref	c_uitof
2232                     	end
