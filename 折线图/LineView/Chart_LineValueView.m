//
//  Chart_LineValueView.m
//  折线图
//
//  Created by MyMac on 16/8/18.
//  Copyright © 2016年 tongfang. All rights reserved.
//
#import "Chart_LineValueView.h"
#import "ChartConst.h"
static CGFloat const radius=3.0;
@interface Chart_LineValueView()
{
    CGFloat xAxleInterval;
    CGRect chart_OriginalFrame;
    CGFloat _lineMaxHeight;
}
/**
 *  点的位置
 */
@property(nonatomic,strong)NSMutableArray*point_Place;
@property(nonatomic,strong)NSMutableParagraphStyle*paragraphStyle;
@end
@implementation Chart_LineValueView
-(instancetype)initWithFrame:(CGRect)frame{
    if (self=[super initWithFrame:frame]) {
        self.backgroundColor=[UIColor clearColor];
        UITapGestureRecognizer*tap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(linePointClick:)];
        [self addGestureRecognizer:tap];
        [self addObserver:self forKeyPath:@"frame" options:NSKeyValueObservingOptionNew|NSKeyValueObservingOptionOld context:nil];

    }
    return self;
}
-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context{
    CGRect new=[change[NSKeyValueChangeNewKey] CGRectValue];
    _lineMaxHeight=CGRectGetHeight(new)-bottom_edge-line_w;
    xAxleInterval=CGRectGetWidth(new)/(_x_tickMarkData.count-1);

        [self setNeedsDisplay];
    
}

-(void)drawRect:(CGRect)rect{
    self.valueTextColor=self.valueTextColor?self.valueTextColor:[UIColor blackColor];
    CGContextRef ctf=UIGraphicsGetCurrentContext();
    CGContextSetLineWidth(ctf, line_w);
    [self drawXAxleLine:ctf];
    [self drawLineValue:ctf];
}
//绘制x轴线
-(void)drawXAxleLine:(CGContextRef)ctf{
    CGContextMoveToPoint(ctf, 0,line_w/2.0);
    CGContextAddLineToPoint(ctf, CGRectGetWidth(self.frame),line_w/2.0);
    CGContextDrawPath(ctf, kCGPathStroke);
}
//绘制折线
-(void)drawLineValue:(CGContextRef)ctf{
    [self.point_Place removeAllObjects];
    for (NSUInteger i=0; i<self.values.count; i++) {
        NSArray*lineValue=self.values[i];
        NSMutableArray*points=[NSMutableArray array];
        CGContextSetStrokeColorWithColor(ctf, self.lineColor[i].CGColor);
        for (NSUInteger j=0; j<lineValue.count; j++) {
            NSNumber*value=lineValue[j];
            CGFloat x=j*xAxleInterval;
            CGFloat h=rand()%99;
            if ([self.delegate respondsToSelector:@selector(chart_LineValueView:lineHeightFromValue:)]) {
                h=[self.delegate chart_LineValueView:self lineHeightFromValue:value];
            }
            CGFloat y=CGRectGetHeight(self.frame)-h-bottom_edge-line_w;
            if (j==0) {
                CGContextMoveToPoint(ctf, x, y);
            }else{
                CGContextAddLineToPoint(ctf, x, y);
            }
            [points addObject:[NSValue valueWithCGPoint:CGPointMake(x, y)]];

        [[NSString stringWithFormat:@"%@",value] drawInRect:CGRectMake(x-xAxleInterval/2.0, y-15, xAxleInterval, 15) withAttributes:@{NSForegroundColorAttributeName:self.valueTextColor,NSFontAttributeName:Text_Font,NSParagraphStyleAttributeName:self.paragraphStyle}];
        }
        [self.point_Place addObject:points];
        CGContextDrawPath(ctf, kCGPathStroke);
    }
    for (NSUInteger m=0; m<self.point_Place.count; m++) {
        CGContextSetFillColorWithColor(ctf,m+1<=self.pointColor.count?self.pointColor[m].CGColor:[UIColor whiteColor].CGColor);
        NSMutableArray*points=self.point_Place[m];
        for (NSUInteger k=0; k<points.count; k++) {
        CGPoint p=[points[k] CGPointValue];
        CGContextAddEllipseInRect(ctf,CGRectMake(p.x-radius, p.y-radius, 2*radius, 2*radius));
        }
        CGContextDrawPath(ctf, kCGPathFill);
    }
}
-(void)setOriginalFrame:(CGRect)originalFrame{
    chart_OriginalFrame=originalFrame;
    self.frame=originalFrame;
     xAxleInterval=CGRectGetWidth(originalFrame)/(_x_tickMarkData.count-1);
    _lineMaxHeight=CGRectGetHeight(originalFrame)-bottom_edge-line_w;
}
-(void)setX_tickMarkData:(NSArray<NSString *> *)x_tickMarkData{
    _x_tickMarkData=x_tickMarkData;
    xAxleInterval=CGRectGetWidth(self.frame)/(_x_tickMarkData.count-1);
}
-(NSMutableArray*)point_Place{
    if (!_point_Place) {
        _point_Place=[NSMutableArray array];
    }
    return _point_Place;
}
-(void)linePointClick:(UITapGestureRecognizer*)tap{
    for (NSUInteger i=0; i<self.point_Place.count; i++) {
        NSMutableArray*points=self.point_Place[i];
        for (NSUInteger j=0; j<points.count; j++) {
            CGPoint p=[points[j] CGPointValue];
            CGRect pF=CGRectMake(p.x-radius, p.y-radius, 2*radius, 2*radius);
            if (CGRectContainsPoint(CGRectMake(p.x-radius, p.y-radius, 2*radius, 2*radius),[tap locationInView:tap.view])) {
                if ([self.delegate respondsToSelector:@selector(chart_LineValueView:didSelectForType:index:xValue:yValue:pointFrame:)]) {
                    [self.delegate chart_LineValueView:self didSelectForType:i index:j xValue:self.x_tickMarkData[j] yValue:self.values[i][j] pointFrame:pF];
                    return;
                }
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
