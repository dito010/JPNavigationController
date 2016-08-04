//
//  JPThirdVc.m
//  JPNavigationController
//
//  Created by Chris on 16/7/20.
//  Copyright © 2016年 Chris. All rights reserved.
//

#import "JPThirdVc.h"
#import "UIImage+Image.h"

@implementation JPThirdVc
-(void)viewDidLoad{
    [super viewDidLoad];
    
    NSLog(@"加载了第二个控制器");
    
    self.view.backgroundColor = [UIColor whiteColor];
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageWithColor:[UIColor orangeColor]] forBarMetrics:UIBarMetricsDefault];
}
@end
