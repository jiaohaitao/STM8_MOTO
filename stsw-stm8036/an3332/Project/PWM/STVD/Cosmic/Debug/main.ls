   1                     ; C Compiler for STM8 (COSMIC Software)
   2                     ; Parser V4.8.32 - 23 Mar 2010
   3                     ; Generator V4.3.4 - 23 Mar 2010
   4                     ; Optimizer V4.3.3 - 10 Feb 2010
  20                     	bsct
  21  0000               _Last_I2c_Buffer:
  22  0000 00            	dc.b	0
  23  0001 000000000000  	ds.b	31
  63                     ; 50 u8 Check_I2c_Data(void)
  63                     ; 51 {
  65                     .text:	section	.text,new
  66  0000               _Check_I2c_Data:
  68  0000 88            	push	a
  69       00000001      OFST:	set	1
  72                     ; 52 	u8 i=0;
  74  0001 0f01          	clr	(OFST+0,sp)
  75                     ; 61 	return 0;
  77  0003 4f            	clr	a
  80  0004 5b01          	addw	sp,#1
  81  0006 81            	ret	
  84                     	bsct
  85  0020               L13_AdcValue:
  86  0020 0000          	dc.w	0
 150                     ; 71 void main(void)
 150                     ; 72 {
 151                     .text:	section	.text,new
 152  0000               _main:
 154  0000 88            	push	a
 155       00000001      OFST:	set	1
 158                     ; 73 	unsigned char pwm=0;
 160  0001 0f01          	clr	(OFST+0,sp)
 161                     ; 76 	SystemClock_Init(HSI_Clock);
 163  0003 4f            	clr	a
 164  0004 cd0000        	call	_SystemClock_Init
 166                     ; 77 	LED_Init();//led3->PC3 led2->PD3 led1->PD3
 168  0007 cd0000        	call	_LED_Init
 170                     ; 78 	Tim1_Init();	
 172  000a cd0000        	call	_Tim1_Init
 174                     ; 79 	Pwm_Init(); //channel1->PD4 channel2->PD3 channel3->PA3
 176  000d cd0000        	call	_Pwm_Init
 178                     ; 80 	ADC_Init();// ADC1 Channel2 PC4
 180  0010 cd0000        	call	_ADC_Init
 182                     ; 81 	Uart1_Init();//PD5->Uart1 Tx   PD6->Uart1 Rx
 184  0013 cd0000        	call	_Uart1_Init
 186                     ; 83 	SetLedOFF(); /* ÈÃËùÓÐµÆÃð */
 188  0016 cd0000        	call	_SetLedOFF
 190                     ; 86 	Init_I2C();//PB4-SCL PB5->SDA
 192  0019 cd0000        	call	_Init_I2C
 194                     ; 90 	UART1_SendString("Stm8 Pwm Test....\r\n");
 196  001c ae0000        	ldw	x,#L55
 197  001f cd0000        	call	_UART1_SendString
 199                     ; 91 		enableInterrupts(); 
 202  0022 9a            	rim	
 204  0023               L75:
 205                     ; 95 		if(Sys_20ms_Flag==1)
 207  0023 b600          	ld	a,_Sys_20ms_Flag
 208  0025 4a            	dec	a
 209  0026 2602          	jrne	L36
 210                     ; 97 			Sys_20ms_Flag=0;
 212  0028 b700          	ld	_Sys_20ms_Flag,a
 213  002a               L36:
 214                     ; 100 		if(Sys_50ms_Flag==1)
 216  002a b600          	ld	a,_Sys_50ms_Flag
 217  002c 4a            	dec	a
 218  002d 2605          	jrne	L56
 219                     ; 102 			Sys_50ms_Flag=0;
 221  002f b700          	ld	_Sys_50ms_Flag,a
 222                     ; 104 			Check_I2c_Data();
 224  0031 cd0000        	call	_Check_I2c_Data
 226  0034               L56:
 227                     ; 107 		if(Sys_100ms_Flag==1)
 229  0034 b600          	ld	a,_Sys_100ms_Flag
 230  0036 4a            	dec	a
 231  0037 261a          	jrne	L76
 232                     ; 109 			Sys_100ms_Flag=0;
 234  0039 b700          	ld	_Sys_100ms_Flag,a
 235                     ; 110 			pwm+=10;
 237  003b 7b01          	ld	a,(OFST+0,sp)
 238  003d ab0a          	add	a,#10
 239                     ; 111 			if(pwm>100)
 241  003f a165          	cp	a,#101
 242  0041 2501          	jrult	L17
 243                     ; 112 			pwm=0;
 245  0043 4f            	clr	a
 246  0044               L17:
 247  0044 6b01          	ld	(OFST+0,sp),a
 248                     ; 114 			Set_Pwm_Channel1(pwm);
 250  0046 cd0000        	call	_Set_Pwm_Channel1
 252                     ; 115 			Set_Pwm_Channel2(pwm);
 254  0049 7b01          	ld	a,(OFST+0,sp)
 255  004b cd0000        	call	_Set_Pwm_Channel2
 257                     ; 116 			Set_Pwm_Channel3(pwm);
 259  004e 7b01          	ld	a,(OFST+0,sp)
 260  0050 cd0000        	call	_Set_Pwm_Channel3
 262  0053               L76:
 263                     ; 119 		if(Sys_200ms_Flag==1)
 265  0053 b600          	ld	a,_Sys_200ms_Flag
 266  0055 4a            	dec	a
 267  0056 261b          	jrne	L37
 268                     ; 121 			Sys_200ms_Flag=0;
 270  0058 b700          	ld	_Sys_200ms_Flag,a
 271                     ; 122 			AdcValue=OneChannelGetADValue(ADC1_CHANNEL_2,ADC1_SCHMITTTRIG_CHANNEL2);
 273  005a ae0002        	ldw	x,#2
 274  005d a602          	ld	a,#2
 275  005f 95            	ld	xh,a
 276  0060 cd0000        	call	_OneChannelGetADValue
 278  0063 bf20          	ldw	L13_AdcValue,x
 279                     ; 124 			UART1_SendByte((unsigned char)(AdcValue>>8));
 281  0065 b620          	ld	a,L13_AdcValue
 282  0067 cd0000        	call	_UART1_SendByte
 284                     ; 125 			UART1_SendByte((unsigned char)AdcValue);
 286  006a b621          	ld	a,L13_AdcValue+1
 287  006c cd0000        	call	_UART1_SendByte
 289                     ; 126 			UART1_SendByte(0);
 291  006f 4f            	clr	a
 292  0070 cd0000        	call	_UART1_SendByte
 294  0073               L37:
 295                     ; 129 		if(Sys_500ms_Flag==1)
 297  0073 b600          	ld	a,_Sys_500ms_Flag
 298  0075 4a            	dec	a
 299  0076 2602          	jrne	L57
 300                     ; 131 			Sys_500ms_Flag=0;
 302  0078 b700          	ld	_Sys_500ms_Flag,a
 303  007a               L57:
 304                     ; 134 		if(Sys_1000ms_Flag==1)
 306  007a b600          	ld	a,_Sys_1000ms_Flag
 307  007c 4a            	dec	a
 308  007d 26a4          	jrne	L75
 309                     ; 136 			Sys_1000ms_Flag=0;
 311  007f b700          	ld	_Sys_1000ms_Flag,a
 312                     ; 137 			LED_Reverse(LED_3);
 314  0081 a608          	ld	a,#8
 315  0083 cd0000        	call	_LED_Reverse
 317  0086 209b          	jra	L75
 342                     	xdef	_main
 343                     	xdef	_Check_I2c_Data
 344                     	xref.b	_Sys_1000ms_Flag
 345                     	xref.b	_Sys_500ms_Flag
 346                     	xref.b	_Sys_200ms_Flag
 347                     	xref.b	_Sys_100ms_Flag
 348                     	xref.b	_Sys_50ms_Flag
 349                     	xref.b	_Sys_20ms_Flag
 350                     	xdef	_Last_I2c_Buffer
 351                     	xref	_UART1_SendString
 352                     	xref	_UART1_SendByte
 353                     	xref	_Uart1_Init
 354                     	xref	_OneChannelGetADValue
 355                     	xref	_ADC_Init
 356                     	xref	_Init_I2C
 357                     	xref	_Tim1_Init
 358                     	xref	_LED_Reverse
 359                     	xref	_SetLedOFF
 360                     	xref	_LED_Init
 361                     	xref	_SystemClock_Init
 362                     	xref	_Set_Pwm_Channel3
 363                     	xref	_Set_Pwm_Channel2
 364                     	xref	_Set_Pwm_Channel1
 365                     	xref	_Pwm_Init
 366                     .const:	section	.text
 367  0000               L55:
 368  0000 53746d382050  	dc.b	"Stm8 Pwm Test....",13
 369  0012 0a00          	dc.b	10,0
 389                     	end
