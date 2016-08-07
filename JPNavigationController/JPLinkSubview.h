//
//  JPLinkSubview.h
//  JPNavigationController
//
//  Created by lava on 16/8/5.
//  Copyright © 2016年 Chris. All rights reserved.
//

#import <UIKit/UIKit.h>

@class JPLinkSubview;

@protocol JPLinkSubviewDelegate <NSObject>

@optional

-(void)linkSubview:(JPLinkSubview *)linkSubview didClickBuy:(UIButton *)sender;

-(void)linkSubview:(JPLinkSubview *)linkSubview didClickClosePop:(UIButton *)sender;

@end


@interface JPLinkSubview : UIView

/** delegate */
@property(nonatomic, weak)id<JPLinkSubviewDelegate> jp_delegate;

+(instancetype)viewForXib;

@end
