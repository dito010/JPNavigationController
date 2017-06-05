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

#import "JPLinkSubview.h"

@implementation JPLinkSubview

+(instancetype)viewForXib{
    return [[NSBundle mainBundle]loadNibNamed:NSStringFromClass([self class]) owner:nil options:nil].firstObject;
}

- (IBAction)collectionBtnClick:(UIButton *)sender {
    if ([self.jp_pushDelegate respondsToSelector:@selector(linkSubview:didClickClosePop:)]) {
        [self.jp_pushDelegate linkSubview:self didClickClosePop:sender];
    }
    NSLog(@"click %@", sender.titleLabel.text);
}

- (IBAction)buyBtnClick:(UIButton *)sender {
    if ([self.jp_pushDelegate respondsToSelector:@selector(linkSubview:didClickCloseAllPop:)]) {
        [self.jp_pushDelegate linkSubview:self didClickCloseAllPop:sender];
    }
    NSLog(@"click %@", sender.titleLabel.text);
}

@end
