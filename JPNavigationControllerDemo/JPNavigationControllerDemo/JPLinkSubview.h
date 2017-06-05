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

#import <UIKit/UIKit.h>

@class JPLinkSubview;

@protocol JPLinkSubviewDelegate <NSObject>

@optional

-(void)linkSubview:(JPLinkSubview *)linkSubview didClickCloseAllPop:(UIButton *)sender;

-(void)linkSubview:(JPLinkSubview *)linkSubview didClickClosePop:(UIButton *)sender;

@end


@interface JPLinkSubview : UIView

/** delegate */
@property(nonatomic, weak)id<JPLinkSubviewDelegate> jp_pushDelegate;

+(instancetype)viewForXib;

@end
