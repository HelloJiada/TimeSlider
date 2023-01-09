//
//  CJDScheduleView.m
//  TimeSlider
//
//  Created by 陈佳达 on 2023/1/9.
//

#import "CJDScheduleView.h"
#import "Masonry.h"
#import "UIView+LayoutExtension.h"
@implementation CJDScheduleView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.frame = frame;
        [self initView];
        self.backgroundColor = UIColor.whiteColor;
    }
    return self;
}

- (void)initView {
    
    [self addSubview:self.titleLb];
    self.titleLb.frame = CGRectMake(0, 200, kW, 30);
    [self addSubview:self.dayLb];
    self.dayLb.frame = CGRectMake(0, self.titleLb.endY + 6, kW, 21);
    [self addSubview:self.cancelBtn];
    [self.cancelBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.mas_top).offset(24);
        make.right.mas_equalTo(self.mas_right).offset(-14);
        make.size.mas_equalTo(CGSizeMake(32, 32));
    }];
    
    [self addSubview:self.asleepImg];
    [self.asleepImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.titleLb.mas_bottom).offset(29);
        make.left.mas_equalTo(self.mas_left).offset(20);
        make.size.mas_equalTo(CGSizeMake(32, 32));
    }];
    
    [self addSubview:self.awakeImg];
    [self.awakeImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.titleLb.mas_bottom).offset(29);
        make.right.mas_equalTo(self.mas_right).offset(-20);
        make.size.mas_equalTo(CGSizeMake(32, 32));
    }];
    
    [self addSubview:self.asleepTitleLabel];
    [self.asleepTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.awakeImg.mas_bottom).offset(3);
        make.left.mas_equalTo(self.mas_left).offset(20);
        make.size.mas_equalTo(CGSizeMake(80, 21));
    }];
    
    [self addSubview:self.awakeTitleLabel];
    [self.awakeTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.awakeImg.mas_bottom).offset(3);
        make.right.mas_equalTo(self.mas_right).offset(-20);
        make.size.mas_equalTo(CGSizeMake(80, 21));
    }];
    
    [self addSubview:self.asleepLabel];
    [self.asleepLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.asleepTitleLabel.mas_bottom).offset(11);
        make.left.mas_equalTo(self.mas_left).offset(20);
        make.size.mas_equalTo(CGSizeMake(117, 54));
    }];
    
    [self addSubview:self.awakelabel];
    [self.awakelabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.awakeTitleLabel.mas_bottom).offset(11);
        make.right.mas_equalTo(self.mas_right).offset(-20);
        make.size.mas_equalTo(CGSizeMake(117, 54));
    }];
    

    
    self.lineView = [[UIView alloc] init];
    self.lineView.backgroundColor = UIColor.whiteColor;
    [self addSubview:self.lineView];
    
    [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.mas_left).offset(19);
        make.right.mas_equalTo(self.mas_right).offset(-19);
        make.top.mas_equalTo(self.awakelabel.mas_bottom).offset(30);
        make.height.mas_equalTo(120);
    }];
    
    [self addSubview:self.beginLabel];
    [self.beginLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.lineView.mas_left);
        make.top.mas_equalTo(self.lineView.mas_bottom).offset(3);
    }];
    
    [self addSubview:self.endLabel];
    [self.endLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.lineView.mas_right);
        make.top.mas_equalTo(self.lineView.mas_bottom).offset(3);
    }];
    
    [self addSubview:self.okBtn];
