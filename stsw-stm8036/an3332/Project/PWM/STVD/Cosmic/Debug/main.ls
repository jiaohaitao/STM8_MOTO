   1                     ; C Compiler for STM8 (COSMIC Software)
   2                     ; Parser V4.8.32 - 23 Mar 2010
   3                     ; Generator V4.3.4 - 23 Mar 2010
   4                     ; Optimizer V4.3.3 - 10 Feb 2010
  70                     ; 45 void main(void)
  70                     ; 46 {
  72                     .text:	section	.text,new
  73  0000               _main:
  75  0000 88            	push	a
  76       00000001      OFST:	set	1
  79                     ; 47 	unsigned char pwm=0;
  81  0001 0f01          	clr	(OFST+0,sp)
  82                     ; 49 	SystemClock_Init(HSI_Clock);
  84  0003 4f            	clr	a
  85  0004 cd0000        	call	_SystemClock_Init
  87                     ; 50 	LED_Init();
  89  0007 cd0000        	call	_LED_Init
  91                     ; 51 	Tim1_Init();	
  93  000a cd0000        	call	_Tim1_Init
  95                     ; 52 	Pwm_Init(); 
  97  000d cd0000        	call	_Pwm_Init
  99                     ; 54 	SetLedOFF(); /* ÈÃËùÓÐµÆÃð */
 101  0010 cd0000        	call	_SetLedOFF
 103                     ; 55 	enableInterrupts(); 
 106  0013 9a            	rim	
 108  0014               L13:
 109                     ; 59 		pwm+=10;
 111  0014 7b01          	ld	a,(OFST+0,sp)
 112  0016 ab0a          	add	a,#10
 113                     ; 60 		if(pwm>100)
 115  0018 a165          	cp	a,#101
 116  001a 2501          	jrult	L53
 117                     ; 61 		pwm=0;
 119  001c 4f            	clr	a
 120  001d               L53:
 121  001d 6b01          	ld	(OFST+0,sp),a
 122                     ; 63 		Set_Pwm_Channel1(pwm);
 124  001f cd0000        	call	_Set_Pwm_Channel1
 126                     ; 64 		Set_Pwm_Channel2(pwm);
 128  0022 7b01          	ld	a,(OFST+0,sp)
 129  0024 cd0000        	call	_Set_Pwm_Channel2
 131                     ; 65 		Set_Pwm_Channel3(pwm);
 133  0027 7b01          	ld	a,(OFST+0,sp)
 134  0029 cd0000        	call	_Set_Pwm_Channel3
 136                     ; 67 		LED_Reverse(LED_2);
 138  002c a620          	ld	a,#32
 139  002e cd0000        	call	_LED_Reverse
 141                     ; 68 		delay_ms(100);
 143  0031 ae0064        	ldw	x,#100
 144  0034 cd0000        	call	_delay_ms
 147  0037 20db          	jra	L13
 160                     	xdef	_main
 161                     	xref	_delay_ms
 162                     	xref	_Tim1_Init
 163                     	xref	_LED_Reverse
 164                     	xref	_SetLedOFF
 165                     	xref	_LED_Init
 166                     	xref	_SystemClock_Init
 167                     	xref	_Set_Pwm_Channel3
 168                     	xref	_Set_Pwm_Channel2
 169                     	xref	_Set_Pwm_Channel1
 170                     	xref	_Pwm_Init
 189                     	end
