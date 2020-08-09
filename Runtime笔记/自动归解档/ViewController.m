//
//  ViewController.m
//  自动归解档
//
//  Created by peterlee on 2020/8/9.
//  Copyright © 2020 peterlee. All rights reserved.
//

#import "ViewController.h"
#import "TestModel.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    TestModel *model = [TestModel new];
    model.name = @"name";
    model.age = 10;
    model.babys = @[@[@1,@3]];
    
    NSError *dataError;
    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:model requiringSecureCoding:YES error:&dataError];
    //保存
    NSString *filePath = [NSHomeDirectory() stringByAppendingPathComponent:@"archiverFile"];
    NSError *writeError;
    [data writeToFile:filePath options:NSDataWritingAtomic error:&writeError];
    
    //解档
    NSData *unData = [NSData dataWithContentsOfFile:filePath];
    NSError *unError;
    NSSet *set = [NSSet setWithArray:@[[NSArray class],[TestModel class]]];
//    TestModel *unModel = [NSKeyedUnarchiver unarchivedObjectOfClass:[NSObject class] fromData:unData error:&unError];
    
    TestModel *unModel = [NSKeyedUnarchiver unarchivedObjectOfClasses:set fromData:unData error:&unError];
    NSLog(@"%@",unModel.description);
}


@end
