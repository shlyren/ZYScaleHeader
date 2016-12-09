//
//  XibTableViewController.m
//  ZYScaleHeaderDemo
//
//  Created by JiaQi on 2016/12/8.
//  Copyright © 2016年 任玉祥. All rights reserved.
//

#import "XibTableViewController.h"
#import "XibHeader.h"
#import "ZYScaleHeader.h"
@interface XibTableViewController ()

@end

@implementation XibTableViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    ZYScaleHeader *ScaleHeader = [ZYScaleHeader headerWithImage:[UIImage imageNamed:@"backimage"]];
    XibHeader *header = [[XibHeader alloc] initWithFrame:ScaleHeader.bounds];
    [ScaleHeader addSubview:header];
    
    self.tableView.zy_header = ScaleHeader;
}
@end
