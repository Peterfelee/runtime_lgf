//
//  ViewController.m
//  全屏测滑返回实现
//
//  Created by peterlee on 2020/8/9.
//  Copyright © 2020 peterlee. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor redColor];
    // Do any additional setup after loading the view.
    
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.navigationController pushViewController:[TestViewController new] animated:YES];
}





@end

#import "UINavigationController+fullScroll.h"

@interface TestViewController()


@end
 
@implementation TestViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor brownColor];
    [self.navigationController performSelector:NSSelectorFromString(@"test")];//可以调用类的私有方法
}

@end
