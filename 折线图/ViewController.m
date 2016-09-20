//
//  ViewController.m
//  折线图
//
//  Created by MyMac on 16/8/8.
//  Copyright © 2016年 tongfang. All rights reserved.
//

#import "ViewController.h"
#import "Chart_BarView.h"
#import "Chart_LineView.h"
@interface ViewController ()<Chart_BarViewDelegate,Chart_LineViewDelegate>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    Chart_LineView*line=[[Chart_LineView alloc]initWithFrame:CGRectMake(10, 10, self.view.bounds.size.width-20, 300)];

    line.values=@[@[@100.0,@10.0,@80.0,@70.0,@60.0,@50.0,@40.0,@30.0,@20.0,@10.0],@[@100.0,@93.0,@82.0,@74.0,@62.0,@52.0,@51.0,@30.0,@28.0,@11.0]];
    line.left_data=@[@100.0,@90.0,@80.0,@70.0,@60.0,@50.0,@40.0,@30.0,@20.0,@10.0];
    line.right_data=@[@100.0,@90.0,@80.0,@70.0,@60.0,@50.0,@40.0,@30.0,@20.0,@10.0];
    line.suffix=@"kwh";
    line.x_tickMarkData =@[@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"10"];
    line.lineColor=@[[UIColor magentaColor],[UIColor orangeColor]];
    line.pointColor=@[[UIColor yellowColor]];
    line.delegate=self;

    [line showInView:self.view];
    
   
    Chart_BarView*barView=[[Chart_BarView alloc]initWithFrame:CGRectMake(10, CGRectGetHeight(line.frame)+20, self.view.bounds.size.width-20, 200)];
    barView.left_data=@[@100.0,@90.0,@80.0,@70.0,@60.0,@50.0,@40.0,@30.0,@20.0,@10.0];
    barView.right_data=@[@100.0,@90.0,@80.0,@70.0,@60.0,@50.0,@40.0,@30.0,@20.0,@10.0];
    barView.suffix=@"kwh";
    barView.left_lineColor=[UIColor blackColor];
    barView.tickMarkColor=[UIColor lightGrayColor];
    barView.left_textColor=[UIColor blackColor];
    barView.right_textColor=[UIColor yellowColor];
    
    barView.x_tickMarkData=@[@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"10"];
    barView.values=@[@100.0,@93.0,@82.0,@74.0,@62.0,@52.0,@51.0,@30.0,@28.0,@11.0];
    barView.tickMarkTextColor=[UIColor blackColor];
    barView.barColor=[UIColor greenColor];
    barView.delegate=self;
    [barView showInView:self.view];
    
}
-(void)chartBarView:(Chart_BarView *)chartBarView didSelectedBarAtIndex:(NSUInteger)index xValue:(NSString *)xValue yValue:(NSNumber *)yValue barFrame:(CGRect)barFrame{

    NSLog(@"Chart_BarView选择 index:%lu xValue:%@ yValue:%@  barFrame:%@",(unsigned long)index,xValue,yValue,[NSValue valueWithCGRect:barFrame]);

}
-(void)chart_LineView:(Chart_LineView *)chart_LineView didSelectForType:(NSUInteger)type index:(NSUInteger)index xValue:(NSString *)xValue yValue:(NSNumber *)yValue pointFrame:(CGRect)pointFrame{

    NSLog(@"Chart_LineView选择 index:%lu xValue:%@ yValue:%@  pointFrame:%@",(unsigned long)index,xValue,yValue,[NSValue valueWithCGRect:pointFrame]);
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