//    self.okBtn.frame = CGRectMake(20, 200, kW-19-20, 54);
    [self.okBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.mas_left).offset(20);
            make.right.mas_equalTo(self.mas_right).offset(-20);
            make.top.mas_equalTo(self.endLabel.mas_bottom).offset(30);
        make.height.mas_equalTo(54);
    }];
    
    /**
     15分钟一格
     */
    for (int i = 0; i < kLineCount; i++) {
        CGFloat h = 0;
        CGFloat y = 0;
        if (i==0 || i == kLineCount-1) {
            h = 120;
            y = 0;
        }else{
            y = [self judgeStr:@"4" with:[NSString stringWithFormat:@"%d",i]]?12:26;
            h = [self judgeStr:@"4" with:[NSString stringWithFormat:@"%d",i]]?96:69;
        }
        UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0+i*kLineW, y, 1, h)];
        line.backgroundColor = [UIColor colorWithRed:208 /255.0f green:208 /255.0f blue:208 /255.0f alpha:1.0f];
        [self.lineView addSubview:line];
        
    }
    
    self.sleepView = [[UIView alloc] initWithFrame:CGRectMake(kLineW*4*3, (120-kSleepH)/2.f, kLineW*4*6, kSleepH)];
    self.sleepView.backgroundColor = [UIColor colorWithRed:65 /255.0f green:97 /255.0f blue:193 /255.0f alpha:1.0f];
    [self.lineView addSubview:self.sleepView];
    self.sleepView.layer.cornerRadius = kSleepH/2.f;
    self.sleepView.layer.masksToBounds = YES;
    
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(commitTranslationDrag:)];
    [self.sleepView addGestureRecognizer:pan];

    [self updateViewWidth:self.sleepView.frame.size.width-kLineW*4];
    
    UIView *leftView = [[UIView alloc] initWithFrame:CGRectMake(kLineW, (kSleepH-kLineW*4)/2.f, kLineW*4, kLineW*4)];
    leftView.backgroundColor = [UIColor colorWithRed:65 /255.0f green:97 /255.0f blue:193 /255.0f alpha:1.0f];
    [self.sleepView addSubview:leftView];
    leftView.layer.cornerRadius = kLineW*4/2.f;
    leftView.layer.masksToBounds = YES;
    
    UIImageView *leftImg = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"sleep_iconSleep"]];
    [leftView addSubview:leftImg];
    leftImg.frame = CGRectMake(0, 0, kLineW*4, kLineW*4);
    self.leftImg = leftImg;
    
    UIView *rightView = [[UIView alloc] init];
    rightView.backgroundColor = [UIColor colorWithRed:65 /255.0f green:97 /255.0f blue:193 /255.0f alpha:1.0f];
    [self.sleepView addSubview:rightView];
    rightView.layer.cornerRadius = kLineW*4/2.f;
    rightView.layer.masksToBounds = YES;
    self.rightView = rightView;
    
    [rightView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.sleepView.mas_right).offset(-kLineW);
        make.centerY.mas_equalTo(self.sleepView.mas_centerY);
        make.size.mas_equalTo(CGSizeMake(kLineW*4, kLineW*4));
    }];
    
    UIImageView *rightImg = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"sleep_iconTime"]];
    [rightView addSubview:rightImg];
    rightImg.frame = CGRectMake(0, 0, kLineW*4, kLineW*4);
    self.rightImg = rightImg;
}

- (UILabel *)titleLb {
    if (!_titleLb) {
        _titleLb = [self labelWithTitle:@"Sleep Schedule" color:UIColor.blackColor font:[UIFont systemFontOfSize:20] TextAlignment:NSTextAlignmentCenter NumberOfLines:0];
    }
    return _titleLb;
}

- (UILabel *)dayLb {
    if (!_dayLb) {
        _dayLb = [self labelWithTitle:@"" color:UIColor.blackColor font:[UIFont systemFontOfSize:16] TextAlignment:NSTextAlignmentCenter NumberOfLines:0];
    }
    return _dayLb;
}

- (UIImageView *)asleepImg {
    if (!_asleepImg) {
        _asleepImg = [[UIImageView alloc] initWithImage:kImageName(@"iconSleep-1")];
    }
    return _asleepImg;
}

- (UIImageView *)awakeImg {
    if (!_awakeImg) {
        _awakeImg = [[UIImageView alloc] initWithImage:kImageName(@"iconTime")];
    }
    return _awakeImg;
}

