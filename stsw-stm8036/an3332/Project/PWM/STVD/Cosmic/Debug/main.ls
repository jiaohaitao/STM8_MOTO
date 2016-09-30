   1                     ; C Compiler for STM8 (COSMIC Software)
   2                     ; Parser V4.8.32 - 23 Mar 2010
   3                     ; Generator V4.3.4 - 23 Mar 2010
   4                     ; Optimizer V4.3.3 - 10 Feb 2010
  20                     	bsct
  21  0000               _Last_I2c_Buffer:
  22  0000 00            	dc.b	0
  23  0001 000000000000  	ds.b	31
  63                     ; 48 u8 Check_I2c_Data(void)
  63                     ; 49 {
  65                     .text:	section	.text,new
  66  0000               _Check_I2c_Data:
  68  0000 88            	push	a
  69       00000001      OFST:	set	1
  72                     ; 50 	u8 i=0;
  74  0001 0f01          	clr	(OFST+0,sp)
  75                     ; 59 	return 0;
  77  0003 4f            	clr	a
  80  0004 5b01          	addw	sp,#1
  81  0006 81            	ret	
 133                     ; 69 void main(void)
 133                     ; 70 {
 134                     .text:	section	.text,new
 135  0000               _main:
 137  0000 88            	push	a
 138       00000001      OFST:	set	1
 141                     ; 71 	unsigned char pwm=0;
 143  0001 0f01          	clr	(OFST+0,sp)
 144                     ; 73 	SystemClock_Init(HSI_Clock);
 146  0003 4f            	clr	a
 147  0004 cd0000        	call	_SystemClock_Init
 149                     ; 74 	LED_Init();//led3->PC3 led2->PD3 led1->PD3
 151  0007 cd0000        	call	_LED_Init
 153                     ; 75 	Tim1_Init();	
 155  000a cd0000        	call	_Tim1_Init
 157                     ; 76 	Pwm_Init(); //channel1->PD4 channel2->PD3 channel3->PA3
 159  000d cd0000        	call	_Pwm_Init
 161                     ; 78 	SetLedOFF(); /* ÈÃËùÓÐµÆÃð */
 163  0010 cd0000        	call	_SetLedOFF
 165                     ; 81 	Init_I2C();//PB4-SCL PB5->SDA
 167  0013 cd0000        	call	_Init_I2C
 169                     ; 83 	enableInterrupts(); 
 172  0016 9a            	rim	
 174  0017               L74:
 175                     ; 87 		if(Sys_20ms_Flag==1)
 177  0017 b600          	ld	a,_Sys_20ms_Flag
 178  0019 4a            	dec	a
 179  001a 2602          	jrne	L35
 180                     ; 89 			Sys_20ms_Flag=0;
 182  001c b700          	ld	_Sys_20ms_Flag,a
 183  001e               L35:
 184                     ; 92 		if(Sys_50ms_Flag==1)
 186  001e b600          	ld	a,_Sys_50ms_Flag
 187  0020 4a            	dec	a
 188  0021 2605          	jrne	L55
 189                     ; 94 			Sys_50ms_Flag=0;
 191  0023 b700          	ld	_Sys_50ms_Flag,a
 192                     ; 96 			Check_I2c_Data();
 194  0025 cd0000        	call	_Check_I2c_Data
 196  0028               L55:
 197                     ; 99 		if(Sys_100ms_Flag==1)
 199  0028 b600          	ld	a,_Sys_100ms_Flag
 200  002a 4a            	dec	a
 201  002b 261a          	jrne	L75
 202                     ; 101 			Sys_100ms_Flag=0;
 204  002d b700          	ld	_Sys_100ms_Flag,a
 205                     ; 102 			pwm+=10;
 207  002f 7b01          	ld	a,(OFST+0,sp)
 208  0031 ab0a          	add	a,#10
 209                     ; 103 			if(pwm>100)
 211  0033 a165          	cp	a,#101
 212  0035 2501          	jrult	L16
 213                     ; 104 			pwm=0;
 215  0037 4f            	clr	a
 216  0038               L16:
 217  0038 6b01          	ld	(OFST+0,sp),a
 218                     ; 106 			Set_Pwm_Channel1(pwm);
 220  003a cd0000        	call	_Set_Pwm_Channel1
 222                     ; 107 			Set_Pwm_Channel2(pwm);
 224  003d 7b01          	ld	a,(OFST+0,sp)
 225  003f cd0000        	call	_Set_Pwm_Channel2
 227                     ; 108 			Set_Pwm_Channel3(pwm);
 229  0042 7b01          	ld	a,(OFST+0,sp)
 230  0044 cd0000        	call	_Set_Pwm_Channel3
 232  0047               L75:
 233                     ; 111 		if(Sys_200ms_Flag==1)
 235  0047 b600          	ld	a,_Sys_200ms_Flag
 236  0049 4a            	dec	a
 237  004a 2602          	jrne	L36
 238                     ; 113 			Sys_200ms_Flag=0;
 240  004c b700          	ld	_Sys_200ms_Flag,a
 241  004e               L36:
 242                     ; 116 		if(Sys_500ms_Flag==1)
 244  004e b600          	ld	a,_Sys_500ms_Flag
 245  0050 4a            	dec	a
 246  0051 2602          	jrne	L56
 247                     ; 118 			Sys_500ms_Flag=0;
 249  0053 b700          	ld	_Sys_500ms_Flag,a
 250  0055               L56:
 251                     ; 121 		if(Sys_1000ms_Flag==1)
 253  0055 b600          	ld	a,_Sys_1000ms_Flag
 254  0057 4a            	dec	a
 255  0058 26bd          	jrne	L74
 256                     ; 123 			Sys_1000ms_Flag=0;
 258  005a b700          	ld	_Sys_1000ms_Flag,a
 259                     ; 124 			LED_Reverse(LED_3);
 261  005c a608          	ld	a,#8
 262  005e cd0000        	call	_LED_Reverse
 264  0061 20b4          	jra	L74
 289                     	xdef	_main
 290                     	xdef	_Check_I2c_Data
 291                     	xref.b	_Sys_1000ms_Flag
 292                     	xref.b	_Sys_500ms_Flag
 293                     	xref.b	_Sys_200ms_Flag
 294                     	xref.b	_Sys_100ms_Flag
 295                     	xref.b	_Sys_50ms_Flag
 296                     	xref.b	_Sys_20ms_Flag
 297                     	xdef	_Last_I2c_Buffer
 298                     	xref	_Init_I2C
 299                     	xref	_Tim1_Init
 300                     	xref	_LED_Reverse
 301                     	xref	_SetLedOFF
 302                     	xref	_LED_Init
 303                     	xref	_SystemClock_Init
 304                     	xref	_Set_Pwm_Channel3
 305                     	xref	_Set_Pwm_Channel2
 306                     	xref	_Set_Pwm_Channel1
 307                     	xref	_Pwm_Init
 326                     	end
