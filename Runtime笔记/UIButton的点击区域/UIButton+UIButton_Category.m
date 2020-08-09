//
//  UIButton+UIButton_Category.m
//  UIButton的点击区域
//
//  Created by peterlee on 2020/8/9.
//  Copyright © 2020 peterlee. All rights reserved.
//

#import "UIButton+UIButton_Category.h"
#import <objc/runtime.h>

static const NSInteger timeInterval = 2;
@interface UIButton()
@property(nonatomic,assign) BOOL isClicking;
@end

@implementation UIButton (UIButton_Category)

- (void)setIsClicking:(BOOL)isClicking
{
    objc_setAssociatedObject(self, @"uibutton_associtated_isClicking", @(isClicking), OBJC_ASSOCIATION_ASSIGN);
}
- (BOOL)isClicking
{

    return [objc_getAssociatedObject(self, @"uibutton_associtated_isClicking") boolValue];
}


/// 自定义一个构建按钮的方法
/// @param title 设置标题的字符串
/// @param image 设置显示图的图片
+ (instancetype)buttonWithTitle:(NSString *)title Image:(UIImage *)image
{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setTitle:title forState:0];
    [btn setImage:image forState:0];
    UIImage *colorImage = [UIImage imageWithColor:[UIColor brownColor] size:CGSizeMake(10, 10)];
    [btn setBackgroundImage:colorImage forState:0];
    UIImage *heighlightColorImage = [UIImage imageWithColor:[[UIColor brownColor] colorWithAlphaComponent:0.5] size:CGSizeMake(10, 10)];
    [btn setBackgroundImage:heighlightColorImage forState:UIControlStateHighlighted];
    btn.layer.cornerRadius = 10;
    btn.layer.masksToBounds = YES;
    return btn;
}


/// 处理多次点击的问题 可以通过一个变量来控制多久一次的点击
/// @param action 响应时调用的action 其实就是一个sel
/// @param target 响应者目标对象
/// @param event 响应的事件 当前点击事件UITouchesEvent
- (void)sendAction:(SEL)action to:(id)target forEvent:(UIEvent *)event
{
    NSLog(@"%ld",timeInterval);
    if (self.isClicking)
    {
        return;
    }
    self.isClicking  = YES;
    [super sendAction:action to:target forEvent:event];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(timeInterval * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        self.isClicking = NO;
    });
}

///响应点击的响应方法
- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event
{
    NSLog(@"%@",NSStringFromCGPoint(point));
    return [super hitTest:point withEvent:event];
}

///判断点击的范围是不是在按钮的范围内
- (BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event
{
    CGRect buttonFrame = self.bounds;
       //扩大区域
       CGFloat padding = 50;
       buttonFrame.origin.x -= padding;
       buttonFrame.origin.y -= padding;
       buttonFrame.size.width += padding;
       buttonFrame.size.height += padding;
    NSLog(@"%@",NSStringFromCGRect(buttonFrame));
//    CGPoint covert =  [self convertPoint:point toView:self.superview];
    if (CGRectContainsPoint(buttonFrame, point))
    {
       return YES;
    }
    
    return NO;
}


@end
