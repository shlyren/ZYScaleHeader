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

}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 10;
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
            cell.textLabel.text = @"present without navigation";
            break;
        case 6:
            cell.textLabel.text = @"dismissViewController";
            break;
            
        case 7:
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
            ZYScaleHeader *header = [ZYScaleHeader headerWithImageNamed:@"psb-12"];
            UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
            [btn setImage:[UIImage imageNamed:@"690"] forState:UIControlStateNormal];
            btn.frame = CGRectMake(header.frame.size.width * 0.5 - 40, header.frame.size.height - 100, 80, 80);
            [btn addTarget:tableV action:@selector(btnclick) forControlEvents:UIControlEventTouchUpInside];
            [header addSubview:btn];
            tableV.tableView.zy_header = header;
             [self.navigationController pushViewController:tableV animated:true];
        }
            break;
        case 1:
        {
            ScrollViewController *scrollV = [ScrollViewController new];
            scrollV.title = cell.textLabel.text;
            ZYScaleHeader *header = [ZYScaleHeader headerWithImageNamed:@"psb-10"];
            UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
            [btn setImage:[UIImage imageNamed:@"690"] forState:UIControlStateNormal];
            btn.frame = CGRectMake(header.frame.size.width * 0.5 - 50, header.frame.size.height - 150, 100, 100);
            [btn addTarget:scrollV action:@selector(btnclick) forControlEvents:UIControlEventTouchUpInside];
            [header addSubview:btn];
            
            UILabel *label = [UILabel new];
            [label setText:@"label"];
            [label setTextColor:[UIColor whiteColor]];
            [label setFont:[UIFont systemFontOfSize:15]];
            [label sizeToFit];
            
            label.frame = CGRectMake((header.frame.size.width - label.frame.size.width) * 0.5, CGRectGetMaxY(btn.frame) + 5, label.frame.size.width, label.frame.size.height);
            [header addSubview:label];
            scrollV.scrollView.zy_header = header;
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
            [self presentViewController:[ViewController new] animated:true completion:nil];
            break;
        case 6:
            [self dismissViewControllerAnimated:true completion:nil];
            break;
        case 7:
            [self.navigationController popViewControllerAnimated:true];
        default:break;
    }
    
   
}

@end
