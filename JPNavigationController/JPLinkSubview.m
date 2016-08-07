//
//  JPLinkSubview.m
//  JPNavigationController
//
//  Created by lava on 16/8/5.
//  Copyright © 2016年 Chris. All rights reserved.
//

#import "JPLinkSubview.h"

@implementation JPLinkSubview

+(instancetype)viewForXib{
    return [[NSBundle mainBundle]loadNibNamed:NSStringFromClass([self class]) owner:nil options:nil].firstObject;
}

- (IBAction)collectionBtnClick:(UIButton *)sender {
    if ([self.jp_delegate respondsToSelector:@selector(linkSubview:didClickClosePop:)]) {
        [self.jp_delegate linkSubview:self didClickClosePop:sender];
    }
    NSLog(@"点击了%@", sender.titleLabel.text);
}

- (IBAction)buyBtnClick:(UIButton *)sender {
    if ([self.jp_delegate respondsToSelector:@selector(linkSubview:didClickBuy:)]) {
        [self.jp_delegate linkSubview:self didClickBuy:sender];
    }
    NSLog(@"点击了%@", sender.titleLabel.text);
}

@end
