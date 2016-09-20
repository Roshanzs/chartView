//
//  Chart_xAxleContainerView.h
//  折线图
//
//  Created by MyMac on 16/8/18.
//  Copyright © 2016年 tongfang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Chart_xAxleValueView.h"
@interface Chart_xAxleContainerView : UIScrollView
@property(nonatomic,strong)Chart_xAxleValueView*x_valueView;
@end
