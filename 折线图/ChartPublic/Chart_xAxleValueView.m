//
//  Chart_xAxleValueView.m
//  折线图
//
//  Created by MyMac on 16/8/18.
//  Copyright © 2016年 tongfang. All rights reserved.
//

#import "Chart_xAxleValueView.h"
#import "ChartConst.h"
@interface Chart_xAxleValueView()
{
    CGFloat bar_Width;
    CGFloat line_Interval;
}
@property(nonatomic,strong)NSMutableParagraphStyle*paragraphStyle;
@end
@implementation Chart_xAxleValueView
-(void)drawRect:(CGRect)rect{
    self.textColor=self.textColor?self.textColor:[UIColor blackColor];
        for (NSUInteger i=0; i<self.x_tickMarkData.count; i++) {
            NSString* x_tickMark=self.x_tickMarkData[i];
            CGFloat w=self.chartType==ChartTypeBar?bar_Width:line_Interval;
            CGFloat x=self.chartType==ChartTypeBar?bar_interval+(bar_Width+bar_interval)*i:i*w-w/2.0;
            if (i==0) {
                x=x+5;
            }else if (i==self.x_tickMarkData.count-1){
                x=x-5;
            }
            CGFloat y=1;
            CGFloat h=CGRectGetHeight(self.frame)-y;
            
            [x_tickMark drawInRect:CGRectMake(x, y, w, h) withAttributes:@{NSForegroundColorAttributeName:self.textColor,NSFontAttributeName:Text_Font,NSParagraphStyleAttributeName:self.paragraphStyle}];
        }
}
-(instancetype)initWithFrame:(CGRect)frame{
    if (self=[super initWithFrame:frame]) {
        self.backgroundColor=[UIColor clearColor];
        [self addObserver:self forKeyPath:@"frame" options:NSKeyValueObservingOptionNew|NSKeyValueObservingOptionOld context:nil];
    }
    return self;

}
-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context{
    CGRect new=[change[NSKeyValueChangeNewKey] CGRectValue];
    bar_Width=(CGRectGetWidth(new)-(self.x_tickMarkData.count+1)*bar_interval)/self.x_tickMarkData.count;
    line_Interval=CGRectGetWidth(new)/(self.x_tickMarkData.count-1);
    [self setNeedsDisplay];

}
-(NSMutableParagraphStyle*)paragraphStyle{
    if (!_paragraphStyle) {
        _paragraphStyle=[[NSMutableParagraphStyle alloc]init];
        _paragraphStyle.alignment=NSTextAlignmentCenter;
        
    }
    return _paragraphStyle;
    
}
-(void)dealloc{

    [self removeObserver:self forKeyPath:@"frame"];
}
@end
