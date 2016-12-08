//
//  ScrollViewController.m
//  ZYScaleHeaderDemo
//
//  Created by JiaQi on 2016/12/7.
//  Copyright © 2016年 任玉祥. All rights reserved.
//

#import "ScrollViewController.h"
#import "ZYScaleHeader.h"

@interface ScrollViewController ()

@end

@implementation ScrollViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
    ZYScaleHeader *header = [ZYScaleHeader headerWithImageNamed:@"psb-10" height:250];
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setImage:[UIImage imageNamed:@"690"] forState:UIControlStateNormal];
    btn.frame = CGRectMake(header.frame.size.width * 0.5 - 25, header.frame.size.height - 70, 50, 50);
    [btn addTarget:self action:@selector(btnclick) forControlEvents:UIControlEventTouchUpInside];
    [header addSubview:btn];
    
    UILabel *label = [UILabel new];
    [label setText:@"label"];
    [label setTextColor:[UIColor whiteColor]];
    [label setFont:[UIFont systemFontOfSize:15]];
    [label sizeToFit];
    
    label.frame = CGRectMake((header.frame.size.width - label.frame.size.width) * 0.5, CGRectGetMaxY(btn.frame), label.frame.size.width, label.frame.size.height);
    [header addSubview:label];
    self.scrollView.zy_header = header;
    
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
