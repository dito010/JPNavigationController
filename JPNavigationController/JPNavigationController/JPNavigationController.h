//
//  JPNavigationController.h
//  JPNavigationController
//
//  Created by Chris on 16/7/19.
//  Copyright © 2016年 Chris. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JPWarpViewController : UIViewController

/** 传进来的被包装的控制器 */
@property(nonatomic, strong)UIViewController *rootViewController;

/** 将传进来的控制器用导航控制器 ----> 解决懒加载问题 --> 将类工厂方法改成对象方法*/
-(JPWarpViewController *)warpViewController:(UIViewController *)viewController;
// +(JPWarpViewController *)warpViewController:(UIViewController *)viewController;

@end


@interface JPNavigationController : UINavigationController

/** 返回按钮图片 */
@property (nonatomic, strong) UIImage *backButtonImage;

/** 全屏右滑返回手势是否可用, 默认可用 */
@property (nonatomic, assign) BOOL jp_fullScreenPopGestureEnabled;

/** 栈里传进被包装的控制器数组 */
@property (nonatomic, copy, readonly) NSArray *jp_viewControllers;

@end


@interface UINavigationController (JPFullScreenPopGesture)

/** 最大允许开始pop手势离屏幕最左侧的距离, 默认为屏幕宽度, 代表全屏滑动 */
@property (nonatomic) CGFloat jp_interactivePopMaxAllowedInitialDistanceToLeftEdge;

/** 暂时关闭pop手势 */
@property(nonatomic)BOOL jp_closePopForTemporary;

@end