//
//  ScrollViewController.m
//  ZYScaleHeaderDemo
//
//  Created by JiaQi on 2016/12/7.
//  Copyright © 2016年 任玉祥. All rights reserved.
//

#import "ScrollViewController.h"

@interface ScrollViewController ()

@end

@implementation ScrollViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
     NSLog(@"%@", NSStringFromUIEdgeInsets(self.scrollView.contentInset));
}

- (UIScrollView *)scrollView
{
    if (_scrollView == nil) {
        UIScrollView *sc = [[UIScrollView alloc] initWithFrame:self.view.bounds];
        sc.backgroundColor = [UIColor whiteColor];
        //        sc.contentSize = CGSizeMake(self.view.frame.size.width, 1000);
        [self.view addSubview:_scrollView = sc];
    }
    
    return _scrollView;
}
- (void)btnclick
{
    if (self.navigationController) {
        [self.navigationController popViewControllerAnimated:true];
    }else{
        [self dismissViewControllerAnimated:true completion:nil];
    }
}
@end
