//
//  TestModel.m
//  自动归解档
//
//  Created by peterlee on 2020/8/9.
//  Copyright © 2020 peterlee. All rights reserved.
//

#import "TestModel.h"
#import <objc/runtime.h>

@interface TestModel()<NSSecureCoding>

@end

@implementation TestModel

+ (BOOL)supportsSecureCoding
{
    return YES;
}

- (void)encodeWithCoder:(NSCoder *)coder
{
    [self setPropertyTo:coder];
}

- (instancetype)initWithCoder:(NSCoder *)coder
{
    if (self = [super init])
    {
        [self setPropertyWith:coder];
    }
    return self;
}

-(void)setPropertyWith:(NSCoder *)coder
{
//    self.name = [coder decodeObjectForKey:@"name"];
//    self.age = [coder decodeIntegerForKey:@"age"];
//    self.babys = [coder decodeObjectForKey:@"babys"];
    
    unsigned int count = 0;
    Ivar *ivarList = class_copyIvarList([self class], &count);
    if (count <= 0)
    {
        return;
    }
    for (int i = 0 ;i<count ; i++) {
        Ivar ivar = ivarList[i];
        NSString *key = [NSString stringWithCString:ivar_getName(ivar) encoding:NSUTF8StringEncoding];
        //解档
        id value = [coder decodeObjectForKey:key];
        [self setValue:value forKey:key];
    }
}

-(void)setPropertyTo:(NSCoder *)coder
{
//    [coder encodeObject:self.name forKey:@"name"];
//    [coder encodeInteger:self.age forKey:@"age"];
//    [coder encodeObject:self.babys forKey:@"babys"];


    unsigned int count = 0;
    ///获取实例变量数组
    Ivar *ivarList = class_copyIvarList([self class], &count);
    if (count <= 0)
    {
        return;
    }
    for (int i = 0 ;i<count ; i++) {
        Ivar ivar = ivarList[i];
        NSString *key = [NSString stringWithCString:ivar_getName(ivar) encoding:NSUTF8StringEncoding];
        id value = [self valueForKey:key];
        //归档
        [coder encodeObject:value forKey:key];
    }
    
}

- (NSString *)description
{
    return [NSString stringWithFormat:@"\nname=%@\nage=%ld\nbabys=%@\n",self.name,self.age,self.babys];
}




@end
