//
//  NSObject+runtime.m
//  Runtime笔记
//
//  Created by peterlee on 2020/8/8.
//  Copyright © 2020 peterlee. All rights reserved.
//

#import "NSObject+runtime.h"
#import "Person.h"
#import <objc/runtime.h>

@implementation NSObject (runtime)

+(void)getProperty
{
    NSInteger count = 0;
    
    objc_property_t *pList = class_copyPropertyList([Person class], &count);
    
    for (int i = 0 ; i < count; i++)
    {
        objc_property_t p = pList[i];
        char const *name = property_getName(p);
        NSLog(@"%@",[NSString stringWithCString:name encoding:NSUTF8StringEncoding]);
    }
    
}

@end
