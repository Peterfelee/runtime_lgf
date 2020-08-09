//
//  UIViewController+Category.m
//  分类增加属性
//
//  Created by peterlee on 2020/8/9.
//  Copyright © 2020 peterlee. All rights reserved.
//
/*
 分类增加属性 通过runtime 为分类增加关联对象，然后根据关联对想去获取响应的实例变量
 通过增加属性来实现一些功能
 
 */
#import "UIViewController+Category.h"
#import <objc/runtime.h>

const static NSString *backgroundViewAssiocateKey = @"backgroundViewAssiocateKey";

@implementation UIViewController (Category)

- (void)setBackgroundView:(UIView *)backgroundView
{
    objc_setAssociatedObject(self, &backgroundViewAssiocateKey, backgroundView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

-(UIView *)backgroundView
{
    return objc_getAssociatedObject(self, &backgroundViewAssiocateKey);
}


@end
