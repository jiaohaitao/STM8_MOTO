
/******************** (C) COPYRIGHT  风驰iCreate嵌入式开发工作室 **************
 * 文件名  ：uart1.c
 * 描述    ：UART1设置文件   
 * 实验平台：风驰STM8开发板
 * 库版本  ：V2.1.0
 * 作者    ：风驰  QQ：779814207
 * 博客    ：
 * 淘宝    ：http://shop71177993.taobao.com/
 *修改时间 ：2012-10-28

  风驰STM8开发板硬件连接
    |------------------------|
    |  TXD - PA4(UART1->RX)  |
    |  RXD - PA5(UART1->TX)  |
    |------------------------|

*******************************************************************************/

/* 包含系统头文件 */
#include <stdarg.h>

/* 包含自定义头文件 */
#include "stm8s.h"
#include "uart1.h"
#include "string.h"

/* 自定义新类型 */

/* 自定义宏 */

/* 全局变量定义 */

/*******************************************************************************
 * 名称: Uart_Init
 * 功能: UART1初始化操作
 * 形参: 无
 * 返回: 无
 * 说明: 无 
 ******************************************************************************/
void Uart1_Init(void)
{
    UART1_DeInit();		/* 将寄存器的值复位 */
	
	/*
	 * 将UART1配置为：
	 * 波特率 = 115200
	 * 数据位 = 8
	 * 1位停止位
	 * 无校验位
	 * 使能接收和发送
	 * 使能接收中断
	 */
    UART1_Init((u32)115200, UART1_WORDLENGTH_8D, UART1_STOPBITS_1, \
    	UART1_PARITY_NO , UART1_SYNCMODE_CLOCK_DISABLE , UART1_MODE_TXRX_ENABLE);
    UART1_ITConfig(UART1_IT_RXNE_OR, DISABLE);
    UART1_Cmd(ENABLE);
}

/*******************************************************************************
 * 名称: UART1_SendByte
 * 功能: UART1发送一个字节
 * 形参: data -> 要发送的字节
 * 返回: 无
 * 说明: 无 
 ******************************************************************************/
void UART1_SendByte(u8 data)
{
	UART1_SendData8((unsigned char)data);
	
	/* 等待传输结束 */
	while (UART1_GetFlagStatus(UART1_FLAG_TXE) == RESET);
}

/*******************************************************************************
 * 名称: UART1_SendString
 * 功能: UART1发送len个字符
 * 形参: data -> 指向要发送的字符串
 *       len -> 要发送的字节数
 * 返回: 无
 * 说明: 无 
 ******************************************************************************/
 #if 0
void UART1_SendString(u8* Data,u16 len)
{
	u16 i=0;
	for(; i < len; i++)
		UART1_SendByte(Data[i]);	/* 循环调用发送一个字符函数 */
}
#endif
void UART1_SendString(u8* Data)
{
	u16 i=0;
	for(; i < strlen(Data); i++)
		UART1_SendByte(Data[i]);	/* 循环调用发送一个字符函数 */
}
/******************* (C) COPYRIGHT 风驰iCreate嵌入式开发工作室 *****END OF FILE****/