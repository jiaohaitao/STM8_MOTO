   1                     ; C Compiler for STM8 (COSMIC Software)
   2                     ; Parser V4.8.32 - 23 Mar 2010
   3                     ; Generator V4.3.4 - 23 Mar 2010
   4                     ; Optimizer V4.3.3 - 10 Feb 2010
  48                     ; 43 INTERRUPT_HANDLER(NonHandledInterrupt, 25)
  48                     ; 44 {
  49                     	switch	.text
  50  0000               f_NonHandledInterrupt:
  54                     ; 48 }
  57  0000 80            	iret	
  79                     ; 56 INTERRUPT_HANDLER_TRAP(TRAP_IRQHandler)
  79                     ; 57 {
  80                     	switch	.text
  81  0001               f_TRAP_IRQHandler:
  85                     ; 61 }
  88  0001 80            	iret	
 110                     ; 67 INTERRUPT_HANDLER(TLI_IRQHandler, 0)
 110                     ; 68 {
 111                     	switch	.text
 112  0002               f_TLI_IRQHandler:
 116                     ; 72 }
 119  0002 80            	iret	
 141                     ; 79 INTERRUPT_HANDLER(AWU_IRQHandler, 1)
 141                     ; 80 {
 142                     	switch	.text
 143  0003               f_AWU_IRQHandler:
 147                     ; 84 }
 150  0003 80            	iret	
 172                     ; 91 INTERRUPT_HANDLER(CLK_IRQHandler, 2)
 172                     ; 92 {
 173                     	switch	.text
 174  0004               f_CLK_IRQHandler:
 178                     ; 96 }
 181  0004 80            	iret	
 204                     ; 103 INTERRUPT_HANDLER(EXTI_PORTA_IRQHandler, 3)
 204                     ; 104 {
 205                     	switch	.text
 206  0005               f_EXTI_PORTA_IRQHandler:
 210                     ; 108 }
 213  0005 80            	iret	
 236                     ; 115 INTERRUPT_HANDLER(EXTI_PORTB_IRQHandler, 4)
 236                     ; 116 {
 237                     	switch	.text
 238  0006               f_EXTI_PORTB_IRQHandler:
 242                     ; 120 }
 245  0006 80            	iret	
 268                     ; 127 INTERRUPT_HANDLER(EXTI_PORTC_IRQHandler, 5)
 268                     ; 128 {
 269                     	switch	.text
 270  0007               f_EXTI_PORTC_IRQHandler:
 274                     ; 132 }
 277  0007 80            	iret	
 300                     ; 139 INTERRUPT_HANDLER(EXTI_PORTD_IRQHandler, 6)
 300                     ; 140 {
 301                     	switch	.text
 302  0008               f_EXTI_PORTD_IRQHandler:
 306                     ; 144 }
 309  0008 80            	iret	
 332                     ; 151 INTERRUPT_HANDLER(EXTI_PORTE_IRQHandler, 7)
 332                     ; 152 {
 333                     	switch	.text
 334  0009               f_EXTI_PORTE_IRQHandler:
 338                     ; 156 }
 341  0009 80            	iret	
 363                     ; 202 INTERRUPT_HANDLER(SPI_IRQHandler, 10)
 363                     ; 203 {
 364                     	switch	.text
 365  000a               f_SPI_IRQHandler:
 369                     ; 207 }
 372  000a 80            	iret	
 395                     ; 214 INTERRUPT_HANDLER(TIM1_UPD_OVF_TRG_BRK_IRQHandler, 11)
 395                     ; 215 {
 396                     	switch	.text
 397  000b               f_TIM1_UPD_OVF_TRG_BRK_IRQHandler:
 401                     ; 219 }
 404  000b 80            	iret	
 427                     ; 226 INTERRUPT_HANDLER(TIM1_CAP_COM_IRQHandler, 12)
 427                     ; 227 {
 428                     	switch	.text
 429  000c               f_TIM1_CAP_COM_IRQHandler:
 433                     ; 231 }
 436  000c 80            	iret	
 459                     ; 263  INTERRUPT_HANDLER(TIM2_UPD_OVF_BRK_IRQHandler, 13)
 459                     ; 264 {
 460                     	switch	.text
 461  000d               f_TIM2_UPD_OVF_BRK_IRQHandler:
 465                     ; 268 }
 468  000d 80            	iret	
 491                     ; 275  INTERRUPT_HANDLER(TIM2_CAP_COM_IRQHandler, 14)
 491                     ; 276 {
 492                     	switch	.text
 493  000e               f_TIM2_CAP_COM_IRQHandler:
 497                     ; 280 }
 500  000e 80            	iret	
 523                     ; 317  INTERRUPT_HANDLER(UART1_TX_IRQHandler, 17)
 523                     ; 318 {
 524                     	switch	.text
 525  000f               f_UART1_TX_IRQHandler:
 529                     ; 322 }
 532  000f 80            	iret	
 555                     ; 329  INTERRUPT_HANDLER(UART1_RX_IRQHandler, 18)
 555                     ; 330 {
 556                     	switch	.text
 557  0010               f_UART1_RX_IRQHandler:
 561                     ; 334 }
 564  0010 80            	iret	
 586                     ; 342 INTERRUPT_HANDLER(I2C_IRQHandler, 19)
 586                     ; 343 {
 587                     	switch	.text
 588  0011               f_I2C_IRQHandler:
 592                     ; 347 }
 595  0011 80            	iret	
 617                     ; 422  INTERRUPT_HANDLER(ADC1_IRQHandler, 22)
 617                     ; 423 {
 618                     	switch	.text
 619  0012               f_ADC1_IRQHandler:
 623                     ; 428     return;
 626  0012 80            	iret	
 649                     ; 451  INTERRUPT_HANDLER(TIM4_UPD_OVF_IRQHandler, 23)
 649                     ; 452 {
 650                     	switch	.text
 651  0013               f_TIM4_UPD_OVF_IRQHandler:
 655                     ; 456 }
 658  0013 80            	iret	
 681                     ; 464 INTERRUPT_HANDLER(EEPROM_EEC_IRQHandler, 24)
 681                     ; 465 {
 682                     	switch	.text
 683  0014               f_EEPROM_EEC_IRQHandler:
 687                     ; 469 }
 690  0014 80            	iret	
 702                     	xdef	f_EEPROM_EEC_IRQHandler
 703                     	xdef	f_TIM4_UPD_OVF_IRQHandler
 704                     	xdef	f_ADC1_IRQHandler
 705                     	xdef	f_I2C_IRQHandler
 706                     	xdef	f_UART1_RX_IRQHandler
 707                     	xdef	f_UART1_TX_IRQHandler
 708                     	xdef	f_TIM2_CAP_COM_IRQHandler
 709                     	xdef	f_TIM2_UPD_OVF_BRK_IRQHandler
 710                     	xdef	f_TIM1_UPD_OVF_TRG_BRK_IRQHandler
 711                     	xdef	f_TIM1_CAP_COM_IRQHandler
 712                     	xdef	f_SPI_IRQHandler
 713                     	xdef	f_EXTI_PORTE_IRQHandler
 714                     	xdef	f_EXTI_PORTD_IRQHandler
 715                     	xdef	f_EXTI_PORTC_IRQHandler
 716                     	xdef	f_EXTI_PORTB_IRQHandler
 717                     	xdef	f_EXTI_PORTA_IRQHandler
 718                     	xdef	f_CLK_IRQHandler
 719                     	xdef	f_AWU_IRQHandler
 720                     	xdef	f_TLI_IRQHandler
 721                     	xdef	f_TRAP_IRQHandler
 722                     	xdef	f_NonHandledInterrupt
 741                     	end
