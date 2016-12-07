//
//  TabBarController.m
//  ZYScaleHeaderDemo
//
//  Created by JiaQi on 2016/12/7.
//  Copyright © 2016年 任玉祥. All rights reserved.
//

#import "TabBarController.h"
#import "ViewController.h"
#import "NAVViewController.h"

@interface TabBarController ()

@end

@implementation TabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:[ViewController new]];
    [self addChildViewController:nav];
    [self addChildViewController:[NAVViewController new]];
}


@end
