//
//  Chart_xAxleContainerView.m
//  折线图
//
//  Created by MyMac on 16/8/18.
//  Copyright © 2016年 tongfang. All rights reserved.
//

#import "Chart_xAxleContainerView.h"

@implementation Chart_xAxleContainerView
-(void)setX_valueView:(Chart_xAxleValueView *)x_valueView{
    _x_valueView=x_valueView;
    _x_valueView.frame=self.bounds;
    [self addSubview:_x_valueView];
}
-(instancetype)initWithFrame:(CGRect)frame{
    if (self=[super initWithFrame:frame]) {
        self.backgroundColor=[UIColor clearColor];
        self.showsHorizontalScrollIndicator=NO;
        self.showsVerticalScrollIndicator=NO;
        self.bounces=NO;
        self.multipleTouchEnabled=YES;
        [self addObserver:self forKeyPath:@"contentSize" options:NSKeyValueObservingOptionNew|NSKeyValueObservingOptionOld context:nil];
    }
    return self;
}
-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context{
    CGSize new=[change[NSKeyValueChangeNewKey] CGSizeValue];
    self.x_valueView.frame=CGRectMake(CGRectGetMinX(self.x_valueView.frame), CGRectGetMinY(self.x_valueView.frame), new.width, CGRectGetHeight(self.x_valueView.frame));
  

}
-(void)dealloc{
    [self removeObserver:self forKeyPath:@"contentSize"];
}
@end
