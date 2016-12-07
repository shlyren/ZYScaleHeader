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

@interface ViewController ()


@end

@implementation ViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"normal";
    self.tableView.zy_header = [ZYScaleHeader headerWithImage:@"backimage"];
    
    
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
    
    cell.textLabel.text = [NSString stringWithFormat:@"样式 %zd", indexPath.row];
    
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
            ZYScaleHeader *header = [ZYScaleHeader headerWithImage:@"backimage"];
            UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
            [btn setImage:[UIImage imageNamed:@"690"] forState:UIControlStateNormal];
            btn.frame = CGRectMake(header.frame.size.width * 0.5 - 25, header.frame.size.height - 20, 50, 50);
            [btn addTarget:self action:@selector(btnclick) forControlEvents:UIControlEventTouchUpInside];
            [header addSubview:btn];
            tableV.tableView.zy_header = header;
             [self.navigationController pushViewController:tableV animated:true];
        }
            break;
        case 1:
        {
            ScrollViewController *scrollV = [ScrollViewController new];
            scrollV.title = cell.textLabel.text;
            ZYScaleHeader *header = [ZYScaleHeader headerWithImage:@"backimage"];
            UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
            [btn setImage:[UIImage imageNamed:@"690"] forState:UIControlStateNormal];
            btn.frame = CGRectMake(header.frame.size.width * 0.5 - 25, header.frame.size.height - 20, 50, 50);
            [btn addTarget:self action:@selector(btnclick) forControlEvents:UIControlEventTouchUpInside];
            [header addSubview:btn];
            scrollV.scrollView.zy_header = header;
            [self.navigationController pushViewController:scrollV animated:true];

        }
            
            break;
        case 2:
            
            break;
        case 3:
            
            break;
        default:
            break;
    }
    
   
}

- (void)btnclick
{
#ifdef DEBUG
    NSLog(@"%s", __func__);
#endif
}
@end
