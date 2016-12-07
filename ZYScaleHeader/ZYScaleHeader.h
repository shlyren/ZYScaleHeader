//
//  ZYScaleHeader.h
//  ZYScaleHeaderDemo
//
//  Created by JiaQi on 2016/12/6.
//  Copyright © 2016年 任玉祥. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZYScaleHeader : UIView
+ (instancetype)headerWithImageNamed:(NSString *)imgName;
+ (instancetype)headerWithImage:(UIImage *)image;
@end

@interface UIScrollView (ZYScaleHeader)
@property (nonatomic, weak) ZYScaleHeader *zy_header;
@end
