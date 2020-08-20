//
//  AppDelegate.m
//  全屏测滑返回实现
//
//  Created by peterlee on 2020/8/9.
//  Copyright © 2020 peterlee. All rights reserved.
//

#import "AppDelegate.h"
#import "ViewController.h"
#import "UINavigationController+fullScroll.h"
#import "CustomViewController.h"
@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    self.window = [UIWindow new];
    self.window.frame = [UIScreen mainScreen].bounds;
    self.window.backgroundColor = [UIColor whiteColor];
    self.window.rootViewController = [[UINavigationController alloc]initWithRootViewController:[ViewController new]];
    [self.window makeKeyAndVisible];
    
    return YES;
}




@end
