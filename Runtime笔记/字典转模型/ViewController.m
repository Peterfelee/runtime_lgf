//
//  ViewController.m
//  字典转模型
//
//  Created by peterlee on 2020/8/9.
//  Copyright © 2020 peterlee. All rights reserved.
//

#import "ViewController.h"
#import "EasyJsonModel.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self parseArray];
//    [self parseDict];
}

-(void)parseArray
{
    //获取字典
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"easy.json" ofType:nil];
    NSDictionary *jsonDict = [NSJSONSerialization JSONObjectWithData:[NSData dataWithContentsOfFile:filePath] options:NSJSONReadingAllowFragments error:nil];
    //转为model
    EasyJsonModel *model = [EasyJsonModel modelFromJsonDict:jsonDict];
    NSLog(@"%@",model.getString);
}


-(void)parseDict
{
    //获取数组
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"easyArray.json" ofType:nil];
    NSArray *jsonArray = [NSJSONSerialization JSONObjectWithData:[NSData dataWithContentsOfFile:filePath] options:NSJSONReadingAllowFragments error:nil];
    //转为model
    NSArray *models = [EasyJsonModel modelFromJsonArray:jsonArray];
    
    NSString *string = @"";
    for (EasyJsonModel *model in models)
    {
        string = [string stringByAppendingString:model.getString];
    }
    
    NSLog(@"%@",string);
}

@end
