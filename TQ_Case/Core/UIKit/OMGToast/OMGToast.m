#import "OMGToast.h"
#import <QuartzCore/QuartzCore.h>

@interface OMGToast ()
@property (assign, nonatomic) NSTimeInterval duration;
@end

@implementation OMGToast

- (id)initWithText:(NSString *)text{
    if (self = [super init]) {
        UIFont *font = [UIFont systemFontOfSize:15];
        CGFloat pading = 15.f;
        CGSize textSize = [text sizeWithFont:font byWidth:(SCREEN_WIDTH - 55)];
        self.duration = DEFAULT_DISPLAY_DURATION;
        self.layer.cornerRadius = 5.0f;
        self.layer.borderWidth = 1.0f;
        self.layer.borderColor = [UIColor colorWithWhite:0.0f alpha:0.8f].CGColor;
        self.frame = CGRectMake(0, 0, textSize.width + pading, textSize.height + pading);
        self.backgroundColor = [UIColor colorWithWhite:0.0f alpha:0.8f];
        self.autoresizingMask = UIViewAutoresizingFlexibleWidth;
        self.alpha = 0.0f;
        
        UILabel *messageLable = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, textSize.width, textSize.height)];
        messageLable.center = self.center;
        messageLable.backgroundColor = [UIColor clearColor];
        messageLable.textColor = [UIColor whiteColor];
        messageLable.textAlignment = NSTextAlignmentCenter;
        messageLable.font = font;
        messageLable.text = text;
        messageLable.numberOfLines = 0;
        
        
        [self setTag:999];
        [self addSubview:messageLable];
    }  
    return self;  
}

/**********************************************************************/
#pragma mark - Private Methods
/**********************************************************************/

- (void)showInView:(UIView *)view center:(CGPoint)center duration:(NSTimeInterval)duration{
    UIView *lastView = [view viewWithTag:999];
    if (lastView != nil) {
        [lastView removeFromSuperview];
    }
    self.center = center;
    self.alpha = 0.0f;
    [view addSubview:self];
    
    [UIView animateWithDuration:0.3f delay:0.0f options:UIViewAnimationOptionCurveEaseIn animations:^{
        self.alpha = 1.0f;
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.3f delay:duration options:UIViewAnimationOptionCurveEaseOut animations:^{
            self.alpha = 0.0f;
        } completion:^(BOOL finished) {
            [self removeFromSuperview];
        }];
    }];
}

- (void)show{
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    [self showInView:window center:window.center duration:self.duration];
}
  
- (void)showFromTopOffset:(CGFloat)top{
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    CGPoint center = CGPointMake(window.center.x, top + self.frame.size.height/2);
    
    [self showInView:window center:center duration:self.duration];
}

- (void)showFromBottomOffset:(CGFloat)bottom{
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    CGPoint center = CGPointMake(window.center.x, window.frame.size.height - (bottom + self.frame.size.height/2));
    
    [self showInView:window center:center duration:self.duration];
}

/**********************************************************************/
#pragma mark - Public Methods
/**********************************************************************/

+ (void)showWithText:(NSString *)text{
    [OMGToast showWithText:text bottomOffset:150.f duration:DEFAULT_DISPLAY_DURATION];
}
+ (void)showWithText:(NSString *)text duration:(CGFloat)duration{
    OMGToast *toast = [[OMGToast alloc] initWithText:text];
    toast.duration = duration;
    [toast show];  
}

+ (void)showWithText:(NSString *)text topOffset:(CGFloat)topOffset{
    [OMGToast showWithText:text topOffset:topOffset duration:DEFAULT_DISPLAY_DURATION];
}
+ (void)showWithText:(NSString *)text topOffset:(CGFloat)topOffset duration:(CGFloat)duration{
    OMGToast *toast = [[OMGToast alloc] initWithText:text];
    toast.duration = duration;
    [toast showFromTopOffset:topOffset];
}

+ (void)showWithText:(NSString *)text bottomOffset:(CGFloat)bottomOffset{
    [OMGToast showWithText:text bottomOffset:bottomOffset duration:DEFAULT_DISPLAY_DURATION];
}
+ (void)showWithText:(NSString *)text bottomOffset:(CGFloat)bottomOffset duration:(CGFloat)duration{
    OMGToast *toast = [[OMGToast alloc] initWithText:text];
    toast.duration = duration;
    [toast showFromBottomOffset:bottomOffset];
}  
  
@end 
