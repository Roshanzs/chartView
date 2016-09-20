//
//  Chart_xAxleValueView.h
//  折线图
//
//  Created by MyMac on 16/8/18.
//  Copyright © 2016年 tongfang. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef NS_ENUM(NSUInteger,ChartType) {

    ChartTypeBar,
    ChartTypeLine

};
@interface Chart_xAxleValueView : UIView
@property(nonatomic,strong)UIColor*textColor;
@property(nonatomic,strong)NSArray<NSString*>*x_tickMarkData;
@property(nonatomic,assign)ChartType chartType;
@end