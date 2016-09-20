//
//  Chart_LineValueView.h
//  折线图
//
//  Created by MyMac on 16/8/18.
//  Copyright © 2016年 tongfang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Chart_ValueBaseView.h"

@class Chart_LineValueView;
@protocol Chart_LineValueViewDelegate <NSObject>
@required;
-(CGFloat)chart_LineValueView:(Chart_LineValueView*)chart_LineValueView lineHeightFromValue:(NSNumber*)barValue;
/**
 *  点击线上的点的回调,value都是从type 和 index一一从values和x_tickMarkData获取到的
 *
 *  @param chart_LineValueView
 *  @param type                哪条线，与values的元素的位置一一对应
 *  @param index               哪个点，与values的元素数组中的元素一一对应
 *  @param xValue              x轴的值，从x_tickMarkData的元素位置获取
 *  @param yValue              y轴的值，从values的元素数组中的元素获取
    pointFrame 点的位置
 */
-(void)chart_LineValueView:(Chart_LineValueView*)chart_LineValueView didSelectForType:(NSUInteger)type index:(NSUInteger)index  xValue:(NSString*)xValue yValue:(NSNumber*)yValue pointFrame:(CGRect)pointFrame;
@end
@interface Chart_LineValueView : Chart_ValueBaseView
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
/**
 *  点上文本标注颜色
 */
@property(nonatomic,strong)UIColor*valueTextColor;
/**
 *  线所能达到的frame最大高度
 */
@property(nonatomic,assign,readonly)CGFloat lineMaxHeight;

@property(nonatomic,strong)NSArray<NSString*>*x_tickMarkData;

@property(nonatomic,weak) id <Chart_LineValueViewDelegate>delegate;

@end
