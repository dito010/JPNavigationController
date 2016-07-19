//
//  UIViewController+NavExtesion.m
//  JPNavigationController
//
//  Created by Chris on 16/7/19.
//  Copyright © 2016年 Chris. All rights reserved.
//

#import "UIViewController+NavExtesion.h"
#import <objc/runtime.h>

@implementation UIViewController (NavExtesion)

-(void)setJp_fullScreenPopGestureEnabled:(BOOL)jp_fullScreenPopGestureEnabled{
    objc_setAssociatedObject(self, @"fullScreenPopGestureEnabled", @(jp_fullScreenPopGestureEnabled), OBJC_ASSOCIATION_ASSIGN);
}

-(BOOL)jp_fullScreenPopGestureEnabled{
    return objc_getAssociatedObject(self, @"fullScreenPopGestureEnabled");
}

-(void)setJp_navigationController:(JPNavigationController *)jp_navigationController{
    objc_setAssociatedObject(self, @"jp_navigationController", jp_navigationController, OBJC_ASSOCIATION_RETAIN);
}

-(JPNavigationController *)jp_navigationController{
    return objc_getAssociatedObject(self, @"jp_navigationController");
}

@end
