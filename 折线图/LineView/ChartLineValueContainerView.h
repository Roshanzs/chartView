//
//  ChartLineValueContainerView.h
//  折线图
//
//  Created by MyMac on 16/8/19.
//  Copyright © 2016年 tongfang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Chart_LineValueView.h"
#import "ChartValueContainerBaseView.h"
@interface ChartLineValueContainerView : ChartValueContainerBaseView
@property(nonatomic,strong)Chart_LineValueView*lineValueView;
-(instancetype)initWithFrame:(CGRect)frame;
@end
