   1                     ; C Compiler for STM8 (COSMIC Software)
   2                     ; Parser V4.8.32 - 23 Mar 2010
   3                     ; Generator V4.3.4 - 23 Mar 2010
   4                     ; Optimizer V4.3.3 - 10 Feb 2010
  20                     	bsct
  21  0000               _Last_I2c_Buffer:
  22  0000 00            	dc.b	0
  23  0001 000000000000  	ds.b	31
  63                     ; 49 u8 Check_I2c_Data(void)
  63                     ; 50 {
  65                     .text:	section	.text,new
  66  0000               _Check_I2c_Data:
  68  0000 88            	push	a
  69       00000001      OFST:	set	1
  72                     ; 51 	u8 i=0;
  74  0001 0f01          	clr	(OFST+0,sp)
  75                     ; 60 	return 0;
  77  0003 4f            	clr	a
  80  0004 5b01          	addw	sp,#1
  81  0006 81            	ret	
  84                     	bsct
  85  0020               L13_AdcValue:
  86  0020 0000          	dc.w	0
 147                     ; 70 void main(void)
 147                     ; 71 {
 148                     .text:	section	.text,new
 149  0000               _main:
 151  0000 88            	push	a
 152       00000001      OFST:	set	1
 155                     ; 72 	unsigned char pwm=0;
 157  0001 0f01          	clr	(OFST+0,sp)
 158                     ; 75 	SystemClock_Init(HSI_Clock);
 160  0003 4f            	clr	a
 161  0004 cd0000        	call	_SystemClock_Init
 163                     ; 76 	LED_Init();//led3->PC3 led2->PD3 led1->PD3
 165  0007 cd0000        	call	_LED_Init
 167                     ; 77 	Tim1_Init();	
 169  000a cd0000        	call	_Tim1_Init
 171                     ; 78 	Pwm_Init(); //channel1->PD4 channel2->PD3 channel3->PA3
 173  000d cd0000        	call	_Pwm_Init
 175                     ; 79 	ADC_Init();// ADC1 Channel2 PC4
 177  0010 cd0000        	call	_ADC_Init
 179                     ; 81 	SetLedOFF(); /* ÈÃËùÓÐµÆÃð */
 181  0013 cd0000        	call	_SetLedOFF
 183                     ; 84 	Init_I2C();//PB4-SCL PB5->SDA
 185  0016 cd0000        	call	_Init_I2C
 187                     ; 86 	enableInterrupts(); 
 190  0019 9a            	rim	
 192  001a               L55:
 193                     ; 90 		if(Sys_20ms_Flag==1)
 195  001a b600          	ld	a,_Sys_20ms_Flag
 196  001c 4a            	dec	a
 197  001d 2602          	jrne	L16
 198                     ; 92 			Sys_20ms_Flag=0;
 200  001f b700          	ld	_Sys_20ms_Flag,a
 201  0021               L16:
 202                     ; 95 		if(Sys_50ms_Flag==1)
 204  0021 b600          	ld	a,_Sys_50ms_Flag
 205  0023 4a            	dec	a
 206  0024 2605          	jrne	L36
 207                     ; 97 			Sys_50ms_Flag=0;
 209  0026 b700          	ld	_Sys_50ms_Flag,a
 210                     ; 99 			Check_I2c_Data();
 212  0028 cd0000        	call	_Check_I2c_Data
 214  002b               L36:
 215                     ; 102 		if(Sys_100ms_Flag==1)
 217  002b b600          	ld	a,_Sys_100ms_Flag
 218  002d 4a            	dec	a
 219  002e 261a          	jrne	L56
 220                     ; 104 			Sys_100ms_Flag=0;
 222  0030 b700          	ld	_Sys_100ms_Flag,a
 223                     ; 105 			pwm+=10;
 225  0032 7b01          	ld	a,(OFST+0,sp)
 226  0034 ab0a          	add	a,#10
 227                     ; 106 			if(pwm>100)
 229  0036 a165          	cp	a,#101
 230  0038 2501          	jrult	L76
 231                     ; 107 			pwm=0;
 233  003a 4f            	clr	a
 234  003b               L76:
 235  003b 6b01          	ld	(OFST+0,sp),a
 236                     ; 109 			Set_Pwm_Channel1(pwm);
 238  003d cd0000        	call	_Set_Pwm_Channel1
 240                     ; 110 			Set_Pwm_Channel2(pwm);
 242  0040 7b01          	ld	a,(OFST+0,sp)
 243  0042 cd0000        	call	_Set_Pwm_Channel2
 245                     ; 111 			Set_Pwm_Channel3(pwm);
 247  0045 7b01          	ld	a,(OFST+0,sp)
 248  0047 cd0000        	call	_Set_Pwm_Channel3
 250  004a               L56:
 251                     ; 114 		if(Sys_200ms_Flag==1)
 253  004a b600          	ld	a,_Sys_200ms_Flag
 254  004c 4a            	dec	a
 255  004d 260d          	jrne	L17
 256                     ; 116 			Sys_200ms_Flag=0;
 258  004f b700          	ld	_Sys_200ms_Flag,a
 259                     ; 117 			AdcValue=OneChannelGetADValue(ADC1_CHANNEL_2,ADC1_SCHMITTTRIG_CHANNEL2);
 261  0051 ae0002        	ldw	x,#2
 262  0054 a602          	ld	a,#2
 263  0056 95            	ld	xh,a
 264  0057 cd0000        	call	_OneChannelGetADValue
 266  005a bf20          	ldw	L13_AdcValue,x
 267  005c               L17:
 268                     ; 120 		if(Sys_500ms_Flag==1)
 270  005c b600          	ld	a,_Sys_500ms_Flag
 271  005e 4a            	dec	a
 272  005f 2602          	jrne	L37
 273                     ; 122 			Sys_500ms_Flag=0;
 275  0061 b700          	ld	_Sys_500ms_Flag,a
 276  0063               L37:
 277                     ; 125 		if(Sys_1000ms_Flag==1)
 279  0063 b600          	ld	a,_Sys_1000ms_Flag
 280  0065 4a            	dec	a
 281  0066 26b2          	jrne	L55
 282                     ; 127 			Sys_1000ms_Flag=0;
 284  0068 b700          	ld	_Sys_1000ms_Flag,a
 285                     ; 128 			LED_Reverse(LED_3);
 287  006a a608          	ld	a,#8
 288  006c cd0000        	call	_LED_Reverse
 290  006f 20a9          	jra	L55
 315                     	xdef	_main
 316                     	xdef	_Check_I2c_Data
 317                     	xref.b	_Sys_1000ms_Flag
 318                     	xref.b	_Sys_500ms_Flag
 319                     	xref.b	_Sys_200ms_Flag
 320                     	xref.b	_Sys_100ms_Flag
 321                     	xref.b	_Sys_50ms_Flag
 322                     	xref.b	_Sys_20ms_Flag
 323                     	xdef	_Last_I2c_Buffer
 324                     	xref	_OneChannelGetADValue
 325                     	xref	_ADC_Init
 326                     	xref	_Init_I2C
 327                     	xref	_Tim1_Init
 328                     	xref	_LED_Reverse
 329                     	xref	_SetLedOFF
 330                     	xref	_LED_Init
 331                     	xref	_SystemClock_Init
 332                     	xref	_Set_Pwm_Channel3
 333                     	xref	_Set_Pwm_Channel2
 334                     	xref	_Set_Pwm_Channel1
 335                     	xref	_Pwm_Init
 354                     	end
