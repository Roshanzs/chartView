//
//  Chart_BarValueView.m
//  折线图
//
//  Created by MyMac on 16/8/16.
//  Copyright © 2016年 tongfang. All rights reserved.
//
#import "ChartConst.h"
#import "Chart_BarValueView.h"

@interface Chart_BarValueView()
{
    CGFloat bar_Width;//bar的宽
    CGRect chart_OriginalFrame;
    BOOL firstUpdate;
    CGFloat _maxHeight;
    
}
@property(nonatomic,strong)NSMutableArray<NSValue*>*bar_Place;
@property(nonatomic,strong)  NSMutableParagraphStyle*paragraphStyle;

@end
@implementation Chart_BarValueView
-(void)drawRect:(CGRect)rect{
    CGContextRef ctf=UIGraphicsGetCurrentContext();
    CGContextSetLineWidth(ctf, line_w);
    [self.bar_Place removeAllObjects];
    [self drawXAxle:ctf];
    [self drawBarValue:ctf];
}

-(instancetype)initWithFrame:(CGRect)frame{
    if (self=[super initWithFrame:frame]) {
        self.backgroundColor=[UIColor clearColor];
        firstUpdate=YES;
        _maxHeight=CGRectGetHeight(frame)-bottom_edge-line_w;
        [self addObserver:self forKeyPath:@"frame" options:NSKeyValueObservingOptionNew|NSKeyValueObservingOptionOld context:nil];
        UITapGestureRecognizer*tap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(barClick:)];
        [self addGestureRecognizer:tap];
    }
    return self;

}
-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context{
    CGRect new=[change[NSKeyValueChangeNewKey] CGRectValue];
    CGRect old=[change[NSKeyValueChangeOldKey] CGRectValue];
    _maxHeight=CGRectGetHeight(self.frame)-bottom_edge-line_w;
    if (CGRectEqualToRect(new, old)==NO) {
    bar_Width=(CGRectGetWidth(new)-(self.x_tickMarkData.count+1)*bar_interval)/self.x_tickMarkData.count;
        firstUpdate=NO;
        [self setNeedsDisplay];
    }
}
-(void)drawBarValue:(CGContextRef)ctf{
    CGContextSetFillColorWithColor(ctf, self.barColor.CGColor);
    CGContextSaveGState(ctf);
    for (NSUInteger i=0; i<self.values.count; i++) {
        NSNumber*value=self.values[i];
        CGFloat x=bar_interval+(bar_Width+bar_interval)*i;
        CGFloat h=random()%100;
        if ([self.delegate respondsToSelector:@selector(chart_BarValueView:barHeightFromValue:)]) {
            h=[self.delegate chart_BarValueView:self barHeightFromValue:self.values[i]];
        }
        CGFloat y=CGRectGetHeight(self.frame)-h-bottom_edge-line_w;
        CGFloat w=bar_Width;
        [self.bar_Place addObject:[NSValue valueWithCGRect:CGRectMake(x, y, w, h)]];
        [[NSString stringWithFormat:@"%@",value] drawInRect:CGRectMake(x, y-15, w, 15) withAttributes:@{NSForegroundColorAttributeName:self.textColor,NSFontAttributeName:Text_Font,NSParagraphStyleAttributeName:self.paragraphStyle}];
        CGContextSetFillColorWithColor(ctf, self.barColor.CGColor);
        CGContextAddRect(ctf, CGRectMake(x, y, w, h));

    }
        CGContextDrawPath(ctf, kCGPathFill);
}
-(void)drawXAxle:(CGContextRef)ctf{

    CGContextMoveToPoint(ctf, 0, CGRectGetHeight(self.frame)-bottom_edge-(firstUpdate?line_w:line_w/2.0));
    CGContextAddLineToPoint(ctf, CGRectGetWidth(self.frame), CGRectGetHeight(self.frame)-bottom_edge-(firstUpdate?line_w:line_w/2.0));
    CGContextDrawPath(ctf, kCGPathStroke);


}
-(NSMutableArray*)bar_Place{
    if (!_bar_Place) {
        _bar_Place=[NSMutableArray array];
    }
    return _bar_Place;


}
-(void)setOriginalFrame:(CGRect)originalFrame{
    chart_OriginalFrame=originalFrame;
    self.frame=originalFrame;
    _maxHeight=CGRectGetHeight(originalFrame)-bottom_edge-line_w;
}

-(void)setX_tickMarkData:(NSArray<NSString *> *)x_tickMarkData{
    _x_tickMarkData=x_tickMarkData;
    bar_Width=(CGRectGetWidth(chart_OriginalFrame)-(_x_tickMarkData.count+1)*bar_interval)/_x_tickMarkData.count;
    
}
-(void)barClick:(UITapGestureRecognizer*)tap{
    CGPoint location=[tap locationInView:tap.view];
    for (NSUInteger i=0; i<self.bar_Place.count; i++) {
        CGRect bar_location=[self.bar_Place[i] CGRectValue];
      bool ret=  CGRectContainsPoint(bar_location, location);
        if (ret) {
            if ([self.delegate respondsToSelector:@selector(chart_BarValueView:didSelectedAtIndex:xValue:yValue:barFrame:)]) {
                [self.delegate chart_BarValueView:self didSelectedAtIndex:i xValue:self.x_tickMarkData[i] yValue:self.values[i] barFrame:bar_location];
                return;
            }
        }
    }



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
