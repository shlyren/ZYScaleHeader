//
//  Header.m
//  ZYScaleHeaderDemo
//
//  Created by JiaQi on 2016/12/8.
//  Copyright © 2016年 任玉祥. All rights reserved.
//

#import "XibHeader.h"

@implementation XibHeader

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self = [[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self.class) owner:nil options:nil].firstObject;
        self.frame = frame;
    }
    return self;
}
- (IBAction)btnclick {
#ifdef DEBUG
    NSLog(@"%s", __func__);
#endif
}

@end
