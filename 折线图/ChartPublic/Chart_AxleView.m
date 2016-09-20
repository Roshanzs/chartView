//
//  Chart_AxleView.m
//  折线图
//
//  Created by MyMac on 16/8/15.
//  Copyright © 2016年 tongfang. All rights reserved.
//
#define Bounds_W self.bounds.size.width
#define Bounds_H self.bounds.size.height
//#define Content_w self.contentSize.width
//#define Content_H self.contentSize.height
#import "Chart_AxleView.h"
#import "ChartConst.h"
@interface Chart_AxleView ()
{
    CGFloat tickMarkDefaultInterval;
    //缩放后左右轴的新刻度值
    NSMutableArray*left_Zoom_values;
    NSMutableArray*right_Zoom_values;
}

@end
@implementation Chart_AxleView
-(void)drawRect:(CGRect)rect{
    CGContextRef ctf=UIGraphicsGetCurrentContext();
    CGContextSetLineWidth(ctf, line_w);
    [self drawLeftYAxle:ctf];
    [self drawRightYAxle:ctf];
    [self drawTickMark:ctf];
    [self drawTickMarkValue:ctf];
}
-(instancetype)initWithFrame:(CGRect)frame{
    if (self=[super initWithFrame:frame]) {
        self.backgroundColor=[UIColor redColor];
        
    }
    return self;
}
-(void)setLeft_data:(NSArray<NSNumber *> *)left_data{
    _left_data=left_data;
    left_Zoom_values=[NSMutableArray arrayWithArray:_left_data];
}
-(void)setRight_data:(NSArray<NSNumber *> *)right_data{
    _right_data=right_data;
    right_Zoom_values=[NSMutableArray   arrayWithArray:_right_data];

}
-(void)setOriginalFrame:(CGRect)originalFrame{
    self.frame=originalFrame;
    //29.888
    tickMarkDefaultInterval=(Bounds_H-top_edge-bottom_edge-line_w)/(_left_data.count-1);
}
-(void)drawLeftYAxle:(CGContextRef)ctf{
    CGContextSetStrokeColorWithColor(ctf, self.left_lineColor.CGColor);
    CGContextMoveToPoint(ctf, left_edge, Bounds_H-bottom_edge);
    CGContextAddLineToPoint(ctf, left_edge, top_edge);
    CGContextDrawPath(ctf, kCGPathStroke);
    
}
-(void)drawRightYAxle:(CGContextRef)ctf{
    CGContextSetStrokeColorWithColor(ctf, self.right_lineColor.CGColor);
    CGContextMoveToPoint(ctf, Bounds_W-left_edge,top_edge);
    CGContextAddLineToPoint(ctf, Bounds_W-left_edge, Bounds_H-bottom_edge);
    CGContextDrawPath(ctf, kCGPathStroke);
    
}
-(void)drawTickMark:(CGContextRef)ctf{
    CGFloat interval=(Bounds_H-top_edge-bottom_edge-line_w)/(self.left_data.count-1);
    NSUInteger tickMarkZoom= interval/tickMarkDefaultInterval;
    if (tickMarkZoom<=0) {
        tickMarkZoom=1;
    }else{
        interval=(Bounds_H-top_edge-bottom_edge-line_w)/((self.left_data.count-1)*(tickMarkZoom-1)+self.left_data.count-1);
    }
    self.tickMarkColor=self.tickMarkColor?self.tickMarkColor:[UIColor lightGrayColor];
    CGContextSetStrokeColorWithColor(ctf, self.tickMarkColor.CGColor);
    for (NSUInteger i=0; i<(self.left_data.count-1)*(tickMarkZoom-1)+self.left_data.count; i++) {
        CGFloat start_x=left_edge+line_w/2.0;
        CGFloat y=interval*i+top_edge+line_w/2.0;
        CGContextMoveToPoint(ctf, start_x, y);
        CGFloat end_x=Bounds_W-left_edge-line_w/2.0;
        CGContextAddLineToPoint(ctf, end_x, y);
    }
    CGContextDrawPath(ctf, kCGPathStroke);
}
static NSUInteger zoom=1;
-(void)drawTickMarkValue:(CGContextRef)ctf{
    UIFont*font=Text_Font;
    NSMutableParagraphStyle*style=[[NSMutableParagraphStyle alloc]init];
    style.alignment=NSTextAlignmentCenter;
    CGFloat interval=(Bounds_H-top_edge-bottom_edge-line_w)/(self.left_data.count-1);
    NSUInteger tickMarkZoom= interval/tickMarkDefaultInterval;
    if (tickMarkZoom<=0) {
        tickMarkZoom=1;
    }else{
        interval=(Bounds_H-top_edge-bottom_edge-line_w)/((self.left_data.count-1)*(tickMarkZoom-1)+self.left_data.count-1);
    }
    CGFloat text_toY_edge=2.0;
    CGFloat text_H=15;
    if (zoom!=tickMarkZoom) {
        zoom=tickMarkZoom;
    [left_Zoom_values removeAllObjects];
    for (NSUInteger i=0; i<self.left_data.count-1; i++) {
        CGFloat currentValue=[self.left_data[i] floatValue];
        CGFloat nextValue=[self.left_data[i+1] floatValue];
        CGFloat valueInterval=(currentValue-nextValue)/tickMarkZoom;
        [left_Zoom_values addObject:self.left_data[i]];
        for (NSUInteger j=1; j<tickMarkZoom; j++) {
        [left_Zoom_values addObject:[NSNumber numberWithFloat:currentValue-j*valueInterval]];
        }
    }
    [left_Zoom_values addObject:self.left_data.lastObject];
        [right_Zoom_values removeAllObjects];
        for (NSUInteger j=0; j<self.right_data.count-1; j++) {
            CGFloat currentValue=[self.right_data[j] floatValue];
            CGFloat nextValue=[self.right_data[j+1] floatValue];
            CGFloat valueInterval=(currentValue-nextValue)/tickMarkZoom;
            [right_Zoom_values addObject:self.right_data[j]];
            for (NSUInteger j=1; j<tickMarkZoom; j++) {
            [right_Zoom_values addObject:[NSNumber numberWithFloat:currentValue-j*valueInterval]];
            }
        }
        [right_Zoom_values addObject:self.right_data.lastObject];
    }
    for (NSUInteger i=0; i<(self.left_data.count-1)*(tickMarkZoom-1)+self.left_data.count; i++) {
        NSString*left_value=[NSString stringWithFormat:@"%@%@",left_Zoom_values[i],self.suffix];
        CGFloat w=left_edge-line_w/2.0-text_toY_edge;
        CGFloat h=text_H;
        CGFloat y=interval*i+top_edge+line_w/2.0-h/2.0;
        [left_value drawInRect:CGRectMake(0, y, w, h) withAttributes:@{NSForegroundColorAttributeName:self.left_textColor?self.left_textColor:[UIColor blackColor],NSFontAttributeName:font,NSParagraphStyleAttributeName:style}];
    }
    for (NSUInteger j=0; j<(self.left_data.count-1)*(tickMarkZoom-1)+self.right_data.count; j++) {
        NSString*right_value=[NSString stringWithFormat:@"%@%@",right_Zoom_values[j],self.suffix];
        CGFloat w=left_edge-line_w/2.0;
        CGFloat h=text_H;
        CGFloat y=interval*j+top_edge+line_w/2.0-h/2.0;
        CGFloat x=Bounds_W-left_edge-line_w/2.0+text_toY_edge;
        [right_value drawInRect:CGRectMake(x, y, w, h) withAttributes:@{NSForegroundColorAttributeName:self.right_textColor?self.right_textColor:[UIColor blackColor],NSFontAttributeName:font,NSParagraphStyleAttributeName:style}];
    }
}
@end
