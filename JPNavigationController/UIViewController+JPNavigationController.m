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

#import "UIViewController+JPNavigationController.h"
#import "objc/runtime.h"

@implementation UIViewController (JPNavigationController)

-(void)setJp_navigationController:(JPNavigationController *)jp_navigationController{
    objc_setAssociatedObject(self, @selector(jp_navigationController), jp_navigationController, OBJC_ASSOCIATION_ASSIGN);
}

-(JPNavigationController *)jp_navigationController{
    return objc_getAssociatedObject(self, _cmd);
}

-(void)setJp_warpViewController:(JPWarpViewController *)jp_warpViewController{
    objc_setAssociatedObject(self, @selector(jp_warpViewController), jp_warpViewController, OBJC_ASSOCIATION_ASSIGN);
}

-(JPWarpViewController *)jp_warpViewController{
    return objc_getAssociatedObject(self, _cmd);
}

@end
