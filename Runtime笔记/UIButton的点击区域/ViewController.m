//
//  ViewController.m
//  UIButton的点击区域
//
//  Created by peterlee on 2020/8/8.
//  Copyright © 2020 peterlee. All rights reserved.
//
/*
 按钮的响应流程
 按钮的扩大点击区域处理
 控制暴力点击
 同时控制暴力手势问题 ？ 暂时待定处理
 */

#import "ViewController.h"
#import "UIButton+UIButton_Category.h"

@interface ViewController ()

@property(nonatomic,strong) UIButton *testButton;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    UIView *testView = [UIView new];
    testView.frame = self.view.bounds;
    [self.view addSubview:testView];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(gestureClick:)];
    [testView addGestureRecognizer:tap];
    
    _testButton = [UIButton buttonWithTitle:@"扩大按钮显示" Image:nil];
    [self.view addSubview:_testButton];
//    [testView addSubview:_testButton];

    [_testButton sizeThatFits:CGSizeMake(100, 50)];
    _testButton.frame = CGRectMake(100, 100, 100, 50);
    [_testButton addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    
    
}



-(void)buttonClick:(UIButton *)btn
{
    NSLog(@"%@ is clicked",btn.currentTitle);
}

-(void)gestureClick:(UIGestureRecognizer *)gesture
{
    NSLog(@"%@ is clicked",NSStringFromClass([gesture.view class]));
}


@end
