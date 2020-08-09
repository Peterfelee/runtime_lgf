//
//  ViewController.m
//  Runtime笔记
//
//  Created by peterlee on 2020/8/8.
//  Copyright © 2020 peterlee. All rights reserved.
//
/*
 运行时
 获取属性
 获取实例变量
 */
#import "ViewController.h"
#import "NSObject+runtime.h"
#import "Person.h"
#import <objc/runtime.h>
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    [NSObject getProperty];
    
    
    unsigned int count = 0;
      //获取属性
      objc_property_t *pList = class_copyPropertyList([Person class], &count);
      
      for (int i = 0 ; i < count; i++)
      {
          objc_property_t p = pList[i];
          char const *name = property_getName(p);
          NSLog(@"%@",[NSString stringWithCString:name encoding:NSUTF8StringEncoding]);
      }
    
    //获取person类内部的实例变量
    Ivar *ivarList = class_copyIvarList([Person class], &count);
    for (int i = 0 ; i < count; i++)
    {
        Ivar var = ivarList[i];
        char const *name = ivar_getName(var);
        NSLog(@"%@",[NSString stringWithCString:name encoding:NSUTF8StringEncoding]);
    }
    
    
    
    
    // Do any additional setup after loading the view.
}


@end
