//
//  CJDScheduleView.h
//  TimeSlider
//
//  Created by 陈佳达 on 2023/1/9.
//

#import <UIKit/UIKit.h>
#define kW [[UIScreen mainScreen] bounds].size.width
#define kH [[UIScreen mainScreen] bounds].size.height
#define kVIEWH 45
#define kLineCount 16*1*4+1
#define kLineW (kW-19*2)/(kLineCount-1)//一格宽度
#define kSleepH kLineW*8
#define kImageName(str) [UIImage imageNamed:str]
NS_ASSUME_NONNULL_BEGIN

@interface CJDScheduleView : UIView<UIGestureRecognizerDelegate>
@property (nonatomic, strong) UIView *lineView;
@property (nonatomic, strong) UIView *sleepView;
@property (nonatomic, strong, nullable) UISwipeGestureRecognizer *leftGestureRecognizer;
@property (nonatomic, strong, nullable) UISwipeGestureRecognizer *rightGestureRecognizer;
@property (nonatomic, assign) NSInteger moveType;
@property (nonatomic, assign) CGFloat coordinateX;
@property (nonatomic, assign) CGFloat beganPoint;
@property (nonatomic, strong) UIView *rightView;
@property (nonatomic, strong) UIView *lineBgView;
@property (nonatomic, strong) UIImageView *leftImg;
@property (nonatomic, strong) UIImageView *rightImg;

@property (nonatomic, strong) UILabel *titleLb;
@property (nonatomic, strong) UILabel *dayLb;
@property (nonatomic, strong) UIButton *okBtn;
@property (nonatomic, strong) UIButton *cancelBtn;

@property (nonatomic, strong) UIImageView *asleepImg;
@property (nonatomic, strong) UIImageView *awakeImg;
@property (nonatomic, strong) UILabel *asleepTitleLabel;
@property (nonatomic, strong) UILabel *awakeTitleLabel;

@property (nonatomic, strong) UILabel *asleepLabel;
@property (nonatomic, strong) UILabel *awakelabel;
@property (nonatomic, strong) UILabel *beginLabel;
@property (nonatomic, strong) UILabel *endLabel;

- (void)updateViewWidth:(CGFloat)width;
@property (nonatomic, copy) void(^ClickOkBlock)(NSString *AsleepStr, NSString *AwakeStr, UIView *view);
@property (nonatomic, copy) void(^ClickCancelBlock)(void);

@end

NS_ASSUME_NONNULL_END
