//
//  ChartBarValueContainerView.m
//  折线图
//
//  Created by MyMac on 16/8/16.
//  Copyright © 2016年 tongfang. All rights reserved.
//

#import "ChartBarValueContainerView.h"
#import "ChartConst.h"
@interface ChartBarValueContainerView()
{
    CGRect originalFrame;
}

@end
@implementation ChartBarValueContainerView
-(instancetype)initWithFrame:(CGRect)frame{
    if (self=[super initWithFrame:frame]) {
        self.showsHorizontalScrollIndicator=NO;
        self.showsVerticalScrollIndicator=NO;
        self.contentSize=frame.size;
        self.pinchGestureRecognizer.enabled=NO;
        self.bounces=NO;
        
        self.backgroundColor=[UIColor clearColor];
       [self addObserver:self forKeyPath:@"contentSize" options:NSKeyValueObservingOptionNew|NSKeyValueObservingOptionOld context:nil];
        [self addObserver:self forKeyPath:@"frame" options:NSKeyValueObservingOptionNew|NSKeyValueObservingOptionOld context:nil];

    }
    return self;
}
-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context{
    if ([keyPath isEqualToString:@"contentSize"]) {
        CGSize new=[change[NSKeyValueChangeNewKey] CGSizeValue];

        [self changeBarValueFrame:CGRectMake(0, 0, new.width,new.height)];

    }else if ([keyPath isEqualToString:@"frame"]){
        CGRect new=[change[NSKeyValueChangeNewKey] CGRectValue];

        [self changeBarValueFrame:CGRectMake(0, 0, new.size.width, self.frame.size.height)];
    
    }
}
-(void)changeBarValueFrame:(CGRect)frame{

    self.barValueView.frame=frame;
}
-(void)setOriginalFrame:(CGRect)frame{
    originalFrame=frame;
    self.contentSize=frame.size;
    self.frame=originalFrame;
    [_barValueView setOriginalFrame:CGRectMake(0, 0, self.contentSize.width, self.contentSize.height)];
}
-(void)setBarValueView:(Chart_BarValueView *)barValueView{
    _barValueView=barValueView;
    [self addSubview:_barValueView];
}
-(void)dealloc{
    [self removeObserver:self forKeyPath:@"contentSize"];
    [self removeObserver:self forKeyPath:@"frame"];
}
@end
