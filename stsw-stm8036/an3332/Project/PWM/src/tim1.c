/******************** (C) COPYRIGHT  ���iCreateǶ��ʽ���������� **************
 * �ļ���  ��tim.c
 * ����    ��STM8--TIM1ģ�����ú���   
 * ʵ��ƽ̨�����STM8������
 * ��汾  ��V2.1.0
 * ����    �����  QQ��779814207
 * ����    ��
 * �Ա�    ��http://shop71177993.taobao.com/
 * �޸�ʱ�� ��2012-10-30

  ���STM8������Ӳ������
    |--------------------|
    |  LED1-PD0          |
    |  LED2-PD1          |
    |  LED3-PD2          |
    |  LED4-PD3          |
    |--------------------|

*******************************************************************************/

/* ����ϵͳͷ�ļ� */

/* �����Զ���ͷ�ļ� */
#include "tim1.h"

/* �Զ��������� */

/* �Զ���� */

/* ȫ�ֱ������� */
u16 TimingDelay; 

__IO u8 Sys_10ms_Flag=0;
__IO u8 Sys_20ms_Flag=0;
__IO u8 Sys_50ms_Flag=0;
__IO u8 Sys_100ms_Flag=0;
__IO u8 Sys_200ms_Flag=0;
__IO u8 Sys_500ms_Flag=0;
__IO u8 Sys_1000ms_Flag=0;

/*******************************************************************************
 * ����: Tim1_Init
 * ����: TIM1��ʼ������
 * �β�: ��
 * ����: ��
 * ˵��: �� 
 ******************************************************************************/
void Tim1_Init(void)
{
  	/* ��ʼ��TIM1Ϊ�ⲿʱ��24��Ƶ ���ϼ���ģʽ ��������1000 ������ʼֵ0 -- 1ms��һ���ж�*/
	TIM1_TimeBaseInit(15, TIM1_COUNTERMODE_UP, 999, 0);
	TIM1_SetCounter(0);/* ����������ֵ��Ϊ0 */
	TIM1_ARRPreloadConfig(DISABLE);	/* Ԥװ�ز�ʹ�� */
	TIM1_ITConfig(TIM1_IT_UPDATE , ENABLE);	/* ���������ϼ���/���¼�����������ж� */
	TIM1_Cmd(ENABLE);			/* ʹ��TIM1 */
}

/*******************************************************************************
 * ����: TimingDelay_Decrement
 * ����: ��ʱ���������Լ�����
 * �β�: ��
 * ����: ��
 * ˵��: �� 
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
 * ����: delay_ms
 * ����: ����TIM1������1ms�ж�����ʱ
 * �β�: nms -> ��ʱֵ(ms)
 * ����: ��
 * ˵��: �� 
 ******************************************************************************/
void delay_ms(u16 nTime)
{
	TimingDelay = nTime;
	
	while(0 != TimingDelay)
	  	;
}