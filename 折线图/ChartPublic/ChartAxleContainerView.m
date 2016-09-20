//
//  ChartAxleContainerView.m
//  折线图
//
//  Created by MyMac on 16/8/16.
//  Copyright © 2016年 tongfang. All rights reserved.
//
#import "ChartConst.h"
#import "ChartAxleContainerView.h"

@interface ChartAxleContainerView()
{
    CGFloat horizontal_end_scale;//水平方向最后缩放比例
    CGFloat vertical_end_scale;//垂直方向最后缩放比例
    
}
@end
@implementation ChartAxleContainerView
-(instancetype)initWithFrame:(CGRect)frame{
    if (self=[super initWithFrame:frame]) {
        self.showsHorizontalScrollIndicator=NO;
        self.showsVerticalScrollIndicator=NO;
        self.contentSize=frame.size;
        self.pinchGestureRecognizer.enabled=NO;
        self.bounces=NO;
        self.backgroundColor=[UIColor whiteColor];
        self.multipleTouchEnabled=YES;
        horizontal_end_scale=1.0;
        vertical_end_scale=1.0;
        ChartPinchGestureRecognizer*pin=[[ChartPinchGestureRecognizer alloc]initWithTarget:self action:@selector(pinAction:)];
        [self addGestureRecognizer:pin];

    }

    return self;
}
-(void)setChart:(Chart_AxleView *)chart{
    _chart=chart;
    [_chart setOriginalFrame:self.bounds];
    [self addSubview:_chart];
}
-(void)setValueContainerView:(ChartValueContainerBaseView *)valueContainerView{
    _valueContainerView=valueContainerView;
    [_valueContainerView setOriginalFrame:CGRectMake(left_edge, top_edge, self.frame.size.width-2*(left_edge)-line_w, self.contentSize.height-top_edge)];
    [self addSubview:_valueContainerView];
}
//static BOOL pinched;
-(void)pinAction:(ChartPinchGestureRecognizer*)pin{
    if ([self.interactiveDelegate respondsToSelector:@selector(chartAxleContainerView:pinchGesture:)]) {
        [self.interactiveDelegate chartAxleContainerView:self pinchGesture:pin];
    }
//    if (pin.state==UIGestureRecognizerStateBegan) {
//            pin.scale=vertical_end_scale;
//        pinched=NO;
//    }else if (pin.state==UIGestureRecognizerStateChanged){
//        if (pin.scale>=1.0&&pin.scale<=max_scale) {
//         pinched=YES;
//        [self drawVertical:pin];
//        [self drawHorizontal:pin];
//         vertical_end_scale=pin.scale;
//
//        //横向捏合，绘制contentSize，纵向捏合，绘制frame
//        self.barContainerView.contentSize=CGSizeMake(pin.scale*CGRectGetWidth(self.barContainerView.frame), CGRectGetHeight(self.barContainerView.frame));
//
//        }
//
//    }else if ((pin.state==UIGestureRecognizerStateEnded||pin.state==UIGestureRecognizerStateFailed||pin.state==UIGestureRecognizerStateCancelled)&&pinched==YES){
//
//            if (pin.scale>max_scale-0.2) {
//                pin.scale=max_scale;
//            }else if (pin.scale<1.0-0.2){
//                pin.scale=1.0;
//            }
//            [self drawVertical:pin];
//            [self drawHorizontal:pin];
//            vertical_end_scale=pin.scale;
//            self.barContainerView.contentSize=CGSizeMake(pin.scale*CGRectGetWidth(self.barContainerView.frame), CGRectGetHeight(self.barContainerView.frame));
//    }
}
//-(void)drawVertical:(ChartPinchGestureRecognizer*)pin{
////    NSLog(@"%f",pin.scale);
//    self.contentSize=CGSizeMake(CGRectGetWidth(self.frame), pin.scale*CGRectGetHeight(self.frame));
//    self.chart.frame=CGRectMake(0, 0, self.contentSize.width, self.contentSize.height);
//    [self.chart setNeedsDisplay];
// 
//
//}
//-(void)drawHorizontal:(ChartPinchGestureRecognizer*)pin{
//
//self.barContainerView.frame=CGRectMake(left_edge, top_edge, self.frame.size.width-2*(left_edge)-line_w, self.contentSize.height-top_edge);
//
//}
@end
