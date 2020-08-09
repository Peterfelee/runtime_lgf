//
//  TestModel.h
//  自动归解档
//
//  Created by peterlee on 2020/8/9.
//  Copyright © 2020 peterlee. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface TestModel : NSObject
@property(nonatomic,copy) NSString *name;
@property(nonatomic,assign) NSUInteger age;
@property(nonatomic,strong) NSArray *babys;
@end

NS_ASSUME_NONNULL_END
