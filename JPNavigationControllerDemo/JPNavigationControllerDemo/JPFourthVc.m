//
//  JPFourthVc.m
//  JPNavigationControllerDemo
//
//  Hello! I am NewPan from Guangzhou of China, Glad you could use my framework, If you have any question or wanna to contact me, please open https://github.com/Chris-Pan or http://www.jianshu.com/users/e2f2d779c022/latest_articles
//

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
