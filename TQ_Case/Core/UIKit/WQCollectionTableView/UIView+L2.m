//
//  UIView+L2.m
//  Pods
//
//  Created by Jayla on 17/3/31.
//
//

#import "UIView+L2.h"

@implementation UIView (L2)

static char * __customObj__ = "__customObj__";
- (void)setCustomObj:(id)customObj {
    objc_setAssociatedObject(self, __customObj__, customObj, OBJC_ASSOCIATION_RETAIN);
}

- (id)customObj {
    return objc_getAssociatedObject(self, __customObj__);
}

static char * __anotherCusObj__ = "__anotherCusObj__";
- (void)setAnotherCusObj:(id)anotherCusObj {
    objc_setAssociatedObject(self, __anotherCusObj__, anotherCusObj, OBJC_ASSOCIATION_RETAIN);
}

- (id)anotherCusObj {
    return objc_getAssociatedObject(self, __anotherCusObj__);
}

static char * __cornered__ = "baseForm_cornered";
-(void)setCornered:(CGFloat)cornered {
    self.clipsToBounds = YES;
    objc_setAssociatedObject(self, __cornered__, [NSNumber numberWithFloat:cornered], OBJC_ASSOCIATION_COPY_NONATOMIC);
    self.layer.cornerRadius = cornered;
}

-(CGFloat)cornered {
    NSNumber *number = objc_getAssociatedObject(self, __cornered__);
    return [number floatValue];
}

static char * __isCircle__ = "baseForm_isCircle";
-(void)setIsCircle:(BOOL)isCircle {
    self.clipsToBounds = YES;
    objc_setAssociatedObject(self, __isCircle__, [NSNumber numberWithBool:isCircle], OBJC_ASSOCIATION_COPY_NONATOMIC);
    if (isCircle) {
        self.layer.cornerRadius = CGRectGetWidth(self.frame)/2;
    }
}

-(BOOL)isCircle {
    NSNumber *number = objc_getAssociatedObject(self, __isCircle__);
    return [number boolValue];
}

@end
