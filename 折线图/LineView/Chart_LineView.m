//
//  Chart_LineView.m
//  折线图
//
//  Created by MyMac on 16/8/19.
//  Copyright © 2016年 tongfang. All rights reserved.
//
#import "ChartConst.h"
#import "Chart_LineView.h"
#import "Chart_AxleView.h"
#import "ChartAxleContainerView.h"

#import "Chart_LineValueView.h"
#import "ChartLineValueContainerView.h"


#import "Chart_xAxleContainerView.h"
#import "Chart_xAxleValueView.h"
@interface Chart_LineView()<ChartAxleContainerViewDelegate,Chart_LineValueViewDelegate>
{
    CGFloat vertical_end_scale;
}
//y轴
@property(strong,nonatomic)Chart_AxleView*axle;
@property(nonatomic,strong)ChartAxleContainerView*axleContainer;

//值
@property(nonatomic,strong)Chart_LineValueView*line;
@property(nonatomic,strong)ChartLineValueContainerView*lineContainer;

//x轴
@property(nonatomic,strong)Chart_xAxleContainerView*xAxleContainer;
@property(nonatomic,strong)Chart_xAxleValueView*xAxle;

@end
@implementation Chart_LineView
-(instancetype)initWithFrame:(CGRect)frame{
    if (self=[super initWithFrame:frame]) {
        vertical_end_scale=1.0;
        self.axleContainer=[[ChartAxleContainerView alloc]initWithFrame:self.bounds];
        self.axleContainer.interactiveDelegate=self;
        self.axle=[[Chart_AxleView alloc]initWithFrame:self.bounds];
        
        
        self.line=[[Chart_LineValueView alloc]initWithFrame:CGRectMake(0, 0, 0, 0)];
        self.line.delegate=self;
        self.lineContainer=[[ChartLineValueContainerView alloc]initWithFrame:CGRectMake(10, 10, self.bounds.size.width-20, 400)];
        
        self.xAxleContainer=[[Chart_xAxleContainerView alloc]initWithFrame:CGRectZero];
        self.xAxle=[[Chart_xAxleValueView alloc]initWithFrame:CGRectZero];
        

    }
    return self;
}
-(void)showInView:(UIView*)view{
    self.axle.left_data=self.left_data;
    self.axle.right_data=self.right_data;
    
    self.axle.suffix=self.suffix;
    
    self.axle.left_lineColor=self.left_lineColor;
    self.axle.right_lineColor=self.right_lineColor;
    
    self.axle.tickMarkColor=self.tickMarkColor;
    
    self.axle.left_textColor=self.left_textColor;
    self.axle.right_textColor=self.right_textColor;
    
  
    
    self.line.x_tickMarkData=self.x_tickMarkData;
    self.line.values=self.values;
    self.line.valueTextColor=self.tickMarkTextColor;
    self.line.lineColor=self.lineColor;
    self.line.pointColor=self.pointColor;
    
    
    self.lineContainer.lineValueView=self.line;
    
    self.axleContainer.chart=self.axle;
    self.axleContainer.valueContainerView=self.lineContainer;
    
    
    self.xAxleContainer.frame=CGRectMake(CGRectGetMinX(self.lineContainer.frame),0, CGRectGetWidth(self.lineContainer.frame),top_edge-1);
    self.xAxle.x_tickMarkData=self.x_tickMarkData;
    self.xAxle.chartType=ChartTypeLine;
    self.xAxleContainer.x_valueView=self.xAxle;
    self.xAxle.textColor=self.tickMarkTextColor;

    [self.lineContainer addObserver:self forKeyPath:@"contentSize" options:NSKeyValueObservingOptionNew|NSKeyValueObservingOptionOld context:nil];
    [self.lineContainer addObserver:self forKeyPath:@"contentOffset" options:NSKeyValueObservingOptionNew|NSKeyValueObservingOptionOld  context:nil];
    
    [self addSubview:self.axleContainer];
    [self addSubview:self.xAxleContainer];
    [view addSubview:self];
}
-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context{
    if ([keyPath isEqualToString:@"contentSize"]) {
        CGSize new=[change[NSKeyValueChangeNewKey] CGSizeValue];
        self.xAxleContainer.contentSize=new;
    }else if ([keyPath isEqualToString:@"contentOffset"]){
        CGPoint new=[change[NSKeyValueChangeNewKey] CGPointValue];
        self.xAxleContainer.contentOffset=CGPointMake(new.x, 0);
    }
    
    
}
#pragma -mark ChartAxleContainerViewDelegate
static BOOL pinched;
-(void)chartAxleContainerView:(nonnull ChartAxleContainerView*)chartAxleContainerView pinchGesture:(nonnull ChartPinchGestureRecognizer*)pin{
    NSLog(@"%lf",pin.scale);
    if (pin.state==UIGestureRecognizerStateBegan) {
        pin.scale=vertical_end_scale;
        pinched=NO;
    }else if (pin.state==UIGestureRecognizerStateChanged){
        if (pin.scale>=1.0&&pin.scale<=max_scale) {
            pinched=YES;
            [self drawVertical:pin];
            [self drawHorizontal:pin];
            vertical_end_scale=pin.scale;
            //横向捏合，绘制contentSize，纵向捏合，绘制frame
            self.lineContainer.contentSize=CGSizeMake(pin.scale*CGRectGetWidth(self.lineContainer.frame), CGRectGetHeight(self.lineContainer.frame));
        }
    }else if ((pin.state==UIGestureRecognizerStateEnded||pin.state==UIGestureRecognizerStateFailed||pin.state==UIGestureRecognizerStateCancelled)&&pinched==YES){
        
        if (pin.scale>max_scale-0.2) {
            pin.scale=max_scale;
        }else if (pin.scale<1.0-0.2){
            pin.scale=1.0;
        }
        [self drawVertical:pin];
        [self drawHorizontal:pin];
        vertical_end_scale=pin.scale;
        self.lineContainer.contentSize=CGSizeMake(pin.scale*CGRectGetWidth(self.lineContainer.frame), CGRectGetHeight(self.lineContainer.frame));
    }
}
#pragma -mark Chart_LineValueViewDelegate
-(void)chart_LineValueView:(Chart_LineValueView *)chart_LineValueView didSelectForType:(NSUInteger)type index:(NSUInteger)index xValue:(NSString *)xValue yValue:(NSNumber *)yValue pointFrame:(CGRect)pointFrame{
    CGRect toLineView_Frame=[self convertRect:pointFrame fromView:chart_LineValueView];

    if ([self.delegate respondsToSelector:@selector(chart_LineView:didSelectForType:index:xValue:yValue:pointFrame:)]) {
        [self.delegate chart_LineView:self didSelectForType:type index:index xValue:xValue yValue:yValue pointFrame:toLineView_Frame];
    }
}
-(CGFloat)chart_LineValueView:(Chart_LineValueView *)chart_LineValueView lineHeightFromValue:(NSNumber *)barValue{

    CGFloat valuePercent=([barValue floatValue]-[self.left_data.lastObject floatValue])/([self.left_data.firstObject floatValue]-[self.left_data.lastObject floatValue]);
    return chart_LineValueView.lineMaxHeight*valuePercent;

}
-(void)drawVertical:(ChartPinchGestureRecognizer*)pin{
    self.axleContainer.contentSize=CGSizeMake(CGRectGetWidth(self.axleContainer.frame), pin.scale*CGRectGetHeight(self.frame));
    self.axle.frame=CGRectMake(0, 0, self.axleContainer.contentSize.width, self.axleContainer.contentSize.height);
    [self.axle setNeedsDisplay];
}
-(void)drawHorizontal:(ChartPinchGestureRecognizer*)pin{
    self.lineContainer.frame=CGRectMake(left_edge, top_edge, self.axleContainer.frame.size.width-2*(left_edge)-line_w, self.axleContainer.contentSize.height-top_edge);
}

-(void)dealloc{
    [self.lineContainer removeObserver:self forKeyPath:@"contentSize"];
    [self.lineContainer removeObserver:self forKeyPath:@"contentOffset"];
    
}

@end