- (UILabel *)asleepTitleLabel {
    if (!_asleepTitleLabel) {
        _asleepTitleLabel = [self labelWithTitle:@"Asleep" color:UIColor.blackColor font:[UIFont systemFontOfSize:16] TextAlignment:NSTextAlignmentLeft NumberOfLines:0];
    }
    return _asleepTitleLabel;
}

- (UILabel *)awakeTitleLabel {
    if (!_awakeTitleLabel) {
        _awakeTitleLabel = [self labelWithTitle:@"Awake" color:UIColor.blackColor font:[UIFont systemFontOfSize:16] TextAlignment:NSTextAlignmentRight NumberOfLines:0];
    }
    return _awakeTitleLabel;
}

- (UILabel *)asleepLabel {
    if (!_asleepLabel) {
        _asleepLabel = [self labelWithTitle:@"10:30pm" color:UIColor.blackColor font:[UIFont systemFontOfSize:16] TextAlignment:NSTextAlignmentCenter NumberOfLines:0];
        _asleepLabel.layer.borderColor = UIColor.blackColor.CGColor;
        _asleepLabel.layer.borderWidth = 1.f;
        _asleepLabel.layer.cornerRadius = 10.f;
        _asleepLabel.clipsToBounds = YES;
    }
    return _asleepLabel;
}

- (UILabel *)awakelabel {
    if (!_awakelabel) {
        _awakelabel = [self labelWithTitle:@"6:30am" color:UIColor.blackColor font:[UIFont systemFontOfSize:16] TextAlignment:NSTextAlignmentCenter NumberOfLines:0];
        _awakelabel.layer.borderColor = UIColor.blackColor.CGColor;
        _awakelabel.layer.borderWidth = 1.f;
        _awakelabel.layer.cornerRadius = 10.f;
        _awakelabel.clipsToBounds = YES;
    }
    return _awakelabel;
}

- (UIButton *)okBtn {
    if (!_okBtn) {
        _okBtn = [self allocButtonWithType:UIButtonTypeCustom buttonNormalStr:@"Save" buttonSelectedStr:@"Save" buttonNormalColor:UIColor.whiteColor buttonSelectedColor:UIColor.whiteColor buttonBackgroundColor:UIColor.blackColor buttonFont:[UIFont systemFontOfSize:16] cornerRadius:54/2.f];
        [_okBtn addTarget:self action:@selector(clickOkBtn) forControlEvents:UIControlEventTouchUpInside];
    }
    return _okBtn;
}

- (UIButton *)cancelBtn {
    if (!_cancelBtn) {
        _cancelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_cancelBtn setImage:kImageName(@"iconX1") forState:UIControlStateNormal];
        [_cancelBtn addTarget:self action:@selector(clickCancelBtn) forControlEvents:UIControlEventTouchUpInside];
    }
    return _cancelBtn;
}

- (UILabel *)beginLabel {
    if (!_beginLabel) {
        _beginLabel = [self labelWithTitle:@"07:00 PM" color:UIColor.blackColor font:[UIFont systemFontOfSize:16] TextAlignment:NSTextAlignmentRight NumberOfLines:0];
    }
    return _beginLabel;
}

- (UILabel *)endLabel {
    if (!_endLabel) {
        _endLabel = [self labelWithTitle:@"11:00 AM" color:UIColor.blackColor font:[UIFont systemFontOfSize:16] TextAlignment:NSTextAlignmentRight NumberOfLines:0];
    }
    return _endLabel;
}

- (void)clickCancelBtn{
    NSLog(@"Cancel");
    if (self.ClickCancelBlock) {
        self.ClickCancelBlock();
    }
}

- (void)clickOkBtn{
    NSLog(@"OK");
    if (self.ClickOkBlock) {
        self.ClickOkBlock(self.asleepLabel.text, self.awakelabel.text,self.sleepView);
    }
}

