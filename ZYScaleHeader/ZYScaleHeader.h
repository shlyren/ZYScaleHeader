//
//  ZYScaleHeader.h
//  ZYScaleHeaderDemo
//
//  Created by JiaQi on 2016/12/6.
//  Copyright © 2016年 任玉祥. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZYScaleHeader : UIView
@property (nonatomic, strong) UIImage *image;

/**
 通过图片名创建一个headerview
 默认宽度为屏幕的宽度, 高度为 宽度 * image高度 / image宽度

 @param imgName imagename
 @return ZYScaleHeader 对象
 */
+ (instancetype)headerWithImageNamed:(NSString *)imgName;
+ (instancetype)headerWithImage:(UIImage *)image;


+ (instancetype)headerWithImageNamed:(NSString *)imgName height:(CGFloat)height;
+ (instancetype)headerWithImage:(UIImage *)image height:(CGFloat)height;
@end

@interface UIScrollView (ZYScaleHeader)
@property (nonatomic, weak) ZYScaleHeader *zy_header;
@end
