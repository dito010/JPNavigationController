//
//  JPThirdVc.m
//  JPNavigationController
//
//  Created by Chris on 16/7/20.
//  Copyright © 2016年 Chris. All rights reserved.
//

#import "JPThirdVc.h"
#import "UIImage+Image.h"
#import "JPNavigationController/JPNavigationControllerKit.h"
#import "JPSecondVC.h"

@interface JPThirdVc()
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *popZoneCons;

@end

const CGFloat thi_linkSubviewH = 44;
#define JPScreenH [UIScreen mainScreen].bounds.size.height
#define JPScreenW [UIScreen mainScreen].bounds.size.width
@implementation JPThirdVc
-(void)viewDidLoad{
    [super viewDidLoad];
    
    NSLog(@"加载了第二个控制器");
    
    self.view.backgroundColor = [UIColor whiteColor];
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageWithColor:[UIColor orangeColor]] forBarMetrics:UIBarMetricsDefault];
    
    UIButton *signBtn = [UIButton new];
    signBtn.frame = CGRectMake(0, 0, JPScreenW, thi_linkSubviewH);
    [signBtn setBackgroundColor:[UIColor colorWithRed:128 / 255.0f green:92 / 255.0f blue:248 / 255.0f alpha:1.0f]];
    [signBtn setTitle:@"pop手势范围设置为160" forState:UIControlStateNormal];
    [signBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [signBtn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateHighlighted];
    [signBtn addTarget:self action:@selector(signBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.navigationController.jp_linkContainerView addSubview:signBtn];
}

// 设置pop手势范围
-(void)signBtnClick:(UIButton *)btn{
    
    NSString *title = btn.titleLabel.text;
    if ([title isEqualToString:@"pop手势范围设置为160"]) {
        self.navigationController.jp_interactivePopMaxAllowedInitialDistanceToLeftEdge = 160.0f;
        [btn setTitle:@"pop手势范围设置为全屏" forState:UIControlStateNormal];
        
        self.popZoneCons.constant = 160.0f;
        [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
            [self.view layoutIfNeeded];
        } completion:nil];
    }
    else if ([title isEqualToString:@"pop手势范围设置为全屏"]){
        self.navigationController.jp_interactivePopMaxAllowedInitialDistanceToLeftEdge = [UIScreen mainScreen].bounds.size.width;
        [btn setTitle:@"pop手势范围设置为160" forState:UIControlStateNormal];
        
        self.popZoneCons.constant = [UIScreen mainScreen].bounds.size.width;
        [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
            [self.view layoutIfNeeded];
        } completion:nil];
    }
    
    NSLog(@"点击了%@", title);
}

- (IBAction)popto:(id)sender {
    [self.navigationController popToViewController:self.second animated:YES];
}

@end
