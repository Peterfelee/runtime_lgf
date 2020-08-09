//
//  EasyJsonModel.m
//  字典转模型
//
//  Created by 樱桃李子 on 2020/8/9.
//  Copyright © 2020 peterlee. All rights reserved.
//

#import "EasyJsonModel.h"

@implementation EasyJsonModel

- (NSDictionary *)replaceKeys
{
    return @{@"tp":@"type"
             ,@"additionalInf":@"additionalInfo"
    };
}


@end
