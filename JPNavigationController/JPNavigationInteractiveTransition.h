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
 * This class is responsible for observe user's push and pop action. it will set self be the delegate of root navigation controller and alloc UIPercentDrivenInteractiveTransition instance, return custom push transition animation when user push. it will set root navigation controller delegate be nil, let system handle pop gesture when pop.
 * 这个类负责监听用户的左滑push和右滑pop. 当监听到push的时候, 把根导航控制器的delegate设为自身, 并创建UIPercentDrivenInteractiveTransition实例, 返回自定义的push过渡动画, 在用户滑动的时候更新界面. 当监听到pop的时候, 把根导航控制器的delegate置nil, 由系统处理pop.
 */

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class UIViewController, UIPercentDrivenInteractiveTransition, JPNavigationInteractiveTransition;

@protocol JPNavigationInteractiveTransitionDelegate <NSObject>

@required

/**
 * This method will be called when user left-slip.
 *
 * @param navInTr   the delegate of root navigation controller.
 */
-(void)didPushLeft:(JPNavigationInteractiveTransition *)navInTr;

@end

@interface JPNavigationInteractiveTransition : NSObject <UINavigationControllerDelegate>

@property(nonatomic, weak)id<JPNavigationInteractiveTransitionDelegate> delegate;

/**
 * Initialze Method.
 *
 * @param nav  root navigation controller.
 *
 * @return     a instance.
 */
- (instancetype)initWithViewController:(UINavigationController *)nav;

/**
 * This method will be called when pan gesture be triggered.
 *
 * @param recognizer  pan gesture.
 */
- (void)handleControllerPop:(UIPanGestureRecognizer *)recognizer;

@end

NS_ASSUME_NONNULL_END
