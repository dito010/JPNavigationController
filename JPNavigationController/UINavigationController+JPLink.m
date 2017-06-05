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

#import "UINavigationController+JPLink.h"
#import "objc/runtime.h"

@implementation UINavigationController (JPLink)

-(void)setJp_linkViewHeight:(CGFloat)jp_linkViewHeight{
    objc_setAssociatedObject(self, @selector(jp_linkViewHeight), @(jp_linkViewHeight), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    [self handleAddLinkView];
}

-(CGFloat)jp_linkViewHeight{
    return [objc_getAssociatedObject(self, _cmd) floatValue];
}

-(void)setJp_linkView:(UIView *)jp_linkView{
    objc_setAssociatedObject(self, @selector(jp_linkView), jp_linkView, OBJC_ASSOCIATION_ASSIGN);
    [self handleAddLinkView];
}

-(UIView *)jp_linkView{
    return objc_getAssociatedObject(self, _cmd);
}

-(void)handleAddLinkView{
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
    [self performSelector:NSSelectorFromString(@"addLinkView")];
#pragma clang diagnostic pop
}

@end
