//
//  JPSecondVC.m
//  JPNavigationController
//
//  Created by Chris on 16/7/20.
//  Copyright © 2016年 Chris. All rights reserved.
//

#import "JPSecondVC.h"
#import "JPThirdVc.h"

@implementation JPSecondVC
-(void)viewDidLoad{
    [super viewDidLoad];
    
    NSLog(@"加载了第二个控制器");
    
    self.view.backgroundColor = [UIColor redColor];
    
    UIButton *btn = [[UIButton alloc]init];
    [btn setTitle:@"跳转" forState:UIControlStateNormal];
    
    [btn sizeToFit];
    btn.center = self.view.center;
    [self.view addSubview:btn];
    
    [btn addTarget:self action:@selector(click) forControlEvents:UIControlEventTouchUpInside];
}

-(void)click{
    JPThirdVc *vc = [[JPThirdVc alloc]init];
    
    [self.navigationController pushViewController:vc animated:YES];
}
@end
