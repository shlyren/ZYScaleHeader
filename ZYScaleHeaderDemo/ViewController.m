//
//  ViewController.m
//  ZYScaleHeaderDemo
//
//  Created by JiaQi on 2016/12/6.
//  Copyright © 2016年 任玉祥. All rights reserved.
//

#import "ViewController.h"
#import "TableViewController.h"
#import "ScrollViewController.h"
#import "NAVViewController.h"

@interface ViewController ()


@end

@implementation ViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"with nav";
    self.tableView.zy_header = [ZYScaleHeader headerWithImageNamed:@"backimage"];
    NSLog(@"%@", NSStringFromUIEdgeInsets(self.tableView.contentInset));

}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 8;
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
            cell.textLabel.text = @"push tableview controller";
            break;
        case 1:
            cell.textLabel.text = @"push scrollView controller";;
            break;
            
        case 2:
            cell.textLabel.text = @"push with navigation hidden";
            break;
        case 3:
            cell.textLabel.text = @"set `zy_header` nil";
            break;
        case 4:
            cell.textLabel.text = @"set a new `zy_header`";
            break;
            
        case 5:
            cell.textLabel.text = @"set a new `zy_header` image";
            break;
        case 6:
            cell.textLabel.text = @"present without navigation";
            break;
        case 7:
            cell.textLabel.text = @"dismissViewController";
            break;
            
        case 8:
            cell.textLabel.text = @"popViewController";
            break;
            default:break;
    }
    
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    [tableView deselectRowAtIndexPath:indexPath animated:true];
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    
    switch (indexPath.row) {
        case 0:
        {
            TableViewController *tableV = [TableViewController new];
            tableV.title = cell.textLabel.text;
            
             [self.navigationController pushViewController:tableV animated:true];
        }
            break;
        case 1:
        {
            ScrollViewController *scrollV = [ScrollViewController new];
            scrollV.title = cell.textLabel.text;
            [self.navigationController pushViewController:scrollV animated:true];

        }
            break;
            
        case 2:
        {
            [self.navigationController pushViewController:[NAVViewController new] animated:true];
        }
            break;
        case 3:
            tableView.zy_header = nil;
            break;
            
        case 4:
            tableView.zy_header = [ZYScaleHeader headerWithImageNamed:@"12312"];
            break;
            
        case 5:
            tableView.zy_header.image = [UIImage imageNamed:@"psb-10"];
            break;
        case 6:
            [self presentViewController:[ViewController new] animated:true completion:nil];
            break;
        case 7:
            [self dismissViewControllerAnimated:true completion:nil];
            break;
        case 8:
            [self.navigationController popViewControllerAnimated:true];
        default:break;
    }
    
   
}

@end
