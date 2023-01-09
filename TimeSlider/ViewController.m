//
//  ViewController.m
//  TimeSlider
//
//  Created by 陈佳达 on 2023/1/9.
//

#import "ViewController.h"
#import "CJDScheduleView.h"
#import "UIView+LayoutExtension.h"
#define kW [[UIScreen mainScreen] bounds].size.width
#define kH [[UIScreen mainScreen] bounds].size.height

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initScheduleView];
}

- (void)initScheduleView {
    CJDScheduleView *vc = [[CJDScheduleView alloc] initWithFrame:CGRectMake(0, 0, kW, 500)];
    
    vc.titleLb.text = [NSString stringWithFormat:@"Edit Sleep Time"];
    
    double sleepResDouble = 8;
    double awakeRessleepResDouble = 10;
    
    int sleepResInt = 11;
    int awakeRessleepResInt = 12;
    
    //        if (self.sleepDurationModel.sleepDurationDayVO.asleepInMinutes/60 >12) {
    //
    //            if (self.sleepDurationModel.sleepDurationDayVO.awakeInMinutes/60 >12) {
    //                vc.sleepView.x = (sleepResInt-19)*4*kLineW + ((sleepResDouble - sleepResInt)*60)/15*kLineW;
    //                vc.sleepView.width = (awakeRessleepResInt - sleepResInt)*4*kLineW - ((sleepResDouble - sleepResInt)*60)/15*kLineW + ((awakeRessleepResDouble - awakeRessleepResInt)*60)/15*kLineW;
    //            }else{
    //                vc.sleepView.x = (sleepResInt-19)*4*kLineW + ((sleepResDouble - sleepResInt)*60)/15*kLineW;
    //                vc.sleepView.width = ((24-sleepResInt) + awakeRessleepResInt)*4*kLineW - (sleepResDouble - sleepResInt)*60/15*kLineW + (awakeRessleepResDouble - awakeRessleepResInt)*60/15*kLineW;
    //            }
    //
    //        }else{
    //            vc.sleepView.x = (sleepResInt+24-19)*4*kLineW + ((sleepResDouble - sleepResInt)*60)/15*kLineW;
    //            vc.sleepView.width = (awakeRessleepResInt - sleepResInt)*4*kLineW - (sleepResDouble - sleepResInt)*60/15*kLineW + (awakeRessleepResDouble - awakeRessleepResInt) *60/15*kLineW;
    //
    //        }
    [vc updateViewWidth:vc.sleepView.width-kLineW*4];
    
    vc.ClickOkBlock = ^(NSString * _Nonnull AsleepStr, NSString * _Nonnull AwakeStr, UIView * _Nonnull view) {
        
        NSLog(@"AsleepStr:%@ AwakeStr:%@",AsleepStr,AwakeStr);
        
    };
    
    [self.view addSubview:vc];
    
}


@end
