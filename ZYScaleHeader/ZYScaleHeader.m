//
//  ZYScaleHeader.m
//  ZYScaleHeaderDemo
//
//  Created by JiaQi on 2016/12/6.
//  Copyright © 2016年 任玉祥. All rights reserved.
//

#import "ZYScaleHeader.h"
#import <objc/runtime.h>
#import "UIView+MJExtension.h"
#import "UIScrollView+MJExtension.h"

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

#pragma mark - lazy load
- (ZYImageView *)imageView
{
    if (!_imageView)
    {
        ZYImageView *imageV = [ZYImageView new];
        imageV.frame = self.bounds;
        imageV.contentMode = UIViewContentModeScaleAspectFill;
        imageV.autoresizingMask = UIViewAutoresizingFlexibleHeight;
        [self insertSubview:_imageView = imageV atIndex:0];
    }
    
    return _imageView;
}

#pragma mark - super init Methods
- (instancetype)init
{
    return [self initWithImage:nil height:0];
}

- (instancetype)initWithFrame:(CGRect)frame
{
    return [self initWithImage:nil height:frame.size.height];
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    return [self initWithImage:nil height:0];
}

#pragma mark - public methods
+ (instancetype)headerWithImageNamed:(NSString *)imgName
{
    return [self headerWithImage:[UIImage imageNamed:imgName]];
}

+ (instancetype)headerWithImage:(UIImage *)image
{
    return [self headerWithImage:image height:0];
}

+ (instancetype)headerWithImageNamed:(NSString *)imgName height:(CGFloat)height
{
    return [self headerWithImage:[UIImage imageNamed:imgName] height:height];
}

+ (instancetype)headerWithImage:(UIImage *)image height:(CGFloat)height
{
    return [[self alloc] initWithImage:image height:height];
}

#pragma mark - main methods
- (instancetype)initWithImage:(UIImage *)image height:(CGFloat)height
{
    if (self = [super initWithFrame:CGRectZero])
    {
        if (!image) return self;
        
        CGFloat width = [UIScreen mainScreen].bounds.size.width;
        CGFloat imgH =  width * (image.size.height / image.size.width);
        self.frame = CGRectMake(0, 0, width, height ?: imgH);
        self.clipsToBounds = true;
        self.imageView.image = image;
    }
    
    return self;
}

#pragma mark - public variable
- (void)setImage:(UIImage *)image
{
    self.imageView.image = image;
}

- (UIImage *)image
{
    return self.imageView.image;
}


#pragma mark - other
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
    
    // 移除监听
    [self removeObservers];
    
     if (!newSuperview) return;
    
    _scrollView = (UIScrollView *)newSuperview;
    
    _scrollView.alwaysBounceVertical = YES;
    
    // 添加监听
    [self addObservers];
}


#pragma mark - KVO
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
    [self addSubview:zy_header];
    [self scrollRectToVisible:CGRectZero animated:false];
    
}

- (ZYScaleHeader *)zy_header
{
    return objc_getAssociatedObject(self, &ZYScaleHeaderKey);
}

@end

