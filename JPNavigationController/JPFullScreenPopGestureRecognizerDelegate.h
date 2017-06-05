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
 * This class be used for the delegate of pan gesture and, judge pan gesture recognizer should begin.
 * This class always need to screen shot when push begain and, post this image to JPNavigationInteractiveTransition for push transition animation.
 */

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

// a note for navigation controller left slip.
extern NSString * const JPNavigationControllerDidScrolledLeftNotification;
// a note for navigation controller right slip.
extern NSString * const JPNavigationControllerDidScrolledRightNotification;

@protocol JPFullScreenPopGestureRecognizerDelegate_Delegate <NSObject>

@optional
-(BOOL)navigationControllerLeftSlipShouldBegain;
-(BOOL)navigationControllerRightSlipShouldBegain;

@end

@interface JPFullScreenPopGestureRecognizerDelegate : NSObject<UIGestureRecognizerDelegate>

/**
 *  Root navigation controller.
 */
@property (nonatomic, weak) UINavigationController *navigationController;

/**
 *  Close or open pop gesture function for all viewcontrollers in current root navigation controller.
 */
@property(nonatomic, assign)BOOL closePopForAllVC;

/**
 * System target event for pop.
 *
 * @see JPNavigationController.
 */
@property(nonatomic, strong)id target;

@property(nonatomic, weak)id<JPFullScreenPopGestureRecognizerDelegate_Delegate> delegate;

@end

NS_ASSUME_NONNULL_END
