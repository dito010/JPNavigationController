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
 * This is a singleton, be used for manage the single viewController who close pop, framework will check this class is saved the current pop viewController when use pop begain.
 * I try a way to handle this is that I save the hash of navigation view controller to replace save navigation view controller, this way should not add a strong refrence to the navigation view controller.
 * @see JPNavigationController.
 * 这是一个单例, 负责将用户关闭了pop手势的控制器的hash值保存起来, 等用户pop的时候来检查当前保存的关闭pop的控制器中是否有正在pop的控制器.
 *
 * @see JPNavigationController.
 */

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface JPManageSinglePopVCTool : NSObject

+(instancetype)shareTool;

/**
 * The array of the single viewController who close pop, I try a way to handle this is that I save the hash of navigation view controller to replace save navigation view controller, this way should not add a strong refrence to the navigation view controller.
 */
@property(nonatomic, strong)NSArray *jp_closePopVCArr;

@end

NS_ASSUME_NONNULL_END
