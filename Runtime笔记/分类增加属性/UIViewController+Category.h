//
//  UIViewController+Category.h
//  分类增加属性
//
//  Created by peterlee on 2020/8/9.
//  Copyright © 2020 peterlee. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIViewController (Category)
@property(nonatomic,strong) UIView *backgroundView;//新增一个可改变背景色的view
@end

NS_ASSUME_NONNULL_END
