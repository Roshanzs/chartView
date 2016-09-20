//
//  ChartBarValueContainerView.h
//  折线图
//
//  Created by MyMac on 16/8/16.
//  Copyright © 2016年 tongfang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Chart_BarValueView.h"
#import "ChartValueContainerBaseView.h"
@interface ChartBarValueContainerView : ChartValueContainerBaseView
@property(nonatomic,strong)Chart_BarValueView*barValueView;
@end
