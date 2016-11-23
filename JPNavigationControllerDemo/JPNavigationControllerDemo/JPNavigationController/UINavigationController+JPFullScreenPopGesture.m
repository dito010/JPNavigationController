//
//  UINavigationController+JPFullScreenPopGesture.m
//  JPNavigationController
//
//  Hello! I am NewPan from Guangzhou of China, Glad you could use my framework, If you have any question or wanna to contact me, please open https://github.com/Chris-Pan or http://www.jianshu.com/users/e2f2d779c022/latest_articles
//

#import "UINavigationController+JPFullScreenPopGesture.h"
#import "objc/runtime.h"

@implementation UINavigationController (JPFullScreenPopGesture)

-(void)setJp_interactivePopMaxAllowedInitialDistanceToLeftEdge:(CGFloat)jp_interactivePopMaxAllowedInitialDistanceToLeftEdge{
    CGSize screenSize = [UIScreen mainScreen].bounds.size;
    jp_interactivePopMaxAllowedInitialDistanceToLeftEdge = MIN(jp_interactivePopMaxAllowedInitialDistanceToLeftEdge, screenSize.width);
    jp_interactivePopMaxAllowedInitialDistanceToLeftEdge = MAX(0, jp_interactivePopMaxAllowedInitialDistanceToLeftEdge);
    SEL key = @selector(jp_interactivePopMaxAllowedInitialDistanceToLeftEdge);
    CGFloat distance = jp_interactivePopMaxAllowedInitialDistanceToLeftEdge;
    objc_setAssociatedObject(self, key, @(MAX(0, distance)), OBJC_ASSOCIATION_ASSIGN);
    UINavigationController *nav = self.navigationController;
    if (nav) {
        NSDictionary *dict = @{
                               @"navigation" : self,
                               @"tempValue" : @(jp_interactivePopMaxAllowedInitialDistanceToLeftEdge)
                               };
        [[NSNotificationCenter defaultCenter]postNotificationName:@"jp_interactivePopMaxNote" object:dict];
    }
}

-(CGFloat)jp_interactivePopMaxAllowedInitialDistanceToLeftEdge{
#if CGFLOAT_IS_DOUBLE
    return [objc_getAssociatedObject(self, _cmd) doubleValue];
#else
    return [objc_getAssociatedObject(self, _cmd) floatValue];
#endif
}

-(void)setJp_closePopForCurrentViewController:(BOOL)jp_closePopForCurrentViewController{
    UINavigationController *nav = self.navigationController;
    if (nav) {
        NSDictionary *dict = @{
                               @"warpNav" : self,
                               @"rootNavigationForCurVC" : nav,
                               @"tempValue" : @(jp_closePopForCurrentViewController)
                               };
        [[NSNotificationCenter defaultCenter]postNotificationName:@"jp_closePopForCurrentViewController" object:dict];
    }
}

-(BOOL)jp_closePopForCurrentViewController{
    return NO;
}

-(void)setJp_closePopForAllViewController:(BOOL)jp_closePopForAllViewController{
    UINavigationController *nav = self.navigationController;
    if (nav) {
        NSDictionary *dict = @{
                               @"rootNavigationForAllVC" : nav,
                               @"tempValue" : @(jp_closePopForAllViewController)
                               };
        [[NSNotificationCenter defaultCenter]postNotificationName:@"jp_closePopForAllViewController" object:dict];
    }
}

-(BOOL)jp_closePopForAllViewController{
    return NO;
}

-(void)setJp_rootNavigationController:(JPNavigationController *)jp_rootNavigationController{
    objc_setAssociatedObject(self, @selector(jp_rootNavigationController), jp_rootNavigationController, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

-(JPNavigationController *)jp_rootNavigationController{
    return objc_getAssociatedObject(self, _cmd);
}

-(void)setJp_delegate:(id<JPNavigationControllerDelegate>)jp_delegate{
    objc_setAssociatedObject(self, @selector(jp_delegate), jp_delegate, OBJC_ASSOCIATION_ASSIGN);
}

-(id<JPNavigationControllerDelegate>)jp_delegate{
    return objc_getAssociatedObject(self, _cmd);
}

-(void)jp_popToViewControllerClassIs:(id)targetClass animated:(BOOL)animated{
}

@end

