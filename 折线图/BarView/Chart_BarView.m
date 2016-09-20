//
//  Chart_BarView.m
//  折线图
//
//  Created by MyMac on 16/8/17.
//  Copyright © 2016年 tongfang. All rights reserved.
//

#import "Chart_BarView.h"
#import "Chart_AxleView.h"
#import "ChartAxleContainerView.h"


#import "Chart_BarValueView.h"
#import "ChartBarValueContainerView.h"

#import "Chart_xAxleValueView.h"
#import "Chart_xAxleContainerView.h"
#import "ChartConst.h"
@interface Chart_BarView()<Chart_BarValueViewDelegate,ChartAxleContainerViewDelegate>
{
    CGFloat vertical_end_scale;
}
//y轴
@property(strong,nonatomic)Chart_AxleView*axle;
@property(nonatomic,strong)ChartAxleContainerView*axleContainer;

//内容
@property(nonatomic,strong)Chart_BarValueView*bar;
@property(nonatomic,strong)ChartBarValueContainerView*barContainer;

//x轴
@property(nonatomic,strong)Chart_xAxleValueView*xAxle;
@property(nonatomic,strong)Chart_xAxleContainerView*xAxleContainer;
@end
@implementation Chart_BarView
-(instancetype)initWithFrame:(CGRect)frame{
    if (self=[super initWithFrame:frame]) {
        vertical_end_scale=1.0;
        self.axleContainer=[[ChartAxleContainerView alloc]initWithFrame:self.bounds];
        self.axleContainer.interactiveDelegate=self;
        self.axle=[[Chart_AxleView alloc]initWithFrame:self.bounds];
        
        
        self.bar=[[Chart_BarValueView alloc]initWithFrame:CGRectMake(0, 0, 0, 0)];
        self.bar.delegate=self;
        self.barContainer=[[ChartBarValueContainerView alloc]initWithFrame:CGRectMake(10, 10, self.bounds.size.width-20, 400)];
        
        self.xAxleContainer=[[Chart_xAxleContainerView alloc]initWithFrame:CGRectZero];
        self.xAxle=[[Chart_xAxleValueView alloc]initWithFrame:CGRectZero];
     
        
    }
    return self;


}
//层级关系 Chart_BarView>ChartAxleContainerView>Chart_AxleView
//                                            >ChartBarValueContainerView>Chart_BarValueView
-(void)showInView:(UIView*)view{

    self.axle.left_data=self.left_data;
    self.axle.right_data=self.right_data;
    
    self.axle.suffix=self.suffix;
    
    self.axle.left_lineColor=self.left_lineColor;
    self.axle.right_lineColor=self.right_lineColor;
    
    self.axle.tickMarkColor=self.tickMarkColor;
    
    self.axle.left_textColor=self.left_textColor;
    self.axle.right_textColor=self.right_textColor;


    self.bar.x_tickMarkData=self.x_tickMarkData;
    self.bar.values=self.values;
    self.bar.textColor=self.tickMarkTextColor;
    self.bar.barColor=self.barColor;
    
    self.barContainer.barValueView=self.bar;

    
    self.axleContainer.chart=self.axle;
    self.axleContainer.valueContainerView=self.barContainer;
    
    self.xAxleContainer.frame=CGRectMake(CGRectGetMinX(self.barContainer.frame), CGRectGetHeight(self.barContainer.frame)+CGRectGetMinY(self.barContainer.frame)-bottom_edge+1, CGRectGetWidth(self.barContainer.frame),bottom_edge-1);
    self.xAxle.x_tickMarkData=self.x_tickMarkData;
    self.xAxle.chartType=ChartTypeBar;
    self.xAxleContainer.x_valueView=self.xAxle;
    self.xAxle.textColor=self.tickMarkTextColor;
    [self.barContainer addObserver:self forKeyPath:@"contentSize" options:NSKeyValueObservingOptionNew|NSKeyValueObservingOptionOld context:nil];
    [self.barContainer addObserver:self forKeyPath:@"contentOffset" options:NSKeyValueObservingOptionNew|NSKeyValueObservingOptionOld  context:nil];
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
#pragma -mark Chart_BarValueViewDelegate bar的高和点击
-(CGFloat)chart_BarValueView:(Chart_BarValueView *)barView barHeightFromValue:(NSNumber *)barValue{
    CGFloat valuePercent=([barValue floatValue]-[self.left_data.lastObject floatValue])/([self.left_data.firstObject floatValue]-[self.left_data.lastObject floatValue]);
    return barView.maxHeight*valuePercent;
}
-(void)chart_BarValueView:(Chart_BarValueView *)barView didSelectedAtIndex:(NSUInteger)index xValue:(NSString *)xValeu yValue:(NSNumber *)yValue barFrame:(CGRect)frame{
    CGRect toBarView_Frame=[self convertRect:frame fromView:barView];
    if ([self.delegate respondsToSelector:@selector(chartBarView:didSelectedBarAtIndex:xValue:yValue:barFrame:)]) {
        [self.delegate chartBarView:self didSelectedBarAtIndex:index xValue:xValeu yValue:yValue barFrame:toBarView_Frame];
    }
}

#pragma -mark ChartAxleContainerViewDelegate
static BOOL pinched;
-(void)chartAxleContainerView:(ChartAxleContainerView *)chartAxleContainerView pinchGesture:(ChartPinchGestureRecognizer *)pin{
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
            self.barContainer.contentSize=CGSizeMake(pin.scale*CGRectGetWidth(self.barContainer.frame), CGRectGetHeight(self.barContainer.frame));
            
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
        self.barContainer.contentSize=CGSizeMake(pin.scale*CGRectGetWidth(self.barContainer.frame), CGRectGetHeight(self.barContainer.frame));
    }
}
-(void)drawVertical:(ChartPinchGestureRecognizer*)pin{
    self.axleContainer.contentSize=CGSizeMake(CGRectGetWidth(self.axleContainer.frame), pin.scale*CGRectGetHeight(self.frame));
    self.axle.frame=CGRectMake(0, 0, self.axleContainer.contentSize.width, self.axleContainer.contentSize.height);
    [self.axle setNeedsDisplay];
}
-(void)drawHorizontal:(ChartPinchGestureRecognizer*)pin{
self.barContainer.frame=CGRectMake(left_edge, top_edge, self.axleContainer.frame.size.width-2*(left_edge)-line_w, self.axleContainer.contentSize.height-top_edge);
}


-(void)dealloc{
    [self.barContainer removeObserver:self forKeyPath:@"contentSize"];
    [self.barContainer removeObserver:self forKeyPath:@"contentOffset"];

}
@end
