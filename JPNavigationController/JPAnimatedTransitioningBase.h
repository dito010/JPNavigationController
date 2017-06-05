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
 * This class is a super class for push animation.
 */

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface JPAnimatedTransitioningBase : NSObject<UIViewControllerAnimatedTransitioning>

/**
 *  Transition Duration.
 */
@property (nonatomic) NSTimeInterval  transitionDuration;

/**
 *  From view controller.
 */
@property (nonatomic, readonly, weak) UIViewController *fromViewController;

/**
 *  Target view controller.
 */
@property (nonatomic, readonly, weak) UIViewController *toViewController;

/**
 *  Container view.
 */
@property (nonatomic, readonly, weak) UIView *containerView;

/**
 *  Animate Transition Event.
 */
- (void)animateTransitionEvent;

/**
 *  Complete transition.
 */
- (void)completeTransition;

@end

NS_ASSUME_NONNULL_END
