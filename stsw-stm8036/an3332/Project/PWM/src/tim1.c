/******************** (C) COPYRIGHT  风驰iCreate嵌入式开发工作室 **************
 * 文件名  ：tim.c
 * 描述    ：STM8--TIM1模块配置函数   
 * 实验平台：风驰STM8开发板
 * 库版本  ：V2.1.0
 * 作者    ：风驰  QQ：779814207
 * 博客    ：
 * 淘宝    ：http://shop71177993.taobao.com/
 * 修改时间 ：2012-10-30

  风驰STM8开发板硬件连接
    |--------------------|
    |  LED1-PD0          |
    |  LED2-PD1          |
    |  LED3-PD2          |
    |  LED4-PD3          |
    |--------------------|

*******************************************************************************/

/* 包含系统头文件 */

/* 包含自定义头文件 */
#include "tim1.h"

/* 自定义新类型 */

/* 自定义宏 */

/* 全局变量定义 */
u16 TimingDelay; 

__IO u8 Sys_10ms_Flag=0;
__IO u8 Sys_20ms_Flag=0;
__IO u8 Sys_50ms_Flag=0;
__IO u8 Sys_100ms_Flag=0;
__IO u8 Sys_200ms_Flag=0;
__IO u8 Sys_500ms_Flag=0;
__IO u8 Sys_1000ms_Flag=0;

/*******************************************************************************
 * 名称: Tim1_Init
 * 功能: TIM1初始化操作
 * 形参: 无
 * 返回: 无
 * 说明: 无 
 ******************************************************************************/
void Tim1_Init(void)
{
  	/* 初始化TIM1为外部时钟24分频 向上计数模式 计数周期1000 计数初始值0 -- 1ms进一次中断*/
	TIM1_TimeBaseInit(15, TIM1_COUNTERMODE_UP, 999, 0);
	TIM1_SetCounter(0);/* 将计数器初值设为0 */
	TIM1_ARRPreloadConfig(DISABLE);	/* 预装载不使能 */
	TIM1_ITConfig(TIM1_IT_UPDATE , ENABLE);	/* 计数器向上计数/向下计数溢出更新中断 */
	TIM1_Cmd(ENABLE);			/* 使能TIM1 */
}

/*******************************************************************************
 * 名称: TimingDelay_Decrement
 * 功能: 延时计数变量自减操作
 * 形参: 无
 * 返回: 无
 * 说明: 无 
 ******************************************************************************/
void TimingDelay_Decrement(void)
{
	static u16 sys_10ms_cnt=0;
	static u16 sys_20ms_cnt=0;
	static u16 sys_50ms_cnt=0;
	static u16 sys_100ms_cnt=0;
	static u16 sys_200ms_cnt=0;
	static u16 sys_500ms_cnt=0;
	static u16 sys_1000ms_cnt=0;
	
//--------for delay 1ms--	
	TimingDelay--;
	
//-----------sys 1ms cnt------
	sys_10ms_cnt++;
	sys_20ms_cnt++;
	sys_50ms_cnt++;
	sys_100ms_cnt++;
	sys_200ms_cnt++;
	sys_500ms_cnt++;
	sys_1000ms_cnt++;
	//for 10ms cyc
	if(sys_10ms_cnt>10)
	{
		sys_10ms_cnt=0;
		Sys_10ms_Flag=1;
	}
	//for 20ms cyc
	if(sys_20ms_cnt>20){
		sys_20ms_cnt=0;
		Sys_20ms_Flag=1;
	}
	//for 50ms cyc
	if(sys_50ms_cnt>50){
		sys_50ms_cnt=0;
		Sys_50ms_Flag=1;
	}
	//for 100ms cyc
	if(sys_100ms_cnt>100){
		sys_100ms_cnt=0;
		Sys_100ms_Flag=1;
	}
	//for 200ms cyc 
	if(sys_200ms_cnt>200){
		sys_200ms_cnt=0;
		Sys_200ms_Flag=1;
	}
	//for 500ms cyc
	if(sys_500ms_cnt>500){
		sys_500ms_cnt=0;
		Sys_500ms_Flag=1;
	}
	//for 1000ms cyc
	if(sys_1000ms_cnt>1000){
		sys_1000ms_cnt=0;
		Sys_1000ms_Flag=1;
	}

}
/*******************************************************************************
 * 名称: delay_ms
 * 功能: 利用TIM1产生的1ms中断来计时
 * 形参: nms -> 计时值(ms)
 * 返回: 无
 * 说明: 无 
 ******************************************************************************/
void delay_ms(u16 nTime)
{
	TimingDelay = nTime;
	
	while(0 != TimingDelay)
	  	;
}