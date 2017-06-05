/*
 * This file is part of the JPNavigationController package.
 * (c) NewPan <13246884282@163.com>
 *
 * For the full copyright and license information, please view the LICENSE
 * file that was distributed with this source code.
 *
 * Click https://github.com/Chris-Pan
 * or http://www.jianshu.com/users/e2f2d779c022/latest_articles to contact me.
 */

#import "UINavigationController+JPFullScreenPopGesture.h"
#import "objc/runtime.h"

// a note for max pop gesture change.
NSString * const JPNavigationControllerDidPopMaxNotification = @"com.newpan.navigation.did.pop.max";
// a note for close pop gesture for current view controller.
NSString * const JPNavigationControllerClosePopForCurrentVCNotification = @"com.newpan.navigation.did.close.pop.for.current.viewController";
// a note for close pop gesture for all view controllers.
NSString * const JPNavigationControllerClosePopForAllVCNotification = @"com.newpan.navigation.did.close.pop.for.all.viewControllers";
// a note for change statusBarStyle.
NSString * const JPNavigationControllerDidChangedStatusBarNotification = @"com.newpan.navigation.did.changed.statusbar";

@implementation UINavigationController (JPFullScreenPopGesture)

-(void)setJp_prefersStatusBarStyle:(NSInteger)jp_prefersStatusBarStyle{
    UINavigationController *nav = self.navigationController;
    if (nav) {
        NSDictionary *dict = @{
                               @"rootNavigationForCurVC" : nav,
                               @"tempValue" : @(jp_prefersStatusBarStyle)
                               };
        [[NSNotificationCenter defaultCenter]postNotificationName:JPNavigationControllerDidChangedStatusBarNotification object:dict];
    }
}

-(NSInteger)jp_prefersStatusBarStyle{
    return 0;
}

-(void)setJp_interactivePopMaxAllowedInitialDistanceToLeftEdge:(CGFloat)jp_interactivePopMaxAllowedInitialDistanceToLeftEdge{
    
    CGSize screenSize = [UIScreen mainScreen].bounds.size;
    jp_interactivePopMaxAllowedInitialDistanceToLeftEdge = MIN(jp_interactivePopMaxAllowedInitialDistanceToLeftEdge, screenSize.width);
    jp_interactivePopMaxAllowedInitialDistanceToLeftEdge = MAX(0, jp_interactivePopMaxAllowedInitialDistanceToLeftEdge);
    SEL key = @selector(jp_interactivePopMaxAllowedInitialDistanceToLeftEdge);
    CGFloat distance = jp_interactivePopMaxAllowedInitialDistanceToLeftEdge;
    objc_setAssociatedObject(self, key, @(MAX(0, distance)), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    UINavigationController *nav = self.navigationController;
    if (nav) {
        NSDictionary *dict = @{
                               @"navigation" : self,
                               @"tempValue" : @(jp_interactivePopMaxAllowedInitialDistanceToLeftEdge)
                               };
        [[NSNotificationCenter defaultCenter]postNotificationName:JPNavigationControllerDidPopMaxNotification object:dict];
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
        [[NSNotificationCenter defaultCenter]postNotificationName:JPNavigationControllerClosePopForCurrentVCNotification object:dict];
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
        [[NSNotificationCenter defaultCenter]postNotificationName:JPNavigationControllerClosePopForAllVCNotification object:dict];
    }
}

-(BOOL)jp_closePopForAllViewController{
    return NO;
}

-(void)setJp_rootNavigationController:(JPNavigationController *)jp_rootNavigationController{
    objc_setAssociatedObject(self, @selector(jp_rootNavigationController), jp_rootNavigationController, OBJC_ASSOCIATION_ASSIGN);
}

-(JPNavigationController *)jp_rootNavigationController{
    return objc_getAssociatedObject(self, _cmd);
}

-(void)setJp_pushDelegate:(id<JPNavigationControllerDelegate>)jp_pushDelegate{
    objc_setAssociatedObject(self, @selector(jp_pushDelegate), jp_pushDelegate, OBJC_ASSOCIATION_ASSIGN);
}

-(id<JPNavigationControllerDelegate>)jp_pushDelegate{
    return objc_getAssociatedObject(self, _cmd);
}

-(void)jp_popToViewControllerClassIs:(id)targetClass animated:(BOOL)animated{
}

@end

