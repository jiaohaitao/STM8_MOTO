
/******************** (C) COPYRIGHT  风驰iCreate嵌入式开发工作室 **************
 * 文件名  ：adc.h
 * 描述    ：adc2设置文件   
 * 实验平台：风驰STM8开发板
 * 库版本  ：V2.1.0
 * 作者    ：风驰  QQ：779814207
 * 博客    ：
 * 淘宝    ：http://shop71177993.taobao.com/
 *修改时间 ：2012-11-18

  风驰STM8开发板硬件连接
    |-------------------------------|
    |  光敏/热敏 - PF0(Adc2->CH10)  |
    |-------------------------------|

*******************************************************************************/

#ifndef __ADC_H
#define __ADC_H

/* 包含系统头文件 */


/* 包含自定义头文件 */
#include "stm8s.h"

/* 自定义新类型 */

/* 自定义宏 */

/* 全局变量定义 */

/**************************************************************************
 * 函数名：Send_ADC_Value
 * 描述  ：ADC转换结果显示函数
 * 输入  ：AD_Value--ADC转换结果值
 *
 * 输出  ：无
 * 返回  ：无 
 * 调用  ：内部调用 
 *************************************************************************/
void ADC_Init(void);
void Send_ADC_Value(u16 AD_Value);
void MultipleChannelGetADValue(void);
uint16_t OneChannelGetADValue(ADC1_Channel_TypeDef ADC1_Channel,\
                                     ADC1_SchmittTrigg_TypeDef ADC1_SchmittTriggerChannel);

#endif