- (void)updateViewWidth:(CGFloat)width{
    CGFloat w = kLineW;
    int count = width/w+1;
    [self.lineBgView removeFromSuperview];
    self.lineBgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.sleepView.width, self.sleepView.height)];
    for (int i = 0; i < count; i++) {
        UIView *line = [[UIView alloc] initWithFrame:CGRectMake(kLineW*2+i*kLineW, (kSleepH-8)/2.f, 1, 8)];
        line.backgroundColor = UIColor.whiteColor;
        [self.lineBgView addSubview:line];
    }
    [self.sleepView addSubview:self.lineBgView];
    [self.sleepView sendSubviewToBack:self.lineBgView];
}

- (NSString *)getAsleepTime:(CGFloat)width{
    
    CGFloat w = kLineW;
    int count = width/w;
    if ([self judgeStr:@"4" with:[NSString stringWithFormat:@"%d",count]]) {
        if ((count/4+7)==12) {
            return [NSString stringWithFormat:@"%d:00 AM",(count/4+7)];
        }else if ((count/4+7)>12){
            return [NSString stringWithFormat:@"%d:00 AM",(count/4+7)-12];
        }else{
            return [NSString stringWithFormat:@"%d:00 PM",(count/4+7)];
        }
    }else{
        if ((count/4+7)==12) {
            return [NSString stringWithFormat:@"%d:%d AM",7+count/4,(count-(count/4)*4)*15];
        }else if ((count/4+7)>12){
            return [NSString stringWithFormat:@"%d:%d AM",7+count/4-12,(count-(count/4)*4)*15];
        }else{
            return [NSString stringWithFormat:@"%d:%d PM",7+count/4,(count-(count/4)*4)*15];
        }
    }
}

- (NSString *)getAwakeTime:(CGFloat)width{
    CGFloat w = kLineW;
    int count = width/w;
    if ([self judgeStr:@"4" with:[NSString stringWithFormat:@"%d",count]]) {
        if ((count/4+7)==12) {
            return [NSString stringWithFormat:@"%d:00 AM",(count/4+7)];
        }else if ((count/4+7)>12){
            return [NSString stringWithFormat:@"%d:00 AM",(count/4+7)-12];
        }else{
            return [NSString stringWithFormat:@"%d:00 PM",(count/4+7)];
        }
    }else{
        if ((count/4+7)==12) {
            return [NSString stringWithFormat:@"%d:%d AM",7+count/4,(count-(count/4)*4)*15];
        }else if ((count/4+7)>12){
            return [NSString stringWithFormat:@"%d:%d AM",7+count/4-12,(count-(count/4)*4)*15];
        }else{
            return [NSString stringWithFormat:@"%d:%d PM",7+count/4,(count-(count/4)*4)*15];
        }
    }
}

- (void)moveSign:(UIPanGestureRecognizer *)recognizer {
    
}

-(BOOL)judgeStr:(NSString *)str1 with:(NSString *)str2{
    int str1Int=[str1 intValue];
    
    double str2Double=[str2 doubleValue];
    int str2Int=[str2 intValue];
    
    if (str2Double/str1Int-str2Int/str1Int  > 0) {
        return NO;
    }
    return YES;
}

