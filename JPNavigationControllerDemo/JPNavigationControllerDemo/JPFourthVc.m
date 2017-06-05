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

#import "JPFourthVc.h"
#import "JPNavigationControllerKit.h"

@interface JPFourthVc ()

@property (weak, nonatomic) IBOutlet UIImageView *avatarImageView;

@end

@implementation JPFourthVc

- (void)viewDidLoad {
    [super viewDidLoad];
    self.avatarImageView.layer.cornerRadius = self.avatarImageView.bounds.size.width * 0.5;
    self.avatarImageView.clipsToBounds = YES;
    self.title = @"NewPan";
}

- (IBAction)push:(id)sender {
    JPFourthVc *four = [JPFourthVc new];
    [self.navigationController pushViewController:four animated:YES];
}

@end
