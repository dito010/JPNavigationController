//
//  JPNavigationBar.m
//  JPNavigationController
//
//  Created by Chris on 16/8/4.
//  Copyright © 2016年 Chris. All rights reserved.
//


/*
    这个类是自定义导航条
 
    我们要添加的联动底部视图View就是添加在他身上，当我们把联动的底部视图添加到导航条上以后，联动视图就超出父控件的范围，不能响应点击事件了
    所以我们在-(UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event方法里处理这种情况。
 */

#import "JPNavigationBar.h"
#import "JPLinkContainerView.h"

@implementation JPNavigationBar

-(UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event{
    JPLinkContainerView *linkView;
    for (UIView *subview in self.subviews) {
        if ([subview isKindOfClass:[JPLinkContainerView class]]) {
            linkView = (JPLinkContainerView *)subview;
            break;
        }
    }
    
    CGPoint viewP = [self convertPoint:point toView:linkView];
    if ([linkView pointInside:viewP withEvent:event]) { // 如果点击的点在联动视图linkView上, 就由linkView来响应事件
        return [linkView hitTest:viewP withEvent:event];
    }
    else{
        return  [super hitTest:point withEvent:event]; // 否则, 执行系统默认的做法
    }
}

@end
