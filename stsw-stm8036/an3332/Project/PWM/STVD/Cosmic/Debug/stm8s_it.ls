   1                     ; C Compiler for STM8 (COSMIC Software)
   2                     ; Parser V4.8.32 - 23 Mar 2010
   3                     ; Generator V4.3.4 - 23 Mar 2010
   4                     ; Optimizer V4.3.3 - 10 Feb 2010
  49                     ; 46 INTERRUPT_HANDLER(NonHandledInterrupt, 25)
  49                     ; 47 {
  50                     .text:	section	.text,new
  51  0000               f_NonHandledInterrupt:
  55                     ; 51 }
  58  0000 80            	iret	
  80                     ; 59 INTERRUPT_HANDLER_TRAP(TRAP_IRQHandler)
  80                     ; 60 {
  81                     .text:	section	.text,new
  82  0000               f_TRAP_IRQHandler:
  86                     ; 64 }
  89  0000 80            	iret	
 111                     ; 70 INTERRUPT_HANDLER(TLI_IRQHandler, 0)
 111                     ; 71 {
 112                     .text:	section	.text,new
 113  0000               f_TLI_IRQHandler:
 117                     ; 75 }
 120  0000 80            	iret	
 142                     ; 82 INTERRUPT_HANDLER(AWU_IRQHandler, 1)
 142                     ; 83 {
 143                     .text:	section	.text,new
 144  0000               f_AWU_IRQHandler:
 148                     ; 87 }
 151  0000 80            	iret	
 173                     ; 94 INTERRUPT_HANDLER(CLK_IRQHandler, 2)
 173                     ; 95 {
 174                     .text:	section	.text,new
 175  0000               f_CLK_IRQHandler:
 179                     ; 99 }
 182  0000 80            	iret	
 205                     ; 106 INTERRUPT_HANDLER(EXTI_PORTA_IRQHandler, 3)
 205                     ; 107 {
 206                     .text:	section	.text,new
 207  0000               f_EXTI_PORTA_IRQHandler:
 211                     ; 111 }
 214  0000 80            	iret	
 237                     ; 118 INTERRUPT_HANDLER(EXTI_PORTB_IRQHandler, 4)
 237                     ; 119 {
 238                     .text:	section	.text,new
 239  0000               f_EXTI_PORTB_IRQHandler:
 243                     ; 123 }
 246  0000 80            	iret	
 269                     ; 130 INTERRUPT_HANDLER(EXTI_PORTC_IRQHandler, 5)
 269                     ; 131 {
 270                     .text:	section	.text,new
 271  0000               f_EXTI_PORTC_IRQHandler:
 275                     ; 135 }
 278  0000 80            	iret	
 301                     ; 142 INTERRUPT_HANDLER(EXTI_PORTD_IRQHandler, 6)
 301                     ; 143 {
 302                     .text:	section	.text,new
 303  0000               f_EXTI_PORTD_IRQHandler:
 307                     ; 147 }
 310  0000 80            	iret	
 333                     ; 154 INTERRUPT_HANDLER(EXTI_PORTE_IRQHandler, 7)
 333                     ; 155 {
 334                     .text:	section	.text,new
 335  0000               f_EXTI_PORTE_IRQHandler:
 339                     ; 159 }
 342  0000 80            	iret	
 364                     ; 205 INTERRUPT_HANDLER(SPI_IRQHandler, 10)
 364                     ; 206 {
 365                     .text:	section	.text,new
 366  0000               f_SPI_IRQHandler:
 370                     ; 210 }
 373  0000 80            	iret	
 398                     ; 217 INTERRUPT_HANDLER(TIM1_UPD_OVF_TRG_BRK_IRQHandler, 11)
 398                     ; 218 {
 399                     .text:	section	.text,new
 400  0000               f_TIM1_UPD_OVF_TRG_BRK_IRQHandler:
 402  0000 3b0002        	push	c_x+2
 403  0003 be00          	ldw	x,c_x
 404  0005 89            	pushw	x
 405  0006 3b0002        	push	c_y+2
 406  0009 be00          	ldw	x,c_y
 407  000b 89            	pushw	x
 410                     ; 222 	TimingDelay_Decrement();
 412  000c cd0000        	call	_TimingDelay_Decrement
 414                     ; 224 	TIM1_ClearITPendingBit(TIM1_IT_UPDATE);  	
 416  000f a601          	ld	a,#1
 417  0011 cd0000        	call	_TIM1_ClearITPendingBit
 419                     ; 225 }
 422  0014 85            	popw	x
 423  0015 bf00          	ldw	c_y,x
 424  0017 320002        	pop	c_y+2
 425  001a 85            	popw	x
 426  001b bf00          	ldw	c_x,x
 427  001d 320002        	pop	c_x+2
 428  0020 80            	iret	
 451                     ; 232 INTERRUPT_HANDLER(TIM1_CAP_COM_IRQHandler, 12)
 451                     ; 233 {
 452                     .text:	section	.text,new
 453  0000               f_TIM1_CAP_COM_IRQHandler:
 457                     ; 237 }
 460  0000 80            	iret	
 483                     ; 269  INTERRUPT_HANDLER(TIM2_UPD_OVF_BRK_IRQHandler, 13)
 483                     ; 270 {
 484                     .text:	section	.text,new
 485  0000               f_TIM2_UPD_OVF_BRK_IRQHandler:
 489                     ; 274 }
 492  0000 80            	iret	
 515                     ; 281  INTERRUPT_HANDLER(TIM2_CAP_COM_IRQHandler, 14)
 515                     ; 282 {
 516                     .text:	section	.text,new
 517  0000               f_TIM2_CAP_COM_IRQHandler:
 521                     ; 286 }
 524  0000 80            	iret	
 547                     ; 323  INTERRUPT_HANDLER(UART1_TX_IRQHandler, 17)
 547                     ; 324 {
 548                     .text:	section	.text,new
 549  0000               f_UART1_TX_IRQHandler:
 553                     ; 328 }
 556  0000 80            	iret	
 579                     ; 335  INTERRUPT_HANDLER(UART1_RX_IRQHandler, 18)
 579                     ; 336 {
 580                     .text:	section	.text,new
 581  0000               f_UART1_RX_IRQHandler:
 585                     ; 340 }
 588  0000 80            	iret	
 610                     ; 348 INTERRUPT_HANDLER(I2C_IRQHandler, 19)
 610                     ; 349 {
 611                     .text:	section	.text,new
 612  0000               f_I2C_IRQHandler:
 616                     ; 353 }
 619  0000 80            	iret	
 641                     ; 428  INTERRUPT_HANDLER(ADC1_IRQHandler, 22)
 641                     ; 429 {
 642                     .text:	section	.text,new
 643  0000               f_ADC1_IRQHandler:
 647                     ; 434     return;
 650  0000 80            	iret	
 673                     ; 457  INTERRUPT_HANDLER(TIM4_UPD_OVF_IRQHandler, 23)
 673                     ; 458 {
 674                     .text:	section	.text,new
 675  0000               f_TIM4_UPD_OVF_IRQHandler:
 679                     ; 462 }
 682  0000 80            	iret	
 705                     ; 470 INTERRUPT_HANDLER(EEPROM_EEC_IRQHandler, 24)
 705                     ; 471 {
 706                     .text:	section	.text,new
 707  0000               f_EEPROM_EEC_IRQHandler:
 711                     ; 475 }
 714  0000 80            	iret	
 726                     	xref	_TimingDelay_Decrement
 727                     	xdef	f_EEPROM_EEC_IRQHandler
 728                     	xdef	f_TIM4_UPD_OVF_IRQHandler
 729                     	xdef	f_ADC1_IRQHandler
 730                     	xdef	f_I2C_IRQHandler
 731                     	xdef	f_UART1_RX_IRQHandler
 732                     	xdef	f_UART1_TX_IRQHandler
 733                     	xdef	f_TIM2_CAP_COM_IRQHandler
 734                     	xdef	f_TIM2_UPD_OVF_BRK_IRQHandler
 735                     	xdef	f_TIM1_UPD_OVF_TRG_BRK_IRQHandler
 736                     	xdef	f_TIM1_CAP_COM_IRQHandler
 737                     	xdef	f_SPI_IRQHandler
 738                     	xdef	f_EXTI_PORTE_IRQHandler
 739                     	xdef	f_EXTI_PORTD_IRQHandler
 740                     	xdef	f_EXTI_PORTC_IRQHandler
 741                     	xdef	f_EXTI_PORTB_IRQHandler
 742                     	xdef	f_EXTI_PORTA_IRQHandler
 743                     	xdef	f_CLK_IRQHandler
 744                     	xdef	f_AWU_IRQHandler
 745                     	xdef	f_TLI_IRQHandler
 746                     	xdef	f_TRAP_IRQHandler
 747                     	xdef	f_NonHandledInterrupt
 748                     	xref	_TIM1_ClearITPendingBit
 749                     	xref.b	c_x
 750                     	xref.b	c_y
 769                     	end
