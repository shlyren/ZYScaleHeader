//
//  TableViewController.m
//  ZYScaleHeaderDemo
//
//  Created by JiaQi on 2016/12/7.
//  Copyright © 2016年 任玉祥. All rights reserved.
//

#import "TableViewController.h"

@interface TableViewController ()

@end

@implementation TableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    
    UIImage *img = [UIImage imageNamed:@"tableViewHeader"];
    
    UIImageView *imgV = [[UIImageView alloc] initWithImage:img];
    imgV.frame =CGRectMake(0, 0, 0, self.view.frame.size.width * img.size.height / img.size.width);
    self.tableView.tableHeaderView = imgV;
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
