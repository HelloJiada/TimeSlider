//
//  UIView+LayoutExtension.h
//  Zeplin
//
//  Created by JiaDa on 2021/12/14.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
 
@interface UIView (LayoutExtension)

@property (nonatomic, assign)CGFloat x;
@property (nonatomic, assign)CGFloat y;
//  结束x坐标(selfX + selfWidth)
@property (nonatomic, assign) CGFloat endX;
//  结束y坐标(selfY + selfHeight)
@property (nonatomic, assign) CGFloat endY;
@property (nonatomic, assign)CGFloat width;
@property (nonatomic, assign)CGFloat height;
@property (nonatomic, assign)CGFloat centerX;
@property (nonatomic, assign)CGFloat centerY;
@property (nonatomic, assign)CGSize size;

@property(nonatomic, assign) IBInspectable CGFloat borderWidth;
@property(nonatomic, assign) IBInspectable UIColor *borderColor;
@property(nonatomic, assign) IBInspectable CGFloat cornerRadius;
 
/**
 *  水平居中
 */
- (void)alignHorizontal;
/**
 *  垂直居中
 */
- (void)alignVertical;
/**
 *  判断是否显示在主窗口上面
 *
 *  @return 是否
 */
- (BOOL)isShowOnWindow;

- (UIViewController *)parentController;

- (void)setCornerRadius:(CGFloat)radius withShadow:(BOOL)shadow withOpacity:(CGFloat)opacity;

@end

NS_ASSUME_NONNULL_END
