//
//  Chart_AxleView.h
//  折线图
//
//  Created by MyMac on 16/8/15.
//  Copyright © 2016年 tongfang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Chart_AxleView : UIView
@property(nonatomic,strong)UIColor*left_lineColor;
@property(nonatomic,strong)UIColor*right_lineColor;
@property(nonatomic,strong)UIColor*left_textColor;
@property(nonatomic,strong)UIColor*right_textColor;
@property(nonatomic,strong)UIColor*tickMarkColor;
@property(nonatomic,strong)NSArray<NSNumber*>*left_data;
@property(nonatomic,strong)NSArray<NSNumber*>*right_data;
/**
 *  刻度单位
 */
@property(nonatomic,strong)NSString*suffix;
-(instancetype)initWithFrame:(CGRect)frame;
-(void)setOriginalFrame:(CGRect)originalFrame;
@end


