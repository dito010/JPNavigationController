//
//  UINavigationController+JPLink.m
//  JPNavigationController
//
//  Created by Chris on 16/8/5.
//  Copyright © 2016年 Chris. All rights reserved.
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

-(void)setJp_linkContainerView:(JPLinkContainerView *)jp_linkContainerView{
    objc_setAssociatedObject(self, @selector(jp_linkContainerView), jp_linkContainerView, OBJC_ASSOCIATION_ASSIGN);
}

-(JPLinkContainerView *)jp_linkContainerView{
    return objc_getAssociatedObject(self, _cmd);
}

@end
