   1                     ; C Compiler for STM8 (COSMIC Software)
   2                     ; Parser V4.8.32 - 23 Mar 2010
   3                     ; Generator V4.3.4 - 23 Mar 2010
   4                     ; Optimizer V4.3.3 - 10 Feb 2010
  76                     ; 33 void Delay_Ms(unsigned int x)
  76                     ; 34 {
  78                     	switch	.text
  79  0000               _Delay_Ms:
  81  0000 89            	pushw	x
  82  0001 5204          	subw	sp,#4
  83       00000004      OFST:	set	4
  86                     ; 36 	for(i=0;i<x;i++)
  88  0003 5f            	clrw	x
  90  0004 200c          	jra	L34
  91  0006               L73:
  92                     ; 37 	for(j=0;j<1000;j++);
  94  0006 5f            	clrw	x
  95  0007               L74:
  99  0007 5c            	incw	x
 102  0008 a303e8        	cpw	x,#1000
 103  000b 25fa          	jrult	L74
 104  000d 1f03          	ldw	(OFST-1,sp),x
 105                     ; 36 	for(i=0;i<x;i++)
 107  000f 1e01          	ldw	x,(OFST-3,sp)
 108  0011 5c            	incw	x
 109  0012               L34:
 110  0012 1f01          	ldw	(OFST-3,sp),x
 113  0014 1305          	cpw	x,(OFST+1,sp)
 114  0016 25ee          	jrult	L73
 115                     ; 38 }
 118  0018 5b06          	addw	sp,#6
 119  001a 81            	ret	
 158                     ; 48 void main(void)
 158                     ; 49 {
 159                     	switch	.text
 160  001b               _main:
 162  001b 88            	push	a
 163       00000001      OFST:	set	1
 166                     ; 50 	unsigned char pwm=0;
 168  001c 0f01          	clr	(OFST+0,sp)
 169                     ; 51 	Pwm_Init(); 
 171  001e cd0000        	call	_Pwm_Init
 173  0021               L37:
 174                     ; 56 		pwm+=10;
 176  0021 7b01          	ld	a,(OFST+0,sp)
 177  0023 ab0a          	add	a,#10
 178                     ; 57 		if(pwm>100)
 180  0025 a165          	cp	a,#101
 181  0027 2501          	jrult	L77
 182                     ; 58 		pwm=0;
 184  0029 4f            	clr	a
 185  002a               L77:
 186  002a 6b01          	ld	(OFST+0,sp),a
 187                     ; 60 		Set_Pwm_Channel1(pwm);
 189  002c cd0000        	call	_Set_Pwm_Channel1
 191                     ; 61 		Set_Pwm_Channel2(pwm);
 193  002f 7b01          	ld	a,(OFST+0,sp)
 194  0031 cd0000        	call	_Set_Pwm_Channel2
 196                     ; 62 		Set_Pwm_Channel3(pwm);
 198  0034 7b01          	ld	a,(OFST+0,sp)
 199  0036 cd0000        	call	_Set_Pwm_Channel3
 201                     ; 63 		Delay_Ms(100);
 203  0039 ae0064        	ldw	x,#100
 204  003c adc2          	call	_Delay_Ms
 207  003e 20e1          	jra	L37
 220                     	xdef	_main
 221                     	xdef	_Delay_Ms
 222                     	xref	_Set_Pwm_Channel3
 223                     	xref	_Set_Pwm_Channel2
 224                     	xref	_Set_Pwm_Channel1
 225                     	xref	_Pwm_Init
 244                     	end
