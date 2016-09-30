   1                     ; C Compiler for STM8 (COSMIC Software)
   2                     ; Parser V4.8.32 - 23 Mar 2010
   3                     ; Generator V4.3.4 - 23 Mar 2010
   4                     ; Optimizer V4.3.3 - 10 Feb 2010
  50                     ; 39 void ADC_Init(void)
  50                     ; 40 {
  52                     .text:	section	.text,new
  53  0000               _ADC_Init:
  57                     ; 49     ADC1_Init(ADC1_CONVERSIONMODE_CONTINUOUS , ADC1_CHANNEL_2, ADC1_PRESSEL_FCPU_D18,\
  57                     ; 50 		ADC1_EXTTRIG_TIM, DISABLE, ADC1_ALIGN_RIGHT, ADC1_SCHMITTTRIG_CHANNEL2,DISABLE);
  59  0000 4b00          	push	#0
  60  0002 4b02          	push	#2
  61  0004 4b08          	push	#8
  62  0006 4b00          	push	#0
  63  0008 4b00          	push	#0
  64  000a 4b70          	push	#112
  65  000c ae0002        	ldw	x,#2
  66  000f a601          	ld	a,#1
  67  0011 95            	ld	xh,a
  68  0012 cd0000        	call	_ADC1_Init
  70  0015 5b06          	addw	sp,#6
  71                     ; 51     ADC1_Cmd(ENABLE);
  73  0017 a601          	ld	a,#1
  75                     ; 53 }
  78  0019 cc0000        	jp	_ADC1_Cmd
 112                     ; 64 void Send_ADC_Value(u16 AD_Value)
 112                     ; 65 {
 113                     .text:	section	.text,new
 114  0000               _Send_ADC_Value:
 118                     ; 72 }
 121  0000 81            	ret	
 145                     ; 82 void MultipleChannelGetADValue(void)
 145                     ; 83 {
 146                     .text:	section	.text,new
 147  0000               _MultipleChannelGetADValue:
 151                     ; 94 }
 154  0000 81            	ret	
 399                     ; 102 uint16_t OneChannelGetADValue(ADC1_Channel_TypeDef ADC1_Channel,\
 399                     ; 103                                      ADC1_SchmittTrigg_TypeDef ADC1_SchmittTriggerChannel)
 399                     ; 104 {
 400                     .text:	section	.text,new
 401  0000               _OneChannelGetADValue:
 403  0000 89            	pushw	x
 404       00000002      OFST:	set	2
 407                     ; 114     ADC1_Init(ADC1_CONVERSIONMODE_CONTINUOUS , ADC1_Channel, ADC1_PRESSEL_FCPU_D18,\
 407                     ; 115 		ADC1_EXTTRIG_TIM, DISABLE, ADC1_ALIGN_RIGHT, ADC1_SchmittTriggerChannel,DISABLE);
 409  0001 4b00          	push	#0
 410  0003 9f            	ld	a,xl
 411  0004 88            	push	a
 412  0005 4b08          	push	#8
 413  0007 4b00          	push	#0
 414  0009 4b00          	push	#0
 415  000b 4b70          	push	#112
 416  000d 9e            	ld	a,xh
 417  000e 97            	ld	xl,a
 418  000f a601          	ld	a,#1
 419  0011 95            	ld	xh,a
 420  0012 cd0000        	call	_ADC1_Init
 422  0015 5b06          	addw	sp,#6
 423                     ; 116     ADC1_Cmd(ENABLE);
 425  0017 a601          	ld	a,#1
 426  0019 cd0000        	call	_ADC1_Cmd
 428                     ; 117     ADC1_StartConversion();
 430  001c cd0000        	call	_ADC1_StartConversion
 432                     ; 118     ADConversion_Value = ADC1_GetConversionValue();
 434  001f cd0000        	call	_ADC1_GetConversionValue
 436                     ; 119     return ADConversion_Value;
 440  0022 5b02          	addw	sp,#2
 441  0024 81            	ret	
 475                     ; 123 static void Delay(u16 nCount)
 475                     ; 124 {
 476                     .text:	section	.text,new
 477  0000               L3_Delay:
 479  0000 89            	pushw	x
 480       00000000      OFST:	set	0
 483  0001 2003          	jra	L502
 484  0003               L302:
 485                     ; 128     nCount--;
 487  0003 5a            	decw	x
 488  0004 1f01          	ldw	(OFST+1,sp),x
 489  0006               L502:
 490                     ; 126   while (nCount != 0)
 492  0006 1e01          	ldw	x,(OFST+1,sp)
 493  0008 26f9          	jrne	L302
 494                     ; 130 }
 497  000a 85            	popw	x
 498  000b 81            	ret	
 511                     	xdef	_OneChannelGetADValue
 512                     	xdef	_MultipleChannelGetADValue
 513                     	xdef	_Send_ADC_Value
 514                     	xdef	_ADC_Init
 515                     	xref	_ADC1_GetConversionValue
 516                     	xref	_ADC1_StartConversion
 517                     	xref	_ADC1_Cmd
 518                     	xref	_ADC1_Init
 537                     	end
