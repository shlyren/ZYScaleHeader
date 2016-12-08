//
//  NAVViewController.m
//  ZYScaleHeaderDemo
//
//  Created by JiaQi on 2016/12/7.
//  Copyright © 2016年 任玉祥. All rights reserved.
//

#import "NAVViewController.h"


#import "TableViewController.h"
#import "ScrollViewController.h"


@interface NAVViewController ()

@end

@implementation NAVViewController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:true];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self.navigationController setNavigationBarHidden:false];
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.title = @"whitout nav";
    }
    
    return self;
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.tableView.zy_header = [ZYScaleHeader headerWithImageNamed:@"backimage"];
    NSLog(@"%@", NSStringFromUIEdgeInsets(self.tableView.contentInset));
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 7;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *ID = @"cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    
    
    switch (indexPath.row) {
        case 0:
            cell.textLabel.text = @"present tableview controller";
            break;
        case 1:
            cell.textLabel.text = @"present scrollView controller";;
            break;
            
        case 2:
            cell.textLabel.text = @"set `zy_header` nil";
            break;
        case 3:
            cell.textLabel.text = @"set a new `zy_header`";
            break;
        case 4:
            cell.textLabel.text = @"present with navigation";
            break;
        case 5:
            cell.textLabel.text = @"dismissViewController";
            break;
        case 6:
            cell.textLabel.text = @"popViewController";
            break;
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    [tableView deselectRowAtIndexPath:indexPath animated:true];
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    
    switch (indexPath.row)
    {
        case 0:
        {
            TableViewController *tableV = [TableViewController new];
            tableV.title = cell.textLabel.text;
            [self presentViewController:tableV animated:true completion:nil];
        }
            break;
        case 1:
        {
            ScrollViewController *scrollV = [ScrollViewController new];
            scrollV.title = cell.textLabel.text;
            [self presentViewController:scrollV animated:true completion:nil];
            
        }
            break;
            
        case 2:
            tableView.zy_header = nil;
            break;
            
        case 3:
            tableView.zy_header = [ZYScaleHeader headerWithImageNamed:@"12312"];
            break;
        case 4:
        {
            UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:[ViewController new]];
            [self presentViewController:nav animated:true completion:nil];
        }
            break;
        case 5:
            [self dismissViewControllerAnimated:true completion:nil];
            break;
        case 6:
            [self.navigationController popViewControllerAnimated:true];
            break;
            
    }
    
    
}
@end
