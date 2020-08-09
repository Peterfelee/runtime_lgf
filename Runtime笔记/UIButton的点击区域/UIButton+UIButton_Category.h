//
//  UIButton+UIButton_Category.h
//  UIButton的点击区域
//
//  Created by peterlee on 2020/8/9.
//  Copyright © 2020 peterlee. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIButton (UIButton_Category)
///添加一个分类创建按钮的方法
+(instancetype)buttonWithTitle:(NSString *)title Image:(UIImage *)image;

@end

NS_ASSUME_NONNULL_END
