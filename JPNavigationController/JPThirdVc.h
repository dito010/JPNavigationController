//
//  JPThirdVc.h
//  JPNavigationController
//
//  Created by Chris on 16/7/20.
//  Copyright © 2016年 Chris. All rights reserved.
//

#import <UIKit/UIKit.h>

@class JPSecondVC;

@interface JPThirdVc : UIViewController

/** 上一个控制器 */
@property(nonatomic, weak)JPSecondVC *second;

@end
