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
 * This category be used for easy use link view.
 * 这是导航控制器的分类, 用来负责方便用户使用底部联动视图.
 */

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class JPLinkContainerView;

@interface UINavigationController (JPLink)

/**
 * Link view height on screen bottom.
 */
@property(nonatomic)CGFloat jp_linkViewHeight;

/**
 * Link view on screen bottom.
 * You just need pass your link view to this property, framework will display your link view automatically.
 * @warning If the of current display in window is a UITableViewController class, frame will add a contentInset automatically to avoid the link view cover on UITableViewController. but if you add a UITableView on UIViewController's, framework will do nothing for that, you may handle this by yourself.
 *
 * @see JPWarpNavigationController
 */
@property(nonatomic)UIView *jp_linkView;

@end

NS_ASSUME_NONNULL_END
