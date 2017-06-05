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

#import "JPAnimatedTransitioningBase.h"

@interface JPAnimatedTransitioningBase()

@property (nonatomic, weak) id <UIViewControllerContextTransitioning> transitionContext;

@property (nonatomic, weak) UIViewController *fromViewController;

@property (nonatomic, weak) UIViewController *toViewController;

@property (nonatomic, weak) UIView *containerView;

@end

@implementation JPAnimatedTransitioningBase

- (instancetype)init {
    self = [super init];
    if (self) {
        _transitionDuration = 0.25f;
    }
    return self;
}

- (NSTimeInterval)transitionDuration:(id <UIViewControllerContextTransitioning>)transitionContext {
    return _transitionDuration;
}

- (void)animateTransition:(id <UIViewControllerContextTransitioning>)transitionContext {
    self.fromViewController = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    self.toViewController   = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    self.containerView      = [transitionContext containerView];
    self.transitionContext  = transitionContext;
    
    [self animateTransitionEvent];
}

- (void)animateTransitionEvent {
    
}

- (void)completeTransition {
    [self.transitionContext completeTransition:!self.transitionContext.transitionWasCancelled];
}

@end
