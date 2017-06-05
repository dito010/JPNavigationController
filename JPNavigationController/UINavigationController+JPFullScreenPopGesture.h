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

/**
 * This is a category for navigation controller.
 * Please use its category method to reach function accordingly.
 * 这是一个导航控制器的分类.
 * 使用以下的导航控制器的分类方法可以实现对应的功能.
 */

#import <UIKit/UIKit.h>
#import "JPNavigationController.h"

NS_ASSUME_NONNULL_BEGIN

typedef NS_OPTIONS(NSInteger, JPStatusBarStyle) {
    JPStatusBarStyleDefault = 1 << 0, // 默认样式, 状态栏文字为黑色.
    JPStatusBarStyleLight = 1 << 1 // 状态栏文字为黑色.
};

// a note for max pop gesture change.
extern NSString * const JPNavigationControllerDidPopMaxNotification;
// a note for close pop gesture for current view controller.
extern NSString * const JPNavigationControllerClosePopForCurrentVCNotification;
// a note for close pop gesture for all view controllers.
extern NSString * const JPNavigationControllerClosePopForAllVCNotification;
// a note for change statusBarStyle.
extern NSString * const JPNavigationControllerDidChangedStatusBarNotification;

@interface UINavigationController (JPFullScreenPopGesture)

/**
 * The biggest space allow pop leave screen left-slide in current root navigation controller.
 * Full screen width default, mean can call pop anywhere in screen.
 */
@property (nonatomic) CGFloat jp_interactivePopMaxAllowedInitialDistanceToLeftEdge;

/**
 * Close or open pop gesture function for current viewcontroller in current root navigation controller.
 */
@property(nonatomic)BOOL jp_closePopForCurrentViewController;

/**
 * Close or open pop gesture function for all viewcontrollers in current root navigation controller.
 */
@property(nonatomic)BOOL jp_closePopForAllViewController;

/**
 * The root navigation controller.
 */
@property(nonatomic, nullable)JPNavigationController *jp_rootNavigationController;

/**
 * The delegate for function of left-slip to push next viewController.
 */
@property(nonatomic)id<JPNavigationControllerDelegate> jp_pushDelegate;

/**
 * The style of status bar.
 */
@property(nonatomic)NSInteger jp_prefersStatusBarStyle;

/**
 * Pop to target view controller, you just need to pass in the class of target view controller. It's easy to use than system's popToViewController: animated: method.
 *
 * @see JPWarpNavigationController.
 */
-(void)jp_popToViewControllerClassIs:(id)targetClass animated:(BOOL)animated;

@end

NS_ASSUME_NONNULL_END
