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
 * This tool be used for screen shot and mix a shadow on left-slide for the view passed in.
 * 这个工具负责截屏以及混合图层阴影的功能.
 */

#import <UIKit/UIKit.h>

#define  JPScreenWidth   [UIScreen mainScreen].bounds.size.width
#define  JPScreenHeight  [UIScreen mainScreen].bounds.size.height
#define shadowWidth 24

NS_ASSUME_NONNULL_BEGIN

@interface JPSnapTool : NSObject

/**
 * Render the view's layer passed in generate an image.
 *
 * @param view  The view need be shot.
 *
 * @return An image for the view of passed in.
 */
+(UIImage *)snapShotWithView:(UIView *)view;

/**
 * Render the view's layer passed in generate an image and, mix a shadow on image left-slide.
 *
 * @param view  The view need be shot.
 *
 * @return An image for the view of passed in after mix a shadow on left-slide.
 */
+(UIImage *)mixShadowWithView:(UIView *)view;

/**
 * Generate an image with the given color.
 *
 * @param color The given color.
 *
 * @return The image with the given color.
 */
+(UIImage *)imageWithColor:(UIColor *)color;

@end

NS_ASSUME_NONNULL_END
