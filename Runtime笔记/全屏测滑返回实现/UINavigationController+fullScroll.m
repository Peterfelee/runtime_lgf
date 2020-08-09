//
//  UINavigationController+fullScroll.m
//  全屏测滑返回实现
//
//  Created by 樱桃李子 on 2020/8/9.
//  Copyright © 2020 peterlee. All rights reserved.
//

#import "UINavigationController+fullScroll.h"
#import <objc/runtime.h>
/*
 思路来源参考 https://www.jianshu.com/p/d39f7d22db6c
 具体更详细的实现https://github.com/forkingdog/FDFullscreenPopGesture
 */
@interface UINavigationController()

@property(nonatomic,strong)UIPanGestureRecognizer  *popGesture;

@end

@implementation UINavigationController (fullScroll)

///设置只读属性
- (UIPanGestureRecognizer *)popGesture
{
    UIPanGestureRecognizer *gesture = objc_getAssociatedObject(self, _cmd);
    if (!gesture)
    {
        gesture = [[UIPanGestureRecognizer alloc]init];
        gesture.maximumNumberOfTouches = 1;
        objc_setAssociatedObject(self, _cmd, gesture, OBJC_ASSOCIATION_RETAIN);
    }
    return gesture;
}

+ (void)load
{
    //为什么这么写 可以查看这篇文章http://www.cocoachina.com/articles/19704
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        //交换导航控制器里面的push方法
        Method oldMethod = class_getInstanceMethod([self class], @selector(pushViewController:animated:));
        Method newMethod = class_getInstanceMethod([self class], @selector(custom_pushViewController:animated:));

        BOOL isAdd = class_addMethod([self class], @selector(pushViewController:animated:), method_getImplementation(newMethod), method_getTypeEncoding(newMethod));
        if (isAdd)
        {
            class_replaceMethod([self class], @selector(custom_pushViewController:animated:), method_getImplementation(oldMethod), method_getTypeEncoding(oldMethod));
        }
        else
        {
            method_exchangeImplementations(oldMethod, newMethod);
        }
        
//        //测试代码
//        Method oldMethod = class_getInstanceMethod([self class], @selector(test));
//        Method newMethod = class_getInstanceMethod([self class], @selector(new_test));
//
//        BOOL isAdd = class_addMethod([self class], @selector(test), method_getImplementation(newMethod), method_getTypeEncoding(newMethod));
//        if (isAdd)
//        {
//            class_replaceMethod([self class], @selector(new_test), method_getImplementation(oldMethod), method_getTypeEncoding(oldMethod));
//        }
//        else
//        {
//            method_exchangeImplementations(oldMethod, newMethod);
//        }
        
    });
    
    
}

-(void)test{
    NSLog(@"%s",__func__);
}


-(void)new_test{
    NSLog(@"%s",__func__);
    [self new_test];
}

//- (void)viewDidLoad
//{
//    [super viewDidLoad];
//
//}

- (void)custom_pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    //主要处理侧滑全屏的逻辑
    BOOL hasCustomPop = [self.interactivePopGestureRecognizer.view.gestureRecognizers containsObject:self.popGesture];
    if (!hasCustomPop)
    {
        //如果导航控制器里面没有新增我们自定义的手势的话
        //添加我们自定义的手势
        [self.interactivePopGestureRecognizer.view addGestureRecognizer:self.popGesture];
        
        //先去获取原来控制器中的target
        NSArray *targets = [self.interactivePopGestureRecognizer valueForKey:@"targets"];
        
        id target = [targets.firstObject valueForKey:@"target"];
        SEL action = NSSelectorFromString(@"handleNavigationTransition:");
        [self.popGesture addTarget:target action:action];
        self.popGesture.delegate = self.interactivePopGestureRecognizer.delegate;
        self.interactivePopGestureRecognizer.enabled = NO;
    }
    
    if (![self.viewControllers containsObject:viewController]) {
        ///因为我们在load的时候已经做过方法交换 所以此时调用custom_pushViewController 就相当于在触发系统的pushViewController 然后让系统的pushViewController把其内在的逻辑处理完毕 这个方法内部其实就是想导航控制器的栈内添加一个viewController 可以通过自己新增一个自定义的方法来去实验
        [self custom_pushViewController:viewController animated:YES];
        NSLog(@"custom%s",__func__);
    }
}

///根据消息转发机制 处理 我们在调用没有实现的方法时的逻辑 通过动态方法解析的方式 去新增一个实现 来完成这个方法的完整调用
//void replace_test(id self,SEL sel)
//{
//    NSLog(@"%@ %@",self,NSStringFromSelector(sel));
//}
//
//+ (BOOL)resolveInstanceMethod:(SEL)sel
//{
//    if (sel == NSSelectorFromString(@"test"))
//    {
//        class_addMethod([self class], @selector(test), replace_test, "v@:");
//        return YES;
//    }
//    return [super resolveInstanceMethod:sel];
//}

@end
