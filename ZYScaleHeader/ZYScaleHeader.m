//
//  ZYScaleHeader.m
//  https://github.com/shlyren/ZYScaleHeader
//
//  Created by JiaQi on 2016/12/6.
//  Copyright © 2016年 任玉祥. All rights reserved.
//

#import "ZYScaleHeader.h"
#import <objc/runtime.h>

@implementation NSObject (EXChangeMethods)

+ (void)zy_exchangeClassMethodWithoOrigSelector:(SEL)origSelector swizzleSelector:(SEL)swizzleSelector
{
    Method origMethod = class_getClassMethod(self, origSelector);
    Method swizzleMethod = class_getClassMethod(self, swizzleSelector);
    // 注意：不能直接交换方法实现，需要判断原有方法是否存在,存在才能交换
    // 如何判断？添加原有方法，如果成功，表示原有方法不存在，失败，表示原有方法存在
    // 原有方法可能没有实现，所以这里添加方法实现，用自己方法实现
    // 这样做的好处：方法不存在，直接把自己方法的实现作为原有方法的实现，调用原有方法，就会来到当前方法的实现
    BOOL isAdd = class_addMethod(self, origSelector, method_getImplementation(swizzleMethod), method_getTypeEncoding(swizzleMethod));
    if (!isAdd) {
        method_exchangeImplementations(origMethod, swizzleMethod);
    }
}

+ (void)zy_exchangeInstanceMethodWithoOrigSelector:(SEL)origSelector swizzleSelector:(SEL)swizzleSelector
{
    Method origMethod = class_getInstanceMethod(self, origSelector);
    Method swizzleMethod = class_getInstanceMethod(self, swizzleSelector);
    
    BOOL isAdd = class_addMethod(self, origSelector, method_getImplementation(swizzleMethod), method_getTypeEncoding(swizzleMethod));
    
    if (!isAdd) {
        method_exchangeImplementations(origMethod, swizzleMethod);
    }
}

@end

#pragma mark - 获取当前view的控制
@implementation UIView (ZYExtend)
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

#pragma mark - ZYImageView
#pragma mark 用于区别与内部缩放的imageview
@interface ZYImageView : UIImageView @end
@implementation ZYImageView @end

#pragma mark - const
NSString *const ZYContentOffsetKey = @"contentOffset";
//NSString *const ZYContentInsetKey = @"contentInset";

#pragma mark - ZYScaleHeader
@interface ZYScaleHeader ()
/** imageView */
@property (nonatomic, weak) ZYImageView *imageView;
/** 父控件 */
@property (nonatomic, weak) UIScrollView *scrollView;

@end

@implementation ZYScaleHeader

+ (void)load
{
    [self zy_exchangeInstanceMethodWithoOrigSelector:@selector(setFrame:) swizzleSelector:@selector(setZy_frame:)];
}

#pragma mark - lazy load
- (ZYImageView *)imageView
{
    if (!_imageView)
    {
        ZYImageView *imageV = [ZYImageView new];
        imageV.frame = self.bounds;
        imageV.clipsToBounds = true;
        imageV.contentMode = UIViewContentModeScaleAspectFill;
        imageV.autoresizingMask = UIViewAutoresizingFlexibleHeight;
        [self insertSubview:_imageView = imageV atIndex:0];
    }
    
    return _imageView;
}

#pragma mark - super init Methods
- (instancetype)initWithFrame:(CGRect)frame
{
    return [self initWithImage:nil height:frame.size.height];
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    return [self initWithImage:nil height:0];
}

#pragma mark - public methods
+ (instancetype)headerWithImageNamed:(NSString *)name
{
    return [self headerWithImageNamed:name height:0];
}

+ (instancetype)headerWithImage:(UIImage *)image
{
    return [self headerWithImage:image height:0];
}

+ (instancetype)headerWithImageNamed:(NSString *)name height:(CGFloat)height
{
    UIImage *image = [UIImage imageNamed:name];
    NSAssert1(image, @"load the nil image with name \"%@\"" , name);
    return [self headerWithImage:image height:height];
}

+ (instancetype)headerWithImage:(UIImage *)image height:(CGFloat)height
{
    return [[self alloc] initWithImage:image height:height];
}

#pragma mark main method
- (instancetype)initWithImage:(UIImage *)image height:(CGFloat)height
{
    NSAssert(image, @"image can not be nil");
    if (self = [super initWithFrame:CGRectZero])
    {
        CGFloat width = [UIScreen mainScreen].bounds.size.width;
        CGFloat imgH =  width * (image.size.height / image.size.width);
        [self setZy_frame:CGRectMake(0, 0, width, height ?: imgH)];
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


#pragma mark - exchangeMethod
- (void)setFrame:(CGRect)frame
{
    CGFloat height = frame.size.height;
    [super setFrame:CGRectMake(0, -height, frame.size.width, height)];
}

- (void)setZy_frame:(CGRect)frame
{
    [self setZy_frame:frame];
    
    UIEdgeInsets insets = self.scrollView.contentInset;
    insets.top = frame.size.height;
    self.scrollView.contentInset = insets;
}

#pragma mark - super mthods
- (void)addSubview:(UIView *)view
{
    [super addSubview:view];
    view.autoresizingMask = UIViewAutoresizingFlexibleTopMargin;
}

- (void)insertSubview:(UIView *)view atIndex:(NSInteger)index
{
    [super insertSubview:view atIndex:index];
    if ([view isKindOfClass:[ZYImageView class]]) return;
    view.autoresizingMask = UIViewAutoresizingFlexibleTopMargin;

}
- (void)insertSubview:(UIView *)view belowSubview:(UIView *)siblingSubview
{
    [super insertSubview:view belowSubview:siblingSubview];
    view.autoresizingMask = UIViewAutoresizingFlexibleTopMargin;
}
- (void)insertSubview:(UIView *)view aboveSubview:(UIView *)siblingSubview
{
    [super insertSubview:view aboveSubview:siblingSubview];
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
    
    // 记录父控件
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
    if ([keyPath isEqualToString:ZYContentOffsetKey])
    {
        CGFloat offsetY = self.scrollView.contentOffset.y;
        [self setZy_frame: CGRectMake(0, offsetY, self.frame.size.width, -offsetY)];
    }
}
@end

@implementation UIScrollView (ZYScaleHeader)

static char ZYScaleHeaderKey = '\0';
- (void)setZy_header:(ZYScaleHeader *)zy_header
{
    if (self.zy_header == zy_header) return;
    
    // 移除旧的
    [self.zy_header removeFromSuperview];
    
    // 添加新的
    [self addSubview:zy_header];
    // runtime
    objc_setAssociatedObject(self, &ZYScaleHeaderKey, zy_header, OBJC_ASSOCIATION_ASSIGN);
    
    // 计算
    CGFloat height = zy_header.frame.size.height;
    
    if ([self.viewController isKindOfClass:[UINavigationController class]])
    {
        UINavigationController *nav = (UINavigationController *)self.viewController;
        if (!nav.navigationBar.isHidden)
            height += nav.navigationBar.frame.size.height + (nav.prefersStatusBarHidden ?:20);
    }
    [zy_header setZy_frame:CGRectMake(0, -height, self.frame.size.width, height)];
    
    UIEdgeInsets insets = self.contentInset;
    insets.top = height;
    self.contentInset = insets;
}

- (ZYScaleHeader *)zy_header
{
    return objc_getAssociatedObject(self, &ZYScaleHeaderKey);
}

@end

