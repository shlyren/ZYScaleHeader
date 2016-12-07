//
//  ZYScaleHeader.m
//  ZYScaleHeaderDemo
//
//  Created by JiaQi on 2016/12/6.
//  Copyright © 2016年 任玉祥. All rights reserved.
//

#import "ZYScaleHeader.h"
#import <objc/runtime.h>

#pragma mark - 获取当前view的控制
@implementation UIView (Extend)
- (UIViewController *)viewController
{
    for (UIView *next = [self superview]; next; next = next.superview)
    {
        UIResponder *nextResponder = [next nextResponder];
        if ([nextResponder isKindOfClass:[UIViewController class]])
            return (UIViewController *)nextResponder;
    }
    return nil;
}
@end

/** 此类用于区别与内部缩放的imageview */
@interface ZYImageView : UIImageView
@end
@implementation ZYImageView
@end

NSString *const ZYContentOffsetKey = @"contentOffset";

@interface ZYScaleHeader ()
@property (nonatomic, weak) ZYImageView *imageView;
@property (nonatomic, weak) UIScrollView *scrollView;
@end

@implementation ZYScaleHeader
+ (instancetype)headerWithImageNamed:(NSString *)imgName
{
    return [self headerWithImage:[UIImage imageNamed:imgName]];
}
+ (instancetype)headerWithImage:(UIImage *)image
{
    ZYScaleHeader *header = [ZYScaleHeader new];
    if (!image) return header;
    
    CGFloat width = [UIScreen mainScreen].bounds.size.width;
    CGFloat imgH = width * (image.size.height / image.size.width);
    header.frame = CGRectMake(0, 0, width, imgH);
    
    ZYImageView *imageV = [[ZYImageView alloc] initWithImage:image];
    imageV.frame = header.bounds;
    imageV.contentMode = UIViewContentModeScaleAspectFill;
    imageV.autoresizingMask = UIViewAutoresizingFlexibleHeight;
    header.clipsToBounds = true;
    [header addSubview:imageV];
    
    return header;
}


/**
 这里该不该重写?
 */
- (void)setFrame:(CGRect)frame
{
    CGFloat height = frame.size.height;
    [super setFrame:CGRectMake(0, -height, frame.size.width, height)];
}

- (void)addSubview:(UIView *)view
{
    [super addSubview:view];
    
    if ([view isKindOfClass:[ZYImageView class]]) return;
    view.autoresizingMask = UIViewAutoresizingFlexibleTopMargin;
}

- (void)willMoveToSuperview:(UIView *)newSuperview
{
    [super willMoveToSuperview:newSuperview];
    
    // 如果不是UIScrollView，不做任何事情
    if (newSuperview && ![newSuperview isKindOfClass:[UIScrollView class]]) return;
    
    // 旧的父控件移除监听
    [self removeObservers];
    
    _scrollView = (UIScrollView *)newSuperview;
    
    _scrollView.alwaysBounceVertical = YES;
    
    // 添加监听
    [self addObservers];
}


#pragma mark - KVO监听
- (void)addObservers
{
    [self.scrollView addObserver:self forKeyPath:ZYContentOffsetKey options:NSKeyValueObservingOptionNew context:nil];
}

- (void)removeObservers
{
    [self.superview removeObserver:self forKeyPath:ZYContentOffsetKey];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context
{
 
    CGFloat offsetY = self.scrollView.contentOffset.y;
    self.frame = CGRectMake(0, offsetY, self.frame.size.width, -offsetY);
}
@end

@implementation UIScrollView (ZYScaleHeader)
static char ZYScaleHeaderKey = '\0';
- (void)setZy_header:(ZYScaleHeader *)zy_header
{
    if (self.zy_header == zy_header) return;
    
    CGFloat height = zy_header.frame.size.height;
    if ([self.viewController isKindOfClass:[UINavigationController class]])
    {
        UINavigationController *nav = (UINavigationController *)self.viewController;
        if (!nav.navigationBar.isHidden)
        {
            height += nav.navigationBar.frame.size.height + (nav.prefersStatusBarHidden ?:20);
        }
    }
    zy_header.frame = CGRectMake(0, -height, self.frame.size.width, height);
    self.contentInset = UIEdgeInsetsMake(height, 0, 0, 0);

    [self.zy_header removeFromSuperview];
    objc_setAssociatedObject(self, &ZYScaleHeaderKey, zy_header, OBJC_ASSOCIATION_ASSIGN);
    [self insertSubview:zy_header atIndex:0];
    
}

- (ZYScaleHeader *)zy_header
{
    return objc_getAssociatedObject(self, &ZYScaleHeaderKey);
}

@end

