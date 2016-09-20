//
//  ChartLineValueContainerView.m
//  折线图
//
//  Created by MyMac on 16/8/19.
//  Copyright © 2016年 tongfang. All rights reserved.
//

#import "ChartLineValueContainerView.h"
@interface ChartLineValueContainerView()
{
    CGRect originalFrame;
    
}

@end
@implementation ChartLineValueContainerView
-(instancetype)initWithFrame:(CGRect)frame{
    if (self=[super initWithFrame:frame]) {
        self.showsHorizontalScrollIndicator=NO;
        self.showsVerticalScrollIndicator=NO;
        self.pinchGestureRecognizer.enabled=NO;
        self.bounces=NO;
        originalFrame=frame;
        self.contentSize=frame.size;
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
    self.lineValueView.frame=frame;
}
-(void)setLineValueView:(Chart_LineValueView *)lineValueView{
    _lineValueView=lineValueView;
    [_lineValueView setOriginalFrame:CGRectMake(0, 0, self.contentSize.width, self.contentSize.height)];
    [self addSubview:_lineValueView];
}
-(void)setOriginalFrame:(CGRect)frame{
    originalFrame=frame;
    self.contentSize=frame.size;
    self.frame=originalFrame;
    [_lineValueView setOriginalFrame:CGRectMake(0, 0, self.contentSize.width, self.contentSize.height)];
}

-(void)dealloc{
    [self removeObserver:self forKeyPath:@"contentSize"];
    [self removeObserver:self forKeyPath:@"frame"];
}

@end
