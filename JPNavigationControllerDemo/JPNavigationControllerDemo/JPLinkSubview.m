//
//  JPLinkSubview.m
//  JPNavigationController
//
//  Hello! I am NewPan from Guangzhou of China, Glad you could use my framework, If you have any question or wanna to contact me, please open https://github.com/Chris-Pan or http://www.jianshu.com/users/e2f2d779c022/latest_articles
//

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
