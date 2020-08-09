//
//  ViewController.m
//  交换方法
//
//  Created by peterlee on 2020/8/9.
//  Copyright © 2020 peterlee. All rights reserved.
//

/*交换方法其实就是对系统方法的替换，用我们自定义的方法来处理系统级问题 常用语埋点统计中
 需求：统计每个页面的加载
 */

#import "ViewController.h"
#import <objc/runtime.h>

@interface ViewController ()

@end

@implementation ViewController

+ (void)load
{
    Method oldM = class_getInstanceMethod([self class], @selector(viewDidLoad));
    Method newM = class_getInstanceMethod([self class], @selector(custom_viewDidLoad));
    
//    BOOL add = class_addMethod([self class], @selector(custom_viewDidLoad), newM, method_getTypeEncoding(newM));
    
    //交换方法一 内部调用的就是下面这两个方法
    method_exchangeImplementations(oldM, newM);
    
//    //交换方法二
//    class_replaceMethod([self class], @selector(viewDidLoad), class_getMethodImplementation([self class], @selector(custom_viewDidLoad)), method_getTypeEncoding(oldM));
    
    
    //交换方法三 交换方法的实质
//    method_setImplementation(oldM, class_getMethodImplementation([self class], @selector(custom_viewDidLoad)));
//    method_setImplementation(newM, class_getMethodImplementation([self class], @selector(viewDidLoad)));
    

    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    NSLog(@"%s",__func__);
}

-(void)custom_viewDidLoad{
    NSLog(@"%s",__func__);
}

@end
