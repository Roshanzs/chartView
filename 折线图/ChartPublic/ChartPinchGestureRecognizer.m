//
//  ChartPinchGestureRecognizer.m
//  折线图
//
//  Created by MyMac on 16/8/17.
//  Copyright © 2016年 tongfang. All rights reserved.
//

#import "ChartPinchGestureRecognizer.h"
#import <UIKit/UIGestureRecognizerSubclass.h>
@interface ChartPinchGestureRecognizer()
{
    ChartPinchGestureRecognizerDirection oldDirection;
    BOOL vaild;

}
@property(nonatomic,weak)UITouch*touch;
@end
@implementation ChartPinchGestureRecognizer
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    NSArray*touchArray=[touches allObjects];
    self.touch=touchArray.firstObject;
    vaild=NO;
   [self calculateDirection:touchArray];
   [super touchesBegan:touches withEvent:event];
}
- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    NSArray*touchArray=[touches allObjects];
    [self calculateDirection:touchArray];
//    if (self.pinchDirection!=oldDirection) {
//        self.pinchDirection=oldDirection;
//    }
//    NSLog(@"pinchDirection:%lu count:%lu",(unsigned long)self.pinchDirection,(unsigned long)touchArray.count);
    [super touchesMoved:touches withEvent:event];

}
- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{

    [super touchesEnded:touches withEvent:event];
}
- (void)touchesCancelled:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{

    [super touchesCancelled:touches withEvent:event];

}
-(void)calculateDirection:(NSArray<UITouch *> *)touchArray{
    if (vaild==YES) {
        self.pinchDirection=oldDirection;
        return;
    }
    CGPoint firstPoint=[self.touch locationInView:self.view];
    CGPoint lastPoint=[self.touch previousLocationInView:self.view];

    CGFloat distance=sqrt(pow(ABS(firstPoint.x-lastPoint.x),2)+pow(ABS(firstPoint.y-lastPoint.y),2));
    CGFloat y_distance=ABS(firstPoint.y-lastPoint.y);
    if (distance==0) {
        return;
    }
    CGFloat sinR=y_distance/distance;
    if (sinR<=0.6) {
        self.pinchDirection=PinchDirectionHorizontal;
    }else if (sinR>0.6){
        self.pinchDirection=PinchDirectionVertical;
    }else{
        self.pinchDirection=PinchDirectionMultivariant;
    }
        if (self.pinchDirection==1||self.pinchDirection==2) {
  
            oldDirection=self.pinchDirection;
            vaild=YES;
        
    }
    

}
@end
