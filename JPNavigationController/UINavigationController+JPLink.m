//
//  UINavigationController+JPLink.m
//  JPNavigationController
//
//  Hello! I am NewPan from Guangzhou of China, Glad you could use my framework, If you have any question or wanna to contact me, please open https://github.com/Chris-Pan or http://www.jianshu.com/users/e2f2d779c022/latest_articles
//

#import "UINavigationController+JPLink.h"
#import <objc/runtime.h>

@implementation UINavigationController (JPLink)

-(void)setJp_linkViewHeight:(CGFloat)jp_linkViewHeight{
    objc_setAssociatedObject(self, @selector(jp_linkViewHeight), @(jp_linkViewHeight), OBJC_ASSOCIATION_ASSIGN);
}

-(CGFloat)jp_linkViewHeight{
    return [objc_getAssociatedObject(self, _cmd) floatValue];
}

-(void)setJp_linkView:(UIView *)jp_linkView{
    
    // Call user's viewDidLoad: method after JPWarpNavigationController's viewDidLoad:.
    // 先调用JPWarpNavigationController的viewDidLoad:方法, 再调用用户的控制器的viewDidLoad:方法
    
    UIView *li = [self valueForKeyPath:@"_linkView"];
    if (li) {
        jp_linkView.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, self.jp_linkViewHeight);
        [li addSubview:jp_linkView];
    }
    objc_setAssociatedObject(self, @selector(jp_linkView), jp_linkView, OBJC_ASSOCIATION_ASSIGN);
}

-(UIView *)jp_linkView{
    return objc_getAssociatedObject(self, _cmd);
}

@end
