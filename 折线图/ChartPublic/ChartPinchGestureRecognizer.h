//
//  ChartPinchGestureRecognizer.h
//  折线图
//
//  Created by MyMac on 16/8/17.
//  Copyright © 2016年 tongfang. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef NS_ENUM(NSUInteger,ChartPinchGestureRecognizerDirection){
    PinchDirectionHorizontal=1,//水平
    PinchDirectionVertical,//垂直
    PinchDirectionMultivariant//其它

};
@interface ChartPinchGestureRecognizer : UIPinchGestureRecognizer
@property(nonatomic,assign)ChartPinchGestureRecognizerDirection pinchDirection;
@end
