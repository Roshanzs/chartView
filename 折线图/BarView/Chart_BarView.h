//
//  Chart_BarView.h
//  折线图
//
//  Created by MyMac on 16/8/17.
//  Copyright © 2016年 tongfang. All rights reserved.
//

#import <UIKit/UIKit.h>
@class Chart_BarView;
@protocol Chart_BarViewDelegate <NSObject>
/**
 *  <#Description#>
 *
 *  @param chartBarView <#chartBarView description#>
 *  @param index        <#index description#>
 *  @param xValue       <#xValue description#>
 *  @param yValue       <#yValue description#>
 *  @param barFrame     bar相对于Chart_BarView的frame
 */
-(void)chartBarView:(Chart_BarView*)chartBarView didSelectedBarAtIndex:(NSUInteger)index xValue:(NSString*)xValue yValue:(NSNumber*)yValue barFrame:(CGRect)barFrame;
@end
@interface Chart_BarView : UIView
#pragma -mark 柱相关属性
/**
 *  柱状图的值
 */
@property(nonatomic,strong)NSArray<NSNumber*>*values;
/**
 *  柱的颜色
 */

@property(nonatomic,strong)UIColor*barColor;



#pragma -mark x轴相关属性
/**
 *  x轴的刻度值
 */
@property(nonatomic,strong)NSArray<NSString*>*x_tickMarkData;
/**
 *  柱的标注文本颜色
 */
@property(nonatomic,strong)UIColor*tickMarkTextColor;



#pragma -mark y轴相关属性
/**
 *  y轴左边线的颜色
 */
@property(nonatomic,strong)UIColor*left_lineColor;
/**
 *  y轴右边线的颜色
 */
@property(nonatomic,strong)UIColor*right_lineColor;
/**
 *  y轴左边刻度标注颜色
 */
@property(nonatomic,strong)UIColor*left_textColor;
/**
 *  y轴右边刻度标注颜色
 */
@property(nonatomic,strong)UIColor*right_textColor;
/**
 *  刻度横线的颜色
 */
@property(nonatomic,strong)UIColor*tickMarkColor;
/**
 *  y轴左边刻度数据源 数值从大到小排列
 */
@property(nonatomic,strong)NSArray<NSNumber*>*left_data;
/**
 *  y轴右边刻度数据源 数值从大到小排列
 */
@property(nonatomic,strong)NSArray<NSNumber*>*right_data;
/**
 *  刻度单位
 */
@property(nonatomic,strong)NSString*suffix;


@property(nonatomic,weak)id<Chart_BarViewDelegate>delegate;
-(instancetype)initWithFrame:(CGRect)frame;
-(void)showInView:(UIView*)view;
@end
