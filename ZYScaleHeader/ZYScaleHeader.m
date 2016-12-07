//
//  ZYScaleHeader.m
//  ZYScaleHeaderDemo
//
//  Created by JiaQi on 2016/12/6.
//  Copyright © 2016年 任玉祥. All rights reserved.
//

#import "ZYScaleHeader.h"
#import <objc/runtime.h>
#define ZYScreenW [UIScreen mainScreen].bounds.size.width


@interface ZYImageView : UIImageView
@end
@implementation ZYImageView
@end

@interface ZYScaleHeader ()
/** defult is nil */
@property (nonatomic, weak) ZYImageView *imageView;
@property (nonatomic, weak) UIScrollView *scrollView;
@end

@implementation ZYScaleHeader
+ (instancetype)headerWithImage:(NSString *)img
{
    ZYScaleHeader *header = [ZYScaleHeader new];
    UIImage *image = [UIImage imageNamed:img];
    
    if (!image) {
        return nil;
    }
    CGSize imgSize = image.size;
    CGFloat imgH = ZYScreenW * (imgSize.height / imgSize.width);
    header.frame = CGRectMake(0, 0, 0, imgH);
    
    ZYImageView *imageV = [[ZYImageView alloc] initWithImage:image];
    imageV.frame = header.bounds;
    imageV.contentMode = UIViewContentModeScaleAspectFill;
    imageV.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleHeight;
    header.clipsToBounds = true;
    [header addSubview:imageV];
    
    return header;
}

- (CGFloat)height
{
    return self.frame.size.height;
}

- (void)setFrame:(CGRect)frame
{
    CGFloat height = frame.size.height;
    [super setFrame:CGRectMake(0, -height, ZYScreenW, height)];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    for (UIView *subView in self.subviews)
    {
        if ([subView isKindOfClass:[ZYImageView class]]) continue;
        subView.autoresizingMask = UIViewAutoresizingFlexibleTopMargin;
    }
}

- (void)willMoveToSuperview:(UIView *)newSuperview
{
    [super willMoveToSuperview:newSuperview];
    
    // 如果不是UIScrollView，不做任何事情
    if (newSuperview && ![newSuperview isKindOfClass:[UIScrollView class]]) return;
    
    // 旧的父控件移除监听
    [self removeObservers];
    
    if (newSuperview) {
        
        // 记录UIScrollView
        _scrollView = (UIScrollView *)newSuperview;
        // 设置永远支持垂直弹簧效果
        _scrollView.alwaysBounceVertical = YES;
        // 设置UIScrollView的contentInset
        _scrollView.contentInset = UIEdgeInsetsMake(self.frame.size.height, 0, 0, 0);
        
        // 添加监听
        [self addObservers];
    }
}

#pragma mark - KVO监听
- (void)addObservers
{
#ifdef DEBUG
    NSLog(@"%s %@", __func__, self.scrollView.class);
#endif
    [self.scrollView addObserver:self forKeyPath:@"contentOffset" options:NSKeyValueObservingOptionNew context:nil];
}

- (void)removeObservers
{
#ifdef DEBUG
    NSLog(@"%s %@", __func__, self.superview.class);
#endif
    [self.superview removeObserver:self forKeyPath:@"contentOffset"];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context
{
    CGFloat offSetY = self.scrollView.contentOffset.y + self.frame.size.height;
    if (offSetY)
    {
        CGFloat height = self.frame.size.height - offSetY;
        self.frame = CGRectMake(0, -height, self.frame.size.width, height);
    }
}

@end


@implementation UIScrollView (ZYScaleHeader)
static char ZYScaleHeaderKey = '\0';
- (void)setZy_header:(ZYScaleHeader *)zy_header
{
    if (self.zy_header == zy_header) return;
    
    [self.zy_header removeFromSuperview];
    objc_setAssociatedObject(self, &ZYScaleHeaderKey, zy_header, OBJC_ASSOCIATION_ASSIGN);
    
    [self insertSubview:zy_header atIndex:0];
    
}

- (ZYScaleHeader *)zy_header
{
    return objc_getAssociatedObject(self, &ZYScaleHeaderKey);
}


@end
