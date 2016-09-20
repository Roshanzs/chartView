//
//  ChartAxleContainerView.h
//  折线图
//
//  Created by MyMac on 16/8/16.
//  Copyright © 2016年 tongfang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Chart_AxleView.h"
#import "ChartValueContainerBaseView.h"
#import "ChartPinchGestureRecognizer.h"
@class ChartAxleContainerView;
@protocol ChartAxleContainerViewDelegate <NSObject>
@required;
-(void)chartAxleContainerView:(nonnull ChartAxleContainerView*)chartAxleContainerView pinchGesture:(nonnull ChartPinchGestureRecognizer*)pin;
@end
@interface ChartAxleContainerView : UIScrollView
@property(nonnull,nonatomic,strong)Chart_AxleView*chart;
@property(nonnull,nonatomic,strong)ChartValueContainerBaseView*valueContainerView;
@property(nullable,nonatomic,weak)id<ChartAxleContainerViewDelegate>interactiveDelegate;

-(nonnull instancetype)initWithFrame:(CGRect)frame;

@end
