//
//  TableViewController.m
//  ZYScaleHeaderDemo
//
//  Created by JiaQi on 2016/12/7.
//  Copyright © 2016年 任玉祥. All rights reserved.
//

#import "TableViewController.h"
#import "ZYScaleHeader.h"
#import "XibTableViewController.h"

@interface TableViewController ()

@end

@implementation TableViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    ZYScaleHeader *header = [ZYScaleHeader headerWithImage:[UIImage imageNamed:@"psb-12"]];
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setImage:[UIImage imageNamed:@"690"] forState:UIControlStateNormal];
    btn.frame = CGRectMake(header.frame.size.width * 0.5 - 40, header.frame.size.height - 100, 80, 80);
    [btn addTarget:self action:@selector(btnclick) forControlEvents:UIControlEventTouchUpInside];
    [header addSubview:btn];
    self.tableView.zy_header = header;
    
    NSLog(@"%@", NSStringFromUIEdgeInsets(self.tableView.contentInset));
    
    
    UIImage *img = [UIImage imageNamed:@"tableViewHeader"];
    UIImageView *imgV = [[UIImageView alloc] initWithImage:img];
    imgV.frame =CGRectMake(0, 0, 0, self.view.frame.size.width * img.size.height / img.size.width);
    self.tableView.tableHeaderView = imgV;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 4;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *ID = @"cellID";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
    }
    
    if (indexPath.row == 0) {
        cell.textLabel.text = @"push xib header";
    }else if (indexPath.row == 1)
    {
        cell.textLabel.text = @"set a new header";
    }else if(indexPath.row == 2) {
        cell.textLabel.text = @"change header image";

    }else if(indexPath.row == 3) {
        cell.textLabel.text = @"change header height";
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{

    if (indexPath.row == 0) {
        XibTableViewController *vc = [XibTableViewController new];
        vc.title = @"xib header";
        [self.navigationController pushViewController:vc animated:true];
    }else if (indexPath.row == 1) {
            ZYScaleHeader *header = [ZYScaleHeader headerWithImage:[UIImage imageNamed:@"backimage"] height:200];
            UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
            [btn setImage:[UIImage imageNamed:@"690"] forState:UIControlStateNormal];
            btn.frame = CGRectMake(header.frame.size.width * 0.5 - 40, header.frame.size.height - 100, 80, 80);
            [btn addTarget:self action:@selector(btnclick) forControlEvents:UIControlEventTouchUpInside];
            [header addSubview:btn];
            tableView.zy_header = header;
    }else if (indexPath.row == 2) {
        tableView.zy_header.image = [UIImage imageNamed:@"psb-10"];
    }else  if (indexPath.row == 3) {
        tableView.zy_header.frame = CGRectMake(0, 0, tableView.frame.size.width, 150);
    }
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
