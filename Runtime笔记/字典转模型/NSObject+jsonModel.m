//
//  NSObject+jsonModel.m
//  字典转模型
//
//  Created by 樱桃李子 on 2020/8/9.
//  Copyright © 2020 peterlee. All rights reserved.
//

#import "NSObject+jsonModel.h"
#import <objc/runtime.h>

@implementation NSObject (jsonModel)

- (NSDictionary *)replaceKeys
{
    return @{};
}

+ (NSArray *)modelFromJsonArray:(NSArray *)jsonArray
{
    NSMutableArray *arr = [NSMutableArray arrayWithCapacity:jsonArray.count];
    for (NSObject *obj in jsonArray)
    {
        if ([obj isKindOfClass:[NSString class]])//字符串的话 直接返回
        {
            [arr addObject:obj];
        }
        else if ([obj isKindOfClass:[NSArray class]])
        {
            [arr addObject:[self modelFromJsonArray:(NSArray *)obj]];
        }
        else if ([obj isKindOfClass:[NSDictionary class]])
        {
            [arr addObject:[self modelFromJsonDict:(NSDictionary *)obj]];
        }
    }
    return arr;
}

+ (instancetype)modelFromJsonDict:(NSDictionary *)jsonDict
{
    id model = [self getModel];
    //获取这个id的类型的所有属性 然后根据属性去取对应的值
    unsigned int count = 0;
    objc_property_t *pList = class_copyPropertyList([self class], &count);
    for (int i = 0; i<count; i++)
    {
        objc_property_t p = pList[i];
        //获取对应的名字
        NSString *key = [NSString stringWithCString:property_getName(p) encoding:NSUTF8StringEncoding];
        if (jsonDict[key])
        {
            [model setValue:jsonDict[key] forKey:key];
        }
        else
        {//处理字段替换的问题
            NSString *replaceKey = [model replaceKeys][key];
            if (jsonDict[replaceKey])
            {
                [model setValue:jsonDict[replaceKey] forKey:key];
            }
        }
    }
    free(pList);
    return model;
}


+(instancetype)getModel
{
    //通过runtime获取到这个类的名字 然后创建
    //也可以通过两次映射去创建
    NSString *className = NSStringFromClass(self);
    id model = [NSClassFromString(className) new];
//    NSString *className = [NSString stringWithCString:class_getName([self class]) encoding:NSUTF8StringEncoding];
//    id model = [NSClassFromString(className) new];
    return model;
}

-(NSString*)getString
{
    //获取这个id的类型的所有属性 然后根据属性去取对应的值
    unsigned int count = 0;
    objc_property_t *pList = class_copyPropertyList([self class], &count);
    NSString *string  = @"";
    for (int i = 0; i<count; i++)
    {
        objc_property_t p = pList[i];
        //获取对应的名字
        NSString *key = [NSString stringWithCString:property_getName(p) encoding:NSUTF8StringEncoding];
        string = [string stringByAppendingFormat:@"\n%@:%@",key,[self valueForKey:key]];
    }
    free(pList);
    return string;
}

@end