- (void)dragOnView:(UIPanGestureRecognizer *)drag{
    if (drag.state == UIGestureRecognizerStateBegan || drag.state == UIGestureRecognizerStateChanged) {
        
        [self commitTranslationDrag:drag];
    }
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(nullable UIEvent *)event{
    UITouch *touch = [[event allTouches] anyObject];

    CGPoint touchPoint = [touch locationInView:self.sleepView];
    self.beganPoint = touchPoint.x;
}

- (void)commitTranslationDrag:(UIPanGestureRecognizer *)drag{
    CGPoint newPosition = [drag translationInView:drag.view];
    CGFloat absX = fabs(newPosition.x);
    CGFloat absY = fabs(newPosition.y);
    CGPoint newlocation = [drag locationInView:drag.view];
    CGRect frame = self.sleepView.frame;
//    NSLog(@"self.sleepView.endX = %f",self.sleepView.endX);
//    NSLog(@"self.sleepView.x = %f",self.sleepView.x);
//    NSLog(@"drag.view.center.x = %f",drag.view.center.x);
//    NSLog(@"newPosition.x = %f",newPosition.x);
//    NSLog(@"实际滑动距离 = %f",absX);
    NSLog(@"设定滑动距离 = %f",kLineW);
//    NSLog(@"手指触摸x点 = %f",newlocation.x);
//    NSLog(@"左边范围 = %f",frame.size.width*0.25);
    NSLog(@"右边触摸范围 = %f",frame.size.width*0.75);
    NSLog(@"BeganPoint -- %lf",self.beganPoint);
    NSLog(@"---------------------------------------");
    // 设置滑动有效距离
    if (MAX(absX, absY) < kLineW)
        return;
    
 
    
    /**
     手指触摸范围
     当前图层宽度
     左边25%
     右边75%
     判断左滑
     判断右滑
     */
    if (frame.size.width<=kLineW*8) {
        if (self.beganPoint < frame.size.width*0.5) {//左边25%
            if (absX > absY ) {
                if (newPosition.x<0) {
                    //向左滑动
                    CGSize newSize = drag.view.frame.size;
                    newPosition.x = -(kLineW) + drag.view.center.x;
                    newSize.width += (kLineW);
                    newPosition.y = 60;
                    if (self.sleepView.frame.origin.x<kLineW) {
                        return;
                    }
                    drag.view.center = newPosition;
                    [drag setTranslation:CGPointZero inView:drag.view];
                    self.sleepView.size = newSize;
                }else{
                    //向右滑动
                    CGSize newSize = drag.view.frame.size;
                    newPosition.x += drag.view.center.x;
                    newPosition.y = 60;
                    newSize.width -= (kLineW);
                    if (newSize.width<=kLineW*8) {
                        return;
                    }
                    
                    drag.view.center = newPosition;
                    [drag setTranslation:CGPointZero inView:drag.view];
                    self.sleepView.size = newSize;
                }
            }
        }else if (self.beganPoint >= frame.size.width*0.5){//右边75%
            if (absX > absY ) {
                if (newPosition.x<0) {
                    //向左滑动
                    CGSize newSize = drag.view.frame.size;
                    newPosition.x = drag.view.center.x;
                    newPosition.y = 60;
                    newSize.width -= kLineW;
                    if (newSize.width<=kLineW*8) {
                        return;
                    }
                    [drag setTranslation:CGPointZero inView:drag.view];
                    self.sleepView.size = newSize;
                    
                }else{
                    //向右滑动
                    CGSize newSize = drag.view.frame.size;
                    newPosition.x = drag.view.center.x;
                    newPosition.y = 60;
                    if (self.sleepView.endX>=kW-19*2) {
                        return;
                    }
                    newSize.width += kLineW;
                    [drag setTranslation:CGPointZero inView:drag.view];
                    self.sleepView.size = newSize;
                    self.beganPoint = self.beganPoint + kLineW;
                }
            }
        }
    }else{
        
        if (self.beganPoint < frame.size.width*0.25) {//左边25%
            if (absX > absY ) {
                if (newPosition.x<0) {
                    if (self.sleepView.frame.origin.x<kLineW) {
                        return;
                    }
                    //向左滑动
                    CGSize newSize = drag.view.frame.size;
                    newPosition.x = -(kLineW) + drag.view.center.x;
                    newSize.width += (kLineW*2);
                    newPosition.y = 60;
                    drag.view.center = newPosition;
                    [drag setTranslation:CGPointZero inView:drag.view];
                    self.sleepView.width = self.sleepView.width + kLineW;
                    
                }else{
                    //向右滑动
                    CGSize newSize = drag.view.frame.size;
                    newPosition.x = kLineW + drag.view.center.x;
                    newPosition.y = 60;
                    newSize.width -= (kLineW*2);
                    if (newSize.width+kLineW*2<=kLineW * 8) {
                        return;
                    }
                    drag.view.center = newPosition;
                    [drag setTranslation:CGPointZero inView:drag.view];
                    self.sleepView.width = self.sleepView.width - kLineW;
                }
            }
        }else if (self.beganPoint >= frame.size.width*0.75){//右边75%
            if (absX > absY ) {
                if (newPosition.x<0) {
                    //向左滑动
                    CGSize newSize = drag.view.frame.size;
                    newPosition.x = drag.view.center.x;
                    newPosition.y = 60;
                    newSize.width -= kLineW;
                    if (newSize.width+kLineW<=kLineW * 8) {
                        return;
                    }
                    [drag setTranslation:CGPointZero inView:drag.view];
                    self.sleepView.width = self.sleepView.width - kLineW;
                }else{
                    if (self.sleepView.endX>=kW-19*2) {
                        return;
                    }
                    //向右滑动
                    CGSize newSize = drag.view.frame.size;
                    newPosition.x = drag.view.center.x;
                    newPosition.y = 60;
                    newSize.width += kLineW;
                    if (newSize.width>=kLineW * kLineCount) {
                        return;
                    }
                    self.beganPoint = self.beganPoint + kLineW;
                    [drag setTranslation:CGPointZero inView:drag.view];
                    self.sleepView.width = self.sleepView.width + kLineW;
                }
            }
        }else{//不改变宽度
            if (absX > absY ) {
                if (newPosition.x<0) {
                    if (self.sleepView.frame.origin.x<kLineW) {
                        return;
                    }
                    //向左滑动
                    newPosition.x = -(kLineW) + drag.view.center.x;
                    newPosition.y = 60;
                    drag.view.center = newPosition;
                    [drag setTranslation:CGPointZero inView:drag.view];
                }else{
                    if (self.sleepView.endX>=kW-19*2) {
                        return;
                    }
                    //向右滑动
                    newPosition.x = kLineW + drag.view.center.x;
                    newPosition.y = 60;
                    drag.view.center = newPosition;
                    [drag setTranslation:CGPointZero inView:drag.view];
                }
            }
        }
    }
    
    self.asleepLabel.text = [self getAsleepTime:self.sleepView.frame.origin.x];
    self.awakelabel.text = [self getAsleepTime:self.sleepView.frame.origin.x+self.sleepView.frame.size.width];
    [self updateViewWidth:self.sleepView.frame.size.width-kLineW*4];
    self.rightView.x = self.sleepView.width - kLineW*4 - kLineW;
}

- (UILabel *)labelWithTitle:(NSString *)title color:(UIColor *)color font:(UIFont *)font TextAlignment:(NSTextAlignment)textAlignment NumberOfLines:(NSInteger)numberOfLines{
    UILabel *label = [[UILabel alloc] init];
    label.textColor = color;
    label.text = title;
    label.font = font;
    label.numberOfLines = numberOfLines;
    label.textAlignment = textAlignment;
    return label;
}

- (UIButton *)allocButtonWithType:(UIButtonType)buttonType buttonNormalStr:(NSString *)buttonNormalStr buttonSelectedStr:(NSString *)buttonSelectedStr buttonNormalColor:(UIColor *)buttonNormalColor buttonSelectedColor:(UIColor *)buttonSelectedColor buttonBackgroundColor:(UIColor *)buttonBackgroundColor buttonFont:(UIFont *)buttonFont cornerRadius:(NSInteger)cornerRadius {
    UIButton *button = [UIButton buttonWithType:buttonType];
    button.adjustsImageWhenHighlighted = NO;
    [button setTitle:buttonNormalStr forState:UIControlStateNormal];
    [button setTitle:buttonSelectedStr forState:UIControlStateSelected];
    [button setTitleColor:buttonNormalColor forState:UIControlStateNormal];
    [button setTitleColor:buttonSelectedColor forState:UIControlStateSelected];
    button.backgroundColor = buttonBackgroundColor;
    button.titleLabel.font = buttonFont;
    if (cornerRadius > 0) {
        button.layer.cornerRadius = cornerRadius;
        button.layer.masksToBounds = YES;
    }
    return button;
}

@end
