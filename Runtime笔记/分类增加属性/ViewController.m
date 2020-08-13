//
//  ViewController.m
//  分类增加属性
//
//  Created by peterlee on 2020/8/9.
//  Copyright © 2020 peterlee. All rights reserved.
//

#import "ViewController.h"
#import "UIViewController+Category.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.backgroundView = [UIView new];
    UITableViewCell
    self.backgroundView.backgroundColor = UIColor.redColor;
    [self.view addSubview:self.backgroundView];
    self.backgroundView.frame = self.view.bounds;
    
    // Do any additional setup after loading the view.
}


@end
