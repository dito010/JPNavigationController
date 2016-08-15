//
//  JPFourthViewController.m
//  JPNavigationController
//
//  Created by Chris on 16/8/15.
//  Copyright © 2016年 Chris. All rights reserved.
//

#import "JPFourthViewController.h"

@interface JPFourthViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *avatarImageView;

@end

@implementation JPFourthViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.avatarImageView.layer.cornerRadius = self.avatarImageView.bounds.size.width * 0.5;
    self.avatarImageView.clipsToBounds = YES;
}

- (IBAction)push:(id)sender {
    JPFourthViewController *four = [JPFourthViewController new];
    [self.navigationController pushViewController:four animated:YES];
}


@end
