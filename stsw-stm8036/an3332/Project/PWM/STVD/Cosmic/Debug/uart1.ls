   1                     ; C Compiler for STM8 (COSMIC Software)
   2                     ; Parser V4.8.32 - 23 Mar 2010
   3                     ; Generator V4.3.4 - 23 Mar 2010
   4                     ; Optimizer V4.3.3 - 10 Feb 2010
  52                     ; 41 void Uart1_Init(void)
  52                     ; 42 {
  54                     .text:	section	.text,new
  55  0000               _Uart1_Init:
  59                     ; 43     UART1_DeInit();		/* 将寄存器的值复位 */
  61  0000 cd0000        	call	_UART1_DeInit
  63                     ; 54     UART1_Init((u32)115200, UART1_WORDLENGTH_8D, UART1_STOPBITS_1, \
  63                     ; 55     	UART1_PARITY_NO , UART1_SYNCMODE_CLOCK_DISABLE , UART1_MODE_TXRX_ENABLE);
  65  0003 4b0c          	push	#12
  66  0005 4b80          	push	#128
  67  0007 4b00          	push	#0
  68  0009 4b00          	push	#0
  69  000b 4b00          	push	#0
  70  000d aec200        	ldw	x,#49664
  71  0010 89            	pushw	x
  72  0011 ae0001        	ldw	x,#1
  73  0014 89            	pushw	x
  74  0015 cd0000        	call	_UART1_Init
  76  0018 5b09          	addw	sp,#9
  77                     ; 56     UART1_ITConfig(UART1_IT_RXNE_OR, DISABLE);
  79  001a 4b00          	push	#0
  80  001c ae0205        	ldw	x,#517
  81  001f cd0000        	call	_UART1_ITConfig
  83  0022 84            	pop	a
  84                     ; 57     UART1_Cmd(ENABLE);
  86  0023 a601          	ld	a,#1
  88                     ; 58 }
  91  0025 cc0000        	jp	_UART1_Cmd
 127                     ; 67 void UART1_SendByte(u8 data)
 127                     ; 68 {
 128                     .text:	section	.text,new
 129  0000               _UART1_SendByte:
 133                     ; 69 	UART1_SendData8((unsigned char)data);
 135  0000 cd0000        	call	_UART1_SendData8
 138  0003               L14:
 139                     ; 72 	while (UART1_GetFlagStatus(UART1_FLAG_TXE) == RESET);
 141  0003 ae0080        	ldw	x,#128
 142  0006 cd0000        	call	_UART1_GetFlagStatus
 144  0009 4d            	tnz	a
 145  000a 27f7          	jreq	L14
 146                     ; 73 }
 149  000c 81            	ret	
 195                     ; 91 void UART1_SendString(u8* Data)
 195                     ; 92 {
 196                     .text:	section	.text,new
 197  0000               _UART1_SendString:
 199  0000 89            	pushw	x
 200  0001 89            	pushw	x
 201       00000002      OFST:	set	2
 204                     ; 93 	u16 i=0;
 206  0002 5f            	clrw	x
 208  0003 200c          	jra	L37
 209  0005               L76:
 210                     ; 95 		UART1_SendByte(Data[i]);	/* 循环调用发送一个字符函数 */
 212  0005 1e03          	ldw	x,(OFST+1,sp)
 213  0007 72fb01        	addw	x,(OFST-1,sp)
 214  000a f6            	ld	a,(x)
 215  000b cd0000        	call	_UART1_SendByte
 217                     ; 94 	for(; i < strlen(Data); i++)
 219  000e 1e01          	ldw	x,(OFST-1,sp)
 220  0010 5c            	incw	x
 221  0011               L37:
 222  0011 1f01          	ldw	(OFST-1,sp),x
 225  0013 1e03          	ldw	x,(OFST+1,sp)
 226  0015 cd0000        	call	_strlen
 228  0018 1301          	cpw	x,(OFST-1,sp)
 229  001a 22e9          	jrugt	L76
 230                     ; 96 }
 233  001c 5b04          	addw	sp,#4
 234  001e 81            	ret	
 247                     	xref	_strlen
 248                     	xdef	_UART1_SendString
 249                     	xdef	_UART1_SendByte
 250                     	xdef	_Uart1_Init
 251                     	xref	_UART1_GetFlagStatus
 252                     	xref	_UART1_SendData8
 253                     	xref	_UART1_ITConfig
 254                     	xref	_UART1_Cmd
 255                     	xref	_UART1_Init
 256                     	xref	_UART1_DeInit
 275                     	end
