//
//  Chart_BarValueView.h
//  折线图
//
//  Created by MyMac on 16/8/16.
//  Copyright © 2016年 tongfang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Chart_ValueBaseView.h"
@class Chart_BarValueView;
@protocol Chart_BarValueViewDelegate <NSObject>
@required
/**
 *  bar的frame高度
 *
 *  @param barView  
 *  @param barValue bar对应的实际值
 *
 *  @return
 */
-(CGFloat)chart_BarValueView:(Chart_BarValueView*)barView barHeightFromValue:(NSNumber*)barValue;
/**
 *  点击bar时响应
 *
 *  @param barView
 *  @param index   bar所对应的值在values的索引
 *  @param yValue   bar所对应的值
    @param xValeu   x轴的值
    @param frame   bar在chart_BarValueView的位置
 */
-(void)chart_BarValueView:(Chart_BarValueView*)barView didSelectedAtIndex:(NSUInteger)index xValue:(NSString*)xValeu yValue:(NSNumber*)yValue barFrame:(CGRect)frame;
@end
@interface Chart_BarValueView : Chart_ValueBaseView
/**
 *  柱状图的值
 */
@property(nonatomic,strong)NSArray<NSNumber*>*values;
/**
 *  柱的颜色
 */
@property(nonatomic,strong)UIColor*barColor;
/**
 *  x轴的刻度值
 */
@property(nonatomic,strong)NSArray<NSString*>*x_tickMarkData;
/**
 *  柱标注文本颜色
 */
@property(nonatomic,strong)UIColor*textColor;

/**
 *  柱所能设定的最大frame高度
 */
@property(nonatomic,assign,readonly)CGFloat  maxHeight;
@property(nonatomic,weak)id<Chart_BarValueViewDelegate>delegate;
-(instancetype)initWithFrame:(CGRect)frame;

@end
