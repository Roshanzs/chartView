//
//  Chart_LineView.h
//  折线图
//
//  Created by MyMac on 16/8/19.
//  Copyright © 2016年 tongfang. All rights reserved.
//

#import <UIKit/UIKit.h>
@class Chart_LineView;
@protocol Chart_LineViewDelegate <NSObject>
-(void)chart_LineView:(Chart_LineView*)chart_LineView didSelectForType:(NSUInteger)type index:(NSUInteger)index  xValue:(NSString*)xValue yValue:(NSNumber*)yValue pointFrame:(CGRect)pointFrame;
@end
@interface Chart_LineView : UIView
#pragma -mark 线相关属性

/**
 *  线的数组，有多少条线就有多少个数组
 */
@property(nonatomic,strong)NSArray<NSArray<NSNumber*>*>*values;
/**
 *  折线的颜色，个数与values的count相同
 */
@property(nonatomic,strong)NSArray<UIColor*>*lineColor;
/**
 *  折线上点的颜色，个数与values的count相同
 */
@property(nonatomic,strong)NSArray<UIColor*>*pointColor;


#pragma -mark x轴相关属性
@property(nonatomic,strong)UIColor*barColor;
/**
 *  x轴的刻度值
 */
@property(nonatomic,strong)NSArray<NSString*>*x_tickMarkData;
/**
 *  标注文本颜色
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

@property(nonatomic,weak)id<Chart_LineViewDelegate>delegate;
-(instancetype)initWithFrame:(CGRect)frame;
-(void)showInView:(UIView*)view;
@end
