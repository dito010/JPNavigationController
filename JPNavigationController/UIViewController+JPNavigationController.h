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
 * You do not need to care about this category.
 * 这个分类是辅助JPNavigationController导航控制实现对应功能的, 用户不用关心.
 */

#import <UIKit/UIKit.h>
#import "JPNavigationController.h"
#import "JPWarpViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface UIViewController (JPNavigationController)

/**
 * The warped navigation controller.
 *
 * @see JPWarpNavigationController.
 */
@property (nonatomic) JPNavigationController *jp_navigationController;

/**
 * The warped view Controller.
 *
 * @see JPWarpViewController.
 */
@property(nonatomic)JPWarpViewController *jp_warpViewController;

@end

NS_ASSUME_NONNULL_END
