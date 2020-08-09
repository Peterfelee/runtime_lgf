//
//  NSObject+jsonModel.h
//  字典转模型
//
//  Created by 樱桃李子 on 2020/8/9.
//  Copyright © 2020 peterlee. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSObject (jsonModel)

/// 要替换的json中的key1和模型中的key2 返回字典为@{key2:key1}
-(NSDictionary *)replaceKeys;

+(NSArray *)modelFromJsonArray:(NSArray *)jsonArray;

+(instancetype)modelFromJsonDict:(NSDictionary *)jsonDict;

-(NSString *)getString;

@end

NS_ASSUME_NONNULL_END
